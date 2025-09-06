--���
--��ͼ�������
--2008.09.23
--�����

--����
local function OnSort(tbA, tbB)
	if tbA[2] == tbB[2] then
		return tbA[2] > tbB[2]
	end 
	return tbA[2] < tbB[2];
end

--��û᳡�ĵ�
function Wldh:GetLeaveMapPos(nType, nReadyId, tbMapTypeParam)
	--����᳡
	local tbLeaveMap = {};
	local nMapLinkType = self:GetMapLinkType(nType);
	local tbWaitMap = self:GetMapWaitTable(nType);
	
	if nMapLinkType == Wldh.MAP_LINK_TYPE_RANDOM then
		for _, nMapId in pairs(tbWaitMap) do
			if SubWorldID2Idx(nMapId) >= 0 then
				for _, tbPos in pairs(Wldh.MACTH_TRAP_LEAVE) do
					table.insert(tbLeaveMap , {nMapId, unpack(tbPos)});
				end
			end
		end
	end
	if nMapLinkType == Wldh.MAP_LINK_TYPE_SERIES then
		if nReadyId <= 0 then
			nReadyId = tbMapTypeParam.nSeries;
		end
		for _, tbPos in pairs(Wldh.MACTH_TRAP_LEAVE) do
			table.insert(tbLeaveMap , {tbWaitMap[nReadyId], unpack(tbPos)});
		end		
	end
		
	if nMapLinkType == Wldh.MAP_LINK_TYPE_FACTION then
		if nReadyId <= 0 then
			nReadyId = tbMapTypeParam.nFaction;
		end		
		for _, tbPos in pairs(Wldh.MACTH_TRAP_LEAVE) do
			table.insert(tbLeaveMap , {tbWaitMap[nReadyId], unpack(tbPos)});
		end
	end
	
	return tbLeaveMap;
end

--���׼����
function Wldh:GetReadyMapId(nType, nMapId, tbMapTypeParam, szLeagueName)
	local nEnterReadyId = 0;
	local nMapLinkType = self:GetMapLinkType(nType);
	local tbReadyMap = self:GetMapReadyTable(nType);
	
	-- fix bug
	local _, nFinal = self:GetCurGameType();
	if nMapLinkType  == self.MAP_LINK_TYPE_RANDOM then

		--����Լ��ǵ�һ��ս�ӳ�Ա���룬��ֱ�ӽ���׼����, ���֮ǰ�������׼��������ֱ�ӽ��롣(����ѡȡ����ս��������������Сս���������������)
		local tbGroupCount = {};
		for nReadyId, nMapId in ipairs(tbReadyMap) do
			self.GroupList[nType] = self.GroupList[nType] or {};
			self.GroupList[nType][nReadyId] = self.GroupList[nType][nReadyId] or {nLeagueCount=0};
			table.insert(tbGroupCount, {nReadyId, self.GroupList[nType][nReadyId].nLeagueCount});
		end
		table.sort(tbGroupCount, OnSort);
		local nMinCount =  tbGroupCount[1][2];
		
		--���֮ǰ�������׼�����������ֱȽϾͻ�����������
		self.GroupListTemp[nType] = self.GroupListTemp[nType] or {};
		if self.GroupListTemp[nType][szLeagueName] then
			if self.GroupList[nType][self.GroupListTemp[nType][szLeagueName]].nLeagueCount < self:GetOneMapPlayerMax(nType) then
				return self.GroupListTemp[nType][szLeagueName];
			end
		end
		
		if nFinal > 0 then
			return 1;
		end
		
		--����Լ�ս�����ж��ѽ����ˣ���ֱ�ӽ���׼������
		for nReadyId, nMapId in ipairs(tbReadyMap) do
			if self.GroupList[nType][nReadyId][szLeagueName] then
				return nReadyId;
			end
		end		
				
		if nMinCount >= self:GetOneMapPlayerMax(nType) then
			--׼����������
			--KGblTask.SCSetDbTaskInt(self.GTASK_MACTH_MAP_STATE, 1)
			return 0;
		end
				
		for i, tbParam in pairs(tbGroupCount) do
			local nP = MathRandom(1, #tbGroupCount);
			tbGroupCount[i], tbGroupCount[nP] = tbGroupCount[nP], tbGroupCount[i];
		end
		
		for nReadyId, nMapId in ipairs(tbReadyMap) do
			if self.GroupList[nType][nReadyId].nLeagueCount < (self.MAP_SELECT_MIN)then
				nEnterReadyId = nReadyId;
				break;
			else
				if math.mod(self.GroupList[nType][nReadyId].nLeagueCount, 2) == 1 then
					nEnterReadyId = nReadyId;
					break;
				end
			end
		end
		if nEnterReadyId == 0 then
			local tbTemp = {};
			for _, tbParam in ipairs(tbGroupCount) do
				if tbParam[2] <= nMinCount then
					table.insert(tbTemp, tbParam[1]);
				end
			end
			nEnterReadyId = tbTemp[MathRandom(1, #tbTemp)];
		end
		self.GroupListTemp[nType][szLeagueName] = nEnterReadyId;
	end
	
	if nMapLinkType == self.MAP_LINK_TYPE_SERIES then
		nEnterReadyId = tbMapTypeParam.nSeries;
		self.GroupList[nType] = self.GroupList[nType] or {};
		if not self.GroupList[nType][nEnterReadyId] then
			self.GroupList[nType][nEnterReadyId] = {};
			self.GroupList[nType][nEnterReadyId].nLeagueCount = 0;
		end
		
		if nFinal > 0 then
			return nEnterReadyId;
		end
		
		--����Լ�ս�����ж��ѽ����ˣ���ֱ�ӽ���׼������
		if self.GroupList[nType][nEnterReadyId][szLeagueName] then
			return nEnterReadyId;
		end
		
		if self.GroupList[nType][nEnterReadyId].nLeagueCount >= self:GetOneMapPlayerMax(nType) then
			--׼����������
			--��ü�ͬ����GS������GS�ж��Ƿ����ˣ����Ч��
			return 0;
		end
		return nEnterReadyId;
	end
	
	if nMapLinkType == self.MAP_LINK_TYPE_FACTION then
		nEnterReadyId = tbMapTypeParam.nFaction;
		self.GroupList[nType] = self.GroupList[nType] or {};
		if not self.GroupList[nType][nEnterReadyId] then
			self.GroupList[nType][nEnterReadyId] = {};
			self.GroupList[nType][nEnterReadyId].nLeagueCount = 0;
		end
		
		if nFinal > 0 then
			return nEnterReadyId;
		end		
		
		--����Լ�ս�����ж��ѽ����ˣ���ֱ�ӽ���׼������
		if self.GroupList[nType][nEnterReadyId][szLeagueName] then
			return nEnterReadyId;
		end
		
		if self.GroupList[nType][nEnterReadyId].nLeagueCount >= self:GetOneMapPlayerMax(nType) then
			--׼����������
			--��ü�ͬ����GS������GS�ж��Ƿ����ˣ����Ч��
			return 0;
		end
		return nEnterReadyId;		
	end
	
	return nEnterReadyId;
end

