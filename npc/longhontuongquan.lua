local tbTuongQuanLH = Npc:GetClass("longhontuongquan");
function tbTuongQuanLH:OnDialog()
local szMsg = "<color=orange>Ngươi muốn gì ?<color> \nChú ý : <color=yellow>LHĐ<color> = Long Hồn Đơn"; 
local tbOpt = { 
{"Shop <color=yellow>Long Hồn<color>", self.ShopLongHon11, self},
{"10 <color=yellow>Nội Tạng<color> = 1 LHĐ", self.ShopLongHon, self},
{"<color=yellow>Long Hồn Lệnh Bài<color> đổi 200 LHĐ", self.LongHonLB, self},
{"Ngũ Sắc Bảo Thạch + 1 Bí Kíp = 300 LHĐ", self.LongHonNSBT, self},
}; 
Dialog:Say(szMsg, tbOpt); 
end
function tbTuongQuanLH:LongHonNSBT()
if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải Có 5 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,25286,1,0,0};
local tbItemId2	= {18,1,25287,1,0,0};
local tbItemId3	= {18,1,25288,1,0,0};
local tbItemId4	= {18,1,25289,1,0,0};
local tbItemId5	= {18,1,25290,1,0,0};
local tbItemId6	= {18,1,25291,1,0,0};
local nCount1 = me.GetItemCountInBags(18,1,25286,1)
local nCount2 = me.GetItemCountInBags(18,1,25287,1)
local nCount3 = me.GetItemCountInBags(18,1,25288,1)
local nCount4 = me.GetItemCountInBags(18,1,25289,1)
local nCount5 = me.GetItemCountInBags(18,1,25290,1)
local nCount6 = me.GetItemCountInBags(18,1,25291,1)
if nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 or nCount5 < 200 or nCount6 < 1 then
Dialog:Say("Đổi 200 LHĐ cần \n Ngũ Sắc Bảo Thạch mỗi loại 200 viên \n 1 Bí Kíp Hợp Thành Bảo Thạch")
return
end

me.AddStackItem(18,1,25292,1,nil,300)
Task:DelItem(me, tbItemId1, 200);
Task:DelItem(me, tbItemId2, 200);
Task:DelItem(me, tbItemId3, 200);
Task:DelItem(me, tbItemId4, 200);
Task:DelItem(me, tbItemId5, 200);
Task:DelItem(me, tbItemId6, 1);
end
function tbTuongQuanLH:LongHonLB()
if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải Có 5 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,25293,1,0,0};
local nCount1 = me.GetItemCountInBags(18,1,25293,1)
if nCount1 < 1 then
Dialog:Say("Không có Long Hồn Lệnh Bài")
return
end
Task:DelItem(me, tbItemId1, 1);
me.AddStackItem(18,1,25292,1,nil,200)
end
function tbTuongQuanLH:ShopLongHon11()
me.OpenShop(200,1)
end
function tbTuongQuanLH:ShopLongHon()
if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải Có 5 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,25284,1,0,0};
local nCount1 = me.GetItemCountInBags(18,1,25284,1)
if nCount1 < 10 then
Dialog:Say("10 Nội Tạng mới đổi được 1 Long Hồn Đơn")
return
end
me.AddItem(18,1,25292,1)
Task:DelItem(me, tbItemId1, 10);
end