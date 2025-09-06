-------------------------------------------------------
-- �ļ�������wldh_battle_camp.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-08-24 16:51:51
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle_def.lua");

local tbCampBase = Wldh.Battle.tbCampBase or {};	-- ֧������
Wldh.Battle.tbCampBase = tbCampBase;

-- �����ʼ��
function tbCampBase:init(nCampId, tbMapCampData, szLeagueName, tbMission)

	self.nCampId	= nCampId;
	self.tbMapData	= tbMapCampData;
	self.tbMission	= tbMission;

	self.szCampName		= Wldh.Battle.NAME_CAMP[nCampId];
	self.nDbTskId_PlCnt	= Wldh.Battle.DBTASKID_PLAYER_COUNT[tbMission.nBattleIndex][nCampId];
	self.szLeagueName 	= szLeagueName;
	self.nBouns			= 0;
	self.tbBTSaveData	= {};
	self:SetPlayerCount(0);

	self:AddDialogNpc("Npc_chuwuxiang", Wldh.Battle.NPCID_WUPINBAOGUANYUAN);
	self:AddDialogNpc("Npc_junyiguan", Wldh.Battle.NPCID_HOUYINGJUNYIGUAN);
	self:AddDialogNpc("Npc_chefu", Wldh.Battle.NPCID_CHEFU);
end

-- ������ʼ
function tbCampBase:OnStart()
	local tbPlayerList = self.tbMission:GetPlayerList(self.nCampId);
	for _, pPlayer in pairs(tbPlayerList) do
		pPlayer.SetTask(Wldh.Battle.TASK_GROUP_ID, Wldh.Battle.TASKID_PLAYER_KEY, self.tbMission.nBattleKey);
		pPlayer.SetTask(Wldh.Battle.TASK_GROUP_ID, Wldh.Battle.TASKID_CAMP, self.nCampId);
	end
end

-- ������������������Ӫ������
function tbCampBase:OnEnd(nResult)	
	
	-- ����ʤ����Ϣ
	local tbPlayerList = self.tbMission:GetPlayerList(self.nCampId);
	local szMsg	= string.format(Wldh.Battle.MSG_CAMP_RESULT[nResult], self.tbMission:GetFullName(), self.szCampName);
	
	for _, pPlayer in pairs(tbPlayerList) do
		Dialog:SendInfoBoardMsg(pPlayer, szMsg);
		local tbBattleInfo = Wldh.Battle:GetPlayerData(pPlayer);
		pPlayer.Msg(string.format("����������ǣ�<color=green>%d<color>, ��õĻ����ǣ�<color=yellow>%d<color>", tbBattleInfo.nListRank, tbBattleInfo.nBouns));
	end
end

-- ��������Ҽ���
function tbCampBase:OnJoin(pPlayer)
	
	-- ��������
	self:SetPlayerCount(self.nPlayerCount + 1);
	
	local tbBattleInfo = self:FindBTData(pPlayer);
	if not tbBattleInfo then
		tbBattleInfo = Lib:NewClass(Wldh.Battle.tbPlayerBase, pPlayer, self);
	else
		tbBattleInfo.pPlayer = pPlayer;	
	end

	-- �غ�Ӫʱ��
	tbBattleInfo.nBackTime	= GetTime();
	
	-- ְҵ
	tbBattleInfo.szFacName	= Player:GetFactionRouteName(pPlayer.nFaction, pPlayer.nRouteId);

	pPlayer.GetTempTable("Wldh").tbPlayerBattleInfo = tbBattleInfo;
	
	-- ͷ��
	tbBattleInfo.pPlayer.AddTitle(2, self.nCampId, tbBattleInfo.nRank, 0);	
	
	-- ��ʾʱ��
	if 2 == self.tbMission.nState then
		local nRemainFrame	= self.tbMission:GetStateLastTime(self.tbMission.nState);
		tbBattleInfo:SetRightBattleInfo(nRemainFrame);
	else
		tbBattleInfo:DeleteRightBattleInfo();
	end
end

-- ����������뿪
function tbCampBase:OnLeave(pPlayer)
	
	self:SetPlayerCount(self.nPlayerCount - 1);
	self:SaveBTData(pPlayer);
	
	pPlayer.RemoveSkillState(Wldh.Battle.SKILL_DAMAGEDEFENCE_ID);
	local tbBattleInfo = Wldh.Battle:GetPlayerData(pPlayer);
	
	if tbBattleInfo then
		
		-- �ر�ս����Ϣ��ʾ
		tbBattleInfo:DeleteRightBattleInfo();
		
		-- ȥ��ͷ��
		tbBattleInfo.pPlayer.RemoveTitle(2, self.nCampId, tbBattleInfo.nRank, 0);
	end
end

-- ��������ұ��Է����ɱ
function tbCampBase:OnPlayerDeath(tbDeathBattleInfo)
	tbDeathBattleInfo.nSeriesKill		= 0;
	tbDeathBattleInfo.nSeriesKillNum	= 0;
	tbDeathBattleInfo.nBackTime			= GetTime();	-- ��1970��1��1��0ʱ���������
	DeRobot:OnMissionDeath(tbDeathBattleInfo);
end

-- ���������ɱ���Է����
function tbCampBase:OnKillPlayer(tbKillerBattleInfo, tbDeathBattleInfo)
	Wldh.Battle:GiveKillerBouns(tbKillerBattleInfo, tbDeathBattleInfo);
	Wldh.Battle:ProcessSeriesBouns(tbKillerBattleInfo, tbDeathBattleInfo);
end

-- ������Ӫ����
function tbCampBase:SetPlayerCount(nPlayerCount)
	self.nPlayerCount = nPlayerCount;
	KGblTask.SCSetTmpTaskInt(self.nDbTskId_PlCnt, nPlayerCount + 1);	-- ��������+1����
end

-- �����Ӫ����
function tbCampBase:GetPlayerCount()
	return self.nPlayerCount;
end

-- ����
function tbCampBase:TransTo(pPlayer, szPosName)
	local tbPos	= self:GetMapPos(szPosName);
	pPlayer.NewWorld(unpack(tbPos));
end

-- ��������
function tbCampBase:GetMapPos(szPosName)
	local tbPoss = self.tbMapData[szPosName];
	local nRand	= MathRandom(#tbPoss);
	return tbPoss[nRand];
end

-- ���ӶԻ�NPC
function tbCampBase:AddDialogNpc(szPosName, nNpcId)
	for _, tbPos in pairs(self.tbMapData[szPosName]) do
		KNpc.Add2(nNpcId, 1, 0, tbPos[1], tbPos[2], tbPos[3]);
	end
end

-- �������ս����Ϣ
function tbCampBase:SaveBTData(pPlayer)
	
	local tbPLInfo = {};
	
	tbPLInfo.nPLId= pPlayer.nId;
	tbPLInfo.tbPlayerBattleInfo	= Wldh.Battle:GetPlayerData(pPlayer);
	
	if not tbPLInfo.tbPlayerBattleInfo then
		return;
	end
	
	self.tbBTSaveData[#self.tbBTSaveData + 1] = tbPLInfo;
	tbPLInfo.pPlayer = nil;
end

-- �������ս����Ϣ
function tbCampBase:FindBTData(pPlayer)
	
	local tbPlayerBattleInfo = nil;
	local nId = pPlayer.nId;
	local nDelId = 0;
	
	for nKey, tbPLInfo in pairs(self.tbBTSaveData) do
		if tbPLInfo.nPLId == nId then
			nDelId = nKey;
			tbPlayerBattleInfo = tbPLInfo.tbPlayerBattleInfo; 
			break;
		end
	end
	
	if 0 ~= nDelId then
		table.remove(self.tbBTSaveData, nDelId);
	end	
	return tbPlayerBattleInfo;
end

-- Ϊ����������Ҽӻ���
function tbCampBase:AddCampBouns(nAddBouns)
	
	local tbPlayerInfoList = self.tbMission:GetPlayerInfoList(self.nCampId);
	
	-- ��Ӫ��������
	for _, tbBattleInfo in pairs(tbPlayerInfoList) do
		tbBattleInfo:AddBounsWithoutCamp(nAddBouns);
	end
end
