local tbBinhNgocBich = Item:GetClass("binhngocbich")
function tbBinhNgocBich:OnUse()
DoScript("\\script\\item\\class\\binhngocbich.lua");
local tbItemId	= {18,1,25194,1,0,0};
me.AddExp(5000000)
me.Msg("<color=yellow>Chúc mừng bạn nhận được 5tr EXP<color>");

Task:DelItem(me, tbItemId, 1);
end