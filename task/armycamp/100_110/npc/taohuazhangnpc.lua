-----------------------------------------------------------
-- 文件名　：taohuazhangnpc.lua
-- 文件描述：桃花瘴區腳本 [鼎]
-- 創建者　：ZhangDeheng
-- 創建時間：2008-11-26 20:23:33
-----------------------------------------------------------

-- 桃花瘴區鼎
local tbNpc = Npc:GetClass("jiuningding");

tbNpc.tbNeedItemList = 
{
	{20, 1, 623, 1, 20},
}
function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nTaoHuaZhangPass == 0) then
		Dialog:Say("此鼎可制作消除毒氣傷害的解藥！",
			{
				{"【制藥】", self.Pharmacy, self, tbInstancing, me.nId},
				{"【結束對話】"}
			});
	end
end

function tbNpc:Pharmacy(tbInstancing, nPlayerId)
	Task:OnGift("放入20枚攝空草。", self.tbNeedItemList, {self.Pass, self, tbInstancing, nPlayerId}, nil, {self.CheckRepeat, self, tbInstancing}, true);
end;

function tbNpc:Pass(tbInstancing, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);	
	assert(pPlayer);
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "制藥完成, 您將不會再受到毒瘴的傷害！");
	end;
	-- 刪除桃花瘴的瘴氣
	for i = 1, 3 do 
		if (tbInstancing.tbZhangQiId[i]) then
			local pNpc = KNpc.GetById(tbInstancing.tbZhangQiId[i]);
			if (pNpc) then
				pNpc.Delete();
			end;
		end;
	end;
	
	-- 刪除禁制
	if (tbInstancing.nJinZhiTaoHuaLin) then
		local pNpc = KNpc.GetById(tbInstancing.nJinZhiTaoHuaLin);
		if (pNpc) then
			pNpc.Delete();
		end;
	end;
	-- 添加天絕使	
	local pTianJueShi = KNpc.Add2(4150, tbInstancing.nNpcLevel, -1 , tbInstancing.nMapId, 1710, 3100); -- 天絕使
	local tbTianJueShi = Npc:GetClass("tianjueshi");
	tbInstancing:NpcSay(pTianJueShi.dwId, tbTianJueShi.tbText);
	pTianJueShi.GetTempTable("Task").tbSayOver = {tbTianJueShi.SayOver, tbTianJueShi, tbInstancing, pTianJueShi.dwId, nPlayerId};
	
	-- 設置桃花瘴可以通過
	tbInstancing.nTaoHuaZhangPass = 1;
end;

function tbNpc:CheckRepeat(tbInstancing)
	if (tbInstancing.nTaoHuaZhangPass == 1) then
		return 0;
	end	
	return 1; 
end

-- 桃花瘴 天絕使
local tbTianJueShi = Npc:GetClass("tianjueshi");

tbTianJueShi.tbText = {
	"你們是誰？你們怎麼會知道進山的方法？",
	"難道？不！不可能！",
	"不好了！有人闖山了！",
}
tbTianJueShi.tbTrack = {{1704, 3095}, {1697, 3089}};

function tbTianJueShi:SayOver(tbInstancing, nNpcId, nPlayerId)
	assert(nNpcId and nPlayerId);
	local pNpc = KNpc.GetById(nNpcId);
	assert(pNpc);
	
	tbInstancing:Escort(nNpcId, nPlayerId, self.tbTrack);
	pNpc.GetTempTable("Npc").tbOnArrive = {self.OnArrive, self, nNpcId, nPlayerId};
end;

function tbTianJueShi:OnArrive(nNpcId, nPlayerId)
	assert(nNpcId and nPlayerId);
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return;
	end;
	
	pNpc.Delete();
end;

-- 桃花瘴指引
local tbTaoHusLinZhiYin = Npc:GetClass("taohualinzhiyin");

tbTaoHusLinZhiYin.szText = "    前面是百蠻山的天險桃花林，林內的桃花瘴氣人畜難過，好在我們知道了通行之法。\n\n    你需要<color=red>將桃花林特有的碧鱗蛇口中的攝空草取20株來，投入到九凝鼎內，<color>煉化出的藥氣便可以以毒攻毒將瘴氣驅散。";

function tbTaoHusLinZhiYin:OnDialog()
	local tbOpt = {{"結束對話"}, };
	Dialog:Say(self.szText, tbOpt);
end;
