-- 文件名　：zongziexp.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-18 11:56:05
-- 描  述  ：

local tbItem = Item:GetClass("dragonboat_zongziexp")

function tbItem:OnUse()
	if me.GetTask(2064, 21) >= 100 then
		Dialog:Say("Nhiều nhất bạn chỉ có thể ăn <color=yellow>100 cái Bánh ít<color>, không thể ăn nữa.");
		return 0;
	end
	local nBase = me.GetBaseAwardExp();
	me.AddExp(nBase*60);
	me.SetTask(2064, 21, me.GetTask(2064, 21)+1);
	return 1;
end

function tbItem:GetTip()
	local szTip = "";
	local tbParam = self.tbBook;
	local nUse =  me.GetTask(2064, 21);
	szTip = szTip .. string.format("<color=green>Đã ăn %s/100 cái<color>", nUse);
	return szTip;
end

