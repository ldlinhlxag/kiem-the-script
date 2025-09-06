--�ƽ̨
--zhouchenfei
--2009.08.13
if (MODULE_GC_SERVER) then
	return 0;
end

function EPlatForm:CheckLeagueType(tbLimitList, tbMacthCfg)
	return 0
end

--��齨��ս���Ƿ�����������ͣ�����1�����ϣ�0Ϊ���ϣ�
function EPlatForm:CheckCreateLeague(pMyPlayer, tbPlayerIdList, tbMacthTypeCfg)
	return 0, "";
end

--������ս���Ƿ�����������ͣ�����1�����ϣ�0Ϊ���ϣ�
function EPlatForm:CheckJoinLeague(pMyPlayer, szLeagueName, tbPlayerIdList, tbJoinPlayerList, tbMacthTypeCfg)
	return 0;
end

--��ҽ���׼������������
function EPlatForm:SetStateJoinIn(nGroupId)
	me.ClearSpecialState()		--�������״̬
	me.RemoveSkillStateWithoutKind(Player.emKNPCFIGHTSKILLKIND_CLEARDWHENENTERBATTLE) --���״̬
	me.DisableChangeCurCamp(1);	--���������йصı������������ھ�����ս�ı�ĳ�������Ӫ�Ĳ���
	me.SetFightState(1);	  	--����ս��״̬
	me.SetLogoutRV(1);			--����˳�ʱ������RV�������´ε���ʱ��RV(���������㣬���˳���)
	me.ForbidEnmity(1);			--��ֹ��ɱ
	me.DisabledStall(1);		--��̯
	me.ForbitTrade(1);			--����
	me.ForbidExercise(1);		-- ��ֹ�д�
	--me.nPkModel = Player.emKPK_STATE_PRACTISE;
	me.SetCurCamp(nGroupId);
	me.TeamDisable(1);			--��ֹ���
	me.TeamApplyLeave();		--�뿪����
	me.StartDamageCounter();	--��ʼ�����˺�
	Faction:SetForbidSwitchFaction(me, 1); -- ����׼�����������Ͳ����л�����
	me.SetDisableZhenfa(1);
	me.nForbidChangePK	= 1;
end

--����뿪׼������������
function EPlatForm:LeaveGame()
	me.SetFightState(0);
	me.SetCurCamp(me.GetCamp());
	me.StopDamageCounter();	-- ֹͣ�˺�����
	me.DisableChangeCurCamp(0);
	me.nPkModel = Player.emKPK_STATE_PRACTISE;--�ر�PK����
	me.nForbidChangePK	= 0;
	me.SetDeathType(0);
	me.RestoreMana();
	me.RestoreLife();
	me.RestoreStamina();
	me.DisabledStall(0);	--��̯
	me.TeamDisable(0);		--��ֹ���
	me.ForbitTrade(0);		--����
	me.ForbidEnmity(0);
	me.ForbidExercise(0);		-- �д�
	Faction:SetForbidSwitchFaction(me, 0); -- ����׼�������������л����ɻ�ԭ
	me.SetDisableZhenfa(0);
	me.LeaveTeam();
	--me.SetLogOutState(0);       --�������ʱҲ���Ե���LOGOUT
end

--����
local function OnSort(tbA, tbB)
	if tbA.nWinRate == tbB.nWinRate then
		return tbA.nWinRate < tbB.nWinRate
	end 
	return tbA.nWinRate > tbB.nWinRate;
end
 
--׼�������������ƥ�����
function EPlatForm:GameMatch(tbLeagueList)
	table.sort(tbLeagueList, OnSort);
	local tbLeagueA = {};
	local tbLeagueB = {};
	
	--ƥ��ԭ��:.....�ݶ�10��Ϊһ������;
	--��ʤ��,ÿN��Ϊһ������.����ÿ�����������
	--�Ӹ�ʤ���������,�����Ѿ������ս��,���������,�������һ��ս���Ѿ����,�����ڶ�����,
	--�Եڶ�������б���,���ѭ��.һֱ���������...���һ�������κ����������ƥ��..
	local tbMatchLeague = {};
	
	--������
	local nDefArea = self.MAP_SELECT_SUBAREA;
	local nSubArea = 0;
	for i, tbLeague in ipairs(tbLeagueList) do
		if i > nSubArea * nDefArea then
			nSubArea = nSubArea + 1;
			tbMatchLeague[nSubArea] = {};
		end
		table.insert(tbMatchLeague[nSubArea], tbLeague);
	end
	local nMaxArea = #tbMatchLeague;
	for nArea, tbAreaLeague in ipairs(tbMatchLeague) do
		--��������˳��.
		for i, tbLeague in ipairs(tbAreaLeague) do
			local nP = MathRandom(1, #tbAreaLeague);
			tbAreaLeague[i], tbAreaLeague[nP] = tbAreaLeague[nP], tbAreaLeague[i];
		end
		local nMaxCount = #tbAreaLeague;
		for i=1, nMaxCount do
			if tbAreaLeague[i] then
				local tbTempAreaLeague = {};
				local nTempMatchCount = 0;
				for j=i+1, nMaxCount  do
					if tbAreaLeague[j] then
						tbTempAreaLeague[j] = tbAreaLeague[j];
						nTempMatchCount = nTempMatchCount + 1;
					end
				end
				--���û��ƥ�����,���������һ������,���ֿ�,����A��
				if nTempMatchCount == 0 and nArea ==  nMaxArea then
					table.insert(tbLeagueA, tbAreaLeague[i]);
					break;
				end
				
				--���û��ƥ�����,���������һ������,���ս�Ӽ��뵽�¸�����
				if nTempMatchCount == 0 and nArea <  nMaxArea then
					table.insert(tbMatchLeague[nArea+1], tbAreaLeague[i]);
					break;
				end
				
				local nFindMatch = 0;
				--��ƥ�����,����ƥ��
				for nAreaLeagueId, tbTempLeague in pairs(tbTempAreaLeague) do
					if not tbAreaLeague[i].tbHistory[tbTempLeague.nNameId] 
					and not tbTempLeague.tbHistory[tbAreaLeague[i].nNameId] then
						table.insert(tbLeagueA, tbAreaLeague[i]);
						table.insert(tbLeagueB, tbAreaLeague[nAreaLeagueId]);
						tbAreaLeague[i] = nil;
						tbAreaLeague[nAreaLeagueId] = nil;
						nFindMatch = 1;
						break;
					end
				end
				
				--û�ҵ�ƥ�����������,���������һ���������ǿ��ƥ��
				if nFindMatch == 0 and nArea == nMaxArea then
					for nAreaLeagueId, tbTempLeague in pairs(tbTempAreaLeague) do
						table.insert(tbLeagueA, tbAreaLeague[i]);
						table.insert(tbLeagueB, tbAreaLeague[nAreaLeagueId]);
						tbAreaLeague[i] = nil;
						tbAreaLeague[nAreaLeagueId] = nil;
						nFindMatch = 1;
						break;
					end
				end
				
				--û�ҵ�ƥ�����������,�������һ������,�����¸�����
				if nFindMatch == 0 and nArea < nMaxArea then
					table.insert(tbMatchLeague[nArea+1], tbAreaLeague[i]);
				end				
				
			end
		end
	end

	if #tbLeagueA < #tbLeagueB then
		return tbLeagueB, tbLeagueA;
	end
	
	return tbLeagueA, tbLeagueB;
end

--��ǿ��ƥ��
function EPlatForm:GameMatchAdv(nReadyId, tbSortLeague)
	local tbAdvLeagueList = {};
	for _, tbLeague in pairs(tbSortLeague) do
		if tbLeague.nRank == 0 or tbLeague.nRank > 8 then
			EPlatForm:GameMatchAdvKickLeague(tbLeague, nReadyId, "����ս��û���ʸ�μӼ��徺������")
		else
			if EPlatForm.MACTH_STATE_ADV_TASK[EPlatForm.AdvMatchState] == 8 then
				tbAdvLeagueList[tbLeague.nRank] = tbLeague;
			elseif EPlatForm.MACTH_STATE_ADV_TASK[EPlatForm.AdvMatchState] == 4 then
				local nSeries = EPlatForm:GetAdvMatchSeries(tbLeague.nRank, 8);
				tbAdvLeagueList[nSeries] = tbLeague;
			elseif EPlatForm.MACTH_STATE_ADV_TASK[EPlatForm.AdvMatchState] == 2 then
				local nSeries = EPlatForm:GetAdvMatchSeries(tbLeague.nRank, 4);
				tbAdvLeagueList[nSeries] = tbLeague;				
			end
		end
	end
	
	local tbLeagueA = {};
	local tbLeagueB = {};

	--��ǿ��
	if EPlatForm.MACTH_STATE_ADV_TASK[EPlatForm.AdvMatchState] == 8 then
		for nRank = 1, 4 do 
			local nVsLeagueRank = 9 - nRank;
			local tbLeagueA1, tbLeagueB1 = EPlatForm:GetGameMatchAdvLogic1(tbAdvLeagueList, nReadyId, nRank, nVsLeagueRank, 4, 8);
			if tbLeagueA1 and tbLeagueB1 then
				table.insert(tbLeagueA, tbLeagueA1);
				table.insert(tbLeagueB, tbLeagueB1);		
			end
		end
	end
	
	--��ǿ��
	if EPlatForm.MACTH_STATE_ADV_TASK[EPlatForm.AdvMatchState] == 4 then
		for nRank = 1, 2 do 
			local nVsLeagueRank = nRank + 2;
			local tbLeagueA1, tbLeagueB1 = EPlatForm:GetGameMatchAdvLogic1(tbAdvLeagueList, nReadyId, nRank, nVsLeagueRank, 2, 4);
			if tbLeagueA1 and tbLeagueB1 then
				table.insert(tbLeagueA, tbLeagueA1);
				table.insert(tbLeagueB, tbLeagueB1);		
			end
		end
	end
	
	--����
	if EPlatForm.MACTH_STATE_ADV_TASK[EPlatForm.AdvMatchState] == 2 then
		local nRank = 1; 
		local nVsLeagueRank = 2;
		local tbLeagueA1, tbLeagueB1 = EPlatForm:GetGameMatchAdvLogic2(tbAdvLeagueList, nReadyId);
		if tbLeagueA1 and tbLeagueB1 then
			table.insert(tbLeagueA, tbLeagueA1);
			table.insert(tbLeagueB, tbLeagueB1);		
		end
	end
	return tbLeagueA, tbLeagueB;
end

function EPlatForm:GetGameMatchAdvLogic1(tbAdvLeagueList, nReadyId, nRank, nVsLeagueRank, nWinCamp, nLostCamp)
	if not tbAdvLeagueList[nRank] and not tbAdvLeagueList[nVsLeagueRank] then
		if EPlatForm.AdvMatchLists[nReadyId][nLostCamp][nRank] then
			EPlatForm.AdvMatchLists[nReadyId][nWinCamp][nRank] = EPlatForm.AdvMatchLists[nReadyId][nLostCamp][nRank];
			local szLeagueName = EPlatForm.AdvMatchLists[nReadyId][nWinCamp][nRank].szName;
			League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK_ADV, nWinCamp);
			EPlatForm:MacthAward(szLeagueName, nil, {}, 1, 0);
		end
		if EPlatForm.AdvMatchLists[nReadyId][nLostCamp][nVsLeagueRank] then
			local szLeagueName = EPlatForm.AdvMatchLists[nReadyId][nLostCamp][nVsLeagueRank].szName;
			League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK_ADV, nLostCamp);
		end
		return 0;	
	end
	
	if not tbAdvLeagueList[nRank] and tbAdvLeagueList[nVsLeagueRank] then
		if EPlatForm.AdvMatchLists[nReadyId][nLostCamp][nRank] then
			local szLeagueName = EPlatForm.AdvMatchLists[nReadyId][nLostCamp][nRank].szName;
			League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK_ADV, nLostCamp);
		end
		if EPlatForm.AdvMatchLists[nReadyId][nLostCamp][nVsLeagueRank] then
			local szLeagueName = EPlatForm.AdvMatchLists[nReadyId][nLostCamp][nVsLeagueRank].szName;
			League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK_ADV, nWinCamp);
		end
		EPlatForm:MacthAward(tbAdvLeagueList[nVsLeagueRank].szName, nil, {}, 1, 0);
		EPlatForm:GameMatchAdvKickLeague(tbAdvLeagueList[nVsLeagueRank], nReadyId, "��Ϊ��Ķ���ȱϯ��������ս�ӻ����ʤ��");			
		return 0;
	end
	
	if tbAdvLeagueList[nRank] and not tbAdvLeagueList[nVsLeagueRank] then
		if EPlatForm.AdvMatchLists[nReadyId][nLostCamp][nRank] then
			local szLeagueName = EPlatForm.AdvMatchLists[nReadyId][nLostCamp][nRank].szName;
			League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK_ADV, nWinCamp);
		end
		if EPlatForm.AdvMatchLists[nReadyId][nLostCamp][nVsLeagueRank] then
			local szLeagueName = EPlatForm.AdvMatchLists[nReadyId][nLostCamp][nVsLeagueRank].szName;
			League:SetLeagueTask(EPlatForm.LGTYPE, szLeagueName, EPlatForm.LGTASK_RANK_ADV, nLostCamp);
		end
		EPlatForm:MacthAward(tbAdvLeagueList[nRank].szName, nil, {}, 1, 0);
		EPlatForm:GameMatchAdvKickLeague(tbAdvLeagueList[nRank], nReadyId, "��Ϊ��Ķ���ȱϯ��������ս�ӻ����ʤ��");
		return 0;
	end
	
	return tbAdvLeagueList[nRank], tbAdvLeagueList[nVsLeagueRank];
end

--1Ϊ��ʤ��2Ϊƽ��3Ϊ��, 4Ϊ�ֿջ�ʤ
function EPlatForm:GetGameMatchAdvLogic2(tbAdvLeagueList, nReadyId)
	if not tbAdvLeagueList[1] and not tbAdvLeagueList[2] then
		if EPlatForm.AdvMatchLists[nReadyId][2][1] then
			EPlatForm.AdvMatchLists[nReadyId][2][1].tbResult[EPlatForm.AdvMatchState - 2] = 4;
		end
		if EPlatForm.AdvMatchLists[nReadyId][2][2] then
			EPlatForm.AdvMatchLists[nReadyId][2][2].tbResult[EPlatForm.AdvMatchState - 2] = 4;
		end
		if EPlatForm.AdvMatchLists[nReadyId][2][1] and EPlatForm.AdvMatchState == 5 then
			EPlatForm:SetAdvMacthResult(nReadyId);
		end
		return 0;	
	end
	
	if not tbAdvLeagueList[1] and tbAdvLeagueList[2] then
		if EPlatForm.AdvMatchLists[nReadyId][2][1] then
			EPlatForm.AdvMatchLists[nReadyId][2][1].tbResult[EPlatForm.AdvMatchState - 2] = 3;
		end
		if EPlatForm.AdvMatchLists[nReadyId][2][2] then
			EPlatForm.AdvMatchLists[nReadyId][2][2].tbResult[EPlatForm.AdvMatchState - 2] = 1;
		end
		EPlatForm:MacthAward(tbAdvLeagueList[2].szName, nil, {}, 1, 0);
		EPlatForm:GameMatchAdvKickLeague(tbAdvLeagueList[2], nReadyId, "��Ϊ��Ķ���ȱϯ��������ս�ӻ����ʤ��");			
		if EPlatForm.AdvMatchLists[nReadyId][2][1] and EPlatForm.AdvMatchState == 5 then
			EPlatForm:SetAdvMacthResult(nReadyId);
		end
		return 0;
	end
	
	if tbAdvLeagueList[1] and not tbAdvLeagueList[2] then
		if EPlatForm.AdvMatchLists[nReadyId][2][1] then
			EPlatForm.AdvMatchLists[nReadyId][2][1].tbResult[EPlatForm.AdvMatchState - 2] = 1;
		end
		if EPlatForm.AdvMatchLists[nReadyId][2][2] then
			EPlatForm.AdvMatchLists[nReadyId][2][2].tbResult[EPlatForm.AdvMatchState - 2] = 3;
		end
		EPlatForm:MacthAward(tbAdvLeagueList[1].szName, nil, {}, 1, 0);
		EPlatForm:GameMatchAdvKickLeague(tbAdvLeagueList[1], nReadyId, "��Ϊ��Ķ���ȱϯ��������ս�ӻ����ʤ��");
		if EPlatForm.AdvMatchLists[nReadyId][2][1] and EPlatForm.AdvMatchState == 5 then
			EPlatForm:SetAdvMacthResult(nReadyId);
		end
		return 0;
	end
	
	return tbAdvLeagueList[1], tbAdvLeagueList[2];
end

function EPlatForm:GameMatchAdvKickLeague(tbLeague, nReadyId, szMsg)
	local nLeaveId = nil;
	
	local tbKickList = {};
	for _, nPlayerId in pairs(tbLeague.tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			tbKickList[nPlayerId] = pPlayer.szName;
		end
	end;
	
	for nPlayerId in pairs(tbKickList) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			nLeaveId = self:KickPlayer(pPlayer, szMsg, nLeaveId);
			Dialog:SendBlackBoardMsg(pPlayer, szMsg);
		end
	end
	
	self.GroupList[nReadyId][tbLeague.szName] = nil;	
end

function EPlatForm:ClearReadyMap()
end

--���������ƥ�����
function EPlatForm:EnterPkMapRule()
	local tbMCfg = EPlatForm:GetMacthTypeCfg(EPlatForm:GetMacthType());
	if (not tbMCfg) then
		return 0;
	end
	
	local tbMacthCfg = tbMCfg.tbMacthCfg;
	for nReadyId, tbMissions in pairs(self.MissionList) do
		if not self.GroupList[nReadyId] then
			self.GroupList[nReadyId] = {};
		end
		--���ͽ����������,ƥ��ԭ��;
		local tbSortLeague = {};
		for szLeagueName, tbLeague in pairs(self.GroupList[nReadyId]) do
			local tbTemp = {szName = szLeagueName, 
				nNameId 		= tbLeague.nNameId , 
				nWinRate 		= tbLeague.nWinRate, 
				tbPlayerList 	= tbLeague.tbPlayerList, 
				tbHistory		= tbLeague.tbHistory,
				nRankAdv		= tbLeague.nRankAdv,
				nRank			= tbLeague.nRank,
				nPlayerNum		= #tbLeague.tbPlayerList,};
			table.insert(tbSortLeague, tbTemp);
		end
		
		local tbMisFlag = {};
		
		--����ǰ�ǿ����ƥ�����
		if EPlatForm:GetMacthState() == EPlatForm.DEF_STATE_ADVMATCH then
			local tbLeagueA, tbLeagueB = EPlatForm:GameMatchAdv(nReadyId, tbSortLeague);
			for i in pairs(tbLeagueA) do
				for nId, tbMission in pairs(tbMissions) do
					if (not tbMisFlag[nId] or tbMisFlag[nId] ~= 1) then
						EPlatForm:OnMacthPkStart(tbMission, nId, nReadyId, tbLeagueA[i], tbLeagueB[i], i);
						tbMisFlag[nId] = 1;
						break;
					end
				end
			end
		elseif (EPlatForm:GetMacthState() == EPlatForm.DEF_STATE_MATCH_1) then
			EPlatForm:OnMacthPkStart_Single(tbMissions, nReadyId);
		elseif #tbSortLeague < EPlatForm.MACTH_LEAGUE_MIN then
			local tbLeagueOut = {};
			for _, tbLeague in pairs(tbSortLeague) do
				tbLeagueOut[tbLeague.szName] = {};
				for _, nPlayerId in pairs(tbLeague.tbPlayerList) do
					tbLeagueOut[tbLeague.szName][nPlayerId] = 1;
				end
			end
			
			for szName, tbLeague in pairs(tbLeagueOut) do
				local nLeaveId = nil;
				for nPlayerId in pairs(tbLeague) do
					local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
					if pPlayer then
						nLeaveId = self:KickPlayer(pPlayer, string.format("�������鲻��%s�ӣ������޷�����", EPlatForm.MACTH_LEAGUE_MIN), nLeaveId);
						Dialog:SendBlackBoardMsg(pPlayer, string.format("�������鲻��%s�ӣ������޷�����", EPlatForm.MACTH_LEAGUE_MIN))
					end
				end
				League:SetLeagueTask(EPlatForm.LGTYPE, szName, EPlatForm.LGTASK_ENTER, 0);
				self.GroupList[nReadyId][szName] = nil;
			end

			for nId, tbMission in pairs(tbMissions) do
				if tbMission:IsOpen() ~= 0 then
					tbMission:CloseGame();
				end
			end
		else
			local tbKickPlayerList = {};
			local tbEnterPlayerList = {};
			
			for _, tbList in pairs(tbSortLeague) do
				local nCount = self:GetTeamEventCount(tbList.szName);
				if (tbList.nPlayerNum < self.MIN_TEAM_EVENT_NUM or nCount <= 0) then
					tbKickPlayerList[#tbKickPlayerList + 1] = tbList;
				else
					tbEnterPlayerList[#tbEnterPlayerList + 1] = tbList;
				end
			end
			
			--logͳ��
			KStatLog.ModifyAdd("eventplantform", string.format("�ƽ̨"), "����", #tbEnterPlayerList);

			local tbLeagueA, tbLeagueB = EPlatForm:GameMatch(tbEnterPlayerList);
			for i, tbMatchLeague in pairs(tbLeagueA) do
				if not tbLeagueB[i] then
					--�ֿ�;
					local tbAwardList = {};
					for _, nId in pairs(tbLeagueA[i].tbPlayerList) do
						local pPlayer = KPlayer.GetPlayerObjById(nId);
						if pPlayer then
							tbAwardList[nId] = pPlayer.szName;
						end
					end
					
--					EPlatForm:MacthAward(tbLeagueA[i].szName, nil, tbAwardList, 4, EPlatForm.MACTH_TIME_BYE)
					--����
					
					local nLeaveId = nil;
					for nId, szName in pairs(tbAwardList) do
						local pPlayer = KPlayer.GetPlayerObjById(nId);
						if pPlayer then
							nLeaveId = self:KickPlayer(pPlayer, "�����ֿ�", nLeaveId);
							Dialog:SendBlackBoardMsg(pPlayer, "�����ֿ�..")
						end					
					end
					self.GroupList[nReadyId][tbLeagueA[i].szName] = nil;
					break;
				end
				for nId, tbMission in pairs(tbMissions) do
					if (not tbMisFlag[nId] or tbMisFlag[nId] ~= 1) then
						EPlatForm:OnMacthPkStart(tbMission, nId, nReadyId, tbLeagueA[i], tbLeagueB[i], i);
						tbMisFlag[nId] = 1;
						break;
					end
				end
			end
			for i, tbList in pairs(tbKickPlayerList) do
				local nLeaveId = nil;
				local tbTemp = Lib:CopyTB1(tbList.tbPlayerList);
				for j, nPlayerId in pairs(tbTemp) do
					local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
					if pPlayer then
						nLeaveId = self:KickPlayer(pPlayer, string.format("���Ӳμӻ����������%d�˲��ܱ���", self.MIN_TEAM_EVENT_NUM), nLeaveId);
					end					
				end
				self.GroupList[nReadyId][tbList.szName] = nil;
			end
		end
	end	
end

function EPlatForm:OnMacthPkStart_Single(tbMissions, nReadyId)
	local tbCfg			 = EPlatForm:GetMacthTypeCfg(EPlatForm:GetMacthType());
	if (not tbCfg) then
		self:WriteLog("OnMacthPkStart_Single", "error OnMacthPkStart_Single not tbCfg");
		return 0;
	end
	local nGamePlayerMax = self.nCurMatchMaxTeamCount;
	local nGamePlayerMin = self.nCurMatchMinTeamCount;
	local nReadyMapId	 = tbCfg.tbReadyMap[nReadyId];
	
	if (not nReadyMapId or nReadyMapId <= 0) then
		return 0;
	end
	
	local tbList = self.GroupList[nReadyId];
	
	local nGroupDivide  = 0;
	local tbKickPlayerList = {};
	local nDynMapIndex	= 1;
	local nLoopMaxCount = 0;
	local nCurReadyMapId = tbCfg.tbReadyMap[nReadyId] or 0;
	
	local tbMission = nil;
	local tbMisFlag	= {};
	local nDynId	= 0;
	
	for nId, tbMis in pairs(tbMissions) do
		if (not tbMisFlag[nId] or tbMisFlag[nId] ~= 1) then
			tbMission = tbMis;
			tbMisFlag[nId] = 1;
			nDynId = nId;
			break;
		end
	end
	
	local nMaxLeaguCount = tbList.nLeagueCount;
	
	local tbTemp = {};
	local tbName2Id = {};
	for szLeagueName, tbGroup in pairs(tbList) do
		if (tbGroup) then
			tbTemp[#tbTemp + 1] = tbGroup;
			tbName2Id[#tbTemp]	= szLeagueName;
		end
	end
	
	for nGroup, tbGroup in ipairs(tbTemp) do
		if nGroupDivide == 0 then
			--�ж��Ƿ�4��
			if not tbTemp[nGroup + (nGamePlayerMin-1)] then
				--���治��4�飬�߳�������
				for nKickGroup = nGroup, #tbTemp do
					if (not tbTemp[nKickGroup].tbPlayerList) then
						tbTemp[nKickGroup].tbPlayerList = {};
					end
					for _, nPlayerId in pairs(tbTemp[nKickGroup].tbPlayerList) do
						local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
						if pPlayer then
							table.insert(tbKickPlayerList, pPlayer);
						end
					end
				end
				break;
			end
		end
		if (not tbGroup.tbPlayerList) then
			tbGroup.tbPlayerList = {};
		end
		
		for _, nPlayerId in pairs(tbGroup.tbPlayerList) do
			local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
			--���󣬷��䶯̬��ͼ��������ţ�
			if pPlayer then
				local nCurMapId = pPlayer.GetWorldPos();
				if (nCurMapId == nCurReadyMapId and tbMission) then
					local tbEnterPos	= tbMission:GetEnterPos();
					local nCount		= self:GetPlayerEventCount(pPlayer);
					if (tbEnterPos and nCount > 0) then
						local nCountFlag = self:CheckEnterCount(pPlayer, tbCfg.tbMacthCfg.tbJoinItem);
						-- û�в�����Ʒ�Ͳ��ܲ���
						if (nCountFlag <= 0 or nCountFlag > 1) then
							table.insert(tbKickPlayerList, pPlayer);
						else
							if (tbEnterPos[1] > 0) then
								pPlayer.NewWorld(tbEnterPos[1], tbEnterPos[2], tbEnterPos[3]);
								self:SetPlayerDynId(pPlayer, nDynId);
								local tbTemp = {};
								tbTemp.szLeagueName = pPlayer.szName;
								tbTemp.tbPlayerList = { nPlayerId };
								tbMission:JoinGame(tbTemp, 0, tbCfg.tbMacthCfg.tbJoinItem);
								local nCount = self:GetPlayerEventCount(pPlayer);
								nCount = nCount - 1;
								if (nCount < 0) then
									nCount = 0;
								end
								self:UseMatchItem(pPlayer, 1, tbCfg.tbMacthCfg.tbJoinItem, tbCfg.tbMacthCfg.nEnterItemCount);
								self:SetPlayerEventCount(pPlayer, nCount);
								self:AddPlayerTotalCount(pPlayer, 1);
								nGroupDivide = nGroupDivide + 1;
							end
						end
					else
						table.insert(tbKickPlayerList, pPlayer);
					end
				end
			end
		end		
		if nGroupDivide >= nGamePlayerMax then
			nGroupDivide = 0;
			nDynMapIndex = nDynMapIndex + 1;

			for nId, tbMis in pairs(tbMissions) do
				if (not tbMisFlag[nId] or tbMisFlag[nId] ~= 1) then
					tbMission = tbMis;
					tbMisFlag[nId] = 1;
					break;
				end
			end

		end
	end
	for _, pPlayer in pairs(tbKickPlayerList) do
		self:KickPlayer(pPlayer);
		local szMsg = string.format("�㱻������䵽�����в���%d�ˣ����ܿ������������³��ٴβ�����", nGamePlayerMin);
		Dialog:SendBlackBoardMsg(pPlayer, szMsg);
		pPlayer.Msg(string.format("<color=green>%s<color>",szMsg));
		pPlayer.AddStackItem(18, 1, 80, 1,nil, 2);
	end
	self.GroupList[nReadyId] = nil;
end

function EPlatForm:OnMacthPkStart(tbMission, nDynId, nReadyId, tbLeagueA, tbLeagueB)
	local tbMacthCfg = EPlatForm:GetMacthTypeCfg(EPlatForm:GetMacthType());
	if (not tbMacthCfg) then
		return 0;
	end
	local nGamePlayerMax = tbMacthCfg.tbMacthCfg.nPlayerCount;
	local tbEnterPos	= tbMission:GetEnterPos();
	local nMatchPatch, nPosX, nPosY 	 = 0, 0, 0;
	if (tbEnterPos) then
		nMatchPatch, nPosX, nPosY = tbEnterPos[1] or 0, tbEnterPos[2] or 0, tbEnterPos[3] or 0;
	end
	
	if SubWorldID2Idx(nMatchPatch) < 0 then
		print("Error!!!", "���ͼû�п���", nMatchPatch);
		return 0;
	end 
	
	--ս�����ݼ�¼
	EPlatForm:AddMacthLeague(tbLeagueA.szName, tbLeagueB.nNameId);
	EPlatForm:AddMacthLeague(tbLeagueB.szName, tbLeagueA.nNameId);
	
	local szMatchMsgA = string.format("���Ķ���ս���ǣ�<color=green>%s<color=yellow>", tbLeagueA.szName);
	local szMatchMsgB = string.format("���Ķ���ս���ǣ�<color=green>%s<color=yellow>", tbLeagueB.szName);
	local tbPlayerMatchListA = {};
	local tbPlayerMatchListB = {};
	local nPlayerCountA = 0;
	local nPlayerCountB = 0;
	local nLeaveId = nil;
	for _, nId in pairs(tbLeagueA.tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			if nPlayerCountA >= nGamePlayerMax then
				nLeaveId = self:KickPlayer(pPlayer, "��ս����ʽ��Ա�ѽ����������<color=yellow>����Ϊ�油����������ȴ����<color>��", nLeaveId);
			else
				nPlayerCountA = nPlayerCountA + 1;
				table.insert(tbPlayerMatchListA, nId);
				szMatchMsgA = szMatchMsgA .. "\n���֣�" .. pPlayer.szName;
			end
		end
	end
	local nLeaveId = nil;
	for _, nId in pairs(tbLeagueB.tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			if nPlayerCountB >= nGamePlayerMax then
				nLeaveId = self:KickPlayer(pPlayer, "��ս����ʽ��Ա�ѽ��������������Ϊ�油����������ȴ������", nLeaveId);							
			else
				nPlayerCountB = nPlayerCountB + 1;
				table.insert(tbPlayerMatchListB, nId);							
				szMatchMsgB = szMatchMsgB .. "\n���֣�" .. pPlayer.szName;
			end
		end
	end
	
	--��Ӫ1
	local nCaptionAId = 0;
	local tbTempA = {};
	tbTempA.szLeagueName = tbLeagueA.szName;
	tbTempA.tbPlayerList = {};
	for _, nId in pairs(tbPlayerMatchListA) do
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			if nCaptionAId == 0 then
				KTeam.CreateTeam(nId);	--��������
				nCaptionAId = nId;
			else
				KTeam.ApplyJoinPlayerTeam(nCaptionAId, nId);	--�������
			end
			EPlatForm.MACTH_ENTER_FLAG[nId] = 1;
			pPlayer.NewWorld(nMatchPatch, nPosX, nPosY);
			self:SetPlayerDynId(pPlayer, nDynId);
			tbTempA.tbPlayerList[#tbTempA.tbPlayerList + 1] = nId;
			pPlayer.Msg(szMatchMsgB);
		end
	end
	tbMission:JoinGame(tbTempA, 1, tbMacthCfg.tbMacthCfg.tbJoinItem);
	local nCount = self:GetTeamEventCount(tbTempA.szLeagueName);
	nCount = nCount - 1;
	if (nCount < 0) then
		nCount = 0;
	end
	GCExcute{"EPlatForm:SetTeamEventCount", tbTempA.szLeagueName, nCount};
	
	for _, nId in pairs(tbPlayerMatchListA) do
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			self:UseMatchItem(pPlayer, 1, tbMacthCfg.tbMacthCfg.tbJoinItem, tbMacthCfg.tbMacthCfg.nEnterItemCount);
		end
	end	

	
	--��Ӫ2
	local tbTempB = {};
	tbTempB.szLeagueName = tbLeagueB.szName;
	tbTempB.tbPlayerList = {};
	local nCaptionBId = 0;
	for _, nId in pairs(tbPlayerMatchListB) do
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			if nCaptionBId == 0 then
				KTeam.CreateTeam(nId);	--��������
				nCaptionBId = nId;
			else
				KTeam.ApplyJoinPlayerTeam(nCaptionBId, nId);	--�������
			end
			EPlatForm.MACTH_ENTER_FLAG[nId] = 1;
			pPlayer.NewWorld(nMatchPatch, nPosX, nPosY);
			self:SetPlayerDynId(pPlayer, nDynId);
			tbTempB.tbPlayerList[#tbTempB.tbPlayerList + 1] = nId;
			pPlayer.Msg(szMatchMsgA);
		end
	end
	tbMission:JoinGame(tbTempB, 2, tbMacthCfg.tbMacthCfg.tbJoinItem);
	nCount = self:GetTeamEventCount(tbTempB.szLeagueName);
	nCount = nCount - 1;
	if (nCount < 0) then
		nCount = 0;
	end
	GCExcute{"EPlatForm:SetTeamEventCount", tbTempB.szLeagueName, nCount};
	
	for _, nId in pairs(tbPlayerMatchListB) do
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			self:UseMatchItem(pPlayer, 1, tbMacthCfg.tbMacthCfg.tbJoinItem, tbMacthCfg.tbMacthCfg.nEnterItemCount);
		end
	end		

	
	self.GroupList[nReadyId][tbLeagueB.szName] = nil;
	self.GroupList[nReadyId][tbLeagueA.szName] = nil;	
end

function EPlatForm:SendResult(tbResultList, nReadyId)
	if (EPlatForm:GetMacthState() == EPlatForm.DEF_STATE_ADVMATCH) then
		self:Award2PvpMatch(tbResultList, nReadyId);
	elseif (EPlatForm:GetMacthState() == EPlatForm.DEF_STATE_MATCH_1) then
		self:AwardWeleeMatch(tbResultList);
	elseif (EPlatForm:GetMacthState() == EPlatForm.DEF_STATE_MATCH_2) then
		self:Award2PvpMatch(tbResultList, nReadyId);
	end
end

function EPlatForm:AwardWeleeMatch(tbPlayerList)
	if (not tbPlayerList) then
		return;
	end
	-- ���ｱ��Ҫ��һ��
	for nRank, tbGroup in ipairs(tbPlayerList) do
		if (tbGroup.tbPlayerList) then
			for nIndex, nPlayerId in pairs(tbGroup.tbPlayerList) do
				local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
				self:GiveWeleeAwardToPlayer(pPlayer, nRank);
			end
		end
	end
end

function EPlatForm:GiveWeleeAwardToPlayer(pPlayer, nRank)
	if (not pPlayer or not nRank or nRank <= 0) then
		return 0;
	end
	
	local nState			= EPlatForm:GetMacthState();
	local nSession			= EPlatForm:GetMacthSession();
	local nMacthType		= EPlatForm:GetMacthType();
	local tbMacth			= EPlatForm:GetMacthTypeCfg(nMacthType);
	local szMatchName	= "���徺��";
	if (tbMacth) then
		szMatchName	= 	tbMacth.szName;
	end	

	pPlayer.Msg(string.format("���ڱ���������л�õ�<color=yellow>%d<color>��", nRank));
	if (nRank > 0 and nRank <= 5) then
		pPlayer.SendMsgToFriend(string.format("���ĺ���[%s]�ڸոս�����%s��л�õ�<color=yellow>%d<color>����", pPlayer.szName, szMatchName, nRank));
	end
	local nAwardFlag = self:SetAwardFlagParam(0, nSession, nState, nRank);
	self:SetAwardParam(pPlayer, nAwardFlag);
	local nHonor = 0;
	if	EPlatForm.AWARD_WELEE_LIST[nSession] and 
	 	EPlatForm.AWARD_WELEE_LIST[nSession][nRank] and 
	 	EPlatForm.AWARD_WELEE_LIST[nSession][nRank].honor then
		nHonor = EPlatForm.AWARD_WELEE_LIST[nSession][nRank].honor[1];
	end
	self:SetEventScore(pPlayer.nId, nHonor, 1, 1);
end

function EPlatForm:Award2PvpMatch(tbPlayerList, nReadyId)
	if (not tbPlayerList) then
		return;
	end

	if (tbPlayerList[1] and tbPlayerList[2]) then
		local tbListA = {};
		if (tbPlayerList[1].tbPlayerList) then
			for _, nId in pairs(tbPlayerList[1].tbPlayerList) do
				local szPlayerName = KGCPlayer.GetPlayerName(nId);
				tbListA[nId] = szPlayerName;
			end
		end
		
		local tbListB = {};
		if (tbPlayerList[2].tbPlayerList) then
			for _, nId in pairs(tbPlayerList[2].tbPlayerList) do
				local szPlayerName = KGCPlayer.GetPlayerName(nId);
				tbListB[nId] = szPlayerName;
			end
		end		

		if (tbPlayerList[1].nDamage == tbPlayerList[2].nDamage) then
			EPlatForm:MacthAward(tbPlayerList[1].szLeagueName, tbPlayerList[2].szLeagueName, tbListA, 2);
			EPlatForm:MacthAward(tbPlayerList[2].szLeagueName, tbPlayerList[1].szLeagueName, tbListB, 2);
		else
			EPlatForm:MacthAward(tbPlayerList[1].szLeagueName, tbPlayerList[2].szLeagueName, tbListA, 1);
			EPlatForm:MacthAward(tbPlayerList[2].szLeagueName, tbPlayerList[1].szLeagueName, tbListB, 3);
		end		
	end
	
	if (tbPlayerList[1] and not tbPlayerList[2]) then
		local tbListA = {};
		if (tbPlayerList[1].tbPlayerList) then
			for _, nId in pairs(tbPlayerList[1].tbPlayerList) do
				local szPlayerName = KGCPlayer.GetPlayerName(nId);
				tbListA[nId] = szPlayerName;
			end
		end
		EPlatForm:MacthAward(tbPlayerList[1].szLeagueName, "", tbListA, 1);
	end
	
	if (EPlatForm.DEF_STATE_ADVMATCH == self:GetMacthState()) then
		if (EPlatForm.AdvMatchState == 5) then -- ���һ��
			EPlatForm:SetAdvMacthResult(nReadyId);
		end
	end
	
end
