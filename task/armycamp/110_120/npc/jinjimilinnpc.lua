-------------------------------------------------------
-- 文件名　：jinjimilinnpc.lua
-- 文件描述：荊棘密林NPC
-- 創建者　：ZhangDeheng
-- 創建時間：2009-03-16 10:35:31
-------------------------------------------------------

local tbNpc_1 = Npc:GetClass("hl_jiheshi");

tbNpc_1.szDesc	= "集合石"
tbNpc_1.SEND_POS	= {1702, 3328};

function tbNpc_1:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (tbInstancing.nJiHeShiTime ~= 0) then
		local szMsg = "集合石暫不能使用，請過" .. tbInstancing.nJiHeShiTime .. "秒再使用！";
		local tbOpt = {"結束對話"};
		Dialog:Say(szMsg, tbOpt);
		return;
	end;
	if (tbInstancing.nJiHeShiCanUse ~= 1) then
		return ;
	end;
	
	local tbOpt = {};
	local szMsg = "請選擇您要召喚的隊友";
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		if (tbInstancing.tbPassJingJiMiLin[teammate.nId] ~= 1 and teammate.nId ~= me.nId) then
			tbOpt[#tbOpt + 1] = { teammate.szName, self.CallUp, self, tbInstancing, teammate.nId};
		end;
	end;
	if (#tbOpt == 0) then
		szMsg = "隊友都已經通過荊棘密林或不在副本中，不再需要傳送！";
	end;
	tbOpt[#tbOpt + 1] = {"結束對話"};
	Dialog:Say(szMsg, tbOpt);
end;

function tbNpc_1:CallUp(tbInstancing, nId)
	if (tbInstancing.tbPassJingJiMiLin[nId] and tbInstancing.tbPassJingJiMiLin[nId] == 1) then
		return;
	end;
	
	local pPlayer = KPlayer.GetPlayerObjById(nId);
	if (not pPlayer or pPlayer.nMapId ~= tbInstancing.nMapId) then
		return;
	end;
	
	Setting:SetGlobalObj(pPlayer);
	
	local tbPlayerDarkData	= BlackSky:GetDarkData();
	if (tbPlayerDarkData.nInDark == 1) then
		Setting:RestoreGlobalObj();
		return;
	end;
	
	local szMsg = "您的隊友召喚您，是否立刻傳送？";
	local tbOpt = {
			{"是",  self.SendNewPos, self, tbInstancing},
			{"否"},
		};
	Dialog:Say(szMsg, tbOpt);		
	Setting:RestoreGlobalObj();
end;	

function tbNpc_1:SendNewPos(tbInstancing)
	if (tbInstancing.nJiHeShiTime ~= 0) then
		return;
	end;
	
	me.NewWorld(tbInstancing.nMapId, self.SEND_POS[1], self.SEND_POS[2]);
	tbInstancing.nJiHeShiTime	= 30;
	me.SetFightState(1);
	Task.tbArmyCampInstancingManager:Tip2MapPlayer(me.nMapId, "<color=yellow>" .. me.szName .. "<color>已經被傳送通過荊棘密林");
end;


local tbNpc_2 = Npc:GetClass("hl_round1");

tbNpc_2.szDesc 	= "開啟BOSS1"
tbNpc_2.szText 	= "<npc=4181>：義軍？你們來做什麼，是白秋琳派你們來的？還是龍五。";
tbNpc_2.tbBoss1Pos	= {1719, 3290};
tbNpc_2.EFFECT_NPC	= 2976


function tbNpc_2:OnDialog()
	local nMapId, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);
	if (not tbInstancing or tbInstancing.nBoss1Out ~= 0) then
		return;
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Setting:SetGlobalObj(teammate);
		TaskAct:Talk(self.szText, self.TalkEnd, self, him.dwId, tbInstancing);
		Setting:RestoreGlobalObj();
	end;	
end;

function tbNpc_2:TalkEnd(dwId, tbInstancing)
	local pNpc = KNpc.GetById(dwId);
	if (not pNpc or tbInstancing.nBoss1Out ~= 0) then
		return;
	end;
	
	local nMapId, nPosX, nPosY	= pNpc.GetWorldPos();
	pNpc.Delete();
	
	local pNpc = KNpc.Add2(self.EFFECT_NPC, 10, -1, tbInstancing.nMapId, self.tbBoss1Pos[1], self.tbBoss1Pos[2]);
	Timer:Register(5 * Env.GAME_FPS, self.CallBoss, self, nMapId, pNpc.dwId);
end;

function tbNpc_2:CallBoss(nMapId, dwId)
	local pNpc = KNpc.GetById(dwId);
	if (not pNpc) then
		return 0;	
	end;
	pNpc.Delete();
		
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);
	if (not tbInstancing or tbInstancing.nBoss1Out ==1) then
		return 0 ;
	end;
		
	local pNpc = KNpc.Add2(4181, tbInstancing.nNpcLevel, -1, nMapId, self.tbBoss1Pos[1], self.tbBoss1Pos[2]);
	pNpc.CastSkill(1163, 10, -1, pNpc.nIndex);
	
	for i = 1, 9 do
		pNpc.AddLifePObserver(i * 10);
	end;
	tbInstancing.nBoss1Out = 1;	
	
	return 0;
end;

local tbNpc_1 = Npc:GetClass("hl_boss1");

tbNpc_1.szDesc 	= "BOSS1"
tbNpc_1.tbText  = {
			[90] = "也許你還會記得我，也許你已經忘記。",
			[80] = "回去吧，這裡不屬於你。",
			[70] = "我的妻兒還好嗎？",
			[60] = "不許你們驚擾我的主人！",
			[50] = "雖然我隻是個守門的，但不要低估了我的能力。",
			[40] = "我不願意再見到你們了，真的。",
			[30] = "感受到了嗎？我的能力提升了許多。",
			[20] = "生不逢時，英雄無用武之地。",
			[10] = "再見了，我的朋友，我不會忘記你的。",
			[0]  = "<npc=4181>：唉，希望你們能夠活著回來。如果你能見到我的妻兒請幫我轉告，我愛他們。",
	}

function tbNpc_1:OnLifePercentReduceHere(nLifePercent)
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

function tbNpc_1:OnDeath(pNpc)
	local nMapId, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);
	
	tbInstancing.nTrap2Pass = 1;
	tbInstancing.nJiHeShiCanUse = 0;
	
	local pNpc = KNpc.Add2(4151, 120, -1, tbInstancing.nMapId, 55200 / 32, 105056 / 32);
	pNpc.szName = "";
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Setting:SetGlobalObj(teammate);
		TaskAct:Talk(self.tbText[0]);
		Setting:RestoreGlobalObj();
	end;	
end;
