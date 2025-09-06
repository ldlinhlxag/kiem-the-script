-- �ļ�������console_gs.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-04-23 10:04:41
-- ��  ��  ��--����̨

if (MODULE_GC_SERVER) then
	return 0;
end

Console.Base = Console.Base or {};
local tbBase = Console.Base;

----�ӿ�,�Զ���----

--��������
function tbBase:OnJoin()
	--print("OnJoin", me.szName)
end

--�뿪�����
function tbBase:OnLeave()
	--print("OnLeave", me.szName)
end

--����׼�����غ�
function tbBase:OnJoinWaitMap()
	--print("OnJoinWaitMap", me.szName)
end

--�뿪׼�����غ�
function tbBase:OnLeaveWaitMap()
	--print("OnLeaveWaitMap", me.szName)
end

--�����߼�
function tbBase:OnGroupLogic()
	--print("OnGroupLogic");
end
--��������
function tbBase:OpenSingleUi(pPlayer, szMsg, nLastFrameTime)
	if not pPlayer or pPlayer == 0 then
		return 0;
	end
	Dialog:SetBattleTimer(pPlayer,  szMsg, nLastFrameTime);
	Dialog:ShowBattleMsg(pPlayer,  1,  0); --��������
end

--�رս���
function tbBase:CloseSingleUi(pPlayer)
	if not pPlayer or pPlayer == 0 then
		return 0;
	end
	Dialog:ShowBattleMsg(pPlayer,  0,  0); -- �رս���
end

--���½���ʱ��
function tbBase:UpdateTimeUi(pPlayer, szMsg, nLastFrameTime)
	if not pPlayer or pPlayer == 0 then
		return 0;
	end
	Dialog:SetBattleTimer(pPlayer,  szMsg, nLastFrameTime);
end

--���½�����Ϣ
function tbBase:UpdateMsgUi(pPlayer, szMsg)
	if not pPlayer or pPlayer == 0 then
		return 0;
	end
	Dialog:SendBattleMsg(pPlayer, szMsg, 1);
end

function tbBase:GetRestTime()
	if self.tbTimerList.nReadyId then
		return Timer:GetRestTime(self.tbTimerList.nReadyId);
	end
	return 0;
end

function tbBase:KickPlayer(pPlayer)
	pPlayer.NewWorld(self:GetLeaveMapPos());
end

function tbBase:KickAllPlayer()
	if not self.tbGroupLists then
		return 0;
	end
	for nMapId, tbGroupList in pairs(self.tbGroupLists) do
		if SubWorldID2Idx(nMapId) >= 0 then
			local tbGroupLists = tbGroupList.tbList;
			if tbGroupLists then
				for nGroup, tbGroup in pairs(tbGroupLists) do
					for _, nPlayerId in pairs(tbGroup) do
						local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
						if pPlayer then
							self:KickPlayer(pPlayer);
						end
					end
				end
			end
		end
	end	
end

---���ýӿ�----

--����,����׼����
function tbBase:ApplySignUp(tbPlayerIdList)
	if self:IsFull(#tbPlayerIdList) == 0 then
		Dialog:Say("Số lượng đã đầy.");
		return 0;
	end
	if self:GetRestTime() <= 5*18 then
		Dialog:Say("Không thể đăng ký nữa.");
		return 0;
	end
	Console:ApplySignUp(self.nDegree, tbPlayerIdList);
end

----end----

--��ͼ����Start
function tbBase:SetMapCfg()
	if self.tbCfg.tbMap then
		for nMapId, tbPos in pairs(self.tbCfg.tbMap) do
			local tbReadyMap = Map:GetClass(nMapId);
			tbReadyMap.OnEnterConsole = function() self:MapReadyOnEnter() end;
			tbReadyMap.OnLeaveConsole = function() self:MapReadyOnLeave() end;
		end
	end
	
	if self.tbCfg.nDynamicMap and self.tbCfg.nDynamicMap > 0 then
		local tbMap = Map:GetClass(self.tbCfg.nDynamicMap);
		tbMap.OnEnterConsole = function() self:MapOnEnter() end;
		tbMap.OnLeaveConsole = function() self:MapOnLeave() end;
	end
end

function tbBase:ApplyDyMap()
	if self.tbCfg.tbMap and self.tbCfg.nDynamicMap then
		for nMapId, tbPos in pairs(self.tbCfg.tbMap) do
			if SubWorldID2Idx(nMapId) >= 0 then
				Console:ApplyDyMap(self.nDegree, nMapId);
			end
		end
	end
end

function tbBase:GetLeaveMapPos()
	for nMapId, tbPos in pairs(self.tbCfg.tbMap) do
		if SubWorldID2Idx(nMapId) >= 0 then
			if tbPos and tbPos.tbOutPos then
				return unpack(tbPos.tbOutPos);
			end
		end
	end
	
	local tbNpc = Npc:GetClass("chefu");
	for _, tbMapInfo in ipairs(tbNpc.tbCountry) do
		if SubWorldID2Idx(tbMapInfo.nId) >= 0 then
			local nRandomPos = MathRandom(1, #tbMapInfo.tbSect)
			return tbMapInfo.nId, tbMapInfo.tbSect[nRandomPos][1],tbMapInfo.tbSect[nRandomPos][2];
		end
	end
	return 5, 1580, 3029;
end

--���󣬷��䶯̬��ͼ��������ţ�
function tbBase:OnDyJoin(pPlayer, nDyId, GroupId)
	local tbData = self:GetPlayerData(pPlayer.nMapId, pPlayer.nId);
	if not tbData then
		return 0;
	end
	local nCaptain = tbData.nCaptain;
	local nGroupId = tbData.nGroupId;
	local nMapId   = tbData.nMapId;	
	
	self.tbMapGroupList[nMapId][nDyId] = self.tbMapGroupList[nMapId][nDyId] or {};
	self.tbMapGroupList[nMapId][nDyId][GroupId] = self.tbMapGroupList[nMapId][nDyId][GroupId] or {tbList={},tbPos={}};
	table.insert(self.tbMapGroupList[nMapId][nDyId][GroupId].tbList, pPlayer.nId);
end

function tbBase:StartSignUp()

	self:KickAllPlayer();
	self:Init();
	self:SetMapCfg();
	self:ApplyDyMap();	
	local nDegree = self.nDegree;
	self.nState 	  = 1;
	self.tbTimerList.nReadyId = Timer:Register((self.tbCfg.nReadyTime), self.TimerClose, self)	
	if self.OnMySignUp then
		self:OnMySignUp();
	end
end

function tbBase:TimerClose()
	--self.nState 	  = 2;
	return 0;
end

function tbBase:MapReadyOnEnter()
	me.SetLogoutRV(1);
	if self.nState ~=  1 then
		return 0;
	end
	self:ReadyOnJoin(me.nMapId, me.nId);
	self:OnJoinWaitMap();
end


function tbBase:MapReadyOnLeave()
	--me.SetLogoutRV(0);
	self:CloseSingleUi(me);
	self:ReadyOnLeave(me.nMapId, me.nId);
	self:OnLeaveWaitMap();
end

function tbBase:MapOnEnter()
	me.SetLogoutRV(1);
	self:OnJoin();
end

function tbBase:MapOnLeave()
	self:CloseSingleUi(me);
	self:OnLeave();
	--me.SetLogoutRV(0);
end

--��ͼ����End

function tbBase:GetPlayerData(nMapId, nId)
	return self.tbPlayerData[nMapId][nId];
end

--����׼����
function tbBase:ReadyOnJoin(nMapId, nId)
	local tbData = self:GetPlayerData(nMapId, nId);
	if not tbData then
		return 0;
	end
	local nCaptain = tbData.nCaptain;
	local nGroupId = tbData.nGroupId;
	--local nMapId = tbData.nMapId;
	
	if nCaptain == 1 then
		table.insert(self.tbGroupLists[nMapId].tbList[nGroupId], 1, nId);
	else
		table.insert(self.tbGroupLists[nMapId].tbList[nGroupId], nId);
	end
end

--�뿪׼����
function tbBase:ReadyOnLeave(nMapId, nId)
	if self.nState >= 2 then
		return 0;
	end	
	GCExcute{"Console:LeaveGroupList", self.nDegree, nMapId, nId};
	GlobalExcute{"Console:LeaveGroupList", self.nDegree, nMapId, nId};
end

function tbBase:OnStartMission()
	self.nState 	  = 2;
	local nDyMapIndex = 1;
	if not self.tbGroupLists then
		return 0;
	end
	for nMapId, tbGroupList in pairs(self.tbGroupLists) do
		if SubWorldID2Idx(nMapId) >= 0 then
			
			local tbGroupLists = {};
			local nPlayerMax   = 0;
			for _, tbGroupTemp in pairs(tbGroupList.tbList) do
				local nCount = #tbGroupTemp
				if nCount > 0 then
					table.insert(tbGroupLists, tbGroupTemp);
					nPlayerMax = nPlayerMax + nCount;
				end
			end
			
			local nGroupMax = #tbGroupLists;
			if nGroupMax > 0 then
				for i, tbGroups in ipairs(tbGroupLists) do
					local nP = MathRandom(1, nGroupMax);
					tbGroups[i], tbGroups[nP] = tbGroups[nP], tbGroups[i];
				end
			end
			
			local tbCfg = {
				nDyMapIndex	 = nDyMapIndex,
				tbGroupLists = tbGroupLists,
				nPlayerMax   = nPlayerMax,
				nGroupMax	 = nGroupMax,
			}
			self:OnGroupLogic(tbCfg);
		end
	end
	self.tbGroupLists = {};
	local nDegree = self.nDegree;
	for nWaitMapId, tbPos in pairs(self.tbCfg.tbMap) do
		if SubWorldID2Idx(nWaitMapId) >= 0 then
			for nDyId, tbGroupLists in pairs(self.tbMapGroupList[nWaitMapId]) do
				local nDyMapId = Console.tbDynMapLists[nWaitMapId][nDyId];
				local tbCfg = {
					nWaitMapId	 = nWaitMapId,		--׼����Id
					nDyMapId 	 = nDyMapId,	--���Id
					tbGroupLists = tbGroupLists,	--�����б�
				}
				self:OnMyStart(tbCfg);
			end
		end
	end
	return 0;
end
