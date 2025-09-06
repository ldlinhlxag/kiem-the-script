-----------------------------------------------------------
-- 文件名　：zhunbeiqunpc.lua
-- 文件描述：准備區腳本 [路路通] [留一半]
-- 創建者　：ZhangDeheng
-- 創建時間：2008-11-26 20:21:59
-----------------------------------------------------------

-- 路路通
local tbNpc = Npc:GetClass("lulutong");
-- 傳送的位置
tbNpc.tbPos = {
	{"碧蜈峰", 1714, 2980,},
	{"神蛛峰", 1876, 2991,},
	{"靈蠍峰", 1936, 2723,},
	{"天絕峰", 1777, 2739,},
	};

function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	local szMsg = "這是一條通往副本內各個地方的捷徑，如果你或你的隊友已經開啟了通關的條件，便可以通過這條捷徑直接前往那裡。但需支付500兩銀子。";
	local tbOpt = {};
	for i = 1, #self.tbPos do
		tbOpt[#tbOpt + 1] = {"前往" .. self.tbPos[i][1], tbNpc.Send, self, i, tbInstancing, me.nId};
	end;
	tbOpt[#tbOpt + 1] = {"結束對話"};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:Send(nPos, tbInstancing, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;
	
	if (pPlayer.nCashMoney < 500) then
		Task.tbArmyCampInstancingManager:Warring(pPlayer, "你身上的錢不夠！");
		return;
	end
	
	if (nPos == 1 and tbInstancing.nTaoHuaShiPass == 1) then
		self:SendToNewPos(nPos, tbInstancing.nMapId, nPlayerId);
		return;
	elseif (nPos == 2 and tbInstancing.nBiWuFengPass == 1) then
		self:SendToNewPos(nPos, tbInstancing.nMapId, nPlayerId);
		return;
	elseif (nPos == 3 and tbInstancing.nShenZhuFengPass == 1) then
		self:SendToNewPos(nPos, tbInstancing.nMapId, nPlayerId);
		return;
	elseif (nPos == 4 and tbInstancing.nLingXieFengPass == 1) then
		self:SendToNewPos(nPos, tbInstancing.nMapId, nPlayerId);
		return;
	end;

	Task.tbArmyCampInstancingManager:Warring(pPlayer, "隻有通過關卡之後才可使用捷徑");
end;

function tbNpc:SendToNewPos(nPos, nMapId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;
		
	assert(pPlayer.CostMoney(500, Player.emKPAY_CAMPSEND) == 1);
	pPlayer.NewWorld(pPlayer.nMapId, tbNpc.tbPos[nPos][2], tbNpc.tbPos[nPos][3]);	
	pPlayer.SetFightState(1);	
end;

local tbLiuYiBan = Npc:GetClass("liuyiban");

tbLiuYiBan.tbLifePresentText = {
	[99] = "不要，不要靠近我！我這裡什麼都沒有！",
	[80] = {"打不過我就跑", "你們真是陰魂不散的跟著我"},
	[60] = {"有本事就追上來！", "你們還真的追上來了！"},
	[40] = {"我跑！我再跑！", "能不能歇一會啊！"},
	[20] = {"不行了，我打累了！", "你們真是陰魂不散的跟著我！"},
	[0]  = "你們……給我留一半啊……",
}

tbLiuYiBan.tbDrop = {
	{"setting\\npc\\droprate\\renwudiaoluo\\jindi_lv1.txt", 8},
	{"setting\\npc\\droprate\\renwudiaoluo\\jindi_lv2.txt", 8},
	{"setting\\npc\\droprate\\renwudiaoluo\\jindi_lv3.txt", 8},
	{"setting\\npc\\droprate\\renwudiaoluo\\jindi_lv4.txt", 8},
	{"setting\\npc\\droprate\\renwudiaoluo\\jindi_lv5.txt", 8},	
}

function tbLiuYiBan:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nLiuYiBanOutCount > 5) then
		return;
	end;
	
	him.SendChat(self.tbLifePresentText[0]);
	
	local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbLifePresentText[0], him.szName);
	end;
	
	local nId = 0;
	if (pNpc and pNpc.GetPlayer()) then
		nId = pNpc.GetPlayer().nId;
	else
		nId = tbPlayList[1].nId;
	end;
	him.DropRateItem(self.tbDrop[tbInstancing.nLiuYiBanOutCount][1], self.tbDrop[tbInstancing.nLiuYiBanOutCount][2], -1, -1, nId);
end;

function tbLiuYiBan:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nLiuYiBanOutCount == 0 or tbInstancing.nLiuYiBanOutCount >= 5) then
		return;
	end;
	if (nLifePercent == 99) then
		him.SendChat(self.tbLifePresentText[nLifePercent]);
		return;
	end;
	
	him.SendChat(self.tbLifePresentText[nLifePercent][1]);
	
	local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbLifePresentText[nLifePercent][1], him.szName);
	end;
	-- 掉落物品
	him.DropRateItem(self.tbDrop[tbInstancing.nLiuYiBanOutCount][1], self.tbDrop[tbInstancing.nLiuYiBanOutCount][2], -1, -1, tbPlayList[1].nId);
	tbInstancing.nLiuYiBanOutCount = tbInstancing.nLiuYiBanOutCount + 1;
	him.Delete();
end;
