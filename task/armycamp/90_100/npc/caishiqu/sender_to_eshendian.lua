-- 傳送去鱷神殿的Npc

-- 上交指定數目的材料可以到下一關
local tbNpc = Npc:GetClass("yunxiaodao");

tbNpc.tbNeedItemList = 
{
	{20, 1, 486, 1, 2},
}

function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nEShenDianPass == 1) then
		Dialog:Say("是否這就去鱷神殿。",
		{
			{"前往鱷神殿", self.Send, self, tbInstancing, me.nId},
			{"結束對話"}
		})
	else
	Dialog:Say("雲小刀：“真是奇哉怪也，這裡竟然會留下這麼一座上古的鱷神殿，這裡面一定有什麼秘密。我等兄弟費了好大力氣才打開了神殿入口，你若是想進入，就拿兩把迷宮鑰匙給我，就算是個辛苦錢吧！”",
		{
			{"給雲小刀兩把迷宮鑰匙", self.Give, self, tbInstancing, me.nId},
			{"結束對話"}
		})
	end
end

function tbNpc:Give(tbInstancing, nPlayerId)
	Task:OnGift("交給雲小刀兩把迷宮鑰匙便可在他的帶領下進入鱷神殿", self.tbNeedItemList, {self.Pass, self, tbInstancing, nPlayerId}, nil, {self.CheckRepeat, self, tbInstancing});
end

function tbNpc:Send(tbInstancing)
	me.NewWorld(tbInstancing.nMapId, 1819, 3941);
end


function tbNpc:Pass(tbInstancing, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);	
	tbInstancing.nEShenDianPass = 1;
	if (pPlayer) then
		Task.tbArmyCampInstancingManager:ShowTip(pPlayer, "我現在放心的去鱷神殿了");
	end
end

function tbNpc:CheckRepeat(tbInstancing)
	if (tbInstancing.nEShenDianPass == 1) then
		return 0;
	end
	
	return 1; 
end
