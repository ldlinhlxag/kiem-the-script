-------------------------------------------------------
-- 文件名　：ercengnpc.lua
-- 文件描述：海陵王墓
-- 創建者　：ZhangDeheng
-- 創建時間：2009-03-17 08:46:04
-------------------------------------------------------

local tbNpc = Npc:GetClass("hl_guess2");

tbNpc.szDesc = "數字將會在<color=red>1-100<color>之間隨機產生，請按照順序說出你們的答案。";

function tbNpc:OnInit(tbInstancing, nMin, nMax)

	tbInstancing.nCurGuess2No		= nMin;
	tbInstancing.nGuess2Max			= nMax;
	
	tbInstancing.nGuessState2		= 0;
	tbInstancing.nGuessNo2			= MathRandom(nMax - nMin) + nMin;
end;

function tbNpc:OnDialog()
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	if (tbInstancing.nZhuZiOpen ~= 1) then
		return;
	end;
	
	if (tbInstancing.nGuessState2 == 0) then
		local tbOpt = {
			{"開始游戲", self.GuessStart, self, tbInstancing, him.dwId},
			{"結束對話"},
		}
		Dialog:Say(self.szDesc, tbOpt);	
	end;
	if (tbInstancing.nGuessState2 == 1) then
		local pPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
		if (not pPlayer) then -- 如果當前猜字的玩家不在了，則下一位
			pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
		end;
		
		if (not pPlayer) then -- 副本中沒人了，出錯返回
			return;
		end;
		tbInstancing.nCurGuessPlayer = pPlayer.nId;
		
		if (me.nId == tbInstancing.nCurGuessPlayer) then
			Dialog:AskNumber("請輸入您猜的點：", tbInstancing.nGuess2Max, self.InputNo, self, tbInstancing, him.dwId, me.nId);
		else
			Dialog:SendInfoBoardMsg(me, "您現在不能猜點，請<color=yellow>" .. pPlayer.szName .. "<color>猜點");
			me.Msg("您現在不能猜點，請<color=yellow>" .. pPlayer.szName .. "<color>猜點");
		end;
	end;
end;

function tbNpc:GuessStart(tbInstancing, dwId)
	if (tbInstancing.nGuessState2 ~= 0) then
		return;
	end;
	 
	tbInstancing:SetGuessTable(tbInstancing.tbGuessTable);
	Lib:SmashTable(tbInstancing.tbGuessTable);
	local pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
	if (pPlayer ~= nil) then
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Dialog:SendInfoBoardMsg(teammate, "猜點游戲開始，答案在<color=green>" ..tbInstancing.nCurGuess2No .. " - " .. tbInstancing.nGuess2Max .."<color>之間，請<color=yellow>" .. pPlayer.szName .. "<color>猜點");
			teammate.Msg("猜點游戲開始，答案在<color=green>" ..tbInstancing.nCurGuess2No .. " - " .. tbInstancing.nGuess2Max .."<color>之間，請<color=yellow>" .. pPlayer.szName .. "<color>猜點");
		end;
		
		tbInstancing.nGuessTimerId = Timer:Register(Env.GAME_FPS * 30, self.OnBreath, self, tbInstancing, dwId);
		tbInstancing.nGuessState2 = 1;
		tbInstancing.nCurGuessPlayer = pPlayer.nId;
	end;

end;

function tbNpc:OnBreath(tbInstancing, nNpcId)	
	local pPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
	if (not pPlayer) then
		return;
	end;

	if (tbInstancing.nGuessTimerId) then
		Timer:Close(tbInstancing.nGuessTimerId);
		tbInstancing.nGuessTimerId = nil;
	end;

	local nNo = MathRandom(tbInstancing.nGuess2Max - tbInstancing.nCurGuess2No) + tbInstancing.nCurGuess2No;
	local szMsg = "<color=green>";
	szMsg = szMsg .. nNo;
	szMsg = szMsg .. "<color>";
	Dialog:SendInfoBoardMsg(pPlayer, "您在30秒內未猜點，系統為您選隨機擇了" .. szMsg .."。");
	pPlayer.Msg("您在30秒內未猜點，系統為您選隨機擇了" .. szMsg .."。");
	self:InputNo(tbInstancing, nNpcId, pPlayer.nId, nNo);
	return 0;
end;

function tbNpc:InputNo(tbInstancing, nNpcId, nId, nCount)
	if (nId ~= tbInstancing.nCurGuessPlayer) then
		return;
	end;
	
	if (tbInstancing.nGuessTimerId) then
		Timer:Close(tbInstancing.nGuessTimerId);
		tbInstancing.nGuessTimerId = nil;
	end;
	
	local pCurPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
	if (tbInstancing.nGuessNo2 == nCount) then
		tbInstancing.nCurGuessPlayer = nil;
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Dialog:SendInfoBoardMsg(teammate, "恭喜<color=yellow>" .. pCurPlayer.szName .. "<color>猜中了點數, 獲得了一個黃金寶箱！");
			teammate.Msg("恭喜<color=yellow>" .. pCurPlayer.szName .. "<color>猜中了點數, 獲得了一個黃金寶箱！");
		end;

		if (pCurPlayer.CountFreeBagCell() >= 1) then
			pCurPlayer.AddItem(18, 1, 330, 1)
		else
			local nMapId, nPosX, nPosY = pCurPlayer.GetWorldPos();
			local pItem = KItem.AddItemInPos(nMapId, nPosX, nPosY, 18, 1, 330, 1,0, 0, 0, nil, nil, 0, 0, pCurPlayer);
			pItem.SetOnlyBelongPick(1);
		end;
		
		tbInstancing.nErCengWinner	 = pCurPlayer.nId;
		tbInstancing.nGuessState2 = 2;
		tbInstancing.nTrap5Pass	= 1;
		
		local pNpc = KNpc.GetById(nNpcId);
		if (pNpc) then
			local _, nPosX, nPosY = pNpc.GetWorldPos();
			pNpc.Delete();
			local pNpc = KNpc.Add2(4227, 120, -1, tbInstancing.nMapId, nPosX, nPosY);
			pNpc.szName = "三層密室入口";
		end;
	else
		local pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
		if not pPlayer then -- 加層判斷 zounan
			return;
		end
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			local szMsg = "";
			
			if (nCount < tbInstancing.nGuessNo2) then
				if (tbInstancing.nCurGuess2No < nCount) then
					tbInstancing.nCurGuess2No = nCount;
				end;
			else
				if (tbInstancing.nGuess2Max > nCount) then
					tbInstancing.nGuess2Max = nCount;
				end;
			end;
			Dialog:SendInfoBoardMsg(teammate, "數字<color=green>" .. nCount.. "<color>未猜中，請<color=yellow>" .. pPlayer.szName .. "<color>繼續猜點！答案在<color=green>" ..tbInstancing.nCurGuess2No .. " - " .. tbInstancing.nGuess2Max .."<color>之間。");
			teammate.Msg("數字<color=green>" .. nCount.. "<color>未猜中，請<color=yellow>" .. pPlayer.szName .. "<color>繼續猜點！答案在<color=green>" ..tbInstancing.nCurGuess2No .. " - " .. tbInstancing.nGuess2Max .."<color>之間。");
		end;
		tbInstancing.nGuessTimerId = Timer:Register(Env.GAME_FPS * 30, self.OnBreath, self, tbInstancing, nNpcId);
		tbInstancing.nCurGuessPlayer = pPlayer.nId;
	end;
end;

local tbZhuZi2 = Npc:GetClass("hl_zhuzi2");

tbZhuZi2.szDesc = "二層柱子";

function tbZhuZi2:OnDialog()
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	
	if (tbInstancing.tbOpen[him.dwId] ~= 0 or tbInstancing.nZhuZiOpen ~= 0) then
		return;
	end;
	if (tbInstancing.nOpenZhuZiTime ~= 2) then
		--進度條
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
end;


function tbZhuZi2:OnOpen(nNpcId, nPlayerId, tbInstancing)
	tbInstancing.nOpenZhuZiTime = 1;
	tbInstancing.tbOpen[nNpcId] = 1;
end;

-- 一層開BOSS2機關
local tbJiGuan = Npc:GetClass("hl_round3");

tbJiGuan.szDesc = "二層開BOSS2開關";
tbJiGuan.szText = "<npc=4183>：我征服的疆土比你們見過的還多，放馬過來吧，年輕人。"
tbJiGuan.EFFECT_NPC	= 2976
tbJiGuan.tbHuWeiPos = {
		{1762, 3558},
		{1768, 3565},
		{1762, 3571},
		{1765, 3564},
	}
tbJiGuan.tbHuWeiId = {
			4185, 4186, 4187, 4188, 4189, 4190, 
			4191, 4192, 4193, 4194, 4195, 4196, 
			4197, 4198, 4199, 4200, 4201, 4202, 
			4203, 4204, 4205, 4206, 4207, 4208, 
		}
		
function tbJiGuan:OnDialog()
	local nMapId, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);

	if (not tbInstancing or tbInstancing.nBoss3Out ~= 0) then
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
	if (not pNpc or tbInstancing.nBoss3Out == 1) then
		return;
	end;
	local nMapId, nPosX, nPosY	= pNpc.GetWorldPos();
	pNpc.Delete();
	
	local pNpc = KNpc.Add2(self.EFFECT_NPC, 10, -1, tbInstancing.nMapId, nPosX, nPosY);
	Timer:Register(5 * Env.GAME_FPS, self.CallBoss, self, nMapId, pNpc.dwId);
end;

function tbJiGuan:CallBoss(nMapId, dwId)
	local pNpc = KNpc.GetById(dwId);
	if (not pNpc) then
		return 0;	
	end;

	local nMapId, nPosX, nPosY	= pNpc.GetWorldPos();
	pNpc.Delete();
	
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);
	if (not tbInstancing or tbInstancing.nBoss3Out == 1) then
		return 0;
	end;
		
	local pNpc = KNpc.Add2(4183, tbInstancing.nNpcLevel, -1, nMapId, nPosX, nPosY);
	pNpc.CastSkill(1163, 10, -1, pNpc.nIndex);
	for i = 1, 9 do
		pNpc.AddLifePObserver(i * 10);
	end;
	tbInstancing.nBoss3Out = 1;	
	
	for i = 1, 4 do
		Lib:SmashTable(self.tbHuWeiId);
		KNpc.Add2(self.tbHuWeiId[i], tbInstancing.nNpcLevel, -1, nMapId, self.tbHuWeiPos[i][1], self.tbHuWeiPos[i][2]);
	end;
end;
-- BOSS3
local tbBoss3 = Npc:GetClass("hl_boss3");

tbBoss3.szDesc = "BOSS3";
tbBoss3.tbText = {
			[90] = "無需我出手，護衛們抓刺客。",
			[80] = "我馳騁江湖的時候你們都還沒出生呢。",
			[70] = "不是我倚老賣老，你們打不過我的。",
			[60] = "你們勇氣可嘉，但是依照軍法按律當斬。",
			[50] = "想當年岳家軍也要讓我三分。",
			[40] = "我倒要給你們看看，老狗也有幾顆牙。",
			[30] = "堅強起來，我骨子裡流的可是大金的血。",
			[20] = "這是最後一擊了，我不會敗給你們的。",
			[10] = "無論你建立多少豐功偉業，你都無法承受歲月的煎熬。",
			[0]  = "<npc=4183>：大金的江山豈是爾等鼠輩可以動搖的，你們永遠無法征服我們狂野的心。",
	}
function tbBoss3:OnLifePercentReduceHere(nLifePercent)
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

function tbBoss3:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	
	tbInstancing.nTrap6Pass = 1;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(nSubWorld);
	for _, teammate in ipairs(tbPlayList) do
		Setting:SetGlobalObj(teammate);
		TaskAct:Talk(self.tbText[0]);
		Setting:RestoreGlobalObj();
	end;
	local pNpc = KNpc.Add2(4151, 120, -1, tbInstancing.nMapId, 55840 / 32, 116736 / 32);
	pNpc.szName = "";
end;

local tbErCengSend = Npc:GetClass("hl_ceng2chuansong");

tbErCengSend.szDesc = "二層傳送";

function tbErCengSend:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	
	Dialog:Say("是否進入？", 
		{"好", self.Enter, self, me.nId, him.dwId, tbInstancing},
		{"暫時不去"})
end;

function tbErCengSend:Enter(nPlayerId, nNpcId, tbInstancing)
	local pNpc = KNpc.GetById(nNpcId);
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pNpc or not pPlayer) then
		return;
	end;
	local tbData = pNpc.GetTempTable("Task");
	if (not tbData or not tbData.tbNo) then
		return;
	end;
	
	me.NewWorld(tbInstancing.nMapId, tbInstancing.ERCENG_SEND_POS[tbData.tbNo[1]][tbData.tbNo[2]][tbData.tbNo[3]][1] / 32, tbInstancing.ERCENG_SEND_POS[tbData.tbNo[1]][tbData.tbNo[2]][tbData.tbNo[3]][2] / 32);
end;

local tbSend2 = Npc:GetClass("hl_ceng2send");

tbSend2.szDesc 		= "猜點2後的傳送門"
tbSend2.tbSendPos 	= {1775, 3490}; 

function tbSend2:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	
	Dialog:Say("是否進入？", 
		{"好", self.Enter, self, me.nId, tbInstancing},
		{"暫時不去"})
end;

function tbSend2:Enter(nPlayerId, tbInstancing)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;
	
	me.NewWorld(tbInstancing.nMapId, self.tbSendPos[1], self.tbSendPos[2]);
end;


-- 一層指引
local tbZhiYin = Npc:GetClass("hl_yindao2");

tbZhiYin.szDesc = "二層指引";

tbZhiYin.szText = "寫給後來的人們：\n    到達迷宮角落，四個人<color=red>同時開啟光影石<color>，游龍會再次降臨，按照他的指示，猜中答案，就會出現下層的通道，但是這次與上層不同，<color=red>猜對的人將會得到豐厚的獎勵<color>。"

tbZhiYin.szDianShu = "猜點的游戲規則：\n    由系統寫出其中的任意一個數字，(以1-100為例，寫出88)，再由所有游戲者按順序每人說一個數字，而游戲者說出的數字有三種可能性，一個比寫好的大，一個比寫好的小，一個正好, 如果比寫好的數字大的話(比如99)，出題者就應該縮小范圍為此游戲者說的數字與最小數字之間(出題者應該說1-99)，再由下一個游戲者說出一個數字, 如果比寫好的數字小的話(比如11)，出題者就應該縮小范圍為此游戲者說的數字與最大數字之間(出題者應該說11-100)，再由下一個游戲者說出一個數字，(再延伸一下，下一個游戲者說90，出題者說11-90，再下一游戲者說60，出題者說60-90，依次類推) 直到游戲者說出出題者寫出的數字，游戲結束。"

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
