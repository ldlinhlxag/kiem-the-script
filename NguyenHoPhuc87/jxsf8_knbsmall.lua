
local KnbSmal = Item:GetClass("knbsmall");

function KnbSmal:OnUse()	
	me.AddJbCoin(95000);--9,5 vạn đồng
	me.Msg("Bạn nhận được <color=gold>9,5 vạn đồng<color>");
	return 1;
end

