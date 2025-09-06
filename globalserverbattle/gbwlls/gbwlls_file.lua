--��������
--�����
--2008.09.17
Require("\\script\\mission\\wlls\\wlls_def.lua")
Require("\\script\\globalserverbattle\\gbwlls\\gbwlls_def.lua")

--����������
function GbWlls:LoadGameTable()
	local tbFile = Lib:LoadTabFile("\\setting\\mission\\gbwlls\\league_table.txt");
	if not tbFile then
		return
	end
	for nId, tbParam in ipairs(tbFile) do
		if nId > 1 then
			local nSession 		= tonumber(tbParam.Session);
			if (nSession) then
				local nLeagueType 	= tonumber(tbParam.LeagueType);
				local szAwardFile 	= tbParam.AwardFile;
				local szAwardSegFile= tbParam.AwardSegFile;
				local nAdvRank 		= tonumber(tbParam.AdvRank);
				local nPreMaxLeague	= tonumber(tbParam.PreMaxLeague) or 200;
				local szDesc 		= tbParam.Desc;
				GbWlls.SEASON_TB[nSession] = {nLeagueType, szAwardFile, nAdvRank, szDesc, nPreMaxLeague};
	
				if not MODULE_GAMECLIENT then
					--���ؽ����ֶα�
					self:LoadGameAwardLevel(szAwardSegFile, nSession);
				end
			end
		end
	end
	
end

--���ؽ����ֲ��
function GbWlls:LoadGameAwardLevel(szFileName, nSession)
	local tbFile = Lib:LoadTabFile("\\setting\\mission\\gbwlls\\league_award\\" .. szFileName);
	if not tbFile then
		return
	end
	if not self.AWARD_LEVEL[nSession] then
		self.AWARD_LEVEL[nSession] = {[GbWlls.MACTH_PRIM] = {}, [GbWlls.MACTH_ADV] = {}};
	end
	for nId, tbParam in ipairs(tbFile) do
		if nId > 1 then
			local nLevelType = tonumber(tbParam.LevelType);
			local nLevel1 = tonumber(tbParam.Level1) or -1;
			local nLevel2 = tonumber(tbParam.Level2) or -1;
			if nLevel1 >= 0 then
				self.AWARD_LEVEL[nSession][GbWlls.MACTH_PRIM][nLevelType] = nLevel1;
			end
			if nLevel2 >= 0 then
				self.AWARD_LEVEL[nSession][GbWlls.MACTH_ADV][nLevelType] = nLevel2;
			end
		end
	end
end

--�����������ͱ�
function GbWlls:LoadGameType()
	local tbFile = Lib:LoadTabFile("\\setting\\mission\\gbwlls\\league_type.txt");
	if not tbFile then
		return
	end
	GbWlls.MACTH_TYPE = {};
	local tbFileName = {};
	local tbFileTrap = {};
	--local tbFileAward = {};
	for nId, tbParam in ipairs(tbFile) do
		if nId > 1 then
			local nLeagueType = tonumber(tbParam.LeagueType);
			if tbParam.FileName ~= "" then
				tbFileName[nLeagueType] = tbParam.FileName;
			end
			if tbParam.FileNameTrap ~= "" then
				tbFileTrap[nLeagueType] = tbParam.FileNameTrap;
			end
			--if tbParam.FileAwardSeg ~= "" then
			--	tbFileAward[nLeagueType] = tbParam.FileAwardSeg;
			--end
			GbWlls.MACTH_TYPE[nLeagueType] = tbParam.ClassName;
		end
	end
	GbWlls.MacthType = {};
	for nType, szClassName in pairs(GbWlls.MACTH_TYPE) do
		GbWlls.MacthType[szClassName] = {};
		GbWlls.MacthType[szClassName].tbMacthCfg 	= {};
		GbWlls.MacthType[szClassName].tbMacthCfg.tbWeekend 	= {};
		GbWlls.MacthType[szClassName].tbMacthCfg.tbCommon 	= {};
		GbWlls.MacthType[szClassName].tbMacthCfg.tbAdvMatch 	= {};
		GbWlls.MacthType[szClassName].PrimMacth 	= {tbIntoMap={},tbReadyMap={},tbMacthMap={}, tbMacthMapPatch={}};
		GbWlls.MacthType[szClassName].AdvMacth 	= {tbIntoMap={},tbReadyMap={},tbMacthMap={}, tbMacthMapPatch={}};
		
		if tbFileName[nType] then
			local tbTypeFile = Lib:LoadTabFile(string.format("\\setting\\mission\\gbwlls\\league_type\\%s", tbFileName[nType]));
			if not tbTypeFile then
				print("��������������ȡ�ļ������ļ�������", tbFileName[nType]);
				return
			end
			for nId, tbParam in ipairs(tbTypeFile) do
				if nId > 1 then
					local szName 		= tbParam.Name;
					local nMapLinkType  = tonumber(tbParam.MapLinkType);
					local nMemberCount  = tonumber(tbParam.MemberCount);
					local nPlayerCount  = tonumber(tbParam.PlayerCount);
					local nSex  		= tonumber(tbParam.Sex);
					local nCamp  		= tonumber(tbParam.Camp);
					local nSeries 	 	= tonumber(tbParam.Series);
					local nFaction  	= tonumber(tbParam.Faction);
					local nTeacher  	= tonumber(tbParam.Teacher);
					local szDesc  		= tbParam.Desc;
					local nPriIntoMap  	= tonumber(tbParam.PriIntoMap);
					local nPriReadyMap  = tonumber(tbParam.PriReadyMap);
					local nPriMacthMap  = tonumber(tbParam.PriMacthMap);
					local nPriMacthMapPatch = tonumber(tbParam.PriMacthMapPatch);
					local nAdvIntoMap  	= tonumber(tbParam.AdvIntoMap);
					local nAdvReadyMap  = tonumber(tbParam.AdvReadyMap);
					local nAdvMacthMap  = tonumber(tbParam.AdvMacthMap);
					local nAdvMacthMapPatch  = tonumber(tbParam.AdvMacthMapPatch);
					local nTimeWeekend	= tonumber(tbParam.Time_Weekend);
					local nTimeCommon	= tonumber(tbParam.Time_Common);
					local nTimeAdvMatch	= tonumber(tbParam.Time_AdvMatch);
					local nReadyTime_Common	= tonumber(tbParam.ReadyTime_Common);
					local nPKTime_Common	= tonumber(tbParam.PKTime_Common);
					local nReadyTime_Adv	= tonumber(tbParam.ReadyTime_Adv);
					local nPKTime_Adv		= tonumber(tbParam.PKTime_Adv);
					
					if szName and szName ~= "" then
						GbWlls.MacthType[szClassName].szName = szName;
					end
					if szDesc and szDesc ~= "" then
						GbWlls.MacthType[szClassName].szDesc = szDesc;
					end					
					if nMapLinkType then
						GbWlls.MacthType[szClassName].nMapLinkType = nMapLinkType;
					end
					if nMemberCount then
						GbWlls.MacthType[szClassName].tbMacthCfg.nMemberCount = nMemberCount;
					end
					if nPlayerCount then
						GbWlls.MacthType[szClassName].tbMacthCfg.nPlayerCount = nPlayerCount;
					end					
					if nSex then
						GbWlls.MacthType[szClassName].tbMacthCfg.nSex = nSex;
					end
					if nCamp then
						GbWlls.MacthType[szClassName].tbMacthCfg.nCamp = nCamp;
					end
					if nSeries then
						GbWlls.MacthType[szClassName].tbMacthCfg.nSeries = nSeries;
					end
					if nFaction then
						GbWlls.MacthType[szClassName].tbMacthCfg.nFaction = nFaction;
					end
					if nTeacher then
						GbWlls.MacthType[szClassName].tbMacthCfg.nTeacher = nTeacher;
					end
					
					if (nReadyTime_Common) then
						GbWlls.MacthType[szClassName].tbMacthCfg.nReadyTime_Common = nReadyTime_Common;
					end

					if (nReadyTime_Adv) then
						GbWlls.MacthType[szClassName].tbMacthCfg.nReadyTime_Adv = nReadyTime_Adv;
					end

					if (nPKTime_Common) then
						GbWlls.MacthType[szClassName].tbMacthCfg.nPKTime_Common = nPKTime_Common;
					end

					if (nPKTime_Adv) then
						GbWlls.MacthType[szClassName].tbMacthCfg.nPKTime_Adv = nPKTime_Adv;
					end
					
					if (nTimeCommon) then
						table.insert(GbWlls.MacthType[szClassName].tbMacthCfg.tbCommon, nTimeCommon);
					end

					if (nTimeWeekend) then
						table.insert(GbWlls.MacthType[szClassName].tbMacthCfg.tbWeekend, nTimeWeekend);
					end

					if (nTimeAdvMatch) then
						table.insert(GbWlls.MacthType[szClassName].tbMacthCfg.tbAdvMatch, nTimeAdvMatch);
					end
					
					if nPriIntoMap then
						table.insert(GbWlls.MacthType[szClassName].PrimMacth.tbIntoMap, nPriIntoMap);
					end
					if nPriReadyMap then
						table.insert(GbWlls.MacthType[szClassName].PrimMacth.tbReadyMap, nPriReadyMap);
					end
					if nPriMacthMap then
						table.insert(GbWlls.MacthType[szClassName].PrimMacth.tbMacthMap, nPriMacthMap);
					end
					if nPriMacthMapPatch then
						table.insert(GbWlls.MacthType[szClassName].PrimMacth.tbMacthMapPatch, nPriMacthMapPatch);
					end					
					if nAdvIntoMap then
						table.insert(GbWlls.MacthType[szClassName].AdvMacth.tbIntoMap, nAdvIntoMap);
					end
					if nAdvReadyMap then
						table.insert(GbWlls.MacthType[szClassName].AdvMacth.tbReadyMap, nAdvReadyMap);
					end
					if nAdvMacthMap then
						table.insert(GbWlls.MacthType[szClassName].AdvMacth.tbMacthMap, nAdvMacthMap);
					end		
					if nAdvMacthMapPatch then
						table.insert(GbWlls.MacthType[szClassName].AdvMacth.tbMacthMapPatch, nAdvMacthMapPatch);
					end																											
				end
			end
			
			if not GbWlls.MacthType[szClassName].szName then
				GbWlls.MacthType[szClassName].szName = "��δ��д���͡�";
			end
			if not GbWlls.MacthType[szClassName].szDesc then
				GbWlls.MacthType[szClassName].szDesc = "��δ��д������";
			end
			if not GbWlls.MacthType[szClassName].nMapLinkType then
				GbWlls.MacthType[szClassName].nMapLinkType = 1;
			end
			if not GbWlls.MacthType[szClassName].tbMacthCfg.nMemberCount then
				GbWlls.MacthType[szClassName].tbMacthCfg.nMemberCount = 0;
			end			
			if not GbWlls.MacthType[szClassName].tbMacthCfg.nPlayerCount then
				GbWlls.MacthType[szClassName].tbMacthCfg.nPlayerCount = 0;
			end
			if not GbWlls.MacthType[szClassName].tbMacthCfg.nSex then
				GbWlls.MacthType[szClassName].tbMacthCfg.nSex = 0;
			end
			if not GbWlls.MacthType[szClassName].tbMacthCfg.nCamp then
				GbWlls.MacthType[szClassName].tbMacthCfg.nCamp = 0;
			end
			if not GbWlls.MacthType[szClassName].tbMacthCfg.nSeries then
				GbWlls.MacthType[szClassName].tbMacthCfg.nSeries = 0;
			end
			if not GbWlls.MacthType[szClassName].tbMacthCfg.nFaction then
				GbWlls.MacthType[szClassName].tbMacthCfg.nFaction = 0;
			end
			if not GbWlls.MacthType[szClassName].tbMacthCfg.nTeacher then
				GbWlls.MacthType[szClassName].tbMacthCfg.nTeacher = 0;
			end
		end
	end
end

function GbWlls:LoadGameAward()
	GbWlls.AWARD_SINGLE_LIST[GbWlls.MACTH_PRIM] = {};
	GbWlls.AWARD_SINGLE_LIST[GbWlls.MACTH_ADV] = {};
	GbWlls.AWARD_FINISH_LIST[GbWlls.MACTH_PRIM] = {};
	GbWlls.AWARD_FINISH_LIST[GbWlls.MACTH_ADV] = {};
	for nSession, tbSession in pairs(self.SEASON_TB) do
		if tbSession[2] then
			self:LoadGameAwardBase("\\setting\\mission\\gbwlls\\league_award\\"..tbSession[2].."_lv1.txt", GbWlls.MACTH_PRIM, nSession);
			self:LoadGameAwardBase("\\setting\\mission\\gbwlls\\league_award\\"..tbSession[2].."_lv2.txt", GbWlls.MACTH_ADV, nSession);
		end
	end
end

--���ؽ���
function GbWlls:LoadGameAwardBase(szPath, nGameLevel, nSession)
	local tbFile = Lib:LoadTabFile(szPath)
	if not tbFile then
		return
	end
	for nId, tbParam in ipairs(tbFile) do
		if nId > 1 then
			
			local szWin = tbParam.Win;
			local szTie = tbParam.Tie;
			local szLost = tbParam.Lost;
			
			if not GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession] then
				GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession] = {};
				GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Win = {};
				GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Tie = {};
				GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Lost = {};
			end
			if szWin and szWin ~= "" then
				local szType, Value = self:GetSplitValue(szWin)
				if not GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Win[szType] then
					GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Win[szType] = {};
				end
				table.insert(GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Win[szType], Value);
			end
			if szTie and szTie ~= "" then
				local szType, Value = self:GetSplitValue(szTie)
				if not GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Tie[szType] then
					GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Tie[szType] = {};
				end
				table.insert(GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Tie[szType], Value);
			end	
			if szLost and szLost ~= "" then
				local szType, Value = self:GetSplitValue(szLost)
				if not GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Lost[szType] then
					GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Lost[szType] = {};
				end
				table.insert(GbWlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Lost[szType], Value);
			end
			
			if not GbWlls.AWARD_FINISH_LIST[nGameLevel][nSession] then
				GbWlls.AWARD_FINISH_LIST[nGameLevel][nSession] = {};
			end		
			for nId in pairs(self.AWARD_LEVEL[nSession][nGameLevel]) do
				if not GbWlls.AWARD_FINISH_LIST[nGameLevel][nSession][nId] then
					GbWlls.AWARD_FINISH_LIST[nGameLevel][nSession][nId] = {};
				end
				local szAward = tbParam["RankType"..nId];
				if szAward and szAward ~= "" then
					local szType, Value = self:GetSplitValue(szAward)
					if not GbWlls.AWARD_FINISH_LIST[nGameLevel][nSession][nId][szType] then
						GbWlls.AWARD_FINISH_LIST[nGameLevel][nSession][nId][szType] = {};
					end
					table.insert(GbWlls.AWARD_FINISH_LIST[nGameLevel][nSession][nId][szType], Value);
				end
			end
		end
	end
end

function GbWlls:GetSplitValue(szStr)
		szStr = Lib:ClearStrQuote(szStr);
		local nSit = string.find(szStr, "=");
		if nSit ~= nil then
			local szFlag = string.sub(szStr, 1, nSit - 1);
			local szContent = string.sub(szStr, nSit + 1, string.len(szStr));
			if tonumber(szContent) then
				return szFlag, tonumber(szContent);
			end
			local tbLit = Lib:SplitStr(szContent, ",");
--			for nId, nNum in ipairs(tbLit) do
--				tbLit[nId] = tonumber(nNum);
--			end
			return szFlag, tbLit;
		end
		return "", "";
end

GbWlls:LoadGameTable();

if not MODULE_GAMECLIENT then
	if (not GLOBAL_AGENT) then
		GbWlls:LoadGameType();
	end
GbWlls:LoadGameAward();
end
