-- 上交指定數目的材料可以到下一關
local tbNpc = Npc:GetClass("caikuangqudoorsill");

tbNpc.tbNeedItemList = 
{
	{20, 1, 604, 1, 3},
	{20, 1, 605, 1, 3},
}

function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nCaiKuangQuPass == 1) then
		Dialog:Say("船已修好，可以坐船前往亂石灘。",
		{
			{"坐船前往亂石灘", self.Send, self, tbInstancing, me.nId},
			{"結束對話"}
		})
	else
	Dialog:Say("這艘船破敗不堪，需用三條麻繩和三塊木板加固方可使用。",
		{
			{"修復舊船", self.Fix, self, tbInstancing, me.nId},
			{"結束對話"}
		})
	end
end

function tbNpc:Fix(tbInstancing, nPlayerId)
	Task:OnGift("船已經破損，需要放入三條麻繩，三塊木板將其修復才可使用。", self.tbNeedItemList, {self.PassCaiKuangQu, self, tbInstancing, nPlayerId}, nil, {self.CheckRepeat, self, tbInstancing});
end

function tbNpc:Send(tbInstancing)
	me.NewWorld(tbInstancing.nMapId, 1668, 3764);
end


function tbNpc:PassCaiKuangQu(tbInstancing, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);	
	tbInstancing.nCaiKuangQuPass = 1;
	if (pPlayer) then
		Task.tbArmyCampInstancingManager:ShowTip(pPlayer, "舊船已經被修好");
	end
end

function tbNpc:CheckRepeat(tbInstancing)
	if (tbInstancing.nCaiKuangQuPass == 1) then
		return 0;
	end
	
	return 1; 
end
