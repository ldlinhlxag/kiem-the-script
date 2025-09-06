local tbNpc = Npc:GetClass("jiejing");


function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	
	local szMsg = "Đây là một lối tắt dẫn đến các mỏ sừng tê giác và bãi chế tác đá, nếu bạn hoặc đồng đội của bạn đã đến đó, Có thể đi đến đó trực tiếp thông qua lối tắt này. Tuy nhiên, phải trả 500 lượng bạc lộ phí.";
	local tbOpt = 
	{
		{"Tôi muốn đến mỏ tê giác", tbNpc.JieJing, self, 1, tbInstancing, me.nId},
		{"Tôi muốn đến bãi chế tác đá", tbNpc.JieJing, self, 2, tbInstancing, me.nId},
		{"Kết thúc đối thoại"},
	}
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:JieJing(nPosType, tbInstancing, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	if (pPlayer.nCashMoney < 500) then
		Task.tbArmyCampInstancingManager:Warring(pPlayer, "Bạn không có đủ tiền.");
		return;
	end
	
	if (nPosType == 1 and tbInstancing.nFaMuQuTrapOpen == 1) then
		assert(pPlayer.CostMoney(500, Player.emKPAY_CAMPSEND) == 1);
		pPlayer.NewWorld(tbInstancing.nMapId, 1919, 3308);	
		pPlayer.SetFightState(1);
		return;
	elseif (nPosType == 2 and tbInstancing.nCaiKuangQuPass == 1) then
		assert(pPlayer.CostMoney(500, Player.emKPAY_CAMPSEND) == 1);
		pPlayer.NewWorld(tbInstancing.nMapId, 1668,3764);
		pPlayer.SetFightState(1);
		return;
	end
	
	Task.tbArmyCampInstancingManager:Warring(pPlayer, "Chỉ có thể sử dụng lối tắt khi đã vượt qua.");
end

