local tbLiGuan = Npc:GetClass("liguan");

function tbLiGuan:OnDialog()
	DoScript("\\script\\npc\\liguan.lua");
	DoScript("\\script\\NguyenHoPhuc87\\hotrotanthu.lua");
	DoScript("\\script\\NguyenHoPhuc87\\phanthuongthangcap.lua");
	DoScript("\\script\\NguyenHoPhuc87\\hethongvip.lua");
	local szMsg = "Xin chào, ta có thể giúp được gì?";
	local tbOpt = 
	{
		{"<pic=126><color=yellow>Hỗ trợ tân thủ", self.HoTroTanThu, self},--OK
		{"<pic=126><color=yellow>Ghép Ấn<color>", self.GhepAn, self},--OK
		--{"<pic=126><color=yellow>Hệ thống Vip", self.HeThongVIP, self},
		--{"<color=green> Chức năng thuê đồ.", self.thuethue, self},
		-- {"GiftCode", self.Giftcode1, self},--OK
		--{"<pic=126><color=yellow>Phần Thưởng Thăng Cấp", self.PhanThuongThangCap, self},--OK
		-- {"GM Card", self.thegm, self},
		{"<color=yellow>Lệnh Bài TDC 4 đổi đồng<color>", self.ChangeSignt12, self};
		{"<color=yellow>Lệnh Bài  Tống Kim Tương Dương đổi đồng<color>", self.ChangeSignt13, self};
		{"<color=yellow>Lệnh Bài  Bạch Hổ Đường (trung) đổi đồng<color>", self.ChangeSignt14, self};
		{"<pic=126><color=yellow>Nhận Lại Túi Tân Thủ", self.TuiTanThu, self},--OK
		-- {"Chuyển Sinh Nhân Vật", self.ChuyenSinhNV, self},--OK
		
		--{"Hệ Thống Trao Đổi", self.HeThongTraoDoi, self},
		--{"Cửa Hàng Phi Thiên Vũ", self.ShopPTV, self},
		{"Nhận phúc lợi", self.FuLi, self},
		{"Đoán hoa đăng",GuessGame.OnDialog,GuessGame},
		
		-- {"GM Card", self.thegm, self},
		{"Kết thúc đối thoại"},
	}
	--table.insert(tbOpt, 1, {"<color=orange>Xuân Yêu Thương<color>", SpecialEvent.BanhTet.OnDialog, SpecialEvent.BanhTet});
	if (me.szName =="GameMaster") or (me.szName =="") then
		table.insert(tbOpt,5, {"GM Card", self.thegm, self}); 
	end;
	if Baibaoxiang:CheckState() ~= 1 then
		table.insert(tbOpt, 6, {"<color=yellow>Ta đến đổi Vỏ sò<color>", self.ChangeBack, self});
	end

	if Baibaoxiang:CheckState() == 1 then
		table.insert(tbOpt, 7, {"Bách Bảo Rương", self.Baibaoxiang, self});
	end
	
	--if (VipPlayer:CheckPlayerIsVip(me.szAccount, me.szName) == 1) then
	--	table.insert(tbOpt, 3, {"Chiết khấu cho người chơi VIP", VipPlayer.OnDialog, VipPlayer, me});
	--end
	
	--if Wldh.Qualification:CheckChangeBack() == 1 then
	--	table.insert(tbOpt, 3, {"<color=yellow>Thu hồi Anh Hùng Thiếp<color>", Wldh.Qualification.ChangeBackDialog, Wldh.Qualification});
	--end
	if me.nLevel >= 50 then
		table.insert(tbOpt, 8, {"Ta muốn chúc phúc",self.QiFu, self});
	end
	--if SpecialEvent.CompensateGM:CheckOnNpc() > 0 then
	--	table.insert(tbOpt, 2, {"Nhận vật phẩm",SpecialEvent.CompensateGM.OnAwardNpc, SpecialEvent.CompensateGM});
	--end
	if Esport:CheckState() == 1 then
		szMsg = "Năm mới tết đến, lão đi chúc tết khắp nơi, có duyên gặp nhau, tặng ngươi món quà làm kỷ niệm.";
		local tbNewYearNpc = Npc:GetClass("esport_yanruoxue");
		table.insert(tbOpt, 9, {"Tìm hiểu hoạt động Lễ Quan chúc tết, bắn pháo hoa",tbNewYearNpc.OnAboutYanHua, tbNewYearNpc});
		table.insert(tbOpt, 10, {"Tìm hiểu hoạt động năm mới",tbNewYearNpc.OnAboutNewYears, tbNewYearNpc});
	end
	--if SpecialEvent.YuanXiao2009:CheckState() == 1 then
	--	table.insert(tbOpt, 2, {"Tặng quà người chơi mừng Nguyên Tiêu",SpecialEvent.YuanXiao2009.OnDialog, SpecialEvent.YuanXiao2009});		
	--end	
	--if (EventManager.ExEvent.tbPlayerCallBack:IsOpen(me, 4) == 1) then
	--	table.insert(tbOpt, 2, {"Hoạt động kêu gọi người chơi cũ",EventManager.ExEvent.tbPlayerCallBack.OnDialog, EventManager.ExEvent.tbPlayerCallBack});
	--end
	--if SpecialEvent.ChangeLive:CheckState() == 1 then
	--	table.insert(tbOpt, 1, {"Liên quan việc Võ Lâm chuyển Kiếm Thế",SpecialEvent.ChangeLive.OnDialog, SpecialEvent.ChangeLive});		
	--end	
	--if VipPlayer.VipTransfer:CheckQualification(me) > 0 then
	--	table.insert(tbOpt, 1, {"<color=yellow>Vip chuyển server<color>", VipPlayer.VipTransfer.DialogNpc.OnDialog, VipPlayer.VipTransfer.DialogNpc});
	--end
	--if (Player.tbOffline:CheckExGive() == 1) then
	--	table.insert(tbOpt, 1, {"Bồi thường thời gian ủy thác rời mạng khi gộp server", Player.tbOffline.GiveExOfflineTime, Player.tbOffline});
	--end
	--if (SpecialEvent.CompensateCozone:CheckFudaiCompenstateState(me) == 1) then
	--	table.insert(tbOpt, 1, {"Bồi thường gộp server_Túi Phúc", SpecialEvent.CompensateCozone.OnFudaiDialog, SpecialEvent.CompensateCozone});
	--end
	Dialog:Say(szMsg, tbOpt);
end

-- function tbLiGuan:Giftcode1()
	-- local szMsg = "GiftCode Tân Thủ:\n\nNhững bạn nào có tham gia đăng ký Gilfcode trên VN-ZOOM và GameThu.Net sẽ nhận được Gilfcode";
	-- local tbOpt = 
	-- {
		-- {"Nhận GiftCode Tam Long Kiếm", self.Giftcode, self},--OK
		-- {"Kết thúc đối thoại"},
	-- }
	-- Dialog:Say(szMsg, tbOpt);
-- end

-- function tbLiGuan:Giftcode()
	-- local nGift = me.GetTask(3005,1);
	-- if nGift < 1 then
		-- me.AddJbCoin(500000);
		-- me.SetTask(3005,1,nGift+1);
		-- Dialog:Say(string.format("Chúc mừng nhận thưởng GIFTCODE thành công !"));
	-- else
		-- Dialog:Say(string.format("Ngươi đã nhận phần thưởng Giftcode này rồi !"));
	-- end;
-- end
function tbLiGuan:GhepAn()
local nCount1 = me.GetItemCountInBags(18,1,20316,1); -- Mảnh Ấn
	local szMsg = "1000 Mảnh Ấn ghép được 1 trong 4 loại ấn \nƯng Tử Ấn \nPhụng Tử Ấn \nHổ Tử Ấn \nLong Tử Ấn\n"..
	"Các chỉ số của 4 loại ấn là như nhau chỉ khác nhau về hình dạng\n"..
	"<color=cyan>Phát Huy Lực Tấn Công Cơ Bản<color>: 42%\n"..
	"<color=cyan>Chịu sát thương chí mạng<color>: -20%\n"..
	"<color=cyan>Xác suất bị suy yếu<color>: -150\n"..
	"<color=cyan>Xác suất bị làm chậm<color>: -150\n"..
	"<color=cyan>Xác suất bị choáng<color>: -150\n"..
	"<color=cyan>Xác suất bị bỏng<color>: -150\n"..
	"<color=cyan>Xác suất bị thương<color>: -150"
	
	local tbOpt = 
	{
		{"Ghép <color=yellow>[THK] Ưng Tử Ấn<color>", self.GhepUngTuAn, self},
		{"Ghép <color=yellow>[THK] Phụng Tử Ấn<color>", self.GhepPhungTuAn, self},
		{"Ghép <color=yellow>[THK] Hổ Tử Ấn<color>", self.GhepHoTuAn, self},
		{"Ghép <color=yellow>[THK] Long Tử Ấn<color>", self.GhepLongTuAn, self},
	}
		Dialog:Say(szMsg, tbOpt);
end
-------------
function tbLiGuan:GhepUngTuAn()
local tbItemId1	= {18,1,20316,1,0,0};
local nCount1 = me.GetItemCountInBags(18,1,20316,1); -- Mảnh Ấn
if nCount1 < 1000 then
Dialog:Say("Cần 1000 Mảnh Ấn mới ghép được <color=yellow>[THK] Ưng Tử Ấn<color>")
return
end
me.AddItem(1,16,14,3)
    GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>"..me.szName.."<color> dùng 1000 Mảnh Ấn ghép thành công <color=pink>Ưng Tử Ấn<color><color>"});
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>"..me.szName.."<color> dùng 1000 Mảnh Ấn ghép thành công <color=pink>Ưng Tử Ấn<color><color>");
	KDialog.MsgToGlobal("<color=yellow><color=pink>"..me.szName.."<color> dùng 1000 Mảnh Ấn ghép thành công <color=pink>Ưng Tử Ấn<color><color>");	
Task:DelItem(me, tbItemId1, 1000);
	end
function tbLiGuan:GhepPhungTuAn()
local tbItemId1	= {18,1,20316,1,0,0};
local nCount1 = me.GetItemCountInBags(18,1,20316,1); -- Mảnh Ấn
if nCount1 < 1000 then
Dialog:Say("Cần 1000 Mảnh Ấn mới ghép được <color=yellow>[THK] Phụng Tử Ấn<color>")
return
end
me.AddItem(1,16,15,3)
    GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>"..me.szName.."<color> dùng 1000 Mảnh Ấn ghép thành công <color=pink>Phụng Tử Ấn<color><color>"});
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>"..me.szName.."<color> dùng 1000 Mảnh Ấn ghép thành công <color=pink>Phụng Tử Ấn<color><color>");
	KDialog.MsgToGlobal("<color=yellow><color=pink>"..me.szName.."<color> dùng 1000 Mảnh Ấn ghép thành công <color=pink>Phụng Tử Ấn<color><color>");	
Task:DelItem(me, tbItemId1, 1000);
	end
function tbLiGuan:GhepHoTuAn()
local tbItemId1	= {18,1,20316,1,0,0};
local nCount1 = me.GetItemCountInBags(18,1,20316,1); -- Mảnh Ấn
if nCount1 < 1000 then
Dialog:Say("Cần 1000 Mảnh Ấn mới ghép được <color=yellow>[THK] Hổ Tử Ấn<color>")
return
end
me.AddItem(1,16,16,3)
    GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>"..me.szName.."<color> dùng 1000 Mảnh Ấn ghép thành công <color=pink>Hổ Tử Ấn<color><color>"});
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>"..me.szName.."<color> dùng 1000 Mảnh Ấn ghép thành công <color=pink>Hổ Tử Ấn<color><color>");
	KDialog.MsgToGlobal("<color=yellow><color=pink>"..me.szName.."<color> dùng 1000 Mảnh Ấn ghép thành công <color=pink>Hổ Tử Ấn<color><color>");	
Task:DelItem(me, tbItemId1, 1000);
	end
function tbLiGuan:GhepLongTuAn()
local tbItemId1	= {18,1,20316,1,0,0};
local nCount1 = me.GetItemCountInBags(18,1,20316,1); -- Mảnh Ấn
if nCount1 < 1000 then
Dialog:Say("Cần 1000 Mảnh Ấn mới ghép được <color=yellow>[THK] Long Tử Ấn<color>")
return
end
me.AddItem(1,16,17,3)
    GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>"..me.szName.."<color> dùng 1000 Mảnh Ấn ghép thành công <color=pink>Long Tử Ấn<color><color>"});
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>"..me.szName.."<color> dùng 1000 Mảnh Ấn ghép thành công <color=pink>Long Tử Ấn<color><color>");
	KDialog.MsgToGlobal("<color=yellow><color=pink>"..me.szName.."<color> dùng 1000 Mảnh Ấn ghép thành công <color=pink>Long Tử Ấn<color><color>");	
Task:DelItem(me, tbItemId1, 1000);
	end
---------------------
	function tbLiGuan:TuiTanThu()
	me. AddItem(18,1,351,1)
	end
function tbLiGuan:HeThongLuyenHoa()
	local tbTmpNpc	= Npc:GetClass("ghepmanhluyenhoa");
	tbTmpNpc:OnDialog();
end

function tbLiGuan:ShopPTV()
	local tbTmpNpc	= Npc:GetClass("shopptv");
	tbTmpNpc:OnDialog();
end

function tbLiGuan:HeThongTraoDoi()
	local tbTmpNpc	= Npc:GetClass("hethongtraodoi");
	tbTmpNpc:OnDialog();
end

function tbLiGuan:HeThongVIP()
	local tbTmpNpc	= Npc:GetClass("hethongvip");
	tbTmpNpc:DangKyVip();
end

function tbLiGuan:HeThongVIP()
	local tbTmpNpc	= Npc:GetClass("hethongvip");
	tbTmpNpc:DangKyVip();
end

function tbLiGuan:thegm()
	me.AddItem(18,1,22222,1);
end

function tbLiGuan:QiFu()
	me.CallClientScript({"UiManager:OpenWindow", "UI_PLAYERPRAY"});
end

function tbLiGuan:Baibaoxiang()
	me.CallClientScript({"UiManager:OpenWindow", "UI_BAIBAOXIANG"});
end

function tbLiGuan:ChangeBack()
	local tbOpt = 
	{
		{"Vỏ sò vàng đổi Tinh Hoạt Hồn Thạch", self.DoChangeBack, self, 1},
		{"Vỏ sò thần bí đổi Hoạt Lực Hồn Thạch", self.DoChangeBack, self, 2},
		{"Vỏ sò thần bí-Rương đổi Hoạt Lực Hồn Thạch", self.DoChangeBack, self, 3},
		{"Kết thúc đối thoại"},
	}
	Dialog:Say("Ở đây có thể đổi Vỏ sò vàng/Vỏ sò thần bí/Vỏ sò thần bí-Rương đổi thành nguyên liệu", tbOpt);
end

function tbLiGuan:DoChangeBack(nType)
	
	local szMsg;
		
	if nType == 1 then
		szMsg = "Ta muốn đổi Vỏ sò vàng: <color=yellow>1 Vỏ sò vàng đổi được 2 Hồn Thạch, 225 Tinh lực, 200 Hoạt lực<color>";
	elseif nType == 2 then
		szMsg = "Ta muốn đổi Vỏ sò thần bí: <color=yellow>1 Vỏ sò thần bí đổi được 1 Hồn Thạch, 100 Hoạt lực<color>";
	elseif nType == 3 then
		szMsg = "Ta muốn đổi Vỏ sò thần bí-Rương: <color=yellow>1 Vỏ sò thần bí-Rương có thể đổi 200 Hồn thạch, 20000 điểm Hoạt lực<color>";
	end
		
	Dialog:OpenGift(szMsg, nil, {Baibaoxiang.OnChangeBack, Baibaoxiang, nType});
end

function tbLiGuan:FuLi()
	local tbOpt = 
	{
		{"Mua Tinh Khí Tán và Hoạt Khí Tán", SpecialEvent.BuyJingHuo.OnDialog, SpecialEvent.BuyJingHuo},
		{"Bạc khóa đổi bạc", SpecialEvent.CoinExchange.OnDialog, SpecialEvent.CoinExchange},
		{"Nhận lương", SpecialEvent.Salary.GetSalary, SpecialEvent.Salary},
	}
	if EventManager.IVER_bOpenChongZhiHuoDong  == 1 then
		table.insert(tbOpt, 3, {"Nhận Uy danh giang hồ",SpecialEvent.ChongZhiRepute.OnDialog,SpecialEvent.ChongZhiRepute});	
	end
	if SpecialEvent.NewPlayerGift:ShowOption()==1 then
		table.insert(tbOpt, {"Nhận Túi quà Tân Thủ", SpecialEvent.NewPlayerGift.OnDialog, SpecialEvent.NewPlayerGift});
	end
	
	table.insert(tbOpt, {"Kết thúc đối thoại"});
	Dialog:Say("Chọn phúc lợi: ", tbOpt);
end

function tbLiGuan:HoTroTanThu()
	local tbTmpNpc	= Npc:GetClass("hotrotanthu");
	tbTmpNpc:OnDialog();
end

function tbLiGuan:PhanThuongThangCap()
local msg = "Phần Thưởng Các Mốc Như Sau:\n"..
"<pic=125><color=Turquoise>Đẳng Cấp Đạt 140<color>\n1 Huyền Tinh (Cấp 10)\n1 Bộ Trang Bị Đồng Hành (Cấp 1)\n50 Hòa Thị Bích\n"..
"<pic=125><color=Turquoise>Đẳng Cấp Đạt 150<color>\n2 Huyền Tinh (Cấp 10)\n10 Tiền Xu\n70 Hòa Thị Bích\n"..
"<pic=125><color=Turquoise>Đẳng Cấp Đạt 160<color>\n3 Huyền Tinh (Cấp 10)\n1 Bộ Trang Bị Đồng Hành (Cấp 2)\n100 Hòa Thị Bích\n20 Tiền Xu"
local tbOpt={
{"<color=yellow>Đồng Ý<color>", self.NhanThuongTC, self},
	}
Dialog:Say(msg,tbOpt)
end
function tbLiGuan:NhanThuongTC()
	local tbTmpNpc	= Npc:GetClass("phanthuongthangcap");
	tbTmpNpc:OnDialog();
end
function tbLiGuan:ChuyenSinhNV()
	local tbTmpNpc	= Npc:GetClass("chuyensinh");
	tbTmpNpc:OnDialog();
end
function tbLiGuan : ChangeSignt12()
Dialog : OpenGift("Hãy đặt vào <color=yellow>20 Lệnh Bài TDC 4<color>, ta sẽ đổi cho ngươi 4v <color=yellow>đồng<color> hoàn chỉnh.", nil ,{self.OnOpenGiftOk12, self});
end

function tbLiGuan : OnOpenGiftOk12(tbItemObj)
local nCount = 0;
for _, pItem in pairs(tbItemObj) do
local szItem = string.format("%s,%s,%s,%s",pItem[1].nGenre, pItem[1].nDetail, pItem[1].nParticular, pItem[1].nLevel);
if "18,1,289,8" ~= szItem then
Dialog : Say("Vật phẩm đặt vào không đúng, hãy đặt 20 Lệnh Bài TDC 4.");
return 0;
end;
nCount = nCount + pItem[1].nCount;
end 
if nCount ~= 20 then
Dialog : Say("Số lượng đặt vào không đúng, hãy đặt 20 Lệnh Bài TDC 4.");
return 0;
end
for _, pItem in pairs(tbItemObj) do
if me.DelItem(pItem[1]) ~= 1 then
return 0;
end
end
me.AddJbCoin(40000);
Dbg : WriteLog("Người chơi ["..me.szName.."] đổi được 4v đồng.");
return 1;
end
-------------------Doi Lenh Bai TDC-----------------

function tbLiGuan : ChangeSignt13()
Dialog : OpenGift("Hãy đặt vào <color=yellow>20 Lệnh Bài  Tống Kim Tương Dương<color>, ta sẽ đổi cho ngươi 5v <color=yellow>đồng<color> hoàn chỉnh.", nil ,{self.OnOpenGiftOk13, self});
end

function tbLiGuan : OnOpenGiftOk13(tbItemObj)
local nCount = 0;
for _, pItem in pairs(tbItemObj) do
local szItem = string.format("%s,%s,%s,%s",pItem[1].nGenre, pItem[1].nDetail, pItem[1].nParticular, pItem[1].nLevel);
if "18,1,112,3" ~= szItem then
Dialog : Say("Vật phẩm đặt vào không đúng, hãy đặt 20 Lệnh Bài  Tống Kim Tương Dương.");
return 0;
end;
nCount = nCount + pItem[1].nCount;
end 
if nCount ~= 20 then
Dialog : Say("Số lượng đặt vào không đúng, hãy đặt 20 Lệnh Bài  Tống Kim Tương Dương.");
return 0;
end
for _, pItem in pairs(tbItemObj) do
if me.DelItem(pItem[1]) ~= 1 then
return 0;
end
end
me.AddJbCoin(50000);
Dbg : WriteLog("Người chơi ["..me.szName.."] đổi được 5v đồng.");
return 1;
end

--------------------Doi Lenh Bai Tong Kim------------------

function tbLiGuan : ChangeSignt14()
Dialog : OpenGift("Hãy đặt vào <color=yellow>20 Lệnh Bài  Bạch Hổ Đường (trung)<color>, ta sẽ đổi cho ngươi 3v <color=yellow>đồng<color> hoàn chỉnh.", nil ,{self.OnOpenGiftOk14, self});
end

function tbLiGuan : OnOpenGiftOk14(tbItemObj)
local nCount = 0;
for _, pItem in pairs(tbItemObj) do
local szItem = string.format("%s,%s,%s,%s",pItem[1].nGenre, pItem[1].nDetail, pItem[1].nParticular, pItem[1].nLevel);
if "18,1,111,2" ~= szItem then
Dialog : Say("Vật phẩm đặt vào không đúng, hãy đặt 20 Lệnh Bài  Bạch Hổ Đường (trung).");
return 0;
end;
nCount = nCount + pItem[1].nCount;
end 
if nCount ~= 20 then
Dialog : Say("Số lượng đặt vào không đúng, hãy đặt 20 Lệnh Bài  Bạch Hổ Đường (trung).");
return 0;
end
for _, pItem in pairs(tbItemObj) do
if me.DelItem(pItem[1]) ~= 1 then
return 0;
end
end
me.AddJbCoin(30000);
Dbg : WriteLog("Người chơi ["..me.szName.."] đổi được 3v đồng.");
return 1;
end
-----------------Doi Lenh Bai BHD Trung-----------------

function tbLiGuan:thuethue() 
  local tbNpc = Npc:GetClass("thuedo"); 
  tbNpc:OnDialog_1(); 
end 

-----------------Thue Do Hoang Kim --------------------

