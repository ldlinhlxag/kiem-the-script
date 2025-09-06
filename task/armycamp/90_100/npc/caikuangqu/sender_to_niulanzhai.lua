-- 牛欄寨
-- 上交指定數目的材料可以到下一關
local tbNpc = Npc:GetClass("qianlai");

tbNpc.tbNeedItemList = 
{
	{20, 1, 485, 1, 2},
}

function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nNiuLanZhaiPass ~= 1) then
		Dialog:Say("錢萊：“我等奉胡嘉大人之命混入牛欄寨刺探消息，有幸成為看守大門的哨兵。你既然是義軍兄弟，那就拿兩塊牛欄寨腰牌給我，這是胡大人下的命令，不然我也不能放你進入牛欄寨。”",
		{
			{"給錢萊兩個牛欄寨腰牌", self.Give, self, tbInstancing, me.nId},
			{"結束對話"}
		})
	end
end

function tbNpc:Give(tbInstancing, nPlayerId)
	Task:OnGift("交給錢萊兩塊牛欄寨腰牌便可自由出入於牛欄寨。", self.tbNeedItemList, {self.Pass, self, tbInstancing, nPlayerId}, nil, {self.CheckRepeat, self, tbInstancing});
end

function tbNpc:Send(tbInstancing)
	--me.NewWorld(tbInstancing.nMapId, 1911, 3000);
end


function tbNpc:Pass(tbInstancing, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);	
	tbInstancing.nNiuLanZhaiPass = 1;
	local pNpc = KNpc.GetById(tbInstancing.nNiuLanZhaiLaoMenId);
	if (pNpc) then
		pNpc.Delete();
	end
	
	if (pPlayer) then
		Task.tbArmyCampInstancingManager:ShowTip(pPlayer, "我現在可以放心的去牛欄寨了");
	end
end

function tbNpc:CheckRepeat(tbInstancing)
	if (tbInstancing.nNiuLanZhaiPass == 1) then
		return 0;
	end
	
	return 1; 
end
