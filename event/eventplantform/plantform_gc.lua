--�ƽ̨
--�ܳ���
--2009.08.10
if (not MODULE_GC_SERVER) then
	return 0;
end

--����׼������
function EPlatForm:EnterReadyMap(nPlayerId, szLeagueName, nMapId, tbMapTypeParam, nCaptain)
	local tbMacthCfg = self:GetMacthTypeCfg(self:GetMacthType());
	local nEnterReadyId = EPlatForm:GetReadyMapId(tbMacthCfg, nMapId, tbMapTypeParam, szLeagueName);
	if nEnterReadyId <= 0 then
		GlobalExcute{"EPlatForm:MapStateFull", nPlayerId};
		return 0;
	end
	if not self.GroupList[nEnterReadyId][szLeagueName] then
		self.GroupList[nEnterReadyId][szLeagueName] = {};
		self.GroupList[nEnterReadyId].nLeagueCount = self.GroupList[nEnterReadyId].nLeagueCount + 1;
	end
	if nCaptain > 0 then
		table.insert(self.GroupList[nEnterReadyId][szLeagueName], 1, nPlayerId);
	else
		table.insert(self.GroupList[nEnterReadyId][szLeagueName], nPlayerId);
	end

	if (EPlatForm:GetMacthState() == EPlatForm.DEF_STATE_MATCH_1) then
		-- ��ʱû��
	else
		--ս�Ӳ���
		if League:GetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_ATTEND) ~= nEnterReadyId then
			League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_ATTEND, nEnterReadyId);
		end
		League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_ENTER, League:GetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_ENTER) + 1);
	end
	GlobalExcute{"EPlatForm:EnterReadyMap", nPlayerId, szLeagueName, nEnterReadyId};
end

--�������������Ъ��
function EPlatForm:GameState0Into1()
	if KGblTask.SCGetDbTaskInt(EPlatForm.GTASK_MACTH_SESSION) == 0 then
		KGblTask.SCSetDbTaskInt(EPlatForm.GTASK_MACTH_SESSION, 1);	
		KGblTask.SCSetDbTaskInt(EPlatForm.GTASK_MACTH_STATE, EPlatForm.DEF_STATE_REST);
	end
end

--��������ڵ�һ�׶�
function EPlatForm:GameState1Into2()
	if EPlatForm:GetMacthState() == EPlatForm.DEF_STATE_REST and EPlatForm.SEASON_TB[EPlatForm:GetMacthSession()] then
		KGblTask.SCSetDbTaskInt(EPlatForm.GTASK_MACTH_STATE, EPlatForm.DEF_STATE_MATCH_1);
		GlobalExcute{"EPlatForm:ClearMissionList"};
		EPlatForm:UpdateMatchTime();
		self:ClearKinScoreAndRank();
		self:ClearPlatformMonthScore();
		-- ��һ�쿪ʼ��Ҫ��ս������ȫ����
		League:ClearLeague(EPlatForm.LGTYPE);
		GlobalExcute{"EPlatForm:LoadMapTable"};
		KGblTask.SCSetDbTaskInt(self.GTASK_MACTH_MAX_SCORE_FOR_NEXT, 0);
	end
end

--��������ڵڶ��׶�
function EPlatForm:GameState2Into3()
	if EPlatForm:GetMacthState() == EPlatForm.DEF_STATE_MATCH_1 then
		KGblTask.SCSetDbTaskInt(EPlatForm.GTASK_MACTH_STATE, EPlatForm.DEF_STATE_MATCH_2);
--		EPlatForm:LeagueClearSession();	--���,��ͬ��,��ͬ���Ƶ�ս������
		self:UpdateMatchTime();
		-- ��ȡ�μӵڶ��ֱ�����ѡ��
		self:GetKinMatchTeam();
	end
end

local function _OnSort(tbA, tbB)
	return tbA[2] > tbB[2];
end

local function _OnSortA(tbA, tbB)
	if (tbA[2] == tbB[2]) then
		return tbA[3] < tbB[3];
	end
	return tbA[2] > tbB[2];
end

-- ��ȡ��ǰ��������
function EPlatForm:GetUpdateKinRankList()
	local pKin, nKinId = KKin.GetNextKin(0);
	local tbKinRankList	= {};
	
	while pKin do
		local nScore = pKin.GetPlatformScore();
		if (nScore > self.DEF_MIN_KINSCORE) then
			local szKinName = pKin.GetName();
			local nLastRank = pKin.GetPlatformKinRank() or 0;
			if (nLastRank == 0) then
				nLastRank = 999999;
			end
			tbKinRankList[#tbKinRankList + 1] = {szKinName, nScore, nLastRank};
		end
		pKin, nKinId = KKin.GetNextKin(nKinId);
	end
	
	table.sort(tbKinRankList, _OnSortA);

	return tbKinRankList;
end

-- ��ȡ��������ҵĻ�������
function EPlatForm:GetUpdatePlayerRankListInKin(szKinName)
	if (not szKinName) then
		return;
	end
	local pKin = KKin.FindKin(szKinName);
	if (not pKin) then
		return;
	end
	local itor = pKin.GetMemberItor();
	local cMember = itor.GetCurMember();
	local szLeagueName = pKin.GetName();
	local nMaxBallot = 0
	local nCurMaxMember = 0
	local nCurJourNum = 0
	local tbTempList = {};
	while cMember do
		local nPlayerId = cMember.GetPlayerId();
		local nPlayerScore = self:GetPlayerMonthScoreById(nPlayerId);
		if (nPlayerScore >= self.DEF_MIN_KINSCORE_PLAYER) then
			local nFigure = cMember.GetFigure();
			-- ֻ����ʽ��Ա���ܲμ���һ�׶α���
			if (nFigure > 0 and nFigure <= Kin.FIGURE_REGULAR) then
				local tbInfo = { nPlayerId, nPlayerScore };
				tbTempList[#tbTempList + 1] = tbInfo;
			end
		end
		cMember = itor.NextMember()
	end
	table.sort(tbTempList, _OnSort);
	return tbTempList;
end

-- ���ݼ�����ֻ�ü�����ǰʮ�����
function EPlatForm:GetKinMatchTeam()
	local tbKinRankList	= EPlatForm:GetUpdateKinRankList();
	local tbTeamResult = {};
	
	self:UpdateKinRankInfo(tbKinRankList);
	
	for i, tbKinInfo in ipairs(tbKinRankList) do
		-- ��������һ����ֵ���ܲμ���һ�׶�
		if (i > EPlatForm.MAX_KINRANK_NEXTMATCH) then
			break;
		end

		local pKin = KKin.FindKin(tbKinInfo[1]);
		if (pKin) then
			local itor = pKin.GetMemberItor();
			local cMember = itor.GetCurMember();
			local szLeagueName = pKin.GetName();
			local nMaxBallot = 0
			local nCurMaxMember = 0
			local nCurJourNum = 0
			local tbTempList = {};
			while cMember do
				local nPlayerId = cMember.GetPlayerId();
				local nPlayerScore = self:GetPlayerMonthScoreById(nPlayerId);
				if (nPlayerScore >= self.DEF_MIN_KINSCORE_PLAYER) then
					local nFigure = cMember.GetFigure();
					-- ֻ����ʽ��Ա���ܲμ���һ�׶α���
					if (nFigure > 0 and nFigure <= Kin.FIGURE_REGULAR) then
						local _, nMemberId = KKin.GetPlayerKinMember(nPlayerId);
						if (not nMemberId) then
							nMemberId = 0;
						end
						local tbInfo = { nPlayerId, nPlayerScore, nMemberId };
						tbTempList[#tbTempList + 1] = tbInfo;
					end
				end
				cMember = itor.NextMember()
			end
			table.sort(tbTempList, _OnSortA);
			local tbTeamA	= {};
			local tbTeamB	= {};
			if (#tbTempList < 4) then
				self:WriteLog("[GetKinMatchTeam] The kin number is less than 4 players, so is not create the team! ", szLeagueName);
			elseif (#tbTempList < 8) then
				for nId, tbInfo in ipairs(tbTempList) do
					if (nId > 5) then
						break;
					end
					local tbPlayerInfo = self:GetPlayerInfo(tbInfo[1]);
					if (tbPlayerInfo) then
						tbTeamA[#tbTeamA + 1] = tbPlayerInfo;
					end
				end										
			else
				for nId, tbInfo in ipairs(tbTempList) do
					if (nId > 10) then
						break;
					end
					local nFlag = self.MATCH_TEAM_PART[nId];
					local tbPlayerInfo = self:GetPlayerInfo(tbInfo[1]);
					if (tbPlayerInfo) then
						if (1 == nFlag) then
							tbTeamA[#tbTeamA + 1] = tbPlayerInfo;
						else
							tbTeamB[#tbTeamB + 1] = tbPlayerInfo;
						end
					end
				end						
			end
			local nKinId = KKin.GetKinNameId(szLeagueName);
			if (#tbTeamA > 0) then
				self:CreateTempLeague(tbTeamA, string.format("%s_һ��", szLeagueName), nKinId or 0);
			end
			
			if (#tbTeamB > 0) then
				self:CreateTempLeague(tbTeamB, string.format("%s_����", szLeagueName), nKinId or 0);
			end
		end
	end
	if (MODULE_GC_SERVER) then
		GlobalExcute{"EPlatForm:LoadKinLeagueInfo"};
	end
	return 0;
end

function EPlatForm:GetPlayerInfo(nPlayerId)
	if (not nPlayerId) then
		return;
	end
	local szPlayerName = KGCPlayer.GetPlayerName(nPlayerId);
	if (not szPlayerName) then
		return;
	end
	local tbInfo = GetPlayerInfoForLadderGC(szPlayerName);
	if (not tbInfo) then
		return;
	end
	local tbPlayerInfo = {
		nId=nPlayerId,
		szName=szPlayerName,
		nFaction=tbInfo.nFaction, 
		nRouteId=tbInfo.nRouteId, 
		nSex=tbInfo.nSex, 
		nCamp=0, 
		nSeries=0,
	};

	--pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_MATCH_FINISH, 0);--���������ȡѡ��.
--	pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_SESSION, Wlls:GetMacthSession());--���ð���������ʾ��Ϣ
--	pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TOTLE, 0);
--	pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_WIN, 0);
--	pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TIE, 0);
	return tbPlayerInfo;
end

--�����ǿ����
function EPlatForm:GameState3Into4()
--	EPlatForm:LeagueRank(0);
	if EPlatForm:GetMacthState() == EPlatForm.DEF_STATE_MATCH_2 then
		EPlatForm:InitGameDateGC(0);
		KGblTask.SCSetDbTaskInt(EPlatForm.GTASK_MACTH_STATE, EPlatForm.DEF_STATE_ADVMATCH);
		EPlatForm:UpdateMatchTime();
		
		EPlatForm:OnGameLeagueRank();
		
		local nRankSession	= EPlatForm:GetMacthSession();
		
		--��ǿ�������
		local tbMacthCfg = self:GetMacthTypeCfg(self:GetMacthType());
		for nReadyId, nMapId in pairs(tbMacthCfg.tbReadyMap) do
			EPlatForm.AdvMatchLists[nReadyId] = {};
			EPlatForm.AdvMatchLists[nReadyId][8] = {};
			EPlatForm.AdvMatchLists[nReadyId][4] = {};
			EPlatForm.AdvMatchLists[nReadyId][2] = {};
			EPlatForm.AdvMatchLists[nReadyId][1] = {};

			if nReadyId == 1 then
				for i=1, #self.RankLeagueList do
					if (i > 32) then
						break;
					end
					local szLeagueName = self.RankLeagueList[i].szName;
					local szKinName = self:GetKinNameFromLeagueName(szLeagueName);
					if (i <= 8) then
						EPlatForm.AdvMatchLists[nReadyId][8][i] = {szName = szLeagueName, tbResult={}};
						League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK_ADV, 8);
						League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_ATTEND, nReadyId);
						self:SetKinAwardFlag(szKinName, nRankSession, 8);
					elseif (i <= 16) then
						League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK_ADV, 16);
						self:SetKinAwardFlag(szKinName, nRankSession, 16);
					elseif (i <= 32) then
						League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK_ADV, 32);
						self:SetKinAwardFlag(szKinName, nRankSession, 32);
					end
				end
				EPlatForm:SyncAdvMatchList(nReadyId, EPlatForm.AdvMatchLists[nReadyId]);
			end

		end
		EPlatForm:UpdateAdvHelpNews();
	end
end

--ÿ�����,��ǿ���ڽ����Ъ��
function EPlatForm:GameState4Into1()
	if EPlatForm:GetMacthState() == EPlatForm.DEF_STATE_ADVMATCH then
		--ս������
		KGblTask.SCSetDbTaskInt(EPlatForm.GTASK_MACTH_RANK, EPlatForm:GetMacthSession());
		KGblTask.SCSetDbTaskInt(EPlatForm.GTASK_MACTH_LASTSESSION, EPlatForm:GetMacthSession());
		EPlatForm:SetMacthSession(EPlatForm:GetMacthSession() + 1);
		KGblTask.SCSetDbTaskInt(EPlatForm.GTASK_MACTH_STATE, EPlatForm.DEF_STATE_REST);
		EPlatForm:LeagueRankFinal();	--����;
		EPlatForm:ClearKinAwardCount();
		Timer:Register(EPlatForm.MACTH_TIME_RANK_FINISH,  self.LeagueRankFinish,  self);
	end
end

--Ԥ����������������ȡ����
function EPlatForm:LeagueRankFinish()
	KGblTask.SCSetDbTaskInt(EPlatForm.GTASK_MACTH_RANK, EPlatForm:GetMacthSession());
	return 0;
end

--ÿ��ս��
function EPlatForm:UpdateHelpNews(nSession, nFinalType)
	if not EPlatForm.RankLeagueList then
--		EPlatForm:LeagueRank(0, 1);
		return 0;
	end
	local tbMacthCfg = EPlatForm:GetMacthTypeCfg(EPlatForm:GetMacthType(nSession));
	local szMatchName = "�ƽ̨";
	if (tbMacthCfg) then
		szMatchName = tbMacthCfg.szName;
	end
	local nKey		= Task.tbHelp.NEWSKEYID.NEWS_MENPAIJINGJI_NEW;
	local szTitle	= string.format("%sÿ��ս��", szMatchName);
	if nFinalType == 1 then
		szTitle	= string.format("%s��������ս��", szMatchName);
	end
	local nAddTime = GetTime();
	local nEndTime = nAddTime + 3600 * 24 * 7;	
	local szMsg	= "";

	szMsg = szMsg .. EPlatForm:GetHelpNewsInfor(self.RankLeagueList, string.format("    <color=yellow>%sս��<color>\n\n", szMatchName));
	Task.tbHelp:AddDNews(nKey, szTitle, szMsg, nEndTime, nAddTime);
end

function EPlatForm:GetHelpNewsInfor(tbLeagueList, szTitle)
	local szMsg = "";
	if #tbLeagueList <= 0 then
		return szMsg;
	end
	szMsg = szMsg .. szTitle;
	for nRank, tbLeague in pairs(tbLeagueList) do
		if nRank > 10 then
			break;
		end
		szMsg = szMsg .. string.format("    <color=yellow>��%s��<color>\n", Lib:Transfer4LenDigit2CnNum(nRank));
		szMsg = szMsg .. string.format("    ս �� ���� <color=green>%s<color>\n", tbLeague.szName);
		szMsg = szMsg .. string.format("    ս�ӳ�Ա�� <color=pink>");
		
		local tbMemberList = EPlatForm:GetLeagueMemberList(tbLeague.szName);
		local tbList = {};
		for i, szName in ipairs(tbMemberList) do
			local nCaptain = League:GetMemberTask(self.LGTYPE, tbLeague.szName, szName, self.LGMTASK_JOB)
			--local nFaction = League:GetMemberTask(self.LGTYPE, tbLeague.szName, szName, self.LGMTASK_FACTION)
			--local nRouteId = League:GetMemberTask(self.LGTYPE, tbLeague.szName, szName, self.LGMTASK_ROUTEID);
			--local szFaction = Player:GetFactionRouteName(nFaction, nRouteId);
			if nCaptain == 1 then
				table.insert(tbList, 1, szName);
			else
				table.insert(tbList, szName);
			end
		end
		for _, szName in pairs(tbList) do
			szMsg = szMsg .. string.format("%s  ", szName);
		end
		szMsg = szMsg .. string.format("<color>\n\n");
	end
	return szMsg;
end

--��ǿ��̬ս��
function EPlatForm:UpdateAdvHelpNews()
	--if not EPlatForm.RankLeagueList then
	--	EPlatForm:LeagueRank(0, 1);
	--	return 0;
	--end
	local tbMacthCfg = EPlatForm:GetMacthTypeCfg(EPlatForm:GetMacthType(nSession));
	local nKey		= Task.tbHelp.NEWSKEYID.NEWS_LEAGUE_ADV;
	local szMatchName = "�ƽ̨";
	if (tbMacthCfg) then
		szMatchName = tbMacthCfg.szName;
	end	
	local szTitle	= string.format("%s��ǿ��ս��", szMatchName);
	if nFinalType == 1 then
		szTitle	= string.format("%s��������ս��", szMatchName);
	end
	local nAddTime = GetTime();
	local nEndTime = nAddTime + 3600 * 24 * 1;	
	local szMsg	= "";

	for nReadyId, tbList in pairs(EPlatForm.AdvMatchLists) do
		szMsg = szMsg .. EPlatForm:GetAdvHelpNewsInfor(tbList, nReadyId)
		GlobalExcute{"EPlatForm:SyncAdvMatchList", nReadyId, tbList}; --ͬ����GS��
	end
	Task.tbHelp:AddDNews(nKey, szTitle, szMsg, nEndTime, nAddTime);
	
end

--��ð���
function EPlatForm:GetAdvHelpNewsInfor(tbLeague, nReadyId)
	local szMsg = "";

	local tbMacthCfg = EPlatForm:GetMacthTypeCfg(EPlatForm:GetMacthType(nSession));
	local szMatchName = "�ƽ̨";
	if (tbMacthCfg) then
		szMatchName = tbMacthCfg.szName;
	end	

	if EPlatForm.AdvMatchState == 5 and tbLeague[2][1] and #tbLeague[2][1].tbResult >= 3 then
		if tbLeague[1] and tbLeague[1][1] then
			szMsg = szMsg .. "\n\n<color=red>����" .. szMatchName .. "�ھ���".. tbLeague[1][1].szName .. "<color>\n";
		else
			szMsg = szMsg .. "\n\n<color=red>����" .. szMatchName .. "�ھ�����˫��սƽ���޹ھ������Ӿ�Ϊ�ڶ���<color>\n";
		end
	end
	
	if #tbLeague[2] > 0 then
		szMsg = szMsg .. "\n\n<color=yellow>���������<color>\n\n";
		local nRank = 1;
		local nVsRank = 2;
		local szName  = "<color=gray>�޲�������<color>";
		local szVsName  = "<color=gray>�޲�������<color>";
		if tbLeague[2][nRank] then
			szName = "<color=pink>" .. tbLeague[2][nRank].szName .. "<color>";
		end
		
		if tbLeague[2][nVsRank] then
			szVsName = "<color=pink>" .. tbLeague[2][nVsRank].szName .. "<color>";
		end
			szMsg = szMsg .. Lib:StrFillR(szName, 37) .. Lib:StrFillC("����", 8) .. szVsName .. "\n";
	end
		
	if #tbLeague[4] > 0 then
		szMsg = szMsg .. "\n\n<color=yellow>��ǿ�������<color>\n\n";
		for nRank=1, 2 do
			local nVsRank = nRank + 2;
			local szName  = "<color=gray>�޲�������<color>";
			local szVsName  = "<color=gray>�޲�������<color>";
			if tbLeague[4][nRank] then
				szName = "<color=pink>" .. tbLeague[4][nRank].szName .. "<color>";
			end
			
			if tbLeague[4][nVsRank] then
				szVsName = "<color=pink>" .. tbLeague[4][nVsRank].szName .. "<color>";
			end
			szMsg = szMsg .. Lib:StrFillR(szName, 37) .. Lib:StrFillC("����", 8) .. szVsName .. "\n";
		end
	end
			
	if #tbLeague[8] > 0 then
		szMsg = szMsg .. "\n\n<color=yellow>��ǿ�������<color>\n\n";
		for nRank=1, 4 do
			local nVsRank = 9 - nRank;
			local szName  = "<color=gray>�޲�������<color>";
			local szVsName  = "<color=gray>�޲�������<color>";
			if tbLeague[8][nRank] then
				szName = "<color=pink>" .. tbLeague[8][nRank].szName .. "<color>";
			end
			
			if tbLeague[8][nVsRank] then
				szVsName ="<color=pink>" .. tbLeague[8][nVsRank].szName .. "<color>";
			end
			szMsg = szMsg .. Lib:StrFillR(szName, 37) .. Lib:StrFillC("����", 8) .. szVsName .. "\n";
		end
	end
	szMsg = szMsg .. "\n\n";
	
	return szMsg;
end

function EPlatForm:UpdateKinRank()
	local tbKinRankList	= EPlatForm:GetUpdateKinRankList();	
	self:UpdateKinRankInfo(tbKinRankList);
	if (MODULE_GC_SERVER) then
		if (not tbKinRankList) then
			return 0;
		end
		if (tbKinRankList) then
			local nIndex = #tbKinRankList;
			if (nIndex > self.MAX_KINRANK_NEXTMATCH) then
				nIndex = self.MAX_KINRANK_NEXTMATCH;
			end
			local tbInfo = tbKinRankList[nIndex];
			if (tbInfo) then
				local pKin = KKin.FindKin(tbInfo[1]);
				if (pKin) then
					local nScore = pKin.GetPlatformScore();
					KGblTask.SCSetDbTaskInt(self.GTASK_MACTH_MAX_SCORE_FOR_NEXT, nScore);
				end
			end			
		end
	end
	if (MODULE_GC_SERVER) then
		GlobalExcute{"EPlatForm:LoadKinLeagueInfo"};
	end	
	return 0;
end

-- ʱ�����¼�
function EPlatForm:OnScheduePlatformEvent()
	local nState = EPlatForm:GetMacthState();

	local nRankSession	= EPlatForm:GetMacthSession();
	
	if (nRankSession <= 0) then
		return 0;
	end

	if (nState == self.DEF_STATE_REST or nState == self.DEF_STATE_CLOSE) then
		return 0;
	end

	local nNowTime = GetTime();
	local nDay = tonumber(os.date("%d", nNowTime));
	if (self.DEF_DEADLINE_CHECKDAY + self.DATE_START_DAY[1][2] + 1 == nDay) then
		self:SetAllLeagueToFormat();
	end
	
	local nState = EPlatForm:GetMacthState();
	if (nState == self.DEF_STATE_MATCH_1) then
		self:UpdateKinRank();
	end
	
	if (nState == self.DEF_STATE_MATCH_2) then
		self:LeagueRank(0);
	end
end
