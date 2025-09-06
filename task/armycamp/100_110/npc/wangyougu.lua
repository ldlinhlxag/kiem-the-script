-----------------------------------------------------------
-- 文件名　：wangyougu.lua
-- 文件描述：忘憂谷腳本
-- 創建者　：ZhangDeheng
-- 創建時間：2008-12-12 09:38:03
-----------------------------------------------------------

-- 火蓬春 對話
local tbHuoPengChen_Dialog = Npc:GetClass("huopengchen_dialog");

tbHuoPengChen_Dialog.tbNeedItemList = { {20, 1, 624, 1, 1}, {20, 1, 625, 1, 1}};

function tbHuoPengChen_Dialog:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	if (tbInstancing.nHuoPengChenOut ~= 0) then
		return;
	end;
	
	local szMsg = "滾遠點，老頭子又讓你們來送死嗎？";
	Dialog:Say(szMsg,
		{
			{"給靜心珠和書信", self.Give, self, tbInstancing, me.nId, him.dwId},
			{"結束對話"}
		});
	
end;

function tbHuoPengChen_Dialog:Give(tbInstancing, nPlayerId, nNpcId)
	Task:OnGift("這些東西你仔細看看！", self.tbNeedItemList, {self.Pass, self, tbInstancing, nPlayerId, nNpcId}, nil, {self.CheckRepeat, self, tbInstancing}, true);
end;

function tbHuoPengChen_Dialog:CheckRepeat(tbInstancing)
	if (tbInstancing.nHuoPengChenOut == 1) then
		return 0;
	end	
	return 1; 
end

function tbHuoPengChen_Dialog:Pass(tbInstancing, nPlayerId, nNpcId)
	if (tbInstancing.nHuoPengChenOut ~= 0) then
		return;
	end;
	
	local szMsg = "這珠子好像是老頭子交給殷童那個小丫頭的，怎麼會在你們手裡？還有這封書信的筆記也很熟悉，好像也是殷童那個小丫頭的，俺看看都寫了些啥。<color=yellow>\
     《我蠢》    《臥春》\
    俺沒有文化（暗梅幽聞花），\
    我智商很低（臥枝傷恨底），\
    要問我是誰（遙聞臥似水），\
    一頭大蠢驢（易透達春綠）。\
    俺是驢    （岸似綠），\
    俺是頭驢  （岸似透綠），\
    俺是頭呆驢（岸似透黛綠）。<color>";
	
	Dialog:Say(szMsg,
	{
		{"結束對話", self.ChangeFight, self, tbInstancing, nNpcId},
	});
	if (tbInstancing.nHuoPengChenOut == 0 and not tbInstancing.nHuoPengChenTimerId) then
		tbInstancing.nHuoPengChenTimerId = Timer:Register(Env.GAME_FPS * 5, self.OnClose, self, tbInstancing, nNpcId);
	end;
end;

function tbHuoPengChen_Dialog:OnClose(tbInstancing, nNpcId)
	self:ChangeFight(tbInstancing, nNpcId);
	if (tbInstancing.nHuoPengChenTimerId) then
		Timer:Close(tbInstancing.nHuoPengChenTimerId);
		tbInstancing.nHuoPengChenTimerId = nil;
	end;
	return 0;
end;

function tbHuoPengChen_Dialog:ChangeFight(tbInstancing, nNpcId)
	assert(tbInstancing, nPlayerId, nNpcId);
	if (tbInstancing.nHuoPengChenOut ~= 0) then
		return;
	end;
	
	local pNpc = KNpc.GetById(nNpcId);
	local nSubWorld, nPosX, nPosY	= him.GetWorldPos();
	pNpc.Delete();
	
	local pNpc = KNpc.Add2(4145, tbInstancing.nNpcLevel, -1, nSubWorld, nPosX, nPosY);
	tbInstancing.nHuoPengChenOut = 1;
	pNpc.AddLifePObserver(90);
	pNpc.AddLifePObserver(70);
	pNpc.AddLifePObserver(60);
	pNpc.AddLifePObserver(40);
	pNpc.AddLifePObserver(30);
	pNpc.AddLifePObserver(20);
	pNpc.AddLifePObserver(10);
	pNpc.AddLifePObserver(5);
	pNpc.AddLifePObserver(4);
	pNpc.AddLifePObserver(3);
	pNpc.AddLifePObserver(2);
	
	local tbNpc = Npc:GetClass("huopengchen_fight");

	if (tbNpc) then
		tbInstancing:NpcSay(pNpc.dwId, tbNpc.tbSayText[100]);
	end;
	
end;

-- 火蓬春 戰斗
local tbHuoPengChen_Fight = Npc:GetClass("huopengchen_fight");

tbHuoPengChen_Fight.tbSayText = {
	[100] = {"殷童這個小丫頭片子！", "人都走了還不忘記捉弄人！"},
	[90] = {"老頭子已經不行了吧？", "俺在上面都聽說了！"},
	[70] = {"老頭子不行了，吖吼！", "那俺豈不是就是這裡的頭頭了？"},
	[60] = {"等俺把這裡的人都收拾齊嘍！", "看俺怎麼收拾你們！"},
	[40] = {"俺一定不會跟俺師傅一樣窩囊！"},
	[30] = {"俺一定要讓他們瞧瞧！", "俺地厲害！"},
	[20] = {"對了，還有殷童那小丫頭！", "俺一定要抓住她！", "讓她給俺當媳婦！"},
	[10] = {"你們就不能輕點啊！", "啊！俺的蠱怎麼招不出來了？", "你們對俺做了啥？"},
	[5]  = "難道老頭子給殷童的就是……",
	[4]  = "天殺的老頭子啊！",
	[3]  = "你死都死的不利索啊！",
	[2]  = "俺……俺……",
	[0]  = "俺恨你們……",
}

function tbHuoPengChen_Fight:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;

	if (nLifePercent < 10 and him) then
		him.SendChat(self.tbSayText[nLifePercent]);
		
		local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			teammate.Msg(self.tbSayText[nLifePercent], him.szName);
		end;
		return;
	end;
	
	tbInstancing:NpcSay(him.dwId, self.tbSayText[nLifePercent]);
end;

function tbHuoPengChen_Fight:OnDeath(pNpc)
	-- 掉一個寶箱
	local nSubWorld, nNpcPosX, nNpcPosY = him.GetWorldPos();
	local pBaoXiang = KNpc.Add2(4113, 1, -1, nSubWorld, nNpcPosX, nNpcPosY);
	assert(pBaoXiang)

	local pPlayer  	= pNpc.GetPlayer();
	pBaoXiang.GetTempTable("Task").nOwnerPlayerId = pPlayer.nId;
	pBaoXiang.GetTempTable("Task").CUR_LOCK_COUNT = 0;
	
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "地上出現一個閃閃發光的箱子！");
	end;
end;

-- 雪羽鴻飛
local tbXueYuHongFei = Npc:GetClass("xueyuhongfei");

tbXueYuHongFei.tbText = {
	[99] = "你們是什麼人敢闖入到禁地中來。",
	[90] = "這裡什麼都沒有，你們到底想要什麼？",
	[70] = {"難道，難道是他？", "是火蓬春這家伙讓你們來的？"},
	[50] = {"你們？你們都知道些什麼？", "你們知道你們都在干些什麼？"},
	[30] = "看樣子你們知道些什麼？",
	[0]  = "你們會後悔的！",
}

function tbXueYuHongFei:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (nLifePercent == 50 or nLifePercent == 70) then
		tbInstancing:NpcSay(him.dwId, self.tbText[nLifePercent]);
		return;
	end;
		
	local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbText[nLifePercent], him.szName);
	end;
	him.SendChat(self.tbText[nLifePercent]);
end;
