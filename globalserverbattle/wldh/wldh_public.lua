--���ִ��
--�����
--2008.09.12
--GC/GS


--�Ƿ��Ǿ���������
function Wldh:CheckIsOpen()
	local nCurSec  = GetTime();
	local nCurDate = tonumber(os.date("%Y%m%d",nCurSec));
	if nCurDate > Wldh.END_DATE then
		return 0;
	end
	if Wldh.IS_OPEN == 1 then
		return 1;
	end
	return 0;
end

--��õ�ǰ��������
function Wldh:GetCurGameType()
	local nType = KGblTask.SCGetDbTaskInt(Wldh.GTASK_MACTH_TYPE);
	local nCurType = 0;
	if not self.STATE_TYPE[nType] then
		return 0;
	end
	return self.STATE_TYPE[nType][1], self.STATE_TYPE[nType][2];
end

--���õ�ǰ��������
function Wldh:SetCurGameType(nType)
	return KGblTask.SCSetDbTaskInt(Wldh.GTASK_MACTH_TYPE, nType);
end

--��õ�ͼ��Ӧ�ı��(0,���г���1�᳡)
function Wldh:GetMacthMapSeriesId(nType, nMapId)
	for nReadyId, nUseMapId in ipairs(Wldh:GetMapWaitTable(nType)) do
		if nUseMapId == nMapId then
			return nReadyId;
		end
	end
	for nReadyId, nUseMapId in ipairs(Wldh:GetMapReadyTable(nType)) do
		if nUseMapId == nMapId then
			return nReadyId;
		end
	end	
	for nReadyId, nUseMapId in ipairs(Wldh:GetMapMacthTable(nType)) do
		if nUseMapId == nMapId then
			return nReadyId;
		end
	end
	for nReadyId, nUseMapId in ipairs(Wldh:GetMapMacthPatchTable(nType)) do
		if nUseMapId == nMapId then
			return nReadyId;
		end
	end			
	return 0;
end

--���Ԥ����������
function Wldh:GetState1GameType()
	local nCurSec  = GetTime();
	local nCurDate = tonumber(os.date("%Y%m%d",nCurSec));
	for _, tbInfo in ipairs(self.STATE1_DATE) do
		if nCurDate >= tbInfo[1] and nCurDate <= tbInfo[2] then
			return tbInfo[3];
		end
	end
	return 0;
end

--��þ�����������
function Wldh:GetState2GameType()
	local nCurSec  = GetTime();
	local nCurDate = tonumber(os.date("%Y%m%d",nCurSec));
	for _, tbInfo in ipairs(self.STATE2_DATE) do
		if nCurDate == tbInfo[1] then
			return tbInfo[3];
		end
	end
	return 0;
end

--��ó����ձ�������������
function Wldh:GetState1FinalListType()
	local nCurSec  = GetTime();
	local nCurDate = tonumber(os.date("%Y%m%d",nCurSec));
	for _, tbInfo in ipairs(self.STATE1_DATE) do
		if nCurDate == tbInfo[2] then
			return tbInfo[3];
		end
	end
	return 0;	
end

--�����Ҳμӵ��ⳡ��������
function Wldh:GetAttendThisType(pPlayer)
	return pPlayer.GetTask(self.TASKID_GROUP, self.TASKID_ATTEND_TYPE);
end

--��������ⳡ�μӵı�������
function Wldh:SetAttendThisType(pPlayer, nValue)
	return pPlayer.SetTask(self.TASKID_GROUP, self.TASKID_ATTEND_TYPE, nValue);
end

--��ñ���Ԫ�ظ���.
function Wldh:CountTableLeng(tbTable)
	local nLeng = 0;
	if type(tbTable) == 'table' then
		for Temp in pairs(tbTable) do
			nLeng = nLeng + 1;
		end
	end
	return nLeng;
end

--���Ӷ���
function Wldh:AddMacthLeague(nType, szLeagueName, szMacthLeagueId)
	local nLGType = Wldh:GetLGType(nType);
	local nEmy1Id = KLib.Number2UInt(League:GetLeagueTask(nLGType, szLeagueName, self.LGTASK_EMY1));
	local nEmy2Id = KLib.Number2UInt(League:GetLeagueTask(nLGType, szLeagueName, self.LGTASK_EMY2));
	local nEmy3Id = KLib.Number2UInt(League:GetLeagueTask(nLGType, szLeagueName, self.LGTASK_EMY3));
	local nEmy4Id = KLib.Number2UInt(League:GetLeagueTask(nLGType, szLeagueName, self.LGTASK_EMY4));
	local nEmy5Id = KLib.Number2UInt(League:GetLeagueTask(nLGType, szLeagueName, self.LGTASK_EMY5));
	if nEmy4Id > 0 then
		League:SetLeagueTask(nLGType, szLeagueName, self.LGTASK_EMY5, nEmy4Id);
	end
	if nEmy3Id > 0 then
		League:SetLeagueTask(nLGType, szLeagueName, self.LGTASK_EMY4, nEmy3Id);
	end
	if nEmy2Id > 0 then
		League:SetLeagueTask(nLGType, szLeagueName, self.LGTASK_EMY3, nEmy2Id);
	end
	if nEmy1Id > 0 then
		League:SetLeagueTask(nLGType, szLeagueName, self.LGTASK_EMY2, nEmy1Id);
	end
	League:SetLeagueTask(nLGType, szLeagueName, self.LGTASK_EMY1, szMacthLeagueId);
end

--����׼����
function Wldh:AddGroupMember(nType, nReadyId, szLeagueName, nPlayerId, szPlayerName)
	if not self.GroupList[nType][nReadyId] then
		self.GroupList[nType][nReadyId] = {};
	end
	local nLGType = Wldh:GetLGType(nType);
	if not self.GroupList[nType][nReadyId][szLeagueName] then
		self.GroupList[nType][nReadyId][szLeagueName] = {};
		self.GroupList[nType][nReadyId][szLeagueName].tbPlayerList = {};
		
		--ս��ͳ��,ʤ��
		local nWin = League:GetLeagueTask(nLGType, szLeagueName, Wldh.LGTASK_WIN);
		local nTie = League:GetLeagueTask(nLGType, szLeagueName, Wldh.LGTASK_TIE);
		local nTotal   = League:GetLeagueTask(nLGType, szLeagueName, Wldh.LGTASK_TOTAL);
		local nRankAdv = League:GetLeagueTask(nLGType, szLeagueName, Wldh.LGTASK_RANK_ADV);
		local nRank    = League:GetLeagueTask(nLGType, szLeagueName, Wldh.LGTASK_RANK);
		local nWinRate =  Wldh.MACTH_NEW_WINRATE * 100;
		if nTotal > 0 then
			nWinRate = math.floor((nWin * 10000) / nTotal);
		end
		self.GroupList[nType][nReadyId][szLeagueName].nWinRate = nWinRate;
		self.GroupList[nType][nReadyId][szLeagueName].nRank 	= nRank;
		self.GroupList[nType][nReadyId][szLeagueName].nRankAdv = nRankAdv;
		--ս��ID��ս�Ӷ�ս��ʷ��¼
		self.GroupList[nType][nReadyId][szLeagueName].nNameId = tonumber(KLib.String2Id(szLeagueName));
		local nEmy1Id = KLib.Number2UInt(League:GetLeagueTask(nLGType, szLeagueName, Wldh.LGTASK_EMY1));
		local nEmy2Id = KLib.Number2UInt(League:GetLeagueTask(nLGType, szLeagueName, Wldh.LGTASK_EMY2));
		local nEmy3Id = KLib.Number2UInt(League:GetLeagueTask(nLGType, szLeagueName, Wldh.LGTASK_EMY3));
		local nEmy4Id = KLib.Number2UInt(League:GetLeagueTask(nLGType, szLeagueName, Wldh.LGTASK_EMY4));
		local nEmy5Id = KLib.Number2UInt(League:GetLeagueTask(nLGType, szLeagueName, Wldh.LGTASK_EMY5));
		self.GroupList[nType][nReadyId][szLeagueName].tbHistory = {};
		if nEmy1Id > 0 then
			self.GroupList[nType][nReadyId][szLeagueName].tbHistory[nEmy1Id] = 1;
		end
		if nEmy2Id > 0 then
			self.GroupList[nType][nReadyId][szLeagueName].tbHistory[nEmy2Id] = 1;
		end
		if nEmy3Id > 0 then
			self.GroupList[nType][nReadyId][szLeagueName].tbHistory[nEmy3Id] = 1;
		end
		if nEmy4Id > 0 then
			self.GroupList[nType][nReadyId][szLeagueName].tbHistory[nEmy4Id] = 1;
		end
		if nEmy5Id > 0 then
			self.GroupList[nType][nReadyId][szLeagueName].tbHistory[nEmy5Id] = 1;
		end
	end
	table.insert(self.GroupList[nType][nReadyId][szLeagueName].tbPlayerList, nPlayerId);
end

--�˳�׼����
function Wldh:DelGroupMember(nType, nReadyId, szLeagueName, nPlayerId)
	if not self.GroupList[nType][nReadyId] or not  self.GroupList[nType][nReadyId][szLeagueName] then
		return
	end
	local nLGType = Wldh:GetLGType(nType);
	local tbTemp = {};
	if (MODULE_GC_SERVER) then
		tbTemp = self.GroupList[nType][nReadyId][szLeagueName]
		local nCount = League:GetLeagueTask(nLGType, szLeagueName, Wldh.LGTASK_ENTER);
		if nCount > 0 then
			League:SetLeagueTask(nLGType, szLeagueName, Wldh.LGTASK_ENTER, nCount - 1);
		end
	else
		tbTemp = self.GroupList[nType][nReadyId][szLeagueName].tbPlayerList
	end
	for ni, nId in pairs(tbTemp) do
		if nId == nPlayerId then
			table.remove(tbTemp, ni);
			break;
		end
	end
	if Wldh:CountTableLeng(tbTemp) <= 0 then
		self.GroupList[nType][nReadyId][szLeagueName] = nil
		if (MODULE_GC_SERVER) then
			KGblTask.SCSetDbTaskInt(self.GTASK_MACTH_MAP_STATE, 0);
			self.GroupList[nType][nReadyId].nLeagueCount = self.GroupList[nType][nReadyId].nLeagueCount - 1;
		end
	end
	if (not MODULE_GC_SERVER) then
		GCExcute{"Wldh:DelGroupMember", nType, nReadyId, szLeagueName, nPlayerId}
	end
end

function Wldh:WriteLog(szLog, nPlayerId)
	if nPlayerId then
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
		if (pPlayer) then
			Dbg:WriteLog("Wldh", "���ִ��", pPlayer.szAccount, pPlayer.szName, szLog);
			return 1;
		end
	end
	Dbg:WriteLog("Wldh","���ִ��", szLog);
end

function Wldh:SyncAdvMatchList(nType, nReadyId, nKey, tbList)
	Wldh.AdvMatchLists[nType] = Wldh.AdvMatchLists[nType] or {};
	Wldh.AdvMatchLists[nType][nReadyId] = Wldh.AdvMatchLists[nType][nReadyId] or {};
	Wldh.AdvMatchLists[nType][nReadyId][nKey] = Wldh.AdvMatchLists[nType][nReadyId][nKey] or {};
	Wldh.AdvMatchLists[nType][nReadyId][nKey] = tbList;
end

function Wldh:WriteLog(szLog, nPlayerId)
	if nPlayerId then
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
		if (pPlayer) then
			Dbg:WriteLog("Wlls", "��������", pPlayer.szAccount, pPlayer.szName, szLog);
			return 1;
		end
	end
	Dbg:WriteLog("Wlls","��������", szLog);
end
