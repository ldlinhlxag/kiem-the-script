-------------------------------------------------------------------
--File: kinscheduletask.lua
--Author: lbh
--Date: 2007-7-11 11:26
--Describe: ����ʱ������
-------------------------------------------------------------------
if not Kin then --������Ҫ
	Kin = {}
	print(GetLocalDate("%Y/%m/%d/%H/%M/%S").." build ok ..")
end

if MODULE_GC_SERVER then
---------------------------GC_SERVER_START----------------------

--һ�����ļ�����Աת��
function Kin:PerMemberDailyAction(cKin, nKinId)
	local itor = cKin.GetMemberItor()
	local cMember = itor.GetCurMember()
	--��ȡ�����0��ʱ�䣨��������Ϊ18:00ִ�У�������Ҫ������ʽ��
	local nTodayBeginTime = GetTime();
	--����48Сʱ����ת��
	local nMinTime = nTodayBeginTime - self.CHANGE_REGULAR_TIME;
	local nTotalRepute = 0;
	local nTotalDec = 0
	local cTmpMember = cMember;
	local nMemberId;
	while cMember do
		--������Աת��
		nMemberId = itor.GetCurMemberId();
		cTmpMember = itor.NextMember();
		if (cMember.GetFigure() == self.FIGURE_SIGNED) then
			if (cMember.GetJoinTime() < nMinTime) then
				cMember.SetCan2Regular(1);
				GlobalExcute{"Kin:SetCan2Regular_GS2", nKinId, nMemberId};
			end
		end
		-- �������������
		local nPlayerId = cMember.GetPlayerId();
		local nMemberRepute = KGCPlayer.GetPlayerPrestige(nPlayerId);
		nTotalRepute = nTotalRepute + nMemberRepute;
		--�ж��Ƿ��˳���Ч��������18:00ִ�У�����������ģ�
		local nLeaveInitTime = cMember.GetLeaveInitTime()
		if nLeaveInitTime > 0 and nTodayBeginTime - nLeaveInitTime > self.MEMBER_LEAVE_TIME then
			local nFigure = cMember.GetFigure()
			-- �峤����ֱ��ɾ��
			if nFigure == self.FIGURE_CAPTAIN then
				cMember.SetLeaveInitTime(0);
			else
				self:MemberDel_GC(nKinId, nMemberId, 0);
			end
		end
		cMember = cTmpMember; 
	end
	--����������
	if nTotalRepute < 0 then
		nTotalRepute = 0
	end
	cKin.SetTotalRepute(nTotalRepute)
	self.nJourNum = self.nJourNum + 1
	cKin.SetKinDataVer(self.nJourNum)
	--KStatLog.ModifyMax("Kin", cKin.GetName(), "����", cKin.nMemberCount);
	local nApplyTime = cKin.GetApplyQuitTime();
	if nApplyTime ~= 0 and GetTime() - nApplyTime >= self.QUIT_TONG_TIME then
		if self:CheckQuitTong(cKin) == 1 then
			local nTongId = cKin.GetBelongTong();
			Tong:KinDel_GC(nTongId, nKinId, 0); -- ͨ������˳��ɹ�
		else
			Kin:FailedQuitTong_GC(nKinId, 0);			-- ʧ��
		end
	end
	-- �峤���⣬������ѡ
	if cKin.GetCaptainLockState() == 1 then
		Kin:StartCaptainVote_GC(nKinId);
	end
	GlobalExcute{"Kin:PerMemberDailyAction_GS", nKinId, self.nJourNum, nMinTime, nTotalRepute}
end

Kin.aSecTotalRepute = { 0, 0, 0, 0 };
function Kin:PerMemberWeeklyAction(cKin, nKinId)
	if not cKin then
		return 0;
	end
	print(cKin.GetName(), "WeeklyAction");
	Kin:PerKinWeeklyTask_GC(self.PerKinWeekly_cNextKin, self.PerKinWeekly_nNextKin);	-- Ϊ���������Ŀ��
	local nRepute = cKin.GetTotalRepute();
	if nRepute >= 4000 then
		Kin:AddGuYinBi_GC(nKinId, 200);
		-- self.aSecTotalRepute[4] = self.aSecTotalRepute[4] + 1;		
	elseif nRepute >= 2000 then
		Kin:AddGuYinBi_GC(nKinId, 150);
		-- self.aSecTotalRepute[3] = self.aSecTotalRepute[3] + 1;
	elseif nRepute >= 1000 then
		Kin:AddGuYinBi_GC(nKinId, 100);
		-- self.aSecTotalRepute[2] = self.aSecTotalRepute[2] + 1;	
	else
		-- self.aSecTotalRepute[1] = self.aSecTotalRepute[1] + 1;		
	end
end

function Kin:PerKinDailyAction_Timer()
	self:PerMemberDailyAction(self.PerKinDaily_cNextKin, self.PerKinDaily_nNextKin)
	self.PerKinDaily_cNextKin, self.PerKinDaily_nNextKin = KKin.GetNextKin(self.PerKinDaily_nNextKin)
	
	-- ÿ�����������ļ��
	Kin:KinRecruitmenClean(self.PerKinDaily_nNextKin);
	
	if not self.PerKinDaily_cNextKin then
		self.PerKinDaily_cNextKin = nil
		self.PerKinDaily_nNextKin = nil
		return 0	--Timer����
	end
	return 1	--1֡����ִ��
end

function Kin:PerKinWeeklyAction_Timer()
	Kin:CleanKinRecruitmenPublish(self.PerKinWeekly_nNextKin);

	self:PerMemberWeeklyAction(self.PerKinWeekly_cNextKin, self.PerKinWeekly_nNextKin);
	self.PerKinWeekly_cNextKin, self.PerKinWeekly_nNextKin = KKin.GetNextKin(self.PerKinWeekly_nNextKin)
	
	if not self.PerKinWeekly_cNextKin then
		self.PerKinWeekly_cNextKin = nil;
		self.PerKinWeekly_nNextKin = nil;
		self.bIsKinWeeklyActionOver = 1;
		if (Tong.bIsTongWeeklyActionOver and 1 == Tong.bIsTongWeeklyActionOver) then
			self:RecordWeeklyActionNo();	-- ��¼��ˮ��
			self:LogWeeklyTaskLevel();	-- �ڼ���Ͱ�ᶼά�����֮�����Ŀ���logд�����ݿ�
			self.bIsKinWeeklyActionOver = 0;
			Tong.bIsTongWeeklyActionOver = 0;
		end
		-- KStatLog.ModifyField("mixstat", "����0������", "����", self.aSecTotalRepute[1]);
		-- KStatLog.ModifyField("mixstat", "����1000������", "����", self.aSecTotalRepute[2]);
		-- KStatLog.ModifyField("mixstat", "����2000������", "����", self.aSecTotalRepute[3]);
		-- KStatLog.ModifyField("mixstat", "����4000������", "����", self.aSecTotalRepute[4]);
		return 0	--Timer����
	end
	return 1	--1֡����ִ��
end

function Kin:CaptainVoteStart()
	local nMonth = tonumber(GetLocalDate("%m"))
	--�����������������ѡ��������
	if KGblTask.SCGetDbTaskInt(DBTASK_KIN_VOTE) == nMonth then
		return 0
	end
	local itor = KKin.GetKinItor()
	if not itor then
		return 0
	end
	local nKinId = itor.GetCurKinId()
	while nKinId > 0 do
		Kin:StartCaptainVote_GC(nKinId);
		nKinId = itor.NextKinId()
	end
	--��¼�����峤��ѡ������
	KGblTask.SCSetDbTaskInt(DBTASK_KIN_VOTE, nMonth);
	return 1;
end

function Kin:CaptainVoteStop()
	local itor = KKin.GetKinItor()
	if not itor then
		return 0
	end
	local cKin = itor.GetCurKin()
	local nCurTime = GetTime()
	--��ʱ�����¼��ѡ����Ҫͳ��Ʊ���ļ���Id
	self.CaptainVote_anVoteStatKinId = {}
	while cKin do
		local nVoteTime = cKin.GetVoteStartTime()
		--24 * 4 * 3600 = 345600
		--ͶƱ�ڵ���������
		if nVoteTime > 0 and nCurTime - nVoteTime > 24 * 4 * 3600 then
			table.insert(self.CaptainVote_anVoteStatKinId, itor.GetCurKinId())
		end
		cKin = itor.NextKin()
	end
	--����ͳ��Ʊ����ʱ������ÿ�������ͳ�ƾ���ִ֡�У������Ч�ʣ�
	Timer:Register(1, self.PerKinVoteStat_Timer, self)
	return 1
end

function Kin:PerKinVoteStat_Timer()
	if not self.CaptainVote_anVoteStatKinId then
		return 0
	end
	--ȡ��һ��Kin
	local nKinId = table.remove(self.CaptainVote_anVoteStatKinId)
	--��Ϊ��
	if not nKinId then
		self.CaptainVote_anVoteStatKinId = nil
		return 0
	end
	self:StopCaptainVote_GC(nKinId)
	return 1
end

--�����ճ�����
function Kin:PerKinDailyStart()
	self.PerKinDaily_cNextKin, self.PerKinDaily_nNextKin = KKin.GetFirstKin()
	if not self.PerKinDaily_cNextKin then
		return 0
	end
	Timer:Register(1, self.PerKinDailyAction_Timer, self)
	return 0
end

-- �����ܴ���
function Kin:PerKinWeeklyStart()
	self.aSecTotalRepute = { 0, 0, 0, 0 };
	local nWeek = tonumber(GetLocalDate("%W"))
	--���������������������
	if KGblTask.SCGetDbTaskInt(DBTASK_KIN_WEEKLY) == nWeek then
		return 0
	end
	self.PerKinWeekly_cNextKin, self.PerKinWeekly_nNextKin = KKin.GetFirstKin()
	if not self.PerKinWeekly_cNextKin then
		self.bIsKinWeeklyActionOver = 1;
		if (Tong.bIsTongWeeklyActionOver and 1 == Tong.bIsTongWeeklyActionOver) then
			self:RecordWeeklyActionNo();	-- ��¼��ˮ��
			self:LogWeeklyTaskLevel();	-- �ڼ���Ͱ�ᶼά�����֮�����Ŀ���logд�����ݿ�
			self.bIsKinWeeklyActionOver = 0;
			Tong.bIsTongWeeklyActionOver = 0;
		end
		return 0
	end
	Timer:Register(1, self.PerKinWeeklyAction_Timer, self)
	KGblTask.SCSetDbTaskInt(DBTASK_KIN_WEEKLY, nWeek)
	return 0
end
----------------------GC_SERVER_END------------------------------
end

if MODULE_GAMESERVER then
----------------------GAME_SERVER_START---------------------------

function Kin:PerMemberDailyAction_GS(nKinId, nDataVer, nMinTime, nTotalRepute)
	local cKin = KKin.GetKin(nKinId)
	if not cKin then
		return
	end
	cKin.SetTotalRepute(nTotalRepute)
	cKin.SetKinDataVer(nDataVer)
end
---------------------GAME_SERVER_END--------------------------------
end
