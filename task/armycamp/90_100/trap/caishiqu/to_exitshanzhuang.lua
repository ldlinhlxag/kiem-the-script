--伐木區--離開鱷神殿

local tbMap	= Map:GetClass(557);
local tbTrap_1 = tbMap:GetTrapClass("to_exitshanzhuang");

function tbTrap_1:OnPlayer()
	me.NewWorld(me.nMapId, 1630, 3638);
	me.SetFightState(0);
	TaskAct:StepOverEvent("離開伏牛山庄舊址");
end


