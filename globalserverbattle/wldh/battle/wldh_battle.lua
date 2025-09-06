-------------------------------------------------------
-- �ļ�������wldh_battle.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-08-20 14:33:58
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle_def.lua");

local tbBattle = Wldh.Battle;

-- ��ʼ��
function tbBattle:Init()
	
	-- ֧������
	if not self.tbMissions then	
		self.tbMissions		= {};	-- 1��mission�����ˣ����ּ���
		self.tbBTSaveData	= {};	-- ��ս����Ϣ
		self.tbRuleBases	= {};	-- ������Ϣ
		self.tbMapInfo		= {};	-- ��ս�ӷ��飬ս������
	end

	-- ������
	if MODULE_GAMESERVER then
		
		-- ���������ͼ��Ϣ
		ServerEvent:RegisterServerStartFunc(self.InitMapInfo, self);
	end
end

-- ��ʼ����ͼ��Ϣ
function tbBattle:InitMapInfo()
	self:_LoadMapList();
	self:_InitSignupPos();
end

-- ���ص�ͼ�б�������ı���һ��trap�㣬����
-- tbMapData = { [nMapId] = {[nCamp] = {["BaseCamp"] = {}, ["OuterCamp1"] = {} } }
function tbBattle:_LoadMapList()
	
	local tbMapData = {};
	
	for nIndex, nMapId in pairs(self.MAPID_MATCH) do
		
		tbMapData[nMapId] = self:_LoadMapData(nMapId, "\\setting\\battle\\map\\wulindahui\\");
		tbMapData[nMapId].szMapName = "���ִ��������" .. nIndex;
	end
	
	self.tbMapData = tbMapData;
end

-- ������
function tbBattle:_InitSignupPos()
	
	-- ���������꼯
	local tbSignUpInfo = {};
	
	for nBattleIndex, nMapId in pairs(self.MAPID_SIGNUP) do
		
		if not tbSignUpInfo[self.MAPID_MATCH[nBattleIndex]] then
			tbSignUpInfo[self.MAPID_MATCH[nBattleIndex]] = {};
		end
			
		for nIndex, tbPos in pairs(self.POS_SIGNUP) do
			tbSignUpInfo[self.MAPID_MATCH[nBattleIndex]][nIndex] = {nMapId, tbPos[1], tbPos[2]};
		end
	end

	self.tbSignUpInfo = tbSignUpInfo;
end


-- ���ص�ͼ����
function tbBattle:_LoadMapData(nMapId, szPath)
	
	local tbPosFileList	= 
	{
		["BaseCamp"]		= "houying%d.txt",			-- ��Ӫ��ڵ�
		["OuterCamp1"]		= "daying%d.txt",			-- ��Ӫ��ڵ�
		["OuterCamp2"]		= "qianying%d.txt",			-- ǰӪ��ڵ�
		["OuterCamp3"]		= "daying%d_1.txt",
		["OuterCamp4"]		= "daying%d_2.txt",
		["Npc_chuwuxiang"]	= "houying%dchuwuxiang.txt",-- ��Ӫ������
		["Npc_junyiguan"]	= "houying%djunyiguan.txt",	-- ��Ӫ��ҽ��
		["Npc_chefu"]		= "chefu%d.txt",			-- ����
	};
	
	local tbMapData	= {};
	
	for nCamp = 1, 4 do
		
		local tbMapCampData	= {};
		for szName, szFileName in pairs(tbPosFileList) do
			
			local szFullPath = szPath..string.format(szFileName, nCamp);
			local tbFileData = Lib:LoadTabFile(szFullPath);
			
			if tbFileData then
				local tbData = {};
				for nIndex, tbRow in ipairs(tbFileData) do
					if tonumber(tbRow.TRAPX) and tonumber(tbRow.TRAPY) then
						tbData[#tbData + 1]	= {nMapId, tonumber(tbRow.TRAPX), tonumber(tbRow.TRAPY)};
					end
				end
				tbMapCampData[szName] = tbData;
			else
				if szName == "BaseCamp" then
					tbMapCampData = nil;
					break;
				end
			end
		end
		
		-- ��Ӫ�㲻���ڣ����ܴ�Ӫ1_1���ڣ������ھ��ǲ�������
		if tbMapCampData and not tbMapCampData["OuterCamp1"] then
			tbMapCampData["OuterCamp1"] = tbMapCampData["OuterCamp3"];
		end
		
		tbMapData[nCamp] = tbMapCampData;
	end
	
	-- ����Ӧ����������Ϣ
	assert(tbMapData[1] and tbMapData[3]);
	return tbMapData;
end

-- ����ս��(ֻ���ڼ���)
function tbBattle:OpenBattle(nBattleIndex, szLeagueNameSong, szLeagueNameJin, nFinalStep)
	
	local szBattleTime = GetLocalDate("%y%m%d%H");
	local nMapId = self.MAPID_MATCH[nBattleIndex];
	
	-- δ�ڱ�����������
	if IsMapLoaded(nMapId) ~= 1 then
		return;	
	end
	
	-- �����ͼ������npc
	ClearMapNpc(nMapId);
	
	-- ����ս�ӷ���
	self.tbMapInfo[nMapId] = 
	{ 
		nBattleIndex = nBattleIndex, -- ����Ҳ�ã���÷���
		szLeagueNameSong = szLeagueNameSong;
		szLeagueNameJin = szLeagueNameJin;
	};

	-- ��ͼ����
	if not self.tbMapData[nMapId] then
		return;
	end
	
	-- ����mission
	local tbMission	= Lib:NewClass(self.tbMissionBase, 
		nBattleIndex, nMapId, self.tbMapData[nMapId], 
		szBattleTime, szLeagueNameSong, szLeagueNameJin, nFinalStep);

	self.tbMissions[nBattleIndex] = tbMission;
	
	-- ����mission
	tbMission:Open();
	
	-- �㲥��Ϣ
	local szMsg = string.format("���ִ��������һ��������Ŀǰ������׼���׶Σ�������ʼʣ��ʱ��:%d�֡�", self.TIMER_SIGNUP / (Env.GAME_FPS * 60));
	KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, szMsg);
	GCExcute({"Wldh:Gb_Anncone", szMsg});
end

-- �ر�ս��
function tbBattle:CloseBattle(nBattleKey, nBattleIndex)
	
	local tbMission	= self.tbMissions[nBattleIndex];
	local nMapId = tbMission.nMapId;
	
	-- ��ȫ���
	assert(tbMission.nBattleKey == nBattleKey);	
	
	-- �ر�mission
	tbMission:Close();

	-- ���npc
	ClearMapNpc(nMapId);
	
	-- ���������
	self.tbMissions[nBattleIndex] = nil;
	self.tbMapInfo[nMapId] = nil;
end

-- ��������ʱtable���������õ�
function tbBattle:GetPlayerData(pPlayer)
	local tbPlayerData = pPlayer.GetTempTable("Wldh");
	local tbPlayerBattleInfo = tbPlayerData.tbPlayerBattleInfo;
	return tbPlayerBattleInfo;
end

-- ���ս��mission
function tbBattle:GetMission(nBattleIndex)
	return self.tbMissions[nBattleIndex];
end

function tbBattle:GetMissionByMapId(nMapId)
	local nBattleIndex = self.tbMapInfo[nMapId].nBattleIndex;
	return self.tbMissions[nBattleIndex];
end

-- ����������
function tbBattle:GetPlayerCount(nBattleIndex)
	local tbDbTaskId	= self.DBTASKID_PLAYER_COUNT[nBattleIndex];
	local nSongCampNum	= KGblTask.SCGetTmpTaskInt(tbDbTaskId[self.CAMPID_SONG]) - 1; 
	local nJinCampNum	= KGblTask.SCGetTmpTaskInt(tbDbTaskId[self.CAMPID_JIN]) - 1;
	return nSongCampNum, nJinCampNum;
end

function tbBattle:GetGroupByLeagueName(szLeagueName)
	
	if not self.tbGroupIndex then
		return nil;
	end
	
	for nIndex, tbGroup in pairs(self.tbGroupIndex) do
		if Wldh.Battle.tbLeagueName[tbGroup[1]][1] == szLeagueName then
			return {nIndex, 1};
		elseif Wldh.Battle.tbLeagueName[tbGroup[2]][1] == szLeagueName then
			return {nIndex, 2};
		end
	end
	
	return nil;
end

tbBattle:Init();
