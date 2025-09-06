-------------------------------------------------------
-- 文件名　：yicengnpc.lua
-- 文件描述：副本一層NPC腳本
-- 創建者　：ZhangDeheng
-- 創建時間：2009-03-16 10:54:32
-------------------------------------------------------

local tbNpc = Npc:GetClass("hl_guess1");

tbNpc.tbDesc = {
		"第一輪游戲開啟：答案將在<color=red>6-36<color>之間隨機產生。",
		"第二輪游戲開啟：答案將在<color=red>5-30<color>之間隨機產生。",
		"第三輪游戲開啟：答案將在<color=red>4-24<color>之間隨機產生。",
	}

tbNpc.GUESS_GIFT = {
				{"白銀寶箱", 18, 1, 331, 1},
				{"青銅寶箱", 18, 1, 332, 1},
				{"黑鐵寶箱", 18, 1, 333, 1},
		}

function tbNpc:OnInit(tbInstancing, nMin, nMax)
	tbInstancing.nCurGuessPlayer 	= 0;

	tbInstancing.nCurGuess1No		= nMin - 1;
	tbInstancing.nGuess1Max			= nMax;
	
	tbInstancing.nOpen1 			= 1;
	tbInstancing.nGuessState1		= 0;
	tbInstancing.nGuessNo1			= MathRandom(nMax - nMin) + nMin;
	tbInstancing.nPassGuess			= {};
	tbInstancing.nReturnGuess		= {};
end;

function tbNpc:OnDialog()
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	if (tbInstancing.nOpenJiGuan ~= 4) then
		return;
	end;
	
	if (tbInstancing.nGuessState1 == 0) then
		local tbOpt = {
			{"開始游戲", self.GuessStart, self, tbInstancing},
			{"結束對話"},
		}
		Dialog:Say(self.tbDesc[tbInstancing.nYiCengGuessCount + 1], tbOpt);	
	end;
	if (tbInstancing.nGuessState1 == 1) then
		local pPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
		if (not pPlayer) then -- 如果當前猜字的玩家不在了，則下一位
			pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
		end;
		
		if (not pPlayer) then -- 副本中沒人了，出錯返回
			return;
		end;
		tbInstancing.nCurGuessPlayer = pPlayer.nId;
		
		if (me.nId == tbInstancing.nCurGuessPlayer) then
			local szMsg = "請選擇："
			local nNo = tbInstancing.nCurGuess1No;
			local tbOpt = {
					{string.format("%d", nNo + 1), self.InputNo, self, me.nId, him.dwId, tbInstancing, 1},
					{string.format("%d,%d", nNo + 1, nNo + 2), self.InputNo, self, me.nId, him.dwId, tbInstancing, 2},
					{string.format("%d,%d,%d", nNo + 1, nNo + 2, nNo + 3), self.InputNo, self, me.nId, him.dwId, tbInstancing, 3},
				};
			if (not tbInstancing.nPassGuess[tbInstancing.nCurGuessPlayer] or tbInstancing.nPassGuess[tbInstancing.nCurGuessPlayer] ~= 1) then
				if (not tbInstancing.nReturnGuess[tbInstancing.nCurGuessPlayer] or tbInstancing.nReturnGuess[tbInstancing.nCurGuessPlayer] ~= 1) then
					tbOpt[#tbOpt + 1] = {"通過", self.InputNo, self, me.nId, him.dwId, tbInstancing, 4};
					tbOpt[#tbOpt + 1] = {"返回", self.InputNo, self, me.nId, him.dwId, tbInstancing, 5};
				end;
			end;
			Dialog:Say(szMsg, tbOpt);
		else
			Dialog:SendInfoBoardMsg(me, "您現在不能猜點，請<color=yellow>" .. pPlayer.szName .. "<color>猜點");
			me.Msg("您現在不能猜點，請<color=yellow>" .. pPlayer.szName .. "<color>猜點");
		end;
	end;
end;

function tbNpc:GuessStart(tbInstancing)
	if (tbInstancing.nGuessState1 ~= 0) then
		return;
	end;
	
	tbInstancing:SetGuessTable(tbInstancing.tbGuessTable);
	Lib:SmashTable(tbInstancing.tbGuessTable);
	local pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
	if (pPlayer ~= nil) then
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Dialog:SendInfoBoardMsg(teammate, "猜點游戲開始，本輪的答案在<color=green>" ..(tbInstancing.nCurGuess1No + 1) .." - " .. tbInstancing.nGuess1Max .."<color>之間，請<color=yellow>" .. pPlayer.szName .. "<color>猜點");
			teammate.Msg("猜點游戲開始，本輪的答案在<color=green>" ..(tbInstancing.nCurGuess1No + 1) .." - " .. tbInstancing.nGuess1Max .."<color>之間，請<color=yellow>" .. pPlayer.szName .. "<color>猜點");
		end;
		
		if (tbInstancing.nGuessTimerId) then
			Timer:Close(tbInstancing.nGuessTimerId);
			tbInstancing.nGuessTimerId = nil;
		end;
		tbInstancing.nGuessTimerId = Timer:Register(Env.GAME_FPS * 30, self.OnBreath, self, him.dwId, tbInstancing);
		tbInstancing.nCurGuessPlayer = pPlayer.nId;
		tbInstancing.nGuessState1 = 1;
	end;
end;

function tbNpc:OnBreath(nId, tbInstancing)
	local pPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
	if (not pPlayer) then
		return;
	end;

	if (tbInstancing.nGuessTimerId) then
		Timer:Close(tbInstancing.nGuessTimerId);
		tbInstancing.nGuessTimerId = nil;
	end;
			
	local nNo = MathRandom(3);
	local szMsg = "<color=green>";
	for i = 1, nNo do
		local n = tbInstancing.nCurGuess1No + i;
		szMsg = szMsg .. n .. " ";
	end;
	szMsg = szMsg .. "<color>";
	Dialog:SendInfoBoardMsg(pPlayer, "您在30秒內未猜點，系統為您選隨機擇了" .. szMsg .."。");
	pPlayer.Msg("您在30秒內未猜點，系統為您選隨機擇了" .. szMsg .."。");
	self:InputNo(pPlayer.nId, nId, tbInstancing, nNo);
	return 0;
end;
	
function tbNpc:InputNo(nId, dwId, tbInstancing, nCount)
	if(nId ~= tbInstancing.nCurGuessPlayer) then
		return;
	end;
	
	if (tbInstancing.nGuessTimerId) then
		Timer:Close(tbInstancing.nGuessTimerId);
		tbInstancing.nGuessTimerId = nil;
	end;
	local pCurPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	
	if (nCount == 4) then
		local pCurPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
		local pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Dialog:SendInfoBoardMsg(teammate, "<color=yellow>" .. pCurPlayer.szName .."<color>選擇<color=green>通過<color>，請<color=yellow>" .. pPlayer.szName .. "<color>猜點");
			teammate.Msg("<color=yellow>" .. pCurPlayer.szName .."<color>選擇<color=green>通過<color>，請<color=yellow>" .. pPlayer.szName .. "<color>猜點");
			tbInstancing.nCurGuessPlayer = pPlayer.nId;
		end;
		
		if (tbInstancing.nGuessTimerId) then
			Timer:Close(tbInstancing.nGuessTimerId);
			tbInstancing.nGuessTimerId = nil;
		end;
	
		tbInstancing.nGuessTimerId = Timer:Register(Env.GAME_FPS * 30, self.OnBreath, self, dwId, tbInstancing);
		tbInstancing.nPassGuess[pCurPlayer.nId] = 1;
	elseif (nCount == 5) then
		local pCurPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
		tbInstancing.tbGuessTable = tbInstancing:ConverseTable(tbInstancing.tbGuessTable);
		local pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Dialog:SendInfoBoardMsg(teammate, "<color=yellow>" .. pCurPlayer.szName .."<color>選擇<color=green>返回<color>，請<color=yellow>" .. pPlayer.szName .. "<color>猜點");
			teammate.Msg("<color=yellow>" .. pCurPlayer.szName .."<color>選擇<color=green>返回<color>，請<color=yellow>" .. pPlayer.szName .. "<color>猜點");
			tbInstancing.nCurGuessPlayer = pPlayer.nId;
		end;
		
		if (tbInstancing.nGuessTimerId) then
			Timer:Close(tbInstancing.nGuessTimerId);
			tbInstancing.nGuessTimerId = nil;
		end;
	
		tbInstancing.nGuessTimerId = Timer:Register(Env.GAME_FPS * 30, self.OnBreath, self, dwId, tbInstancing);
		tbInstancing.nReturnGuess[pCurPlayer.nId] = 1;
	else
		if (tbInstancing.nGuessNo1 >= tbInstancing.nCurGuess1No + 1 and tbInstancing.nGuessNo1 <= tbInstancing.nCurGuess1No + nCount) then
			tbInstancing.nYiCengGuessCount = tbInstancing.nYiCengGuessCount + 1;
			if (tbInstancing.nYiCengGuessCount ~= 3) then
				for _, teammate in ipairs(tbPlayList) do
					Dialog:SendInfoBoardMsg(teammate, "很不幸<color=yellow>" .. pCurPlayer.szName .. "<color>猜到了倒霉數字，請進行下一輪猜點");
					teammate.Msg("很不幸<color=yellow>" .. pCurPlayer.szName .. "<color>猜到了倒霉數字，請進行下一輪猜點");
				end;
				if (tbInstancing.nYiCengGuessCount == 1) then
					self:OnInit(tbInstancing, 5, 30);
				elseif (tbInstancing.nYiCengGuessCount == 2) then
					self:OnInit(tbInstancing, 4, 24);
				end;
				
				tbInstancing.tbYiCengWinner[tbInstancing.nYiCengGuessCount] = pCurPlayer.nId;
			else
				tbInstancing.tbYiCengWinner[tbInstancing.nYiCengGuessCount] = pCurPlayer.nId;
				self:GameOver(dwId, tbInstancing);
			end;
		else
			local pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
			if not pPlayer then  -- 加層判斷zounan
				return;
			end	
			local szMsg = "";
			for i = tbInstancing.nCurGuess1No + 1, tbInstancing.nCurGuess1No + nCount do
				szMsg = szMsg .. i .. " ";
			end;
			for _, teammate in ipairs(tbPlayList) do
				Dialog:SendInfoBoardMsg(teammate, "<color=yellow>" .. pCurPlayer.szName .."<color>選擇<color=green>" .. szMsg .. "<color>，未猜中答案，請<color=yellow>" .. pPlayer.szName .. "<color>猜點");
				teammate.Msg("<color=yellow>" .. pCurPlayer.szName .."<color>選擇<color=green>" .. szMsg .. "<color>，未猜中答案，請<color=yellow>" .. pPlayer.szName .. "<color>猜點");
			end;
			
			if (tbInstancing.nGuessTimerId) then
				Timer:Close(tbInstancing.nGuessTimerId);
				tbInstancing.nGuessTimerId = nil;
			end;
	
			tbInstancing.nGuessTimerId = Timer:Register(Env.GAME_FPS * 30, self.OnBreath, self, dwId, tbInstancing);
			tbInstancing.nCurGuess1No = tbInstancing.nCurGuess1No + nCount;
			tbInstancing.nCurGuessPlayer = pPlayer.nId;
		end;
	end;
end;

function tbNpc:GameOver(nNpcId, tbInstancing)
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	local pCurPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
	
	for _, teammate in ipairs(tbPlayList) do
		local nWinCount = 1;
		for i = 1, #tbInstancing.tbYiCengWinner do
			if (tbInstancing.tbYiCengWinner[i] == teammate.nId) then
				nWinCount = nWinCount + 1;
			end;
		end;
		if (self.GUESS_GIFT[nWinCount]) then
			if (teammate.CountFreeBagCell() >= 1) then
				teammate.AddItem(self.GUESS_GIFT[nWinCount][2], self.GUESS_GIFT[nWinCount][3], self.GUESS_GIFT[nWinCount][4], self.GUESS_GIFT[nWinCount][5])
			else
				local nMapId, nPosX, nPosY = teammate.GetWorldPos();
				local pItem = KItem.AddItemInPos(nMapId, nPosX, nPosY, self.GUESS_GIFT[nWinCount][2], self.GUESS_GIFT[nWinCount][3], self.GUESS_GIFT[nWinCount][4], self.GUESS_GIFT[nWinCount][5], 0, 0, 0, nil, nil, 0, 0, teammate);
				pItem.SetOnlyBelongPick(1);
			end;
			Dialog:SendInfoBoardMsg(teammate, "很不幸<color=yellow>" .. pCurPlayer.szName .. "<color>猜到了倒霉數字，游戲結束。您獲得了一個<color=yellow>" .. self.GUESS_GIFT[nWinCount][1] .. "<color>!");
			teammate.Msg("很不幸<color=yellow>" .. pCurPlayer.szName .. "<color>猜到了倒霉數字，游戲結束。您獲得了一個<color=yellow>" .. self.GUESS_GIFT[nWinCount][1] .. "<color>!");
		else
			Dialog:SendInfoBoardMsg(teammate, "很不幸<color=yellow>" .. pCurPlayer.szName .. "<color>猜到了倒霉數字，游戲結束。"); 
			teammate.Msg("很不幸<color=yellow>" .. pCurPlayer.szName .. "<color>猜到了倒霉數字，游戲結束。"); 
		end;
	end;
	
	local pNpc = KNpc.GetById(nNpcId);
	local nPosX = 58912 / 32;
	local nPosY = 102752 / 32;
	if (pNpc) then
		local _, nX, nY = pNpc.GetWorldPos();
		nPosX = nX;
		nPosY = nY;
		
		pNpc.Delete();
	end;
	
	local pNpc = KNpc.Add2(4226, 120, -1, tbInstancing.nMapId, nPosX, nPosY);
	pNpc.szName = "二層密室入口";
end;

-- 一層機關，按照風 林 火 山 順序開啟
local tbJiGuan = Npc:GetClass("hl_jiguan");

tbJiGuan.szDesc = "一層機關";
tbJiGuan.szText = "<npc=4224>：你們找到了我，很好，但是要想通過這裡，你們必須幫我找到三個答案。<end><npc=4224>：忘了說了，答到數字的人將會受到懲罰。<end><npc=4224>：想好了就開始游戲，你們盡情享受吧，哈哈哈哈……<end>";

function tbJiGuan:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nOpenJiGuan == 4) then
		return;
	end;
	
	local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
	}
	GeneralProcess:StartProcess("正在開啟", 5 * 18, {self.OnOpen, self, him.dwId, me.nId, tbInstancing}, {me.Msg, "開啟被打斷！"}, tbEvent);
end;

function tbJiGuan:OnOpen(dwNpcId, nPlayerId, tbInstancing)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local pNpc = KNpc.GetById(dwNpcId);
	if (not pPlayer or not pNpc) then
		return;
	end;
	
	if (tbInstancing.nOpenJiGuan >= 4) then
		return;
	end;
	
	local tbNpcData = pNpc.GetTempTable("Task"); 
	assert(tbNpcData);

	if (tbNpcData.nNo ~= (tbInstancing.nOpenJiGuan + 1)) then
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Task.tbArmyCampInstancingManager:ShowTip(teammate, "開啟順序不對，請從風重新開啟!");
			teammate.Msg("開啟順序不對，請從風重新開啟!");
		end;
		tbInstancing.nOpenJiGuan = 0;
		return;
	end;
	
	tbInstancing.nOpenJiGuan = tbInstancing.nOpenJiGuan + 1;
	pPlayer.Msg("開啟成功！");
	
	if (tbInstancing.nOpenJiGuan == 4) then
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			teammate.NewWorld(tbInstancing.nMapId, 58880 / 32, 102688 / 32);
			tbInstancing:OnCoverBegin(teammate);
			teammate.SetFightState(1);
			
			Setting:SetGlobalObj(teammate);
			TaskAct:Talk(self.szText);
			Setting:RestoreGlobalObj();		
		end;	
			
		-- 猜點NPC
		KNpc.Add2(4224, 120, -1, tbInstancing.nMapId, 58912 / 32, 102752 / 32);
	end;
end;

-- 一層指引
local tbZhiYin = Npc:GetClass("hl_yindao1");

tbZhiYin.szDesc = "一層指引";

tbZhiYin.szText = "寫給後來的人們：\n    找到四面的擎天柱，按照<color=red>風，林，火，山<color>的順序開啟，游龍會降臨，按照他的指示，猜出三個密碼，就會出現下層的通道，但是，<color=red>猜對的人將會付出代價<color>。"

tbZhiYin.szDianShu = "猜點游戲規則：\n    1， 首先由系統在規定范圍內之間隨機挑一個數字（三輪的范圍分別是6-36，5-30，4-24）。\n    2， 玩家輪流報數，第一個玩家從最小的數字開始報，以第一輪為例，可以報6，67，678，三種選擇方式，如果報數中沒有系統選定的數字，則安全通過。第二個玩家延續第一個玩家的報數順序往下報，也是三種選擇，以此類推如果有一位玩家的報數與系統挑中的數字相同，那麼他就輸掉了比賽。\n    3， 在數字的三種組合選擇之外，玩家還可以選擇通過和返回，顧名思義，覺得下個數字危險，選擇通過下家不報數，或者返回給上家報數，將報數的順序逆過來。在一局比賽中，玩家隻能選擇一次通過或者返回，使用之後，這兩個選項將不會在面板中出現。\n    4， 當一個玩家猜中倒霉數字，則被標記為輸掉本輪比賽。待到三輪結束後，按照綜合成績頒發獎勵，一次未輸者獎勵最高。";

function tbZhiYin:OnDialog()
	Dialog:Say(self.szText, 
			{
				{"猜點規則", self.Say, self},
				{"結束對話"},	
			}
		);
end;

function tbZhiYin:Say()
	Dialog:Say(self.szDianShu, 
			{
				{"結束對話"},	
			}
		);	
end;

-- 一層開BOSS2機關
local tbJiGuan = Npc:GetClass("hl_round2");

tbJiGuan.szDesc = "一層開BOSS2開關";
tbJiGuan.szText = "<npc=4182>：我聞到了活人的味道，我的寶刀已經好久沒有嘗過鮮血了。"
tbJiGuan.EFFECT_NPC	= 2976

function tbJiGuan:OnDialog()
	local nMapId, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);

	if (not tbInstancing or tbInstancing.nBoss2Out ~= 0) then
		return;
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Setting:SetGlobalObj(teammate);
		TaskAct:Talk(self.szText, self.TalkEnd, self, him.dwId, tbInstancing);
		Setting:RestoreGlobalObj();
	end;	
end;

function tbJiGuan:TalkEnd(dwId, tbInstancing)

	local pNpc = KNpc.GetById(dwId);
	if (not pNpc) then
		return;
	end;
	
	local nMapId, nPosX, nPosY	= pNpc.GetWorldPos();
	pNpc.Delete();
	
	local pNpc = KNpc.Add2(self.EFFECT_NPC, 10, -1, tbInstancing.nMapId, nPosX, nPosY);
	Timer:Register(5 * Env.GAME_FPS, self.CallBoss, self, nMapId, pNpc.dwId);
end;

function tbJiGuan:CallBoss(nMapId, nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return 0;	
	end;

	local nMapId, nPosX, nPosY	= pNpc.GetWorldPos();
	pNpc.Delete();
		
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);
	if (not tbInstancing or tbInstancing.nBoss2Out == 1) then
		return 0;
	end;
		
	local pNpc = KNpc.Add2(4182, tbInstancing.nNpcLevel, -1, nMapId, nPosX, nPosY);
	pNpc.CastSkill(1163, 10, -1, pNpc.nIndex);
	for i = 1, 9 do
		pNpc.AddLifePObserver(i * 10);
	end;
	tbInstancing.nBoss2Out = 1;	
	return 0;
end;

local tbBoss2 = Npc:GetClass("hl_boss2");

tbBoss2.szDesc = "BOSS2"
tbBoss2.tbText = {
			[90] = "不許你們擾亂主人休息，去死吧。",
			[80] = "金國第一刀客可不是浪得虛名的。",
			[70] = "沒有人能夠通過這裡，沒有人。",
			[60] = "我燒，我燒，我燒燒燒。",
			[50] = "今晚加個菜，我要把你們變成燒烤的野味。",
			[40] = "入侵者，格殺勿論。",
			[30] = "我要出全力了，看招。。",
			[20] = "能把我逼到如此地步，還是第一次。",
			[10] = "完顏不破時刻守護在主人身邊。",
			[0]  = "<npc=4182>：你們贏了，過去吧，希望你們把這些力量用在正義的事業上，大地母親與你同在。",
	}
function tbBoss2:OnLifePercentReduceHere(nLifePercent)	
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	
	if (self.tbText[nLifePercent]) then
		him.SendChat(self.tbText[nLifePercent]);
		
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			teammate.Msg(self.tbText[nLifePercent], him.szName);
		end;
	end;
end;

function tbBoss2:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	
	tbInstancing.nTrap4Pass = 1;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(nSubWorld);
	for _, teammate in ipairs(tbPlayList) do
		Setting:SetGlobalObj(teammate);
		TaskAct:Talk(self.tbText[0]);
		Setting:RestoreGlobalObj();
	end;
	
	local pNpc = KNpc.Add2(4151, 120, -1, tbInstancing.nMapId, 56192 / 32, 110528 / 32);
	pNpc.szName = "";
end;

local tbSend1 = Npc:GetClass("hl_ceng1send");

tbSend1.szDesc 		= "猜數字1後的傳送門"
tbSend1.tbSendPos 	= {1788, 3293}; 

function tbSend1:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	
	Dialog:Say("是否傳送？", 
		{"好", self.Enter, self, me.nId, tbInstancing},
		{"暫時不去"})
end;

function tbSend1:Enter(nPlayerId, tbInstancing)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;
	
	me.NewWorld(tbInstancing.nMapId, self.tbSendPos[1], self.tbSendPos[2]);
end;
