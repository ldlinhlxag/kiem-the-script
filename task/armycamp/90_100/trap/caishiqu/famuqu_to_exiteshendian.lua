--伐木區--離開鱷神殿

local tbMap	= Map:GetClass(557);
local tbTrap_1 = tbMap:GetTrapClass("to_exiteshendian");

function tbTrap_1:OnPlayer()
	me.NewWorld(me.nMapId, 1809, 3778);
	TaskAct:StepOverEvent("離開鱷神殿");
end


