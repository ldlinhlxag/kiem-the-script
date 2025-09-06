-- 傳送去蠻瘴山的Npc

-- 上交指定數目的材料可以到下一關
local tbNpc = Npc:GetClass("yundadao");

tbNpc.tbNeedItemList = 
{
	{20, 1, 487, 1, 2},
}

function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nManZhangShanPass == 1) then
		Dialog:Say("是否這就去蠻瘴山。",
		{
			{"前往蠻瘴山", self.Send, self, tbInstancing, me.nId},
			{"Kết thúc đối thoại"}
		})
	else
	Dialog:Say("雲大刀：“此番我等兄弟幾人前來蠻瘴山尋寶，費了好大力氣才和這裡的蠻人套好交情。你若想進蠻瘴山，我可以幫忙。不過我們快刀門以利當先，你要先給我找來兩個骨玉圖騰才行。”",
		{
			{"給雲大刀兩個骨玉圖騰", self.Give, self, tbInstancing, me.nId},
			{"Kết thúc đối thoại"}
		})
	end
end

function tbNpc:Give(tbInstancing, nPlayerId)
	Task:OnGift("交給雲大刀兩個骨玉圖騰便可在他的帶領下進入蠻瘴山。", self.tbNeedItemList, {self.Pass, self, tbInstancing, nPlayerId}, nil, {self.CheckRepeat, self, tbInstancing});
end

function tbNpc:Send(tbInstancing)
	me.NewWorld(tbInstancing.nMapId, 1911, 3000);
end


function tbNpc:Pass(tbInstancing, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);	
	tbInstancing.nManZhangShanPass = 1;
	if (pPlayer) then
		Task.tbArmyCampInstancingManager:ShowTip(pPlayer, "我現在放心的去蠻瘴山了");
	end
end

function tbNpc:CheckRepeat(tbInstancing)
	if (tbInstancing.nManZhangShanPass == 1) then
		return 0;
	end
	
	return 1; 
end
