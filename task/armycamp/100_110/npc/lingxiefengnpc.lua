-----------------------------------------------------------
-- 文件名　：lingxiefengnpc.lua
-- 文件描述：碧蜈峰NPC腳本
-- 創建者　：ZhangDeheng
-- 創建時間：2008-11-27 09:19:00
-----------------------------------------------------------

-- 鐵公雞牢門
local tbLaoMen = Npc:GetClass("laomen");

function tbLaoMen:OnDialog()
	local nSubWorld, _, _	= me.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nLaoMenDurationTime ~= 0) then
		me.Msg("五秒鐘以後才能再次開啟！")
		return;
	end;
	
		local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
	}
	-- 
	GeneralProcess:StartProcess("正在開啟", 5 * Env.GAME_FPS, {self.Open, self, me.nId, him.dwId, tbInstancing}, {me.Msg, "開啟被打斷"}, tbEvent);
end;

-- 打開牢門 成功率30%
function tbLaoMen:Open(nPlayerId, nNpcId, tbInstancing)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local pNpc = KNpc.GetById(nNpcId);
	assert(pPlayer);
	if (not pNpc) then
		return;
	end;
	
	-- 成功率30%
	local nSuccess = MathRandom(100);
	if (nSuccess < 30) then
		Task.tbArmyCampInstancingManager:ShowTip(pPlayer, "鐵門已打開！");
		tbInstancing.nTieGongJiLaoMen = 1;
		pNpc.Delete();
	else
		pPlayer.Msg("開啟失敗！");
		tbInstancing.nLaoMenDurationTime = 5;
	end;
end;

-- 鐵公雞 對話
local tbTieGongJi = Npc:GetClass("tiegongji_dialog");
-- 需要的物品
tbTieGongJi.tbNeedItemList 	= { {20, 1, 626, 1, 20}, };
-- 鐵公雞的行走路線
tbTieGongJi.tbTrack			= { 
	{1870, 2694}, {1881, 2693}, {1890, 2681}, 
	{1900, 2675}, {1889, 2650}, {1871, 2650}, 
	{1866, 2638}, {1874, 2619}, {1882, 2606} 
};

tbTieGongJi.tbText = {"啊！天哪！天哪！這是誰？", "是誰帶來這麼可惡的家伙？"};

function tbTieGongJi:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	if (tbInstancing.nTieGongJiOut == 1) then
		return;
	end;
	
	Dialog:Say("給我20隻蠍尾，我可以幫你們除掉靈蠍使。",
		{
			{"給蠍尾", self.Give, self, tbInstancing, me.nId, him.dwId},
			{"結束對話"}
		});
end;

function tbTieGongJi:Give(tbInstancing, nPlayerId, nNpcId)
	Task:OnGift("給鐵嘴公雞20隻蠍尾。", self.tbNeedItemList, {self.Pass, self, tbInstancing, nPlayerId, nNpcId}, nil, {self.CheckRepeat, self, tbInstancing}, true);
end;

function tbTieGongJi:CheckRepeat(tbInstancing)
	if (tbInstancing.nTieGongJiOut == 1) then
		return 0;
	end	
	return 1; 
end

function tbTieGongJi:Pass(tbInstancing, nPlayerId, nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return;
	end;
	local nSubWorld, nPosX, nPosY	= him.GetWorldPos();
	pNpc.Delete();
	
	if (tbInstancing.nTieGongJiLaoOut == 1) then
		return;
	end;
	local pFightNpc = KNpc.Add2(4170, 100, -1, nSubWorld, nPosX, nPosY);
	tbInstancing.nTieGongJiOut = 1;
	tbInstancing.dwFightGongJiId = pFightNpc.dwId;
	
	tbInstancing:Escort(pFightNpc.dwId, nPlayerId, self.tbTrack, 50, 1);
	pFightNpc.GetTempTable("Npc").tbOnArrive = {self.OnArrive, self, pFightNpc.dwId, me.nId};
	
	tbInstancing.bLXSCastSkill = false;
	
	if (tbInstancing.nLingXieShiId) then
		local pNpc = KNpc.GetById(tbInstancing.nLingXieShiId);
		if (not pNpc) then
			return;
		end;
		pNpc.RemoveSkillState(999);
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg("喔喔喔！！！", pFightNpc.szName);
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "鐵嘴金雞的鳴叫已令靈蠍使的金鐘罩失去效力");
	end;
end;

function tbTieGongJi:OnArrive(dwNpcId, nPlayerId)

	assert(dwNpcId and nPlayerId);
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then  --加上保護 zounan
		return;
	end
	local nSubWorld, _, _	= pNpc.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);

	local tbNpc = Npc:GetClass("lingxieshi");
	tbInstancing:NpcSay(tbInstancing.nLingXieShiId, self.tbText);
end;

-- 靈蠍使
local tbLingXieShi = Npc:GetClass("lingxieshi");

tbLingXieShi.tbText = {
	[99] = "這一關可沒那麼好過！",
	[50] = {"快把它帶走，快點帶走！", "我求求你們啦！快帶走它！"},
	[30] = "可惡的家伙，我不放過你們！",
	[10] = "看我的蠱影分身大法！",
	[0]  = "你們不得好死！",
}
-- 毒蠍ID
tbLingXieShi.tbDuWeiXieId = 4128;
-- 毒蠍位置
tbLingXieShi.tbPos = {
	{1880, 2601}, {1883, 2601}, {1885, 2602}, {1886, 2604},
	{1886, 2607}, {1884, 2609}, {1881, 2609}, {1879, 2605},
}

tbLingXieShi.tbDropItem = {"setting\\npc\\droprate\\droprate010_shouling.txt", 6};

function tbLingXieShi:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nJinZhiLingXieFeng) then
		local pNpc_x = KNpc.GetById(tbInstancing.nJinZhiLingXieFeng);
		if (pNpc_x) then
			pNpc_x.Delete();
		end;
	end;
	
	
	
	tbInstancing.nLingXieFengPass = 1;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	
	-- 掉落
	local nId = 0;
	if (pNpc and pNpc.GetPlayer()) then
		nId = pNpc.GetPlayer().nId;
	else
		nId = tbPlayList[1].nId;
	end;
	him.DropRateItem(self.tbDropItem[1], self.tbDropItem[2], -1, -1, nId);
	
	for _, teammate in ipairs(tbPlayList) do
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "您可以前往天絕峰了！");
	end;
end;

function tbLingXieShi:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (nLifePercent == 50) then
		tbInstancing:NpcSay(him.dwId, self.tbText[nLifePercent]);
		him.GetTempTable("Task").tbSayOver = nil;
		return;
	end;
	
	him.SendChat(self.tbText[nLifePercent]);
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbText[nLifePercent], him.szName);
	end;	
	
	if (nLifePercent == 10) then
		-- 毒蠍幼蟲
		for i = 1, 8 do
			local pNpc = KNpc.Add2(self.tbDuWeiXieId, 100, -1, nSubWorld, self.tbPos[i][1], self.tbPos[i][2]);
			assert(pNpc);
			pNpc.GetTempTable("Task").nLingXieFengLifePresent = him.nCurLife;
		end;
		-- 刪除公雞
		if (tbInstancing.dwFightGongJiId) then
			local pGongJi = KNpc.GetById(tbInstancing.dwFightGongJiId);
			if (pGongJi) then
				pGongJi.Delete();
				tbInstancing.dwFightGongJiId = nil;
			end;
		end;
		-- 刪除靈蠍使
		him.Delete();
	end;
end;

-- 毒尾蠍
local tbDuWeiXie = Npc:GetClass("duweixie");

function tbDuWeiXie:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	--assert(tbInstancing); 改成保護 zounan
	if not tbInstancing then
		Dbg:WriteLog("軍營","毒尾蠍 死亡時 無副本",nSubWorld);
		return;
	end
			
	local tbNpcData = him.GetTempTable("Task");
	if (not tbNpcData or not tbNpcData.nLingXieFengLifePresent) then
		return; -- 
	end;
	
	tbInstancing.nDuWeiXieCount = tbInstancing.nDuWeiXieCount + 1;
	if (tbInstancing.nDuWeiXieCount > 8) then
		return;
	end;
	
	if (tbInstancing.nDuWeiXieCount == 8) then
		local pNpc = KNpc.Add2(4136, tbInstancing.nNpcLevel, -1 , tbInstancing.nMapId, 1883, 2605);
		assert(pNpc);
		
		local nReduct = pNpc.nMaxLife - tbNpcData.nLingXieFengLifePresent;
		pNpc.ReduceLife(nReduct);
	end;
end;

-- 靈蠍峰指引
local tbLingXieFengZhiYin = Npc:GetClass("lingxiefengzhiyin");

tbLingXieFengZhiYin.szText = "    能闖到此地，諸位果然是高手。不過前方靈蠍使所修與其他三使不同，請留神聽我說。\n\n    靈蠍使所修蠱術可令其有如金鐘，刀劍難傷。可惜再強的絕技也有罩門，破她蠱術的恰恰是最不起眼的雄雞。\n\n    諸位可先暗中<color=red>從靈蠍峰的蠍子身上獲得蠍尾20隻，將其喂給我暗中喂養的鐵嘴金雞<color>，它自會帶著你們大鬧靈蠍峰。";

function tbLingXieFengZhiYin:OnDialog()
	local tbOpt = {{"結束對話"}, };
	Dialog:Say(self.szText, tbOpt);
end;
