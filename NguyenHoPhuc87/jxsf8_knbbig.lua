
local KnbBiz = Item:GetClass("knbbig");

function KnbBiz:OnUse()	
	me.AddJbCoin(950000);--95v đồng
	me.Msg("Bạn nhận được <color=gold>95 vạn đồng<color>");
	return 1;
end

