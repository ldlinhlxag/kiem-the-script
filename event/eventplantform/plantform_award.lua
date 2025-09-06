--ƽ̨�����
--�����
--2008.09.23

--��������������1Ϊ��ʤ��2Ϊƽ��3Ϊ��, 4Ϊ�ֿջ�ʤ
function EPlatForm:MacthAward(szLeagueName, szMatchLeagueName, tbMisPlayerList, nResult)
	local tbMsg = 
	{
		[1] = {string.format("<color=yellow>����ս���ڱ�����սʤ�˶��֣���ϲ�����ʤ����<color>")},
		[2] = {string.format("<color=green>����ս���ڱ�����սƽ�˶��֣��´μ���Ŭ���ɡ�<color>")},
		[3] = {string.format("<color=blue>����ս���ڱ����аܸ��˶��֣��´μ���Ŭ���ɡ�<color>")},
		[4] = {string.format("<color=yellow>����ս������α������ֿ��ˣ�����Ļ����ʤ����<color>")}
	}
	local nLeagueTotal 	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TOTAL);
	local nLeagueWin 	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_WIN);
	local nLeagueTie 	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TIE);
--	local nGameLevel 	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_MLEVEL);
	local nSession 		= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_MSESSION);	
	local nReadyId		= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_ATTEND);

	local tbPlayerList = {};
	local tbPlayerObjList = {};


	local nState			= EPlatForm:GetMacthState();
	local nRankSession		= EPlatForm:GetMacthSession();
	local nMacthType		= EPlatForm:GetMacthType();
	local tbMacth			= EPlatForm:GetMacthTypeCfg(nMacthType);
	local szMatchName	= "���徺��";
	if (tbMacth) then
		szMatchName	= 	tbMacth.szName;
	end

	local tbMemberList = EPlatForm:GetLeagueMemberList(szLeagueName) or {};
	for _, szName in pairs(tbMemberList) do
		local pPlayer = KPlayer.GetPlayerByName(szName);
		if pPlayer then
			pPlayer.Msg(tbMsg[nResult][1]);
			Dialog:SendBlackBoardMsg(pPlayer, tbMsg[nResult][1])
			--����
			pPlayer.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_TOTLE, pPlayer.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_TOTLE) + 1);
			pPlayer.SetTask(EPlatForm.TASKID_GROUP, EPlatForm.TASKID_HELP_TOTLE, nLeagueTotal + 1);
			local szFriendMsg	= "";
			local szMyMsg	= "";
			if nResult == 1 or nResult == 4 then
				pPlayer.SetTask(EPlatForm.TASKID_GROUP, EPlatForm.TASKID_MATCH_WIN, pPlayer.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_WIN) + 1);
				pPlayer.SetTask(EPlatForm.TASKID_GROUP, EPlatForm.TASKID_HELP_WIN, nLeagueWin + 1);
				pPlayer.SendMsgToFriend(string.format("���ĺ���[%s]����ս���ڸոս�����%s���ȡ����ʤ����", pPlayer.szName, szMatchName));
			end
			
			if (nState ~= self.DEF_STATE_ADVMATCH) then
				local nAwardFlag = self:SetAwardFlagParam(0, nRankSession, nState, nResult);
				self:SetAwardParam(pPlayer, nAwardFlag);			
			end

			-- ͳ����Ҳμ����������ĳ���
			-- Stats.Activity:AddCount(pPlayer, Stats.TASK_COUNT_WLLS, 1);
		else
			--������,�´������Զ�����.
			if (nState ~= self.DEF_STATE_ADVMATCH) then
				League:SetMemberTask(self.LGTYPE, szLeagueName, szName, self.LGMTASK_AWARD, nResult);
			end
		end
		EPlatForm:WriteLog(string.format("������Ա:%s��%s Vs %s�����:%s", szName, szLeagueName, (szMatchLeagueName or ""), nResult))
	end
	
	local szKinName = self:GetKinNameFromLeagueName(szLeagueName);
	if nResult == 1 or nResult == 4 then
		local szKinMsg = string.format("%sս�ӻ����%s���ʤ����", szLeagueName, szMatchName);
		local nKinId = KKin.GetKinNameId(szKinName);
		if (nKinId > 0) then
			KKin.Msg2Kin(nKinId, szKinMsg);
		end
	end
	
	if EPlatForm:GetMacthState() == EPlatForm.DEF_STATE_ADVMATCH then
		local nRank   = League:GetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK);
		local nVsRank = 0;
		if szMatchLeagueName then
			nVsRank = League:GetLeagueTask(EPlatForm.LGTYPE, szMatchLeagueName, EPlatForm.LGTASK_RANK);
		end
		if EPlatForm.MACTH_STATE_ADV_TASK[EPlatForm.AdvMatchState] == 8 then
			if nResult == 1 or nResult == 4 or (nResult == 2 and nRank < nVsRank) then
				local nSeries = EPlatForm:GetAdvMatchSeries(nRank, 8);
				EPlatForm.AdvMatchLists[nReadyId][4][nSeries] = EPlatForm.AdvMatchLists[nReadyId][8][nRank];
				League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK_ADV, 4);
				self:SetKinAwardFlag(szKinName, nRankSession, 4);
			end
			
			if (nResult == 3 or (nResult == 2 and nRank >= nVsRank) ) then
				EPlatForm:SendAdvMatchResultMsg(szLeagueName, 4);
				League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK_ADV, 8);
			end
		elseif EPlatForm.MACTH_STATE_ADV_TASK[EPlatForm.AdvMatchState] == 4 then
			if nResult == 1 or nResult == 4  or (nResult == 2 and nRank < nVsRank) then
				local nSeries = EPlatForm:GetAdvMatchSeries(nRank, 4);
				EPlatForm.AdvMatchLists[nReadyId][2][nSeries] = EPlatForm.AdvMatchLists[nReadyId][8][nRank];
				League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK_ADV, 2);
				self:SetKinAwardFlag(szKinName, nRankSession, 2);			
			end
			if (nResult == 3 or (nResult == 2 and nRank >= nVsRank) ) then
				EPlatForm:SendAdvMatchResultMsg(szLeagueName, 3);
				League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK_ADV, 4);
			end
		elseif EPlatForm.MACTH_STATE_ADV_TASK[EPlatForm.AdvMatchState] == 2 then
			local nSeries = EPlatForm:GetAdvMatchSeries(nRank, 2);
			EPlatForm.AdvMatchLists[nReadyId][2][nSeries].tbResult[EPlatForm.AdvMatchState - 2] = nResult;
		end
	else
		if nResult == 1 or nResult == 4 then
			League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_WIN, nLeagueWin + 1 );
			EPlatForm:WriteLog(string.format("ʤ������ʤ������:%s", szLeagueName));
		elseif nResult == 2 then
			League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TIE, nLeagueTie + 1);
		end
		League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TOTAL, nLeagueTotal + 1);
	end
	League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_ENTER, 0);
end

--�����ȡ����ʤ������
function EPlatForm:OnCheckAwardSingle(pPlayer)
	if pPlayer.GetTask(EPlatForm.TASKID_GROUP, EPlatForm.TASKID_MATCH_WIN_AWARD) == 10 then
		return 1;
	end
	return 0;
end

--���ս������н���ʱ���ȵ�������ѡ��
function EPlatForm:OnCheckAward(pPlayer, nPart)
	local szLeagueName = League:GetMemberLeague(EPlatForm.LGTYPE, pPlayer.szName);
	if not szLeagueName then
		return 0, 0, "��û��ս�ӡ�";
	end
	
	-- �ж��ǲ��Ǳ���������ѡ��
	
	if EPlatForm:GetMacthState() ~= EPlatForm.DEF_STATE_REST or KGblTask.SCGetDbTaskInt(EPlatForm.GTASK_MACTH_RANK) < EPlatForm:GetMacthSession() then
		return 0, 0, string.format("�����ڻ�δ�������߱����������л�δ�����������ĵȴ���");		
	end
	
	if League:GetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_TOTAL) <= 0 then
		return 0, 0, string.format("����ս�ӻ�δ�μӹ����������½�ս�ӣ�������ȡ������");	
	end
	local nRank = League:GetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK);
	local nTotle = League:GetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_TOTAL);
	local nSession = League:GetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_MSESSION);
	local nAdvRank = League:GetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK_ADV);
	
	if pPlayer.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_FINISH) >= nSession then
		return 0, 0 , string.format("������ȡ�������ˡ�");
	end	
	
	
	if nRank == 1 and nAdvRank == 2 then
		nRank = 2;
	end	
	local nGameType = EPlatForm:GetMacthType(nSession)
	local nLevelSep, nMaxRank = EPlatForm:GetAwardLevelSep(nPart, nSession, nRank);
	if nLevelSep <= 0 then
		return 0, 0, string.format("����ս��û�н���������ȡ��");
	end
	if nMaxRank >= 10000 and nTotle < math.floor(nMaxRank/10000) then
		return 0, 0 , string.format("����ս���ڱ��������û�л���κν���,���½����Ŭ����");
	end
	return 1, nRank , string.format("��ȡ����");
end


--��ȡ���ս���
function EPlatForm:OnGetAward_Final(nPart, nFlag)
	local nCheck,nRank,szError = EPlatForm:OnCheckAward(me, nPart);
	if nCheck == 0 then
		Dialog:Say(szError);
		return 0;
	end
	local szLeagueName = League:GetMemberLeague(EPlatForm.LGTYPE, me.szName);
	local nSession = League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_MSESSION);
	local nGameType = EPlatForm:GetMacthType(nSession);
	local nLevelSep, nMaxRank = EPlatForm:GetAwardLevelSep(nPart, nSession, nRank);
	
	if not nFlag then
		local szMsg = string.format("����ս�����Ͻ���徺����л���˵�<color=yellow>%s<color>������ȡ�����������˳�ս�ӣ����ս��û��ʣ���Ա��ս�ӽ����ɢ��", nRank);
		local tbOpt = 
		{
			{"��ȷ����ȡ����",self.OnGetAward_Final, self, nPart, 1},
			{"���ٿ��ǿ���"},
		}
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	local nFree = EPlatForm.Fun:GetNeedFree(EPlatForm.AWARD_FINISH_LIST[nSession][nLevelSep]);
	if me.CountFreeBagCell() < nFree then
		Dialog:Say(string.format("���ı����ռ䲻��,������%s�񱳰��ռ�.", nFree));
		return 0;
	end
	
	if me.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_BEST) > nRank then
		me.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_BEST, nRank);
	end
	if me.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_BEST) == 0 then
		me.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_BEST, nRank);
	end
	
	me.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_FINISH, nSession);
	local nLogTaskFlag = nSession + nLevelSep * 1000 + nPart * 10000 ;
	me.SetTask(self.TASKID_GROUP, self.TASKID_AWARD_LOG, nLogTaskFlag);	
	
	--����
	EPlatForm.Fun:DoExcute(me, EPlatForm.AWARD_FINISH_LIST[nSession][nLevelSep]);

	GCExcute{"EPlatForm:LeaveLeague", me.szName, 1};
	Dialog:Say("���ɹ���ȡ�˽��������˳���ս�ӣ���ӭ�����μ��½���");
	EPlatForm:WriteLog(string.format("��������:%s", nRank), me.nId, me.szName)
end

function EPlatForm:GetPlayerAward_Final()
	self:OnGetAward_Final(EPlatForm.MATCH_TEAMMATCH);
	return 1;
end

function EPlatForm:GetKinAward(nFlag)
	local nResult, szMsg = self:OnCheckKinAward(me);
	if (nResult == 0) then
		Dialog:Say(szMsg);
		return 0;
	end
	
	szMsg = string.format("%s����ȷ��Ҫ��ȡ���影����", szMsg or "");
	
	Dialog:Say(szMsg, 
		{
			{"��ȷ��Ҫ��ȡ", self.OnApplyGetKinAward, self, 1},
			{"���ڿ��ǿ���"}	
		});
	return 1;
end

function EPlatForm:OnApplyGetKinAward()
	local nResult, szMsg = self:OnCheckKinAward(me);
	if (nResult == 0) then
		Dialog:Say(szMsg);
		return 0;
	end
	GCExcute{"EPlatForm:ApplyGetKinAward", me.nId};
end

function EPlatForm:OnGetKinAward(nPlayerId)
	if (not nPlayerId) then
		return 0;
	end
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return 0;
	end
	local nResult, szMsg = self:OnCheckKinAward(pPlayer);
	if (nResult == 0) then
		pPlayer.Msg(szMsg);
		return 0;
	end

	local dwKinId, nMemberId = KKin.GetPlayerKinMember(pPlayer.nId);
	if (dwKinId <= 0) then
		return 0;
	end
	
	local pKin = KKin.GetKin(dwKinId);
	if (not pKin) then
		return 0;
	end
	
	local pMember = pKin.GetMember(nMemberId);
	if (not pMember) then 
		return 0;
	end
	
	local szKinName = pKin.GetName();
	local nFigure = pMember.GetFigure();
	if (nFigure <= 0 or nFigure > 3) then
		return 0;
	end

	local nKinAwardType = pKin.GetPlatformKinAward() or 0;
	if (nKinAwardType <= 0) then
		return 0;
	end

	if (self:GetPlayerMonthScore(pPlayer.szName) < self.DEF_MIN_KINAWARD_SCORE) then
		return 0;
	end

	local nSession = math.floor(nKinAwardType / 10000);
	local nType = math.fmod(nKinAwardType, 10000);

	local nKinCount = pKin.GetPlatformAwardCount();
	if (nKinCount >= self.DEF_MAX_KINAWARDCOUNT) then
		return 0;
	end

	local nFlag = pPlayer.GetTask(self.TASKID_GROUP, self.TASKID_KINAWARDFLAG);
	local nMySession= math.floor(nFlag / 10000);
	local nMyType	= math.fmod(nFlag, 10000);

	if (nSession == nMySession) then
		return 0;
	end
	
	local tbResultName = {
			[1] = "�ھ�",
			[2] = "�Ǿ�",
			[4] = "4ǿ",
			[8] = "8ǿ", 
			[16] = "16ǿ",
			[32] = "32ǿ",
		};	
	local nLevel = self:GetAwardLevelSep(self.MATCH_KINAWARD, nSession, nType);
	
	if (nLevel <= 0) then
		self:WriteLog("GetKinAward", string.format("%s ������ȡʧ��", pPlayer.szName), nSession, nType);
		return 0;
	end
	
	if (not self.AWARD_KIN_LIST[nSession][nLevel]) then
		return 0;
	end
	
	local nFree = EPlatForm.Fun:GetNeedFree(self.AWARD_KIN_LIST[nSession][nLevel]);
	if pPlayer.CountFreeBagCell() < nFree then
		return 0;
	end
	
	EPlatForm.Fun:DoExcute(pPlayer, self.AWARD_KIN_LIST[nSession][nLevel]);
	nKinCount = nKinCount + 1;
	if (nKinCount > EPlatForm.DEF_MAX_KINAWARDCOUNT	) then
		nKinCount = EPlatForm.DEF_MAX_KINAWARDCOUNT;
	end

	pKin.SetPlatformAwardCount(nKinCount);
	pPlayer.SetTask(self.TASKID_GROUP, self.TASKID_KINAWARDFLAG, nKinAwardType);
	self:WriteLog("OnGetKinAward", string.format("GS Del Kin AwardCount 1, now Count %d", nKinCount), pPlayer.nId, pPlayer.szName, szKinName);
	self:WriteLog("OnGetKinAward", string.format("%s��һ�ȡ���影���ɹ�", pPlayer.szName), nSession, nLevel, nKinAwardType);
	return 1;	
end

function EPlatForm:OnCheckKinAward(pPlayer)
	if EPlatForm:GetMacthState() ~= EPlatForm.DEF_STATE_REST or KGblTask.SCGetDbTaskInt(EPlatForm.GTASK_MACTH_RANK) < EPlatForm:GetMacthSession() then
		return 0, string.format("�����ڻ�δ�������߱����������л�δ�����������ĵȴ���");		
	end		
	
	local dwKinId, nMemberId = KKin.GetPlayerKinMember(pPlayer.nId);
	if (dwKinId <= 0) then
		return 0, "��û�м����޷���ȡ���影��";
	end
	
	local pKin = KKin.GetKin(dwKinId);
	if (not pKin) then
		return 0, "��û�м����޷���ȡ���影��";
	end
	
	local pMember = pKin.GetMember(nMemberId);
	if (not pMember) then 
		return 0, "�㲻�Ǽ����Ա�޷���ȡ���影��";
	end
	
	local szKinName = pKin.GetName();
	local nFigure = pMember.GetFigure();
	if (nFigure <= 0 or nFigure > 3) then
		return 0, string.format("�㲻��<color=yellow>%s<color>�����<color=yellow>��ʽ��Ա<color>��������ȡ���影����", szKinName);
	end
	
	if (self:GetPlayerMonthScore(pPlayer.szName) < self.DEF_MIN_KINAWARD_SCORE) then
		return 0, string.format("����»����û�дﵽ%d�֣�������ȡ������", self.DEF_MIN_KINAWARD_SCORE);
	end

	local nKinAwardType = pKin.GetPlatformKinAward() or 0;
	if (nKinAwardType <= 0) then
		return 0, string.format("�����ڼ���û�н���������ȡ��");
	end
	local nSession = math.floor(nKinAwardType / 10000);
	local nType = math.fmod(nKinAwardType, 10000);


	local nFlag = pPlayer.GetTask(self.TASKID_GROUP, self.TASKID_KINAWARDFLAG);
	local nMySession= math.floor(nFlag / 10000);
	local nMyType	= math.fmod(nFlag, 10000);
	
	if (nSession == nMySession) then
		return 0, "���Ѿ���ȡ��������ļ��影����";
	end
	
	local nKinCount = pKin.GetPlatformAwardCount();
	if (nKinCount >= self.DEF_MAX_KINAWARDCOUNT) then
		return 0, string.format("%s���影�������Ѿ����꣬���޷���ȡ��", szKinName);
	end

	local nLevel = self:GetAwardLevelSep(self.MATCH_KINAWARD, nSession, nType);
	
	if (nLevel <= 0) then
		self:WriteLog("GetKinAward", string.format("%s ������ȡ�ȼ�����", pPlayer.szName), nSession, nType);
		return 0, "��û���ʸ�����影��";
	end
	
	if (not self.AWARD_KIN_LIST[nSession][nLevel]) then
		return 0, "��������������ϵ����Ա";
	end
	
	local nFree = EPlatForm.Fun:GetNeedFree(self.AWARD_KIN_LIST[nSession][nLevel]);
	if pPlayer.CountFreeBagCell() < nFree then
		return 0, string.format("���ı����ռ䲻��,������%s�񱳰��ռ�.", nFree);
	end

	local tbResultName = {
			[1] = "�ھ�",
			[2] = "�Ǿ�",
			[3] = "4ǿ",
			[4] = "8ǿ", 
			[5] = "16ǿ",
			[6] = "32ǿ",
		};
	return 1, string.format("�����ڵļ����ڵ�%d���л����<color=yellow>%s<color>����", nSession, tbResultName[nLevel]);
end

function EPlatForm:GetPlayerAward_Single()
	local nAwardFlag = me.GetTask(EPlatForm.TASKID_GROUP, EPlatForm.TASKID_AWARDFLAG);
	if (0 >= nAwardFlag) then
		Dialog:Say("û�н���������Ŷ����Ҫ�������μӻ�ɣ�");
		return 0;
	end
	local nSession, nState, nAwardID = EPlatForm:GetAwardFlagParam(nAwardFlag);
	if (nSession <= 0 or nState <= 0 or nAwardID <= 0) then
		return 0;
	end
	
	-- �ǵ�һ�׶α�����������ô���Ǹ��˽���
	if (nState == EPlatForm.DEF_STATE_MATCH_1) then
		return self:OnGetAwardSingle(EPlatForm.MATCH_WELEE, nSession, nAwardID);
	elseif (nState == EPlatForm.DEF_STATE_MATCH_2 or nState == EPlatForm.DEF_STATE_ADVMATCH) then
		return self:OnGetAwardSingle(EPlatForm.MATCH_TEAMMATCH, nSession, nAwardID);
	end
	
	return 1;
end

--��ȡ����ʤ������
function EPlatForm:OnGetAwardSingle(nAwardType, nSession, nAwardID)
	-- ��ս����
	if (self.MATCH_WELEE == nAwardType) then
		local nAwardLevel = EPlatForm:GetAwardLevelSep(nAwardType, nSession, nAwardID);
		
		if (not EPlatForm.AWARD_WELEE_LIST[nSession]) then
			Dialog:Say("û�н���");
			return 0;
		end
		
		local tbAward = EPlatForm.AWARD_WELEE_LIST[nSession][nAwardLevel];
		if (not tbAward) then
			Dialog:Say("û�н���");
			return 0;	
		end
		
		local nFree = EPlatForm.Fun:GetNeedFree(tbAward);
		if me.CountFreeBagCell() < nFree then
			Dialog:Say(string.format("���ı����ռ䲻��,������%s�񱳰��ռ�.", nFree));
			return 0;
		end

		--����
		EPlatForm.Fun:DoExcute(me, tbAward);

		me.SetTask(self.TASKID_GROUP, self.TASKID_AWARDFLAG, 0);
		EPlatForm:WriteLog("OnGetAwardSingle", string.format("%s��û�ս��Ʒ���� nSession, nAwardID", me.szName), nSession, nAwardID);	
	-- ս�ӽ���
	elseif (self.MATCH_TEAMMATCH == nAwardType) then
		if (not EPlatForm.AWARD_WELEE_LIST[nSession]) then
			Dialog:Say("û�н���");
			return 0;
		end
		
		local tbAward = nil;
		
		if (not EPlatForm.AWARD_SINGLE_LIST[nSession]) then
			Dialog:Say("û�н���");
			return 0;		
		end
		
		-- ʤ������
		if (nAwardID == 1) then
			tbAward = EPlatForm.AWARD_SINGLE_LIST[nSession].Win;
		elseif (nAwardID == 2) then
			tbAward = EPlatForm.AWARD_SINGLE_LIST[nSession].Tie;
		elseif (nAwardID == 3) then
			tbAward = EPlatForm.AWARD_SINGLE_LIST[nSession].Lost;
		end
		
		if (not tbAward) then
			Dialog:Say("û�н���");
			return 0;		
		end
		
		local nFree = EPlatForm.Fun:GetNeedFree(tbAward);
		if me.CountFreeBagCell() < nFree then
			Dialog:Say(string.format("���ı����ռ䲻��,������%s�񱳰��ռ�.", nFree));
			return 0;
		end

		--����
		EPlatForm.Fun:DoExcute(me, tbAward);

		me.SetTask(self.TASKID_GROUP, self.TASKID_AWARDFLAG, 0);
		EPlatForm:WriteLog("OnGetAwardSingle", string.format("%s���ս�ӽ�����Ʒ���� nSession, nAwardID", me.szName), nSession, nAwardID);	
	end
	return 1;
end

--��ҵ�½���콱��.
function EPlatForm:OnLogin()
	self:RefreshTeamAward(me);
end

function EPlatForm:RefreshTeamAward(pPlayer)
	local szLeagueName = League:GetMemberLeague(EPlatForm.LGTYPE, pPlayer.szName);
	if szLeagueName then
		local nLeagueTotal = League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TOTAL);
		local nLeagueWin = League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_WIN);
		local nLeagueTie = League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TIE);
		local nSession = League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_MSESSION);
		
		if nSession > pPlayer.GetTask(EPlatForm.TASKID_GROUP, EPlatForm.TASKID_HELP_SESSION) then
			pPlayer.SetTask(EPlatForm.TASKID_GROUP, EPlatForm.TASKID_HELP_SESSION, nSession);
			pPlayer.SetTask(EPlatForm.TASKID_GROUP, EPlatForm.TASKID_HELP_TOTLE, nLeagueTotal);
			pPlayer.SetTask(EPlatForm.TASKID_GROUP, EPlatForm.TASKID_HELP_WIN, nLeagueWin);
			pPlayer.SetTask(EPlatForm.TASKID_GROUP, EPlatForm.TASKID_HELP_TIE, nLeagueTie);	
		end
		if pPlayer.GetTask(EPlatForm.TASKID_GROUP, EPlatForm.TASKID_HELP_TOTLE) ~= nLeagueTotal then
			pPlayer.SetTask(EPlatForm.TASKID_GROUP, EPlatForm.TASKID_HELP_TOTLE, nLeagueTotal);
			pPlayer.SetTask(EPlatForm.TASKID_GROUP, EPlatForm.TASKID_HELP_WIN, nLeagueWin);
			pPlayer.SetTask(EPlatForm.TASKID_GROUP, EPlatForm.TASKID_HELP_TIE, nLeagueTie);		
		end
		local nResult = League:GetMemberTask(self.LGTYPE, szLeagueName, pPlayer.szName, self.LGMTASK_AWARD);
		if nResult == 0 then
			return 0
		end

		local nAwardFlag = self:SetAwardFlagParam(0, nSession, EPlatForm.DEF_STATE_MATCH_2, nResult);
		self:SetAwardParam(pPlayer, nAwardFlag);		
		
		League:SetMemberTask(self.LGTYPE, szLeagueName, pPlayer.szName, self.LGMTASK_AWARD, 0);
		EPlatForm:WriteLog("�ɹ����쵥������", pPlayer.szName);
	end	
end

function EPlatForm:SendAdvMatchResultMsg(szLeagueName, nResultId)
	if (not szLeagueName or not nResultId or nResultId <= 0 or nResultId > 4) then
		return 0;
	end
	local tbResultName = {
			[1] = "�ھ�",
			[2] = "�Ǿ�",
			[3] = "4ǿ",
			[4] = "8ǿ", 
		};

	local nMacthType = EPlatForm:GetMacthType();
	local tbMacth	= EPlatForm:GetMacthTypeCfg(nMacthType);
	local szMatchName	= "";
	if (tbMacth) then
		szMatchName	= 	tbMacth.szName;
	end

	local szMsg = "��ϲ<color=yellow>%s<color>�����<color=yellow>%s<color>ս���ڶӳ�<color=yellow>%s<color>�Ĵ����»���˱��¼��徺���<color=yellow>%s<color>��<color=yellow>%s<color>";
	local szMyMsg = "��ϲ�����ڶ������˱�����%s"
	local tbMemberList = EPlatForm:GetLeagueMemberList(szLeagueName);
	local szCaptain	= "";
	for _, szMemberName in ipairs(tbMemberList) do
		local nCaptain = League:GetMemberTask(self.LGTYPE, szLeagueName, szMemberName, self.LGMTASK_JOB);
		if (1 == nCaptain) then
			szCaptain = szMemberName;
			break;
		end
	end
	local szKinName = self:GetKinNameFromLeagueName(szLeagueName);
	szMsg = string.format(szMsg, szKinName, szLeagueName, szCaptain, szMatchName, tbResultName[nResultId]);
	szMyMsg = string.format(szMyMsg, tbResultName[nResultId]);
	
	if (1 == nResultId or 2 == nResultId) then
		KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, szMsg);	
	end
	
	for nId, szName in pairs(tbMemberList) do
		local pPlayer = KPlayer.GetPlayerByName(szName);
		if pPlayer then
			pPlayer.Msg(szMyMsg);
			Dialog:SendBlackBoardMsg(pPlayer, szMyMsg);
			Player:SendMsgToKinOrTong(pPlayer, szMsg, 1);
			pPlayer.SendMsgToFriend(szMsg);
		end
	end
end

function EPlatForm:GetAwardFlagParam(nAwardFlag)	
	local nSession	= KLib.GetByte(nAwardFlag, 3);
	local nState	= KLib.GetByte(nAwardFlag, 2);
	local nAwardID	= KLib.GetByte(nAwardFlag, 1);
	return nSession, nState, nAwardID;
end

function EPlatForm:SetAwardFlagParam(nAwardFlag, nSession, nState, nAwardID)	
	nAwardFlag	= KLib.SetByte(nAwardFlag, 3, nSession);
	nAwardFlag	= KLib.SetByte(nAwardFlag, 2, nState);
	nAwardFlag	= KLib.SetByte(nAwardFlag, 1, nAwardID);
	return nAwardFlag;
end

