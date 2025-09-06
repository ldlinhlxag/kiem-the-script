-------------------------------------------------------------------
--File: tuiguangyuan.lua
--Author: kenmaster
--Date: 2008-06-04 03:00
--Describe: ��ƹ�Աnpc�ű�
-------------------------------------------------------------------
local tbTuiGuangYuan = Npc:GetClass("tuiguangyuan");
tbTuiGuangYuan.TaskGourp = 3026;
tbTuiGuangYuan.TaskGourp1 = 3028;
tbTuiGuangYuan.TaskId_TanThu = 1;
tbTuiGuangYuan.tbItemInfo = {bForceBind=1,};
function tbTuiGuangYuan:OnDialog()
	DoScript("\\script\\npc\\tuiguangyuan.lua");
	local tbOpt = 
	{
		{"<color=yellow>Nhận <color=cyan>Tiền Xu<color> Nạp Thẻ<color>", self.dnnhandong, self},
		{"<color=yellow>Đổi <color=cyan>Tiền Xu<color> ra Đồng<color>", self.DoiDTV1, self},
		{"Nhận Thưởng <color=yellow>GiftCode<color>", self.NhanThuongGift_THK, self},
		-- {"Mua đại Kim Nguyên Bảo (100v Đồng)", self.MuaKNB, self, 1},
		-- {"Mua tiểu Kim Nguyên Bảo (10v Đồng)", self.MuaKNB, self, 2},
		-- {"<color=green>Nhận Danh Hiệu Nữ 20/10<color>", self.danhhieu, self},
		-- {"<color=green>Nhận Hoa Hồng Thiên Tuyệt Kiếm<color>", self.nhanhoahong, self},
		--{"<color=red>Đổi Hoa Hồng - Nữ<color>", self.doihoahongnu, self},
		-- {"<color=red>Đổi Hoa Hồng - Mọi Người<color>", self.doihoahongall, self},
   		{"Kết Thúc Đối Thoại"}
	}
	Dialog:Say("Nhân Chi Sơ, Tính Bổn Thiện. Chúc bạn một ngày tốt lành",tbOpt);
end
function tbTuiGuangYuan:NhanThuongGift_THK()
-- if me.szName ~= "TuHoiKiem" then
-- return
-- end
self:TestThuGiftCOde()
end
function tbTuiGuangYuan:TestThuGiftCOde()
local msg = "           <pic=120><color=red>Phần thưởng GiftCode<color><pic=120>\n"..
"\nNhận <color=green>1 Đá Cường Hóa +16<color>\n"..
"Nhận <color=green>2000 Ngũ Hành Hồn Thạch<color>\n"..
"Nhận <color=green>10 Tinh Thạch Thánh Hỏa<color>\n"..
"Nhận <color=green>20 Chân Nguyên Tu Luyện Đơn<color>\n"..
"Nhận <color=green>20 Thánh Linh Bảo Hạp Hồn<color>\n"..
"Nhận <color=green>4 Huyền Tinh (Cấp 8)<color>\n"..
"Nhận <color=green>2 Huyền Tinh (Cấp 9)<color>"
local tbOpt = 
	{
{"Tra <color=yellow>Danh Sách<color>", self.TestThuGiftCOde_OK, self},
}
	Dialog:Say(msg,tbOpt);
end
function tbTuiGuangYuan:TestThuGiftCOde_OK()
if me.CountFreeBagCell() < 20 then
		Dialog:Say("Phải Có 20 Ô Trống Trong Túi Hành Trang!");
		return 0;
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
if nCount >= 1 then
Dialog:Say("Ngươi đã nhận thưởng GiftCode rồi !")
return
end
local msg = "<color=yellow>Danh Sách Nhân Vật Nhận GiftCode<color>"
	local tbOpt = 
	{
{"Nhân Sĩ <color=green>ThoạiNguyễn<color>", self.GiftTest_ThoaiNguyen, self},
{"Nhân Sĩ <color=green>TiểuThư<color>", self.GiftTest_TieuThu, self},
{"Nhân Sĩ <color=green>LệnhHồXung<color>", self.GiftTest_LenhHoXung, self},
{"Nhân Sĩ <color=green>CooLạnh<color>", self.GiftTest_CooLanh, self},
{"Nhân Sĩ <color=green>LáoLàBem<color>", self.GiftTest_LaoLaBem, self},
{"Nhân Sĩ <color=green>BạchHổ<color>", self.GiftTest_BachHo, self},
{"Nhân Sĩ <color=green>asdasdasd<color>", self.GiftTest_asdasdasd, self},
{"Nhân Sĩ <color=green>TesterGame8<color>", self.GiftTest_TesterGame8, self},
{"Nhân Sĩ <color=green>TesterGame9<color>", self.GiftTest_TesterGame9, self},
{"Nhân Sĩ <color=green>TesterGame10<color>", self.GiftTest_TesterGame10, self},
{">>> <color=pink>Trang Kế<color>", self.TrangTiepTheo, self}
	}
	Dialog:Say(msg,tbOpt);
end
function tbTuiGuangYuan:GiftTest_ThoaiNguyen()
if me.szName ~= "ThoạiNguyễn" then
Dialog:Say("\nNgươi không phải <color=green>ThoạiNguyễn<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_ThoaiNguyen_OK, self);
end
function tbTuiGuangYuan:GiftTest_ThoaiNguyen_OK(TuHoiKiem_ThoaiNguyen)
if TuHoiKiem_ThoaiNguyen ~= "THK0015801" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
-----------
function tbTuiGuangYuan:GiftTest_TieuThu()
if me.szName ~= "TiểuThư" then
Dialog:Say("\nNgươi không phải <color=green>TiểuThư<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_TieuThu_OK, self);
end
function tbTuiGuangYuan:GiftTest_TieuThu_OK(TuHoiKiem_TieuThu)
if TuHoiKiem_TieuThu ~= "THK0015802" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
----------------
function tbTuiGuangYuan:GiftTest_LenhHoXung()
if me.szName ~= "LệnhHồXung" then
Dialog:Say("\nNgươi không phải <color=green>LệnhHồXung<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_LenhHoXung_OK, self);
end
function tbTuiGuangYuan:GiftTest_LenhHoXung_OK(TuHoiKiem_LenhHoXung)
if TuHoiKiem_LenhHoXung ~= "THK0015803" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
--------------------
function tbTuiGuangYuan:GiftTest_CooLanh()
if me.szName ~= "CooLạnh" then
Dialog:Say("\nNgươi không phải <color=green>CooLạnh<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_CooLanh_OK, self);
end
function tbTuiGuangYuan:GiftTest_CooLanh_OK(TuHoiKiem_CooLanh)
if TuHoiKiem_CooLanh ~= "THK0015804" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
--------------
function tbTuiGuangYuan:GiftTest_LaoLaBem()
if me.szName ~= "LáoLàBem" then
Dialog:Say("\nNgươi không phải <color=green>LáoLàBem<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_LaoLaBem_OK, self);
end
function tbTuiGuangYuan:GiftTest_LaoLaBem_OK(TuHoiKiem_LaoLaBem)
if TuHoiKiem_LaoLaBem ~= "THK0015805" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
--------------
function tbTuiGuangYuan:GiftTest_BachHo()
if me.szName ~= "BạchHổ" then
Dialog:Say("\nNgươi không phải <color=green>BạchHổ<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_BachHo_OK, self);
end
function tbTuiGuangYuan:GiftTest_BachHo_OK(TuHoiKiem_BachHo)
if TuHoiKiem_BachHo ~= "THK0015806" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
--------------
function tbTuiGuangYuan:GiftTest_asdasdasd()
if me.szName ~= "asdasdasd" then
Dialog:Say("\nNgươi không phải <color=green>asdasdasd<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_asdasdasd_OK, self);
end
function tbTuiGuangYuan:GiftTest_asdasdasd_OK(TuHoiKiem_asdasdasd)
if TuHoiKiem_asdasdasd ~= "THK0015807" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
-----------------
function tbTuiGuangYuan:GiftTest_TesterGame8()
if me.szName ~= "TesterGame8" then
Dialog:Say("\nNgươi không phải <color=green>TesterGame8<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_TesterGame8_OK, self);
end
function tbTuiGuangYuan:GiftTest_TesterGame8_OK(TuHoiKiem_TesterGame8)
if TuHoiKiem_TesterGame8 ~= "THK0015808" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
-------------------
function tbTuiGuangYuan:GiftTest_TesterGame9()
if me.szName ~= "TesterGame9" then
Dialog:Say("\nNgươi không phải <color=green>TesterGame9<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_TesterGame9_OK, self);
end
function tbTuiGuangYuan:GiftTest_TesterGame9_OK(TuHoiKiem_TesterGame9)
if TuHoiKiem_TesterGame9 ~= "THK0015809" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
-----------------
function tbTuiGuangYuan:GiftTest_TesterGame10()
if me.szName ~= "TesterGame10" then
Dialog:Say("\nNgươi không phải <color=green>TesterGame10<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_TesterGame10_OK, self);
end
function tbTuiGuangYuan:GiftTest_TesterGame10_OK(TuHoiKiem_TesterGame10)
if TuHoiKiem_TesterGame10 ~= "THK0015810" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end

----------------------------------
function tbTuiGuangYuan:TrangTiepTheo()
local msg = "<color=yellow>Danh Sách Nhân Vật Nhận GiftCode<color>"
	local tbOpt = 
	{
{"Nhân Sĩ <color=green>TesterGame11<color>", self.GiftTest_TesterGame11, self},
{"Nhân Sĩ <color=green>TesterGame12<color>", self.GiftTest_TesterGame12, self},
{"Nhân Sĩ <color=green>TesterGame13<color>", self.GiftTest_TesterGame13, self},
{"Nhân Sĩ <color=green>TesterGame14<color>", self.GiftTest_TesterGame14, self},
{"Nhân Sĩ <color=green>TesterGame15<color>", self.GiftTest_TesterGame15, self},
{"Nhân Sĩ <color=green>TesterGame16<color>", self.GiftTest_TesterGame16, self},
{"Nhân Sĩ <color=green>TesterGame17<color>", self.GiftTest_TesterGame17, self},
{"Nhân Sĩ <color=green>TesterGame18<color>", self.GiftTest_TesterGame18, self},
{"Nhân Sĩ <color=green>TesterGame19<color>", self.GiftTest_TesterGame19, self},
{"Nhân Sĩ <color=green>TesterGame20<color>", self.GiftTest_TesterGame20, self},
	}
	Dialog:Say(msg,tbOpt);
end
-------------
function tbTuiGuangYuan:GiftTest_TesterGame11()
if me.szName ~= "TesterGame11" then
Dialog:Say("\nNgươi không phải <color=green>TesterGame11<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_TesterGame11_OK, self);
end
function tbTuiGuangYuan:GiftTest_TesterGame11_OK(TuHoiKiem_TesterGame11)
if TuHoiKiem_TesterGame11 ~= "THK0015811" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
------------------
function tbTuiGuangYuan:GiftTest_TesterGame12()
if me.szName ~= "TesterGame12" then
Dialog:Say("\nNgươi không phải <color=green>TesterGame12<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_TesterGame12_OK, self);
end
function tbTuiGuangYuan:GiftTest_TesterGame12_OK(TuHoiKiem_TesterGame12)
if TuHoiKiem_TesterGame12 ~= "THK0015812" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
-------------------
function tbTuiGuangYuan:GiftTest_TesterGame13()
if me.szName ~= "TesterGame13" then
Dialog:Say("\nNgươi không phải <color=green>TesterGame13<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_TesterGame13_OK, self);
end
function tbTuiGuangYuan:GiftTest_TesterGame13_OK(TuHoiKiem_TesterGame13)
if TuHoiKiem_TesterGame13 ~= "THK0015813" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
-----------------
function tbTuiGuangYuan:GiftTest_TesterGame14()
if me.szName ~= "TesterGame14" then
Dialog:Say("\nNgươi không phải <color=green>TesterGame14<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_TesterGame14_OK, self);
end
function tbTuiGuangYuan:GiftTest_TesterGame14_OK(TuHoiKiem_TesterGame14)
if TuHoiKiem_TesterGame14 ~= "THK0015814" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
-------------------
function tbTuiGuangYuan:GiftTest_TesterGame15()
if me.szName ~= "TesterGame15" then
Dialog:Say("\nNgươi không phải <color=green>TesterGame15<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_TesterGame15_OK, self);
end
function tbTuiGuangYuan:GiftTest_TesterGame15_OK(TuHoiKiem_TesterGame15)
if TuHoiKiem_TesterGame15 ~= "THK0015815" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
-------------------
function tbTuiGuangYuan:GiftTest_TesterGame16()
if me.szName ~= "TesterGame16" then
Dialog:Say("\nNgươi không phải <color=green>TesterGame16<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_TesterGame16_OK, self);
end
function tbTuiGuangYuan:GiftTest_TesterGame16_OK(TuHoiKiem_TesterGame16)
if TuHoiKiem_TesterGame16 ~= "THK0015816" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
--------------------
function tbTuiGuangYuan:GiftTest_TesterGame17()
if me.szName ~= "TesterGame17" then
Dialog:Say("\nNgươi không phải <color=green>TesterGame17<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_TesterGame17_OK, self);
end
function tbTuiGuangYuan:GiftTest_TesterGame17_OK(TuHoiKiem_TesterGame17)
if TuHoiKiem_TesterGame17 ~= "THK0015817" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
------------------------
function tbTuiGuangYuan:GiftTest_TesterGame18()
if me.szName ~= "TesterGame18" then
Dialog:Say("\nNgươi không phải <color=green>TesterGame18<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_TesterGame18_OK, self);
end
function tbTuiGuangYuan:GiftTest_TesterGame18_OK(TuHoiKiem_TesterGame18)
if TuHoiKiem_TesterGame18 ~= "THK0015818" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
-------------------------
function tbTuiGuangYuan:GiftTest_TesterGame19()
if me.szName ~= "TesterGame19" then
Dialog:Say("\nNgươi không phải <color=green>TesterGame19<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_TesterGame19_OK, self);
end
function tbTuiGuangYuan:GiftTest_TesterGame19_OK(TuHoiKiem_TesterGame19)
if TuHoiKiem_TesterGame19 ~= "THK0015819" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end
--------------------------
function tbTuiGuangYuan:GiftTest_TesterGame20()
if me.szName ~= "TesterGame20" then
Dialog:Say("\nNgươi không phải <color=green>TesterGame20<color> <pic=15>")
return
end
Dialog:AskString("Nhập Giftcode", 20, self.GiftTest_TesterGame20_OK, self);
end
function tbTuiGuangYuan:GiftTest_TesterGame20_OK(TuHoiKiem_TesterGame20)
if TuHoiKiem_TesterGame20 ~= "THK0015820" then
Dialog:Say("Nhập Sai Code")
return
end
local nCount = me.GetTask(self.TaskGourp1, self.TaskId_TanThu);
me.AddStackItem(18,1,20327,1,self.tbItemInfo,1); -- 1 Đá Cường Hóa +16
me.AddStackItem(18,1,205,1,self.tbItemInfo,2000); -- 2000 Ngũ Hành Hồn Thạch
me.AddStackItem(18,1,1331,4,self.tbItemInfo,10); -- 10 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,402,1,self.tbItemInfo,20); -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20); -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1,8,self.tbItemInfo,4); -- 4 Huyền Tinh Cấp 8
me.AddStackItem(18,1,1,9,self.tbItemInfo,2); -- 2 Huyền Tinh Cấp 9
me.SetTask(self.TaskGourp1, self.TaskId_TanThu, nCount + 1);
end






















-------------------
function tbTuiGuangYuan:InfoSatThanXT()
-- if me.szName ~= "AdminLongThần" then
-- Dialog:Say("Chức năng đang hoàn thiện")
-- return
-- end 
local Van = 10000;
local nCoin = me.CheckCoin();
local szMsg = "Tên Nhân Vật: <color=yellow>"..me.szName.."<color>\nSố Đồng Chưa Rút: <color=yellow>"..nCoin/Van.."<color> Vạn Đồng\nSố Đồng Trong Người: <color=yellow>"..me.nCoin/Van.."<color> Vạn"; 
local tbOpt = { 
{"<color=Turquoise>Rút Đồng<color>",self.RutDong,self};
}; 
Dialog:Say(szMsg, tbOpt);
end
function tbTuiGuangYuan:RutDong()
if me.CountFreeBagCell() < 20 then
		Dialog:Say("Phải Có 20 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local Van = 10000;
local nCoin = me.CheckCoin();
local szMsg = "                  <color=yellow>Phúc Lợi Nạp Thẻ<color>\n"..
"<pic=49><color=wheat>Số Đồng Trong Tài Khoản < 60v<color> \n50tr EXP + 10 Đồng Vàng\n"..
"<pic=49><color=wheat>Số Đồng Trong Tài Khoản >60v và < 300v<color> \n100tr EXP + 30 Đồng Vàng + 50 Điểm TĐLT + 50 Điểm TDC + 1 HTB\n"..
"<pic=49><color=wheat>Số Đồng Trong Tài Khoản > 300v<color> \n130tr EXP +  50 Đồng Vàng + 7 HTB + 100 Điểm TĐLT + 100 Điểm TDC\n"..
"<pic=49><color=wheat>Tài Khoản Còn : <color=pink>"..nCoin/Van.."<color> Vạn Đồng<color><pic=49>" 
local tbOpt = { 
{"<color=Turquoise>Chấp Nhận Rút<color>",self.RutDong123,self};
}; 
Dialog:Say(szMsg, tbOpt);
end
function tbTuiGuangYuan:RutDong123()
local nCoin = me.CheckCoin();
if nCoin == 0 then
Dialog:Say("Không có đồng để rút")
end
if (nCoin > 0) and (nCoin <= 600000) then -- x < 60v
me.ReloadJbCoin()
me.AddExp(80000000) -- 50tr
me.AddStackItem(18,1,20251,1,nil,10)
end
if (nCoin > 600000) and (nCoin < 3000000) then -- 60v < x < 300v
me.ReloadJbCoin()
me.AddStackItem(18,1,377,1,nil,5) -- Add 5 HTB
me.AddExp(120000000) -- 100tr
me.AddBindMoney(1500000) -- 150v BK
me.AddRepute(8,1,50) -- Add 0 điểm TĐLT
me.AddRepute(5,3,50) -- Add 100 điểm TDC
me.AddStackItem(18,1,20251,1,nil,30)
end
if (nCoin >= 3000000) then -- x > 300v
me.ReloadJbCoin()
me.AddStackItem(18,1,377,1,nil,7) -- Add 7 HTB
me.AddRepute(8,1,100) -- Add 100 điểm TĐLT
me.AddRepute(5,3,100) -- Add 100 điểm TDC
me.AddExp(150000000) -- 130tr
me.AddStackItem(18,1,20251,1,nil,50)
end
end














function tbTuiGuangYuan:dnnhandong()	
local msg = 
"<color=gold>\n             <pic=120>Phúc Lợi Nạp Thẻ<color><pic=120>\n"..
"                     Nạp Lần Đầu\n"..
"                  <color=red>Mệnh Giá Bất Kỳ<color>\n"..
"Nhận <color=green>30tr EXP<color>\n"..
"Nhận <color=green>5 Cuốc<color>\n"..
"Nhận <color=green>20 Chân Nguyên Tu Luyện Đơn<color>\n"..
"Nhận <color=green>20 Thánh Linh Bảo Hạp Hồn<color>\n"..
"Nhận <color=green>3 Tinh Thạch Thánh Hỏa<color>\n"..
"Nhận <color=green>2 Gậy Đập Bóng (Đặc Biệt)<color>\n"..
"Nhận <color=green>1 Đá Cường Hóa +15<color>\n"..
"\n<color=red>Chú ý<color> Nạp thẻ với mệnh giá bất kỳ nhận\n"..
"<color=green>50tr EXP<color>\n1 <color=green>Gậy Đập Bóng (Thường)<color>\n1 <color=green>Tinh Thạch Thánh Hỏa<color>\n5 <color=green>Rương Mảnh Trang Bị Đồng Hành<color>\n1 <color=green>Huyền Tinh (Cấp 8)<color>"
local tbOpt = {
{"Nhận <color=green>Tiền Xu<color> nạp thẻ",self.NhanXuNapThe_OK,self};
-- {"Xem <color=cyan>Phúc Lợi Nạp Thẻ<color>",self.PhucLoiNapThe,self};
}
Dialog:Say(msg,tbOpt)
end
function tbTuiGuangYuan:NhanXuNapThe_OK()
if me.CountFreeBagCell() < 25 then
Dialog:Say("Phải Có 25 Ô Trống Trong Túi Hành Trang");
return 0;
end
local nRet = me.GetUserPayCoin();
local nSoXu = math.floor(nRet/10000)
if nRet ~= 0  then
local nCount1 = me.GetTask(self.TaskGourp, self.TaskId_TanThu);
if nCount1 < 1 then
me.AddJbCoin(-1*nRet)
me.AddStackItem(18,10,11,2,nil,nSoXu)
me.Msg("<color=yellow>Nhận <color=green>Quà Nạp Lần Đầu")
self:NhanXuNapThe_OK_Lan1()
return
end
if nCount1 >= 1 then
me.AddJbCoin(-1*nRet)
me.AddStackItem(18,10,11,2,nil,nSoXu)
me.AddExp(50000000)
me.AddStackItem(18,1,2075,1,self.tbItemInfo,1) -- 1 Gậy Đập Bóng Thường
me.AddStackItem(18,1,1331,4,self.tbItemInfo,1) -- 1 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,2009,1,self.tbItemInfo,5) -- 5 Rương Mảnh Trang Bị Đồng Hành
me.AddStackItem(18,1,1,8,self.tbItemInfo,1) -- 1 Huyen Tinh 8
me.Msg("<color=yellow>Số <color=green>Tiền Xu<color> nhận được là <color=cyan>"..nSoXu.."<color>\nNhận thêm:\n50tr EXP\n1 Gậy Đập Bóng (Thường)\n1 Tinh Thạch Thánh Hỏa\n5 Rương Mảnh Trang Bị Đồng Hành\n1 Huyen Tinh 8")
KDialog.MsgToGlobal("<color=yellow>\nNgười chơi <color=green>"..me.szName.."<color> <color=red>|<color> Nhận được <color=green>"..nSoXu.."<color> Tiền Xu từ hệ thống nạp thẻ.\nNhận thêm:\n50tr EXP\n1 Gậy Đập Bóng (Thường)\n1 Tinh Thạch Thánh Hỏa\n5 Rương Mảnh Trang Bị Đồng Hành\n1 Huyen Tinh 8");	
return
end
end
me.Msg("<color=yellow>Số <color=green>Tiền Xu<color> còn lại trong tài khoản : <color=red>"..nRet.."<color>")
end
function tbTuiGuangYuan:NhanXuNapThe_OK_Lan1()
local nRet = me.GetUserPayCoin();
local nSoXu = math.floor(nRet/10000);
local nCount1 = me.GetTask(self.TaskGourp, self.TaskId_TanThu);
me.AddJbCoin(-1*nRet)
if me.CountFreeBagCell() < 25 then
Dialog:Say("Phải Có 25 Ô Trống Trong Túi Hành Trang");
return 0;
end
me.AddJbCoin(-1*nRet)
me.AddExp(30000000) -- 30tr EXp
me.AddStackItem(18,1,2100,1,self.tbItemInfo,5) -- 5 Cuốc
me.AddStackItem(18,1,402,1,self.tbItemInfo,20) -- 20 Chân Nguyên Tu Luyện Đơn
me.AddStackItem(18,1,1334,1,self.tbItemInfo,20) -- 20 Thánh Linh Bảo Hạp Hồn
me.AddStackItem(18,1,1331,4,self.tbItemInfo,3) -- 3 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,2076,1,self.tbItemInfo,2) -- 2 Gậy Đập Bóng (Đặc Biệt)
me.AddStackItem(18,1,20326,1,self.tbItemInfo,1) -- 1 Đá Cường Hóa +15
KDialog.MsgToGlobal("<color=yellow>\nNgười chơi <color=green>"..me.szName.."<color> <color=red>|<color> Nhận được quà nạp thẻ lần đầu !");	
me.Msg("<color=yellow>Số <color=green>Tiền Xu<color> nhận được là <color=cyan>"..nSoXu.."<color>\nNhận Quà Nạp Lần Đầu")
me.SetTask(self.TaskGourp, self.TaskId_TanThu, nCount1 + 1);
end
function tbTuiGuangYuan:NhanXuNapThe_OK_Lan2TroDi()
local nRet = me.GetUserPayCoin();
local nSoXu = math.floor(nRet/10000);
me.Msg("<color=yellow>Số <color=green>Tiền Xu<color> nhận được là <color=cyan>"..nSoXu.."<color>")
KDialog.MsgToGlobal("<color=yellow>\nNgười chơi <color=green>"..me.szName.."<color> <color=red>|<color> Nhận được <color=green>"..nSoXu.."<color> Tiền Xu.");	
self:NhanPhucLoiMuc1()
end
function tbTuiGuangYuan:NhanPhucLoiMuc1()

end
function tbTuiGuangYuan:NhanPhucLoiMuc2()
me.AddExp(70000000)
me.AddStackItem(18,1,2072,1,self.tbItemInfo,3) -- 3 300 Bài Hát Thiếu Nhi
me.AddStackItem(18,1,2100,1,self.tbItemInfo,5) -- 5 Cuốc
me.AddStackItem(18,1,2076,1,self.tbItemInfo,1) -- 2 Gậy Đập Bóng (Đặc Biệt)
me.AddStackItem(18,1,1331,4,self.tbItemInfo,2) -- 2 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,2009,1,self.tbItemInfo,10) -- 10 Rương Mảnh Trang Bị Đồng Hành
end
function tbTuiGuangYuan:NhanPhucLoiMuc2()
me.AddExp(70000000)
me.AddStackItem(18,1,2072,1,self.tbItemInfo,3) -- 3 300 Bài Hát Thiếu Nhi
me.AddStackItem(18,1,2100,1,self.tbItemInfo,5) -- 5 Cuốc
me.AddStackItem(18,1,2076,1,self.tbItemInfo,1) -- 2 Gậy Đập Bóng (Đặc Biệt)
me.AddStackItem(18,1,1331,4,self.tbItemInfo,2) -- 2 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,2009,1,self.tbItemInfo,10) -- 10 Rương Mảnh Trang Bị Đồng Hành
end
function tbTuiGuangYuan:NhanPhucLoiMuc3()
me.AddExp(100000000)
me.AddStackItem(18,1,2072,1,self.tbItemInfo,5) -- 5 300 Bài Hát Thiếu Nhi
me.AddStackItem(18,1,2100,1,self.tbItemInfo,7) -- 7 Cuốc
me.AddStackItem(18,1,2076,1,self.tbItemInfo,5) -- 5 Gậy Đập Bóng (Đặc Biệt)
me.AddStackItem(18,1,1331,4,self.tbItemInfo,4) -- 4 Tinh Thạch Thánh Hỏa
me.AddStackItem(18,1,2009,1,self.tbItemInfo,15) -- 15 Rương Mảnh Trang Bị Đồng Hành
me.AddStackItem(18,1,1,10,self.tbItemInfo,1) -- 1 Huyền Tinh 10
me.AddStackItem(18,1,20326,1,self.tbItemInfo,1) -- 1 Đá Cường Hóa 15
end
-------------------------------------------
function tbTuiGuangYuan:PhucLoiNapThe()
local msg = 
"\n<color=green><pic=120>Mức 1<color>\n"..
"\nTừ <color=gold>10.000 VNĐ<color> đến <color=gold>49.000 VNĐ<color>\n"..
"50tr Điểm Kinh Nghiệm\n"..
"1 Gậy Đập Bóng (Thường)\n"..
"1 Tinh Thạch Thánh Hỏa\n"..
"5 Rương Mảnh Trang Bị Pet\n"..
"\n<color=green><pic=120>Mức 2<color>\n"..
"\nTừ <color=gold>50.000 VNĐ<color> đến <color=gold>99.000 VNĐ<color>\n"..
"70tr Điểm Kinh Nghiệm\n"..
"2 Gậy Đập Bóng (Đặc Biệt)\n"..
"2 Tinh Thạch Thánh Hỏa\n"..
"10 Rương Mảnh Trang Bị Pet\n"..
"5 Cuốc\n"..
"3 Quyển 300 Bài Hát Thiếu Nhi\n"..
"\n<color=green><pic=120>Mức 3<color>\n"..
"\nTừ <color=gold>100.000 VNĐ<color> trở lên\n"..
"100tr Điểm Kinh Nghiệm\n"..
"5 Gậy Đập Bóng (Đặc Biệt)\n"..
"4 Tinh Thạch Thánh Hỏa\n"..
"15 Rương Mảnh Trang Bị Pet\n"..
"7 Cuốc\n"..
"5 Quyển 300 Bài Hát Thiếu Nhi\n"..
"1 Huyền Tinh 10\n"..
"1 Đá Cường Hóa +15"
Dialog:Say(msg)
end
function tbTuiGuangYuan:dnnhandong111()
	local nRet = me.GetUserPayCoin();
	if nRet ~= 0 then
		local nSoXu = math.floor(nRet/10000);	
		me.AddStackItem(18,10,11,2,nil,nSoXu)
		me.Msg(string.format("<color=gold>%s<color> nhận được <color=yellow>%d Tiền Xu<color> từ hệ thống",me.szName, nSoXu))
me.AddJbCoin(-1*nRet)	
	end
end

function tbTuiGuangYuan:DoiDTV1()
	Dialog:AskString("Nhập số lượng", 16, self.DoiDTV2, self);
end

function tbTuiGuangYuan:DoiDTV2(nValue)
	local nGiaTri = tonumber(nValue);
	local tbItemId	= {18,10,11,2,0,0};
	local nCount = me.GetItemCountInBags(18,10,11,2); --Đồng tiền vàng
	if nCount < nGiaTri then
		me.Msg(string.format("Ngươi mang theo không đủ Tiền Xu"));
		return 0;
	else
		Task:DelItem(me, tbItemId, nGiaTri);
		me.AddJbCoin(nGiaTri*20000)
		me.Msg(string.format("Đổi thành công, nhận được %s đồng", nGiaTri*20000))
	end;
end

function tbTuiGuangYuan:MuaKNB(nValue)
	local nCount = me.GetJbCoin()
	if nValue == 1 then
		if nCount < 1000000 then
			Dialog:Say("Trong người ngươi hiện chỉ có "..nCount.." Đồng ")
			return 0;
		end
		me.AddItem(18,1,1338,1)
		me.AddJbCoin(-1*1000000)
		Dialog:Say("Mua thành công 1 đại Kim Nguyên Bảo")
	elseif nValue == 2 then
		if nCount < 100000 then
			Dialog:Say("Trong người ngươi hiện chỉ có "..nCount.." Đồng ")
			return 0;
		end
		me.AddItem(18,1,1338,2)
		me.AddJbCoin(-1*100000)
		Dialog:Say("Mua thành công 1 tiểu Kim Nguyên Bảo")
	end;
end

function tbTuiGuangYuan:danhhieu()
local tbInfo	= GetPlayerInfoForLadderGC(me.szName);
local checknhan = me.GetTask(2125,1);
if checknhan==1 then
me.Msg("Bạn đã nhận danh hiệu rồi");
return 0;
end
if (tbInfo.nSex == 1) then
me.AddTitle(6,6,6,11);
me.SetTask(2125,1,1);
else
me.Msg("Không phải nữ mà cũng đòi nhận danh hiệu sao");
end	
end

function tbTuiGuangYuan:nhanhoahong()
local tbInfo	= GetPlayerInfoForLadderGC(me.szName);
local nCurDate = tonumber(os.date("%Y%m%d", GetTime()))
local checknhan = me.GetTask(2125,2);

if nCurDate == checknhan then
me.Msg("Hôm nay, Ngươi đã nhận quà rồi !");
return 0;
end

if me.CountFreeBagCell() < 3 then
	me.Msg("Túi của bạn đã đầy, cần ít nhất 3 ô trống.");
	return 0;
end	

if (tbInfo.nSex == 1) then
me.AddStackItem(18,1,1343,2,nil,100);
me.SetTask(2125,2,nCurDate);
else
me.Msg("Đàn ông con trai, ai lại đi giả dạng nhận quà của Phụ Nữ ?");
end	
end

function tbTuiGuangYuan:doihoahongnu()
local checkdoi = me.GetTask(2125,3);
if checkdoi==1 then
me.Msg("Mỗi người chỉ có một lần đổi mà thôi");
return 0;
end
local tbOpt = 
	{
		{"<color=red>Đổi 500 Hoa Hồng Thiên Tuyệt<color>", self.hhn500, self},
		{"<color=green>Đổi 1000 Hoa Hồng Thiên Tuyệt<color>", self.hhn1000, self},
   		{"Kết Thúc Đối Thoại"}
	}
	Dialog:Say("Mỹ Nhân, Ngươi Muốn Gì Nào ? Hãy Suy Nghĩ Cho Kỹ, Vì Ngươi Chỉ Có 01 Lần Đổi Thôi",tbOpt);
end


function tbTuiGuangYuan:hhn500()
local tbItemId1	= {18,1,1343,2,0,0};
local nCount1 = me.GetItemCountInBags(18,1,1343,2); --Trứng
if nCount1 < 500 then
Dialog:Say("<color=yellow>Không đủ <color=cyan>Hoa Hồng Thiên Tuyệt Kiếm<color> . Không Thể Đổi<color>");
return 0;
end
if me.CountFreeBagCell() < 3 then
	Dialog:Say("Phải Có 3 Ô Trống Trong Túi Hành Trang Mới Đổi Hoa Hồng Được !");
	return 0;
end
me.AddItem(1,12,37,4).Bind(1);
Task:DelItem(me, tbItemId1, 500);
me.SetTask(2125,3,1);
me.Msg("Đổi <color=cyan>500 Hoa Hồng <color> Nhận Được 01 Thú Cưỡi Hỷ Hỷ"); 
end

function tbTuiGuangYuan:hhn1000()
local tbItemId1	= {18,1,1343,2,0,0};
local nCount1 = me.GetItemCountInBags(18,1,1343,2); --Trứng
if nCount1 < 1000 then
Dialog:Say("<color=yellow>Không đủ <color=cyan>Hoa Hồng Thiên Tuyệt Kiếm<color> . Không Thể Đổi<color>");
return 0;
end
if me.CountFreeBagCell() < 3 then
	Dialog:Say("Phải Có 3 Ô Trống Trong Túi Hành Trang Mới Đổi Hoa Hồng Được !");
	return 0;
end
me.AddStackItem(18,1,298,1,nil,30);
Task:DelItem(me, tbItemId1, 1000);
me.SetTask(2125,3,1);
me.Msg("Đổi <color=cyan>1000 Hoa Hồng <color> Nhận Được 100 Hộp Quà Mỹ Nữ 20/10"); 
end

function tbTuiGuangYuan:doihoahongall()
local tbOpt = 
	{
		{"<color=red>Đổi 100 Hoa Hồng 20/10<color>", self.hh100, self},
		{"<color=green>Đổi 300 Hoa Hồng 20/10<color>", self.hh300, self},
		{"<color=orange>Đổi 500 Hoa Hồng 20/10<color>", self.hh500, self},
		{"<color=gold>Đổi 1000 Hoa Hồng 20/10t<color>", self.hh1000, self},
   		{"Kết Thúc Đối Thoại"}
	}
	Dialog:Say("Chào Bằng Hữu, Ngươi Mang Hoa Hồng Đến Mừng Ngày Phụ Nữ Việt Nam Ư ?",tbOpt);
end


function tbTuiGuangYuan:hh100()
local tbItemId1	= {18,1,1343,1,0,0};
local nCount1 = me.GetItemCountInBags(18,1,1343,1); --Trứng
if nCount1 < 100 then
Dialog:Say("<color=yellow>Không đủ <color=cyan>Hoa Hồng Thiên 20/10<color> . Không Thể Đổi<color>");
return 0;
end
if me.CountFreeBagCell() < 3 then
	Dialog:Say("Phải Có 3 Ô Trống Trong Túi Hành Trang Mới Đổi Hoa Hồng Được !");
	return 0;
end
local item01 = me.AddItem(1,12,33,4);
item01.Bind(1);
Task:DelItem(me, tbItemId1, 100);
me.Msg("Đổi <color=cyan>100 Hoa Hồng 20/10 <color> Nhận Được 01 Thú Cưỡi Phiên Vũ Khóa Vĩnh Viễn"); 
end


function tbTuiGuangYuan:hh300()
local tbItemId1	= {18,1,1343,1,0,0};
local nCount1 = me.GetItemCountInBags(18,1,1343,1); --Trứng
if nCount1 < 300 then
Dialog:Say("<color=yellow>Không đủ <color=cyan>Hoa Hồng 20/10m<color> . Không Thể Đổi<color>");
return 0;
end
if me.CountFreeBagCell() < 3 then
	Dialog:Say("Phải Có 3 Ô Trống Trong Túi Hành Trang Mới Đổi Hoa Hồng Được !");
	return 0;
end

Task:DelItem(me, tbItemId1, 300);
local item01 = me.AddItem(1,13,63,1);
me.SetItemTimeout(item01,21600);
item01.Bind(1);
me.Msg("Đổi <color=cyan>300 Hoa Hồng <color> Nhận 01 Mặt Nạ Hàng Long Phục Hổ 15 Ngày"); 
end

function tbTuiGuangYuan:hh500()
local tbItemId1	= {18,1,1343,1,0,0};
local nCount1 = me.GetItemCountInBags(18,1,1343,1); --Trứng
if nCount1 < 500 then
Dialog:Say("<color=yellow>Không đủ <color=cyan>Hoa Hồng Thiên Tuyệt Kiếm<color> . Không Thể Đổi<color>");
return 0;
end
if me.CountFreeBagCell() < 3 then
	Dialog:Say("Phải Có 3 Ô Trống Trong Túi Hành Trang Mới Đổi Hoa Hồng Được !");
	return 0;
end

Task:DelItem(me, tbItemId1, 500);
local item01 = me.AddItem(1,13,63,1);
me.SetItemTimeout(item01,21600*2);
me.Msg("Đổi <color=cyan>500 Hoa Hồng <color> Nhận 01 Mặt Nạ Hàng Long Phục Hổ 30 Ngày"); 
end

function tbTuiGuangYuan:hh1000()
local tbItemId1	= {18,1,1343,1,0,0};
local nCount1 = me.GetItemCountInBags(18,1,1343,1); --Trứng
if nCount1 < 1000 then
Dialog:Say("<color=yellow>Không đủ <color=cyan>Hoa Hồng 20/10<color> . Không Thể Đổi<color>");
return 0;
end
if me.CountFreeBagCell() < 3 then
	Dialog:Say("Phải Có 3 Ô Trống Trong Túi Hành Trang Mới Đổi Hoa Hồng Được !");
	return 0;
end
Task:DelItem(me, tbItemId1, 1000);
local item01 = me.AddItem(1,12,47,4);
me.SetItemTimeout(item01,21600);
me.Msg("Đổi <color=cyan>1000 Hoa Hồng <color> Nhận Được 01 Ức Vân 15 Ngày"); 
end