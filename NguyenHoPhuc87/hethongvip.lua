local tbItem = Npc:GetClass("hethongvip");
tbItem.tbItemInfo = {bForceBind=1,};
local REQUIRE_ITEM = 
{ 
	[1] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 5},	--5 tiểu KNB
	},			
	[2] = {
		{{string.format("%s,%s,%s,%s", 18, 10, 11, 2),}, 15},	--15 Tiền Xu
	},
};

function tbItem:OnDialog()
end

function tbItem:DangKyVip()
if me.CountFreeBagCell() < 15 then
		Dialog:Say("Phải Có 15 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
	DoScript("\\script\\npc\\liguan.lua");
	local szMsg	= "<color=gold>Hệ thống Vip<color>\n<color=yellow>Giá Vip<color>: <color=green>2 Tiền Xu/1 Ngày<color>\n<color=yellow>Phần Thưởng Mua VIP<color>:\nDanh Hiệu <color=pink>Xưng Bá Nhất Phương<color>\n1 <color=green>[THK] Thẻ V.I.P<color> (<color=red>Có hạn sử dụng<color>)";
	local tbOpt = {
		{"Mua <color=green>[THK] Thẻ V.I.P<color>", self.DangKyNhomVip, self},--OK
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:DangKyNhomVip()
local nCount = me.GetItemCountInBags(18,10,11,2)
local msg = "<color=red>Chú ý:<color> <color=yellow>Giá Vip<color>: <color=green>2 Tiền Xu/1 Ngày<color>\n<color=yellow>Số Tiền Xu Hiện Có <color=cyan>"..nCount.." Tiền Xu"
local tbOpt = {
{"Bạn Muốn Mua Bao Nhiêu Ngày ?",self.MuaLenhBaiVIPHoiNgay,self}
};
Dialog:Say(msg,tbOpt)
end
function tbItem:MuaLenhBaiVIPHoiNgay()
Dialog:AskNumber("Nhập Số Ngày",30,self.NhapNgay,self, nSoNgay);
end
function tbItem:NhapNgay(nSoNgay)
if nSoNgay == 0 then
Dialog:Say("<color=red>Chú Ý<color> số ngày mua > 1 ngày")
return
end
local nCount = me.GetItemCountInBags(18,10,11,2)
local msg = "Bạn muốn mua VIP <color=green>"..nSoNgay.." ngày<color>\n"..
"Số Tiền Xu cần trả là : <color=cyan>".. (nSoNgay*2) .." Tiền Xu<color>\n"..
"Số Tiền Xu hiện có là : <color=cyan>".. nCount .." Tiền Xu<color>"
if nCount < nSoNgay*2 then
local tbOpt = {
{"<color=red>Chú Ý<color> không đủ <color=green>Tiền Xu<color>"}
};
Dialog:Say(msg,tbOpt)
return
end
local tbOpt = {
{"Đồng ý trả <color=green>".. (nSoNgay*2) .."<color> Tiền Xu",self.XacNhanMuaLBVIP,self,nSoNgay}
};
Dialog:Say(msg,tbOpt)
end
function tbItem:XacNhanMuaLBVIP(nSoNgay)
local tbItemId1	= {18,10,11,2,0,0}; -- 
if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải Có 5 Ô Trống Trong Túi Hành Trang!");
		return 0;
end
local tbTimeOut = nSoNgay*24*60;	--3 ngày
local pItem1 = me.AddItem(18,1,25297,1);	-- LB VIP
me.AddTitle(17,1,1,1)
me.SetItemTimeout(pItem1, tbTimeOut, 0);
pItem1.Bind(1);
Task:DelItem(me, tbItemId1, nSoNgay*2);
me.Msg("<color=yellow>Mua thành công <color=cyan>V.I.P "..nSoNgay.."<color>. Tiêu hao <color=green>".. (nSoNgay*2) .."<color> Tiền Xu<color>")
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>Chúc mừng người chơi <color=cyan>"..me.szName.."<color> trở thành VIP <color=cyan>"..nSoNgay.."<color> ngày<color>\n <color=yellow><color=cyan>"..me.szName.."<color> tiêu hao <color=green>".. (nSoNgay*2) .." Tiền Xu"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Chúc mừng người chơi <color=cyan>"..me.szName.."<color> trở thành VIP <color=cyan>"..nSoNgay.."<color> ngày<color>\n<color=yellow><color=cyan>"..me.szName.."<color> tiêu hao <color=green>".. (nSoNgay*2) .." Tiền Xu");
KDialog.MsgToGlobal("<color=yellow>Chúc mừng người chơi <color=cyan>"..me.szName.."<color> trở thành VIP <color=cyan>"..nSoNgay.."<color> ngày<color>\n<color=yellow><color=cyan>"..me.szName.."<color> tiêu hao <color=green>".. (nSoNgay*2) .." Tiền Xu");	
end
