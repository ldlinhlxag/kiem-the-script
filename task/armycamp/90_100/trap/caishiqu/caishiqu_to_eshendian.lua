--伐木區--蠻瘴山

local tbMap	= Map:GetClass(557);
local tbTrap_1 = tbMap:GetTrapClass("to_eshendian");

function tbTrap_1:OnPlayer()
	me.NewWorld(me.nMapId, 1807, 3773);
	TaskAct:StepOverEvent("請找雲小刀帶路進入鱷神殿");
end


