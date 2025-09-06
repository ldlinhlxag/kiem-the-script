-- �ļ�������fuben_gs.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2009-12-7
-- ��  ��  ��

if (MODULE_GC_SERVER) then
	return 0;
end

Require("\\script\\fuben\\fuben_file.lua");
Require("\\script\\fuben\\define.lua");

--���븱��(��Ʒ����)
function CFuben:ApplyFuBen(nItemId, nPlayerId)	
	local  pItem = KItem.GetObjById(nItemId);
	if  pItem then
		local nItemGDPL = string.format("%s,%s,%s,%s", pItem.nGenre, pItem.nDetail, pItem.nParticular,pItem.nLevel);
		local nType = self.FUBEN_EX[nItemGDPL][1];
		local nId = self.FUBEN_EX[nItemGDPL][2];
		return self:ApplyFuBenEx(nType, nId, nPlayerId);
	end
end

--���븱��(npcֱ������)	nTypeΪ����������id��nidΪ���帱�����Ӧ��id��
function CFuben:ApplyFuBenEx(nType, nId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer  then
		local nTime =  tonumber(KGblTask.SCGetDbTaskInt(DBTASD_SERVER_STARTTIME));
		local nNowTime = Lib:GetDate2Time(tonumber(GetLocalDate("%Y%m%d"))*10000);
		if nNowTime - nTime < self.FUBEN[nType][nId].nTime * 24 * 3600 then
			pPlayer.Msg("�˴���û�г���ֱ����պ�������");
			return 0;
		end	
		if self.FubenData[nPlayerId] then
			pPlayer.Msg(string.format("���Ѿ�������<color=yellow> %s <color>�����������������ˣ�",self.FUBEN[self.FubenData[nPlayerId][4]][self.FubenData[nPlayerId][5]].szName)) ;
			return 0;
		end
		--���ģʽ��Ҫ�ж϶ӳ����ǲ����ж���ģ�����ģʽĬ�ϸ����Ѿ�����Ҫ��
		if self.FUBEN[nType][nId].nGroupModel == 1 then
			local tbPlayerList = KTeam.GetTeamMemberList(pPlayer.nTeamId);
			if pPlayer.nTeamId == 0 then
				pPlayer.Msg("��û�ж��飡");
				return 0;
			end
			local tbPlayerList = KTeam.GetTeamMemberList(pPlayer.nTeamId);
			if tbPlayerList[1] ~= me.nId then
				pPlayer.Msg("�����Ƕӳ���");
				return 0;
			end				
			if #tbPlayerList < self.FUBEN[nType][nId].nMinNumber or #tbPlayerList > self.FUBEN[nType][nId].nMaxNumber then
				KTeam.Msg2Team(pPlayer.nTeamId, string.format("���Ƕӳ�Ա����<color=yellow>%s<color>�����Ƕ���<color=yellow>%s<color>",self.FUBEN[nType][nId].nMinNumber,self.FUBEN[nType][nId].nMaxNumber));
				return 0;
			end
			for i = 1,#tbPlayerList do
				local pPlayerEx = KPlayer.GetPlayerObjById(tbPlayerList[i]);
				if pPlayerEx then
					if pPlayerEx.nLevel < self.FUBEN[nType][nId].nGrade or pPlayerEx.nFaction == 0 then
						KTeam.Msg2Team(pPlayerEx.nTeamId, string.format("���Ƕӵ�<color=white>  %s  <color>��ô���ǲ������ǲ���ȥ�ģ�",pPlayerEx.szName));
						return 0;
					end
					local nDate = pPlayerEx.GetTask(CFuben.TASKID_GROUP,CFuben.TASKID_DATE);
					local nTimes =  0;
					local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
					if  nDate ~= nNowDate then
						pPlayerEx.SetTask(CFuben.TASKID_GROUP,CFuben.TASKID_DATE,nNowDate);
						pPlayerEx.SetTask(CFuben.TASKID_GROUP,CFuben.TASKID_NTIMES + nType -1, 0);
					else
						nTimes = pPlayerEx.GetTask(CFuben.TASKID_GROUP,CFuben.TASKID_NTIMES + nType -1) or 0;
					end
					if nTimes >= self.FUBEN[nType].nCount  then
						KTeam.Msg2Team(pPlayerEx.nTeamId,string.format("%s����Ĵ����Ѿ������ˣ�",pPlayerEx.szName));
						return 0;
					end
				end
 			end
		end
		if self:ApplyMap(pPlayer.nId, nType, nId) == 1 then
			pPlayer.Msg(string.format("�ɹ�����<color=yellow>%s<color>������",self.FUBEN[nType][nId].szName));
			return 1;
		end
	end
end

function CFuben:IsSatisfy(nPlayerId, nCaptainId)	--���븱������	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then		
		if not self.FubenData[nCaptainId] then
			pPlayer.Msg("���Ķ��顢������ǰ��ɲ�û��û�����븱����");
			return 0;
		end
		local nTempMapId = self.FubenData[nCaptainId][1];
		local nMapId = self.FubenData[nCaptainId][2];
		local nType = self.FubenData[nCaptainId][4];
		local nId = self.FubenData[nCaptainId][5];
		if  CFuben.tbMapList[nTempMapId][nMapId].IsOpen == 0 then
			pPlayer.Msg("���Ķ��顢������ǰ�������ĸ�����û�п�����");
			return 0;
		end
		
		local nApplyedMap, nPosX, nPosY = pPlayer.GetWorldPos();
		if nApplyedMap ~=  	 self.FubenData[nCaptainId][3] then
			pPlayer.Msg(string.format("��ص�����ø����ĵ�ͼ<color=yellow>%s<color>����������룡", GetMapNameFormId(self.FubenData[nCaptainId][3])));
			return 0;
		end

		local nDate = pPlayer.GetTask(CFuben.TASKID_GROUP,CFuben.TASKID_DATE);
		local nTimes = 0;
		local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
		if  nDate ~= nNowDate then
			pPlayer.SetTask(CFuben.TASKID_GROUP,CFuben.TASKID_DATE,nNowDate);
			pPlayer.SetTask(CFuben.TASKID_GROUP,CFuben.TASKID_NTIMES + nType -1, 0);
		else
			nTimes = pPlayer.GetTask(CFuben.TASKID_GROUP,CFuben.TASKID_NTIMES + nType -1) or 0;
		end
		if nTimes >= self.FUBEN[nType].nCount then
			KTeam.Msg2Team(pPlayerEx.nTeamId,string.format("%s����Ĵ����Ѿ������ˣ�",pPlayerEx.szName));
			return 0;
		end
		
		if self.FUBEN[nType][nId].nGroupModel == 1 then		--���ģʽ
			local tbPlayerList = KTeam.GetTeamMemberList(pPlayer.nTeamId);
			if #tbPlayerList < self.FUBEN[nType][nId].nMinNumber or #tbPlayerList > self.FUBEN[nType][nId].nMaxNumber then
				pPlayer.Msg(string.format("���Ƕӳ�Ա����<color=yellow>%s<color>�����Ƕ���<color=yellow>%s<color>",self.FUBEN[nType][nId].nMinNumber,self.FUBEN[nType][nId].nMaxNumber));
				return 0;
			end
			if (self.tbMapList[nTempMapId][nMapId].nCount or 0) >= self.FUBEN[nType][nId].nMaxNumber then
				pPlayer.Msg("���Ƕӳ��Ѿ�����ȥ�㹻�����ˣ��������ټ�����");
				return 0;				
			end
		elseif self.FUBEN[nType][nId].nGroupModel == 2 then  --����ģʽ
			if (self.tbMapList[nTempMapId][nMapId].nCount or 0) >= self.FUBEN[nType][nId].nMaxNumber then
				pPlayer.Msg("�Ѿ���ȥ�㹻�����ˣ��������ټ�����");
				return 0;
			end
		elseif self.FUBEN[nType][nId].nGroupModel == 3 then		--����ģʽ
			if (self.tbMapList[nTempMapId][nMapId].nCount or 0) >= self.FUBEN[nType][nId].nMaxNumber then
				pPlayer.Msg("�Ѿ���ȥ�㹻�����ˣ��������ټ�����");
				return 0;
			end
		end
		
		if pPlayer.nLevel < self.FUBEN[nType][nId].nGrade then
			pPlayer.Msg(string.format("���ĵȼ���δ�ﵽ %s ��������������»�ȥ���������յĵط���",self.FUBEN[nType][nId].nGrade));
			return 0;
		end
	end
	return 1;
end

function CFuben:Init()
	CFuben.FubenData = {};
	for _, varFuBen in pairs(CFuben.FUBEN) do
		if type(varFuBen) == "table" then
			for _ , tbFuBen in ipairs(varFuBen) do
				local nMapId = tbFuBen.nMapId;
				CFuben.tbMapList[nMapId] = CFuben.tbMapList[nMapId] or {};
				CFuben.tbMapList[nMapId].nCount = CFuben.tbMapList[nMapId].nCount or 0;
			end
		end
 	end	
end

function CFuben:JoinGame(nPlayerId, nCaptainId)
	local nTempMapId = self.FubenData[nCaptainId][1];
	local nDyMapId = self.FubenData[nCaptainId][2];
	local nType = self.FubenData[nCaptainId][4];
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		if not self.tbMapList[nTempMapId][nDyMapId].PlayerList[nPlayerId] then	
			--joinmission		
			local nTimes = (pPlayer.GetTask(CFuben.TASKID_GROUP,CFuben.TASKID_NTIMES + nType -1) or 0) + 1;			
			pPlayer.SetTask(CFuben.TASKID_GROUP,CFuben.TASKID_NTIMES + nType -1, nTimes);
			self.tbMapList[nTempMapId][nDyMapId].PlayerList[nPlayerId] = 1;
		end
		self.tbMapList[nTempMapId][nDyMapId].nCount = self.tbMapList[nTempMapId][nDyMapId].nCount + 1;
		self.tbMapList[nTempMapId][nDyMapId].MissionList:JoinPlayer(pPlayer,1);	
	end
end

function CFuben:OnLeave(nPlayerId) --����fb�ӳ�id
	local nTempMapId = self.FubenData[nPlayerId][1];
	local nDyMapId = self.FubenData[nPlayerId][2];
	if self.tbMapList[nTempMapId][nDyMapId].nCount >= 1 then
		self.tbMapList[nTempMapId][nDyMapId].nCount = self.tbMapList[nTempMapId][nDyMapId].nCount - 1;
	end
end

function CFuben:ApplyMap(nPlayerId, nType, nId)	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then		
		if self.FUBEN[nType][nId].szConditionItemName and self.FUBEN[nType][nId].szConditionItemName ~= "" then
			local tbFind = pPlayer.FindClassItemInBags(self.FUBEN[nType][nId].szConditionItemName);
			if not tbFind[1] then
				pPlayer.Msg("������û�п�����Կ�ף��ǲ�������ģ�");
				return 0;
			end
		end
		local nPlayerMapId, nPosX, nPosY = me.GetWorldPos();	
		local szMapType = GetMapType(nPlayerMapId);
		if self.FUBEN[nType][nId].szConditionMapType and self.FUBEN[nType][nId].szConditionMapType ~= szMapType then
			pPlayer.Msg(string.format("�õ�ͼ��������˸������뵽<color=yellow>%s<color>ȥ����ɣ�",self.tbMapType[self.FUBEN[nType][nId].szConditionMapType]));
			return 0;
		end
		local nTempMapId = self.FUBEN[nType][nId].nMapId;
		if self:GetServerLoadMapCount(nTempMapId) >= self.FUBEN[nType][nId].nCount then
			pPlayer.Msg("��λӢ���Ѵ���˵أ���λ��ʿ�����Ժ�Ƭ�̡�");
			return 0;
		end
		--if SubWorldID2Idx(nTempMapId) >= 0 then
		--�����õĵ�ͼ
		if self.tbMapList[nTempMapId] then
			for nMapId, varValue in pairs(self.tbMapList[nTempMapId]) do								
				if  type(varValue) == "table" and self.tbMapList[nTempMapId][nMapId] and self.tbMapList[nTempMapId][nMapId].OnUsed ~= 1 
				and  self.tbMapList[nTempMapId][nMapId].IsServer then
					--self.tbMapList[nTempMapId][nMapId].OnUsed = 1;	--��ͼ��Ϊռ��
					--self.FubenData[nPlayerId] = {nTempMapId, nMapId, nPlayerMapId, nPosX, nPosY};					
					GlobalExcute{"CFuben:OnLoadMap", nPlayerId, nType, nId, nPlayerMapId, nPosX, nPosY, nMapId, 0};
					return 1;
				end
			end
		--�����ͼ
			local nTempMapId = self.FUBEN[nType][nId].nMapId;
			self.FubenData[nPlayerId] = {nTempMapId, 0, nPlayerMapId, nType, nId, nPosX, nPosY};
			if (Map:LoadDynMap(1, nTempMapId, {self.OnLoadMapFinish, self, nPlayerId, nType, nId, nPlayerMapId, nPosX, nPosY}) ~= 1) then
				print(string.format("������ͼ%s���ش���",nTempMapId));
				self.ResetMapState(nPlayerId);
				return 0;
			end			
			return 1;
		end
	end
	return 0;
end

--��������ɹ��ص�
function CFuben:OnLoadMapFinish(nPlayerId, nType, nId, nPlayerMapId, nPosX, nPosY,nDyMapId)
	local nTempMapId = self.FUBEN[nType][nId].nMapId;
	self.tbMapList[nTempMapId][nDyMapId] = {};
	self.tbMapList[nTempMapId][nDyMapId].IsServer = 1;
	GlobalExcute{"CFuben:OnLoadMap", nPlayerId, nType, nId, nPlayerMapId, nPosX, nPosY, nDyMapId, 1};
end

function CFuben:CloseEx(nPlayerId)--����fb�ӳ�id
	local nTempMapId = self.FubenData[nPlayerId][1];
	local nDyMapId = self.FubenData[nPlayerId][2];
	GlobalExcute{"CFuben:Close", nTempMapId, nDyMapId, nPlayerId};
end

function CFuben:GameStart(nPlayerId, nDyMapId)		
	local nTempMapId = self.FubenData[nPlayerId][1];
	local nType = self.FubenData[nPlayerId][4];
	local nId = self.FubenData[nPlayerId][5];
	local nFlag = self.tbMapList[nTempMapId].IsAddTrap;	
	self.tbMapList[nTempMapId][nDyMapId].MissionList = self.tbMapList[nTempMapId][nDyMapId].MissionList or Lib:NewClass(CFuben.FubenMission);	
	self.tbMapList[nTempMapId][nDyMapId].MissionList:InitGameEx(nDyMapId,nPlayerId,self.FUBEN[nType][nId].nFubenId);
	self.tbMapList[nTempMapId][nDyMapId].MissionList:StartGame(nFlag);
	--����mission
end

function CFuben:OnLoadMap(nPlayerId, nType, nId, nPlayerMapId, nPosX, nPosY,nDyMapId, nFlag)
	local nTempMapId = self.FUBEN[nType][nId].nMapId;
	self.tbMapList[nTempMapId][nDyMapId] = self.tbMapList[nTempMapId][nDyMapId] or {};
	self.tbMapList[nTempMapId][nDyMapId].OnUsed = 1;	--��ͼ��Ϊռ��
	self.tbMapList[nTempMapId].nCount = self.tbMapList[nTempMapId].nCount  + 1;
	self.tbMapList[nTempMapId][nDyMapId].nCount = 0;
	self.tbMapList[nTempMapId][nDyMapId].IsOpen = 0;
	self.tbMapList[nTempMapId].IsAddTrap = nFlag;	
	self.tbMapList[nTempMapId][nDyMapId].PlayerList = {};
	self.FubenData[nPlayerId] = {nTempMapId, nDyMapId, nPlayerMapId, nType, nId, nPosX, nPosY};		
	--������������
	if self.FUBEN[nType][nId].nFlagAuto == 1 then
		self:GameStart(nPlayerId, nDyMapId);
		self.tbMapList[nTempMapId][nDyMapId].IsOpen = 1;
	else		
		Timer:Register(CFuben.NTIMES_END, self.ReSetFuben, self, nPlayerId);
	end
end

function CFuben:Close(nTempMapId, nDyMapId, nPlayerId)
	local nType = self.FubenData[nPlayerId][4];
	local nId = self.FubenData[nPlayerId][5];
	self.tbMapList[nTempMapId][nDyMapId].OnUsed = 0;	--���õ�ͼ
	self.tbMapList[nTempMapId].nCount = self.tbMapList[nTempMapId] .nCount  - 1;
	self.tbMapList[nTempMapId][nDyMapId].nCount = 0;
	self.tbMapList[nTempMapId][nDyMapId].IsOpen = 0;
	self.tbMapList[nTempMapId][nDyMapId].PlayerList = {};
	self.FubenData[nPlayerId] = nil;
	if self.FUBEN[nType][nId].szItemId and self.FUBEN[nType][nId].szItemId ~= "" then
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			local tbItem = pPlayer.FindClassItemInBags("fuben");
			for i = 1 , #tbItem do
				if string.format("%s,%s,%s,%s", tbItem[i].pItem.nGenre, tbItem[i].pItem.nDetail, tbItem[i].pItem.nParticular, tbItem[i].pItem.nLevel) == self.FUBEN[nType][nId].szItemId and tbItem[i].pItem.GetGenInfo(1) == 1 then
					pPlayer.Msg(string.format("�����������ĸ�����ʱ��û�н��룬ϵͳ�Զ�ɾ�����ڸ�������Ʒ<color=yellow>%s<color>��",tbItem[i].pItem.szName));				
					tbItem[i].pItem.Delete(pPlayer);
				end
			end
		end
	end
end

function CFuben:ResetMapState(nPlayerId)
	self.FubenData[nPlayerId] = nil;
end

function CFuben:FindFunben(nFlag,nVarId)
	for nPlayerId,  tbFuben in pairs(self.FubenData) do
		local nTempMapId = tbFuben[1];
		local nDyMapId = tbFuben[2];	
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			if nFlag == 2 then
				if pPlayer.dwKinId == nVarId then
					return 1, nPlayerId;
				end
			elseif pPlayer.dwTongId == nVarId then
				return 1, nPlayerId;				
			end			
		end		
	end
	return 0, 0;
end

function CFuben:ReSetFuben(nPlayerId)	
	if not CFuben.FubenData[nPlayerId] then
		return 0;
	end
	local nTempMapId = self.FubenData[nPlayerId][1];
	local nDyMapId = self.FubenData[nPlayerId][2];
	local nType = self.FubenData[nPlayerId][4];
	local nId = self.FubenData[nPlayerId][5];
	if self.tbMapList[nTempMapId][nDyMapId].OnUsed == 1 and self.tbMapList[nTempMapId][nDyMapId].IsOpen == 0 then
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			pPlayer.Msg(string.format("�������<color=yellow>%s<color>�������ڳ�ʱ��û�п�����ϵͳ�Զ��ջأ�", self.FUBEN[nType][nId].szName));
		end
		self.tbMapList[nTempMapId][nDyMapId].OnUsed = 0;
		self.tbMapList[nTempMapId].nCount = self.tbMapList[nTempMapId] .nCount  - 1;
		self.FubenData[nPlayerId] = nil;
	end
	return 0;
end

function CFuben:GetServerLoadMapCount(nTempMapId)
	local nCount = 0;
	for nMapId, varValue in pairs(self.tbMapList[nTempMapId]) do								
		if type(varValue) == "table" and self.tbMapList[nTempMapId][nMapId].IsServer then
			nCount = nCount + 1;
		end
	end
	return nCount
end

ServerEvent:RegisterServerStartFunc(CFuben.Init, CFuben);
