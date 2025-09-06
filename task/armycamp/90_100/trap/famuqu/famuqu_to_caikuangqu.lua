-- 伐木區到採礦區
local tbMap	= Map:GetClass(557);
local tbTrap_1 = tbMap:GetTrapClass("to_caikuanqu");

function tbTrap_1:OnPlayer()
	local nSubWorld, _, _	= me.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nFaMuQuTrapOpen ~= 1) then
		me.NewWorld(me.nMapId, 1842, 3399);
		Task.tbArmyCampInstancingManager:ShowTip(me, "需要先殺死守礦的嘍羅頭目才可進入");
	else
		me.NewWorld(me.nMapId, 1913,3316);
		Task.tbArmyCampInstancingManager:ShowTip(me, "進入犀角礦");
	end
end
