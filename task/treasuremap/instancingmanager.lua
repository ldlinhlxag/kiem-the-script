Require("\\script\\task\\treasuremap\\treasuremap.lua")

local tbInstancingMgr = TreasureMap.InstancingMgr;
tbInstancingMgr.tbUsable = {}; 		-- 已經加載的可用副本地圖列表
tbInstancingMgr.tbWaitQueue = {};	-- 等待FB的隊列
tbInstancingMgr.tbOpenedList = {};	-- 已經打開的FB列表
 
-- 玩家開出一個FB
function tbInstancingMgr:CreatInstancing(pPlayer, nTreasureId)
	assert(pPlayer)
	if (pPlayer.nTeamId == 0) then
		Dialog:SendInfoBoardMsg(pPlayer, "<color=red>Chỉ có tổ đội mới được tham gia!<color>");
		return;
	end
	
	local tbTreasureInfo = TreasureMap:GetTreasureInfo(nTreasureId);
	local nMyMapId, nMyPosX, nMyPosY	= pPlayer.GetWorldPos();
	if (tbTreasureInfo.MapId ~= nMyMapId) then
		Dialog:SendInfoBoardMsg(pPlayer, "<color=red>Bạn và bảo tàng không cùng trên một khu vực!<color>");
		return;
	end
	
	local nTreasureMapId, bReset = self:PreorderMap(tbTreasureInfo.InstancingMapId, nTreasureId, tbTreasureInfo.MaxMap);
	
	-- 通知GC載入地圖
	if (not nTreasureMapId) then
		if (LoadDynMap(Map.DYNMAP_TREASUREMAP, tbTreasureInfo.InstancingMapId, nTreasureId) == 1) then
			self.tbWaitQueue[#self.tbWaitQueue + 1] = {nPlayerId = pPlayer.nId, tbPos = {nMyMapId, nMyPosX, nMyPosY}, nTreasureId = nTreasureId, nMapTemplateId = tbTreasureInfo.InstancingMapId};
		end
	else
		self:OpenMap(pPlayer, nTreasureId, nTreasureMapId, tbTreasureInfo.MapId, nMyPosX, nMyPosY, bReset);
	end
end


-- 預訂一個副本
function tbInstancingMgr:PreorderMap(nMapTemplateId, nTreasureId, nMaxMap)
	local bReset = 1;	-- 是否需要重置副本
	
	-- 復用之前可用的老的副本，需要重置
	for nIndex = 1, #self.tbUsable[nTreasureId] do
		if ((self.tbUsable[nTreasureId][nIndex].MapTemplateId == nMapTemplateId) and (self.tbUsable[nTreasureId][nIndex].Free == 1)) then
			self.tbUsable[nTreasureId][nIndex].Free = 0;
			return self.tbUsable[nTreasureId][nIndex].MapId, bReset;
		end
	end
	
	
	-- 進入一個有人的副本
	if (nMaxMap > 0 and #self.tbUsable[nTreasureId] >= nMaxMap) then
		bReset = 0;
		local nIndex = MathRandom(#self.tbUsable[nTreasureId]);
		return self.tbUsable[nTreasureId][nIndex].MapId, bReset;	-- 進入有人的FB，不重置裡面的東西
	end
	
	-- 執行到此處說明沒有FB可用，需要通知GC載入一個地圖
end

-- GC載入地圖完畢
function tbInstancingMgr:OnLoadMapFinish(nTreasureMapId, nMapTemplateId, nTreasureId)
	if (#self.tbWaitQueue == 0) then
		assert(false);
		return;
	end
	
	for nIndex = 1, #self.tbWaitQueue do
		if (nMapTemplateId == self.tbWaitQueue[nIndex].nMapTemplateId and nTreasureId == self.tbWaitQueue[nIndex].nTreasureId) then
			local pPlayer = KPlayer.GetPlayerObjById(self.tbWaitQueue[nIndex].nPlayerId);
			if (pPlayer and pPlayer.nTeamId ~= 0) then
				self.tbUsable[nTreasureId][#self.tbUsable[nTreasureId] + 1] = {MapTemplateId = nMapTemplateId, MapId = nTreasureMapId, Free = 0};
				self:OpenMap(pPlayer, self.tbWaitQueue[nIndex].nTreasureId, nTreasureMapId, self.tbWaitQueue[nIndex].tbPos[1], self.tbWaitQueue[nIndex].tbPos[2], self.tbWaitQueue[nIndex].tbPos[3], 1);
				table.remove(self.tbWaitQueue, nIndex);
				break;
			else
				self.tbUsable[nTreasureId][#self.tbUsable[nTreasureId] + 1] = {MapTemplateId = nMapTemplateId, MapId = nTreasureMapId, Free = 1};
				table.remove(self.tbWaitQueue, nIndex);
				break;
			end
		end
	end
end


-- 開啟副本地圖
function tbInstancingMgr:OpenMap(pPlayer, nTreasureId, nTreasureMapId, nEntranceMapId, nEntranceMapPosX, nEntranceMapPosY, bReset)
	assert(pPlayer)
	if (bReset == 1) then
		assert(not self.tbOpenedList[nTreasureMapId]);
	end
	
	self:RegisterEntranceNpc(pPlayer, nTreasureId, nTreasureMapId, nEntranceMapId, nEntranceMapPosX, nEntranceMapPosY, bReset);
	if (bReset == 1) then
		self:ResetMap(nTreasureMapId);
	end
	
	
	local tbInfo = TreasureMap:GetTreasureInfo(nTreasureId);
	local nMapTemplateId = tbInfo.InstancingMapId;
	local tbInstancingBase = TreasureMap:GetInstancingBase(nMapTemplateId);
	local tbInstancing = Lib:NewClass(tbInstancingBase);
	
	self.tbOpenedList[nTreasureMapId] = tbInstancing;
	tbInstancing.nTreasureId = nTreasureId;
	tbInstancing.nTreasureMapId = nTreasureMapId;
	tbInstancing.nMapTemplateId = nMapTemplateId;
	if (bReset == 1) then
		tbInstancing.nFirstOpenerId = pPlayer.nId;
		tbInstancing:OnNew();
		tbInstancing.nCurStep = 1;
		if (tbInstancing.GetSteps and #tbInstancing:GetSteps() > 0) then
			tbInstancing.nTimerId = Timer:Register(TreasureMap.nInstancingCheckTime, self.OnInstancingTimer, self, nTreasureMapId);
		end
	end
	tbInstancing.tbPlayerList = {};
	tbInstancing:OnOpen();
	
	--額外事件，活動系統
	SpecialEvent.ExtendEvent:DoExecute("Open_Treasure", tbInfo.nLevel, nTreasureMapId, nMapTemplateId);
end


function tbInstancingMgr:OnInstancingTimer(nTreasureMapId)
	local tbInstancing = self.tbOpenedList[nTreasureMapId];
	if (not tbInstancing) then
		return;
	end
	local tbSteps = tbInstancing:GetSteps();
	local tbStep = tbSteps[tbInstancing.nCurStep]
	if (not tbStep) then
		tbInstancing.nTimerId = nil;
		return 0;
	end
	
	-- 滿足condition
	if (self:CheckConditions(tbStep.tbConditions) == 1) then
		tbInstancing.nCurStep = tbInstancing.nCurStep + 1;
		self:DoActions(tbStep.tbActions);
		return tbStep.nTime * Env.GAME_FPS;
	end
	
	return TreasureMap.nInstancingCheckTime;
end


function tbInstancingMgr:CheckConditions(tbConditions)
	if (not tbConditions) then
		return 1;
	end
	
	for _, tbCondition in ipairs(tbConditions) do
		local _, nRet	= Lib:CallBack(tbCondition);
		if (nRet ~= 1) then
			return 0
		end
	end
	
	return 1;
end

function tbInstancingMgr:DoActions(tbActions)
	if (not tbActions) then
		return;
	end
	
	for _, tbAction in ipairs(tbActions) do
		Lib:CallBack(tbAction);
	end
end


-- 注冊一個入口Npc
function tbInstancingMgr:RegisterEntranceNpc(pPlayer, nTreasureId, nTreasureMapId, nEntranceMapId, nEntranceMapPosX, nEntranceMapPosY, bReset)
	assert(pPlayer);
	local tbTreasureInfo = TreasureMap:GetTreasureInfo(nTreasureId);
	local pNpc = KNpc.Add2(TreasureMap.TreasureMapEntranceNpcId, 1, -1, nEntranceMapId, nEntranceMapPosX, nEntranceMapPosY);
	local tbNpcData = pNpc.GetTempTable("TreasureMap");

	tbNpcData.nEntrancePlayerId 	= pPlayer.nId;
	tbNpcData.nEntranceTreasureId 	= nTreasureId;
	tbNpcData.nTreasureMapId		= nTreasureMapId;
	tbNpcData.nTreasureMapLevel		= tbTreasureInfo.Level;
	tbNpcData.nMapTemplateId		= tbTreasureInfo.InstancingMapId;
	
	local szTitle = pPlayer.szName.." đào được lối vào địa cung";
	pNpc.SetTitle(szTitle);
	Timer:Register(50 *60 *Env.GAME_FPS, self.DelEntrance, self, pPlayer.nId, pNpc.dwId);
	
	if (bReset) then
		Timer:Register(tbTreasureInfo.Duration * 60 * Env.GAME_FPS, self.DelMap, self, nTreasureId, nTreasureMapId, nEntranceMapId, nEntranceMapPosX, nEntranceMapPosY, pPlayer.nId);
	end
end

-- 刪除入口
function tbInstancingMgr:DelEntrance(nPlayerId, nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return;
	end
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (pPlayer) then
		pPlayer.Msg("<color=yellow>Lối vào địa cung vừa phát hiện đã không còn!<color>")
	end
	
	pNpc.Delete();
	
	return 0;
end


-- 刪除一個副本地圖
function tbInstancingMgr:DelMap(nTreasureId, nMapId, nEntranceMapId, nEntranceMapPosX, nEntranceMapPosY, nPlayerId)
	assert(self.tbOpenedList[nMapId]);
	local tbInstancing = self.tbOpenedList[nMapId];
	
	-- 關閉計時器
	if (tbInstancing.nTimerId) then
		Timer:Close(tbInstancing.nTimerId);
		tbInstancing.nTimerId = nil;
	end
	
	if (tbInstancing.OnDelete) then
		tbInstancing:OnDelete();
	end
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (pPlayer) then
		pPlayer.Msg("<color=yellow>Cùng với tiếng nổ, tất cả các mê cung đều sụp đổ!<color>")
	end
	
	-- 玩家回到入口點
	local tbPlayerList = KPlayer.GetMapPlayer(nMapId);
	for _, pPlayer in pairs(tbPlayerList) do
		pPlayer.NewWorld(nEntranceMapId, nEntranceMapPosX, nEntranceMapPosY);
	end
	
	for _, Instancing in ipairs(self.tbUsable[nTreasureId]) do
		if (Instancing.MapId == nMapId and Instancing.Free == 0) then
			Instancing.Free = 1;
			break;
		end
	end
	
	self.tbOpenedList[nMapId] = nil;
	
	return 0;
end


-- 重置一個副本地圖
function tbInstancingMgr:ResetMap(nMapId)
	ResetMapNpc(nMapId);
end


function tbInstancingMgr:ShowInstancingInfo(pPlayer)
	for _, tbTreasureMap in pairs(self.tbUsable) do
		for _, Instancing in ipairs(tbTreasureMap) do
			pPlayer.Msg("Id mô phỏng bản đồ:"..Instancing.MapTemplateId..", Id bản đồ:"..Instancing.MapId..", có trống không:"..Instancing.Free);
		end
	end
end

function tbInstancingMgr:IsInstancingFree(nTreasureId, nMapId)
	assert(self.tbUsable[nTreasureId]);
	for _, Instancing in ipairs(self.tbUsable[nTreasureId]) do
		if (Instancing.MapId == nMapId) then
			return Instancing.Free;
		end
	end
end

function tbInstancingMgr:GetInstancing(nMapId)
	return self.tbOpenedList[nMapId];	
end
function tbInstancingMgr:WeekEvent()
	me.ClearTaskGroup(2066, 1);	-- 每周進入指定地圖的次數清0
	me.SetTask(TreasureMap.TSKGID, TreasureMap.TSK_OPENBOX, 0, 1);	-- 玩家每周開箱子的次數
end

PlayerSchemeEvent:RegisterGlobalWeekEvent({"TreasureMap.InstancingMgr:WeekEvent"});
