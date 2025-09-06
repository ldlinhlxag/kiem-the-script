-- �ļ�������console_base_global.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-05-06 14:26:51
-- ��  ��  ��

Console.Base = Console.Base or {};
local tbBase = Console.Base;

--�Ƿ���,0Ϊ����,1׼���׶�,2�����׶�
function tbBase:IsOpen()
	return self.nState or 0;
end

--�ж��Ƿ�����,���ؿɽ���ĵ�ͼId
function tbBase:IsFull(nPlayerCount)
	for nMapId, tbGroup in pairs(self.tbGroupLists) do
		if tbGroup.nMaxPlayer < self.tbCfg.nMaxPlayer then
			if (self.tbCfg.nMaxPlayer - tbGroup.nMaxPlayer) >= nPlayerCount then
				return nMapId;
			end
		end
	end
	return 0;
end

function tbBase:JoinGroupList(nMapId, tbPlayerList)
	if self:IsOpen() == 0 then
		return 0;
	end
	self.tbGroupLists[nMapId].nMaxPlayer = self.tbGroupLists[nMapId].nMaxPlayer + #tbPlayerList;	
	table.insert(self.tbGroupLists[nMapId].tbList, {});
	local nGroupId = #self.tbGroupLists[nMapId].tbList;
	for nId, nPlayerId in pairs(tbPlayerList) do
		local nCaptain = 0;
		if nId == 1 then
			nCaptain = 1;
		end 
		self.tbPlayerData[nMapId][nPlayerId] = 
		{
			nCaptain = nCaptain;
			nGroupId = nGroupId;
			nMapId 	 = nMapId;
		};
	end	
end

function tbBase:LeaveGroupList(nMapId, nId)
	local tbData = self:GetPlayerData(nMapId, nId);
	if tbData and self.tbGroupLists[nMapId] and self.tbGroupLists[nMapId].tbList[tbData.nGroupId] then
		for i, nLeaveId in pairs(self.tbGroupLists[nMapId].tbList[tbData.nGroupId]) do
			if nLeaveId == nId then
				table.remove(self.tbGroupLists[nMapId].tbList[tbData.nGroupId], i);
				break;
			end
		end
		self.tbGroupLists[nMapId].nMaxPlayer = self.tbGroupLists[nMapId].nMaxPlayer - 1;
	end	
end


function tbBase:Init()
	self.nState 	  = 0;
	self.tbPlayerData = {}; --�������
	self.tbGroupLists = {}; --��������	
	self.tbTimerList  = {}; --��������	
	self.tbMapGroupList= {};--������ͼ��Ա����
	
	for nMapId, tbPos in pairs(self.tbCfg.tbMap) do
		local nReadyMapId = nMapId;
		Console.tbDynMapLists[nMapId] = Console.tbDynMapLists[nMapId] or {};
		self.tbMapGroupList[nReadyMapId] = {};		
		self.tbPlayerData[nReadyMapId] = {};	
		self.tbGroupLists[nReadyMapId]  = {tbList = {}, nMaxPlayer = 0};	
	end
end
