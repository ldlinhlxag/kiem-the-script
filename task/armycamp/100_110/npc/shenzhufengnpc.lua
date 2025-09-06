-----------------------------------------------------------
-- 文件名　：shenzhufengnpc.lua
-- 文件描述：神蛛峰NPC腳本
-- 創建者　：ZhangDeheng
-- 創建時間：2008-11-26 20:39:28
-----------------------------------------------------------

-- 鑼
local tbLuo = Npc:GetClass("luo");
-- 傳送玩家的位置
tbLuo.tbPlayerPos = {1952, 2896};

tbLuo.tbPlayText = {"是誰膽敢妄動我的禁物！", "神蛛使"};

-- 刷出的幼蟲的位置
tbLuo.tbZhiZhuYouChongPos = { {1952, 2885}, {1946, 2907}, {1942, 2897}, {1945, 2888}, {1959, 2906}, {1953, 2910}, {1959, 2888}, {1962, 2897},}
-- 敲鑼
function tbLuo:OnDialog()
	local nSubWorld, _, _	= me.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	-- 可以敲鼓就不能再敲鑼
	if (tbInstancing.nPlayDrumCount == 1) then
		return;
	end;
	-- 時間是否到
	if (tbInstancing.nPlayDrumTime ~= 0) then
		me.Msg("你還需等" .. tbInstancing.nPlayDrumTime .. "秒才可以繼續敲鑼");
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
		-- 播放音樂
	local szMsg 	= "setting\\audio\\obj\\ss034.wav"; 
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.CallClientScript({"PlaySound", szMsg, 3});
	end;
	GeneralProcess:StartProcess("敲鑼", 5 * Env.GAME_FPS, {self.OnPlay, self, me.nId, tbInstancing, nSubWorld}, {self.BreakPlay, self, me.nId, tbPlayList, szSound, "被打斷！"}, tbEvent);
end;

function tbLuo:BreakPlay(nPlayerId, tbPlayList, szSound, szMsg)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.Msg(szMsg);
	for _, teammate in ipairs(tbPlayList) do
		teammate.CallClientScript({"StopSound", szSound});
	end;	
end;

function tbLuo:OnPlay(nPlayerId, tbInstancing, nSubWorld)
	tbInstancing.nPlayDrumTime = 10;
	
	-- 傳送
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbPlayText[1], self.tbPlayText[2]);
		teammate.NewWorld(tbInstancing.nMapId, self.tbPlayerPos[1], self.tbPlayerPos[2]);
		teammate.SetFightState(1);
	end;
	-- 刪除幼蟲
	for i = 1, #tbInstancing.tbWenZhu do
		if (tbInstancing.tbWenZhu[i]) then
			local pNpc = KNpc.GetById(tbInstancing.tbWenZhu[i]);
			if (pNpc) then
				pNpc.Delete();
			end;
		end;
	end;
	tbInstancing.tbWenZhu = {};
	-- 重新刷出幼蟲
	for i = 1, 5 do
		for i = 1, #self.tbZhiZhuYouChongPos do
			local pYouChong = KNpc.Add2(4131, tbInstancing.nNpcLevel, -1 , nSubWorld, self.tbZhiZhuYouChongPos[i][1], self.tbZhiZhuYouChongPos[i][2]);
			assert(pYouChong);
			tbInstancing.tbWenZhu[#tbInstancing.tbWenZhu + 1] = pYouChong.dwId;
		end;
	end;
end;


-- 文珠
local tbWenZhu = Npc:GetClass("wenzhu");

tbWenZhu.tbDeathText = {"你們這些家伙，我會讓你們死的很難看。", "神蛛使"};

function tbWenZhu:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then	-- 
		return;
	end;
	
	tbInstancing.nWenZhu = tbInstancing.nWenZhu + 1;
	
	if (tbInstancing.nWenZhu % 10 == 0) then
		local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			teammate.Msg(self.tbDeathText[1], self.tbDeathText[2])
		end;
	end;
	
	if (tbInstancing.nWenZhu >= 200 and tbInstancing.nPlayDrumCount == 0) then
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Task.tbArmyCampInstancingManager:ShowTip(teammate, "現在可以打鼓了！");
			tbInstancing.nPlayDrumCount = 1;
			for i = 1, #tbInstancing.tbWenZhu do
				if (tbInstancing.tbWenZhu[i]) then
					local pNpc = KNpc.GetById(tbInstancing.tbWenZhu[i]);
					if (pNpc) then
						pNpc.Delete();
					end;
				end;
			end;
			tbInstancing.tbWenZhu = {};
		end;
	end; 
end;


-- 鼓
local tbGu = Npc:GetClass("gu");
-- 蛛母出現的位置
tbGu.tbZhuMuPos = {1976, 2851};

tbGu.tbPlayText = {"你們這是自投羅網！", "神蛛使"}
-- 敲鼓
function tbGu:OnDialog()
	local nSubWorld, _, _	= me.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	-- 是否可以打鼓
	if (tbInstancing.nWenZhu < 200) then
		me.Msg("情網大陣未破不可敲鼓！");
		return;
	end;
	-- 是否已經敲過鼓
	if (tbInstancing.nPlayGongCount ~= 0) then
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
	
	-- 播放音樂
	local szMsg 	= "setting\\audio\\obj\\ss033s.wav"; 
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.CallClientScript({"PlaySound", szMsg, 3});
	end;
	
	GeneralProcess:StartProcess("打鼓", 5 * 18, {self.OnPlay, self, me.nId, tbInstancing, nSubWorld}, {self.BreakPlay, self, me.nId, tbPlayList, szSound, "被打斷！"}, tbEvent);	
end;

function tbGu:BreakPlay(nPlayerId, tbPlayList, szSound, szMsg)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.Msg(szMsg);
	for _, teammate in ipairs(tbPlayList) do
		teammate.CallClientScript({"StopSound", szSound});
	end;	
end;

function tbGu:OnPlay(nPlayerId, tbInstancing, nSubWorld)
	-- 是否已經敲過鼓
	if (tbInstancing.nPlayGongCount ~= 0) then
		return;
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbPlayText[1], self.tbPlayText[2])
	end;
	
	tbInstancing.nPlayGongCount = 1;
	local pZhuMu = KNpc.Add2(4132, tbInstancing.nNpcLevel, -1 , nSubWorld, self.tbZhuMuPos[1], self.tbZhuMuPos[2]);
	assert(pZhuMu);
	
	pZhuMu.AddLifePObserver(99);
	pZhuMu.AddLifePObserver(90);
	pZhuMu.AddLifePObserver(70);
	pZhuMu.AddLifePObserver(50);
	pZhuMu.AddLifePObserver(30);
	pZhuMu.AddLifePObserver(10);
	
	if (tbInstancing.nLiuYiBanOutCount ~= 0) then
		local pNpc = KNpc.Add2(4155, tbInstancing.nNpcLevel, -1, nSubWorld, 1979, 2855);
		pNpc.AddLifePObserver(40);
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "神蛛使已出現");
	end;
end;

-- 蛛母
local tbZhuMu = Npc:GetClass("shenzhushi");

tbZhuMu.tbText = {
	[99] = {"看樣子老二他們都已經慘敗了是吧？", "看不出來你們小小年紀竟然會有這麼深厚的功力！"},
	[90] = {"人往高處走，水往低處流！", "不如你加入我們蠱教！", "我會傳授你練蠱的法門！"},
	[70] = {"再不撒手老娘可是要發飆了！", "小畜生當真不知好歹嗎？"},
	[50] = {"我們往日無怨，近日無仇！", "你們這又是何必呢？", "何苦跟我一個女人過不去呢？"},
	[30] = {"看情形有點不妙！", "我還是看清逃路的方向吧！"},
	[10] = {"老娘我不陪你們玩了！", "這，這不可能！"},
	[0]  = {"我太高估自己了！", "神蛛使"},

}
function tbZhuMu:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();

	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	tbInstancing.nShenZhuFengPass = 1;
	
	him.SendChat(self.tbText[0][1]);
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbText[0][1], self.tbText[0][2]);
	end;
	
	if (tbInstancing.nJinZhiShenZhuFeng) then
		local pNpc = KNpc.GetById(tbInstancing.nJinZhiShenZhuFeng);
		pNpc.Delete();
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "您可以前往靈蠍峰了！");
	end;
end;

function tbZhuMu:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	tbInstancing:NpcSay(him.dwId, self.tbText[nLifePercent]);
	
	if (nLifePercent == 10) then
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			teammate.NewWorld(tbInstancing.nMapId, 1952, 2896);
			teammate.SetFightState(1);
			Task.tbArmyCampInstancingManager:ShowTip(teammate, "神蛛使用情網大陣陷害你和你的隊友！");
		end;
	end;
end;

-- 神蛛峰指引
local tbBiWuFengZhiYin = Npc:GetClass("shenzhufengzhiyin");

tbBiWuFengZhiYin.szText = "    前面神蛛使依然聞風設下了情網大陣，等著你們自投羅網。還在此陣奧妙我已悉知，不足為懼。\n\n    破陣的關鍵是神蛛峰的那面鑼，<color=red>隻要敲響鑼，神蛛便會誤以為是要其攻擊蜂擁而出，隻要神蛛不敵而退便可敲鼓迎戰神蛛使。<color>需要注意的是，一旦鑼被敲響，所有人都會被吸入到陣法中心，此時文蛛必定蜂擁而出，一定要小心！切記！切記！\n\n    情網大陣一破，可速速<color=red>敲響神蛛使殿前的那面鼓<color>，此是神蛛使放出本命蠱害人的訊號，隻要本命蠱飛出，神蛛使並不足為懼了。";

function tbBiWuFengZhiYin:OnDialog()
	local tbOpt = {{"結束對話"}, };
	Dialog:Say(self.szText, tbOpt);
end;
