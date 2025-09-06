-----------------------------------------------------------
-- 文件名　：main.lua
-- 文件描述：軍營副本-百蠻山
-- 創建者　：ZhangDeheng
-- 創建時間：2008-12-01 15:48:25
-----------------------------------------------------------

Require("\\script\\task\\armycamp\\campinstancing\\instancingmanager.lua");

local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancingBase(2); -- 2為此FB的Id

tbInstancing.szName = "Bách Man Sơn";
tbInstancing.szDesc = "Chuẩn bị vào phó bản";

-- 山民 說的話
tbInstancing.tbShanMinText = {
	{"Đã chế thuốc xong có thể đến Đào Hoa Sứ.", ""},
	{"Chưa đi qua không thể di chuyển nhanh", "Đi đến Bích Ngô Sứ"},
	{"Chưa đi qua không thể di chuyển nhanh", "Đi đến Thần Chu Sứ"},
	{"Chưa đi qua không thể di chuyển nhanh", "Đi đến Linh Hạt Sứ"},
	{"Chưa đi qua không thể di chuyển nhanh", "Đi đến Cổ Vương"},
	{"Mọi ngươi có thể đến được đây, thật là tuyệt vời."},
	{"Chúc mừng bạn đã chinh phục được Bách Man Sơn"},
}

-- 桃花瘴瘴氣位置
tbInstancing.tbZhangQiPos = {
	{1653, 3051},
	{1707, 3029},
	{1707, 3029},
}

-- 蠱王護法位置
tbInstancing.tbGuWangHuFaPos 	= {{1842, 2767}, {1883, 2862}, {1842, 2940}, {1761, 2900}, {1763, 2812}};
-- 心燈位置  傳送
tbInstancing.tbXinDengInPos		= {{1822, 2818}, {1845, 2860}, {1824, 2882}, {1794, 2863}, {1798, 2837}, };
-- 心燈位置  出
tbInstancing.tbXinDengOutPos 	= {{1839, 2789}, {1866, 2869}, {1838, 2920}, {1777, 2891}, {1776, 2824}, };

-- 開啟FB的時候調用
function tbInstancing:OnOpen()
	-- 開啟FB計時器
	self.nNoPlayerDuration = 0; 
	self.nBreathTimerId = Timer:Register(Env.GAME_FPS, self.OnBreath, self);
	self.nCloseTimerId 	= Timer:Register(self.tbSetting.nInstancingExistTime*Env.GAME_FPS, self.OnClose, self);
	
	self.tbPlayerList = {}; -- 當前Player列表
	self.tbEnteredPlayerList = {}; -- 曾經進過的Player列表
	
	-- 用於NPC說話計數
	self.nCount	= nil;
	
	-- 留一半 出現的次數
	self.nLiuYiBanOutCount = 0;
	
	-- 桃花瘴
	local pNpc = KNpc.Add2(4163, 110, -1, self.nMapId, 1709, 3122);
	self.nTaoHuaLinZhiYin = pNpc.dwId; -- 桃花林指引
	-- 桃花瘴 禁制
	local pNpc = KNpc.Add2(4135, 110, -1, self.nMapId, 1655, 3023);
	self.nJinZhiTaoHuaLin = pNpc.dwId
	
	-- 山民
	local pNpc = KNpc.Add2(4154, 110, -1, self.nMapId, 1656, 3029);
	self.nTaoHuaZhengShanMin1 = pNpc.dwId;
	local pNpc = KNpc.Add2(4154, 110, -1, self.nMapId, 1661, 3023);
	self.nTaoHuaZhengShanMin2 = pNpc.dwId;
	
	-- 桃花瘴瘴氣
	self.tbZhangQiId = {};
	local pNpc = KNpc.Add2(4141, 150, -1, self.nMapId, self.tbZhangQiPos[1][1], self.tbZhangQiPos[1][2]);
	self.tbZhangQiId[1] = pNpc.dwId;
	local pNpc = KNpc.Add2(4141, 150, -1, self.nMapId, self.tbZhangQiPos[2][1], self.tbZhangQiPos[2][2]);
	self.tbZhangQiId[2] = pNpc.dwId;
	local pNpc = KNpc.Add2(4141, 150, -1, self.nMapId, self.tbZhangQiPos[3][1], self.tbZhangQiPos[3][2]);
	self.tbZhangQiId[3] = pNpc.dwId;
	
	self.nTaoHuaZhangPass 	= 0; -- 桃花瘴是否可以通過
	
	-- 桃花使
	KNpc.Add2(4124, self.nNpcLevel, -1 , self.nMapId, 1671, 2910);	-- 對話桃花使
	
	local pNpc = KNpc.Add2(4135, 110, -1, self.nMapId, 1686, 2944); -- 禁制
	self.nJinZhiTaoHuaShi = pNpc.dwId;
	
	local pNpc = KNpc.Add2(4154, 110, -1, self.nMapId, 1676, 2931);
	self.nTaoHuaShiShanMin1 = pNpc.dwId;
	local pNpc = KNpc.Add2(4154, 110, -1, self.nMapId, 1681, 2926);
	self.nTaoHuaShiShanMin2 = pNpc.dwId;
	
	local nProb = MathRandom(100);  -- 10%的概率出現留一半

	if (nProb < 50) then  
		local pNpc = KNpc.Add2(4155, self.nNpcLevel, -1 , self.nMapId, 1667, 2907); -- 留一半
		pNpc.AddLifePObserver(99);
		pNpc.AddLifePObserver(80);
		self.nLiuYiBanOutCount = 1;
	end;

	self.nTaoHuaShiOut		= 0; 						-- 桃花使是否已經出現
	self.nTaoHuaShiPass 	= 0; 						-- 桃花使處是否可以通過
	
	-- 碧蜈峰
	local pNpc = KNpc.Add2(4125, 150, -1 , self.nMapId, 1781, 3073, 1); -- 蠱翁
	
	pNpc.AddLifePObserver(99);
	pNpc.AddLifePObserver(80);
	pNpc.AddLifePObserver(30);
	pNpc.AddLifePObserver(10);
	
	for i = 1, 14 do 
		pNpc.AddLifePObserver(i * 7);
	end;
	
	
	local pNpc = KNpc.Add2(4135, 110, -1, self.nMapId, 1828, 3044); -- 碧蜈峰 禁制
	self.nJinZhiBiWuFeng = pNpc.dwId;
	
	-- 山民
	local pNpc = KNpc.Add2(4154, 110, -1, self.nMapId, 1825, 3043);
	self.nBiWuFengShanMin1 = pNpc.dwId;
	local pNpc = KNpc.Add2(4154, 110, -1, self.nMapId, 1829, 3047);
	self.nBiWuFengShanMin2 = pNpc.dwId;
	
	local pNpc = KNpc.Add2(4164, 110, -1, self.nMapId, 1720, 2977); --碧蜈峰指引
	self.nBiWuFengZhiYin = pNpc.dwId;

	self.nDuXieYouChong		= 0; -- 殺死毒蠍幼蟲的個數	
	self.nXieWangOut		= 0;  -- 碧蜈使是否出現
	self.nBiWuFengPass		= 0;  -- 碧蜈峰是否可以通過	
	
	-- 神蛛峰
	local pNpc = KNpc.Add2(4165, 110, -1, self.nMapId, 1877, 2981); -- 神蛛峰指引
	self.nShenZhuFengZhiYin = pNpc.dwId;
	-- 神蛛峰 禁制
	local pNpc = KNpc.Add2(4135, 110, -1, self.nMapId, 1951, 2847);
	self.nJinZhiShenZhuFeng = pNpc.dwId;

	-- 山民
	local pNpc = KNpc.Add2(4154, 110, -1, self.nMapId, 1949, 2852);
	self.nShenZhuFengShanMin1 = pNpc.dwId;
	local pNpc = KNpc.Add2(4154, 110, -1, self.nMapId, 1954, 2849);
	self.nShenZhuFengShanMin2 = pNpc.dwId;
	
	self.tbWenZhu			= {}; -- 用於記錄每次刷出的毒蠍幼蟲
	self.nPlayDrumTime 		= 0;  -- 記錄可以敲鼓的時間是否到
	self.nPlayDrumCount		= 0; -- 敲鼓的次數
	self.nPlayGongCount		= 0; -- 敲鑼的次數
	self.nWenZhu			= 0; -- 殺死毒蠍幼蟲的個數	 

	self.nShenZhuFengPass 	= 0; -- 神蛛峰是否可以通過
	 
	-- 靈蠍峰
	KNpc.Add2(4134, self.nNpcLevel, -1 , self.nMapId, 1865, 2692); 	-- 鐵公雞
	local pNpc = KNpc.Add2(4136, self.nNpcLevel, -1 , self.nMapId, 1883, 2605);		-- 靈蠍使
	self.nLingXieShiId = pNpc.dwId;
	self.bLXSCastSkill = true; -- 記錄靈蠍使是否繼續釋放技能
	
	pNpc.AddLifePObserver(99);
	pNpc.AddLifePObserver(50);
	pNpc.AddLifePObserver(30);
	pNpc.AddLifePObserver(10);
	-- 靈蠍峰 禁制
	local pNpc = KNpc.Add2(4135, 110, -1, self.nMapId, 1826, 2685);
	self.nJinZhiLingXieFeng = pNpc.dwId;
	
	-- 山民
	local pNpc = KNpc.Add2(4154, 110, -1, self.nMapId, 1831, 2684);
	self.nLingXieFengShanMin1 = pNpc.dwId;
	local pNpc = KNpc.Add2(4154, 110, -1, self.nMapId, 1825, 2678);
	self.nLingXieFengShanMin2 = pNpc.dwId;	

	if (self.nLiuYiBanOutCount ~= 0) then 
		local pNpc = KNpc.Add2(4155, self.nNpcLevel, -1, self.nMapId, 1886, 2608);
		pNpc.AddLifePObserver(20);
	end;
	
	local pNpc = KNpc.Add2(4166, 110, -1, self.nMapId, 1939, 2715); -- 靈蠍峰指引
	self.nLingXieFengZhiYin = pNpc.dwId;
	
	self.nLaoMenDurationTime 		= 0; 	-- 據下次可以開牢門的時間
	self.nLingXieFengPass			= 0; 	-- 碧蜈峰是否可以通過
	self.nTieGongJiLaoMen			= 0; 	-- 鐵公雞牢門是否打開
	self.nTieGongJiOut				= 0;	-- 戰斗鐵公雞是否出現
	self.nDuWeiXieCount				= 0;	-- 殺死毒尾蠍的個數
	-- 天絕峰
	
	local pNpc = KNpc.Add2(4167, 110, -1, self.nMapId, 1772, 2742); -- 天絕峰指引
	self.nTianJueGongZhiYin = pNpc.dwId;

	-- 山民
	local pNpc = KNpc.Add2(4154, 110, -1, self.nMapId, 1646, 2955);
	self.nTianJueGongShanMin1 = pNpc.dwId;

	local pNpc = KNpc.Add2(4154, 110, -1, self.nMapId, 1810, 2828);
	self.nTianJueGongShanMin2 = pNpc.dwId;
	local pNpc = KNpc.Add2(4154, 110, -1, self.nMapId, 1807, 2833);
	self.nTianJueGongShanMin3 = pNpc.dwId;
	
	-- 蠱王護法
	for i = 1, #self.tbGuWangHuFaPos do
		local pNpc = KNpc.Add2(4142, 110, -1 , self.nMapId, self.tbGuWangHuFaPos[i][1], self.tbGuWangHuFaPos[i][2]);
		pNpc.GetTempTable("Task").nId = i;
		pNpc.AddLifePObserver(99);
	end;

	-- 心燈 傳送
	for i = 1, #self.tbXinDengInPos do
		local pNpc6 = KNpc.Add2(4137, 110, -1 , self.nMapId, self.tbXinDengInPos[i][1], self.tbXinDengInPos[i][2]);
		pNpc6.GetTempTable("Task").nId = i;
	end;
	-- 心燈 出
	for i = 1, #self.tbXinDengOutPos do
		local pNpc6 = KNpc.Add2(4138, 110, -1 , self.nMapId, self.tbXinDengOutPos[i][1], self.tbXinDengOutPos[i][2]);
		pNpc6.GetTempTable("Task").nId = i;
	end;
	
	-- 長生燈出現的順序
	self.tbChangShengDeng = {1, 2, 3, 4, 5,};
	Lib:SmashTable(self.tbChangShengDeng);	-- 長生燈的順序	
	
	self.nGuWangLife99				= 0; -- 記錄開始的時候話是否說過
	self.nGuWangChange75			= 0; -- 蠱王轉變成別的NPC 75%
	self.nGuWangChange50			= 0; -- 蠱王轉變成別的NPC 50%	
	self.nGuShenOut					= 0; -- 蠱神是否出現
	self.nChangShengDengCount		= 0; -- 長生燈已經出現的個數
	self.nOpenChangShengDeng		= 0; -- 已經開啟的個數
	
	-- 忘憂谷
	KNpc.Add2(4144, self.nNpcLevel, -1, self.nMapId, 1841, 2990);
	self.nHuoPengChenOut			= 0; -- 火蓬春是否出現
	
	-- 風雪鴻飛
	local pNpc = KNpc.Add2(4148, self.nNpcLevel, -1, self.nMapId, 1894, 2924, 1);
	pNpc.AddLifePObserver(99);
	pNpc.AddLifePObserver(90);
	pNpc.AddLifePObserver(70);
	pNpc.AddLifePObserver(50);
	pNpc.AddLifePObserver(30);
	
	local pNpc = KNpc.Add2(4146, self.nNpcLevel, -1, self.nMapId, 1910, 2838, 1); -- 火眼猊
	
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
		Task.tbArmyCampInstancingManager:Tip2MapPlayer(self.nMapId, "Cách giờ đóng cửa "..self.tbSetting.szName.." còn "..math.floor((self.tbSetting.nInstancingExistTime-self.nCurSec)/60).." phút");
	end
	-- 指引的人每10秒說一次話
	if ((self.nCurSec - 1) % 5 == 0) then
		self:NpcTimerSay(self.nTaoHuaLinZhiYin, "Con đường phía trước rất nguy hiểm đấy.");
		self:NpcTimerSay(self.nBiWuFengZhiYin, "Hiệp sỹ hãy ở lại đây với ta.");
		self:NpcTimerSay(self.nShenZhuFengZhiYin, "Phía trước có rất nhiều quân mai phục, hãy cẩn thận");
		self:NpcTimerSay(self.nLingXieFengZhiYin, "Nhà ngươi vội đi đâu vậy ?");
		self:NpcTimerSay(self.nTianJueGongZhiYin, "Hãy ở đây nói chuyện với ta một lúc.");
	end;
	
	-- 山名說話 每5秒一次
	if (self.nCurSec % 5 == 0) then
		-- 桃花瘴 山民
		self:NpcTimerSayWithCondition(self.nTaoHuaZhengShanMin1, self.nTaoHuaZhangPass, self.tbShanMinText[1][1], self.tbShanMinText[1][2]);
		self:NpcTimerSayWithCondition(self.nTaoHuaZhengShanMin2, self.nTaoHuaZhangPass, self.tbShanMinText[1][1], self.tbShanMinText[1][2]);
		-- 桃花使 山民
		self:NpcTimerSayWithCondition(self.nTaoHuaShiShanMin1, self.nTaoHuaShiPass, self.tbShanMinText[2][1], self.tbShanMinText[2][2]);
		self:NpcTimerSayWithCondition(self.nTaoHuaShiShanMin2, self.nTaoHuaShiPass, self.tbShanMinText[2][1], self.tbShanMinText[2][2]);
		-- 碧蜈峰 山民
		self:NpcTimerSayWithCondition(self.nBiWuFengShanMin1, self.nBiWuFengPass, self.tbShanMinText[3][1], self.tbShanMinText[3][2]);
		self:NpcTimerSayWithCondition(self.nBiWuFengShanMin2, self.nBiWuFengPass, self.tbShanMinText[3][1], self.tbShanMinText[3][2]);
		-- 神蛛峰 山民
		self:NpcTimerSayWithCondition(self.nShenZhuFengShanMin1, self.nShenZhuFengPass, self.tbShanMinText[4][1], self.tbShanMinText[4][2]);
		self:NpcTimerSayWithCondition(self.nShenZhuFengShanMin2, self.nShenZhuFengPass, self.tbShanMinText[4][1], self.tbShanMinText[4][2]);
		-- 靈蠍峰 山民
		self:NpcTimerSayWithCondition(self.nLingXieFengShanMin1, self.nLingXieFengPass, self.tbShanMinText[5][1], self.tbShanMinText[5][2]);
		self:NpcTimerSayWithCondition(self.nLingXieFengShanMin2, self.nLingXieFengPass, self.tbShanMinText[5][1], self.tbShanMinText[5][2]);
		-- 天絕峰 山民
		self:NpcTimerSay(self.nTianJueGongShanMin1, self.tbShanMinText[6][1]);
		
		self:NpcTimerSay(self.nTianJueGongShanMin2, self.tbShanMinText[7][1]);
		self:NpcTimerSay(self.nTianJueGongShanMin3, self.tbShanMinText[7][1]);

	end;	
	-- 牢門計時
	if (self.nLaoMenDurationTime ~= 0) then
		self.nLaoMenDurationTime = self.nLaoMenDurationTime - 1;
	end;
	-- 敲鑼計時
	if (self.nPlayDrumTime > 0) then
		self.nPlayDrumTime = self.nPlayDrumTime - 1;
	end;
	 
	-- 靈蠍使每三分鐘釋放一次金鐘罩
	if (self.nLingXieShiId and self.bLXSCastSkill and (self.nCurSec - 1) % 300 == 0) then
		local pNpc = KNpc.GetById(self.nLingXieShiId);
		if (not pNpc) then
			return;
		end;
		pNpc.CastSkill(999, 10, -1, pNpc.nIndex);
	end;
end

-- NPC說一句話
function tbInstancing:NpcTimerSay(nNpcId, szMsg)

	if (nNpcId) then
		local pNpc = KNpc.GetById(nNpcId);
		assert(pNpc);
		
		pNpc.SendChat(szMsg);
	end;
end;

-- NPC按條件說話
function tbInstancing:NpcTimerSayWithCondition(nNpcId, nCondition, szMsg1, szMsg2)
	if (nNpcId) then
		local pNpc = KNpc.GetById(nNpcId);
		assert(pNpc);
		if (nCondition == 0) then
			pNpc.SendChat(szMsg1);
		else
			pNpc.SendChat(szMsg2);
		end;
	end;
end;
-- NPC說話
function tbInstancing:NpcSay(nNpcId, tbText)
	-- 某個NPC正在說話         -- 不能同時說話
	if (self.nCount) then
		return;
	end;

	if (not nNpcId or not tbText) then
		return;
	end;

	self.nNpcSayTimerId 	= Timer:Register(Env.GAME_FPS * 2, self.OnBreathDialog, self, nNpcId, tbText);
	self.nCount				= 0;
end;

-- 
function tbInstancing:OnBreathDialog(nNpcId, tbText)
	assert(nNpcId and tbText);
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		self.nNpcSayTimerId = nil;
		--Timer:Close(self.nNpcSayTimerId);
		self.nCount = nil;
		return 0;
	end;
	
	self.nCount = self.nCount + 1;
	-- 說完話，關閉計時器	
	if (self.nCount  > #tbText) then
		--Timer:Close(self.nNpcSayTimerId);
		self.nCount = nil;
		self.nNpcSayTimerId = nil;
		local tbSayOver = pNpc.GetTempTable("Task").tbSayOver;
		if (tbSayOver) then
			Lib:CallBack(tbSayOver);
			tbSayOver = nil;
		end;
		return 0;
	end;

	pNpc.SendChat(tbText[self.nCount]);

	local tbPlayList, nCount = KPlayer.GetMapPlayer(self.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(tbText[self.nCount], pNpc.szName);
	end;		
end;

-- 護送NPC
function tbInstancing:Escort(nNpcId, nPlayerId, tbTrack, nActiveFight, bPassiveFight)
	assert(nNpcId and nPlayerId);
	local pNpc = KNpc.GetById(nNpcId);
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	assert(pNpc and pPlayer);
	
	if (not nActiveFight) then
		nActiveFight = 0;
	end;
	if (not bPassiveFight) then
		bPassiveFight = 0;
	end;
	
	pNpc.SetCurCamp(0);
	pNpc.RestoreLife();
	pNpc.AI_ClearPath();
	for _,Pos in ipairs(tbTrack) do
		if (Pos[1] and Pos[2]) then
			pNpc.AI_AddMovePos(tonumber(Pos[1])*32, tonumber(Pos[2])*32)
		end
	end;
	pNpc.SetNpcAI(9, nActiveFight, bPassiveFight, -1, 25, 25, 25, 0, 0, 0, pPlayer.GetNpc().nIndex);	
end; 

-- FB關閉時調用
function tbInstancing:OnClose()
	for nPlayerId, tbPlayerData in pairs(self.tbPlayerList) do
		self:KickPlayer(nPlayerId, 1, "Thời gian ở trong phó bản đã hết, bạn đã được đưa ra ngoài.");
	end
	
	Task.tbArmyCampInstancingManager:CloseMap(self.nMapId);
	Timer:Close(self.nBreathTimerId);
	Timer:Close(self.nCloseTimerId);
	
	return 0;
end


-- 當一個玩家申請進入
function tbInstancing:OnPlayerAskEnter(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (self.nPlayerCount >= self.tbSetting.nMaxPlayer) then
		Dialog:SendInfoBoardMsg(pPlayer, "Phó bản đã đầy, không thể mở thêm.");
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
		pPlayer.SetTask(1024, 61, 0); -- 重置任務變量
		
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
	Task.tbArmyCampInstancingManager:ShowTip(pPlayer, "Bạn đã theo "..self.szOpenerName.." vào "..self.szRegisterMapName.." "..self.tbSetting.szName .. " ", 20);
	
	-- 計時面板
	if (not self.nCurSec) then -- 在報名的一秒鐘以內進入副本，self.nCurSec還沒經過OnBreath生成，為nil 則在此處生成
		self.nCurSec = 0;
	end;
	Dialog:SetTimerPanel(pPlayer, "<color=Gold>Phó bản quân doanh: <color>\n<color=White>Cách giờ đóng cửa còn: <color>", (self.tbSetting.nInstancingExistTime-self.nCurSec));
	Task.tbArmyCampInstancingManager.StatLog:WriteLog(1, 1, pPlayer);
	
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
	self:RemoveTaskItem(pPlayer, {20, 1, 623, 1, 0, 0});
	self:RemoveTaskItem(pPlayer, {20, 1, 624, 1, 0, 0});
	self:RemoveTaskItem(pPlayer, {20, 1, 625, 1, 0, 0});
	self:RemoveTaskItem(pPlayer, {20, 1, 626, 1, 0, 0});

	if (bPassive) then
		local nMapId, nReviveId, nMapX, nMapY = pPlayer.GetLoginRevivePos();
		pPlayer.NewWorld(nMapId, nMapX/32, nMapY/32);
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

-- 玩家死亡
function tbInstancing:OnPlayerDeath()
	me.ReviveImmediately(0);
	me.SetFightState(0);
end

-- 玩家離開地圖
function tbInstancing:OnPlayerLeaveMap()
	self:KickPlayer(me.nId);
end

