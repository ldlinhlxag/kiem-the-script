--���ִ��
--�����
--2008.09.11
if (MODULE_GC_SERVER) then
	return 0;
end

function Wldh:CheckLeagueType(tbLimitList, tbMacthCfg)

	--���м�� todo
	if tbMacthCfg.nSeries == self.LEAGUE_TYPE_SERIES_MIX then
		--��ͬ����
		local tbSeries = {};
		for _, nSeries in pairs(tbLimitList.tbSeries) do
			if not tbSeries[nSeries] then
				tbSeries[nSeries] = 1;
			else
				return 1, "�����ͱ�����Ҫս�ӳ�Ա�ǲ�ͬ������ϡ�";
			end
		end
	end
	return 0
end

--��齨��ս���Ƿ�����������ͣ�����1�����ϣ�0Ϊ���ϣ�
function Wldh:CheckCreateLeague(pMyPlayer, tbPlayerIdList, nType)
	local tbMacthCfg = self:GetCfg(nType);
	local nLGType = self:GetLGType(nType);
	local tbLimitList = {
			tbSex = {};
			tbCamp = {};
			tbSeries = {};
			tbFaction = {};
		};
	local nMapId, nPosX, nPosY	= pMyPlayer.GetWorldPos();	
	for _, nPlayerId in pairs(tbPlayerIdList) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if not pPlayer then
			return 1, "�������ж��ѱ������⸽����";
		end
		local nMapId2, nPosX2, nPosY2	= pPlayer.GetWorldPos();
		local nDisSquare = (nPosX - nPosX2)^2 + (nPosY - nPosY2)^2;
		if nMapId2 ~= nMapId or nDisSquare > 400 then
			return 1, "�������ж��ѱ������⸽����";
		end		
		if not pPlayer or pPlayer.nMapId ~= nMapId then
			return 1, "�������ж��ѱ������⸽����";
		end
		
		local nChose = GetPlayerSportTask(pPlayer.nId, Wldh.GBTASKID_GROUP, Wldh.GBTASKID_CHOSE_TYPE) or 0;
		if nType > 1 and nChose > 0 then
			return 1, string.format("������<color=yellow>%s<color>�Ѿ�ѡ�����������Ƶı�������������ֻ��ѡ������һ�֡�", pPlayer.szName);			
		end
		
		if pPlayer.GetCamp() == 0 then
			return 1, string.format("������<color=yellow>%s<color>��û�м������ɣ�ֻ�м������ɵ���ʿ��Ů���ܲμӡ�", pPlayer.szName);
		end

		local szLeagueName = League:GetMemberLeague(nLGType, pPlayer.szName);
		if szLeagueName then
			return 1, string.format("������<color=yellow>%s<color>���кͱ��˽���ս�Ӳμӱ����ͱ���������ս��ʱ�������еĶ�Ա����û��ѡ��μӱ����ͱ�����", pPlayer.szName);
		end
		
		table.insert(tbLimitList.tbSex, pPlayer.nSex);
		table.insert(tbLimitList.tbCamp, pPlayer.GetCamp());
		table.insert(tbLimitList.tbSeries, pPlayer.nSeries);
		table.insert(tbLimitList.tbFaction, pPlayer.nFaction);
	end
	
	--�������
	if #tbPlayerIdList ~= tbMacthCfg.nMemberCount then
		return 1, string.format("���Ķ������������ϱ����ͱ����������󣬱����ͱ���������<color=yellow>%s��<color>��Ա���ս�Ӳμӱ�����", tbMacthCfg.nMemberCount);
	end
	
	local nFlag, szMsg = self:CheckLeagueType(tbLimitList, tbMacthCfg)
	if nFlag == 1 then
		return 1, szMsg;
	end
	local szReturnMsg = "�ɹ�����ս�ӣ�";
	return 0, szReturnMsg;
end

--��ҽ���׼������������
function Wldh:SetStateJoinIn(nGroupId)
	me.ClearSpecialState()		--�������״̬
	me.RemoveSkillStateWithoutKind(Player.emKNPCFIGHTSKILLKIND_CLEARDWHENENTERBATTLE) --���״̬
	me.DisableChangeCurCamp(1);	--���������йصı������������ھ�����ս�ı�ĳ�������Ӫ�Ĳ���
	me.SetFightState(1);	  	--����ս��״̬
	me.SetLogoutRV(1);			--����˳�ʱ������RV�������´ε���ʱ��RV(���������㣬���˳���)
	me.ForbidEnmity(1);			--��ֹ��ɱ
	me.DisabledStall(1);		--��̯
	me.ForbitTrade(1);			--����
	--me.nPkModel = Player.emKPK_STATE_PRACTISE;
	me.SetCurCamp(nGroupId);
	me.TeamDisable(1);			--��ֹ���
	me.TeamApplyLeave();		--�뿪����
	me.StartDamageCounter();	--��ʼ�����˺�
	Faction:SetForbidSwitchFaction(me, 1); -- ����׼�����������Ͳ����л�����
	me.SetDisableTeam(1);
	me.SetDisableStall(1);
	me.SetDisableFriend(1);
	me.nForbidChangePK	= 1;
end

--����뿪׼������������
function Wldh:LeaveGame()
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
	Faction:SetForbidSwitchFaction(me, 0); -- ����׼�������������л����ɻ�ԭ
	me.SetDisableTeam(0);
	me.SetDisableStall(0);
	me.SetDisableFriend(0);	
	me.LeaveTeam();
end

--����
local function OnSort(tbA, tbB)
	if tbA.nWinRate == tbB.nWinRate then
		return tbA.nWinRate < tbB.nWinRate
	end 
	return tbA.nWinRate > tbB.nWinRate;
end
 
--׼�������������ƥ�����
function Wldh:GameMatch(tbLeagueList)
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

--���������ƥ�����
function Wldh:EnterPkMapRule(nType, nIsFinal)
	local nLGType = self:GetLGType(nType);
	local szTypeName = self:GetName(nType);
	for nReadyId, tbMission in pairs(self.MissionList[nType]) do
		if not self.GroupList[nType][nReadyId] then
			self.GroupList[nType][nReadyId] = {};
		end
		--���ͽ����������,ƥ��ԭ��;
		local tbSortLeague = {};
		for szLeagueName, tbLeague in pairs(self.GroupList[nType][nReadyId]) do
			local tbTemp = {szName = szLeagueName, 
				nNameId 		= tbLeague.nNameId , 
				nWinRate 		= tbLeague.nWinRate, 
				tbPlayerList 	= tbLeague.tbPlayerList, 
				tbHistory		= tbLeague.tbHistory,
				nRankAdv		= tbLeague.nRankAdv,
				nRank			= tbLeague.nRank};
			table.insert(tbSortLeague, tbTemp);
		end
		
		--����ǰ�ǿ����ƥ�����
		if nIsFinal > 0 then
			local tbLeagueA, tbLeagueB = Wldh:GameMatchAdv(nIsFinal, nType, nReadyId, tbSortLeague);
			local nIsNotAttend = 1;
			for i in pairs(tbLeagueA) do
				nIsNotAttend = 0;
				Wldh:OnMacthPkStart(tbMission, nType, nReadyId, tbLeagueA[i], tbLeagueB[i], i);
			end
			if nIsFinal == 7 and nIsNotAttend == 1 then
				Wldh:SetAdvMacthResult(nType, nReadyId);
			end
		elseif #tbSortLeague < Wldh.MACTH_LEAGUE_MIN then
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
						nLeaveId = self:KickPlayer(pPlayer, string.format("�������鲻��%s�ӣ������޷�����", Wldh.MACTH_LEAGUE_MIN), nType, nLeaveId);
						Dialog:SendBlackBoardMsg(pPlayer, string.format("�������鲻��%s�ӣ������޷�����", Wldh.MACTH_LEAGUE_MIN))
					end
				end
				--League:SetLeagueTask(nLGType, szName, Wldh.LGTASK_ENTER, 0);
				self.GroupList[nType][nReadyId][szName] = nil;
			end
			
			if tbMission:IsOpen() ~= 0 then
				tbMission:EndGame();
			end
		else
			--logͳ��
			--KStatLog.ModifyAdd("Wldh", string.format("%s����ÿ�����������",nType), "����", #tbSortLeague);

			local tbLeagueA, tbLeagueB = Wldh:GameMatch(tbSortLeague);
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
					
					Wldh:MacthAward(nType, nIsFinal, tbLeagueA[i].szName, nil, tbAwardList, 4, Wldh.MACTH_TIME_BYE, nReadyId)
					--����
					
					local nLeaveId = nil;
					for nId, szName in pairs(tbAwardList) do
						local pPlayer = KPlayer.GetPlayerObjById(nId);
						if pPlayer then
							local szKickMsg = string.format("�������ˣ���Ϊ����ƥ�䲻�����㱾��%s�����ֿա�", szTypeName);
							nLeaveId = self:KickPlayer(pPlayer, szKickMsg, nType, nLeaveId);
							Dialog:SendBlackBoardMsg(pPlayer, szKickMsg)
						end					
					end
					self.GroupList[nType][nReadyId][tbLeagueA[i].szName] = nil;
					break;
				end
				
				Wldh:OnMacthPkStart(tbMission, nType, nReadyId, tbLeagueA[i], tbLeagueB[i], i);
			end
		end
	end	
end

function Wldh:OnMacthPkStart(tbMission, nType, nReadyId, tbLeagueA, tbLeagueB, nAearId)
	local nGamePlayerMax = self:GetCfg(nType).nPlayerCount;
	local nMatchPatch 	 = tbMission.nMacthMap;
	if nAearId > self.MAP_SELECT_MAX then
		nAearId = (nAearId - self.MAP_SELECT_MAX)
		nMatchPatch = tbMission.nMacthMapPatch;
	end
	
	if SubWorldID2Idx(nMatchPatch) < 0 then
		print("Error!!!", "���ִ���ͼû�п���", nMatchPatch);
		return 0;
	end 
	
	local nPosX, nPosY = unpack(Wldh:GetMapPKPosTable(nType)[nAearId]);
	
	--ս�����ݼ�¼
	Wldh:AddMacthLeague(nType, tbLeagueA.szName, tbLeagueB.nNameId);
	Wldh:AddMacthLeague(nType, tbLeagueB.szName, tbLeagueA.nNameId);
	
	local szMatchMsgA = string.format("���Ķ���ս���ǣ�<color=green>%s<color=yellow>", tbLeagueA.szName);
	local szMatchMsgB = string.format("���Ķ���ս���ǣ�<color=green>%s<color=yellow>", tbLeagueB.szName);
	local szLookMsgA = string.format("<color=green>---%sս�����---<color><color=yellow>", tbLeagueA.szName);
	local szLookMsgB = string.format("<color=green>---%sս�����---<color><color=yellow>", tbLeagueB.szName);
	local tbPlayerMatchListA = {};
	local tbPlayerMatchListB = {};
	local nPlayerCountA = 0;
	local nPlayerCountB = 0;
	local nLeaveId = nil;
	for _, nId in pairs(tbLeagueA.tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			if nPlayerCountA >= nGamePlayerMax then
				nLeaveId = self:KickPlayer(pPlayer, "��ս����ʽ��Ա�ѽ����������<color=yellow>����Ϊ�油�����ڻ᳡�ȴ����<color>������뿪�˻᳡����<color=yellow>�޷������ս�ӵı�������<color>��", nType, nLeaveId);
			else
				nPlayerCountA = nPlayerCountA + 1;
				table.insert(tbPlayerMatchListA, nId);
				szMatchMsgA = szMatchMsgA .. "\n���֣�" .. pPlayer.szName .."  ".. Player:GetFactionRouteName(pPlayer.nFaction, pPlayer.nRouteId) .. "  " .. pPlayer.nLevel .."��";
				szLookMsgA = szLookMsgA .. "\n��Ա��" .. pPlayer.szName .."  ".. Player:GetFactionRouteName(pPlayer.nFaction, pPlayer.nRouteId) .. "  " .. pPlayer.nLevel .."��";
			end
		end
	end
	local nLeaveId = nil;
	for _, nId in pairs(tbLeagueB.tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			if nPlayerCountB >= nGamePlayerMax then
				nLeaveId = self:KickPlayer(pPlayer, "��ս����ʽ��Ա�ѽ��������������Ϊ�油�����ڻ᳡�ȴ������", nType, nLeaveId);							
			else
				nPlayerCountB = nPlayerCountB + 1;
				table.insert(tbPlayerMatchListB, nId);							
				szMatchMsgB = szMatchMsgB .. "\n���֣�" .. pPlayer.szName .."  ".. Player:GetFactionRouteName(pPlayer.nFaction, pPlayer.nRouteId) .. "  " .. pPlayer.nLevel .."��";
				szLookMsgB = szLookMsgB .. "\n��Ա��" .. pPlayer.szName .."  ".. Player:GetFactionRouteName(pPlayer.nFaction, pPlayer.nRouteId) .. "  " .. pPlayer.nLevel .."��";
			end
		end
	end
	
	--��Ӫ1
	local nCaptionAId = 0;
	for _, nId in pairs(tbPlayerMatchListA) do
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			if nCaptionAId == 0 then
				KTeam.CreateTeam(nId);	--��������
				nCaptionAId = nId;
			else
				KTeam.ApplyJoinPlayerTeam(nCaptionAId, nId);	--�������
			end
			Wldh.MACTH_ENTER_FLAG[nId] = 1;
			tbMission:AddLeague(pPlayer, pPlayer.szName, tbLeagueA.szName, tbLeagueB.szName);
			pPlayer.NewWorld(nMatchPatch, nPosX, nPosY);
			tbMission:JoinGame(pPlayer, 1);
			pPlayer.Msg(szMatchMsgB);
		end
	end
	
	--��Ӫ2
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
			Wldh.MACTH_ENTER_FLAG[nId] = 1;
			tbMission:AddLeague(pPlayer, pPlayer.szName, tbLeagueB.szName, tbLeagueA.szName);
			pPlayer.NewWorld(nMatchPatch, nPosX, nPosY);
			tbMission:JoinGame(pPlayer, 2)
			pPlayer.Msg(szMatchMsgA);
		end
	end
	
	self.GroupList[nType][nReadyId][tbLeagueB.szName] = nil;
	self.GroupList[nType][nReadyId][tbLeagueA.szName] = nil;	
end

function Wldh:GameMatchAdv(nIsFinal, nType, nReadyId, tbSortLeague)
	local nLGType = self:GetLGType(nType);
	local tbLeagueListA = {};
	local tbLeagueListB = {};
	for nRank=1, math.floor(Wldh.MACTH_STATE_ADV_TASK[nIsFinal]/2) do
		if not self.AdvMatchLists[nType] or not self.AdvMatchLists[nType][nReadyId] then
			break;
		end
		local tbList = self.AdvMatchLists[nType][nReadyId][Wldh.MACTH_STATE_ADV_TASK[nIsFinal]];
		local tbLeagueA = tbList[nRank];
		local tbLeagueB = tbList[Wldh.MACTH_STATE_ADV_TASK[nIsFinal] - nRank + 1];

		--���ж������
		if tbLeagueA and tbLeagueB then
			local szAName = tbLeagueA.szName;
			local szBName = tbLeagueB.szName;
			local nAId, tbLeagueA1 = self:GameMatchAdvLeagueInfo(szAName, tbSortLeague);
			local nBId, tbLeagueB1 = self:GameMatchAdvLeagueInfo(szBName, tbSortLeague);

			--���ֶ��ڳ�
			if tbLeagueA1 and tbLeagueB1 then
				table.insert(tbLeagueListA, tbLeagueA1);
				table.insert(tbLeagueListB, tbLeagueB1);
				tbSortLeague[nAId] = nil;
				tbSortLeague[nBId] = nil;
			elseif not tbLeagueA1 and not tbLeagueB1 then--���ֶ����ڳ�
				local szWinName = szAName;
				local szLostName = szBName;
				if tbLeagueA.nRank > tbLeagueB.nRank then
					szWinName = szBName;
					szLostName = szAName;
				end
				self:MacthAward(nType, nIsFinal, szWinName, szLostName, {}, 2, 0, nReadyId);
				self:MacthAward(nType, nIsFinal, szLostName, szWinName, {}, 2, 0, nReadyId);
			else
				local szWinName = szAName;
				local szLostName = szBName;
				if tbLeagueB1 then
					szWinName = szBName;
					szLostName = szAName;
				end
				self:MacthAward(nType, nIsFinal, szWinName, szLostName, {}, 1, 0, nReadyId);
				self:MacthAward(nType, nIsFinal, szLostName, szWinName, {}, 3, 0, nReadyId);				
				self:GameMatchAdvKickLeague(tbLeagueA1 or tbLeagueB1, nType, nReadyId, "��Ϊ��Ķ���ȱϯ��������ս�ӻ����ʤ��");
				tbSortLeague[nAId] = nil;
				tbSortLeague[nBId] = nil;
			end
		elseif tbLeagueA or tbLeagueB then
			--�޶��������ֱ�ӻ�ʤ
			
			local tbWinLeague = tbLeagueA or tbLeagueB;
			local szWinName = tbWinLeague.szName;
			self:MacthAward(nType, nIsFinal, szWinName, nil, {}, 1, 0, nReadyId);
			local nAId, tbLeagueA1 = self:GameMatchAdvLeagueInfo(szWinName, tbSortLeague);
			if tbLeagueA1 then
				self:GameMatchAdvKickLeague(tbLeagueA1, nType, nReadyId, "��Ϊ��û�ж��֣���ս��ֱ�ӻ����ʤ��");
				tbSortLeague[nAId] = nil;
			end
		end
	end
	
	--������ȫ���������
	for _, tbLeague in pairs(tbSortLeague) do
		Wldh:GameMatchAdvKickLeague(tbLeague, nType, nReadyId, "����ս��û���ʸ�μ����ִ�����")
	end
	
	return tbLeagueListA, tbLeagueListB;
end

function Wldh:GameMatchAdvLeagueInfo(szName, tbSortLeague)
	local tbLeagueA1 = nil;
	local nAId = 0;
	for nId, tbLeague in pairs(tbSortLeague) do
		if tbLeague.szName == szName then
			tbLeagueA1 = tbLeague;
			nAId = nId;
			break;
		end
	end
	return nAId, tbLeagueA1;
end

function Wldh:GameMatchAdvKickLeague(tbLeague, nType, nReadyId, szMsg)
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
			nLeaveId = self:KickPlayer(pPlayer, szMsg, nType, nLeaveId);
			Dialog:SendBlackBoardMsg(pPlayer, szMsg);
		end
	end
	self.GroupList[nType][nReadyId][tbLeague.szName] = nil;	
end
