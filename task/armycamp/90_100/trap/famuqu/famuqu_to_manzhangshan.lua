--伐木區--蠻瘴山

local tbMap	= Map:GetClass(557);
local tbTrap_1 = tbMap:GetTrapClass("to_manzhangshan");

function tbTrap_1:OnPlayer()
	me.NewWorld(me.nMapId, 1831, 3080);
	TaskAct:StepOverEvent("請找雲大刀帶路進入蠻瘴山");
end


