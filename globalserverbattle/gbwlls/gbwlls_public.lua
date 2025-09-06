-- �ļ�������gbwlls_public.lua
-- �����ߡ���zhouchenfei
-- ����ʱ�䣺2009-12-16 11:15:59
-- ������  �����������غ���

function GbWlls:GetGblWllsOpenState()
	return GetGlobalSportTask(GbWlls.GBTASK_GROUP, GbWlls.GBTASK_SESSION) or 0;
end

function GbWlls:SetGblWllsOpenState(nState)
	SetGlobalSportTask(GbWlls.GBTASK_GROUP, GbWlls.GBTASK_SESSION, nState);
end

function GbWlls:GetGblWllsOpenTime()
	return GetGlobalSportTask(GbWlls.GBTASK_GROUP, GbWlls.GBTASK_FIRSTOPENTIME) or 0;
end

function GbWlls:SetGblWllsOpenTime(nTime)
	SetGlobalSportTask(GbWlls.GBTASK_GROUP, GbWlls.GBTASK_FIRSTOPENTIME, nTime);
end

function GbWlls:SetGblWllsState(nState)
	SetGlobalSportTask(GbWlls.GBTASK_GROUP, GbWlls.GBTASK_MATCH_STATE, nState);
end

function GbWlls:GetGblWllsState()
	return GetGlobalSportTask(GbWlls.GBTASK_GROUP, GbWlls.GBTASK_MATCH_STATE) or 0;
end

-- ��ȡ������ɱ�־
function GbWlls:GetGblWllsRankFinish()
	return GetGlobalSportTask(GbWlls.GBTASK_GROUP, GbWlls.GBTASK_MATCH_RANK) or 0;
end

function GbWlls:SetGblWllsRankFinish(nFlag)
	SetGlobalSportTask(GbWlls.GBTASK_GROUP, GbWlls.GBTASK_MATCH_RANK, nFlag);
end

--��������������ñ�
function GbWlls:GetMacthTypeCfg(nMacthType)
	if not nMacthType or nMacthType <= 0 then
		return
	end
	return self.MacthType[self.MACTH_TYPE[nMacthType]];
end

--�����������,Int
function GbWlls:GetMacthType(nSession)
	if not nSession then
		return 0;
	end
	if not self.SEASON_TB[nSession] then
		return 0;
	end
	return self.SEASON_TB[nSession][1];
end

--������Ƶȼ����ñ�
function GbWlls:GetMacthLevelCfg(nMacthType, nMacthLevel)
	if not nMacthType or nMacthType <= 0 then
		return
	end
	return self.MacthType[self.MACTH_TYPE[nMacthType]][self.MACTH_LEVEL[nMacthLevel]];
end

--��õ�ǰ��������
function GbWlls:GetMacthLevelCfgType()
	local nRankSession = GbWlls:GetGblWllsOpenState();
	if GbWlls:GetMacthTypeCfg(GbWlls:GetMacthType(nRankSession)) then
		return GbWlls:GetMacthTypeCfg(GbWlls:GetMacthType(nRankSession)).nMapLinkType;
	end
	return 0;
end

function GbWlls:SetPlayerGblWllsSessionByName(szPlayerName, nSession)
	if (not GLOBAL_AGENT) then
		return 0;
	end
	if (not szPlayerName) then
		return 0;
	end
	local nId = KGCPlayer.GetPlayerIdByName(szPlayerName);
	if nId then
		SetPlayerSportTask(nId, GbWlls.GBTASKID_GROUP, GbWlls.GBTASKID_SESSION, nSession);
	end
end

function GbWlls:GetPlayerGblWllsSessionByName(szPlayerName)
	if (not szPlayerName) then
		return 0;
	end
	local nId = KGCPlayer.GetPlayerIdByName(szPlayerName);
	if nId then
		return GetPlayerSportTask(nId, GbWlls.GBTASKID_GROUP, GbWlls.GBTASKID_SESSION) or 0;
	end
	return 0;
end

-- ����Ƿ�������������
function GbWlls:CheckOpenState_GblServer()
	if (not GLOBAL_AGENT) then
		return 0;
	end
	
	if (self.IsOpen ~= 1) then
		return 0;
	end
	
	local nFlagState = GbWlls:GetGblWllsOpenState();
	if (not nFlagState or nFlagState <= 0) then
		return 0;
	end

	if (self:CheckOpenMonth(GetTime()) == 0) then
		return 0;
	end

	return 1;
end

function GbWlls:SetGblWllsSession(nSession)
	if (not GLOBAL_AGENT) then
		return 0;
	end

	if (not nSession or nSession <= 0) then
		return 0;
	end

	local nGblSession = self:GetGblWllsOpenState();
	if (nGblSession <= 0) then
		return 0;
	end
	self:SetGblWllsOpenState(nSession);
end

function GbWlls:CheckOpenMonth(nNowTime)
	if (not nNowTime) then
		return 0;
	end
	local tbTime	= os.date("*t", nNowTime);
	if (not tbTime) then
		return 0;
	end
	for i=1, #GbWlls.DEF_OPEN_MONTH do
		if (tbTime.month == GbWlls.DEF_OPEN_MONTH[i]) then
			return 1;
		end	
	end
	return 0;
end

-- ����ȫ�ַ�������һ�����
function GbWlls:WllsGlobalServerOpenTime()
	if (not GLOBAL_AGENT) then
		return 0;
	end

	-- �Ƿ���ȫ�ַ���������
	local nStateFlag = self:GetGblWllsOpenState();
	if (nStateFlag <= 0) then
		return 0;
	end
	
	-- �Ƿ��Ѿ�������һ��
	local nTime = self:GetGblWllsOpenTime();
	-- ��ʾ�Ѿ�����Ͽ�������
	if (nTime > 0) then
		return 0;
	end
	
	if (Wlls:GetMatchStateForDate() ~= GbWlls.DEF_STATE_REST) then
		return 0;
	end	
	local nNowTime	= GetTime();
	if (self:CheckOpenMonth(nNowTime) == 0) then
		return 0;
	end

	KGblTask.SCSetDbTaskInt(GbWlls.GTASK_MACTH_SESSION, 1);	
	KGblTask.SCSetDbTaskInt(GbWlls.GTASK_MACTH_STATE, GbWlls.DEF_STATE_REST);
	GbWlls:SetGblWllsOpenState(1);
	GbWlls:SetGblWllsOpenTime(GetTime());
	return 1;
end

-- �鿴�����Ƿ����ʸ�μӿ������
function GbWlls:ServerIsCanJoinGbWlls()
	local nSession = Wlls:GetMacthSession();
	if (nSession < GbWlls.DEF_OPENGBWLLSSESSION) then
		return 0, "�����ڵķ�������û���й����������������޷�ȥ�μӿ������������";
	end
	return 1;
end

-- ��֤�Ƿ����ʸ�ȥȫ�ַ�����
function GbWlls:CheckIsCanTransferGblWlls(pPlayer)
	if (not pPlayer) then
		return 0, string.format("ֻ�вƸ�����ǰ%d����������������ǰ%d������ң�����֮ǰ�Ѿ�����������Ҳ���ȥӢ�۵���", GbWlls.DEF_MAXGBWLLS_MONEY_RANK, GbWlls.DEF_MAXGBWLLS_WLLS_RANK);
	end
	local nGblSession = self:GetGblWllsOpenState();
	local nMyGblSession = self:GetPlayerGblWllsSessionByName(pPlayer.szName);
	-- �Ѿ��μ��˿�������������Ƿ������ȼ��������Խ���

	local szLeagueName = League:GetMemberLeague(Wlls.LGTYPE, pPlayer.szName);
	local nFlag = Wlls:GetPlayerLeagueFlag(pPlayer);

	if not szLeagueName then
		-- ��ʾû��ս�ӵ���û�������
		if (nFlag == 1) then
			Wlls:SetPlayerIsLeagueFlag(pPlayer.szName, 0);
		end
	else
		-- �����ս��û��ǣ������
		if (nFlag == 0) then
			Wlls:SetPlayerIsLeagueFlag(pPlayer.szName, 1);
		end
		return 0, "���Ѿ��μ��˱����������������޷��μӿ��������";
	end
	
	if (nGblSession > 0 and nGblSession == nMyGblSession) then
		return 1;
	end
	
	if (pPlayer.nLevel < GbWlls.DEF_MIN_PLAYERLEVEL) then
		return 0, string.format("���ĵȼ�û�дﵽ%d�����޷��μӿ��������", GbWlls.DEF_MIN_PLAYERLEVEL);
	end
	
	local nMoneyRank	= PlayerHonor:GetPlayerHonorRankByName(pPlayer.szName, PlayerHonor.HONOR_CLASS_MONEY, 0);
	local nWllsRank		= PlayerHonor:GetPlayerHonorRankByName(pPlayer.szName, PlayerHonor.HONOR_CLASS_WLLS, 0);
	if ((nMoneyRank <= 0 or nMoneyRank > self.DEF_MAXGBWLLS_MONEY_RANK) and (nWllsRank <= 0 or nWllsRank > self.DEF_MAXGBWLLS_WLLS_RANK)) then
		return 0, string.format("ֻ�вƸ�����ǰ%d����������������ǰ%d������ң�����֮ǰ�Ѿ�����������Ҳ���ȥӢ�۵���", GbWlls.DEF_MAXGBWLLS_MONEY_RANK, GbWlls.DEF_MAXGBWLLS_WLLS_RANK);
	end
	
	local nSession = Wlls:GetMacthSession();
	if (nSession < GbWlls.DEF_OPENGBWLLSSESSION) then
		return 0, "�����ڵķ�������û���й����������������޷�ȥ�μӿ������������";
	end
	me.SetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_MONEY_RANK, nMoneyRank);
	me.SetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_WLLS_RANK, nWllsRank);
	return 1;
end

-- �ж��Ƿ���Ա����μӵ�ǰ���ڷ���������������
function GbWlls:CheckWllsQualition(pPlayer)
	if (not pPlayer) then
		return 0;
	end
	
	-- �����ȫ�ַ��������ж��Ƿ��Ѿ��μ����Ǹ�����ڱ���������
	if (GLOBAL_AGENT) then
		local nLeagueFlag = Wlls:GetPlayerLeagueFlag(pPlayer);
		if (nLeagueFlag == 1) then
			return 0;
		end
	else
		local nGblMySession = GetPlayerSportTask(pPlayer.nId, GbWlls.GBTASKID_GROUP, GbWlls.GBTASKID_SESSION) or 0;
		local nGblSession	= GetGlobalSportTask(GbWlls.GBTASK_GROUP, GbWlls.GBTASK_SESSION) or 0;
		if (nGblSession <= 0) then
			return 1;
		end
		
		-- �������ֵ��ͬ���Ҷ�����0����ô˵���Ѿ��μ�����ҿ������
		if (nGblMySession == nGblSession) then
			return 0;
		end
	end
	return 1;
end

-- 1��ʾ�Ѿ��μӿ������
function GbWlls:CheckIsJoinGbWlls(szPlayerName)
	if (not szPlayerName) then
		return 0;
	end

	local nPlayerId = KGCPlayer.GetPlayerIdByName(szPlayerName);
	
	if (nPlayerId <= 0) then
		return 0;
	end
	
	local nGblMySession = GetPlayerSportTask(nPlayerId, GbWlls.GBTASKID_GROUP, GbWlls.GBTASKID_SESSION) or 0;
	local nGblSession	= GetGlobalSportTask(GbWlls.GBTASK_GROUP, GbWlls.GBTASK_SESSION) or 0;
	if (nGblSession <= 0) then
		return 0;
	end
	
	-- �������ֵ��ͬ���Ҷ�����0����ô˵���Ѿ��μ�����ҿ������
	if (nGblMySession == nGblSession) then
		return 1;
	end
	return 0;
end

function GbWlls:GetPlayerSportTask(szPlayerName, nTaskId)
	if (not szPlayerName or not nTaskId or nTaskId <= 0) then
		return 0;
	end
	local nId = KGCPlayer.GetPlayerIdByName(szPlayerName);
	if not nId or nId <= 0 then
		return 0;
	end
	return GetPlayerSportTask(nId, GbWlls.GBTASKID_GROUP, nTaskId) or 0;
end

function GbWlls:SetPlayerSportTask(szPlayerName, nTaskId, nValue)
	if (not szPlayerName or not nTaskId or nTaskId <= 0 or not nValue) then
		return 0;
	end
	local nId = KGCPlayer.GetPlayerIdByName(szPlayerName);
	if not nId or nId <= 0 then
		return 0;
	end
	SetPlayerSportTask(nId, GbWlls.GBTASKID_GROUP, nTaskId, nValue);
end

--��ý����ȼ���
function GbWlls:GetAwardLevelSep(nGameLevel, nSession, nRank)
	if nRank <= 0 then
		return 0, 0;
	end
	for nLevelSep, nMaxRank in ipairs(self.AWARD_LEVEL[nSession][nGameLevel]) do
		if nRank <= nMaxRank then
			return nLevelSep, nMaxRank;
		end
	end
	return 0, 0;
end

function GbWlls:ResetPlayerGbWllsInfo(szPlayerName, nMatchLevel, nExParam)
	if (not GLOBAL_AGENT) then
		return 0;
	end

	self:SetPlayerSportTask(szPlayerName, self.GBTASKID_MATCH_LEVEL, nMatchLevel);
	self:SetPlayerSportTask(szPlayerName, self.GBTASKID_MATCH_RANK, 0);
	self:SetPlayerSportTask(szPlayerName, self.GBTASKID_MATCH_WIN_AWARD, 0);
	self:SetPlayerSportTask(szPlayerName, self.GBTASKID_MATCH_TIE_AWARD, 0);
	self:SetPlayerSportTask(szPlayerName, self.GBTASKID_MATCH_LOSE_AWARD, 0);
	self:SetPlayerSportTask(szPlayerName, self.GBTASKID_MATCH_FINAL_AWARD, 0);
	self:SetPlayerSportTask(szPlayerName, self.GBTASKID_MATCH_ADVRANK, 0);
	self:SetPlayerSportTask(szPlayerName, self.GBTASKID_MATCH_TYPE_PAREM, nExParam or 0);
end

function GbWlls:SetGbWllsEnterFlag(pPlayer, nFlag)
	if (not pPlayer) then
		return 0;
	end
	pPlayer.SetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_ENTERFLAG, nFlag);
end

function GbWlls:GetGbWllsEnterFlag(pPlayer)
	if (not pPlayer) then
		return 0;
	end
	return pPlayer.GetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_ENTERFLAG);
end

function GbWlls:Anncone_GS(szAnncone)
	KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, szAnncone);
	KDialog.Msg2SubWorld(szAnncone);
end

function GbWlls:OnLogin()
	if (not GLOBAL_AGENT) then
		self:SetGbWllsEnterFlag(me, 0);
		self:ProcessJoinTitle(me);
	end
end

function GbWlls:ProcessJoinTitle(pPlayer)
	if (GLOBAL_AGENT) then
		return 0;
	end
	
	if (not pPlayer) then
		return 0;
	end
	
	local nTime = GetTime();
	if (self:CheckSiguUpTime(nTime) == 0) then
		return 0;
	end
	
	local tbTime = os.date("*t", nTime);
	if (not tbTime) then
		return 0;
	end

	local nJoinFlag		= self:CheckWllsQualition(pPlayer);
	local nTitleFlag	= pPlayer.FindTitle(unpack(self.JOIN_TITLE));
	-- ��ʾ�Ѿ������μ��˿������
	if (0 == nJoinFlag) then
		-- ���ʸ�û�ƺţ���
		if (0 == nTitleFlag) then			
			local tbEndTime = {
				year	=tbTime.year,
				month	=tbTime.month + 1,
				day		=1,
				hour	=0,
				min		=0,
				sec		=0,
			};
			local nEndTime = os.time(tbEndTime);
			pPlayer.AddTitleByTime(self.JOIN_TITLE[1], self.JOIN_TITLE[2], self.JOIN_TITLE[3], self.JOIN_TITLE[4], nEndTime);
			local nSession = self:GetGblWllsOpenState();
			if (nSession <= 0) then
				return 0;
			end
			local nMacthType = GbWlls:GetMacthType(nSession);
			local tbMatchCfg = GbWlls:GetMacthTypeCfg(nMacthType);			
			local szMsg = string.format(self.MSG_JOIN_SUCCESS_FOR_ALL, pPlayer.szName, nSession, tbMatchCfg.szName);
			pPlayer.SendMsgToFriend(szMsg);
		end
	else
		-- û�ʸ��гƺţ�ɾ
		if (1 == nTitleFlag) then
			pPlayer.RemoveTitle(unpack(self.JOIN_TITLE));
		end
	end
end

function GbWlls:CheckSiguUpTime(nTime)
	if (not nTime or nTime <= 0) then
		return 0;
	end
	local tbTime = os.date("*t", nTime);
	if (not tbTime) then
		return 0;
	end
	local nMonthFlag = 0;
	for _, nValue in ipairs(GbWlls.DEF_OPEN_MONTH) do
		if (nValue == tbTime.month) then
			nMonthFlag = 1;
			break;
		end
	end
	if (nMonthFlag ~= 1) then
		return 0;
	end
	
	if (tbTime.day > 27) then
		return 0;
	end
	return 1;
end

function GbWlls:GetZoneName(pPlayer)
	local szGateway = Transfer:GetMyGateway(pPlayer);
	local tbInfo = ServerEvent:GetServerInforByGateway(szGateway);
	if not tbInfo then
		print("stack traceback", "Transfer:GetMyGatewa Error", "Not Find gatewaylistInfor", szGateway);
		return;
	end
	return tbInfo.ZoneName, tbInfo.ServerName;
end

function GbWlls:GetZoneNameAndServerName()
	local tbInfo = ServerEvent:GetMyServerInforByGateway();
	if (not tbInfo) then
		return "", "";
	end
	return tbInfo.ZoneName, tbInfo.ServerName;
end

function GbWlls:GetZoneInfo(szGateway)
	if (not szGateway) then
		return nil;
	end
	if (not self.tbZoneName) then
		return nil;
	end
	local nZoneId = tonumber(string.sub(szGateway, 5, 6)) or 0;
	return self.tbZoneName[nZoneId];
end

function GbWlls:WriteLog(...)
	if (MODULE_GAMESERVER) then
		Dbg:WriteLogEx(Dbg.LOG_INFO, "GbWlls", unpack(arg));
	end
	if (MODULE_GC_SERVER) then
		Dbg:WriteLog("GbWlls", unpack(arg));
	end
end

function GbWlls:ClearAllStatuary()
	Domain.tbStatuary:ClearGbWllsStatuary();
end

function GbWlls:_RepairMatchLevel(pPlayer, nNowMatchLevel)
	if (not pPlayer) then
		return 0;
	end
	
	local nChangeDate = tonumber(os.date("%Y%m%d", GetTime()));
	if (nChangeDate >= GbWlls._DEF_MATCHLEVEL_CHANGETIME) then
		return 0;
	end
	local nMatchLevel = GbWlls:GetPlayerSportTask(me.szName, GbWlls.GBTASKID_MATCH_LEVEL);
	local nMatchSession	= GbWlls:GetPlayerSportTask(me.szName, GbWlls.GBTASKID_SESSION);
	if (nMatchSession <= 0) then
		return 0;
	end
	
	if (nMatchLevel > 0) then
		return 0;
	end

	GbWlls:SetPlayerSportTask(me.szName, GbWlls.GBTASKID_MATCH_LEVEL, nNowMatchLevel);
	self:WriteLog("_RepairMatchLevel", pPlayer.szName, "repair the matchlevel", nNowMatchLevel);
	return 1;
end

-- ��ʱ���ʱ������Ͽ�������ʸ����ҷ������뺯
function GbWlls:SendJoiningGbWllsMail()
	if (GbWlls:ServerIsCanJoinGbWlls() ~= 1) then
		return 0;
	end

	local nSession	 = GbWlls:GetGblWllsOpenState();
	if (nSession <= 0) then
		return 0;
	end
	local nMacthType = GbWlls:GetMacthType(nSession);
	local tbMatchCfg = GbWlls:GetMacthTypeCfg(nMacthType);		
	
	local tbResultPlayerList = self:GetJoinPlayerList();
	
	local nTime		= GetTime();
	local tbTime	= os.date("*t", nTime);
	local tbMail = {
		szTitle		= string.format(self.MAIL_JOINGBWLLS.szTitle, tbMatchCfg.szName), 
		szContent	= string.format(self.MAIL_JOINGBWLLS.szContent, Lib:Transfer4LenDigit2CnNum(nSession), tbMatchCfg.szName, tbTime.month, self.DEF_ADV_PK_STARTDAY),
	};
	
	Mail.tbParticularMail:SendMail(tbResultPlayerList, tbMail);
	return 1;
end

function GbWlls:SendJoinMail_Gb()
	if (not GLOBAL_AGENT) then
		return 0;
	end

	local nNowTime = GetTime();
	if (self:CheckOpenMonth(nNowTime) == 0) then
		return 0;
	end
	
	local tbTime = os.date("*t", nNowTime);
	if (tbTime.day ~= self.DEF_SEND_MAIL_DAY) then
		return 0;
	end
	
	local nSession = self:GetGblWllsOpenState();
	if (nSession <= 0) then
		return 0;
	end
	
	if (self:GetGblWllsState() ~= self.DEF_STATE_REST) then
		return 0;
	end
	
	if (GbWlls.IsOpen ~= 1) then
		return 0;
	end
	-- ����ǿ��������Ҫɾ������ս��
	Timer:Register(Wlls.MACTH_TIME_CLEARLEAGUE,  Wlls.ClearLeague, Wlls);
	Timer:Register(self.DEF_TIME_SEND_JOINMAIL * Env.GAME_FPS, self.OnTimer_SendJoinMail, self);
	
end

function GbWlls:OnTimer_SendJoinMail()
	GC_AllExcute({"GbWlls:SendJoiningGbWllsMail"});
	return 0;
end

-- ��ȡ����ǰ150�����߲Ƹ�������ǰ200�������
function GbWlls:GetJoinPlayerList()
	local tbResultList = {};
	local tbTypeName = {};

	-- ��������
	local nType = Ladder:GetType(0, Ladder.LADDER_CLASS_WLLS, Ladder.LADDER_TYPE_WLLS_HONOR, 0);
	local tbLadder = GetTotalLadderPart(nType, 1, self.DEF_MAXGBWLLS_WLLS_RANK);
	if (tbLadder) then
		for _, tbInfo in pairs(tbLadder) do
			table.insert(tbResultList, tbInfo.szPlayerName);
			tbTypeName[tbInfo.szPlayerName] = 1;
		end
	end
	
	-- �Ƹ�����
	nType = Ladder:GetType(0, Ladder.LADDER_CLASS_MONEY, Ladder.LADDER_TYPE_MONEY_HONOR_MONEY, 0);
	tbLadder = GetTotalLadderPart(nType, 1, self.DEF_MAXGBWLLS_MONEY_RANK);	
	if (tbLadder) then
		for _, tbInfo in pairs(tbLadder) do
			if (not tbTypeName[tbInfo.szPlayerName]) then
				table.insert(tbResultList, tbInfo.szPlayerName);
			end
		end		
	end
	
	return tbResultList;
end

function GbWlls:SendAdvGbWllsMatchMail(tbPlayerName)
	if (not tbPlayerName) then
		return 0;
	end

	if (GbWlls:ServerIsCanJoinGbWlls() ~= 1) then
		return 0;
	end
	
	local nSession	 = GbWlls:GetGblWllsOpenState();
	if (nSession <= 0) then
		return 0;
	end
	local nMacthType = GbWlls:GetMacthType(nSession);
	local tbMatchCfg = GbWlls:GetMacthTypeCfg(nMacthType);	
	
	local tbGateInfo = ServerEvent:GetMyServerInforByGateway() or {};
	
	local nTime		= GetTime();
	local tbTime	= os.date("*t", nTime);
	local tbMail = {
		szTitle		= string.format(self.MAIL_JOINGBWLLS_ADV.szTitle, tbMatchCfg.szName), 
		szContent	= string.format(self.MAIL_JOINGBWLLS_ADV.szContent, tbGateInfo.ZoneName or "��", tbTime.month, self.DEF_ADV_PK_STARTDAY),
	};
	
	Mail.tbParticularMail:SendMail(tbPlayerName, tbMail);
	return 1;
end

function GbWlls:SendAdvGbWllsMatchMail_Gb()
	if (not GLOBAL_AGENT) then
		return 0;
	end

	local nNowTime = GetTime();
	if (self:CheckOpenMonth(nNowTime) == 0) then
		return 0;
	end
	
	local tbTime = os.date("*t", nNowTime);
	
	local nSession = self:GetGblWllsOpenState();
	if (nSession <= 0) then
		return 0;
	end
	
	if (self:GetGblWllsState() ~= self.DEF_STATE_ADVMATCH) then
		return 0;
	end
	
	if (GbWlls.IsOpen ~= 1) then
		return 0;
	end

	local tbPlayerName = {};
	-- ������
	if Wlls:GetMacthLevelCfgType() == Wlls.MAP_LINK_TYPE_FACTION then
		local tbMacthLevelCfg = Wlls:GetMacthLevelCfg(Wlls:GetMacthType(), Wlls.MACTH_ADV);
		for nReadyId, nMapId in pairs(tbMacthLevelCfg.tbReadyMap) do
			local tbLadder, szName, szContext = GetShowLadder(Ladder:GetType(0, 3, 2, nReadyId));
			if (tbLadder) then
				for nId, tbLeague in ipairs(tbLadder) do
					if nId <= 8 then
						local tbTeam = Wlls:GetLeagueMemberList(tbLeague.szName);
						if (tbTeam) then
							for _, szMemberName in ipairs(tbTeam) do
								tbPlayerName[#tbPlayerName + 1] = szMemberName;
							end
						end
					end
				end
			end
		end
	end
	
	GC_AllExcute({"GbWlls:SendAdvGbWllsMatchMail", tbPlayerName});
end

function GbWlls:SendJoinMsg_GB(szPlayerName)
	if (not GLOBAL_AGENT) then
		return 0;
	end
	GC_AllExcute({"GbWlls:SendJoinMsg_GC", szPlayerName});
end

function GbWlls:SendJoinMsg_GC(szPlayerName)
	if (not MODULE_GC_SERVER) then
		return 0;
	end
	
	if (not szPlayerName) then
		return 0;
	end
	local nPlayerId = KGCPlayer.GetPlayerIdByName(szPlayerName);
	if (not nPlayerId or nPlayerId <= 0) then
		return 0;
	end
	GlobalExcute({"GbWlls:SendJoinMsg_GS", szPlayerName});
end

function GbWlls:SendJoinMsg_GS(szPlayerName)
	if (not MODULE_GAMESERVER) then
		return 0;
	end
	
	local tbPlayerInfo = GetPlayerInfoForLadderGC(szPlayerName);
	if (not tbPlayerInfo) then
		return 0;
	end

	local nSession = self:GetGblWllsOpenState();
	if (nSession <= 0) then
		return 0;
	end
	local nMacthType = self:GetMacthType(nSession);
	local tbMatchCfg = self:GetMacthTypeCfg(nMacthType);			
	local szMsg = string.format(self.MSG_JOIN_SUCCESS_FOR_ALL, szPlayerName, Lib:Transfer4LenDigit2CnNum(nSession), tbMatchCfg.szName);
	
	if (tbPlayerInfo.nKinId > 0) then
		KKin.Msg2Kin(tbPlayerInfo.nKinId, szMsg);
	end
	
	if (tbPlayerInfo.nTongId > 0) then
		KTong.Msg2Tong(tbPlayerInfo.nTongId, szMsg);
	end
	return 1;
end

function GbWlls:SendWorldMsg_Gb(szMsg)
	if GLOBAL_AGENT then
		GC_AllExcute({"Dialog:SendWorldMsg_GC", szMsg});
	end
end

function GbWlls:SendWorldMsg_GC(szMsg)
	if (self:ServerIsCanJoinGbWlls() == 0) then
		return 0;
	end
	Dialog:GlobalMsg2SubWorld_GC(szMsg);
end

function GbWlls:SendNewsMsg_Gb(szMsg)
	if GLOBAL_AGENT then
		GC_AllExcute({"Dialog:SendNewsMsg_GC", szMsg});
	end
end

function GbWlls:SendNewsMsg_GC(szMsg)
	if (self:ServerIsCanJoinGbWlls() == 0) then
		return 0;
	end
	Dialog:GlobalMsg2SubWorld_GC(szMsg);
end

function GbWlls:SendPlayerJoinOrLeave_GB(tbPlayerList, nGateWay, nLeave)
	if (not GLOBAL_AGENT) then
		return 0;
	end
	if (not tbPlayerList or not nGateWay or nGateWay <= 0) then
		return 0;
	end
	
	GC_AllExcute({"GbWlls:SendPlayerJoinOrLeave_GC", tbPlayerList, nGateWay, nLeave});
	return 1;
end

function GbWlls:SendPlayerJoinOrLeave_GC(tbPlayerList, nGateWay, nLeave)
	if (not MODULE_GC_SERVER) then
		return 0;
	end
	if (not tbPlayerList or not nGateWay or nGateWay <= 0) then
		return 0;
	end
	
	local szGateway = GetGatewayName();
	local nNowGateWay = tonumber(string.sub(szGateway, 5, 8));
	
	if (nGateWay ~= nNowGateWay) then
		return 0;
	end

	GlobalExcute({"GbWlls:SendPlayerJoinOrLeave_GS", tbPlayerList, nLeave});
	return 1;
end

function GbWlls:SendPlayerJoinOrLeave_GS(tbPlayerList, nLeave)
	if (not tbPlayerList) then
		return 0;
	end
	
	-- ��ʾ����ӵ�
	if (not nLeave or nLeave ~= 1) then
		for _, szName in pairs(tbPlayerList) do
			table.insert(self.tbMatchPlayerList, szName);
		end
		return 1;
	end
	local tbDelList = {};
	-- �ӱ���ɾ��
	for _, szName in pairs(tbPlayerList) do
		local nIndex = 0;
		for i, szPlayerName in pairs(self.tbMatchPlayerList) do
			if (szName == szPlayerName and szName ~= "") then
				nIndex = i;
				break;
			end
		end
		if (nIndex > 0) then
			table.remove(self.tbMatchPlayerList, nIndex);
		end
	end

	return 1;
end

function GbWlls:Process8RankInfo(tb8RankInfo)
	if (not tb8RankInfo) then
		return 0;
	end
	local nState	= tb8RankInfo.nState;
	if (not nState) then
		return 0;
	end

	if (GbWlls:ServerIsCanJoinGbWlls() ~= 1) then
		return 0;
	end
	
	local nSession	 = GbWlls:GetGblWllsOpenState();
	if (nSession <= 0) then
		return 0;
	end
	if (nState == Wlls.DEF_STATE_MATCH) then
		self:ProcessDailyMsg(tb8RankInfo);
	-- ��ʾ����������8ǿ������
	elseif (nState == Wlls.DEF_STATE_ADVMATCH) then
		self:ProcessAdv8Rank(tb8RankInfo);
	-- ��ʾ��ǿ���Ѿ�����
	elseif (nState == Wlls.DEF_STATE_REST) then
		self:ProcessFinal8Rank(tb8RankInfo);
	end
end

function GbWlls:ProcessDailyMsg(tb8RankInfo)
	if (not tb8RankInfo) then
		return 0;
	end
	local nSession	= tb8RankInfo.nSession;
	local nMapType	= tb8RankInfo.nMapType;
	local nState	= tb8RankInfo.nState;
	
	local nMatchType	= GbWlls:GetMacthType(nSession);
	local tbMatchCfg	= GbWlls:GetMacthTypeCfg(nMatchType);
	
	if (not tbMatchCfg) then
		return 0;
	end
	
	if (not nSession or not nMapType or not nState) then
		return 0;
	end
	
	-- �������Ļ�
	if (nMapType == Wlls.MAP_LINK_TYPE_FACTION) then
		local szTime	= os.date("%Y��%m��%d��", GetTime());
		local szMsg = string.format("<color=yellow>%s    ����%sѭ����ս����<color>\n\n", szTime, tbMatchCfg.szName);
		for i, tbInfo in pairs(tb8RankInfo.tbInfo) do
			if (tbInfo) then
				local szFaction = Player:GetFactionRouteName(i);
				for j, tbLeagueInfo in ipairs(tbInfo) do
					if (j > 3) then
						break;
					end
					local szInfo = "";
					local szInfo2 = "";
					local tbDetailInfo	= tbLeagueInfo.tbInfo;
					local szLeagueName	= tbDetailInfo[GbWlls.DEF_INDEX_GBWLLS_8RANK_LEAGUENAME];
					local nRank 		= tbDetailInfo[GbWlls.DEF_INDEX_GBWLLS_8RANK_RANK];
					local nGateWay 		= tbDetailInfo[GbWlls.DEF_INDEX_GBWLLS_8RANK_GATEWAY];
					local nNowGateWay	= self:GetGetWay2Num();
					if (nGateWay == nNowGateWay and nNowGateWay > 0) then
						local szMemberMsg = "";
						if (tbLeagueInfo.tbList) then
							for k, tbPlayerInfo in ipairs(tbLeagueInfo.tbList) do
								if (k > 1) then
									szMemberMsg = szMemberMsg .. "��";
								end
								szMemberMsg = szMemberMsg .. tbPlayerInfo[1];
							end
						end
						szInfo = string.format("ս����  ��%s\n�������ɣ�%s��\nս�ӳ�Ա��%s\n����    ��%s", szLeagueName, szFaction, szMemberMsg, nRank);
						szInfo2 = string.format("ս������%s���������ɣ�%s��ս�ӳ�Ա��%s�����Σ�%s��", szLeagueName, szFaction, szMemberMsg, nRank);
						szMsg = szMsg .. szInfo .. "\n\n";
						Dialog:GlobalNewsMsg_GC(szInfo2);
					end
				end
			end
		end
		local nKey		= Task.tbHelp.NEWSKEYID.NEWS_GBWLLS_DAILY;
		local szTitle	= string.format("��%s��������ÿ��ս��", Lib:Transfer4LenDigit2CnNum(nSession));
		local nAddTime	= GetTime();
		local nEndTime	= nAddTime + 3600 * 24 * 1;	
		Task.tbHelp:AddDNews(nKey, szTitle, szMsg, nEndTime, nAddTime);
	end
end

function GbWlls:ProcessAdv8Rank(tb8RankInfo)
	if (not tb8RankInfo) then
		return 0;
	end
	local nSession	= tb8RankInfo.nSession;
	local nMapType	= tb8RankInfo.nMapType;
	local nState	= tb8RankInfo.nState;
	local nMatchType	= GbWlls:GetMacthType(nSession);
	local tbMatchCfg	= GbWlls:GetMacthTypeCfg(nMatchType);
	if (not tbMatchCfg) then
		return 0;
	end
	
	if (not nSession or not nMapType or not nState) then
		return 0;
	end
	local tbZoneInfo	= ServerEvent:GetMyServerInforByGateway();
	local szTime		= os.date("%Y��%m��", GetTime());
	-- �������Ļ�
	if (nMapType == Wlls.MAP_LINK_TYPE_FACTION) then
		local szMsg = string.format("<color=yellow>%s��%s��ǿ\n\n��������%s%s�վ���<color>����ҿ�ȥ�������������Ϊ��������ף���ɣ�\n\n", tbZoneInfo.ZoneName, tbMatchCfg.szName, szTime, self.DEF_ADV_PK_STARTDAY);
		local nFlagCount = 0;
		for i, tbInfo in pairs(tb8RankInfo.tbInfo) do
			if (tbInfo) then
				local szFaction = Player:GetFactionRouteName(i);
				szMsg = string.format("%s<color=green>%s���ɰ�ǿ������<color>\n", szMsg, szFaction);
				for j, tbLeagueInfo in ipairs(tbInfo) do
					local szInfo = "";
					local tbDetailInfo = tbLeagueInfo.tbInfo;
					local szLeagueName	= tbDetailInfo[GbWlls.DEF_INDEX_GBWLLS_8RANK_LEAGUENAME];
					local nRank 		= tbDetailInfo[GbWlls.DEF_INDEX_GBWLLS_8RANK_RANK];
					local nGateWay 		= tbDetailInfo[GbWlls.DEF_INDEX_GBWLLS_8RANK_GATEWAY];
					local tbGateInfo	= self:GetGateWayInfo(nGateWay);
					local szServerName	= tbGateInfo.ServerName or "";
					local szMemberMsg = "";
					if (tbLeagueInfo.tbList) then
						for k, tbPlayerInfo in ipairs(tbLeagueInfo.tbList) do
							if (k > 1) then
								szMemberMsg = szMemberMsg .. "��";
							end
							szMemberMsg = szMemberMsg .. tbPlayerInfo[1];
						end
					end
					szInfo = string.format("    <color=yellow>%s<color>��<color=orange>%s<color>��  ", szLeagueName, szServerName);
					nFlagCount = nFlagCount + 1;
--					szInfo = string.format("    ���ڷ�������%s��ս������%s���������ɣ�%s��ս�ӳ�Ա��%s�����Σ�%s��\n", szServerName, szLeagueName, szFaction, szMemberMsg, nRank);
					szMsg = szMsg .. szInfo;
					nFlagCount = nFlagCount + 1;
					if (nFlagCount >= 3) then
						szMsg = szMsg .. "\n";
						nFlagCount = 0;						
					end

					if (not tbLeagueInfo.nGuessCount) then
						tbLeagueInfo.nGuessCount = 0;
					end
				end
				szMsg = szMsg .. "\n\n";
			end
		end
		self.tb8RankInfo = tb8RankInfo;
		self:SaveGbWllsGbBuf(self.tb8RankInfo);
		local nKey		= Task.tbHelp.NEWSKEYID.NEWS_GBWLLS_DAILY;
		local szTitle	= string.format("��%s����������ǿ������", Lib:Transfer4LenDigit2CnNum(nSession));
		local nAddTime	= GetTime();
		local nEndTime	= nAddTime + 3600 * 24 * 2;	
		Task.tbHelp:AddDNews(nKey, szTitle, szMsg, nEndTime, nAddTime);
	end
end

function GbWlls:ProcessFinal8Rank(tb8RankInfo)
	if (not tb8RankInfo) then
		return 0;
	end
	local nSession	= tb8RankInfo.nSession;
	local nMapType	= tb8RankInfo.nMapType;
	local nState	= tb8RankInfo.nState;
	
	local nMatchType	= GbWlls:GetMacthType(nSession);
	local tbMatchCfg	= GbWlls:GetMacthTypeCfg(nMatchType);
	if (not tbMatchCfg) then
		return 0;
	end
	
	if (not nSession or not nMapType or not nState) then
		return 0;
	end
	
	-- �������Ļ�
	if (nMapType == Wlls.MAP_LINK_TYPE_FACTION) then
		local szMsg = string.format("<color=yellow>%s����ս��<color>\n", tbMatchCfg.szName);
		local tbRank = {};
		local tbRankResult = {};
		tbRankResult.nSession = nSession;
		tbRankResult.nMapType = nMapType;
		for nFaction, tbInfo in pairs(tb8RankInfo.tbInfo) do
			if (tbInfo) then
				local szFaction = Player:GetFactionRouteName(nFaction);
				szMsg = string.format("%s    <color=green>%s��������������<color>\n", szMsg, szFaction);
				tbRank[nFaction] = {};
				for j, tbLeagueInfo in ipairs(tbInfo) do
					local szInfo = "";
					local tbDetailInfo = tbLeagueInfo.tbInfo;
					local szLeagueName	= tbDetailInfo[GbWlls.DEF_INDEX_GBWLLS_8RANK_LEAGUENAME];
					local nRank 		= tbDetailInfo[GbWlls.DEF_INDEX_GBWLLS_8RANK_RANK];
					local nGateWay 		= tbDetailInfo[GbWlls.DEF_INDEX_GBWLLS_8RANK_GATEWAY];
					local nAdvId		= tbDetailInfo[GbWlls.DEF_INDEX_GBWLLS_8RANK_ADVID];
					local tbGateInfo	= self:GetGateWayInfo(nGateWay);
					local szServerName	= tbGateInfo.ServerName or "";
					local szMemberMsg = "";
					if (tbLeagueInfo.tbList) then
						for k, tbPlayerInfo in ipairs(tbLeagueInfo.tbList) do
							if (k > 1) then
								szMemberMsg = szMemberMsg .. "��";
							end
							szMemberMsg = szMemberMsg .. tbPlayerInfo[1];
						end
					end
					szInfo = string.format("<color=yellow>���Σ�%s  ��������%s  ս������%s  ��Ա��%s��<color>\n", nRank, szServerName, szLeagueName, szMemberMsg);
					szMsg = szMsg .. szInfo;
					if (not tbLeagueInfo.nGuessCount) then
						tbLeagueInfo.nGuessCount = 0;
					end
					tbRank[nFaction][j] = {szLeagueName, nAdvId};
				end
			end
		end
		tbRankResult.tbRank = tbRank;
		self:SendGbWllsFinal_GC(tbRankResult);
		local nKey		= Task.tbHelp.NEWSKEYID.NEWS_GBWLLS_DAILY;
		local szTitle	= string.format("��%s���������ռ�ս��", Lib:Transfer4LenDigit2CnNum(nSession));
		local nAddTime	= GetTime();
		local nEndTime	= nAddTime + 3600 * 24 * 30;	
		Task.tbHelp:AddDNews(nKey, szTitle, szMsg, nEndTime, nAddTime);
	end
end

function GbWlls:SendGbWllsFinal_GC(tbRankResult)
	if (not MODULE_GC_SERVER) then
		return 0;
	end
	if (not tbRankResult or not tbRankResult.nSession) then
		return 0;
	end
	if (not self.tb8RankInfo) then
		print("[Error] SendGbWllsFinal_GC is no tb8RankInfo");
		return 0;
	end
	if (tbRankResult.nMapType == Wlls.MAP_LINK_TYPE_FACTION) then
		for i, tbFaction in pairs(tbRankResult.tbRank) do
			if (self.tb8RankInfo.tbInfo and self.tb8RankInfo.tbInfo[i]) then
				for j, tbInfo in pairs(tbFaction) do
					local szName = tbInfo[1];
					for k, tbLeague in pairs(self.tb8RankInfo.tbInfo[i]) do
						local tbLInfo = tbLeague.tbInfo;
						if (tbLInfo and tbLInfo[1] and tbLInfo[1] == szName and szName ~= "") then
							tbLeague.tbInfo[GbWlls.DEF_INDEX_GBWLLS_8RANK_RANK] = j;
							tbLeague.tbInfo[GbWlls.DEF_INDEX_GBWLLS_8RANK_ADVRANK] = j;
							self.tb8RankInfo.tbInfo[i][k] = tbLeague;
						end
					end
				end
			end
		end
		self:SaveGbWllsGbBuf(self.tb8RankInfo);
	end
	GlobalExcute({"GbWlls:SendGbWllsFinal_GS", tbRankResult});
end

function GbWlls:SendGbWllsFinal_GS(tbRankResult)
	if (not tbRankResult or not tbRankResult.nSession) then
		return 0;
	end
	if (not GbWlls.tb8RankInfo) then
		return 0;
	end
	if (tbRankResult.nMapType == Wlls.MAP_LINK_TYPE_FACTION) then
		for i, tbFaction in pairs(tbRankResult.tbRank) do
			if (self.tb8RankInfo.tbInfo and self.tb8RankInfo.tbInfo[i]) then
				for j, tbInfo in pairs(tbFaction) do
					local szName = tbInfo[1];
					for k, tbLeague in pairs(self.tb8RankInfo.tbInfo[i]) do
						local tbLInfo = tbLeague.tbInfo;
						if (tbLInfo and tbLInfo[1] and tbLInfo[1] == szName and szName ~= "") then
							tbLeague.tbInfo[GbWlls.DEF_INDEX_GBWLLS_8RANK_RANK] = j;
							tbLeague.tbInfo[GbWlls.DEF_INDEX_GBWLLS_8RANK_ADVRANK] = j;
							self.tb8RankInfo.tbInfo[i][k] = tbLeague;
						end
					end
				end
			end
		end
	end
end

function GbWlls:GetGetWay2Num()
	local szGateway = GetGatewayName();
	local nNowGateWay = tonumber(string.sub(szGateway, 5, 8));
	return nNowGateWay;
end

function GbWlls:GetGateWayInfo(nGateWay)
	local szGateway	= tostring(nGateWay);
	local nLen		= string.len(szGateway);
	if (nLen < 4) then
		for i=1, 4 - nLen do
			szGateway = "0"..szGateway;
		end
	end
	szGateway = "gate" .. szGateway;
	return ServerEvent:GetServerInforByGateway(szGateway);
end

function GbWlls:Save8RankInfo()
	if (not MODULE_GC_SERVER) then
		return 0;
	end
	
	if (GbWlls:ServerIsCanJoinGbWlls() ~= 1) then
		return 0;
	end
	
	if (self.IsOpen ~= 1) then
		return 0;
	end
	
--	local nFlagState = GbWlls:GetGblWllsOpenState();
--	if (not nFlagState or nFlagState <= 0) then
--		return 0;
--	end

	if (self:CheckOpenMonth(GetTime()) == 0) then
		return 0;
	end
	
	GbWlls:SaveGbWllsGbBuf(self.tb8RankInfo);
end

function GbWlls:Load8RankInfo()
	if (GbWlls:ServerIsCanJoinGbWlls() ~= 1) then
		return 0;
	end
	
	if (self.IsOpen ~= 1) then
		return 0;
	end
	
--	local nFlagState = GbWlls:GetGblWllsOpenState();
--	if (not nFlagState or nFlagState <= 0) then
--		return 0;
--	end

	if (self:CheckOpenMonth(GetTime()) == 0) then
		return 0;
	end
	
	self.tb8RankInfo = GbWlls:LoadGbWllsGbBuf();

	if (MODULE_GC_SERVER and not GLOBAL_AGENT) then
		if (self.nTime_SaveGbWlls_TimerId and self.nTime_SaveGbWlls_TimerId > 0) then
			Timer:Close(self.nTime_SaveGbWlls_TimerId);
			self.nTime_SaveGbWlls_TimerId = 0;
		end
		self.nTime_SaveGbWlls_TimerId = Timer:Register(self.DEF_TIME_SAVE_GBWLLSBUF * Env.GAME_FPS, self.OnTimer_SaveGbWllsGbBuf, self);	
	end
end

function GbWlls:OnTimer_SaveGbWllsGbBuf()
	if (not MODULE_GC_SERVER or GLOBAL_AGENT) then
		self.nTime_SaveGbWlls_TimerId = 0;
		return 0;
	end

	if (GbWlls:ServerIsCanJoinGbWlls() ~= 1) then
		self.nTime_SaveGbWlls_TimerId = 0;
		return 0;
	end

	if (self:CheckOpenMonth(GetTime()) == 0) then
		self.nTime_SaveGbWlls_TimerId = 0;
		return 0;
	end

	if (self.IsOpen ~= 1) then
		self.nTime_SaveGbWlls_TimerId = 0;
		return 0;
	end
	
	local nFlagState = GbWlls:GetGblWllsOpenState();
	if (not nFlagState or nFlagState <= 0) then
		self.nTime_SaveGbWlls_TimerId = 0;
		return 0;
	end	

	if (self:GetGblWllsState() ~= self.DEF_STATE_ADVMATCH) then
		return;
	end
	
	self:Save8RankInfo();

	return;
end

function GbWlls:LoadGbWllsGbBuf()
	local tbData = GetGblIntBuf(GBLINTBUF_GBWLLS_FINALPLAYERLIST, 0, 1) or {};
	return tbData;
end

function GbWlls:SaveGbWllsGbBuf(tbData)
	SetGblIntBuf(GBLINTBUF_GBWLLS_FINALPLAYERLIST, 0, 1, tbData);
end

function GbWlls:CheckFactionGbWllsGuess(pPlayer, nFaction, nLeagueIndex)
	local bResult = 0;
	if (not pPlayer) then
		return bResult, "ͶƱ�����������ͶƱ";
	end
	local szFaction = "";

	local nResultTaskId = 0;
	local nGuessFaction, nLeagueIdex = GbWlls:GetPlayerGbWllsGuessTask(pPlayer, GbWlls.TASKID_GUESS_PLAYER_FLAG1);
	if (nGuessFaction > 0) then
		local szFaction = Player:GetFactionRouteName(nGuessFaction);
		local nFlag = 0;
		if (nGuessFaction == nFaction and nLeagueIndex == nLeagueIdex) then
			nFlag = 2;
		end
		return nFlag, string.format("���Ѿ�Ͷ��%s���ɰ�ǿ����ˣ�������ͶƱ�ˣ�", szFaction);
	end

	szFaction = Player:GetFactionRouteName(nFaction);
	if (pPlayer.nFaction ~= nFaction) then
		return 0, string.format("��Ŀǰ�����ɲ���%s�����ܸ��������ͶƱ��", szFaction);
	end

	nResultTaskId = GbWlls.TASKID_GUESS_PLAYER_FLAG1;

	return 1, nResultTaskId;
end

function GbWlls:SetPlayerGbWllsGuessTask(pPlayer, nTaskId, nFirstParam, nSecondParam)
	if (not pPlayer) then
		return 0;
	end
	local nFlag = 0;
	nFlag	= KLib.SetByte(0, 1, nFirstParam);
	nFlag	= KLib.SetByte(nFlag, 3, nSecondParam);
	pPlayer.SetTask(GbWlls.TASKID_GROUP, nTaskId, nFlag);
	return 1;
end

function GbWlls:GetPlayerGbWllsGuessTask(pPlayer, nTaskId)
	if (not pPlayer) then
		return;
	end
	local nFirstParam	= 0;
	local nSecondParam	= 0;
	local nTaskValue	= pPlayer.GetTask(GbWlls.TASKID_GROUP, nTaskId);
	nFirstParam		= KLib.GetByte(nTaskValue, 1);
	nSecondParam	= KLib.GetByte(nTaskValue, 3);
	return nFirstParam, nSecondParam;
end

function GbWlls:AddGuess8RankPlayer(szName, nClass, nLeagueIndex, nCount)
	if (not MODULE_GAMESERVER) then
		return 0;
	end
	local tbLeagueInfo = self:Get8RankLeagueInfo(nClass, nLeagueIndex);
	if (not tbLeagueInfo) then
		return 0;
	end
	local szLeagueName = tbLeagueInfo.tbInfo[self.DEF_INDEX_GBWLLS_8RANK_LEAGUENAME];
	GCExcute({"GbWlls:AddGuessTicket_GC", szLeagueName, nCount});
end

function GbWlls:UpdateMaxGuessTicketPlayer(szName)
	if (not szName) then
		return 0;
	end
	local pPlayer = KPlayer.GetPlayerByName(szName);
	if (not pPlayer) then
		return 0;
	end
	local nTotalCount = 0;
	nTotalCount = nTotalCount + GbWlls:GetPlayer8RankGuessTicket(pPlayer, GbWlls.TASKID_GUESS_PLAYER_COUNT1);
	if (nTotalCount <= 0) then
		return 0;
	end
	
	local nCurMaxCount = KGblTask.SCGetDbTaskInt(self.GTASK_MAX_GUESS_TICKET);
	if (nTotalCount > nCurMaxCount) then
		KGblTask.SCSetDbTaskStr(self.GTASK_MAX_GUESS_TICKET, szName);
		KGblTask.SCSetDbTaskInt(self.GTASK_MAX_GUESS_TICKET, nTotalCount);
	end
	return 1;
end

function GbWlls:Get8RankLeagueInfo(nClass, nSmallClass)
	if (not self.tb8RankInfo) then
		return;
	end
	if (not self.tb8RankInfo.nSession) then
		return;
	end
	
	local nMapType = self.tb8RankInfo.nMapType;

	if (nMapType == Wlls.MAP_LINK_TYPE_FACTION) then
		local tbData = self.tb8RankInfo.tbInfo;
		if (not tbData) then
			return;
		end
		
		local tbFaction = tbData[nClass];
		if (not tbFaction) then
			return;
		end
		
		if (not nSmallClass) then
			return tbFaction;
		end
		
		local tbLeagueInfo = tbFaction[nSmallClass];
		return tbLeagueInfo;
	end
	return;
end

function GbWlls:Get8RankGbWllsInfo()
	if (not self.tb8RankInfo) then
		return;
	end
	return self.tb8RankInfo.nSession, self.tb8RankInfo.nMapType, self.tb8RankInfo.nState, self.tb8RankInfo.tbInfo;
end

function GbWlls:GetPlayer8RankGuessTicket(pPlayer, nTaskId)
	if (not pPlayer) then
		return 0;
	end
	return pPlayer.GetTask(GbWlls.TASKID_GROUP, nTaskId);
end

function GbWlls:SetPlayer8RankGuessTicket(pPlayer, nTaskId, nCount)
	if (not pPlayer) then
		return 0;
	end
	pPlayer.SetTask(GbWlls.TASKID_GROUP, nTaskId, nCount);
	return 1;
end

function GbWlls:GetGuessAwardList(pPlayer)
	local tbAward = {};

	local tbOneAward = GbWlls:GetGuessAwardTable(pPlayer, self.TASKID_GUESS_PLAYER_FLAG1, self.TASKID_GUESS_PLAYER_COUNT1);
	if (tbOneAward) then
		table.insert(tbAward, tbOneAward);
	end

	return tbAward;
end

function GbWlls:GetGuessAwardTable(pPlayer, nTaskId, nCountTaskId)
	local tbAward = nil;
	local nClass, nLeagueIdex = GbWlls:GetPlayerGbWllsGuessTask(pPlayer, nTaskId);
	if (nClass > 0) then
		tbAward = {
			nClass		= nClass,
			nIndex		= nLeagueIdex,
			nMyCount	= self:GetPlayer8RankGuessTicket(pPlayer, nCountTaskId),
			nTaskFlagId	= nTaskId,
		};
	end
	return tbAward;
end

function GbWlls:GetTotalTicket(nClass, nIndex)
	if (not self.tb8RankInfo) then
		return 0;
	end
	if (not self.tb8RankInfo.nSession) then
		return 0;
	end
	
	local nMapType = self.tb8RankInfo.nMapType;

	if (nMapType == Wlls.MAP_LINK_TYPE_FACTION) then
		if (not self.tb8RankInfo.tbInfo) then
			return 0;
		end
		local tbFaction = self.tb8RankInfo.tbInfo[nClass];
		if (not tbFaction) then
			return 0;
		end
		local nCount = 0;
		for i, tbLeague in pairs(tbFaction) do
			nCount = nCount + tbLeague.nGuessCount or 0;
		end
		return nCount;
	end
	return 0;
end

function GbWlls:Clear8RankTaskValue(pPlayer)
	if (not pPlayer) then
		return 0;
	end
	self:WriteLog("Clear8RankTaskValue", pPlayer.szName, "Clear All Ticket Value");
	self:SetPlayerGbWllsGuessTask(pPlayer, self.TASKID_GUESS_PLAYER_FLAG1, 0, 0);
	self:SetPlayer8RankGuessTicket(pPlayer, self.TASKID_GUESS_PLAYER_COUNT1, 0);
end

function GbWlls:ClearOld8RankInfo_GB()
	if (not GLOBAL_AGENT) then
		return 0;
	end
	self.tb8RankInfo = {};
	self:SaveGbWllsGbBuf(self.tb8RankInfo);
	GC_AllExcute({"GbWlls:ClearOld8RankInfo_GC"});
end

function GbWlls:ClearOld8RankInfo_GC()
	if (not MODULE_GC_SERVER) then
		return 0;
	end
	self.tb8RankInfo = {};
	self:SaveGbWllsGbBuf(self.tb8RankInfo);
	GlobalExcute({"GbWlls:ClearOld8RankInfo_GS"});
end

function GbWlls:ClearOld8RankInfo_GS()
	self.tb8RankInfo = {};
end

function GbWlls:ResetPlayer8RankGuessCount(pPlayer)
	if (not pPlayer) then
		return 0;
	end
	local nLastGuessSession = pPlayer.GetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_GUESS_SESSION);
	local nNowSession		= GbWlls:GetGblWllsOpenState();
	if (nLastGuessSession == nNowSession) then
		return 0;
	end
	GbWlls:Clear8RankTaskValue(pPlayer)
	pPlayer.SetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_GUESS_SESSION, nNowSession);
	return 1;
end

function GbWlls:SendSystemMsg()
	if (not self.nTimeMsg_Count) then
		return 0;
	end
	if (self.nTimeMsg_Count > self.DEF_TIME_MSG_MAX_COUNT) then
		return 0;
	end
	
	if (GbWlls:ServerIsCanJoinGbWlls() ~= 1) then
		return 0;
	end
	
	if (self.IsOpen ~= 1) then
		return 0;
	end
	
	local nFlagState = GbWlls:GetGblWllsOpenState();
	if (not nFlagState or nFlagState <= 0) then
		return 0;
	end
	
	local nNowTime	= GetTime();
	local tbTime	= os.date("*t", nNowTime);

	local nStarTime	= KGblTask.SCGetDbTaskInt(GbWlls.GTASK_STARSERVERFLAG_TIME);
	local nNowDay	= Lib:GetLocalDay(nNowTime);
	local nStarDay	= Lib:GetLocalDay(nStarTime);
	local nOpenFlag = 0;
	local nDetDay	= nNowDay - nStarDay;
	if (nDetDay < 0) then
		nDetDay = 0;
	end
	
	local nMatchType	= self:GetMacthType(nFlagState);
	local tbMatchCfg	= self:GetMacthTypeCfg(nMatchType);
	local nMatchState	= GbWlls:GetGblWllsState();	
	
	if (self.DEF_STATE_REST == nMatchState and nStarTime > 0) then
		if (nDetDay >= 0 and nDetDay <= GbWlls.DEF_DAY_STARSERVER_1) then
			local nStarFlag = KGblTask.SCGetDbTaskInt(GbWlls.GTASK_STARSERVERFLAG);
			if (nStarFlag > 0) then
				local szZoneName = GbWlls:GetZoneNameAndServerName();
				local szMsg = string.format(GbWlls.MSG_MATCH_TIME_GLOBALMSG_STAR, Lib:Transfer4LenDigit2CnNum(nFlagState - 1), szZoneName);
				Dialog:GlobalMsg2SubWorld_GC(szMsg);
				self.nTimeMsg_Count = self.nTimeMsg_Count + 1;
				return;
			end
		end	
	end	

	if (self:CheckOpenMonth(nNowTime) == 0) then
		return 0;
	end

	if (self.DEF_STATE_MATCH == nMatchState) then
		local szMsg = string.format(GbWlls.MSG_MATCH_TIME_GLOBALMSG_COMMON, Lib:Transfer4LenDigit2CnNum(nFlagState), tbMatchCfg.szName, tbTime.month);
		Dialog:GlobalMsg2SubWorld_GC(szMsg);
	elseif (self.DEF_STATE_ADVMATCH == nMatchState) then
		local szMsg = string.format(GbWlls.MSG_MATCH_TIME_GLOBALMSG_ADV, Lib:Transfer4LenDigit2CnNum(nFlagState), GbWlls.DEF_ADV_PK_STARTDAY);
		Dialog:GlobalMsg2SubWorld_GC(szMsg);
	end
	self.nTimeMsg_Count = self.nTimeMsg_Count + 1;
	return;
end

function GbWlls:OnTimer_SendSystem_Msg()
	self.nTimeMsg_Count = 0;

	if (GbWlls:ServerIsCanJoinGbWlls() ~= 1) then
		return 0;
	end

	if (self.IsOpen ~= 1) then
		return 0;
	end

	local nFlagState = GbWlls:GetGblWllsOpenState();
	if (not nFlagState or nFlagState <= 0) then
		return 0;
	end

	self.nTimeMsg_TimerId = Timer:Register(self.DEF_TIME_MSG_TIME * Env.GAME_FPS, self.SendSystemMsg, self);
end

function GbWlls:StatLog_Statuary()
	local tbStatuary = Domain.tbStatuary.tbStatuData;
	for i, tbInfo in pairs(tbStatuary) do
		local tbPlayer = tbInfo.tbPlayerInfo;
		if (tbPlayer) then
			local szName	= tbPlayerInfo[Domain.tbStatuary.INFOID_PLAYERNAME];
			local nRevere	= tbPlayerInfo[Domain.tbStatuary.INFOID_REVERE];
			local nEndure	= tbPlayerInfo[Domain.tbStatuary.INFOID_ENDURE];
			local nAddTime	= tbPlayerInfo[Domain.tbStatuary.INFOID_ADDTIME];
			local nType		= tbPlayerInfo[Domain.tbStatuary.INFOID_EVENTTYPE];
			if (szName and szName ~= "" and nType >= 2000 and nType < 3000) then
				Dbg:WriteLogEx(Dbg.LOG_INFO, "GbWlls_Statuary_Info", szName, nRevere, nEndure, nAddTime, nType);
			end
		end		
	end
end

function GbWlls:Stat_GbWllsPlayer8League(nType)
	local tbLadder = GetShowLadder(Ladder:GetType(0, 3, 5, 0));
	if not tbLadder then
	    return -1;
	end
	local szMsg="";
	for i, tbPlayer in ipairs(tbLadder) do
	    if (i > 4) then
	        break;
	    end
	    local szLName=tbPlayer.szName;
	    local tbContext = Lib:SplitStr(tbPlayer.szContext, "\n");
	    szMsg = szMsg..i..":"..szLName;
	    for _, szStr1 in ipairs(tbContext) do
	        local tbText = Lib:SplitStr(szStr1, "|");
	        if (tbText and tbText[1]) then
	            szMsg = szMsg.."\t"..tbText[1];
	        end
	    end
	    szMsg = szMsg.."\n"
	end
	return szMsg;
end

function GbWlls:CheckStarServer()
	local nStarFlag = KGblTask.SCGetDbTaskInt(GbWlls.GTASK_STARSERVERFLAG);
	if (nStarFlag <= 0) then
		return 0;
	end
	local nStarTime	= KGblTask.SCGetDbTaskInt(GbWlls.GTASK_STARSERVERFLAG_TIME);
	local nNowTime	= GetTime();
	local tbTime	= os.date("*t", nNowTime);
	local nNowDay	= Lib:GetLocalDay(nNowTime);
	local nStarDay	= Lib:GetLocalDay(nStarTime);
	local nOpenFlag = 0;
	local nDetDay	= nNowDay - nStarDay;
	if (nDetDay <= 0) then
		return 0;
	end
	local nLastDay	= -1;
	if (1 == nStarFlag or 2 == nStarFlag) then
		nLastDay = GbWlls.DEF_DAY_STARSERVER_1;
	elseif (3 == nStarFlag) then
		nLastDay = GbWlls.DEF_DAY_STARSERVER_3;
	elseif (4 == nStarFlag) then
		nLastDay = GbWlls.DEF_DAY_STARSERVER_4;
	end
	
	if (nDetDay > nLastDay) then
		return 0;
	end
	return 1;
end

-- ��ȫ�ַ��������ͱ���ͶƱ���
function GbWlls:Send8RankTickets()
	if (not MODULE_GC_SERVER) then
		return 0;
	end
	
	if (GLOBAL_AGENT) then
		return 0;
	end

	if (GbWlls:ServerIsCanJoinGbWlls() ~= 1) then
		return 0;
	end

	if (self.IsOpen ~= 1) then
		return 0;
	end

	local nFlagState = GbWlls:GetGblWllsOpenState();
	if (not nFlagState or nFlagState <= 0) then
		return 0;
	end
	
	if (not self.tb8RankInfo) then
		return 0;
	end
	
	local nMapType	= self.tb8RankInfo.nMapType;
	local nSession	= self.tb8RankInfo.nSession;
	if (not nMapType or not nSession or nSession <= 0) then
		return 0;
	end

	if (nSession ~= nFlagState) then
		return 0;
	end
	
	if (Wlls.MAP_LINK_TYPE_FACTION == nMapType) then
		local tbSendInfo = {};
		local tbTickets = {};
		local szGateWay = GetGatewayName();
		for nFaction, tbFaction in pairs(self.tb8RankInfo.tbInfo) do
			if (not tbTickets[nFaction]) then
				tbTickets[nFaction] = {};
			end
			for nRank, tbTeamInfo in pairs(tbFaction) do
				if (tbTeamInfo.tbInfo) then
					local szLeagueName	= tbTeamInfo.tbInfo[self.DEF_INDEX_GBWLLS_8RANK_LEAGUENAME];
					local nTotalCount	= tbTeamInfo.nGuessCount or 0;
					tbTickets[nFaction][nRank] = {szLName = szLeagueName, nTickets = nTotalCount};
					self:WriteLog("Send8RankTickets", szLeagueName, nTotalCount, szGateWay);
				end
			end
		end
		tbSendInfo = { 
			nMapType = nMapType, 
			nSession = nSession, 
			tbTickets = tbTickets 
		};
		GC_AllExcute({"GbWlls:Recv8RankTickets_GB", tbSendInfo, szGateWay})
	end
end

-- ���ո���������Ʊ��
function GbWlls:Recv8RankTickets_GB(tbRecvInfo, szGateWay)
	if (not GLOBAL_AGENT) then
		return 0;
	end
	
	if (not tbRecvInfo) then
		return 0;
	end
	
	local nSession = tbRecvInfo.nSession;
	local nMapType = tbRecvInfo.nMapType;
	local tbTickets = tbRecvInfo.tbTickets;
	
	if (not nSession or not nMapType or not tbTickets) then
		return 0;
	end
	
	local nFlagState = GbWlls:GetGblWllsOpenState();
	if (not nFlagState or nFlagState <= 0) then
		return 0;
	end
	
	if (nSession ~= nFlagState) then
		return 0;
	end
	
	if (not self.tbTicketInfo) then
		self.tbTicketInfo = {};
		self.tbTicketInfo.nSession = nSession;
		self.tbTicketInfo.nMapType = nMapType;
		self.tbTicketInfo.tbTickets	= {};
	else
		local nTbSession = self.tbTicketInfo.nSession;
		if (not nTbSession or nTbSession ~= nSession) then
			self.tbTicketInfo = {};
			self.tbTicketInfo.nSession = nSession;
			self.tbTicketInfo.nMapType = nMapType;
			self.tbTicketInfo.tbTickets	= {};
		end
	end
	
	if (Wlls.MAP_LINK_TYPE_FACTION == nMapType) then
		if (not self.tbTicketInfo.tbTickets) then
			self.tbTicketInfo.tbTickets = {};
		end
		for nFaction, tbFaction in pairs(tbTickets) do
			if (not self.tbTicketInfo.tbTickets[nFaction]) then
				self.tbTicketInfo.tbTickets[nFaction] = {};
			end
			local tbFac = self.tbTicketInfo.tbTickets[nFaction];
			for nRank, tbInfo in pairs(tbFaction) do
				if (tbInfo.szLName and tbInfo.szLName ~= "") then
					if (not tbFac[tbInfo.szLName]) then
						tbFac[tbInfo.szLName] = 0;
					end
					tbFac[tbInfo.szLName] = tbFac[tbInfo.szLName] + tbInfo.nTickets;
					self:WriteLog("Recv8RankTickets_GB", tbInfo.szLName, tbFac[tbInfo.szLName], tbInfo.nTickets, szGateWay);
				end
			end
			self.tbTicketInfo.tbTickets[nFaction] = tbFac;
		end
	end
end

local function _OnTicketSort(tbA, tbB)
	return tbA[2] > tbB[2];
end

function GbWlls:ProcessMoreTicketPlayer()
	if (not GLOBAL_AGENT) then
		return 0;
	end
	
	if (not self.tbTicketInfo) then
		return 0;
	end
	
	local nSession	= self.tbTicketInfo.nSession;
	local nMapType	= self.tbTicketInfo.nMapType;
	local tbTickets	= self.tbTicketInfo.tbTickets

	if (not nSession or not nMapType or not tbTickets) then
		return 0;
	end
	
	local nFlagState = GbWlls:GetGblWllsOpenState();
	if (not nFlagState or nFlagState <= 0) then
		return 0;
	end
	
	if (nSession ~= nFlagState) then
		return 0;
	end
	
	if (Wlls.MAP_LINK_TYPE_FACTION == nMapType) then
		local tbMoreTicketPlayer = {};
		for nFaction, tbFaction in pairs(tbTickets) do
			local tbList = {};
			for szName, nTickets in pairs(tbFaction) do
				if (szName and szName ~= "") then
					tbList[#tbList + 1] = {szName, nTickets};
				end
			end
			table.sort(tbList, _OnTicketSort);
			if (tbList[1] and tbList[1][1]) then
				local tbStar = {};
				local szFirstName = tbList[1][1];
				local nTickets = tbList[1][2];
				for _, tbInfo in ipairs(tbList) do
					if (nTickets ~= tbInfo[2]) then
						break;
					end
					if (tbInfo[2] > 0) then
						self:GiveMoreTicketTitleFlag(tbInfo[1]);
					end
				end
			end
		end
	end
end

function GbWlls:GiveMoreTicketTitleFlag(szLeagueName)
	if (not GLOBAL_AGENT) then
		return 0;
	end
	if (not szLeagueName) then
		return 0;
	end
	
	local nGateWay	= League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_GATEWAY);
	local nSession	= League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MSESSION);
	local tbMember	= League:GetMemberList(Wlls.LGTYPE, szLeagueName);
	if (not tbMember) then
		return 0;
	end

	local tbGateInfo	= self:GetGateWayInfo(nGateWay);
	local szZoneName	= "";
	if (tbGateInfo) then
		szZoneName	= tbGateInfo.ZoneName or "";
	end

	for _, szName in pairs(tbMember) do
		local szMsg = string.format(GbWlls.MSG_STARPLAYER, szName, szZoneName);
		self:SetPlayerSportTask(szName, GbWlls.GBTASKID_MATCH_DAILY_RESULT, nSession);
		self:WriteLog("GiveMoreTicketTitleFlag", szLeagueName, szName, szZoneName);
		Dialog:GlobalMsg2SubWorld_Center(szMsg);
	end
end

function GbWlls:_GetPlayerGbWllsInfo(szName)
	if (not szName) then
		return 0;
	end
	local szMsg="";
	for i=1,6 do
		szMsg = szMsg .. GbWlls:GetPlayerSportTask(szName, 2, i) .. ",";
	end
	return szMsg;	
end

if (MODULE_GAMESERVER) then
	PlayerEvent:RegisterGlobal("OnLogin", GbWlls.OnLogin, GbWlls);
	ServerEvent:RegisterServerStartFunc(GbWlls.Load8RankInfo, GbWlls);
end

if (MODULE_GC_SERVER) then
	GCEvent:RegisterGCServerShutDownFunc(GbWlls.Save8RankInfo, GbWlls);
	GCEvent:RegisterGCServerStartFunc(GbWlls.Load8RankInfo, GbWlls);
end
