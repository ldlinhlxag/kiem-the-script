
Require("\\script\\task\\armycamp\\campinstancing\\instancingmanager.lua");

local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancingBase(1); -- 1為此FB的Id

tbInstancing.szName = "Hậu phục ngưu sơn";
tbInstancing.szDesc = "Chế phẩm, chiến thắng.";

-- 隨機Npc，12選3
tbInstancing.tbRandNpc = 
{
	{nTemplateId = 4062, nPosX = 1600, nPosY = 3648},
	{nTemplateId = 4063, nPosX = 1607, nPosY = 3638},
	{nTemplateId = 4064, nPosX = 1611, nPosY = 3633},
	{nTemplateId = 4065, nPosX = 1615, nPosY = 3627},
	{nTemplateId = 4066, nPosX = 1624, nPosY = 3674},
	{nTemplateId = 4067, nPosX = 1639, nPosY = 3660},
	{nTemplateId = 4068, nPosX = 1658, nPosY = 3647},
	{nTemplateId = 4069, nPosX = 1654, nPosY = 3643},
	{nTemplateId = 4070, nPosX = 1650, nPosY = 3638},
	{nTemplateId = 4071, nPosX = 1648, nPosY = 3628},
	{nTemplateId = 4072, nPosX = 1675, nPosY = 3557},
	{nTemplateId = 4073, nPosX = 1681, nPosY = 3564},
}

tbInstancing.tbRandPos = 
{
	{1655, 3640},
	{1658, 3645},
	{1649, 3631},
}

tbInstancing.tbExtRandNpc = 
{
	{
		{4078, 1918, 2988}, {4079, 1920, 2990}, {4080,1922,2992},
	},
	{
		{4086, 1891, 3175}, {4087, 1879, 3171}, {4088,1918,3106},
	},
	{
		{4081, 1825, 3944}, {4082, 1827, 3946}, {4083,1829,3948},
	},
}
-- 開啟FB的時候調用，用於一些初始化
function tbInstancing:OnOpen()
	-- 開啟FB計時器
	self.nNoPlayerDuration = 0;
	self.nBreathTimerId = Timer:Register(Env.GAME_FPS, self.OnBreath, self);
	self.nCloseTimerId 	= Timer:Register(self.tbSetting.nInstancingExistTime*Env.GAME_FPS, self.OnClose, self);
	
	self.tbPlayerList = {}; -- 當前Player列表
	self.tbEnteredPlayerList = {}; -- 曾經進過的Player列表
	
	--  隨機添加3個任務Npc
	Lib:SmashTable(self.tbRandNpc);
	for i = 1, 3 do
		KNpc.Add2(self.tbRandNpc[i].nTemplateId, 1, -1, self.nMapId, self.tbRandPos[i][1], self.tbRandPos[i][2]);
	end
	
	-- 隨機添加3個擴展區域任務Npc
	local tbRandom = {};
	table.insert(tbRandom, MathRandom(3));
	table.insert(tbRandom, MathRandom(3));
	table.insert(tbRandom, MathRandom(3));
	for i = 1, #self.tbExtRandNpc do
		local tbNpc = self.tbExtRandNpc[i][tbRandom[i]];
		KNpc.Add2(tbNpc[1], 1, -1, self.nMapId, tbNpc[2], tbNpc[3]);
	end

	-- 伐木區
	self.nFaMuQuTrapOpen = 0;	
	
	
	-- 採礦區
	-- 添加6機關
	local pControl1 = KNpc.Add2(4019, 1, -1, self.nMapId, 1940, 3305);
	local pControl2 = KNpc.Add2(4019, 1, -1, self.nMapId, 1925, 3289);
	local pControl3 = KNpc.Add2(4019, 1, -1, self.nMapId, 2006, 3348);
	local pControl4 = KNpc.Add2(4019, 1, -1, self.nMapId, 2000, 3328);
	local pControl5 = KNpc.Add2(4019, 1, -1, self.nMapId, 1971, 3421);
	local pControl6 = KNpc.Add2(4019, 1, -1, self.nMapId, 1968, 3452);

	-- 添加6柵欄
	local pBarrier1 = KNpc.Add2(4015, 1, -1, self.nMapId, 1939, 3299);
	local pBarrier2 = KNpc.Add2(4015, 1, -1, self.nMapId, 1929, 3289);
	local pBarrier3 = KNpc.Add2(4015, 1, -1, self.nMapId, 2010, 3346);
	local pBarrier4 = KNpc.Add2(4015, 1, -1, self.nMapId, 2004, 3329);
	local pBarrier5 = KNpc.Add2(4015, 1, -1, self.nMapId, 1968, 3439);
	local pBarrier6 = KNpc.Add2(4016, 1, -1, self.nMapId, 1959, 3453);
	
	-- 伏牛山庄舊址 百斬吉
	local pNpc = KNpc.Add2(4117, self.nNpcLevel, -1 , self.nMapId, 1615, 3334);
	assert(pNpc);
	self.BAIZHANJI_IS_OUT = 0;
	
	-- 判斷Trap是否可以通過的標志
	self.tbBarrierPairs = 
	{
		{pControl1.dwId, pBarrier2.dwId, 0},
		{pControl2.dwId, pBarrier1.dwId, 0},
		{pControl3.dwId, pBarrier4.dwId, 0},
		{pControl4.dwId, pBarrier3.dwId, 0},
		{pControl5.dwId, pBarrier6.dwId, 0},
		{pControl6.dwId, pBarrier5.dwId, 0},
	}
	
	-- 刷新材料
	local tbMineA = Npc:GetClass("funiushan_caikuangqu_masheng");
	tbMineA:Grow(self.nMapId);
	
	local tbMineB = Npc:GetClass("funiushan_caikuangqu_mubang");
	tbMineB:Grow(self.nMapId);
	
	self.nCaiKuangQuPass = 0;
	
	
	-- 採石區
	self.nCaiShiQuColItem = 0;
	self.nCaiShiQuPass = 0;
	
	
	-- 蠻瘴山
	self.nManZhangShanPass = 0;
	
	-- 牛欄寨
	self.nNiuLanZhaiPass = 0;
	local pNiuLanZhaiLaoMen = KNpc.Add2(4015, 1, -1, self.nMapId, 1871, 3183); -- 牢門
	self.nNiuLanZhaiLaoMenId = pNiuLanZhaiLaoMen.dwId;
	
	local pNpc = KNpc.Add2(4004, self.nNpcLevel, -1, self.nMapId, 1908, 3437); -- 動態加載監工頭領
	assert(pNpc);

	local pNpc = KNpc.Add2(4006, self.nNpcLevel, -1, self.nMapId, 1845, 3269); -- 動態加載嘍羅頭目
	assert(pNpc);
	
	-- 鱷神殿
	self.nEShenDianPass = 0;
end


function tbInstancing:OnBreath()
	if (self.nPlayerCount == 0) then
		self.nNoPlayerDuration = self.nNoPlayerDuration + 1;
	elseif (nNoPlayerDuration ~= 0) then
		self.nNoPlayerDuration = 0;
	end
	
	if (self.nNoPlayerDuration >= self.tbSetting.nNoPlayerDuration) then
		self:OnClose();
		return 0;
	end
	
	if (not self.nCurSec) then
		self.nCurSec = 1;
	else
		self.nCurSec = self.nCurSec + 1;
	end
	
	if (self.nCurSec % 600 == 0) then
		Task.tbArmyCampInstancingManager:Tip2MapPlayer(self.nMapId, "Cách thời gian đóng "..self.tbSetting.szName.." còn "..math.floor((self.tbSetting.nInstancingExistTime-self.nCurSec)/60).." phút");
	end
end

-- FB關閉時調用
function tbInstancing:OnClose()
	for nPlayerId, tbPlayerData in pairs(self.tbPlayerList) do
		self:KickPlayer(nPlayerId, 1, "Phó bản của bạn đã hết thời gian vượt qua.");
	end
	
	Task.tbArmyCampInstancingManager:CloseMap(self.nMapId);
	Timer:Close(self.nBreathTimerId);
	Timer:Close(self.nCloseTimerId);

	if (self.nBzhjTimerId and self.nBzhjTimerId > 0) then
		Timer:Close(self.nBzhjTimerId);
		self.nBzhjTimerId = nil;
	end

	return 0;
end


-- 當一個玩家申請進入
function tbInstancing:OnPlayerAskEnter(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (self.nPlayerCount >= self.tbSetting.nMaxPlayer) then
		Dialog:SendInfoBoardMsg(pPlayer, "Số lượng người vào phó bản đã quá giới hạn.");
		return;
	end
	
	pPlayer.NewWorld(self.nMapId, unpack(self.tbSetting.tbRevivePos));
	pPlayer.SetFightState(0);
	self:OnPlayerEnter(pPlayer.nId);
end

-- 當一個玩家進入後
function tbInstancing:OnPlayerEnter(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	assert(pPlayer);
	self.nPlayerCount = self.nPlayerCount + 1;
	assert(self.nPlayerCount <= self.tbSetting.nMaxPlayer);
	-- 第一次進入當前副本
	if (not self.tbEnteredPlayerList[nPlayerId]) then
		local nTimes = pPlayer.GetTask(self.tbSetting.nInstancingEnterLimit_D.nTaskGroup, self.tbSetting.nInstancingEnterLimit_D.nTaskId);
		pPlayer.SetTask(self.tbSetting.nInstancingEnterLimit_D.nTaskGroup, self.tbSetting.nInstancingEnterLimit_D.nTaskId, nTimes + 1, 1);
		self.tbEnteredPlayerList[nPlayerId] = 1;
		self:ResetPlayerAttr(nPlayerId);
		
		-- 記錄玩家參加軍營副本的次數
		Stats.Activity:AddCount(pPlayer, Stats.TASK_COUNT_ARMYCAMP, 1);
	end
	
	self.tbPlayerList[nPlayerId] = {};
	
	-- 對此玩家注冊一些事件
	Setting:SetGlobalObj(pPlayer, him, it);
	local nDeathEventId = PlayerEvent:Register("OnDeath", self.OnPlayerDeath, self);
	self.tbPlayerList[nPlayerId].nDeathEventId = nDeathEventId;
	local nLogoutEventId = PlayerEvent:Register("OnLogout", self.OnPlayerLogout, self);
	self.tbPlayerList[nPlayerId].nLogoutEventId = nLogoutEventId;
	local nLeaveMapEventId = PlayerEvent:Register("OnLeaveMap", self.OnPlayerLeaveMap, self);
	self.tbPlayerList[nPlayerId].nLeaveMapEventId = nLeaveMapEventId;
	Setting:RestoreGlobalObj();
	local nRevMapId, nRevPointId = pPlayer.GetRevivePos();
	self.tbPlayerList[nPlayerId].tbOldRev = {nRevMapId, nRevPointId};
	pPlayer.SetTmpDeathPos(self.nMapId, unpack(self.tbSetting.tbRevivePos));
	pPlayer.SetLogoutRV(1);
	Task.tbArmyCampInstancingManager:ShowTip(pPlayer, "Bạn đã vào "..self.szOpenerName.." "..self.szRegisterMapName.." mở "..self.tbSetting.szName, 20);
	-- 計時面板
	if (not self.nCurSec) then -- 在報名的一秒鐘以內進入副本，self.nCurSec還沒經過OnBreath生成，為nil 則在此處生成
		self.nCurSec = 0;
	end;
	Dialog:SetTimerPanel(pPlayer, "<color=Gold>Phó bản mở<color>\n<color=White>Thời gian đóng phó bản: <color>", (self.tbSetting.nInstancingExistTime-self.nCurSec));

	Task.tbArmyCampInstancingManager.StatLog:WriteLog(1, 1, pPlayer);
	
	--Task.tbArmyCampInstancingManager:OpenArmyCampUi(pPlayer.nId, self.nCloseTimerId);
end

-- 踢出一個玩家
function tbInstancing:KickPlayer(nPlayerId, bPassive, szDesc)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	if (not self.tbPlayerList[nPlayerId]) then
		return;
	end
	
	Dialog:CloseTimerPanel(pPlayer);
	
	self.nPlayerCount = self.nPlayerCount -1;
	assert(self.nPlayerCount >= 0);
	assert(self.tbPlayerList[nPlayerId] and self.tbPlayerList[nPlayerId].nDeathEventId and self.tbPlayerList[nPlayerId].nLogoutEventId and self.tbPlayerList[nPlayerId].nLeaveMapEventId);
	Setting:SetGlobalObj(pPlayer, him, it);
	PlayerEvent:UnRegister("OnDeath", self.tbPlayerList[nPlayerId].nDeathEventId);
	PlayerEvent:UnRegister("OnLogout", self.tbPlayerList[nPlayerId].nLogoutEventId);
	PlayerEvent:UnRegister("OnLeaveMap", self.tbPlayerList[nPlayerId].nLeaveMapEventId);
	Setting:RestoreGlobalObj();
	pPlayer.SetRevivePos(unpack(self.tbPlayerList[nPlayerId].tbOldRev));
	self.tbPlayerList[nPlayerId] = nil;
	if (pPlayer.IsDead() == 1) then
		pPlayer.ReviveImmediately(0);
	end
	
	-- 刪除指定道具
	self:RemoveTaskItem(pPlayer, {20, 1, 603, 1, 0, 0});
	self:RemoveTaskItem(pPlayer, {20, 1, 604, 1, 0, 0});
	self:RemoveTaskItem(pPlayer, {20, 1, 605, 1, 0, 0});
	-- 刪除玩家身上的雞血
	self:RemoveTaskItem(pPlayer, {20, 1, 620, 1, 0, 0});
	
	--Task.tbArmyCampInstancingManager:CloseArmyCampUi(pPlayer.nId);
	if (bPassive) then
		local nMapId, nReviveId, nMapX, nMapY = pPlayer.GetLoginRevivePos();
		pPlayer.NewWorld(nMapId, nMapX/32, nMapY / 32);
	end
	
	pPlayer.SetLogoutRV(0);
	
	if (szDesc) then
		Task.tbArmyCampInstancingManager:Warring(pPlayer, szDesc);
	end
end

function tbInstancing:RemoveTaskItem(pPlayer, tbItemId)	
	local nDelCount = Task:GetItemCount(me, tbItemId);
	
	Task:DelItem(me, tbItemId, nDelCount);
end

-- 當玩家下線時候調用
function tbInstancing:OnPlayerLogout()
	self:KickPlayer(me.nId, 1);
end

-- 玩家死亡後調用
function tbInstancing:OnPlayerDeath()
	me.ReviveImmediately(0);
	me.SetFightState(0);
end

-- 玩家離開地圖時調用
function tbInstancing:OnPlayerLeaveMap()
	self:KickPlayer(me.nId);
end

-- 重置玩家FB相關的屬性
function tbInstancing:ResetPlayerAttr(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	assert(pPlayer);
	pPlayer.SetTask(1022, 136, 0, 1);
	pPlayer.SetTask(1024, 53, 0, 1);
	pPlayer.SetTask(1024, 56, 0, 1);
end
