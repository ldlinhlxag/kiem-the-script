--��������
--�����
--2008.09.23

--�����ȡ����ʤ������
function GbWlls:OnCheckAwardSingle(pPlayer, nGbTaskId, nTaskId)
	if (not pPlayer) then
		return 0;
	end
	
	if (not nGbTaskId or not nTaskId or nGbTaskId <= 0 or nTaskId <= 0) then
		return 0;
	end
	
	local nGblSession		= GbWlls:GetGblWllsOpenState();
	local nMyGblSession		= GbWlls:GetPlayerGblWllsSessionByName(pPlayer.szName);
	local nMatchWinCount	= GbWlls:GetPlayerSportTask(pPlayer.szName, nGbTaskId);
	local nAlreadyGetAward	= pPlayer.GetTask(GbWlls.TASKID_GROUP, nTaskId);
	local nMySession		= pPlayer.GetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_MATCH_SESSION);
	if (nGblSession <= 0) then
		return 0;
	end
	
	if (nMyGblSession <= 0) then
		return 0;
	end
	
	if (nGblSession ~= nMyGblSession) then
		return 0;
	end
	
	if (nMySession ~= nMyGblSession) then
		return 0;
	end

	if nMatchWinCount > 0 and nMatchWinCount > nAlreadyGetAward then
		return nTaskId;
	end
	return 0;
end

function GbWlls:UpdateMatchAwardCount(pPlayer)
	if (not pPlayer) then
		return 0;
	end
	
	local nGblSession		= GbWlls:GetGblWllsOpenState();
	local nMyGblSession		= GbWlls:GetPlayerGblWllsSessionByName(pPlayer.szName);
	local nAlreadyGetAward	= pPlayer.GetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_MATCH_WIN_AWARD);
	local nMySession		= pPlayer.GetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_MATCH_SESSION);
	if (nGblSession <= 0) then
		return 0;
	end
	
	if (nMyGblSession <= 0) then
		return 0;
	end
	
	if (nMySession == nMyGblSession) then
		return 0
	end

	pPlayer.SetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_MATCH_SESSION, nMyGblSession);
	pPlayer.SetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_MATCH_LOSE_AWARD, 0);
	pPlayer.SetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_MATCH_WIN_AWARD, 0);
	pPlayer.SetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_MATCH_TIE_AWARD, 0);
	
	return 0;
end

--��ȡ����ʤ������
function GbWlls:OnGetAwardSingle(nGbTaskId, nTaskId)
	self:UpdateMatchAwardCount(me);
	local nFlag = GbWlls:OnCheckAwardSingle(me, nGbTaskId, nTaskId);
	if nFlag == 0 then
		Dialog:Say("Ŀǰû�п�����ȡ�Ľ�����");
		return 0;
	end

	local nMatchWinCount	= GbWlls:GetPlayerSportTask(me.szName, nGbTaskId);
	local nAlreadyGetAward	= me.GetTask(GbWlls.TASKID_GROUP, nTaskId);
	
	local nDet = nMatchWinCount - nAlreadyGetAward;
	if (nDet <= 0) then
		Dialog:Say("Ŀǰû�п�����ȡ�Ľ�����");
		return 0;
	end
		
	local szMsg = string.format("Ŀǰ����<color=yellow>%d<color>������û����ȡ��ȷ����ȡ��", nDet);
	Dialog:Say(szMsg, 
		{
			{"��ȷ����ȡ", self.GetSingleAward, self, nGbTaskId, nTaskId},
			{"����ʱ��������"},
		}
	);

end

function GbWlls:GetSingleAward(nGbTaskId, nTaskId)
	self:UpdateMatchAwardCount(me);
	local nFlag = GbWlls:OnCheckAwardSingle(me, nGbTaskId, nTaskId);
	if nFlag == 0 then
		return 0;
	end

	local nGameLevel	= GbWlls:GetPlayerSportTask(me.szName, self.GBTASKID_MATCH_LEVEL);
	if (nGameLevel <= 0) then
		return 0;
	end

	local nMatchWinCount	= GbWlls:GetPlayerSportTask(me.szName, nGbTaskId);
	local nCount			= me.GetTask(GbWlls.TASKID_GROUP, nTaskId);
	
	local nSession		= GbWlls:GetPlayerGblWllsSessionByName(me.szName);
	local tbAward		= {};
	local nFreeCount	= 0;
	if (self.TASKID_MATCH_WIN_AWARD == nTaskId) then
		tbAward	= GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Win;
		nFreeCount = GbWlls.Fun:GetNeedFree(tbAward);
		nFreeCount = nFreeCount + 1;
	elseif (self.TASKID_MATCH_LOSE_AWARD == nTaskId) then
		tbAward	= GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Lost;
		nFreeCount	= GbWlls.Fun:GetNeedFree(tbAward);
	elseif (self.TASKID_MATCH_TIE_AWARD == nTaskId) then
		tbAward	= GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Tie;
		nFreeCount	= GbWlls.Fun:GetNeedFree(tbAward);
	end
	
	if me.CountFreeBagCell() < nFreeCount then
		Dialog:Say(string.format("���ı����ռ䲻��,������%s�񱳰��ռ�.", nFreeCount));
		return 0;
	end
	
	if (nMatchWinCount - nCount <= 0) then
		Dialog:Say("Ŀǰû�п�����ȡ�Ľ�����");
		return 0;
	end	
	
	GbWlls.Fun:DoExcute(me, tbAward);
	if (self.TASKID_MATCH_WIN_AWARD == nTaskId) then
		local pItem = me.AddItem(18,1,548,1);
		if pItem then
			Dbg:WriteLog("GbWlls","�ɹ���ȡ����������", me.szName);
		end
		Dialog:Say("�������һ��<color=yellow>����������<color>��");		
	elseif (self.TASKID_MATCH_LOSE_AWARD == nTaskId) then
		-- TODO
	elseif (self.TASKID_MATCH_TIE_AWARD == nTaskId) then
		-- TODO
	end

	me.SetTask(GbWlls.TASKID_GROUP, nTaskId, nCount + 1);
end

--���ս������н���ʱ���ȵ�������ѡ��
function GbWlls:OnCheckAward(pPlayer, nGameLevel)
	if (not pPlayer) then
		return 0, 0, "";
	end
	
	local nGblSession		= GbWlls:GetGblWllsOpenState();
	local nMyGblSession		= GbWlls:GetPlayerGblWllsSessionByName(pPlayer.szName);
	
	if (nGblSession <= 0) then
		return 0, 0, string.format("�����������δ�������޷���ȡ������");
	end

	if not nGameLevel or nGameLevel <= 0 then
		return 0, 0 ,string.format("�����ǿ�����������Ĳ���ѡ�֡�");
	end
	
	if GbWlls:GetGblWllsState() ~= Wlls.DEF_STATE_REST or GbWlls:GetGblWllsRankFinish() < GbWlls:GetGblWllsOpenState() then
		return 0, 0, string.format("�����ڻ�δ�������߱����������л�δ�����������ĵȴ���");		
	end
	
	local nTotal = self:GetPlayerSportTask(pPlayer.szName, self.GBTASKID_MATCH_WIN_AWARD) + self:GetPlayerSportTask(pPlayer.szName, self.GBTASKID_MATCH_LOSE_AWARD) + self:GetPlayerSportTask(pPlayer.szName, self.GBTASKID_MATCH_TIE_AWARD);
	if nTotal <= 0 then
		return 0, 0, string.format("����ս�ӻ�δ�μӹ����������½�ս�ӣ�������ȡ������");	
	end
	local nRank		= self:GetPlayerSportTask(pPlayer.szName, self.GBTASKID_MATCH_RANK);
	local nAdvRank	= self:GetPlayerSportTask(pPlayer.szName, self.GBTASKID_MATCH_ADVRANK);
	
	if pPlayer.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_FINAL_AWARD) >= nMyGblSession then
		return 0, 0 , string.format("������ȡ�������ˡ�");
	end	
	
	
	if nRank == 1 and nAdvRank == 2 then
		nRank = 2;
	end	

	local nLevelSep, nMaxRank = GbWlls:GetAwardLevelSep(nGameLevel, nMyGblSession, nRank);
	if nLevelSep <= 0 then
		return 0, 0, string.format("����ս��û�н���������ȡ��");
	end

	if nMaxRank >= 10000 and nTotal < math.floor(nMaxRank/10000) then
		return 0, 0 , string.format("����ս���ڱ��������û�л���κν���,���½����Ŭ����");
	end
	return 1, nRank , string.format("��ȡ����");
end


--��ȡ���ս���
function GbWlls:OnGetAward(nFlag)
	local nGameLevel = self:GetPlayerSportTask(me.szName, self.GBTASKID_MATCH_LEVEL);
	if (nGameLevel <= 0) then
		return 0;
	end
	local nCheck,nRank,szError = GbWlls:OnCheckAward(me, nGameLevel);
	
	if nCheck == 0 then
		Dialog:Say(szError);
		return 0;
	end

	local nSession		= GbWlls:GetPlayerGblWllsSessionByName(me.szName);
	local nMatchType	= self:GetMacthType(nSession);
	local tbMatchType	= self:GetMacthTypeCfg(nMatchType);
	local nLevelSep, nMaxRank = GbWlls:GetAwardLevelSep(nGameLevel, nSession, nRank);

	local szRank = string.format("��%d��", nRank);	
	
	--��������
	if nRank == 1 then
		me.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_FIRST, me.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_FIRST) + 1);
		szRank = "�ھ�";
	end
	if nRank == 2 then
		me.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_SECOND, me.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_SECOND) + 1);
		szRank = "�Ǿ�";
	end
	if nRank == 3 then
		me.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_THIRD, me.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_THIRD) + 1);
		szRank = "����";
	end

	local nTotal = self:GetPlayerSportTask(me.szName, self.GBTASKID_MATCH_WIN_AWARD) + self:GetPlayerSportTask(me.szName, self.GBTASKID_MATCH_LOSE_AWARD) + self:GetPlayerSportTask(me.szName, self.GBTASKID_MATCH_TIE_AWARD);	
	
	if (nMaxRank >= 10000) then
		local nMaxMatch = math.floor(nMaxRank/10000);
		if (nMaxMatch <= nTotal) then
			szRank = string.format("����<color=yellow>%s<color>��", nMaxMatch);
		end
	else
		szRank = string.format("�����<color=yellow>%s<color>", szRank);
	end
	
	if not nFlag then
		local szMsg = string.format("�������������Ա������ս�����Ͻ�����������%s��ȷ��������ȡ��", szRank);
		local tbOpt = 
		{
			{"��ȷ����ȡ����",self.OnGetAward, self, 1},
			{"���ٿ��ǿ���"},
		}
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	local nFree = GbWlls.Fun:GetNeedFree(GbWlls.AWARD_FINISH_LIST[nGameLevel][nSession][nLevelSep]);
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
		
	me.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_FINAL_AWARD, nSession);
	me.SetTask(self.TASKID_GROUP, self.TASKID_GETFINALAWARD_TIME, GetTime());
	local nLogTaskFlag = nSession + nLevelSep * 1000 + nGameLevel * 1000000;
	me.SetTask(self.TASKID_GROUP, self.TASKID_AWARD_LOG, nLogTaskFlag);	
	
	--����
	GbWlls.Fun:DoExcute(me, GbWlls.AWARD_FINISH_LIST[nGameLevel][nSession][nLevelSep]);

	local nStarPlayerFlag = self:GetPlayerSportTask(me.szName, GbWlls.GBTASKID_MATCH_DAILY_RESULT);
	if (nStarPlayerFlag > 0 and nStarPlayerFlag < 100) then
		self:GiveStarPlayerTitle(me, nStarPlayerFlag);
	end

	-- �����ȡ�����������ս����Ŀͷ�log
	local szLogMsg = string.format("��ң�%s �������Σ�%s ���Σ�%s�� �Ѿ���ȡ�����������������", me.szName, nTotal, nRank);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szLogMsg);

	-- ������ʾ
	local _, szServerName = self:GetZoneNameAndServerName();
	
	Dialog:Say("���ɹ���ȡ�˽�����");
	Wlls:WriteLog(string.format("%s����������:%s, ·��:%s", nGameLevel, nRank, Player:GetFactionRouteName(me.nFaction, me.nRouteId)), me.nId)	
	
	local szAnncone = string.format("<color=green>%s���%s<color>����һ�������������л����<color=red>%s<color>������", szServerName, me.szName, szRank);
	local szKinOrTong = string.format("����һ�����������л����<color=red>%s<color>�ĺóɼ���", szRank);
	local szFriend = string.format("���ĺ���[<color=green>%s<color>]���Ͻ����������л����<color=red>%s<color>��", me.szName, szRank);
	
	if (nRank <= 0) then
		return 0;
	end
	
	-- ǰ3��
	if nRank <= 3 then
		Dialog:GlobalMsg2SubWorld(szAnncone);
		Dialog:GlobalNewsMsg(szAnncone);
		Player:SendMsgToKinOrTong(me, szKinOrTong, 1);
	-- ǰ8��
	elseif nRank <= 8 then
		KDialog.NewsMsg(1, Env.NEWSMSG_NORMAL, szAnncone);
		Player:SendMsgToKinOrTong(me, szKinOrTong, 1);
	end
	
	-- ���ѹ���
	me.SendMsgToFriend(szFriend);
end

function GbWlls:GiveStarPlayerTitle(pPlayer, nStarPlayerFlag)
	if (not pPlayer or not nStarPlayerFlag) then
		return 0;
	end
	
	if (2 == nStarPlayerFlag) then
		local nFaction = self:GetPlayerSportTask(me.szName, GbWlls.GBTASKID_MATCH_TYPE_PAREM);
		if (nFaction <= 0 or nFaction > 12) then
			self:WriteLog("GiveStarPlayerTitle", "Give Star Player Title failed", pPlayer.szName, nFaction);
			return 0;
		end
		pPlayer.AddTitle(self.DEF_STARPLAYER_FAC_TITLE[1], self.DEF_STARPLAYER_FAC_TITLE[2], nFaction, 0);
		self:WriteLog("GiveStarPlayerTitle", pPlayer.szName, nFaction);
	end
	return 1;
end

function GbWlls:GiveLuckCardAward(pPlayer, nNowTime)
	if (not pPlayer or not nNowTime) then
		return 0;
	end

	if (not self.tbMatchPlayerList) then
		self:WriteLog("GiveLuckCardAward", "tbMatchPlayerList is not exist!!!!", pPlayer.szName);
		return 0;
	end
	
	local nMaxCount = #self.tbMatchPlayerList;
	if (nMaxCount <= 0) then
		local tbItem = GbWlls.DEF_ITEM_LOSTGUESS;
		pPlayer.AddStackItem(tbItem[1], tbItem[2], tbItem[3], tbItem[4], {bForceBind=1}, GbWlls.DEF_ITEM_LOSTGUESS_COUNT);
		pPlayer.Msg("Ŀǰ��û����ұ�����лл���Ĳ��룡");
		return 0;
	end
	local nRandomResult = MathRandom(1, nMaxCount);
	local szGuessName = self.tbMatchPlayerList[nRandomResult];
	
	if (not szGuessName) then
		pPlayer.Msg("����쳣��лл���Ĳ��룡");
		return 0;		
	end

	local nNowDay	= Lib:GetLocalDay(nNowTime);
	local nResult	= self:GetPlayerSportTask(szGuessName, self.GBTASKID_MATCH_DAILY_RESULT);
	local nWinDay	= Lib:GetLocalDay(nResult); 
	local szMsg		= "";
	if (nNowDay == nWinDay and nNowDay > 0) then
		szMsg = string.format(string.format("<color=yellow>%s<color>����������������ǣ����ڽ�������μӵı���������Ӯ����һ��������ʤ������ϲ�㣡", szGuessName));
		local tbItem = GbWlls.DEF_ITEM_WINGUESS;
		pPlayer.AddStackItem(tbItem[1], tbItem[2], tbItem[3], tbItem[4], {bForceBind=1}, self.DEF_ITEM_WINGUESS_COUNT);
	else
		szMsg = string.format("���<color=yellow>%s<color>�������������ǣ���ϧ����״̬���ã�û��Ӯ�ý��������ʤ����", szGuessName);
		local tbItem = GbWlls.DEF_ITEM_LOSTGUESS;
		pPlayer.AddStackItem(tbItem[1], tbItem[2], tbItem[3], tbItem[4], {bForceBind=1}, GbWlls.DEF_ITEM_LOSTGUESS_COUNT);
	end
	
	pPlayer.Msg(szMsg);
	return 1;	
end
