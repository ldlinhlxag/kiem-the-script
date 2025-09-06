--����
--��ͼ�������

--����
local function OnSort(tbA, tbB)
	if tbA[2] == tbB[2] then
		return tbA[2] > tbB[2]
	end 
	return tbA[2] < tbB[2];
end

--���׼����
function EPlatForm:GetReadyMapId(tbMacthCfg, nMapId, tbMapTypeParam, szLeagueName)
	local nEnterReadyId = 0;
	local nState = EPlatForm:GetMacthState();
	
	if (nState == EPlatForm.DEF_STATE_MATCH_1) then
		for nReadyId, nMapId in ipairs(tbMacthCfg.tbReadyMap) do
			if not self.GroupList[nReadyId] then
				self.GroupList[nReadyId] = {};
				self.GroupList[nReadyId].nLeagueCount = 0;
			end
			if (self.GroupList[nReadyId].nLeagueCount < self:GetPreMaxLeague()) then
				self.GroupListTemp[szLeagueName] = nReadyId
				return nReadyId;
			end
		end
		--׼����������
		KGblTask.SCSetDbTaskInt(self.GTASK_MACTH_MAP_STATE, 1)
		return 0;		
	end
	

	--����Լ��ǵ�һ��ս�ӳ�Ա���룬��ֱ�ӽ���׼����, ���֮ǰ�������׼��������ֱ�ӽ��롣(����ѡȡ����ս��������������Сս���������������)
	local tbGroupCount = {};
	for nReadyId, nMapId in ipairs(tbMacthCfg.tbReadyMap) do
		if not self.GroupList[nReadyId] then
			self.GroupList[nReadyId] = {};
			self.GroupList[nReadyId].nLeagueCount = 0;
		end
		table.insert(tbGroupCount, {nReadyId, self.GroupList[nReadyId].nLeagueCount});
	end
	table.sort(tbGroupCount, OnSort);
	
	--��ǿ����Ա�������һ����
	if nState == EPlatForm.DEF_STATE_ADVMATCH then
		return 1;
	end
	
	local nMinCount =  tbGroupCount[1][2];
	
	--���֮ǰ�������׼�����������ֱȽϾͻ�����������
	if self.GroupListTemp[szLeagueName] then
		if self.GroupList[self.GroupListTemp[szLeagueName]].nLeagueCount < self:GetPreMaxLeague() then
			return self.GroupListTemp[szLeagueName];
		end
	end
	
	--����Լ�ս�����ж��ѽ����ˣ���ֱ�ӽ���׼������
	for nReadyId, nMapId in ipairs(tbMacthCfg.tbReadyMap) do
		if self.GroupList[nReadyId][szLeagueName] then
			return nReadyId;
		end
	end		
			
	if nMinCount >= self:GetPreMaxLeague() then
		--׼����������
		KGblTask.SCSetDbTaskInt(self.GTASK_MACTH_MAP_STATE, 1)
		return 0;
	end
			
	for i, tbParam in pairs(tbGroupCount) do
		local nP = MathRandom(1, #tbGroupCount);
		tbGroupCount[i], tbGroupCount[nP] = tbGroupCount[nP], tbGroupCount[i];
	end
	
	for nReadyId, nMapId in ipairs(tbMacthCfg.tbReadyMap) do
		if (self.GroupList[nReadyId].nLeagueCount < self.MAP_SELECT_MIN)then
			nEnterReadyId = nReadyId;
			break;
		else
			if math.mod(self.GroupList[nReadyId].nLeagueCount, 2) == 1 then
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
	self.GroupListTemp[szLeagueName] = nEnterReadyId;
	
	return nEnterReadyId;
end

