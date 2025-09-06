-----------------------------------------------------------
-- 文件名　：taohuashi.lua
-- 文件描述：對話桃花使及戰斗桃花使
-- 創建者　：ZhangDeheng
-- 創建時間：2008-11-26 17:26:10
-----------------------------------------------------------

-- 戰斗桃花使
local tbTaoHuaShi_Fight = Npc:GetClass("taohuashifight");

tbTaoHuaShi_Fight.tbText = {
	[70] = {"看樣子你們是有備而來的！", "不過爺爺我可不是吃素的！", "讓你們瞧瞧我的厲害吧！"},
	[50] = {"我覺得有些緊張！", "我們坐下來談談怎麼樣？", "別那麼固執好不好？"},
	[20] = {"都是出來混的，給點面子吧！", "大家都不容易啊！", "我們停手好不好？"},
	[10] = {"好小子！軟硬不吃是吧？", "算你狠咱們走著瞧！"},
	[0]  = {"我真的沒想到……"},
}
-- 死亡時執行
function tbTaoHuaShi_Fight:OnDeath(pNpc)
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	him.SendChat(self.tbText[0][1]);
	
	tbInstancing.nTaoHuaShiPass = 1;
	if (not tbInstancing.nJinZhiTaoHuaLin) then
		return;
	end;
	
	local pNpc = KNpc.GetById(tbInstancing.nJinZhiTaoHuaShi);
	if (pNpc) then
		pNpc.Delete();
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "您可以前往碧蜈峰了！");
	end;
end;

-- 血量在一定的時候執行
function tbTaoHuaShi_Fight:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	tbInstancing:NpcSay(him.dwId, self.tbText[nLifePercent]);
end;

-- 對話桃花使
local tbTaoHuaShi_Dialog = Npc:GetClass("taohuashidialog");

tbTaoHuaShi_Dialog.tbText = {
	"來吧！來吧！我都等的不耐煩了！",
	"你們真以為你們可以闖過我這個山頭嗎？",
	"在你們之前已經有無數人嘗試過了！",
}
-- 對話
function tbTaoHuaShi_Dialog:OnDialog()
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (tbInstancing.nTaoHuaShiOut ~= 0) then
		return;
	end;
	
	local szMsg = string.format("%s：來吧！來吧！我都等的不耐煩了！", him.szName);
	local tbOpt = {
		{"開始戰斗", self.Fight, self, me.nId, him.dwId},
		{"結束對話"},
	}
	Dialog:Say(szMsg, tbOpt);
end;

-- 對話轉戰斗
function tbTaoHuaShi_Dialog:Fight(nPlayerId, nNpcId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local pNpc = KNpc.GetById(nNpcId);
	if (not pPlayer or not pNpc) then
		return;
	end;
	
	local nSubWorld, nNpcPosX, nNpcPosY = pNpc.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	if (tbInstancing.nTaoHuaShiOut ~= 0) then
		return;
	end
	-- 戰斗桃花使
	local pTaoHuaShi = KNpc.Add2(4171, tbInstancing.nNpcLevel, -1 , nSubWorld, nNpcPosX, nNpcPosY);
	assert(pTaoHuaShi);
	tbInstancing:NpcSay(pTaoHuaShi.dwId, self.tbText);
	
	pTaoHuaShi.AddLifePObserver(70);
	pTaoHuaShi.AddLifePObserver(50);
	pTaoHuaShi.AddLifePObserver(20);
	pTaoHuaShi.AddLifePObserver(10);
	
	tbInstancing.nTaoHuaShiOut = 1;
	pNpc.Delete();
end;

