----------------------------------------
-- 百斬吉
-- ZhangDeheng
-- 2008/10/29  8:41
----------------------------------------

local tbBaiZhanJi_Fight = Npc:GetClass("fnsbaizhanjifight");

tbBaiZhanJi_Fight.BOXID	= 4113; --打死BOSS後掉落寶箱的ID
-- 用於記錄血量在一定的時候的話是否說了
tbBaiZhanJi_Fight.tbLifePercentSay =
{
	[100] = false,
	[90]  = false,
	[49]  = false,
	[9]   = false,
}

-- 每隔一定時間說的話
tbBaiZhanJi_Fight.tbOnTimerSayText = 
{
	[100] = {
		"我們家養的都是名貴的坑多�夫撕雞。",
		"來，溫隻雞！",
		"總覺得有什麼事情沒辦，但是又想不起來……",
	},
	[90] = {
		"再來！再來！我們再玩玩！",
		"看來，要吃幾口雞肉補補了！停手！",
		"來人哪，給我點啃得雞補充些內力！",
	},
	[49] = {
		"我要把你們打得雞毛亂飛！",
		"你說什麼？你確定你是在向我求饒嗎？",
		"你跑不了了，小雞們！",
	},
	[9]  = {
		"轉移敵人注意力！看~灰雞！！",
		"我現在開始體會到被我吃掉的雞的感覺了！",
		"滾開！",
	}, 
}

-- 血量在一定的時候說的話
tbBaiZhanJi_Fight.tbOnLifeSayText = 
{
	[100] = "你們竟然敢來我的地盤撒野？看我老鷹抓小雞！",
	[90]  = "哎呦好痛，轉移敵人注意力！看~灰雞！！",
	[49]  = "肌肉有點酸啊。",
	[9]   = "我……我……！",
}

-- 死亡時執行
function tbBaiZhanJi_Fight:OnDeath(pNpc)
	Task.tbToBeDelNpc[him.dwId] = 0;
	local nSubWorld, nNpcPosX, nNpcPosY = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	if (tbInstancing.nBzhjTimerId and tbInstancing.nBzhjTimerId > 0) then
		Timer:Close(tbInstancing.nBzhjTimerId);
		tbInstancing.nBzhjTimerId = nil;
	end
	
	-- 掉一個寶箱
	local pBaoXiang = KNpc.Add2(self.BOXID, 1, -1, nSubWorld, nNpcPosX, nNpcPosY);
	assert(pBaoXiang)

	local pPlayer  	= pNpc.GetPlayer();
	pBaoXiang.GetTempTable("Task").nOwnerPlayerId = pPlayer.nId;
	pBaoXiang.GetTempTable("Task").CUR_LOCK_COUNT = 0;
end;

-- 每幀執行一次
function tbBaiZhanJi_Fight:OnBreath(nId)
	local pNpc = KNpc.GetById(nId);
	local nSubWorld, _, _ = pNpc.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	
	assert(tbInstancing);
	
	if not tbInstancing.nBaiZhanJiCurSec then
		tbInstancing.nBaiZhanJiCurSec = 1;
	else
		tbInstancing.nBaiZhanJiCurSec = tbInstancing.nBaiZhanJiCurSec + 1;
	end
	
	-- 血量在100%的時候每隔20秒說一次話
	if (self:OnTimerSay(nId, 100, 100, 20)) then
		return;
	-- 血量在90% - 50% 的時候每隔10秒說一次話	
	elseif (self:OnTimerSay(nId, 90, 50, 10)) then
		return;
	-- 血量在49% - 10% 的時候每隔10秒說一次話
	elseif (self:OnTimerSay(nId, 49, 10, 10)) then
		return;
	-- 血量在9% - 0% 的時候每隔10秒說一次話
	elseif (self:OnTimerSay(nId, 9, 0, 10)) then
		return;
	-- 在血量低於9的時候說一句話
	elseif (self:OnLifePercentSay(nId, 9)) then
		return;	
	-- 在血量低於49的時候說一句話
	elseif (self:OnLifePercentSay(nId, 49)) then
		return;	
	-- 在血量低於90的時候說一句話
	elseif (self:OnLifePercentSay(nId, 90)) then
		return;	
	-- 在被攻擊的時候說一句話
	elseif (self:OnLifePercentSay(nId, 100)) then
		return;
	end;
end

-- 當血量在一定百分比的時候說話
function tbBaiZhanJi_Fight:OnLifePercentSay(nId, nLifePercent)
	local pNpc = KNpc.GetById(nId);
	assert(pNpc);
	local nSubWorld, _, _ = pNpc.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	local nPercent = (pNpc.nCurLife / pNpc.nMaxLife) * 100;
	if (nPercent < nLifePercent and not self.tbLifePercentSay[nLifePercent]) then
		pNpc.SendChat(self.tbOnLifeSayText[nLifePercent]);
		self.tbLifePercentSay[nLifePercent] = true;
		tbInstancing.nBaiZhanJiCurSec = 0;
		return true;
	else 
		return false;
	end;
end;

-- 當血量在一定范圍內 每隔一定時間說一次話
function tbBaiZhanJi_Fight:OnTimerSay(nId, nLifeMax, nLifeMin, nTime)
	local pNpc = KNpc.GetById(nId);
	assert(pNpc);
	local nSubWorld, _, _ = pNpc.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	local nPercent = (pNpc.nCurLife / pNpc.nMaxLife) * 100;
	if (nPercent <= nLifeMax and nLifeMin <= nPercent and tbInstancing.nBaiZhanJiCurSec % nTime == 0) then
		local nTextId = MathRandom(#self.tbOnTimerSayText[nLifeMax]);
		pNpc.SendChat(self.tbOnTimerSayText[nLifeMax][nTextId]);
		tbInstancing.nBaiZhanJiCurSec = 0;
		return true;
	else 
		return false;	
	end;	
end;

-- 對話百斬吉
local tbBaiZhanJi_Dialog = Npc:GetClass("fnsbaizhanjidialog");

function tbBaiZhanJi_Dialog:OnDialog()
	local tbPlayerTask = Task:GetPlayerTask(me) --獲得玩家的任務
	local tbOpt = {};
	local szMsg = string.format("%s：走開走開，我最討厭你們這些小厮！", him.szName);
	
	local tbTask = tbPlayerTask.tbTasks[0x122];
	
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	
	if (tbTask and tbTask.nSubTaskId == 0x1D1 and tbTask.nCurStep == 4 and tbInstancing.BAIZHANJI_IS_OUT == 0) then
		szMsg = string.format("%s：你是誰？你是怎麼混進來的？", him.szName);
		tbOpt[#tbOpt + 1] = {"【開始戰斗】", self.Fight, self, me.nId, him.dwId};
	end
	
	local tbTask = tbPlayerTask.tbTasks[0x12E];
	if (tbTask and tbTask.nSubTaskId == 0x1DD and tbTask.nCurStep == 4 and tbInstancing.BAIZHANJI_IS_OUT == 0) then
		szMsg = string.format("%s：你是誰？你是怎麼混進來的？", him.szName);
		tbOpt[#tbOpt + 1] = {"【開始戰斗】", self.Fight, self, me.nId, him.dwId};
	end

	tbOpt[#tbOpt+1]	= {"【結束對話】"};
	Dialog:Say(szMsg, tbOpt);
end

function tbBaiZhanJi_Dialog:Fight(nPlayerId,nNpcId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local pNpc = KNpc.GetById(nNpcId);
	if (not pPlayer or not pNpc) then
		return;
	end;
	
	local nSubWorld, nNpcPosX, nNpcPosY = pNpc.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	if (tbInstancing.BAIZHANJI_IS_OUT ~= 0) then
		return;
	end
	local pBaiZhanJi = KNpc.Add2(4111, tbInstancing.nNpcLevel, -1 , nSubWorld, nNpcPosX, nNpcPosY);
	assert(pBaiZhanJi);
	Task.tbToBeDelNpc[pBaiZhanJi.dwId] = 1;
	
	tbInstancing.nBaiZhanJiCurSec = 0;
	tbInstancing.BAIZHANJI_IS_OUT = 1;
	local tbNpc = Npc:GetClass("fnsbaizhanjifight");

	tbInstancing.nBzhjTimerId = Timer:Register(Env.GAME_FPS, tbNpc.OnBreath, tbNpc, pBaiZhanJi.dwId);
	tbInstancing.nFnsBaiZhanJiId = pBaiZhanJi.dwId;
	
	KTeam.Msg2Team(pPlayer.nTeamId, "<color=yellow>和百斬吉的戰斗已經開始<color>！");
	pNpc.Delete();
end

		
