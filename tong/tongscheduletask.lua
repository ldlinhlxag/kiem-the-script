-------------------------------------------------------------------
--File: tongscheduletask.lua
--Author: lbh
--Date: 2007-9-21 9:21
--Describe: ���ʱ������
-------------------------------------------------------------------
if not Tong then --������Ҫ
	Tong = {}
	print(GetLocalDate("%Y\\%m\\%d  %H:%M:%S").." build ok ..")
end

if MODULE_GC_SERVER then
---------------------------GC_SERVER_START----------------------

function Tong:PerTongDailyAction_Timer()
	local cTong = self.PerTongDaily_cNextTong
	if not cTong then
		return 0	--Timer����
	end
	local nTongId = self.PerTongDaily_nNextTong
	if cTong.GetTestState() ~= 0 then
		if cTong.GetBuildFund() >= self.TEST_PASS_BUILD_FUND then
			cTong.SetTestState(0)
			KTong.Msg2Tong(nTongId, "��ϲ�������˳��ͨ�������ڣ�")
		else
			local nLeftTime;
			local nCreateTime = cTong.GetCreateTime();
			if nCreateTime < os.time({year=2008, month=6, day=17}) then		-- 6��17�� ǰ�������ĸ�14��Ŀ�����
				nLeftTime= self.TONG_TEST_TIME * 2 - GetTime() + nCreateTime;
			else
				nLeftTime= self.TONG_TEST_TIME - GetTime() + nCreateTime;
			end
			if nLeftTime < 0 then
				KTong.Msg2Tong(nTongId, "����ڿ������ڽ������δ�ﵽ"..self.TEST_PASS_BUILD_FUND.."������ɢ��")
				Tong:DisbandTong_GC(nTongId);
				cTong = nil;	-- ����ʧЧ������nilֵ
			else
				KTong.Msg2Tong(nTongId, "����뿼���ڽ�������<color=red>"..math.ceil(nLeftTime / 24 / 3600)..
				"<color>�죬�����ڿ�������ʹ�������ﵽ"..self.TEST_PASS_BUILD_FUND.."�������Ὣ��ɢ��")
			end
		end
	end
	if cTong then
		if Tong:MasterVoteDeadLine(nTongId) == 1 then
			Tong:StopMasterVote_GC(nTongId);
		end
		
		local pKinItor = cTong.GetKinItor();
		local nKinId = pKinItor.GetCurKinId();
		local nTotalRepute = 0;
		while nKinId ~= 0 do
			local pKin = KKin.GetKin(nKinId);
			if pKin then
				nTotalRepute = nTotalRepute + pKin.GetTotalRepute();
			end
			nKinId = pKinItor.NextKinId();
		end
		cTong.SetTotalRepute(nTotalRepute);
		GlobalExcute{"Tong:SyncTongTotalRepute_GS2", nTongId, nTotalRepute, self.nJourNum};
		
		if self:CheckAndSpiltStock(nTongId) ~= 1 then
			self:SyncTotalStock(nTongId);
		end
	end
	--if cTong then
		--local nKinCount, nMemberCount = cTong.GetMemberCount();
		--KStatLog.ModifyMax("Tong", cTong.GetName(), "������", nKinCount);		-- ��¼������
		--KStatLog.ModifyMax("Tong", cTong.GetName(), "�������", nMemberCount);	-- ��¼��Ա��
	--end
	self.PerTongDaily_cNextTong, self.PerTongDaily_nNextTong = KTong.GetNextTong(self.PerTongDaily_nNextTong)
	if not self.PerTongDaily_cNextTong then
		self.PerTongDaily_nNextTong = nil
		return 0
	end
	return 1	--1֡����ִ��
end

function Tong:PerTongWeeklyAction_Timer()
	local cTong = self.PerTongWeekly_cNextTong
	if not cTong then
		return 0	--Timer����
	end
	local nTongId = self.PerTongWeekly_nNextTong
		
	--�ж���ˢ��
	self:RefleshTongEnergy(nTongId)
	--��Ӣ�����
	self:ExcellentConfirm(nTongId)
	GlobalExcute{"Tong:ExcellentConfirm", nTongId}
	
	--���ֺܷ���Ч
	self:DealTakeStock(nTongId)

	-- Ϊ��������Ŀ��
	self:PerTongWeeklyAction_GC(self.PerTongWeekly_cNextTong, self.PerTongWeekly_nNextTong);
	
	--��һ�����
	self.PerTongWeekly_cNextTong, self.PerTongWeekly_nNextTong = KTong.GetNextTong(self.PerTongWeekly_nNextTong)
	if not self.PerTongWeekly_cNextTong then
		self.PerTongWeekly_nNextTong = nil
		self.bIsTongWeeklyActionOver = 1;
		if (Kin.bIsKinWeeklyActionOver and 1 == Kin.bIsKinWeeklyActionOver) then
			Kin:RecordWeeklyActionNo();	-- ��¼��ˮ��
			Kin:LogWeeklyTaskLevel();	-- �ڼ���Ͱ�ᶼά�����֮�����Ŀ���logд�����ݿ�
			self.bIsTongWeeklyActionOver = 0;
			Kin.bIsKinWeeklyActionOver = 0;
		end
		return 0
	end
	return 1	--1֡����ִ��
end


function Tong:DailyPresidentConfirm_Timer()
	local cTong = self.PerTongPresident_cNextTong;
	if not cTong then
		return 0;	--Timer����
	end
	local nTongId = self.PerTongPresident_nNextTong;
	local nKinId = cTong.GetPresidentKin();			-- �������
	local nMemberId = cTong.GetPresidentMember();	-- �����Ա
	local pKin = KKin.GetKin(nKinId);
	local bConfirm = 0;
	if not pKin or pKin.GetBelongTong() ~= nTongId then
		bConfirm = 1;
	elseif pKin then
		local pMember = pKin.GetMember(nMemberId);
		if not pMember then
			bConfirm = 1;
		end
	end
	if tonumber(os.date("%w", GetTime())) == self.PRESDIENT_CONFIRM_WDATA then		-- ��Ҫѡһ������,ͬʱ��������
		self:PresidentConfirm_GC(nTongId, 1)			
	elseif bConfirm == 1 then							-- �����뿪�����~��Ҫѡһ������~����������
		self:PresidentConfirm_GC(nTongId)
	elseif tonumber(os.date("%w", GetTime())) == 5 then
		self:PresidentCandidateConfirm_GC(nTongId)
	end
	--��һ�����
	self.PerTongPresident_cNextTong, self.PerTongPresident_nNextTong = KTong.GetNextTong(nTongId);
	if not self.PerTongPresident_cNextTong then
		self.PerTongPresident_cNextTong = nil
		self.PerTongPresident_nNextTong = 0
		return 0
	end
	return 1;
end

function Tong:PerTongVoteStat_Timer()
	_DbgOut("PerTongVoteStat_Timer")
	if not self.MasterVote_anVoteStatTongId then
		return 0
	end
	-- ȡ��һ��Tong
	local nTongId = table.remove(self.MasterVote_anVoteStatTongId)
	-- ��Ϊ��
	if not nTongId then
		self.MasterVote_anVoteStatTongId = nil
		return 0
	end
	self:StopMasterVote_GC(nTongId);
	return 1
end


--����ճ�����
function Tong:PerTongDailyStart()
	_DbgOut("PerTongDailyStart")
	self.PerTongDaily_cNextTong, self.PerTongDaily_nNextTong = KTong.GetFirstTong()
	if not self.PerTongDaily_cNextTong then
		_DbgOut("no tong");
		return 0
	end
	Timer:Register(1, self.PerTongDailyAction_Timer, self)
	return 0
end


function Tong:PerTongWeeklyStart()
	_DbgOut("PerWeeklyStart")
	local nWeek = tonumber(GetLocalDate("%W"))
	--���������������������
	if KGblTask.SCGetDbTaskInt(DBTASK_TONG_WEEKLY) == nWeek then
		return 0
	end
	self.PerTongWeekly_cNextTong, self.PerTongWeekly_nNextTong = KTong.GetFirstTong()
	if not self.PerTongWeekly_cNextTong then
		self.bIsTongWeeklyActionOver = 1;
		if (Kin.bIsKinWeeklyActionOver and 1 == Kin.bIsKinWeeklyActionOver) then
			Kin:RecordWeeklyActionNo();	-- ��¼��ˮ��
			Kin:LogWeeklyTaskLevel();	-- �ڼ���Ͱ�ᶼά�����֮�����Ŀ���logд�����ݿ�
			self.bIsTongWeeklyActionOver = 0;
			Kin.bIsKinWeeklyActionOver = 0;
		end
		_DbgOut("no tong")
		return 0
	end
	Timer:Register(1, self.PerTongWeeklyAction_Timer, self)
	--��¼������ִ��
	KGblTask.SCSetDbTaskInt(DBTASK_TONG_WEEKLY, nWeek)	
	return 0
end

-- ������촦��
function Tong:DailyPresidentConfirm()
	_DbgOut("DailyPresidentConfirm");
	if tonumber(os.date("%w", GetTime())) == self.PRESDIENT_CONFIRM_WDATA then				-- ��һ��Ҫά������
		local nOfficialMainTainNo = KGblTask.SCGetDbTaskInt(DBTASK_OFFICIAL_MAINTAIN_NO);
		KGblTask.SCSetDbTaskInt(DBTASK_OFFICIAL_MAINTAIN_NO, nOfficialMainTainNo + 1);
	end
	self.PerTongPresident_cNextTong, self.PerTongPresident_nNextTong = KTong.GetFirstTong()
	if not self.PerTongPresident_cNextTong then
		_DbgOut("no tong");
		return 0
	end
	Timer:Register(1, self.DailyPresidentConfirm_Timer, self)
	return 0
end

-- ��ʼ����
function Tong:StartGreatMemberVote()
	self.StartGreatMemberVote_pNextTong, self.StartGreatMemberVote_nNextTongId = KTong.GetFirstTong()
	if not self.StartGreatMemberVote_pNextTong then
		_DbgOut("no tong");
		return 0;
	end
	if tonumber(os.date("%w", GetTime())) == self.GREAT_MEMBER_VOTE_START_DAY then				-- ���忪ʼ
		local nCurNo = KGblTask.SCGetDbTaskInt(DBTASK_GREAT_MEMBER_VOTE_NO) + 1
		KGblTask.SCSetDbTaskInt(DBTASK_GREAT_MEMBER_VOTE_NO, nCurNo);
		Timer:Register(1, self.StartGreatMemberVote_Timer, self);
		return 0;
	end
end

-- ÿ����Ὺʼ����
function Tong:StartGreatMemberVote_Timer()
	local pTong = self.StartGreatMemberVote_pNextTong;
	if not pTong then
		return 0;	--Timer����
	end
	local nTongId = self.StartGreatMemberVote_nNextTongId;
	
	Tong:StartGreatMemberVote_GC(nTongId);
		
	self.StartGreatMemberVote_pNextTong, self.StartGreatMemberVote_nNextTongId = KTong.GetNextTong(self.StartGreatMemberVote_nNextTongId)
	if not self.StartGreatMemberVote_pNextTong then
		self.StartGreatMemberVote_nNextTongId = nil;
		return 0;
	end
	return 1;	--1֡����ִ��
end

-- ��������
function Tong:EndGreatMemberVote()
	self.EndGreatMemberVote_pNextTong, self.EndGreatMemberVote_nNextTongId = KTong.GetFirstTong()
	if not self.EndGreatMemberVote_pNextTong then
		_DbgOut("no tong");
		return 0;
	end
	if tonumber(os.date("%w", GetTime())) == self.GREAT_MEMBER_VOTE_END_DAY then				-- ���տ�ʼ
		Timer:Register(1, self.EndGreatMemberVote_Timer, self);
		return 0;
	end
end

-- ÿ������������
function Tong:EndGreatMemberVote_Timer()
	local pTong = self.EndGreatMemberVote_pNextTong;
	if not pTong then
		return 0;	--Timer����
	end
	local nTongId = self.EndGreatMemberVote_nNextTongId;
	
	Tong:EndGreatMemberVote_GC(nTongId);
		
	self.EndGreatMemberVote_pNextTong, self.EndGreatMemberVote_nNextTongId = KTong.GetNextTong(self.EndGreatMemberVote_nNextTongId)
	if not self.EndGreatMemberVote_pNextTong then
		self.EndGreatMemberVote_nNextTongId = nil;
		return 0;
	end
	return 1;	--1֡����ִ��
end



----------------------GC_SERVER_END------------------------------
end

if MODULE_GAMESERVER then
----------------------GAME_SERVER_START---------------------------

---------------------GAME_SERVER_END------------------------------
end
