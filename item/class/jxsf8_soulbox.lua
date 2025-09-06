local tbZhenzhus = Item:GetClass("jxsf8_soulbox");

function tbZhenzhus:OnUse()
	--DoScript("\\script\\item\\class\\jxsf8_soulbox.lua");
	local szMsg = "Đặt vào đã nghe âm khí vây quanh, chúng sinh lầm than cơ cực.";
	local tbOpt = {
		{"Ta muốn tích lũy linh hồn", self.tuluyen, self, it},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbZhenzhus:tuluyen(pThisItem)
	if pThisItem.nCount > 1 then
		pThisItem.SetCount(pThisItem.nCount-1);
	else
		me.DelItem(pThisItem);
	end
	local lhcu = me.GetTask(2123,1);
	--local lhmoi = lhcu + 100000000;
	local lhmoi = lhcu + 10000; --Open
	me.SetTask(2123,1,lhmoi);
	--me.Msg(string.format("Ngươi vừa tích lũy được thêm <color=gold> 100000000 <color> linh hồn"));
	me.Msg(string.format("Ngươi vừa tích lũy được thêm <color=gold> 10000 <color> linh hồn"));--OPEN
end
