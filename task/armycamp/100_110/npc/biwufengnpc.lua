-----------------------------------------------------------
-- 文件名　：biwufengnpc.lua
-- 文件描述：蠱翁，毒蠍幼蟲，蠍王
-- 創建者　：ZhangDeheng
-- 創建時間：2008-11-26 18:11:25
-----------------------------------------------------------

-- 蠱翁
local tbGuWeng = Npc:GetClass("guweng");

-- 幼蟲ID
tbGuWeng.nYouChongId = 4126;

-- 幼蟲出現的位置
tbGuWeng.tbYouChongPos = {
	{1777, 3069}, {1784, 3069}, {1787, 3081}, {1779, 3091}, {1773, 3079},
};

-- 
tbGuWeng.tbLifePresent = {99, 90, 80, 70, 30, 10,};

tbGuWeng.tbLifePresentText = {
	[99] = {{"二哥，他們在砸你的醋壇子","天絕使"}, {"閉嘴，我又不是沒有長眼睛", "碧蜈使"}},
	[90] = {{"二哥，還在砸！", "天絕使"}, {"看看再說，我的蠱可不是養來看的！", "碧蜈使"}},
	[80] = {{"二哥，你的蠱好像不怎麼厲害！", "天絕使"}, {"胡說，你懂啥，現在出來都是沒什麼用的，厲害的在後頭呢！", "碧蜈使"}},
	[70] = {{"二哥……", "天絕使"}, {"閉嘴！", "碧蜈使"}},
	[30] = {{"二哥，我看你的蠱是真的不行了！怕不是臭了吧？", "天絕使"}, {"又不是在腌咸菜，什麼臭不臭的，怕什麼？出了事有我頂著，這都是些小屁孩，我怎麼跟他們計較，傳出去我還怎麼見人？", "碧蜈使"}},
	[10] = {{"二哥，我覺得你這裡也不是很安全！", "天絕使"}, {"好戲還在後頭呢！", "碧蜈使"}},
	[0]  = {{"小癟三，你們折騰夠了吧？", "碧蜈使"}, {"現在讓你們數數馬王爺有幾隻眼！", "碧蜈使"}},
}

function tbGuWeng:OnLifePercentReduceHere(nLifePercent)
	
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);

	-- 添加幼蟲
	if (nLifePercent % 7 == 0) then
		for i = 1, #self.tbYouChongPos do
			for j = 1, 2 do
				KNpc.Add2(self.nYouChongId, tbInstancing.nNpcLevel, -1 , nSubWorld, self.tbYouChongPos[i][1], self.tbYouChongPos[i][2]);
			end;
		end;
	end;
	
	-- 說話
	for i = 1, #self.tbLifePresent do 
		if (nLifePercent == self.tbLifePresent[i]) then
			local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
			for _, teammate in ipairs(tbPlayList) do
				teammate.Msg(self.tbLifePresentText[nLifePercent][1][1],self.tbLifePresentText[nLifePercent][1][2]);
				teammate.Msg(self.tbLifePresentText[nLifePercent][2][1],self.tbLifePresentText[nLifePercent][2][2]);
			end;
		end;
	end;
end;

function tbGuWeng:OnDeath(pNpc)
	local nSubWorld, _, _ = him.GetWorldPos();	
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
		
	local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbLifePresentText[0][1][1],self.tbLifePresentText[0][1][2]);
		teammate.Msg(self.tbLifePresentText[0][2][1],self.tbLifePresentText[0][2][2]);
	end;
end;

-- 毒蠍幼蟲
local tbDuXieYouChong = Npc:GetClass("youchong");
-- 需要殺的數量
tbDuXieYouChong.NEED_COUNT		= 100;

-- 死亡時執行
function tbDuXieYouChong:OnDeath(pNpc)
	local nSubWorld, nNpcPosX, nNpcPosY = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	
	tbInstancing.nDuXieYouChong = tbInstancing.nDuXieYouChong + 1;
	if (tbInstancing.nDuXieYouChong >= self.NEED_COUNT and tbInstancing.nXieWangOut == 0) then
		local pXieWang = KNpc.Add2(4127, tbInstancing.nNpcLevel, -1 , nSubWorld, 1800, 3035);
		assert(pXieWang);
		
		pXieWang.AddLifePObserver(90);
		pXieWang.AddLifePObserver(70);
		pXieWang.AddLifePObserver(50);
		pXieWang.AddLifePObserver(30);
		pXieWang.AddLifePObserver(10);
		tbInstancing.nXieWangOut = 1;
		-- 留一半
		if (tbInstancing.nLiuYiBanOutCount ~= 0) then
			local pNpc = KNpc.Add2(4155, tbInstancing.nNpcLevel, -1, nSubWorld, 1804, 3036);
			pNpc.AddLifePObserver(60);
		end;
		
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Task.tbArmyCampInstancingManager:ShowTip(teammate, "碧蜈使已出現");
		end;
	end;
end;

-- 蠍王
local tbBiWuShi = Npc:GetClass("biwushi");

tbBiWuShi.tbText = {
	[90] = {"難怪老四這麼害怕！還挺扎手！", "大理國內沒有這樣的好手！", "你們是哪路高手，報上名來！"},
	[70] = {{"怎麼的？看不起人？知道我是誰不？", "我可是百蠻山的老大！"}, {"二哥，大姐知道會不高興的！", "天絕使"}, {"不高興？她什麼時候高興過？", "她要是高興的話早就是你二嫂了！"}},
	[50] = {"點子扎手！", "有點吃不消了！"},
	[30] = {{"我看我們還是去找大姐吧！", "天絕使"}, {"你誠心看我出丑嗎？", "碧蜈使"}, {"出丑總比沒命強吧？", "天絕使"}},
	[10] = {{"二哥！留著青山在還怕沒柴燒？", "天絕使"}, {"唉！風緊扯呼！", "碧蜈使"}},
	[0]  = {"看樣子有點晚了！", "你自己逃命去吧！"}
}

function tbBiWuShi:OnDeath(pNpc)
	local nSubWorld, nNpcPosX, nNpcPosY = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	
	local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbText[0][1], him.szName);
		teammate.Msg(self.tbText[0][2], him.szName);
	end;
	
	tbInstancing.nBiWuFengPass = 1;
	
	if (not tbInstancing.nJinZhiBiWuFeng) then
		return;
	end;
	
	local pNpc = KNpc.GetById(tbInstancing.nJinZhiBiWuFeng);
	if (pNpc) then
		pNpc.Delete();
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "您可以前往神蛛峰了！");
	end;
end;

function tbBiWuShi:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	if (nLifePercent == 90 or nLifePercent == 50) then
			tbInstancing:NpcSay(him.dwId, self.tbText[nLifePercent]);
			him.GetTempTable("Task").tbSayOver = nil;
	end;
	if (nLifePercent == 70) then
		tbInstancing:NpcSay(him.dwId, self.tbText[nLifePercent][1]);
		him.GetTempTable("Task").tbSayOver = {self.SayOver, self, him.dwId, self.tbText[nLifePercent]};
	end;
	if (nLifePercent == 30 or nLifePercent == 10) then
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			for i = 1, #self.tbText[nLifePercent] do
				teammate.Msg(self.tbText[nLifePercent][i][1], self.tbText[nLifePercent][i][2]);
			end;
		end;
	end;
end;

function tbBiWuShi:SayOver(nNpcId, tbText)
	if (not nNpcId or not tbText) then
		return;
	end;
	
	local pNpc = KNpc.GetById(nNpcId);
	local nSubWorld, _, _ = pNpc.GetWorldPos();	
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
		
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(tbText[2][1], tbText[2][2]);
	end;
	
	tbInstancing:NpcSay(nNpcId, tbText[3]);
	him.GetTempTable("Task").tbSayOver = nil;
end;

-- 碧蜈峰指引
local tbBiWuFengZhiYin = Npc:GetClass("biwufengzhiyin");

tbBiWuFengZhiYin.szText = "    過橋處便是碧蜈峰，此處由碧蜈使把守。碧蜈使以前輩自居，對後輩從不主動出手。若想和他交手，必須將其激怒。\n\n   等下你們經過碧蜈峰會看到一個巨大的蠱瓮，此是碧蜈使煉蠱所用。<color=red>隻要攻擊此瓮，瓮內的蠱物必會按奈不住出來傷人，蠱物傷的多了，碧蜈使自然會按奈不住。<color>";

function tbBiWuFengZhiYin:OnDialog()
	local tbOpt = {{"結束對話"}, };
	Dialog:Say(self.szText, tbOpt);
end;
