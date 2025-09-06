-------------------------------------------------------
-- �ļ�������wldh_battle_mission.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-08-24 09:46:53
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle_def.lua");

local tbMissionBase = Wldh.Battle.tbMissionBase or Mission:New();
Wldh.Battle.tbMissionBase = tbMissionBase;

-- ��ǰս��״̬��
--	0��ս��δ����
--	1��ս�۱�����
--	2��ս��ս��������
--	3��ս�۸ոս�����
tbMissionBase.nState = nil;	
						
-- �����ʼ��
-- �ڼ�������ͼid����ͼ���ݣ�ʱ�䣬��ս��������ս����
function tbMissionBase:init(nBattleIndex, nMapId, tbMapData, szBattleTime, szLeagueNameSong, szLeagueNameJin, nFinalStep)

	assert(self ~= Battle.tbMissionBase);
	assert(not self.nState);
	
	-- δ��ʼ
	self:_SetState(0);

	self.nBattleIndex		= nBattleIndex;  		-- �ڼ�������
	self.nMapId				= nMapId;				-- ��ͼID	
	self.tbMapData 			= tbMapData;			-- ��ͼ����
	self.nFinalStep			= nFinalStep;			-- ������־(1-�����,2-����)
	
	self.tbLeagueName =
	{
		[Wldh.Battle.CAMPID_SONG] = szLeagueNameSong,
		[Wldh.Battle.CAMPID_JIN] = szLeagueNameJin,		
	};
		
	self.szBattleName		= tbMapData.szMapName;	-- ����
	self.nRuleType 			= 4;					-- ģʽ����
	self.tbPlayerJoin		= {} 					-- �μӹ�����ҵ�ID��
	self.nBattleKey			= tonumber(szBattleTime .. nBattleIndex);	-- ��ȫ�����

	-- ָ������
	local tbMapDataSong	= tbMapData[1];
	local tbMapDataJin = tbMapData[3];

	-- ˫����Ӫ
	local tbCampSong = Lib:NewClass(Wldh.Battle.tbCampBase, Wldh.Battle.CAMPID_SONG, tbMapDataSong, szLeagueNameSong, self);
	local tbCampJin	= Lib:NewClass(Wldh.Battle.tbCampBase, Wldh.Battle.CAMPID_JIN, tbMapDataJin, szLeagueNameJin, self);
	
	-- ������Ӫ
	tbCampSong.tbOppCamp = tbCampJin;
	tbCampJin.tbOppCamp = tbCampSong;
	
	self.tbCamps = 
	{
		[Wldh.Battle.CAMPID_SONG] = tbCampSong,
		[Wldh.Battle.CAMPID_JIN] = tbCampJin,
	};
	
	self.tbCampSong	= tbCampSong;
	self.tbCampJin = tbCampJin;
	
	-- ��������
	self.tbRule	= Lib:NewClass(Wldh.Battle.tbRuleBases[self.nRuleType]);
	self.tbRule:Init(self);

	-- ��ͼ���ƣ�Trap���¼���
	local tbMapCamp	= 
	{
		[1]	= tbCampSong,
		[3]	= tbCampJin,
	};
	
	-- ���뵽map����**��֪����ɶ��
	local tbMapClass = Lib:NewClass(Wldh.Battle.tbMapBase, tbMapCamp);
	Map.tbClass[nMapId]	= tbMapClass;
	
	-- ��Ӫ�����
	local tbBaseCampPos	= 
	{
		[Wldh.Battle.CAMPID_SONG]	= tbMapDataSong["BaseCamp"],
		[Wldh.Battle.CAMPID_JIN]	= tbMapDataJin["BaseCamp"],
	};

	local tbSongIcon 	= {"\\image\\ui\\001a\\main\\chatchanel\\chanel_song.spr", 	"\\image\\ui\\001a\\main\\chatchanel\\btn_chanel_song.spr"};
	local tbKingIcon	= {"\\image\\ui\\001a\\main\\chatchanel\\chanel_jin.spr",	"\\image\\ui\\001a\\main\\chatchanel\\btn_chanel_jin.spr"};
	local tbChannel		=
	{
		[Wldh.Battle.CAMPID_SONG]	= {string.format("�η�����%d", nBattleIndex), 20, tbSongIcon[1], tbSongIcon[2]},
		[Wldh.Battle.CAMPID_JIN]	= {string.format("������%d", nBattleIndex), 20, tbKingIcon[1], tbKingIcon[2]},
	};
	
	-- �趨Mission��ѡ������
	self.tbMisCfg	= 
	{
		tbLeavePos		= Wldh.Battle.tbSignUpInfo[nMapId],	-- �뿪����
		tbEnterPos		= tbBaseCampPos,					-- ��������
		tbDeathRevPos	= tbBaseCampPos,					-- ����������
		tbChannel		= tbChannel,						-- ����Ƶ��
		tbCamp			= Wldh.Battle.NPC_CAMP_MAP,			-- �ֱ��趨��ʱ��Ӫ
		nForbidTeam		= 0,								-- ��ֹ��ӻ�ɫ
		nInBattleState	= 1,								-- ��ֹ��ͬ��Ӫ���
		nPkState		= Player.emKPK_STATE_CAMP,			-- PK״̬
		nDeathPunish	= 1,								-- �������ͷ�
		nOnDeath		= 1,								-- ������������ص�
		nOnMovement		= 1,								-- �μ�ĳ��
		nForbidSwitchFaction = 1,							-- ��ֹ�л�����
		nForbidStall	= 1,								-- ��ֹ��̯
		nDisableOffer	= 1,								-- ��ֹ...δ֪
		nDisableFriendPlane = 1,							-- ��ֹ���ѽ���
		nDisableStallPlane	= 1,							-- ��ֹ���׽���
	};
	
	self.tbMisEventList = 
	{
		{1, Wldh.Battle.TIMER_SIGNUP, "OnTimer_SignupEnd"},
		{2, Wldh.Battle.TIMER_GAME, "OnTimer_GameEnd"},
	};
	
	self.nStateJour = 0;
	self.tbNowStateTimer = nil;
end

-- mission����
function tbMissionBase:OnOpen()
	
	self:_SetState(1, 0);
	self:GoNextState();

	self:CreateTimer(Wldh.Battle.TIMER_SIGNUP_MSG, self.OnTimer_SignupMsg, self);
	self:CreateTimer(Wldh.Battle.TIMER_SYNCDATA, self.OnTimer_SyncData, self);
	
	self.nGameSyncCount	= math.floor((Wldh.Battle.TIMER_GAME + Wldh.Battle.TIMER_SIGNUP) / Wldh.Battle.TIMER_SYNCDATA);
	self.nSignUpMsgCount = math.floor(Wldh.Battle.TIMER_SIGNUP / Wldh.Battle.TIMER_SIGNUP_MSG);
end

-- �ر�mission
function tbMissionBase:OnClose()
	
	self.tbRule:OnClose();

	if 2 ~= self.nState then	-- ��������������������δ��ս�ͽ���
		self:_SetState(3);
	else
		self:_SetState(3, 2);
		
		local nWinCampId	= self.tbRule:GetWinCamp();		
		local nSongResult	= nil;
		local nJinResult	= nil;
		
		
		-- ����ʤ�����
		if nWinCampId == Wldh.Battle.CAMPID_SONG then
			nSongResult	= Wldh.Battle.RESULT_WIN;
			nJinResult = Wldh.Battle.RESULT_LOSE;
		
		elseif nWinCampId == Wldh.Battle.CAMPID_JIN then
			nSongResult	= Wldh.Battle.RESULT_LOSE;
			nJinResult = Wldh.Battle.RESULT_WIN;
		
		else
			nSongResult	= Wldh.Battle.RESULT_TIE;
			nJinResult = Wldh.Battle.RESULT_TIE;
		end
	
		self.tbCampSong:OnEnd(nSongResult);
		self.tbCampJin:OnEnd(nJinResult);	

		-- ���ؽ��
		local tbResult = 
		{
			[1] = {self.tbLeagueName[1], nSongResult},
			[2] = {self.tbLeagueName[2], nJinResult},
		};

		if self.nFinalStep then
			Wldh.Battle:FinalEnd_GS(self.nBattleIndex, tbResult, self.nFinalStep);
		else
			Wldh.Battle:RoundEnd_GS(self.nBattleIndex, tbResult);
		end
	end
	
	-- ��Ǳ�������
	self.tbCampSong:SetPlayerCount(-1);
	self.tbCampJin:SetPlayerCount(-1);

	Wldh.Battle.tbMissions[self.nBattleIndex] = nil;
end
	
-- ����Mission
function tbMissionBase:OnJoin(nGroupId)
	
	local tbCamp = self.tbCamps[nGroupId];
	local pPlayer = me;
	
	-- ������Ӫ
	tbCamp:OnJoin(pPlayer);
	
	-- ���
	pPlayer.TeamApplyLeave();
	
	-- add ��ֹ��ɱ
	pPlayer.ForbidEnmity(1);
	pPlayer.ForbidExercise(1);		
	
	if self.tbPlayerJoin[pPlayer.nId] == nil then
		self.tbPlayerJoin[pPlayer.nId] = 1;
	end
	
	-- �μӴ�����1
	local nAttend = GetPlayerSportTask(pPlayer.nId, Wldh.GBTASKID_GROUP, Wldh.GBTASKID_BATTLE_ATTEND_ID) or 0;
	
	nAttend = nAttend + 1;
	if nAttend > Wldh.Battle.MAX_MATCH then
		nAttend = Wldh.Battle.MAX_MATCH;
	end
	
	SetPlayerSportTask(pPlayer.nId, Wldh.GBTASKID_GROUP, Wldh.GBTASKID_BATTLE_ATTEND_ID, nAttend);
	
	-- �����
	DeRobot:OnMissionJoin(pPlayer);
end

-- ����뿪ǰ
function tbMissionBase:BeforeLeave(nGroupId)
	local pPlayer = me;
	self.tbRule:OnLeave(pPlayer);
end

-- ����뿪ս��
function tbMissionBase:OnLeave(nGroupId)
	
	local pPlayer = me;
	
	self.tbCamps[nGroupId]:OnLeave(pPlayer);

	pPlayer.TeamApplyLeave();
	pPlayer.SetFightState(0);
	
	pPlayer.ForbidEnmity(0);
	pPlayer.ForbidExercise(0);		
	
	DeRobot:OnMissionLeave(pPlayer)
end

-- ��������
function tbMissionBase:OnDeath(pKillerNpc) 
	
	local pPlayer = me;
	local nGroupId = self:GetPlayerGroupId(pPlayer);
	
	self.tbRule:OnLeave(pPlayer);
	
	local tbDeathBattleInfo	= Wldh.Battle:GetPlayerData(pPlayer);
	self.tbCamps[nGroupId]:OnPlayerDeath(tbDeathBattleInfo);
	
	local pKillerPlayer = pKillerNpc.GetPlayer();
	if pKillerPlayer then
		
		local nKillerGroupId = self:GetPlayerGroupId(pKillerPlayer);
		if nKillerGroupId == nGroupId then
			return;
		end

		local tbKillerBattleInfo = Wldh.Battle:GetPlayerData(pKillerPlayer);

		-- ����Ҫ��
		local szMsg	= string.format("%s��%s <color=yellow>%s<color> ������ %s��%s <color=yellow>%s<color>",
			Wldh.Battle.NAME_CAMP[nKillerGroupId], Wldh.Battle.NAME_RANK[tbKillerBattleInfo.nRank], tbKillerBattleInfo.pPlayer.szName,
			Wldh.Battle.NAME_CAMP[nGroupId], Wldh.Battle.NAME_RANK[tbDeathBattleInfo.nRank], tbDeathBattleInfo.pPlayer.szName);

		tbKillerBattleInfo.pPlayer.Msg(szMsg);	
		
		self.tbCamps[nKillerGroupId]:OnKillPlayer(tbKillerBattleInfo, tbDeathBattleInfo);
		
		self:DecreaseDamageDefence(tbKillerBattleInfo.pPlayer);
		self:IncreaseDamageDefence(tbDeathBattleInfo.pPlayer);
		
		tbDeathBattleInfo.nBeenKilledNum = tbDeathBattleInfo.nBeenKilledNum + 1;
	end
end

-- ���������������ȼ�
function tbMissionBase:IncreaseDamageDefence(pPlayer)
	
	local nDamDefenceLevel = pPlayer.GetSkillState(Wldh.Battle.SKILL_DAMAGEDEFENCE_ID);

	if 0 >= nDamDefenceLevel then
		nDamDefenceLevel = 1;
	else
		nDamDefenceLevel = nDamDefenceLevel + 1;
	end
	
	if 5 >= nDamDefenceLevel then
		pPlayer.AddSkillState(Wldh.Battle.SKILL_DAMAGEDEFENCE_ID, nDamDefenceLevel, 1, Wldh.Battle.SKILL_DAMAGEDEFENCE_TIME, 1);
	end
	
	nDamDefenceLevel = pPlayer.GetSkillState(Wldh.Battle.SKILL_DAMAGEDEFENCE_ID);
end

-- �������ȼ�
function tbMissionBase:DecreaseDamageDefence(pPlayer)
	
	local nDamDefenceLevel = pPlayer.GetSkillState(Wldh.Battle.SKILL_DAMAGEDEFENCE_ID);

	nDamDefenceLevel = nDamDefenceLevel - 2;
	pPlayer.RemoveSkillState(Wldh.Battle.SKILL_DAMAGEDEFENCE_ID);
	
	if 0 < nDamDefenceLevel then
		pPlayer.AddSkillState(Wldh.Battle.SKILL_DAMAGEDEFENCE_ID, nDamDefenceLevel, 1, Wldh.Battle.SKILL_DAMAGEDEFENCE_TIME, 1);
	end
end

-- ���ս���Ƿ��
function tbMissionBase:CheckOpenBattle()
	
	local nSongNum	= self.tbCamps[Wldh.Battle.CAMPID_SONG].nPlayerCount;
	local nJinNum	= self.tbCamps[Wldh.Battle.CAMPID_JIN].nPlayerCount;
	
	-- �Ժ��ټ��ж�
	if nSongNum >= Wldh.Battle.BTPLNUM_LOWBOUND and nJinNum >= Wldh.Battle.BTPLNUM_LOWBOUND then
		return 1;
	end
	
	return 0;
end

-- ��ʱ����������������ʼս��
function tbMissionBase:OnTimer_SignupEnd()
	
	-- �Ѿ�����
	if self.nState == 2 then
		return 1;
	end
	
	-- ս��û��
	if 0 == self:CheckOpenBattle() then
		
		-- ��ô����
		self:BroadcastMsg(0, "û�����ɹ�");
		self:Close();
		
		return 0;
	end
	
	self:_SetState(2, 1);
	
	local szMsg	= string.format("���ִ������������ʱ�䵽��%s����ʽ��ʼ��!", self.szBattleName);
	self:BroadcastMsg(szMsg);
	
	self.tbCampSong:OnStart();
	self.tbCampJin:OnStart();
	self.tbRule:OnStart();
		
	local tbAllPlayer = self:GetPlayerList();
	local nNowTime = GetTime();
	
	for _, pPlayer in pairs(tbAllPlayer) do	
		
		-- ����ʱ�䣬battletimer
		Wldh.Battle:GetPlayerData(pPlayer):SetRightBattleInfo(Wldh.Battle.TIMER_GAME);
		
		-- -10��Ŀ�� ��������Ҹտ�ʼ����ʱ�ܹ������뿪��Ӫ
		Wldh.Battle:GetPlayerData(pPlayer).nBackTime = nNowTime - 10; 
	end
	
	-- ÿ���Ӽӷ�
	self:CreateTimer(Wldh.Battle.TIMER_ADD_BOUNS, self.OnTimer_AddBouns, self);
	
	return 1;	-- �ر�Timer
end

-- ÿ���Ӹ���Ա�ӷ�
function tbMissionBase:OnTimer_AddBouns()
	
	local tbAllPlayer = self:GetPlayerList();
	
	if 2 == self.nState then
		for _, pPlayer in pairs(tbAllPlayer) do	
			
			-- ÿ���Ӹ������˼�1��
			Wldh.Battle:GetPlayerData(pPlayer):AddBounsWithCamp(1);	
		end
	else
		return 0;
	end
end

-- ��ʱ���������ڼ�㲥��Ϣ
function tbMissionBase:OnTimer_SignupMsg()
	
	self.nSignUpMsgCount = self.nSignUpMsgCount - 1;
	
	if self.nSignUpMsgCount > 0 then
		local nFrame = self.nSignUpMsgCount * Wldh.Battle.TIMER_SIGNUP_MSG;
		local szMsg	= string.format("ս����δ��ʼ����ʣ%d��", nFrame / Env.GAME_FPS);
		self:BroadcastMsg(szMsg);
	else
		return 0;
	end
end

-- ��ʱ���������������ر�Mission
function tbMissionBase:OnTimer_GameEnd()
	Wldh.Battle:CloseBattle(self.nBattleKey, self.nBattleIndex);
	return 0;
end

-- ��ʱ����ս���ڼ�ͬ���ͻ�����Ϣ
function tbMissionBase:OnTimer_SyncData()
	
	self.nGameSyncCount	= self.nGameSyncCount - 1;
	
	if self.nGameSyncCount <= 0 then
		return 0;
	end
	
	local nRemainTime = self.nGameSyncCount * Wldh.Battle.TIMER_SYNCDATA / Env.GAME_FPS;
	
	if 2 ~= self.nState then
		nRemainTime = 0;
	end
	
	self:UpdateBattleInfo(nRemainTime);
end


function tbMissionBase:UpdateBattleInfo(nRemainTime)
	
	local tbPlayerList = self:GetSortPlayerInfoList();
	
	-- �����������
	for i = 1, #tbPlayerList do
		local tbBattleInfo	= tbPlayerList[i];
		local nOldRank 		= tbBattleInfo.nListRank;
		tbBattleInfo.nListRank = i;
		if nOldRank ~= i and 2 == self.nState then
			tbBattleInfo:ShowRightBattleInfo();
		end
	end	
	
	local tbPlayerInfoList = self:GetSyncInfo_List(tbPlayerList);	

	if tbPlayerInfoList then
		for _, tbPlayer in pairs(tbPlayerList) do
			local tbPlayerInfo = self.tbRule:GetSyncInfo_Self(tbPlayer, nRemainTime);
			local tbPlayerListResult = self:FindMyInfoHighLight(tbPlayer.pPlayer, tbPlayerInfoList);
			local tbAllData	= {};
			
			tbAllData.tbPlayerInfo = tbPlayerInfo;
			tbAllData.tbPlayerInfoList = tbPlayerListResult
			
			local nUseFullTime = 12;
			if nRemainTime == 0 then
				nUseFullTime = 60 * 10;
			end
			
			-- �ͻ���ui���ܽ���
			Dialog:SyncCampaignDate(tbPlayer.pPlayer, "SongJinBattle", tbAllData, nUseFullTime * Env.GAME_FPS);
		end
	end

	for _, tbBattleInfo in pairs(tbPlayerList) do
		
		local nBackTime	= tbBattleInfo.nBackTime;
		
		if 0 == tbBattleInfo.pPlayer.nFightState and 2 == self.nState then			
			local nRemainTime = Wldh.Battle.TIME_PLAYER_STAY - (GetTime() - nBackTime);		
			if 0 >= nRemainTime then
				tbBattleInfo.pPlayer.Msg("���ں�Ӫͣ��ʱ��̫�����������£����㼴�̳�ս��");
				tbBattleInfo.tbCamp:TransTo(tbBattleInfo.pPlayer, "OuterCamp1");
				tbBattleInfo.pPlayer.SetFightState(1);
			end
		end
		
		local nLiveTime	= Wldh.Battle.TIME_PALYER_LIVE - (GetTime() - nBackTime);
		if 0 >= nLiveTime then
			if 1 == tbBattleInfo.pPlayer.IsDead() then
				tbBattleInfo.pPlayer.Revive(0);
			end
		end
	end	
end

-- ������
function tbMissionBase:FindMyInfoHighLight(pPlayer, tbPlayerInfoList)
	
	local tbPlayerListResult = {};
	
	for key, value in ipairs(tbPlayerInfoList) do
		
		local tbPlayerHighInfo = {};
		local nColor = 0;		
		
		if value[3] == pPlayer.szName then
			nColor = 1;
		end
		
		tbPlayerHighInfo = value;
		tbPlayerHighInfo.nC = nColor;
		tbPlayerListResult[key] = tbPlayerHighInfo;
	end
	
	return tbPlayerListResult;
end

-- �������а���Ϣ
function tbMissionBase:GetSyncInfo_List(tbPlayerList)
	
	local tbPlayerInfoList 	= {};
	local nBattleListNum	= 0;
	
	if 30 <= #tbPlayerList then
		nBattleListNum	= 20;
		
	elseif 10 <= #tbPlayerList then
		nBattleListNum	= 10;
		
	else
		nBattleListNum	= #tbPlayerList;
	end
	
	for i = 1, nBattleListNum do
		local tbPlayerInfo = self.tbRule:GetTopRankInfo(tbPlayerList[i]);
		tbPlayerInfoList[#tbPlayerInfoList + 1] = tbPlayerInfo;
	end

	return tbPlayerInfoList;
end

-- ��������������б�
function tbMissionBase:GetSortPlayerInfoList()
	
	local tbPlayerInfoList	= self:GetPlayerInfoList();
	table.sort(tbPlayerInfoList, self._PlayerCmp);
	
	return tbPlayerInfoList;
end

function tbMissionBase:GetPlayerInfoList(nCampId)
	
	local tbPlayerList, nCount = self:GetPlayerList(nCampId);
	local tbPlayerInfoList = {};

	for i, pPlayer in pairs(tbPlayerList) do
		tbPlayerInfoList[i] = Wldh.Battle:GetPlayerData(pPlayer);
	end

	return tbPlayerInfoList, nCount;
end

-- �ȽϺ���
tbMissionBase._PlayerCmp = function(tbPlayerA, tbPlayerB)
	return tbPlayerA.nBouns > tbPlayerB.nBouns;
end

-- ����ս��״̬
function tbMissionBase:_SetState(nState, nOldState)
	
	-- ״̬����
	if nOldState then
		if self.nState ~= nOldState then
			local szMsg	= string.format("[ERROR]MS:SetState %d=>%d, but old = %s", nOldState, nState, tostring(self.nState));
			error(szMsg, 2);
		end
	end
	
	self.nState	= nState;
end

-- ���ȫ�� ## ȥ���˵ȼ�
function tbMissionBase:GetFullName()
	return self.szBattleName .. "-" .. self.nBattleIndex
end
