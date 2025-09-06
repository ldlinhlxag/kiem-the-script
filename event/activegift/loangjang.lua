 local tbLiGuan = Npc:GetClass("loangjang");

function tbLiGuan:OnDialog()
	local szMsg = "Thân đã bị bắt, muốn chém muốn giết gì cứ việc! Tin tức các ngươi muốn ta đã khai, nếu có đánh chết ta, ta cũng không nói!";
	local tbOpt = 
	{
		{"Kết thúc đối thoại",self.lsAd,self},
	}
	Dialog:Say(szMsg, tbOpt);
end


function tbLiGuan:NhanDenBu()
	local tbTmpNpc	= Npc:GetClass("nhandenbulan1");
	tbTmpNpc:OnDialog();
end

function tbLiGuan:ConFirmGC()
 local tbGCode = Npc:GetClass("GiftCode");
tbGCode:OnCheck_TK();
end;	



function tbLiGuan:NhanDenBu111()
	local nCount = me.GetTask(self.TASK_GROUP_ID8, self.TaskId_Count);
    if nCount >= self.Use_Max then
        local szMsg = "<color=yellow>Phần thưởng chỉ nhận được 1 lần :<color>";
		local tbOpt = {
		
		{"Bạn đã nhận phần thưởng này rồi..."};
	};
	Dialog:Say(szMsg, tbOpt);
    return 0; 
    end    
	if (nCount == 0) then
		local szMsg = "<color=yellow>Phần thưởng chỉ nhận được 1 lần. Hãy chọn<color><color=pink> Nhận thưởng <color><color=yellow>:<color>";
		local tbOpt = {
		{"Nhận thưởng", self.NhanDenBu1, self};
	};
	Dialog:Say(szMsg, tbOpt);
	end
	me.SetTask(self.TASK_GROUP_ID8, self.TaskId_Count, nCount + 1);
end

function tbLiGuan:NhanDenBu1()
	me.AddStackItem(18,1,26,1,nil,2000); -- Qua Hoang Kim
	me.AddStackItem(18,1,3005,1,nil,400); -- Thien Ma Lenh
	me.AddStackItem(18,1,20316,1,nil,400); -- Manh An
end



function tbLiGuan:MatTichTrung()
local nFaction = me.nFaction;
 if (nFaction == 0) then
  Dialog:Say("Bạn hãy gia nhập phái");
  return;
 end
 
 if (1 == nFaction) then
 me.AddItem(1,14,1,2);
 me.AddItem(1,14,2,2);
 elseif (2 == nFaction) then
 me.AddItem(1,14,3,2);
 me.AddItem(1,14,4,2);
 elseif (3 == nFaction) then
 me.AddItem(1,14,5,2);
 me.AddItem(1,14,6,2);
 elseif (4 == nFaction) then
 me.AddItem(1,14,7,2);
 me.AddItem(1,14,8,2);
 elseif (5 == nFaction) then
 me.AddItem(1,14,9,2);
 me.AddItem(1,14,10,2);
 elseif (6 == nFaction) then
 me.AddItem(1,14,11,2);
 me.AddItem(1,14,12,2);
 elseif (7 == nFaction) then
 me.AddItem(1,14,13,2);
 me.AddItem(1,14,14,2);
 elseif (8 == nFaction) then
 me.AddItem(1,14,15,2);
 me.AddItem(1,14,16,2);
 elseif (9 == nFaction) then
 me.AddItem(1,14,17,2);
 me.AddItem(1,14,18,2);
 elseif (10 == nFaction) then
 me.AddItem(1,14,19,2);
 me.AddItem(1,14,20,2);
 elseif (11 == nFaction) then
 me.AddItem(1,14,21,2);
 me.AddItem(1,14,22,2);
 elseif (12 == nFaction) then
 me.AddItem(1,14,23,2);
 me.AddItem(1,14,24,2);
 else
  Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nFaction);
 end
end






function tbLiGuan:lsTopTP()
	local szMsg = "<color=blue>Mời Bạn Chọn TOP Theo Bảng Xếp Hạng<color>";
	local tbOpt = {
		{"<color=red>TOP 1<color>",self.LsTOP1,self};
		{"<color=red>TOP 2<color>",self.LsTOP2,self};
		{"<color=red>TOP 3<color>",self.LsTOP3,self};
		{"<color=red>TOP 4 Đến 10<color>",self.LsTOP4,self};
		--{"<color=red>TOP 5<color>",self.LsTOP5,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end



function tbLiGuan:lsTopBH()
	local szMsg = "<color=blue>Mời Bạn Chọn TOP Theo Bảng Xếp Hạng<color>";
	local tbOpt = {
		{"<color=red>TOP 1<color>",self.lsTopBH1,self};
		{"<color=red>TOP 2<color>",self.lsTopBH2,self};
		{"<color=red>TOP 3<color>",self.lsTopBH3,self};
		{"<color=red>TOP 4 Đến 10<color>",self.lsTopBH4,self};
		--{"<color=red>Hệ Thổ<color>",self.lsTopBH5,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:lsTopBH1()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "BụiĐờiCL" ) or (me.szName == "Administrator" ) or (me.szName == "" )	or (me.szName == "" ) or (me.szName == "" ) or (me.szName == "" ) then
	table.insert(tbOpt, {"<color=red>Nhận Quà<color>" , self.TopBH11, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:lsTopBH2()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "Meomeo" ) or (me.szName == "" ) or (me.szName == "" )	or (me.szName == "" ) or (me.szName == "" ) or (me.szName == "" ) then
	table.insert(tbOpt, {"<color=red>Nhận Quà<color>" , self.TopBH12, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:lsTopBH3()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "z0zLãngTử" ) or (me.szName == "" ) or (me.szName == "" )	or (me.szName == "" ) or (me.szName == "" ) or (me.szName == "" ) then
	table.insert(tbOpt, {"<color=red>Nhận Quà<color>" , self.TopBH13, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:lsTopBH4()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "BabyDeThuong" ) or (me.szName == "BốGiàSingle" ) or (me.szName == "Gangster" )	or (me.szName == "llSOSllHades" ) or (me.szName == "z0zLãngDu" ) or (me.szName == "Ngoáy" ) or (me.szName == "VuaQuỷ" ) then
	table.insert(tbOpt, {"<color=red>Nhận Quà<color>" , self.TopBH14, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:lsTopBH5()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "Administrator" ) or (me.szName == "" ) or (me.szName == "" )	or (me.szName == "" ) or (me.szName == "" ) or (me.szName == "" ) then
	table.insert(tbOpt, {"<color=red>Nhận Quà<color>" , self.TopBH15, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end

----------------------------------------------------------------------------------------------------------------------------------------------------
function tbLiGuan:lsTopVDVL()
	local szMsg = "<color=blue>Mời Bạn Chọn TOP Theo Bảng Xếp Hạng<color>";
	local tbOpt = {
		{"<color=red>TOP 1<color>",self.lsTopVDVL1,self};
		{"<color=red>TOP 2<color>",self.lsTopVDVL2,self};
		{"<color=red>TOP 3<color>",self.lsTopVDVL3,self};
		{"<color=red>TOP 4 Đến 10<color>",self.lsTopVDVL4,self};
		--{"<color=red>Hệ Thổ<color>",self.lsTopBH5,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:lsTopVDVL1()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "VôTình" ) or (me.szName == "Administrator" ) or (me.szName == "" )	or (me.szName == "" ) or (me.szName == "" ) or (me.szName == "" ) then
	table.insert(tbOpt, {"<color=red>Nhận Quà<color>" , self.lsTopVDVL11, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:lsTopVDVL2()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "BốGiàSingle" ) or (me.szName == "" ) or (me.szName == "" )	or (me.szName == "" ) or (me.szName == "" ) or (me.szName == "" ) then
	table.insert(tbOpt, {"<color=red>Nhận Quà<color>" , self.lsTopVDVL12, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:lsTopVDVL3()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "VuaQuỷ" ) or (me.szName == "" ) or (me.szName == "" )	or (me.szName == "" ) or (me.szName == "" ) or (me.szName == "" ) then
	table.insert(tbOpt, {"<color=red>Nhận Quà<color>" , self.lsTopVDVL13, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:lsTopVDVL4()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "Meomeo" ) or (me.szName == "oOoLucyoOo" ) or (me.szName == "ZzSátThủPK9zZ" )	or (me.szName == "ThánhKimCương" ) or (me.szName == "TrươngVôKỵ" ) or (me.szName == "BụiĐờiCL" ) or (me.szName == "llSOSllHades" ) then
	table.insert(tbOpt, {"<color=red>Nhận Quà<color>" , self.lsTopVDVL14, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:lsTopVDVL5()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "Administrator" ) or (me.szName == "" ) or (me.szName == "" )	or (me.szName == "" ) or (me.szName == "" ) or (me.szName == "" ) then
	table.insert(tbOpt, {"<color=red>Nhận Quà<color>" , self.lsTopVDVL15, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end

--------------------------------------------------------------------------------------------------------------------------------------------
function tbLiGuan:LsTOP1()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "o0ChânMệnh0o" ) or (me.szName == "Administrator" ) or (me.szName == "" )	or (me.szName == "" ) or (me.szName == "" ) or (me.szName == "" ) then
	table.insert(tbOpt, {"<color=red>Nhận Quà<color>" , self.TopTP1, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:LsTOP2()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "BụiĐờiCL" ) or (me.szName == "" ) or (me.szName == "" )	or (me.szName == "" ) or (me.szName == "" ) or (me.szName == "" ) then
	table.insert(tbOpt, {"<color=red>Nhận Quà<color>" , self.TopTP2, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:LsTOP3()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "VôCực" ) or (me.szName == "" ) or (me.szName == "" )	or (me.szName == "" ) or (me.szName == "" ) or (me.szName == "" ) then
	table.insert(tbOpt, {"<color=red>Nhận Quà<color>" , self.TopTP3, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:LsTOP4()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "Meomeo" ) or (me.szName == "BốGiàSingle" ) or (me.szName == "VôTình" )	or (me.szName == "VuaQuỷ" ) or (me.szName == "ZzSátThủPK9zZ" ) or (me.szName == "ZzzTửLongzzZ" ) or (me.szName == "TrươngVôKỵ" ) then
	table.insert(tbOpt, {"<color=red>Nhận Quà<color>" , self.TopTP4, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:LsTOP5()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "" ) or (me.szName == "" ) or (me.szName == "" )	or (me.szName == "" ) or (me.szName == "" ) or (me.szName == "" ) then
	table.insert(tbOpt, {"<color=red>Nhận Quà<color>" , self.TopTP5, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end





function tbLiGuan:PhanThuongThangCap()
local msg = "Phần Thưởng Các Mốc Như Sau:\n"..
"<pic=125><color=Turquoise>Đẳng Cấp Đạt 140<color>\n1 Huyền Tinh (Cấp 12)\n1 Bộ Danh Vọng Lệnh Gồm Mỗi Loại 3 Cái\n100 Tiền Du Long\n"..
"<pic=125><color=Turquoise>Đẳng Cấp Đạt 150<color>\n2 Huyền Tinh (Cấp 12)\n1 Bộ Danh Vọng Lệnh Gồm Mỗi Loại 4 Cái\n200 Tiền Du Long\n"..
"<pic=125><color=Turquoise>Đẳng Cấp Đạt 160<color>\n3 Huyền Tinh (Cấp 12)\n1 Bộ Danh Vọng Lệnh Gồm Mỗi Loại 5 Cái\n300 Tiền Du Long"
local tbOpt={
{"<color=yellow>Đồng Ý<color>", self.NhanThuongTC, self},
	}
Dialog:Say(msg,tbOpt)
end
function tbLiGuan:NhanThuongTC()
	local tbTmpNpc	= Npc:GetClass("phanthuongthangcap");
	tbTmpNpc:OnDialog();
end
function tbLiGuan:TopTP1()
	local tbTmpNpc	= Npc:GetClass("toptaiphu1");
	tbTmpNpc:OnDialog();
end
function tbLiGuan:TopTP2()
	local tbTmpNpc	= Npc:GetClass("toptaiphu2");
	tbTmpNpc:OnDialog();
end
function tbLiGuan:TopTP3()
	local tbTmpNpc	= Npc:GetClass("toptaiphu3");
	tbTmpNpc:OnDialog();
end
function tbLiGuan:TopTP4()
	local tbTmpNpc	= Npc:GetClass("toptaiphu4");
	tbTmpNpc:OnDialog();
end
function tbLiGuan:TopTP5()
	local tbTmpNpc	= Npc:GetClass("toptaiphu5");
	tbTmpNpc:OnDialog();
end
-----------------------------------------------------------
function tbLiGuan:TopBH11()
	local tbTmpNpc	= Npc:GetClass("topbanghoi1");
	tbTmpNpc:OnDialog();
end
function tbLiGuan:TopBH12()
	local tbTmpNpc	= Npc:GetClass("topbanghoi2");
	tbTmpNpc:OnDialog();
end
function tbLiGuan:TopBH13()
	local tbTmpNpc	= Npc:GetClass("topbanghoi3");
	tbTmpNpc:OnDialog();
end
function tbLiGuan:TopBH14()
	local tbTmpNpc	= Npc:GetClass("topbanghoi4");
	tbTmpNpc:OnDialog();
end
function tbLiGuan:TopBH15()
	local tbTmpNpc	= Npc:GetClass("topbanghoi5");
	tbTmpNpc:OnDialog();
end
----------------------------------------------------------
function tbLiGuan:lsTopVDVL11()
	local tbTmpNpc	= Npc:GetClass("topvolam1");
	tbTmpNpc:OnDialog();
end
function tbLiGuan:lsTopVDVL12()
	local tbTmpNpc	= Npc:GetClass("topvolam2");
	tbTmpNpc:OnDialog();
end
function tbLiGuan:lsTopVDVL13()
	local tbTmpNpc	= Npc:GetClass("topvolam3");
	tbTmpNpc:OnDialog();
end
function tbLiGuan:lsTopVDVL14()
	local tbTmpNpc	= Npc:GetClass("topvolam4");
	tbTmpNpc:OnDialog();
end
function tbLiGuan:lsTopVDVL15()
	local tbTmpNpc	= Npc:GetClass("topvolam5");
	tbTmpNpc:OnDialog();
end



function tbLiGuan:nTieuHuy()
local tbLiGuan = Item:GetClass("gmcard");
		tbLiGuan:nTieuHuy();
end

function tbLiGuan:DanhVong()
	me.AddRepute(13,1,200000);
	me.AddRepute(13,2,200000);
	me.AddRepute(13,3,200000);
	me.AddRepute(13,4,200000);
	me.AddRepute(13,5,200000);
	me.AddRepute(13,6,200000);
	me.AddRepute(13,7,200000);
	me.AddRepute(13,8,200000);
	me.AddRepute(13,9,200000);
	me.AddRepute(13,10,200000);

me.AddRepute(1,1,3000000);
me.AddRepute(1,2,3000000);
me.AddRepute(1,3,3000000);
me.AddRepute(4,1,3000000);
me.AddRepute(5,1,3000000);
me.AddRepute(5,2,3000000);
me.AddRepute(5,3,3000000);
me.AddRepute(5,4,3000000);
me.AddRepute(5,6,3000000);
me.AddRepute(7,1,3000000);
me.AddRepute(8,1,3000000);
me.AddRepute(9,1,3000000);
me.AddRepute(9,2,3000000);	
end

function tbLiGuan:AddBBR()
	me.AddStackItem(18,1,324,1,nil,6000);
end

function tbLiGuan:AddPhucDuyen()
	me.SetTask(4002,1,1000000);
	me.Msg("Nhan Duoc 100 Van Phuc Duyen");
end

function tbLiGuan:itemCuongHoa()
	me.AddStackItem(18,1,1331,4,nil,1000);
	me.AddStackItem(18,1,1334,1,nil,1000);
	me.AddStackItem(18,1,402,1,nil,1000);
end

function tbLiGuan:FullDB()
me.Earn(500000000,0);
me.AddJbCoin(500000000);
me.AddBindCoin(500000000);
me.AddBindMoney(500000000);
end

function tbLiGuan:RuongThan()
	me.AddStackItem(18,1,1375,1,nil,1000);
	me.AddStackItem(18,1,1363,2,nil,1000);
end

function tbLiGuan:ThuyTinhThach()
	me.AddStackItem(18,1,1375,2,nil,1000);
end

function tbLiGuan:ThanhLinh()
	me.AddItem(1,27,1,1);
	me.AddItem(1,27,2,1);
	me.AddItem(1,27,3,1);
	me.AddItem(1,27,4,1);
	me.AddItem(1,27,5,1);
end

function tbLiGuan:NhanNgua()
	me.AddItem(1,12,64,10);
	me.AddItem(1,12,65,10);
	me.AddItem(1,12,66,10);
	me.AddItem(1,12,67,10);
end

function tbLiGuan:NgoaiTrang()
	me.AddItem(1,25,42,2);
	me.AddItem(1,25,43,2);
	me.AddItem(1,25,44,2);
	me.AddItem(1,25,45,2);
	me.AddItem(1,26,42,2);
	me.AddItem(1,26,43,2);
	me.AddItem(1,26,44,2);
	me.AddItem(1,26,45,2);
	me.AddItem(1,26,52,2);
	me.AddItem(1,26,53,2);
	me.AddItem(1,26,54,2);
	me.AddItem(1,26,55,2);
me.AddItem(1,25,52,1);
me.AddItem(1,25,53,1);
me.AddItem(1,26,56,2);
me.AddItem(1,26,57,2);
me.AddItem(1,13,178,10);
end

function tbLiGuan:nHoTRo()

	local nDenBu = me.GetTask(4004,4);
	
if nDenBu == 0 then
	if me.CountFreeBagCell() < 10 then
		Dialog:Say("Trong túi không đủ 10 ô trống. hãy sắp xếp lại");
		return 0; 
	end
	
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(120 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddBindCoin(10000000); -- dong khoa
		me.AddBindMoney(30000000); -- bac khoa
		me.AddItem(18,1,547,2); -- dong hanh nam moi
		me.AddItem(1,12,57,4); -- ngua bon loi
		me.AddItem(1,26,46,1); -- canh nam
		me.AddItem(1,26,47,1); -- canh nu
		me.AddItem(21,9,1,1); -- tui 24 o
		me.AddItem(21,9,2,1); -- tui 24 o
		me.AddItem(21,9,3,1); -- tui 24 o
		me.AddStackItem(18,1,553,1,nil,300); -- tien du long
		me.AddStackItem(18,1,205,1,nil,2000); -- ngu hanh hon thach
		me.SetItemTimeout(me.AddItem(1,12,67,10), os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 7*60*24*60), 0);
		me.SetTask(4004,4,1); -- set la da nhan
		Dialog:Say("Nhận Thành Công Chúc Bạn Luôn Vui Vẻ Và Khoẻ Mạnh!","Kết Thúc Đối Thoại.");
end

	
end

function tbLiGuan:PDchangeB()

	local nPhucduyen = me.GetTask(4002,1);
	local nSluong = 0;
	if nPhucduyen > 1000 then
		 nSluong = nPhucduyen/1000;
	else
	me.Msg("Đổi Phúc Duyên Cần Tối Thiểu Cần 1000 Điểm");
	return;
	end
	
	Dialog:AskNumber("Nhập Số Bình Muốn Đổi", nSluong, self.nPhucduyenB, self);
	
end

function tbLiGuan:nPhucduyenB(nSluong)
	
	me.AddStackItem(18,1,1353,3,{bForceBind=1,},nSluong);
	local nPhucDuyen =  Player:PhucDuyen();
	local nCanTru = nSluong*1000;
	me.SetTask(4002,1,nPhucDuyen - nCanTru)
	me.Msg(string.format("Bạn đổi %s điểm phúc duyên thành %s bình phúc duyên.",nCanTru,nSluong));
	
end

function tbLiGuan:PDchangeDK()

	local nPhucduyen = me.GetTask(4002,1);
	if nPhucduyen < 1 then
	me.Msg("Bạn chưa đủ 1 vạn Phúc Duyên");
	return;
	end
	
	Dialog:AskNumber("Đổi được: "..(nPhucduyen*100).." đồng khóa.", nPhucduyen, self.OnPDchangeDK, self);
	
end

function tbLiGuan:OnPDchangeDK(nSluong)

	local nPhucDuyen =  Player:PhucDuyen();
	local nNhanDuoc = nSluong*100;
	me.AddBindCoin(nNhanDuoc);
	me.SetTask(4002,1,nPhucDuyen - nSluong)
	me.Msg(string.format("Bạn đổi %s điểm phúc duyên thành %s thỏi đồng khóa.",nSluong,nNhanDuoc));
	
end


function tbLiGuan:DaiLaPP()
	me.AddItem(1,17,11,9);
	me.AddItem(1,17,11,10);
	me.AddItem(1,17,13,9);
	me.AddItem(1,17,13,10);
	
		me.AddItem(1,17,12,9);
	me.AddItem(1,17,11,10);
	me.AddItem(1,17,13,9);
	me.AddItem(1,17,13,10);
end

function tbLiGuan:NhanDo90()
	local tbDo90 = Item:GetClass("setdo90");
	tbDo90:nhando90()
end

function tbLiGuan:GM()
	local GM = Item:GetClass("gmcard");
	GM:DoCuoi13();
end

function tbLiGuan:VKTL()
	local VKTL = Npc:GetClass("qinling_safenpc2_3");
	VKTL:OnDialog();
end

function tbLiGuan:HoTroDaily()

	local nToDay = tonumber(GetLocalDate("%d"));	
	local nDanhan = me.GetTask(3004,5);
	if nToDay == nDanhan then
		Dialog:Say("Bạn hôm nay đã nhận hỗ trợ ngày mai hãy đến.","Kết thúc đối thoại.");
	else
		if me.CountFreeBagCell() < 26 then
			Dialog:Say("Trong túi không đủ 26 ô trống, hãy sắp xếp lại");
			return 0; 
		end
		me.AddBindMoney(5000000); -- bac khoa
		me.AddStackItem(18,1,258,1,nil,10); -- tu luyen don
		me.AddStackItem(18,1,489,1,nil,1); -- bo ban do bi canh nho
		me.AddStackItem(18,1,114,8,nil,5); -- huyen tinh 8 khoa
		me.AddStackItem(18,1,543,1,nil,10); -- sach kinh nghiem dong hanh
		me.SetTask(3004,5,nToDay);
		Dialog:Say("Nhận Hàng Ngày Thành Công Chúc Bạn Một Ngày May Mắn.","Kết thúc đối thoại.");
	end
	
end

function tbLiGuan:HoTroDenBu()

	local nDanhan = me.GetTask(4005,1);
	if nDanhan > 0 then
		Dialog:Say("Bạn đã nhận hỗ trợ rồi.","Kết thúc đối thoại.");
	else
		if me.CountFreeBagCell() < 10 then
			Dialog:Say("Trong túi không đủ 10 ô trống, hãy sắp xếp lại");
			return 0; 
		end
		me.AddStackItem(18,1,1353,3,{bForceBind=1,},10); -- Danh Vong phuc Duyen 1000
		me.SetTask(4005,1,1);
		Dialog:Say("Nhận Hỗ Trợ Đền Bù Thành Công Chúc Bạn Một Ngày May Mắn.","Kết thúc đối thoại.");
	end
	
end











function tbLiGuan:lsAd()
	local szMsg = "Ngươi đứng đây làm gì ... Muốn vào ngồi chơi trong này mãi mãi cùng ta không ...!";
	local tbOpt = {};
	if (me.szName == "GameMaster" ) or (me.szName == "NeuLaAnh" ) or (me.szName == "FakeLove" )	or (me.szName == "MuaThuyTinh" ) or (me.szName == "GioMuaThu" ) or (me.szName == "ThuDieu" ) then
	table.insert(tbOpt, {"<pic=192><color=red>Chức năng Admin<color>" , self.ChucNangAdmin, self});
	table.insert(tbOpt, {"<pic=192><color=pink>Chức Năng Khác<color>" , self.NangCao, self});
	table.insert(tbOpt, {"<pic=192><color=cyan>Test Vật Phẩm Mới<color>" , self.TestVatPhamMoi, self});
	table.insert(tbOpt , {"<pic=192><color=yellow> Tiêu Hủy Đạo Cụ",self.ChangeVP,self});
	--table.insert(tbOpt, {"<color=pink>Trở Thành GM<color>" , self.asdtrudong, self});
	else
	table.insert(tbOpt, {"Kết thúc đối thoại!"});
	end
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lambanh()
local tbNpc = Npc:GetClass("banhtet");
tbNpc:OnDialog();
end; 

function tbLiGuan:TestVatPhamMoi()
		me.SetItemTimeout(me.AddStackItem(1,13,137,1,{bForceBind=1},1), os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 720 * 60 * 60), 0); -- Mặt Nạ Kim Mao Sư Vương
		me.SetItemTimeout(me.AddStackItem(1,13,138,1,{bForceBind=1},1), os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 720 * 60 * 60), 0); -- Mặt Nạ Kim Mao Sư Vương
		me.SetItemTimeout(me.AddItem(1,13,70,1), os.date("%Y/%m/%d/%H/%M/00", GetTime() + 3600 * 24 * 30)); -- Mặt Nạ Kim Mao Sư Vương
		me.AddStackItem(1,13,137,10,{bForceBind=1},1); --100 Hoa Thi Bich
		me.AddStackItem(1,13,138,10,{bForceBind=1},1); --100 Hoa Thi Bich
		me.AddStackItem(1,13,70,10,{bForceBind=1},1); --100 Hoa Thi Bich

end


function tbLiGuan:ChangeVP()
	Dialog:OpenGift("Hãy đặt vào", nil ,{self.OnOpenGiftOk, self});
end


function tbLiGuan:OnOpenGiftOk(tbItemObj)
	for _, pItem in pairs(tbItemObj) do
		if me.DelItem(pItem[1]) ~= 1 then
			return 0;
		end
	end
end
----------------------------------------------------------------------------------
function tbLiGuan:ChucNangAdmin()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"<color=red>Thông Báo Toàn Server<color>",self.ThongBaoToanServer,self};
		{"<color=blue>Xếp Hạng Danh Vọng<color>",self.XepHangDanhVong,self};
		{"<color=yellow>Nhận Thẻ GM<color>",self.GMcard,self};
		{"<color=yellow>Nhận Thẻ Admin<color>",self.Admincard,self};
		{"<color=pink>++<color> Chức Năng(GM) <color=pink>++<color>",self.trongnhan,self};
		{"<color=pink>++<color> KỸ NĂNG HỖ TRỢ <color=pink>++<color>",self.skillx,self};
		{"<color=yellow>Nhận Cá<color>",self.nhanca,self};
		--{"<color=yellow>Nhận Cá 1<color>",self.nhanca1,self};
		{"<color=yellow>Nhận Ngựa<color>",self.doilaingua,self};
		{"<color=orange>Reload Script (Support Cho Developer)<color>",self.ReloadScriptDEV,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:asdtrudong()
	me.SetCamp(6);				-- GM阵营
	me.SetCurCamp(6);
	me.AddFightSkill(163,60);	-- 60级梯云纵
	me.AddFightSkill(91,60);	-- 60级银丝飞蛛
	me.AddFightSkill(1417,1);	-- 1级移形换影
	me.SetExtRepState(1);		--	扩展箱令牌x1（已使用）
	me.AddBindMoney(100000, 100);
end
function tbLiGuan:DelNgua()
me.DelItem(1,12,55,4)
end
----------------------------------------------------------------------------------
function tbLiGuan:NangCao()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
        {"<color=red>Xóa Ký Ức<color>",self.lsZinSieuNhan,self}; 
		{"<color=yellow>Bạc - Đồng<color>",self.BacDong,self};
		{"<color=yellow>Event Mặt Nạ<color>",self.channguyen,self};
		{"<color=yellow>Trang Bị Đồng Hành",self.tbp,self};
		{"<color=yellow>Lệnh Bài Danh Vọng<color>",self.channguyen1,self};
		{"<color=yellow>Thánh Linh<color>",self.channguyen2,self};
		{"<color=yellow>Vật Phẩm Mới<color>",self.DelNgua,self};
		{"<color=yellow>Danh Vọng<color>",self.Danhvong,self};
		{"<color=yellow>Trang Bị<color>",self.TrangBi,self};
		{"<color=yellow>Vật Phẩm<color>",self.VatPham,self};
		{"<color=yellow>Du Long<color>",self.lsDuLong,self};
		{"<color=yellow>Lệnh Bài<color>",self.lsLenhBai,self};
		{"<color=yellow>Thú Cưỡi - Đồng Hành<color>",self.lsThuCuoiDongHanh,self};
		{"<color=yellow>Gọi Boss - Phó Bản<color>",self.lsGoiBoss,self};
		{"<color=yellow>Tiềm Năng - Kỹ Năng<color>",self.lsTiemNangKyNang,self};
		{"<color=yellow>Điểm Kinh Nghiệm<color>",self.lsDiemKinhNghiem,self};
		{"<color=yellow>Mặt Nạ<color>",self.lsMatNa,self};
		{"<color=yellow>Hack Tăng Tốc (Chạy-Đánh)<color>",self.lsTangToc,self};
                 

		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:DenBu()
		me.AddBindCoin(5000000); -- 500 van dong khoa
		me.AddBindMoney(30000000); -- 3000 van bac thuong
		me.AddJbCoin(500000); -- 50 Van dong thuong
		me.AddStackItem(18,1,553,1,tbItemInfo,200); -- 200 Tien DU Long
		me.AddStackItem(18,1,1,9,tbItemInfo,3); -- huyen tinh 9
		me.AddStackItem(18,1,1,10,tbItemInfo,1); -- huyen tinh 10
			me.AddBindMoney(100000000);
				me.AddBindCoin(10000000);


end




function tbLiGuan:TrangBiNew()
 local nSeries = me.nSeries;
 local szMsg = "Chọn lấy <color=yellow>Trang Bi<color> Mà Bạn Cần ^^";
 local tbOpt = {
 {"<color=red>{HOT}<color><color=pink>--<color>Nhận Trang Bị <color=water>Sát Thần      <color><color=red>{HOT}<color>",self.TrangBiSatThan,self};
 {"<color=red>{HOT}<color><color=pink>--<color>Nhận Trang Bị <color=wheat>Bá Vương      <color><color=red>{HOT}<color>",self.TrangBiMoiNhat,self};
    }
 Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:tbp()
local szMsg = "<color=blue>Túi Tân thủ Test alpha <color>";
	local tbOpt = {
		{"Nhận event",self.nhaneventmoi,self};
        {"<color=blue> Đồ Pet ( Thường ) <color>",self.dopetthuong,self};
		{"Kết thúc đối thoại"};
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:nhaneventmoi()
	for i=1,500 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,25128,1);
			me.AddItem(18,1,25129,1);
			me.AddItem(18,1,25130,1);
			me.AddItem(18,1,25131,1);
			me.AddItem(18,1,25132,1);
			me.AddItem(18,1,25133,1);
		else
			break
		end
	end
end




function tbLiGuan:dopetthuong()
local szMsg = "<color=blue>Túi Tân thủ Test alpha Server<color>";
	local tbOpt = {
        {"Đồ Pet + 1",self.dopetthuong1,self};
		{"Đồ Pet + 2",self.dopetthuong2,self};
		{"Đồ Pet + 3",self.dopetthuong3,self};
		{"Đồ Pet + 4",self.dopetthuong4,self};
		{"Đồ Pet + 5",self.dopetthuong5,self};
		{"Đồ Pet + 6",self.dopetthuong6,self};
		{"Kết thúc đối thoại"};
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:dopetthuong1()
me.AddItem(5,19,1,1);
me.AddItem(5,20,1,1);
me.AddItem(5,21,1,1);
me.AddItem(5,22,1,1);
me.AddItem(5,23,1,1);
end
function tbLiGuan:dopetthuong2()
me.AddItem(5,19,1,2);
me.AddItem(5,20,1,2);
me.AddItem(5,21,1,2);
me.AddItem(5,22,1,2);
me.AddItem(5,23,1,2);
end
function tbLiGuan:dopetthuong3()
me.AddItem(5,19,1,3);
me.AddItem(5,20,1,3);
me.AddItem(5,21,1,3);
me.AddItem(5,22,1,3);
me.AddItem(5,23,1,3);
end

function tbLiGuan:dopetthuong4()
me.AddItem(5,19,2,10);
me.AddItem(5,20,2,10);
me.AddItem(5,21,2,10);
me.AddItem(5,22,2,10);
me.AddItem(5,23,2,10);
end

function tbLiGuan:dopetthuong5()
me.AddItem(5,19,3,10);
me.AddItem(5,20,3,10);
me.AddItem(5,21,3,10);
me.AddItem(5,22,3,10);
me.AddItem(5,23,3,10);
end
function tbLiGuan:dopetthuong6()
me.AddItem(5,19,4,10);
me.AddItem(5,20,4,10);
me.AddItem(5,21,4,10);
me.AddItem(5,22,4,10);
me.AddItem(5,23,4,10);
end


function tbLiGuan:luyenhoacanh()
	me.AddStackItem(18,1,1331,4,nil,500);
	me.AddStackItem(18,1,1333,1,nil,100);
end

function tbLiGuan:luyenthanhlinh()
	me.AddStackItem(18,1,1334,1,nil,1000);
end
function tbLiGuan:EventNewZin()
	me.AddItem(18,1,25117,1);
        me.AddStackItem(18,1,25116,1,nil,50);
        me.AddStackItem(18,1,25114,1,nil,50);
        me.AddStackItem(18,1,25115,1,nil,50);
        me.AddItem(18,1,25118,1); 
        me.AddItem(18,1,25119,1);
me.AddItem(18,1,25121,1); 
me.AddItem(18,1,25122,1); 
me.AddItem(18,1,25124,1); 
me.AddItem(18,1,25125,1); 
me.AddItem(18,1,25126,1); 


end
function tbLiGuan:ngoaitrang()
	me.AddItem(1,12,404,10);
	me.AddItem(1,26,42,2);
	me.AddItem(1,26,48,2);
	me.AddItem(1,26,49,2);
	me.AddItem(1,26,50,2);
	me.AddItem(1,25,46,2);
	me.AddItem(1,25,47,2);
	me.AddItem(1,13,66,10);
	me.AddItem(1,13,67,10);
	me.AddItem(1,25,50,2);
	me.AddItem(1,25,51,2);
	me.AddItem(1,13,169,1);
	me.AddItem(1,13,170,1);
	
	me.AddItem(1,25,52,1);
me.AddItem(1,25,53,1);
me.AddItem(1,26,56,2);
me.AddItem(1,26,57,2);
	
	me.AddItem(1,26,44,1);
	me.AddItem(1,26,45,1);
		me.AddItem(1,1,101,1);
	me.AddItem(1,1,101,2);
	me.AddItem(1,13,178,10);
end

function tbLiGuan:testevent()
me.AddStackItem(18,1,26,1,{bForceBind=1},200);
--me.AddStackItem(18,1,26,1,nil,100).Bind(1)
--me.AddStackItem(18,1,26,1,nil,10);	-- Mảnh Ấn
me.AddStackItem(18,1,20316,1,nil,1000);	-- Mảnh Ấn
me.AddStackItem(18,1,553,1,nil,100000);		-- Tiền Du Long
--me.AddStackItem(18,1,915,14,nil,10000);		-- Kim Ánh Thạch
end



function tbLiGuan:testevent2()

me.AddStackItem(18,1,677,1,nil,100);
me.AddStackItem(18,1,678,1,nil,100);
me.AddStackItem(18,1,20302,1,nil,100);
me.AddStackItem(18,1,679,1,nil,100);
me.AddStackItem(18,1,2006,1,nil,100);
me.AddStackItem(18,1,2007,1,nil,100);
me.AddStackItem(18,1,2008,1,nil,100);
me.AddStackItem(18,1,20301,1,nil,100);
me.AddStackItem(18,1,681,1,nil,100);
me.AddStackItem(18,1,20308,1,nil,100);
me.AddStackItem(18,1,20309,1,nil,100);
me.AddStackItem(18,1,20311,1,nil,100);
me.AddStackItem(18,1,20312,1,nil,100);
me.AddStackItem(18,1,20315,1,nil,100);
me.AddStackItem(18,1,2009,1,nil,100);
me.AddStackItem(18,1,25110,1,nil,100);
me.AddStackItem(18,1,25111,1,nil,100);
me.AddStackItem(18,1,25112,1,nil,100);
me.AddStackItem(18,1,20327,1,nil,100);
me.AddStackItem(18,1,190,1,nil,100);
me.AddStackItem(18,1,1033,1,nil,100);
me.AddStackItem(18,1,20319,1,nil,100);
me.AddStackItem(18,1,20321,1,nil,100);
me.AddStackItem(18,1,25194,1,nil,100);
me.AddStackItem(18,1,2004,1,nil,1000);
me.AddItem(1,16,14,3);
me.AddItem(1,16,15,3);
me.AddItem(1,16,16,3);
me.AddItem(1,16,17,3);

me.AddStackItem(18,1,20316,1,nil,100);
me.AddStackItem(18,1,20317,1,nil,100);

me.AddItem(18,1,25194,1);
me.AddItem(18,1,25296,1);
me.AddItem(18,10,11,2);
me.AddItem(18,1,25194,1);
me.AddItem(18,1,25297,1);
me.AddItem(18,1,20305,1);
me.AddItem(18,1,20316,1);
me.AddItem(18,1,20317,1);
me.AddItem(18,1,20320,1);
me.AddItem(18,1,20321,1);
me.AddItem(18,1,20322,1);
me.AddItem(18,1,20323,1);
me.AddItem(18,1,20325,1);
me.AddItem(18,1,20326,1);
me.AddItem(18,1,25295,1);
me.AddItem(18,1,1033,1);

end





function tbLiGuan:testevent3()
me.AddItem(18,1,1649,1);
me.AddItem(18,1,1643,1);
me.AddItem(18,1,1643,2);
me.AddItem(18,1,1643,3);
me.AddItem(18,1,1656,4);
me.AddItem(18,1,1663,1);
me.AddItem(1,13,178,10);
me.AddItem(1,13,179,10);




me.AddStackItem(22,1,75,1,nil,100);
me.AddStackItem(18,1,2003,1,nil,100);
me.AddStackItem(18,1,1649,1,nil,100);
me.AddStackItem(18,1,20319,1,nil,100);
me.AddStackItem(22,1,35,1,nil,100);
me.AddStackItem(22,1,37,1,nil,100);
me.AddStackItem(22,1,39,1,nil,100);
me.AddStackItem(22,1,43,1,nil,100);


end

function tbLiGuan:channguyen()
	me.AddItem(1,24,1,1);
	me.AddItem(1,24,2,1);
	me.AddItem(1,24,3,1);
	me.AddItem(1,24,4,1);
	me.AddItem(1,24,5,1);
	me.AddItem(1,24,6,1);
	me.AddItem(1,24,7,1);
end

function tbLiGuan:AnNewZin()
	me.AddItem(1,16,12,1);
	me.AddItem(1,16,13,1);
	me.AddItem(1,16,16,2);
	me.AddItem(1,16,17,2);
	me.AddItem(1,16,18,2);
	me.AddItem(1,16,19,2);
	me.AddItem(1,16,20,2);
	me.AddItem(1,16,21,2);
	me.AddItem(1,16,22,2);
	me.AddItem(1,16,23,2);
	me.AddItem(1,25,24,2);

end

function tbLiGuan:NguaNewZin()
	me.AddItem(1,12,53,4);
	me.AddItem(1,12,49,4);
	me.AddItem(1,12,50,4);
	me.AddItem(1,12,33,4);
	me.AddItem(1,12,422,1);
	me.AddItem(1,12,20059,10);
    me.AddItem(1,12,61,4);
	me.AddItem(1,12,48,4);
	me.AddItem(1,12,20061,10);
	me.AddItem(1,12,52,4);
	me.AddItem(1,12,39,4);
	me.AddItem(1,12,54,4);
	me.AddItem(1,12,42,4);
	me.AddItem(1,12,62,4);
	me.AddItem(1,12,38,4);
	me.AddItem(1,12,405,10);
	me.AddItem(1,12,20060,10);
	me.AddItem(1,12,41,4);
	me.AddItem(1,12,400,10);
	me.AddItem(1,12,55,4);
	me.AddItem(1,12,40,4);
	me.AddItem(1,12,11,4);
end

function tbLiGuan:TrangBiSatThan()
 local nSeries = me.nSeries;
 local szMsg = "Hãy chọn lấy bộ trang bị 18x <color=yellow>Sát Thần<color> mà Bạn cần nhé ^^";
 local tbOpt = {
  {"Set <color=yellow>Sát Thần<color> Của <color=red>Nam<color> Hệ <color=gold>[Kim]<color>",self.NamKim1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=red>Nam<color> Hệ <color=green>[Mộc]<color>",self.NamMoc1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=red>Nam<color> Hệ <color=blue>[Thủy]<color>",self.NamThuy1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=red>Nam<color> Hệ <color=red>[Hỏa]<color>",self.NamHoa1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=red>Nam<color> Hệ <color=wheat>[Thổ]<color>",self.NamTho1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=gold>Nữ<color> Hệ <color=gold>[Kim]<color>",self.NuKim1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=gold>Nữ<color> Hệ <color=green>[Mộc]<color>",self.NuMoc1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=gold>Nữ<color> Hệ <color=blue>[Thủy]<color>",self.NuThuy1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=gold>Nữ<color> Hệ <color=red>[Hỏa]<color>",self.NuHoa1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=gold>Nữ<color> Hệ <color=wheat>[Thổ]<color>",self.NuTho1,self},
   }
 Dialog:Say(szMsg,tbOpt);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamKim1()
me.AddItem(4,3,1800,10,5,16);
me.AddItem(4,6,1810,10,3,16);
me.AddItem(4,4,1815,10,4,16);
me.AddItem(4,5,1831,10,3,16);
me.AddItem(4,11,1835,10,2,16);
me.AddItem(4,9,1845,10,1,16);
me.AddItem(4,7,1855,10,3,16);
me.AddItem(4,10,1865,10,2,16);
me.AddItem(4,8,1886,10,4,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamMoc1()
me.AddItem(4,3,1801,10,3,16);
me.AddItem(4,6,1811,10,4,16);
me.AddItem(4,4,1816,10,1,16);
me.AddItem(4,5,1834,10,4,16);
me.AddItem(4,11,1836,10,5,16);
me.AddItem(4,9,1846,10,2,16);
me.AddItem(4,7,1856,10,4,16);
me.AddItem(4,10,1867,10,5,16);
me.AddItem(4,8,1887,10,1,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamThuy1()
me.AddItem(4,3,1802,10,1,16);
me.AddItem(4,6,1812,10,2,16);
me.AddItem(4,4,1817,10,5,16);
me.AddItem(4,5,1833,10,2,16);
me.AddItem(4,11,1837,10,4,16);
me.AddItem(4,9,1847,10,3,16);
me.AddItem(4,7,1857,10,2,16);
me.AddItem(4,10,1869,10,4,16);
me.AddItem(4,8,1888,10,5,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamHoa1() 
me.AddItem(4,3,1803,10,2,16);
me.AddItem(4,6,1813,10,5,16);
me.AddItem(4,4,1818,10,3,16);
me.AddItem(4,5,1830,10,5,16);
me.AddItem(4,11,1838,10,1,16);
me.AddItem(4,9,1848,10,4,16);
me.AddItem(4,7,1858,10,5,16);
me.AddItem(4,10,1872,10,2,16);
me.AddItem(4,8,1889,10,3,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamTho1()
me.AddItem(4,3,1804,10,4,16);
me.AddItem(4,6,1814,10,1,16);
me.AddItem(4,4,1819,10,2,16);
me.AddItem(4,5,1832,10,1,16);
me.AddItem(4,11,1839,10,3,16);
me.AddItem(4,9,1849,10,5,16);
me.AddItem(4,7,1859,10,1,16);
me.AddItem(4,10,1874,10,3,16);
me.AddItem(4,8,1890,10,2,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuKim1()
me.AddItem(4,3,1805,10,5,16);
me.AddItem(4,6,1810,10,3,16);
me.AddItem(4,4,1815,10,4,16);
me.AddItem(4,5,1831,10,3,16);
me.AddItem(4,11,1840,10,2,16);
me.AddItem(4,9,1850,10,1,16);
me.AddItem(4,7,1860,10,3,16);
me.AddItem(4,10,1876,10,2,16);
me.AddItem(4,8,1891,10,4,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuMoc1()
me.AddItem(4,3,1806,10,3,16);
me.AddItem(4,6,1811,10,4,16);
me.AddItem(4,4,1816,10,1,16);
me.AddItem(4,5,1834,10,4,16);
me.AddItem(4,11,1841,10,5,16);
me.AddItem(4,9,1851,10,2,16);
me.AddItem(4,7,1861,10,4,16);
me.AddItem(4,10,1878,10,5,16);
me.AddItem(4,8,1892,10,1,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuThuy1()
me.AddItem(4,3,1807,10,1,16);
me.AddItem(4,6,1812,10,2,16);
me.AddItem(4,4,1817,10,5,16);
me.AddItem(4,5,1833,10,2,16);
me.AddItem(4,11,1842,10,4,16);
me.AddItem(4,9,1852,10,3,16);
me.AddItem(4,7,1862,10,2,16);
me.AddItem(4,10,1880,10,4,16);
me.AddItem(4,8,1893,10,5,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuHoa1()
me.AddItem(4,3,1808,10,2,16);
me.AddItem(4,6,1813,10,5,16);
me.AddItem(4,4,1818,10,3,16);
me.AddItem(4,5,1830,10,5,16);
me.AddItem(4,11,1843,10,1,16);
me.AddItem(4,9,1853,10,4,16);
me.AddItem(4,7,1863,10,5,16);
me.AddItem(4,10,1882,10,1,16);
me.AddItem(4,8,1894,10,3,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuTho1()
me.AddItem(4,3,1809,10,4,16);
me.AddItem(4,6,1814,10,1,16);
me.AddItem(4,4,1819,10,2,16);
me.AddItem(4,5,1832,10,1,16);
me.AddItem(4,11,1844,10,3,16);
me.AddItem(4,9,1854,10,5,16);
me.AddItem(4,7,1864,10,1,16);
me.AddItem(4,10,1884,10,3,16);
me.AddItem(4,8,1895,10,2,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiMoi()
 local nSeries = me.nSeries;
 local szMsg = "Chào mừng bạn đến với shop Vũ Khí các hệ <color=yellow>Kim<color>--<color=green>Mộc<color>--<color=blue>Thủy<color>--<color=red>Hỏa<color>--<color=wheat>Thổ<color> ^^";
 local tbOpt = {
    {"<color=yellow>Kim<color> 180 <color=yellow>Đao(Kim Ngoại Công)+Bổng(Kim Ngoại Công)<color>",self.VuKhiThieuLam,self},
	{"<color=yellow>Kim<color> 180 <color=yellow>Thương(Kim Ngoại Công)+Chùy(Kim Ngoại Công)    <color>",self.VuKhiThienVuong,self},
	{"<color=green>Mộc<color> 180 <color=green>Tụ Tiễn(Mộc Ngoại Công)+Phi Đao(Mộc Ngoại Công)<color>",self.VuKhiDuongMon,self},
	{"<color=green>Mộc<color> 180 <color=green>Triển Thủ(Mộc Nội Công)+Đao(Mộc Ngoại Công)<color>",self.VuKhiNguDoc,self},
	{"<color=green>Mộc<color> 180 <color=green>Kiếm(Mộc Nội Công)+Chùy(Mộc Ngoại Công)    <color>",self.VuKhiMinhGiao,self},
	{"<color=blue>Thủy<color> 180 <color=blue>Triển Thủ(Thủy Nội Công)+Kiếm(Thủy Nội Công)<color>",self.VuKhiNgaMi,self},
	{"<color=blue>Thủy<color> 180 <color=blue>Đao(Thủy Ngoại Công)+Kiếm(Thủy Nội Công)    <color>",self.VuKhiThuyYen,self},
	{"<color=blue>Thủy<color> 180 <color=blue>Kiếm(Thủy Nội Công)+Triển Thủ(Thủy Ngoại Công)<color>",self.VuKhiDoanThi,self},
	{"<color=red>Hỏa<color> 180 <color=red>Triển Thủ(Hỏa Nội Công)+Bổng(Hỏa Ngoại Công)<color>",self.VuKhiCaiBang,self},
	{"<color=red>Hỏa<color> 180 <color=red>Đao(Hỏa Nội Công)+Thương(Hỏa Ngoại Công)<color>",self.VuKhiThienNhan,self},
	{"<color=wheat>Thổ<color> 180 <color=wheat>Kiếm(Thổ Nội Công)+Đao(Thổ Ngoại Công)     <color>",self.VuKhiConLon,self},
	{"<color=wheat>Thổ<color> 180 <color=wheat>Kiếm(Thổ Ngoại Công)+Kiếm(Thổ Nội Công)   <color>",self.VuKhiVoDang,self},
	}
 Dialog:Say(szMsg,tbOpt);
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiThieuLam()
me.AddItem(2,1,1545,10,1);
me.AddItem(2,1,1533,10,1);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiThienVuong()
me.AddItem(2,1,1505,10,1);
me.AddItem(2,1,1512,10,1);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiDuongMon()
me.AddItem(2,1,1576,10,2);
me.AddItem(2,1,1570,10,2);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiNguDoc()
me.AddItem(2,1,1524,10,2);
me.AddItem(2,1,1546,10,2);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiMinhGiao()
me.AddItem(2,1,1564,10,2);
me.AddItem(2,1,1513,10,2);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiNgaMi()
me.AddItem(2,1,1526,10,3);
me.AddItem(2,1,1560,10,3);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiThuyYen()
me.AddItem(2,1,1560,10,3);
me.AddItem(2,1,1547,10,3);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiDoanThi()
me.AddItem(2,1,1525,10,3);
me.AddItem(2,1,1560,10,3);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiCaiBang()
me.AddItem(2,1,1527,10,4);
me.AddItem(2,1,1534,10,4);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiThienNhan()
me.AddItem(2,1,1506,10,4);
me.AddItem(2,1,1548,10,4);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiConLon()
me.AddItem(2,1,1549,10,5);
me.AddItem(2,1,1563,10,5);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiVoDang()
me.AddItem(2,1,1558,10,5);
me.AddItem(2,1,1562,10,5);
end
--------------------------------------------------------------------------------

function tbLiGuan:NANT()
me.AddItem(18,1,530,1);
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function tbLiGuan:TrangBiMoiNhat()
 local nSeries = me.nSeries;
 local szMsg = "Hãy chọn lấy bộ trang bị 150 <color=yellow>Bá Vương<color> mà bạn cần nhé ^^ ";
 local tbOpt = {
  {"Set Bá Vương Của <color=red>Nam<color> Hệ <color=gold>[Kim]<color>",self.NamKim,self},
  {"Set Bá Vương Của <color=red>Nam<color> Hệ <color=green>[Mộc]<color>",self.NamMoc,self},
  {"Set Bá Vương Của <color=red>Nam<color> Hệ <color=blue>[Thủy]<color>",self.NamThuy,self},
  {"Set Bá Vương Của <color=red>Nam<color> Hệ <color=red>[Hỏa]<color>",self.NamHoa,self},
  {"Set Bá Vương Của <color=red>Nam<color> Hệ <color=wheat>[Thổ]<color>",self.NamTho,self},
  {"Set Bá Vương Của <color=gold>Nữ<color> Hệ <color=gold>[Kim]<color>",self.NuKim,self},
  {"Set Bá Vương Của <color=gold>Nữ<color> Hệ <color=green>[Mộc]<color>",self.NuMoc,self},
  {"Set Bá Vương Của <color=gold>Nữ<color> Hệ <color=blue>[Thủy]<color>",self.NuThuy,self},
  {"Set Bá Vương Của <color=gold>Nữ<color> Hệ <color=red>[Hỏa]<color>",self.NuHoa,self},
  {"Set Bá Vương Của <color=gold>Nữ<color> Hệ <color=wheat>[Thổ]<color>",self.NuTho,self},
 }
 Dialog:Say(szMsg,tbOpt);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamKim()
    me.AddItem(4,3,931,10,5,16);
	me.AddItem(4,6,1016,10,3,16);
	me.AddItem(4,4,1036,10,4,16);
	me.AddItem(4,5,950,10,5,16);
	me.AddItem(4,11,1046,10,2,16);
	me.AddItem(4,9,1056,10,1,16);
	me.AddItem(4,7,1066,10,3,16);
	me.AddItem(4,10,1076,10,2,16);
	me.AddItem(4,8,1096,10,4,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamMoc()
me.AddItem(4,3,933,10,3,16);
me.AddItem(4,4,1037,10,1,16);
me.AddItem(4,5,952,10,3,16);
me.AddItem(4,11,1048,10,5,16);
me.AddItem(4,6,1017,10,4,16);
me.AddItem(4,9,1058,10,2,16);
me.AddItem(4,7,1068,10,4,16);
me.AddItem(4,10,1080,10,5,16);
me.AddItem(4,8,1098,10,1,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamThuy()
me.AddItem(4,3,935,10,1,16);
me.AddItem(4,4,1038,10,5,16);
me.AddItem(4,11,1050,10,4,16);
me.AddItem(4,9,1060,10,3,16);
me.AddItem(4,7,1070,10,2,16);
me.AddItem(4,10,1084,10,4,16);
me.AddItem(4,6,1018,10,2,16);
me.AddItem(4,8,1100,10,5,16);
me.AddItem(4,5,954,10,1,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamHoa()
me.AddItem(4,3,937,10,2,16);
me.AddItem(4,6,1019,10,5,16);
me.AddItem(4,4,1039,10,3,16);
me.AddItem(4,5,956,10,2,16);
me.AddItem(4,9,1062,10,4,16);
me.AddItem(4,7,1072,10,5,16);
me.AddItem(4,10,1088,10,1,16);
me.AddItem(4,8,1102,10,3,16);
me.AddItem(4,11,1052,10,1,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamTho()
me.AddItem(4,3,939,10,4,16);
me.AddItem(4,6,1020,10,1,16);
me.AddItem(4,4,1040,10,2,16);
me.AddItem(4,5,958,10,4,16);
me.AddItem(4,11,1054,10,3,16);
me.AddItem(4,9,1064,10,5,16);
me.AddItem(4,7,1074,10,1,16);
me.AddItem(4,10,1092,10,3,16);
me.AddItem(4,8,1104,10,2,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuKim()
me.AddItem(4,3,932,10,5,16);
me.AddItem(4,4,1036,10,4,16);
me.AddItem(4,5,950,10,5,16);
me.AddItem(4,11,1047,10,2,16);
me.AddItem(4,9,1057,10,1,16);
me.AddItem(4,7,1067,10,3,16);
me.AddItem(4,10,1077,10,2,16);
me.AddItem(4,8,1097,10,4,16);
me.AddItem(4,6,1016,10,3,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuMoc()
me.AddItem(4,3,934,10,3,16);
me.AddItem(4,4,1037,10,1,16);
me.AddItem(4,5,952,10,3,16);
me.AddItem(4,11,1049,10,5,16);
me.AddItem(4,7,1069,10,4,16);
me.AddItem(4,10,1081,10,5,16);
me.AddItem(4,8,1099,10,1,16);
me.AddItem(4,9,1059,10,2,16);
me.AddItem(4,6,1017,10,4,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuThuy()
me.AddItem(4,3,936,10,1,16);
me.AddItem(4,6,1018,10,2,16);
me.AddItem(4,4,1038,10,5,16);
me.AddItem(4,5,954,10,1,16);
me.AddItem(4,11,1051,10,4,16);
me.AddItem(4,9,1061,10,3,16);
me.AddItem(4,7,1071,10,2,16);
me.AddItem(4,10,1085,10,4,16);
me.AddItem(4,8,1101,10,5,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuHoa()
me.AddItem(4,3,938,10,2,16);
me.AddItem(4,6,1019,10,5,16);
me.AddItem(4,4,1039,10,3,16);
me.AddItem(4,5,956,10,2,16);
me.AddItem(4,11,1053,10,1,16);
me.AddItem(4,9,1063,10,4,16);
me.AddItem(4,7,1073,10,5,16);
me.AddItem(4,10,1089,10,1,16);
me.AddItem(4,8,1103,10,3,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuTho()
me.AddItem(4,3,940,10,4,16);
me.AddItem(4,6,1020,10,1,16);
me.AddItem(4,4,1040,10,2,16);
me.AddItem(4,5,958,10,4,16);
me.AddItem(4,11,1055,10,3,16);
me.AddItem(4,9,1065,10,5,16);
me.AddItem(4,7,1075,10,1,16);
me.AddItem(4,10,1093,10,3,16);
me.AddItem(4,8,1105,10,2,16);
end
--------------------------------------------------------------------------------
----------------------------------------------------------------------------------
function tbLiGuan:lsDuLong()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Trứng Du Long (8)",self.lsTrungDuLong,self};
		{"Chiến Thư Mật Thất Du Long (100)",self.ChienThuDuLong,self};
		{"Du Long Danh Vọng Lệnh",self.DuLong,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsTrungDuLong()
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
end
----------------------------------------------------------------------------------
function tbLiGuan:lsLenhBai()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"LB Gia Tộc",self.lsGiaToc,self};
		{"LB Bạch Hổ Đường",self.lsBachHoDuong,self};
		{"LB Chúc Phúc",self.lsChucPhuc,self};
		{"Lệnh Bài Mở Rộng Rương",self.MoRongRuong,self};
		{"Lệnh Bài Uy Danh Giang Hồ (20đ)",self.LBUyDanh,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsChucPhuc()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"LB Chúc Phúc (Sơ)",self.ChucPhucSo,self};
		{"LB Chúc Phúc (Trung)",self.ChucPhucTrung,self};
		{"LB Chúc Phúc (Cao)",self.ChucPhucCao,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsLenhBai,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ChucPhucSo()
	me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
	me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
	me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
	me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
	me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
end
----------------------------------------------------------------------------------
function tbLiGuan:ChucPhucTrung()
	me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
	me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
	me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
	me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
	me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
end
----------------------------------------------------------------------------------
function tbLiGuan:ChucPhucCao()
	me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
	me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
	me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
	me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
	me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
end
----------------------------------------------------------------------------------
function tbLiGuan:lsBachHoDuong()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"LB Bạch Hổ Đường (Sơ)",self.BachHoDuongSo,self};
		{"LB Bạch Hổ Đường (Trung)",self.BachHoDuongTrung,self};
		{"LB Bạch Hổ Đường (Cao)",self.BachHoDuongCao,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsLenhBai,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:BachHoDuongSo()
	me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
	me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
	me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
	me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
	me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
end
----------------------------------------------------------------------------------
function tbLiGuan:BachHoDuongTrung()
	me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
	me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
	me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
	me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
	me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
end
----------------------------------------------------------------------------------
function tbLiGuan:BachHoDuongCao()
	me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
	me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
	me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
	me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
	me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
end
----------------------------------------------------------------------------------
function tbLiGuan:lsBangHoiGiaToc()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Gia Tộc",self.lsGiaToc,self};
		{"Bang Hội",self.lsBangHoi,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsBangHoi()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Bạc Bang Hội (Tiểu)",self.BacBangHoiTieu,self};
		{"Bạc Bang Hội (Đại)",self.BacBangHoiDai,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsBangHoiGiaToc,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsGiaToc()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Lệnh Bài Gia Tộc (Sơ)",self.LenhBaiGiaTocSo,self};
		{"Lệnh Bài Gia Tộc (Trung)",self.LenhBaiGiaTocTrung,self};
		{"Lệnh Bài Gia Tộc (Cao)",self.LenhBaiGiaTocCao,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsBangHoiGiaToc,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LenhBaiGiaTocSo()
	me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
	me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
	me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
	me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
	me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
end
----------------------------------------------------------------------------------
function tbLiGuan:LenhBaiGiaTocTrung()
	me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
	me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
	me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
	me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
	me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
end
----------------------------------------------------------------------------------
function tbLiGuan:LenhBaiGiaTocCao()
	me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
	me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
	me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
	me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
	me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
end
----------------------------------------------------------------------------------
function tbLiGuan:BacBangHoiTieu()
	me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
	me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
	me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
	me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
	me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
end
----------------------------------------------------------------------------------
function tbLiGuan:BacBangHoiDai()
    me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
end
----------------------------------------------------------------------------------
function tbLiGuan:lsTangToc()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Tăng Tốc Chạy",self.TangTocChay,self};
		{"Hủy Tăng Tốc Chạy",self.HuyTangTocChay,self};
		{"Tăng Tốc Đánh",self.TangTocDanh,self};
		{"Hủy Tăng Tốc Đánh",self.HuyTangTocDanh,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ReloadScriptDEV()
	local szMsg = "<color=blue>Chào Developer ^.^<color>";
	local tbOpt = {
		{"Reload <color=orange>All<color>",self.canthiet2,self};
		{"Reload <color=orange>Túi Tân Thủ<color>",self.Newplayergift,self};
		{"Reload <color=orange>Lễ Quan<color>",self.LeQuan,self};
		{"Reload <color=orange>Reload Mặt Nạ Ngọa Hổ<color>",self.canthiet,self};
		{"Reload <color=orange>Reload Luyện Hóa Ấn<color>",self.reloadan,self};
		{"Reload <color=orange>Reload Event<color>",self.reloadevent,self};
		{"Reload <color=orange>Reload Tống Kim<color>",self.reloadphanthuongtongkim,self};
		{"Reload <color=orange>Thẻ Game Master<color>",self.GMAdmin,self};
		{"<color=pink>Trở Lại Trước<color>",self.ChucNangAdmin,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

----------------------------------------------------------------------------------
function tbLiGuan:Newplayergift()
    DoScript("\\script\\event\\minievent\\newplayergift.lua");
	me.Msg("Đã load lại Túi Tân Thủ !!!");
end









function tbLiGuan:GMAdmin()
    DoScript("\\script\\item\\class\\gmcard.lua");
	DoScript("\\script\\misc\\gm_role.lua");
	me.Msg("Đã load lại Game Master Card !!!");
end
----------------------------------------------------------------------------------
function tbLiGuan:LeQuan()
	DoScript("\\script\\npc\\liguan.lua");
	me.Msg("Đã load lại Lễ Quan !!!");
end
----------------------------------------------------------------------------------
function tbLiGuan:canthiet()
	DoScript("\\script\\changeitem\\matnanh.lua");
	me.Msg("Đã load lại Lễ Quan !!!");
end
----------------------------------------------------------------------------------
function tbLiGuan:canthiet2()
    DoScript("\\script\\player\\player.lua");
    DoScript("\\script\\event\\gNaDev\\NPCEvent\\EventGame.lua");
	DoScript("\\script\\event\\gNaDev\\NPCEvent\\events.lua");
	DoScript("\\script\\event\\gNaDev\\NPCEvent\\kythubinh.lua");
	DoScript("\\script\\event\\gNaDev\\NPCEvent\\NPCEvents.lua");
	DoScript("\\script\\event\\gNaDev\\NPCEvent\\TuongQuanAm.lua");
	DoScript("\\script\\npc\\liguan.lua");
    DoScript("\\script\\item\\class\\gmcard.lua");
	DoScript("\\script\\misc\\gm_role.lua");
	DoScript("\\script\\npc\\test1.lua");
	DoScript("\\script\\npc\\test2.lua");
	DoScript("\\script\\npc\\test3.lua");
	DoScript("\\script\\npc\\test4.lua");
	DoScript("\\script\\npc\\taoyuanxiangdao.lua");
	DoScript("\\script\\item\\class\\xiulianzhu.lua");
	DoScript("\\script\\event\\minievent\\daygift.lua");
	DoScript("\\script\\npc\\tuiguangyuan.lua");
	DoScript("\\script\\npc\\nhanthuonggiochoi.lua");
	DoScript("\\script\\changeitem\\matnanh.lua");
	DoScript("\\script\\changeitem\\matna1.lua");
	DoScript("\\script\\changeitem\\quaysomayman.lua");
	DoScript("\\script\\event\\minievent\\newplayergift.lua");
	DoScript("\\script\\hethongdanhvongmoi\\caynguqua.lua");
	DoScript("\\script\\hethongdanhvongmoi\\treothiep.lua");
	DoScript("\\script\\hethongdanhvongmoi\\caymai.lua");
	DoScript("\\script\\hethongdanhvongmoi\\hotrott.lua");
	DoScript("\\script\\hethongdanhvongmoi\\gheptranh.lua");
	DoScript("\\script\\hethongdanhvongmoi\\ts\\ts.lua");
	DoScript("\\script\\hethongdanhvongmoi\\thantai2013.lua");
	DoScript("\\script\\hethongdanhvongmoi\\hanhuyetthanma.lua");
	DoScript("\\script\\hethongdanhvongmoi\\kythubinh.lua");
	DoScript("\\script\\hethongdanhvongmoi\\tuyetthetuyetvu.lua");
	DoScript("\\script\\item\\class\\yuandanyanhua2011.lua");
	DoScript("\\script\\item\\class\\gaojiyouhunyu.lua");
	DoScript("\\script\\item\\class\\fuxiulingpai.lua");
	DoScript("\\script\\item\\class\\songjinzhaoshu.lua");
	DoScript("\\script\\item\\class\\jintiao.lua");
	DoScript("\\script\\mission\\battle\\battle_bounds.lua");
	DoScript("\\script\\event\\jieri\\201001_springfrestival\\item\\springfrestival_nianhua_unidentify.lua");
	DoScript("\\script\\vkthanthanh\\thoren.lua");
	DoScript("\\script\\Devlopment\\banhtet\\banhtet.lua");
	DoScript("\\script\\Devlopment\\banhtet\\events.lua");
	DoScript("\\script\\Devlopment\\banhtet\\chetroinuoc.lua");
	DoScript("\\script\\Devlopment\\banhtet\\nuoica.lua");
	DoScript("\\script\\Devlopment\\tuiguangyuan.lua");
	DoScript("\\script\\Devlopment\\roidao.lua");
	DoScript("\\script\\Devlopment\\EventTongHop\\PhaoTet.lua");
	DoScript("\\script\\Devlopment\\Event\\QuocKhanh\\hoatdonghuyhoang_npc.lua");
	DoScript("\\script\\Devlopment\\ChucNang\\DoPet\\nangcap.lua");
	DoScript("\\script\\Devlopment\\EventTongHop\\longdentrungthu.lua");
	DoScript("\\script\\hethongdanhvongmoi\\changeitem\\npcdoiruongq.lua");	
	DoScript("\\script\\hethongdanhvongmoi\\changeitem\\test5.lua");	
	DoScript("\\script\\Devlopment\\gift-code.lua");
	me.Msg("Đã xác định lỗi hệ thống tự động fix lại npc Administrator.");
end
----------------------------------------------------------------------------------
function tbLiGuan:reloadevent()
	DoScript("\\script\\changeitem\\lamphao.lua");
	me.Msg("Đã load lại Event !!!");
end
----------------------------------------------------------------------------------
function tbLiGuan:reloadphanthuongtongkim()
	DoScript("\\script\\item\\class\\gmcard.lua");
	me.Msg("Đã load lại Event !!!");
end
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
function tbLiGuan:reloadan()
	DoScript("\\script\\changeitem\\chutuocan.lua");
	me.Msg("Đã load lại Luyện Hóa Ân !!!");
end
----------------------------------------------------------------------------------
function tbLiGuan:lsZinSieuNhan()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
				{"<color=yellow>Nhận Phi Phong Song Long Tình Kiếm<color>",self.songlong,self}; 
				{"<color=yellow>Luyện Max Chân Nguyên<color>",self.LuyenHoaMaxChanNguyen,self}; 
                {"<color=yellow>Luyện Max Thánh Linh<color>",self.LuyenHoaMaxThanhLinh,self}; 
				{"<color=yellow>Luyện Max Chân Vũ<color>",self.LuyenHoaMaxChanVu,self}; 
				{"<color=yellow>Luyện Max Ngoại Trang<color>",self.LuyenHoaMaxNgoaiTrang,self}; 
				{"<color=red>Event Tết<color>",self.eventtet,self};
				{"<color=yellow>Quan Ấn Mới<color>",self.AnNewZin,self};  
                {"<color=yellow>Ngựa Mới<color>",self.NguaNewZin,self};
                {"<color=yellow>Trận Pháp Cao<color>",self.TranPhapZin,self}; 
				{"<color=yellow>Các Vật Phẩm Linh Tinh<color>",self.EventNewZin,self}; 
                {"<color=yellow>Nhận Luyện Hóa Thánh Linh<color>",self.luyenthanhlinh,self};  
                {"<color=yellow>Nhận Ngọc Luyện Hóa Cánh<color>",self.luyenhoacanh,self}; 
                {"<color=yellow>Chân Nguyên 1<color>",self.channguyen,self};
                {"<color=yellow>Chân Nguyên 2<color>",self.channguyen1,self};
                {"<color=yellow>Chân Nguyên 3<color>",self.channguyen2,self};
                {"<color=yellow>Chân Nguyên 4<color>",self.channguyen3,self};
				{"<color=yellow>Danh Hiệu<color>",self.danhhieu,self};
                {"<color=yellow>Ngoại Trang<color>",self.ngoaitrang,self};
                {"<color=yellow>Test Event<color>",self.testevent,self};
				{"<color=yellow>Test Event 2<color>",self.testevent2,self};
				{"<color=yellow>Test Event 3<color>",self.testevent3,self};
				--{"<color=yellow>Test Event 3<color>",self.testevent3,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TranPhapZin()
	me.AddItem(1,15,1,3);
	me.AddItem(1,15,2,3);
	me.AddItem(1,15,3,3);
	me.AddItem(1,15,4,3);
	me.AddItem(1,15,5,3);
	me.AddItem(1,15,6,3);
	me.AddItem(1,15,7,3);
	me.AddItem(1,15,8,3);
	me.AddItem(1,15,9,3);
	me.AddItem(1,15,10,3);
	me.AddItem(1,15,11,3);
end








function tbLiGuan:danhhieu()
	me.AddTitle(62,1,2,1);
		me.AddTitle(19,1,1,1);
		me.AddTitle(20,1,1,1);
	me.AddTitle(13,1,2,9);
	me.AddTitle(14,2,1,8);
	me.AddTitle(250,61,1,1);
	me.AddTitle(12,13,7,10);
	me.AddTitle(13,1,3,9);
	me.SetItemTimeout(me.AddItem(1,18,1,1,1), os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 168 * 60 * 60), 0);
end





function tbLiGuan:eventtet()
me.AddStackItem(18,1,1113,1,nil,50)
--me.AddStackItem(18,1,25136,1,nil,100)
--me.AddItem(4,3,1913,10,1,16)
--me.AddStackItem(18,1,558,1,nil,50)
--me.AddStackItem(18,1,558,2,nil,50)
--me.AddStackItem(18,1,558,3,nil,50)
--me.AddStackItem(18,1,558,4,nil,50)
--me.AddStackItem(18,1,558,5,nil,50)
--me.AddStackItem(18,1,558,6,nil,50)
--me.AddStackItem(18,1,558,7,nil,50)
--me.AddStackItem(18,1,558,8,nil,50)
--me.AddStackItem(18,1,558,9,nil,50)
--me.AddStackItem(18,1,558,10,nil,50)
--me.AddStackItem(18,1,558,11,nil,50)
--me.AddStackItem(18,1,558,12,nil,50)
end
----------------------------------------------------------------------------------
function tbLiGuan:lsGoiBoss()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Nhận Cầu hồn ngọc (4)",self.Cauhon,self};
		{"Gọi Boss",self.GoiBoss,self};
		{"Phó Bản",self.PhoBan,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:PhoBan()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Lệnh Bài Phó Bản",self.LenhBaiPhoBan,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsGoiBoss,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LenhBaiPhoBan()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"LB Thiên Quỳnh Cung",self.LenhBaiThienQuynhCung,self};
		{"LB Vạn Hoa Cốc",self.LenhBaiVanHoaCoc,self};
		{"<color=pink>Trở Lại Trước<color>",self.PhoBan,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LenhBaiThienQuynhCung()
    me.AddItem(18,1,186,1); --Lệnh Bài Thiên Quỳnh Cung
end

function tbLiGuan:LenhBaiVanHoaCoc()
    me.AddItem(18,1,245,1); --Lệnh Bài Vạn Hoa Cốc
end
----------------------------------------------------------------------------------
function tbLiGuan:lsMatNa()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"<color=red>Mặt Nạ Mới<color>",self.MatNaNew,self};
		{"Mặt Nạ Hàng Long <color=red>(Ko Thể Bán)<color>",self.MatNaHangLong,self};
		{"Tần Thủy Hoàng <color=red>(Ko Thể Bán)<color>",self.MatNaTanThuyHoang,self};
		{"Áo Dài Khăn Đống (Nam)",self.MatNaAoDaiKhanDongNam,self};
		{"Wodekapu",self.MatNaWodekapu,self};
		{"Lam Nhan",self.MatNaLamNhan,self};
		{"Rùa Thần",self.MatNaRuaThan,self};
		{"Mãnh Hổ",self.MatNaManhHo,self};
		{"Kim Mao Sư Vương",self.MatNaKimMaoSuVuong,self};
		{"Tây Độc Âu Dương Phong",self.MatNaTayDocAuDuongPhong,self};
		{"Cốc Tiên Tiên <color=red>(Ko Thể Bán)<color>",self.MatNaCocTienTien,self};
		{">>>",self.lsMatNa1,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:MatNaNew()
	me.AddItem(1,13,66,10);
	me.AddItem(1,13,67,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsMatNa1()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Lãnh Sương Nhiên <color=red>(Ko Thể Bán)<color>",self.MatNaLanhSuongNhien,self};
		{"Tân Niên Hiệp Nữ <color=red>(Ko Thể Bán)<color>",self.MatNaTanNienHiepNu,self};
		{"Doãn Tiêu Vũ <color=red>(Ko Thể Bán)<color>",self.MatNaDoanTieuVu,self};
		{"Ngưu Thúy Hoa <color=red>(Ko Thể Bán)<color>",self.MatNaNguuThuyHoa,self};
		{"<<<",self.lsMatNa,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ThongBaoToanServer()
    Dialog:AskString("Nhập dữ liệu", 1000, self.ThongBao, self);
end

function tbLiGuan:ThongBao(msg)
    GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
end
----------------------------------------------------------------------------------
function tbLiGuan:XepHangDanhVong()
    GCExcute({"PlayerHonor:UpdateWuLinHonorLadder"}); 
    GCExcute({"PlayerHonor:UpdateMoneyHonorLadder"}); 
    GCExcute({"PlayerHonor:UpdateLeaderHonorLadder"}); 
    KGblTask.SCSetDbTaskInt(86, GetTime()); 
    GlobalExcute({"PlayerHonor:OnLadderSorted"});
	GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Thứ hạng danh vọng Tài Phú đã được cập nhật, có thể xem chi tiết bằng phím Ctrl + C. Các hão hán đã có thể mua Phi phong nếu đủ điều kiện danh vọng"});
end
----------------------------------------------------------------------------------
function tbLiGuan:GoiBoss()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Bách Phu Trường",self.GoiBoss1,self};
		{"Chiến Sĩ Vong Trận",self.GoiBoss2,self};
		{"<color=yellow>Tà Hồn Sư<color>",self.GoiBoss3,self};
		{"Quỷ Sứ",self.GoiBoss4,self};
		{"Quỷ Nô",self.GoiBoss5,self};
		{"<color=red>Tần Thủy Hoàng<color>",self.GoiBoss6,self};
		{"Thần Thương Phương Vãn",self.GoiBoss7,self};
		{"Triệu Ứng Tiên",self.GoiBoss8,self};
		{"Hương Ngọc Tiên",self.GoiBoss9,self};
		{"Tống Nguyên Soái",self.GoiBoss10,self};
		{"Kim Nguyên Soái",self.GoiBoss11,self};
		{"<color=red>Niên Thú<color>",self.GoiBoss12,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsGoiBoss,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:GoiBoss1()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2431, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss2()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2430, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss3()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2429, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss4()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2428, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss5()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2427, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss6()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2426, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss7()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2407, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss8()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2408, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss9()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2409, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss10()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(7035, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss11()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(7037, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss12()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(3618, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end
----------------------------------------------------------------------------------
function tbLiGuan:lsQuanHam()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Nhận Quan Hàm",self.NhanQuanHam,self};
		{"Nhận Quan Ấn",self.NhanQuanAn,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:NhanQuanHam()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Quan Hàm Cấp 1",self.quanham1,self};
		{"Quan Hàm Cấp 2",self.quanham2,self};
		{"Quan Hàm Cấp 3",self.quanham3,self};
		{"Quan Hàm Cấp 4",self.quanham4,self};
		{"Quan Hàm Cấp 5",self.quanham5,self};
		{"Quan Hàm Cấp 6",self.quanham6,self};
		{"Quan Hàm Cấp 7",self.quanham7,self};
		{"Quan Hàm Cấp 8",self.quanham8,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsQuanHam,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:quanham1()
	me.AddTitle(10, 2, 1, 8)
end

function tbLiGuan:quanham2()
	me.AddTitle(10, 2, 2, 8)
end

function tbLiGuan:quanham3()
	me.AddTitle(10, 2, 3, 8)
end

function tbLiGuan:quanham4()
	me.AddTitle(10, 2, 4, 8)
end

function tbLiGuan:quanham5()
	me.AddTitle(10, 2, 5, 8)
end

function tbLiGuan:quanham6()
	me.AddTitle(10, 2, 6, 8)
end

function tbLiGuan:quanham7()
	me.AddTitle(10, 2, 7, 8)
end

function tbLiGuan:quanham8()
	me.AddTitle(13, 1, 10)
end
----------------------------------------------------------------------------------
function tbLiGuan:NhanQuanAn()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Nhận Quan ấn Kim",self.QuanAnKim,self};
		{"Nhận Quan ấn Mộc",self.QuanAnMoc,self};
		{"Nhận Quan ấn Thủy",self.QuanAnThuy,self};
		{"Nhận Quan ấn Hỏa",self.QuanAnHoa,self};
		{"Nhận Quan ấn Thổ",self.QuanAnTho,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsQuanHam,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnKim()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Nhận Quan ấn cấp 1",self.QuanAnKim1,self};
		{"Nhận Quan ấn cấp 2",self.QuanAnKim2,self};
		{"Nhận Quan ấn cấp 3",self.QuanAnKim3,self};
		{"Nhận Quan ấn cấp 4",self.QuanAnKim4,self};
		{"Nhận Quan ấn cấp 5",self.QuanAnKim5,self};
		{"Nhận Quan ấn cấp 6",self.QuanAnKim6,self};
		{"Nhận Quan ấn cấp 7",self.QuanAnKim7,self};
		{"Nhận Quan ấn cấp 8",self.QuanAnKim8,self};
		{"<color=pink>Trở Lại Trước<color>",self.NhanQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnKim1()
	me.AddItem(1,18,1,1,1);
end

function tbLiGuan:QuanAnKim2()
	me.AddItem(1,18,1,2,1);
end

function tbLiGuan:QuanAnKim3()
	me.AddItem(1,18,1,3,1);
end

function tbLiGuan:QuanAnKim4()
	me.AddItem(1,18,1,4,1);
end

function tbLiGuan:QuanAnKim5()
	me.AddItem(1,18,1,5,1);
end

function tbLiGuan:QuanAnKim6()
	me.AddItem(1,18,1,6,1);
end

function tbLiGuan:QuanAnKim7()
	me.AddItem(1,18,1,7,1);
end

function tbLiGuan:QuanAnKim8()
	me.AddItem(1,18,1,8,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnMoc()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Nhận Quan ấn cấp 1",self.QuanAnMoc1,self};
		{"Nhận Quan ấn cấp 2",self.QuanAnMoc2,self};
		{"Nhận Quan ấn cấp 3",self.QuanAnMoc3,self};
		{"Nhận Quan ấn cấp 4",self.QuanAnMoc4,self};
		{"Nhận Quan ấn cấp 5",self.QuanAnMoc5,self};
		{"Nhận Quan ấn cấp 6",self.QuanAnMoc6,self};
		{"Nhận Quan ấn cấp 7",self.QuanAnMoc7,self};
		{"Nhận Quan ấn cấp 8",self.QuanAnMoc8,self};
		{"<color=pink>Trở Lại Trước<color>",self.NhanQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnMoc1()
	me.AddItem(1,18,2,1,1);
end

function tbLiGuan:QuanAnMoc2()
	me.AddItem(1,18,2,2,1);
end

function tbLiGuan:QuanAnMoc3()
	me.AddItem(1,18,2,3,1);
end

function tbLiGuan:QuanAnMoc4()
	me.AddItem(1,18,2,4,1);
end

function tbLiGuan:QuanAnMoc5()
	me.AddItem(1,18,2,5,1);
end

function tbLiGuan:QuanAnMoc6()
	me.AddItem(1,18,2,6,1);
end

function tbLiGuan:QuanAnMoc7()
	me.AddItem(1,18,2,7,1);
end

function tbLiGuan:QuanAnMoc8()
	me.AddItem(1,18,2,8,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnThuy()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Nhận Quan ấn cấp 1",self.QuanAnThuy1,self};
		{"Nhận Quan ấn cấp 2",self.QuanAnThuy2,self};
		{"Nhận Quan ấn cấp 3",self.QuanAnThuy3,self};
		{"Nhận Quan ấn cấp 4",self.QuanAnThuy4,self};
		{"Nhận Quan ấn cấp 5",self.QuanAnThuy5,self};
		{"Nhận Quan ấn cấp 6",self.QuanAnThuy6,self};
		{"Nhận Quan ấn cấp 7",self.QuanAnThuy7,self};
		{"Nhận Quan ấn cấp 8",self.QuanAnThuy8,self};
		{"<color=pink>Trở Lại Trước<color>",self.NhanQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnThuy1()
	me.AddItem(1,18,3,1,1);
end

function tbLiGuan:QuanAnThuy2()
	me.AddItem(1,18,3,2,1);
end

function tbLiGuan:QuanAnThuy3()
	me.AddItem(1,18,3,3,1);
end

function tbLiGuan:QuanAnThuy4()
	me.AddItem(1,18,3,4,1);
end

function tbLiGuan:QuanAnThuy5()
	me.AddItem(1,18,3,5,1);
end

function tbLiGuan:QuanAnThuy6()
	me.AddItem(1,18,3,6,1);
end

function tbLiGuan:QuanAnThuy7()
	me.AddItem(1,18,3,7,1);
end

function tbLiGuan:QuanAnThuy8()
	me.AddItem(1,18,3,8,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnHoa()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Nhận Quan ấn cấp 1",self.QuanAnHoa1,self};
		{"Nhận Quan ấn cấp 2",self.QuanAnHoa2,self};
		{"Nhận Quan ấn cấp 3",self.QuanAnHoa3,self};
		{"Nhận Quan ấn cấp 4",self.QuanAnHoa4,self};
		{"Nhận Quan ấn cấp 5",self.QuanAnHoa5,self};
		{"Nhận Quan ấn cấp 6",self.QuanAnHoa6,self};
		{"Nhận Quan ấn cấp 7",self.QuanAnHoa7,self};
		{"Nhận Quan ấn cấp 8",self.QuanAnHoa8,self};
		{"<color=pink>Trở Lại Trước<color>",self.NhanQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnHoa1()
	me.AddItem(1,18,4,1,1);
end

function tbLiGuan:QuanAnHoa2()
	me.AddItem(1,18,4,2,1);
end

function tbLiGuan:QuanAnHoa3()
	me.AddItem(1,18,4,3,1);
end

function tbLiGuan:QuanAnHoa4()
	me.AddItem(1,18,4,4,1);
end

function tbLiGuan:QuanAnHoa5()
	me.AddItem(1,18,4,5,1);
end

function tbLiGuan:QuanAnHoa6()
	me.AddItem(1,18,4,6,1);
end

function tbLiGuan:QuanAnHoa7()
	me.AddItem(1,18,4,7,1);
end

function tbLiGuan:QuanAnHoa8()
	me.AddItem(1,18,4,8,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnTho()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Nhận Quan ấn cấp 1",self.QuanAnTho1,self};
		{"Nhận Quan ấn cấp 2",self.QuanAnTho2,self};
		{"Nhận Quan ấn cấp 3",self.QuanAnTho3,self};
		{"Nhận Quan ấn cấp 4",self.QuanAnTho4,self};
		{"Nhận Quan ấn cấp 5",self.QuanAnTho5,self};
		{"Nhận Quan ấn cấp 6",self.QuanAnTho6,self};
		{"Nhận Quan ấn cấp 7",self.QuanAnTho7,self};
		{"Nhận Quan ấn cấp 8",self.QuanAnTho8,self};
		{"<color=pink>Trở Lại Trước<color>",self.NhanQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnTho1()
	me.AddItem(1,18,5,1,1);
end

function tbLiGuan:QuanAnTho2()
	me.AddItem(1,18,5,2,1);
end

function tbLiGuan:QuanAnTho3()
	me.AddItem(1,18,5,3,1);
end

function tbLiGuan:QuanAnTho4()
	me.AddItem(1,18,5,4,1);
end

function tbLiGuan:QuanAnTho5()
	me.AddItem(1,18,5,5,1);
end

function tbLiGuan:QuanAnTho6()
	me.AddItem(1,18,5,6,1);
end

function tbLiGuan:QuanAnTho7()
	me.AddItem(1,18,5,7,1);
end

function tbLiGuan:QuanAnTho8()
	me.AddItem(1,18,5,8,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:VatPham()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Túi",self.Tui,self};
		{"Tần Lăng Hòa Thị Bích",self.TanLangHoaThiBich,self};
		{"Vé Cường Hóa",self.VeCuongHoa,self};
		{"Luyện Hóa Đồ",self.LuyenHoaDo,self};
		{"Huyền Tinh (1-12)",self.HuyenTinh,self};
		{"Đồ Nhiệm Vụ 110 (10 món)",self.nhiemvu110,self};
		{"Nguyệt Ảnh Thạch (10v)<color=red>( Ko Thể Bán)<color>",self.NguyetAnhThach,self};
		{"Bùa Sửa Trang Bị Cường 16",self.BuaSuaTrangBi,self};
		{"Nguyệt Ảnh Nguyên Thạch (10c)",self.NguyetAnhNguyenThach,self};
		{"Vỏ Sò Vàng (500)",self.VoSoVang,self};
		{"Rương Vỏ Sò Vàng (5r)",self.RuongVoSoVang,self};
		{"Rương Cao Quý (5r)",self.RuongCaoQuy,self};
		{"Rương Dạ Minh Châu (1r)",self.RuongDaMinhChau,self};
		{"Tu Luyện Đơn (5c)",self.TuLuyenDon,self};
		{">>>",self.VatPham1,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TanLangHoaThiBich()
	me.AddItem(18,1,377,1); --Tần lăng hòa thị bích
end
----------------------------------------------------------------------------------
function tbLiGuan:RuongCaoQuy()
	me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
	me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
	me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
	me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
	me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
end
----------------------------------------------------------------------------------
function tbLiGuan:VatPham1()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Tinh lực - Hoạt Lực",self.TinhLucHoatLuc,self};
		{"Ngũ Hành Hồn Thạch (10r)",self.NguHanhHonThach,self};
		{"Ngọc Trúc Mai Hoa (Tháng)",self.NgocTrucMaiHoa,self};
		{"Ngũ Hoa Ngọc Lộ Hoàn (1r)",self.NguHoaNgocLoHoan,self};
		{"Vạn Vật Quy Nguyên Đơn",self.VanVatQuyNguyenDon,self};
		{"Tổ Tiên Bảo Hộ",self.ToTienBaoHo,self};
		{"Bánh Ít Hồ Lô",self.BanhItHoLo,self};
		{"Túi Tân Thủ",self.TuiTanThu,self};
		{"<<<",self.VatPham,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TuiTanThu()
	me.AddItem(18,1,351,1); --Túi Tân Thủ
end
----------------------------------------------------------------------------------
function tbLiGuan:ChienThuDuLong()
	for i=1,100 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,524,1);
		else
			break
		end
	end
end
----------------------------------------------------------------------------------
function tbLiGuan:BanhItHoLo()
	me.AddItem(18,1,326,4); --Bánh ít hồ lô
end
----------------------------------------------------------------------------------
function tbLiGuan:MoRongRuong()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"LB Mở Rộng Rương 1",self.LBMoRongRuong1,self};
		{"LB Mở Rộng Rương 2",self.LBMoRongRuong2,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsLenhBai,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LBMoRongRuong1()
	me.AddItem(18,1,216,1); --Lệnh bài mở rộng rương lv1
end

function tbLiGuan:LBMoRongRuong2()
	me.AddItem(18,1,216,2); --Lệnh bài mở rộng rương lv2
end
----------------------------------------------------------------------------------
function tbLiGuan:BuaSuaTrangBi()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Bùa Sửa Phòng Cụ Cường 16",self.BuaSuaPC16,self};
		{"Bùa Sửa Trang Sức Cường 16",self.BuaSuaTS16,self};
		{"Bùa Sửa Vũ Khí Cường 16",self.BuaSuaVK16,self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:BuaSuaPC16()
	me.AddItem(18,3,1,16); --Bùa sửa phòng cụ cường 16
end

function tbLiGuan:BuaSuaTS16()
	me.AddItem(18,3,2,16); --Bùa sửa trang sức cường 16
end

function tbLiGuan:BuaSuaVK16()
	me.AddItem(18,3,3,16); --Bùa sửa vủ khí cường 16
end
----------------------------------------------------------------------------------
function tbLiGuan:ToTienBaoHo()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Tổ Tiên Bảo Hộ - Thường",self.ToTienBaoHo1, self};
		{"Tổ Tiên Bảo Hộ - Phụng Hoàng",self.ToTienBaoHo2, self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ToTienBaoHo1()
	me.AddItem(18,1,957,1,0,0); --Tổ Tiên Bảo Hộ Thường
end

function tbLiGuan:ToTienBaoHo2()
	me.AddItem(18,1,957,2,0,0); --Tổ Tiên Bảo Hộ - Phụng Hoàng
end
----------------------------------------------------------------------------------
function tbLiGuan:DuLong()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Du Long Lệnh (Phù)",self.DuLongPhu, self};
		{"Du Long Lệnh (Nón)",self.DuLongNon, self};
		{"Du Long Lệnh (Áo)",self.DuLongAo, self};
		{"Du Long Lệnh (Yêu Đái)",self.DuLongYeuDai, self};
		{"Du Long Lệnh (Giầy)",self.DuLongGiay, self};
		{"Du Long Lệnh (Hạng Liên)",self.DuLongHangLien, self};
		{"<color=pink>Trở Lại Trước<color>",self.lsDuLong,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:DuLongPhu()
	me.AddItem(18,1,529,1,0,1); --Du Long Lệnh Hộ Thân Phù
end

function tbLiGuan:DuLongNon()
	me.AddItem(18,1,529,2,0,1); --Du Long Lệnh Nón
end

function tbLiGuan:DuLongAo()
	me.AddItem(18,1,529,3,0,1); --Du Long Lệnh Áo
end

function tbLiGuan:DuLongYeuDai()
	me.AddItem(18,1,529,4,0,1); --Du Long Lệnh Yêu Đái
end

function tbLiGuan:DuLongGiay()
	me.AddItem(18,1,529,5,0,1); --Du Long Lệnh Giầy
end

function tbLiGuan:DuLongHangLien()
	me.AddItem(18,1,529,6,0,1); --Du Long Lệnh Hạng Liên
end
----------------------------------------------------------------------------------
function tbLiGuan:Tui()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"<color=yellow>Túi 24 ô (3c)<color>",self.Tui24, self};
		{"Túi Thiên Tằm (24 ô)",self.TuiThienTam, self};
		{"Túi Bàn Long (24 ô)",self.TuiBanLong, self};
		{"Túi Phi Phượng (24 ô)",self.TuiPhiPhuong, self};
		{"Túi Nữ Anh Hùng (24 ô)",self.TuiNuAnhHung, self};
		{"Túi Khởi La (20 ô)",self.TuiKhoiLa, self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TuiThienTam()
	me.AddItem(21,9,1,1); --Túi thiên tằm 24 ô
end
	
function tbLiGuan:TuiBanLong()
	me.AddItem(21,9,2,1); --Túi bàn long 24 ô
end

function tbLiGuan:TuiPhiPhuong()
	me.AddItem(21,9,3,1); --Túi Phi Phượng 24 ô
end

function tbLiGuan:TuiNuAnhHung()
	me.AddItem(21,9,6,1,0,1); --Túi Nữ Anh Hùng
end
function tbLiGuan:TuiKhoiLa()
	me.AddItem(21,8,2,1,0,3,1,2,6); --Túi Khởi La, Quân Dụng
end
----------------------------------------------------------------------------------
function tbLiGuan:NguyetAnhNguyenThach()
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
end
----------------------------------------------------------------------------------
function tbLiGuan:TinhLucHoatLuc()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Tinh Lực (1000000)",self.TinhLuc, self};
		{"Hoạt Lực (1000000)",self.HoatLuc, self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham1,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LuyenHoaDo()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Bộ Thủy Hoàng",self.BoThuyHoang, self};
		{"Bộ Trục Lộc",self.BoTrucLoc, self};
		{"Bộ Tiêu Dao",self.BoTieuDao, self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:BoThuyHoang()
	me.AddItem(18,2,4,3,0,1,9,1,4); -- Thủy Hoàng Y Phục Luyện Hóa Đồ
	me.AddItem(18,2,4,2,0,1,9,1,3); -- Thủy Hoàng Yêu Thụy Luyện Hóa Đồ
	me.AddItem(18,2,4,1,0,1,9,1,2); -- Thủy Hoàng Hộ Uyển Luyện Hóa Đồ
end

function tbLiGuan:BoTrucLoc()
	me.AddItem(18,2,3,1,0,1,8,1,2); --Trục Lộc Mạo Tử Luyện Hóa Đồ
	me.AddItem(18,2,3,2,0,1,8,1,3); --Trục Lộc Yêu Đái Luyện Hóa Đồ
	me.AddItem(18,2,3,3,0,1,8,1,4); --Trục Lộc Hạng Liên Luyện Hóa Đồ
end

function tbLiGuan:BoTieuDao()
	me.AddItem(18,2,1,1,0,1,5,3,2); --Tiêu Dao Hộ Uyển Luyện Hóa Đồ
	me.AddItem(18,2,1,2,0,1,5,3,3); --Tiêu Dao Yêu Trụy Luyện Hóa Đồ
	me.AddItem(18,2,1,3,0,1,5,3,4); --Tiêu Dao Hài Tử Luyện Hóa Đồ
end
----------------------------------------------------------------------------------
function tbLiGuan:VanVatQuyNguyenDon()
    me.AddItem(18,1,384,1);
    me.AddItem(18,1,384,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:VeCuongHoa()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Vé Cường Hóa Vũ Khí <color=red>(Ko Thể Bán)<color>" ,self.VeCuongHoaVuKhi, self};
		{"Vé Cường Hóa Phòng Cụ <color=red>(Ko Thể Bán)<color>" ,self.VeCuongHoaPhongCu, self};
		{"Vé Cường Hóa Trang Sức <color=red>(Ko Thể Bán)<color>" ,self.VeCuongHoaTrangSuc, self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:VeCuongHoaVuKhi()
	me.AddItem(18,1,518,1,0,1); --Vé Cường Hóa Vũ Khí
end

function tbLiGuan:VeCuongHoaPhongCu()
	me.AddItem(18,1,519,1,0,1); --Vé Cường Hóa Phòng Cụ
end

function tbLiGuan:VeCuongHoaTrangSuc()
	me.AddItem(18,1,520,1,0,1); --Vé Cường Hóa Trang Sức
end
----------------------------------------------------------------------------------
function tbLiGuan:lsThuCuoiDongHanh()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Thú Cưỡi" ,self.lsThuCuoi, self};
		{"Đồng Hành" ,self.lsDongHanh, self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsThuCuoi()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Dây Cương Thần Bí" ,self.DayCuongThanBi, self};
		{"Phiên Vũ" ,self.PhienVu, self};
		{"Hoan Hoan" ,self.HoanHoan, self};
		{"Hoan Hoan Có Kháng" ,self.HoanHoan1, self};
		{"Hỷ Hỷ" ,self.HyHy, self};
		{"Hỷ Hỷ Có Kháng" ,self.HyHy1, self};
		{"Hổ Cát Tường" ,self.HoCatTuong, self};
		{"Trục Nhật" ,self.TrucNhat, self};
		{"Trục Nhật <color=red>(Ko Bán Được)<color>" ,self.TrucNhat0, self};
		{"Trục Nhật Có Kháng (2)" ,self.TrucNhat1, self};
		{">>>" ,self.lsThuCuoi1, self};
		{"<color=pink>Trở Lại Trước<color>",self.lsThuCuoiDongHanh,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:DayCuongThanBi()
	me.AddItem(18,1,237,1); --Dây cương thần bí
end
----------------------------------------------------------------------------------
function tbLiGuan:lsThuCuoi1()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Lăng Thiên" ,self.LangThien, self};
		{"Lăng Thiên <color=red>(Ko Bán Được)<color>" ,self.LangThien0, self};
		{"Lăng Thiên Có Kháng<color=red>(Ko Bán Được)<color>" ,self.LangThien1, self};
		{"Lăng Thiên Có Kháng" ,self.LangThien2, self};
		{"Hỏa Kỳ Lân" ,self.HoaKyLan, self};
		{"Tuyết Hồn <color=red>(Ko Bán Được)<color>" ,self.TuyetHon, self};
		{"Tuyết Hồn" ,self.TuyetHon1, self};
		{"Tuyết Hồn Có Kháng" ,self.TuyetHon2, self};
		{"Xích Thố Có Kháng (3)" ,self.XichTho, self};
		{"Bôn Tiêu Có Kháng" ,self.BonTieu, self};
		{"Ức Vân" ,self.UcVan, self};
		{"Ức Vân Có Kháng +Skill <color=red>(Ko Bán Được)<color>" ,self.UcVan1, self};
		{"Tuyệt Thế Tuyết Vũ",self.TuyetTheTuyetVu,self},
		{"Hãn Huyết Thần Mã",self.HanHuyetThanMa,self},
	    {"Lạc Đà Xanh Dương",self.LacDaXanhDuong,self},
		--{"Lạc Đà Đỏ",self.LacDaDo,self},
		--{"Lạc Đà Xanh Nước Biển",self.LacDaXanhNuocBien,self},
	    {"Lam Kỳ Lân",self.LamKyLan,self},
		--{"Sư Tử",self.Sutu,self},
		{"<<<" ,self.lsThuCuoi, self};
		{"<color=pink>Trở Lại Trước<color>",self.lsThuCuoiDongHanh,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TuyetTheTuyetVu()
me.AddItem(1,12,55,4).Bind(1)
end;
----------------------------------------------------------------------------------
function tbLiGuan:HanHuyetThanMa()
me.AddItem(1,12,61,4);
end
----------------------------------------------------------------------------------
function tbLiGuan:LacDaXanhDuong()
me.AddItem(1,12,62,4);
end
----------------------------------------------------------------------------------
function tbLiGuan:LacDaDo()
me.AddItem(1,12,50,4);
end
----------------------------------------------------------------------------------
function tbLiGuan:LacDaXanhNuocBien()
me.AddItem(1,12,54,4);
end
----------------------------------------------------------------------------------
function tbLiGuan:Sutu()
me.AddItem(1,12,51,4);
end
----------------------------------------------------------------------------------
function tbLiGuan:LamKyLan()
	me.AddItem(1,12,42,4);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsDongHanh()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Bạn Đồng Hành" ,self.BanDongHanh, self};
		{"Mật Tịch Đồng Hành" ,self.MatTichDongHanh, self};
		{"Nguyên Liệu Đồng Hành" ,self.NguyenLieuDongHanh, self};
		{"Sách Kinh Nghiệm Đồng Hành" ,self.lsSachKinhNghiemDongHanh, self};
		{"Thiệp Bạc - Thiệp Lụa" ,self.ThiepBacThiepLua, self};
		{"Tinh Phách" ,self.TinhPhach, self};
		{"Chuyển Sinh PET - Bồ Đề Quả",self.lsChuyenSinhPet,self};
		{"Thư Đồng Hành",self.ThuDongHanh,self};
		{"Bạch Ngân Tinh Hoa",self.BachNganTinhHoa,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsThuCuoiDongHanh,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
	
end
----------------------------------------------------------------------------------
function tbLiGuan:BachNganTinhHoa()
	me.AddItem(18,1,565,1); --bạch ngân tinh hoa
end
----------------------------------------------------------------------------------
function tbLiGuan:ThuDongHanh()
    me.AddItem(18,1,566,1,0,1); --Thư Đồng Hành
end
----------------------------------------------------------------------------------
function tbLiGuan:lsChuyenSinhPet()
    me.AddItem(18,1,564,1); --Bồ Đề Quả - Chuyển sinh cho PET
end
----------------------------------------------------------------------------------
function tbLiGuan:BonTieu()
	me.AddItem(1,12,35,4); --Bôn tiêu có kháng, bán đc
end

function tbLiGuan:UcVan()
	me.AddItem(1,12,40,4); --Ức vân ko kháng, bán đc
end

function tbLiGuan:UcVan1()
	me.AddItem(1,12,47,4); --Ức vân có kháng +skill, ko bán đc
end

function tbLiGuan:XichTho()
	me.AddItem(1,12,45,4); --Xích thố có kháng, bán đc
	me.AddItem(1,12,34,4); --Xích thố có kháng, bán đc
	me.AddGeneralEquip(12,34,4); --Xích thố có kháng, bán đc
end

function tbLiGuan:TrucNhat1()
	me.AddItem(1,12,38,4); --Trục Nhật Có kháng, bán đc
	me.AddItem(1,12,43,4); --Trục Nhật có kháng, bán đc
end
----------------------------------------------------------------------------------
function tbLiGuan:PhienVu()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"PV Thường" ,self.PhienVu1, self};
		{"PV Có Kỹ Năng" ,self.PhienVu2, self};
		{"PV Có Kỹ Năng-Kháng <color=red>(Ko Khóa,Ko Bán)<color>" ,self.PhienVu3, self};
		{"PV Có Kỹ Năng-Kháng <color=yellow>(Khóa,Bán Được)<color>" ,self.PhienVu4, self};
		{"<color=pink>Trở Lại Trước<color>",self.lsThuCuoi,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:PhienVu1()
	me.AddItem(1,12,24,4);--Ngựa Phiên vũ ko có kĩ năng,không có kháng
end

function tbLiGuan:PhienVu2()
	me.AddItem(1,12,12,4);--Ngựa Phiên vũ có kĩ năng ko có kháng
end

function tbLiGuan:PhienVu3()
	me.AddItem(1,12,33,4);--Ngựa Phiên vũ tốt nhất Ko Khóa, Ko thể bán
end

function tbLiGuan:PhienVu4()
	me.AddItem(1,12,20001,4); --Phiên Vũ VIP - Khóa, có thể bán
end

function tbLiGuan:HoanHoan()
	me.AddItem(1,12,25,4); --Hoan Hoan
end

function tbLiGuan:HoanHoan1()
	me.AddItem(1,12,36,4); --Hoan Hoan có kháng, bán đc
end

function tbLiGuan:HyHy()
	me.AddItem(1,12,26,4); --Hỷ Hỷ
end

function tbLiGuan:HyHy1()
	me.AddItem(1,12,37,4); --Hỷ Hỷ có kháng, bán đc
end

function tbLiGuan:HoCatTuong()
	me.AddItem(1,12,27,4); --Hổ Cát Tường
end

function tbLiGuan:TrucNhat()
	me.AddItem(1,12,28,4); --Trục Nhật
end

function tbLiGuan:TrucNhat0()
	me.AddItem(1,12,28,4,0,1); --Trục Nhật ko bán đc
end
	
function tbLiGuan:LangThien()
	me.AddItem(1,12,29,4); --Lăng Thiên
end

function tbLiGuan:LangThien0()
	me.AddItem(1,12,29,4,0,1); --Lăng Thiên ko bán đc
end

function tbLiGuan:LangThien1()
	me.AddItem(1,12,44,4); --Lăng thiên, có kháng, ko bán đc
end

function tbLiGuan:LangThien2()
	me.AddItem(1,12,39,4); --Lăng thiên có kháng, bán đc
end

function tbLiGuan:HoaKyLan()
	me.AddItem(1,12,48,4); --Hỏa Kỳ Lân
end

function tbLiGuan:TuyetHon()
	me.AddItem(1,12,20000,4); --Tuyết Hồn
end

function tbLiGuan:TuyetHon1()
	me.AddItem(1,12,41,4); --Tuyết hồn ko kháng, bán đc
end

function tbLiGuan:TuyetHon2()
	me.AddItem(1,12,46,4); --Tuyết hồn có kháng, bán đc
end
----------------------------------------------------------------------------------
function tbLiGuan:BacDong()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Nhận Đồng",self.BacThuong,self};
		{"Nhận Thỏi Đồng (1000v đồng khóa)",self.ThoiDong,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsSachKinhNghiemDongHanh()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Sách KN Đồng Hành Thường (10Q)" ,self.SachKinhNghiemDongHanh1, self};
		{"Sách KN Đồng Hành Đặc Biệt (10Q)" ,self.SachKinhNghiemDongHanh2, self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TinhPhach()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Tinh Phách Thường" ,self.TinhPhachThuong, self};
		{"Tinh Phách Đặc Biệt" ,self.TinhPhachDacBiet, self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ThoiBac()
	me.AddItem(18,1,284,2); --Thỏi Bạc (  )
end
----------------------------------------------------------------------------------
function tbLiGuan:ThoiDong()
	me.AddItem(18,1,118,2); --Thỏi Đồng (1000 0000 đồng khóa)
end
----------------------------------------------------------------------------------
function tbLiGuan:TinhPhachThuong()
	me.AddItem(18,1,544,1,0,1); --Tinh Phách Thường
end

function tbLiGuan:TinhPhachDacBiet()
	me.AddItem(18,1,544,2,0,1); --Tinh Phách Đặc Biệt
end
----------------------------------------------------------------------------------
function tbLiGuan:BanDongHanh()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Bạn Đồng Hành 4 Kỹ Năng" ,self.BanDongHanh4, self};
		{"Bạn Đồng Hành 6 Kỹ Năng" ,self.BanDongHanh6, self};
		{"ĐH Thiên Thiên 6 Kỹ Năng" ,self.ThienThien6KN, self};
		{"ĐH Bảo Ngọc 6 Kỹ Năng" ,self.BaoNgoc6KN, self};
		{"ĐH Diệp Tịnh 5 Kỹ Năng" ,self.DiepTinh5KN, self};
		{"ĐH Bảo Ngọc 5 Kỹ Năng" ,self.BaoNgoc5KN, self};
		{"ĐH Tử Uyển 4 Kỹ Năng" ,self.TuUyen4KN, self};
		{"ĐH Hạ Tiểu Sảnh 4 Kỹ Năng" ,self.HaTieuSanh4KN, self};
		{"ĐH Diệp Tịnh 6 Kỹ Năng" ,self.DiepTinh6KN, self};
		{"ĐH Tiêu Bất Thực 5 Kỹ Năng" ,self.TieuBatThuc5KN, self};
		{"ĐH Hạ Hầu Tiểu Tiểu 4 Kỹ Năng" ,self.HaHauTieuTieu4KN, self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ThienThien6KN()
	me.AddItem(18,1,666,9); --ĐH thiên thiên 6 KN
end

function tbLiGuan:BaoNgoc6KN()
	me.AddItem(18,1,666,8); --ĐH Bảo ngọc 6KN
end

function tbLiGuan:DiepTinh5KN()
	me.AddItem(18,1,666,7); --ĐH Diệp tịnh 5KN
end

function tbLiGuan:BaoNgoc5KN()
	me.AddItem(18,1,666,6); --ĐH Bảo ngọc 5KN
end

function tbLiGuan:TuUyen4KN()
	me.AddItem(18,1,666,5); --ĐH Tử Uyển 4KN
end

function tbLiGuan:TuUyen4KN()
	me.AddItem(18,1,666,4); --ĐH Hạ Tiểu Sảnh 4KN
end

function tbLiGuan:DiepTinh6KN()
	me.AddItem(18,1,666,3); --ĐH Diệp Tịnh 6KN
end

function tbLiGuan:TieuBatThuc5KN()
	me.AddItem(18,1,666,2); --ĐH Tiêu Bất Thực 5KN
end

function tbLiGuan:HaHauTieuTieu4KN()
	me.AddItem(18,1,666,1); --ĐH Hạ Hầu Tiểu Tiểu 4KN
end
----------------------------------------------------------------------------------
function tbLiGuan:ThiepBacThiepLua()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Thiệp Bạc" ,self.ThiepBac, self};
		{"Thiệp Lụa" ,self.ThiepLua, self};
		{"Rương Thiệp Lụa" ,self.RuongThiepLua, self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:HuyenTinh()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt =
	{
		{"Huyền tinh 1",self.HuyenTinh1,self};
		{"Huyền tinh 2",self.HuyenTinh2,self};
		{"Huyền tinh 3",self.HuyenTinh3,self};
		{"Huyền tinh 4",self.HuyenTinh4,self};
		{"Huyền tinh 5",self.HuyenTinh5,self};
		{"Huyền tinh 6",self.HuyenTinh6,self};
		{"Huyền tinh 7",self.HuyenTinh7,self};
		{"Huyền tinh 8",self.HuyenTinh8,self};
		{"Huyền tinh 9",self.HuyenTinh9,self};
		{"Huyền tinh 10",self.HuyenTinh10,self};
		{"Huyền tinh 11",self.HuyenTinh11,self};
		{"Huyền tinh 12",self.HuyenTinh12,self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
	}
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:HuyenTinh1()
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
end

function tbLiGuan:HuyenTinh2()
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
end

function tbLiGuan:HuyenTinh3()
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
end

function tbLiGuan:HuyenTinh4()
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
end

function tbLiGuan:HuyenTinh5()
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
end

function tbLiGuan:HuyenTinh6()
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
end

function tbLiGuan:HuyenTinh7()
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
end

function tbLiGuan:HuyenTinh8()
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
end

function tbLiGuan:HuyenTinh9()
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
end

function tbLiGuan:HuyenTinh10()
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
end

function tbLiGuan:HuyenTinh11()
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
end

function tbLiGuan:HuyenTinh12()
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsDiemKinhNghiem()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = { 		
		{"Nhận Kinh Nghiệm Cấp 10<color>",self.LenLevel10,self};
		{"Nhận Kinh Nghiệm Cấp 20<color>",self.LenLevel20,self};
		{"Nhận Kinh Nghiệm Cấp 30<color>",self.LenLevel30,self};
		{"Nhận Kinh Nghiệm Cấp 40<color>",self.LenLevel40,self};
		{"Nhận Kinh Nghiệm Cấp 50<color>",self.LenLevel50,self};
		{"Nhận Kinh Nghiệm Cấp 60<color>",self.LenLevel60,self};
		{"Nhận Kinh Nghiệm Cấp 70<color>",self.LenLevel70,self};
		{"Nhận Kinh Nghiệm Cấp 80<color>",self.LenLevel80,self};
		{"Nhận Kinh Nghiệm Cấp 90<color>",self.LenLevel90,self};
		{"Nhận Kinh Nghiệm Cấp 100<color>",self.LenLevel100,self};
		{">>>",self.lsDiemKinhNghiem1,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsDiemKinhNghiem1()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = { 		
		{"Nhận Kinh Nghiệm Cấp 110<color>",self.LenLevel110,self};
		{"Nhận Kinh Nghiệm Cấp 120<color>",self.LenLevel120,self};
		{"Nhận Kinh Nghiệm Cấp 126<color>",self.LenLevel130,self};
		{"Nhận Kinh Nghiệm Cấp 140<color>",self.LenLevel140,self};
		{"Nhận Kinh Nghiệm Cấp 141<color>",self.LenLevel141,self};
		{"Nhận Kinh Nghiệm Cấp 142<color>",self.LenLevel142,self};
		{"Nhận Kinh Nghiệm Cấp 143<color>",self.LenLevel143,self};
		{"Nhận Kinh Nghiệm Cấp 144<color>",self.LenLevel144,self};
		{"Nhận Kinh Nghiệm Cấp 145<color>",self.LenLevel145,self};
		{"Nhận Kinh Nghiệm Cấp 146<color>",self.LenLevel146,self};
		{"Nhận Kinh Nghiệm Cấp 147<color>",self.LenLevel147,self};
		{"Nhận Kinh Nghiệm Cấp 148<color>",self.LenLevel148,self};
		{"Nhận Kinh Nghiệm Cấp 149<color>",self.LenLevel149,self};
		{"Nhận Kinh Nghiệm Cấp 200<color>",self.LenLevel150,self};
		{"Nhận Kinh Nghiệm Cấp 168<color>",self.LenLevel168,self};
		{"Nhận 100 Triệu Điểm Kinh Nghiệm",self.DiemKinhNghiem,self};
		{"Bánh Ít Thịt Heo (10c)",self.BanhItThitHeo,self};
		{"<<<",self.lsDiemKinhNghiem,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:BanhItThitHeo()
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
end
----------------------------------------------------------------------------------
function tbLiGuan:lsTiemNangKyNang()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = { 		
		{"Luyện Max Skill Kỹ Năng Môn Phái",self.MaxSkillMonPhai,self};
		{"Nhận 5000 Tiềm Năng",self.DiemTiemNang,self};
		{"Nhận 200 Điểm Kỹ Năng",self.DiemKyNang,self};
		{"Skill 120",self.skill120, self};	
	    {"Mật Tịch Cao",self.MatTichCao, self};
		{"<color=yellow>Luyện Max Skill Mật Tịch Trung<color>",self.lsMatTichTrung,self};
		{"<color=yellow>Luyện Max Skill Mật Tịch Cao<color>",self.lsMatTichCao,self};
		{"Võ Lâm Mật Tịch - Tẩy Tủy",self.VoLamTayTuy,self};
		{"Bánh Tiềm Năng - Kỹ Năng",self.BanhTrai,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsMatTichTrung()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl70, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv70, self});
	table.insert(tbOpt , {"Đường môn",  self.dm70, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd70, self});
	table.insert(tbOpt , {"Minh giáo",  self.mg70, self});
	table.insert(tbOpt , {"Nga My",  self.nm70, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty70, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt70, self});
	table.insert(tbOpt , {"Cái Bang",  self.cb70, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn70, self});
	table.insert(tbOpt , {"Võ Đang",  self.vd70, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl70, self});
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:tl70()
	me.AddFightSkill(1200,10);
    me.AddFightSkill(1201,10);
end

function tbLiGuan:tv70()		
    me.AddFightSkill(1202,10);
end

function tbLiGuan:dm70()
	me.AddFightSkill(1203,10);
    me.AddFightSkill(1204,10);
end

function tbLiGuan:nd70()		
	me.AddFightSkill(1205,10);
    me.AddFightSkill(1206,10);
end

function tbLiGuan:mg70()		
	me.AddFightSkill(1219,10);
    me.AddFightSkill(1220,10);
end

function tbLiGuan:nm70()
	me.AddFightSkill(1207,10);
    me.AddFightSkill(1208,10);
end

function tbLiGuan:ty70()		
	me.AddFightSkill(1209,10);
    me.AddFightSkill(1210,10);
end

function tbLiGuan:dt70()		
	me.AddFightSkill(1221,10);
    me.AddFightSkill(1222,10);
end

function tbLiGuan:cb70()
	me.AddFightSkill(1211,10);
	me.AddFightSkill(1212,10);
end

function tbLiGuan:tn70()		
    me.AddFightSkill(1213,10);
	me.AddFightSkill(1214,10);
end

function tbLiGuan:vd70()
	me.AddFightSkill(1215,10);
	me.AddFightSkill(1216,10);
end

function tbLiGuan:cl70()		
	me.AddFightSkill(1217,10);
	me.AddFightSkill(1218,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsMatTichCao()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl100, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv100, self});
	table.insert(tbOpt , {"Đường môn",  self.dm100, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd100, self});
	table.insert(tbOpt , {"Minh giáo",  self.mg100, self});
	table.insert(tbOpt , {"Nga My",  self.nm100, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty100, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt100, self});
	table.insert(tbOpt , {"Cái Bang",  self.cb100, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn100, self});
	table.insert(tbOpt , {"Võ Đang",  self.vd100, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl100, self});
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:tl100()
	me.AddFightSkill(1241,10);
    me.AddFightSkill(1242,10);
end

function tbLiGuan:tv100()		
    me.AddFightSkill(1243,10);
    me.AddFightSkill(1244,10);
end

function tbLiGuan:dm100()
	me.AddFightSkill(1245,10);
    me.AddFightSkill(1246,10);
end

function tbLiGuan:nd100()		
	me.AddFightSkill(1247,10);
    me.AddFightSkill(1248,10);
end

function tbLiGuan:mg100()		
	me.AddFightSkill(1261,10);
    me.AddFightSkill(1262,10);
end

function tbLiGuan:nm100()
	me.AddFightSkill(1249,10);
    me.AddFightSkill(1250,10);
end

function tbLiGuan:ty100()		
	me.AddFightSkill(1251,10);
    me.AddFightSkill(1252,10);
end

function tbLiGuan:dt100()		
	me.AddFightSkill(1263,10);
    me.AddFightSkill(1264,10);
end

function tbLiGuan:cb100()
	me.AddFightSkill(1253,10);
	me.AddFightSkill(1254,10);
end

function tbLiGuan:tn100()		
    me.AddFightSkill(1255,10);
	me.AddFightSkill(1256,10);
end

function tbLiGuan:vd100()
	me.AddFightSkill(1257,10);
	me.AddFightSkill(1258,10);
end

function tbLiGuan:cl100()		
	me.AddFightSkill(1259,10);
	me.AddFightSkill(1260,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:VoLamTayTuy()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = { 		
		{"Võ Lâm Mật Tịch",self.VoLamMatTich,self};
		{"Tẩy Tủy Kinh",self.TayTuyKinh,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LenLevel10()
	me.AddLevel(10 - me.nLevel);
end

function tbLiGuan:LenLevel20()
	me.AddLevel(20 - me.nLevel);
end

function tbLiGuan:LenLevel30()
	me.AddLevel(30 - me.nLevel);
end

function tbLiGuan:LenLevel40()
	me.AddLevel(40 - me.nLevel);
end

function tbLiGuan:LenLevel50()
	me.AddLevel(50 - me.nLevel);
end

function tbLiGuan:LenLevel60()
	me.AddLevel(60 - me.nLevel);
end

function tbLiGuan:LenLevel70()
	me.AddLevel(70 - me.nLevel);
end

function tbLiGuan:LenLevel80()
	me.AddLevel(80 - me.nLevel);
end

function tbLiGuan:LenLevel90()
	me.AddLevel(90 - me.nLevel);
end

function tbLiGuan:LenLevel100()
	me.AddLevel(200 - me.nLevel);
end

function tbLiGuan:LenLevel110()
	me.AddLevel(110 - me.nLevel);
end

function tbLiGuan:LenLevel120()
	me.AddLevel(120 - me.nLevel);
end

function tbLiGuan:LenLevel130()
	me.AddLevel(126 - me.nLevel);
end

function tbLiGuan:LenLevel140()
	me.AddLevel(140 - me.nLevel);
end

function tbLiGuan:LenLevel141()
	me.AddLevel(141 - me.nLevel);
end

function tbLiGuan:LenLevel142()
	me.AddLevel(142 - me.nLevel);
end


function tbLiGuan:LenLevel143()
	me.AddLevel(143 - me.nLevel);
end

function tbLiGuan:LenLevel144()
	me.AddLevel(144 - me.nLevel);
end

function tbLiGuan:LenLevel145()
	me.AddLevel(145 - me.nLevel);
end

function tbLiGuan:LenLevel146()
	me.AddLevel(146 - me.nLevel);
end

function tbLiGuan:LenLevel147()
	me.AddLevel(147 - me.nLevel);
end

function tbLiGuan:LenLevel148()
	me.AddLevel(148 - me.nLevel);
end

function tbLiGuan:LenLevel149()
	me.AddLevel(149 - me.nLevel);
end

function tbLiGuan:LenLevel168()
	me.AddLevel(168 - me.nLevel);
end

function tbLiGuan:LenLevel150()
	me.AddLevel(200 - me.nLevel);
end	
----------------------------------------------------------------------------------
function tbLiGuan:DiemTiemNang()
		me.AddPotential(5000)
end
----------------------------------------------------------------------------------
function tbLiGuan:DiemKyNang()
		me.AddFightSkillPoint(200)
end
----------------------------------------------------------------------------------
function tbLiGuan:DiemKinhNghiem()
		me.AddExp(100000000);
end
----------------------------------------------------------------------------------
function tbLiGuan:vdkiem() 
	if me.nFaction > 0 then 
		if me.nFaction == 9 then 
			me.AddFightSkill(163 ,54);  -- Thê Vân Tung 
			me.AddFightSkill(499 ,28);  -- Thái Nhất Chân Khí 
            me.AddFightSkill(170 ,54);  -- Thất Tinh Quyết 
		end
	end
end
----------------------------------------------------------------------------------
function tbLiGuan:MaxSkillMonPhai() 
    if me.nFaction > 0 then 
        if me.nFaction == 1 then    --Skill Thiếu Lâm 
            --Skill Đao Thiếu 
            me.AddFightSkill(21,54);    --Phục Ma Đao Pháp 
            me.AddFightSkill(22,54);    --Thiếu Lâm Đao Pháp 
            me.AddFightSkill(23,54);    --Dịch Cốt Kinh 
            me.AddFightSkill(25,54);    --A La Hán Thần Công 
            me.AddFightSkill(24,54);    --Phá Giới Đao Pháp 
            me.AddFightSkill(250,54);    --Hàng Long Phục Hổ 
            me.AddFightSkill(26,54);    --Bồ Đề Tâm Pháp 
            me.AddFightSkill(28,54);    --Hỗn Nguyên Nhất Khí 
            me.AddFightSkill(27,54);    --Thiên Trúc Tuyệt Đao 
            me.AddFightSkill(252,54);    --Như Lai Thiên Diệp 
            me.AddFightSkill(819,54);    --Thiền Nguyên Công 
            
             
            --Skill Côn Thiếu 
            me.AddFightSkill(29,54);    --Phổ Độ Côn Pháp 
            me.AddFightSkill(30,54);    --Thiếu Lâm Côn Pháp 
            me.AddFightSkill(31,54);    --Sư Tử Hống 
            me.AddFightSkill(25,54);    --A La Hán Thần Công 
            me.AddFightSkill(33,54);    --Phục Ma Côn Pháp 
            me.AddFightSkill(34,54);    --Bất Động Minh Vương 
            me.AddFightSkill(254,54);    --Dịch Cốt Kinh 
            me.AddFightSkill(37,54);    --Đạt Ma Vũ Kinh 
            me.AddFightSkill(36,54);    --Thất Tinh La Sát Côn 
            me.AddFightSkill(255,54);    --Vô Tướng Thần Công 
            me.AddFightSkill(821,54);    --Túy Bát Tiên Côn 
             
             
        elseif me.nFaction == 2 then    --Skill Thiên Vương 
            --Thương Thiên 
            me.AddFightSkill(38,54);    --Hồi Phong Lạc Nhạn 
            me.AddFightSkill(40,54);    --Thiên Vương Thương Pháp 
            me.AddFightSkill(41,54);    --Đoạn Hồn Thích     
            me.AddFightSkill(45,54);    --Tĩnh Tâm Quyết 
            me.AddFightSkill(43,54);    --Dương Quan Tam Điệp 
            me.AddFightSkill(256,54);    --Kinh Lôi Phá Thiên 
            me.AddFightSkill(46,54);    --Thiên Vương Chiến Ý     
            me.AddFightSkill(49,54);    --Thiên Canh Chiến Khí     
            me.AddFightSkill(47,54);    --Truy Tinh Trục Nguyệt 
            me.AddFightSkill(259,54);    --Huyết Chiến Bát Phương     
            me.AddFightSkill(823,54);    --Bôn Lôi Toàn Long Thương     
                            
             
            --Chùy Thiên 
            me.AddFightSkill(50,54);    --Hành Vân Quyết 
            me.AddFightSkill(52,54);    --Thiên Vương Chùy Pháp 
            me.AddFightSkill(41,54);    --Đoạn Hồn Thích 
            me.AddFightSkill(781,54);    --Tĩnh Tâm Thuật 
            me.AddFightSkill(53,54);    --Truy Phong Quyết 
            me.AddFightSkill(260,54);    --Thiên Vương Bản Sinh 
            me.AddFightSkill(55,54);    --Kim Chung Tráo 
            me.AddFightSkill(58,54);    --Đảo Hư Thiên 
            me.AddFightSkill(56,54);    --Thừa Long Quyết 
            me.AddFightSkill(262,54);    --Bất Diệt Sát Ý 
            me.AddFightSkill(825,54);    --Trảm Long Quyết 
                     
         
        elseif me.nFaction == 3 then    --Đường Môn 
            --Hãm Tĩnh 
            me.AddFightSkill(69,54);    --Độc Thích Cốt 
            me.AddFightSkill(70,54);    --Đường Môn Hãm Tĩnh 
            me.AddFightSkill(64,54);    --Mê Ảnh Tung     
            me.AddFightSkill(71,54);    --Câu Hồn Tĩnh 
            me.AddFightSkill(72,54);    --Tiểu Lý Phi Đao 
            me.AddFightSkill(263,54);    --Hấp Tinh Trận 
            me.AddFightSkill(73,54);    --Triền Thân Thích     
            me.AddFightSkill(75,54);    --Tâm Phách     
            me.AddFightSkill(74,54);    --Loạn Hoàn Kích 
            me.AddFightSkill(265,54);    --Thực Cốt Huyết Nhẫn     
            me.AddFightSkill(827,54);    --Cơ Quan Bí Thuật     
                 
            --Tụ Tiễn 
            me.AddFightSkill(59,54);    --Truy Tâm Tiễn 
            me.AddFightSkill(60,54);    --Đường Môn Tụ Tiễn 
            me.AddFightSkill(64,54);    --Mê Ảnh Tung     
            me.AddFightSkill(61,54);    --Tôi Độc Thuật 
            me.AddFightSkill(62,54);    --Thiên La Địa Võng 
            me.AddFightSkill(266,54);    --Đoạn Cân Nhẫn 
            me.AddFightSkill(65,54);    --Ngự Độc Thuật     
            me.AddFightSkill(68,54);    --Tâm Ma     
            me.AddFightSkill(66,54);    --Bạo Vũ Lê Hoa 
            me.AddFightSkill(268,54);    --Tâm Nhãn     
            me.AddFightSkill(829,54);    --Thất Tuyệt Sát Quang     
                
             
        elseif me.nFaction == 4 then    --Ngũ Độc 
            --Đao Độc 
            me.AddFightSkill(76 ,70);  -- Huyết Đao Độc Sát 
            me.AddFightSkill(77 ,70);  -- Ngũ Độc Đao Pháp 
            me.AddFightSkill(78 ,100);  -- Vô Hình Cổ 
            me.AddFightSkill(81 ,54);  -- Thí Độc Thuật 
            me.AddFightSkill(80 ,54);  -- Bách Độc Xuyên Tâm 
            me.AddFightSkill(269 ,54);  -- Ôn Cổ Chi Khí 
            me.AddFightSkill(82 ,54);  -- Vạn Cổ Thực Tâm 
            me.AddFightSkill(85 ,54);  -- Ngũ Độc Kỳ Kinh 
            me.AddFightSkill(83 ,54);  -- Huyền Âm Trảm 
            me.AddFightSkill(271 ,54);  -- Thiên Thù Vạn Độc 
            me.AddFightSkill(831 ,54);  -- Chu Cáp Thanh Minh 
             
            --Chưởng Độc 
            me.AddFightSkill(86 ,54);  -- Độc Sa Chưởng 
            me.AddFightSkill(87 ,54);  -- Ngũ Độc Chưởng Pháp 
            me.AddFightSkill(92 ,54);  -- Xuyên Tâm Độc Thích 
            me.AddFightSkill(91 ,54);  -- Ngân Ti Phi Thù 
            me.AddFightSkill(90 ,54);  -- Thiên Canh Địa Sát 
            me.AddFightSkill(272 ,54);  -- Khu Độc Thuật 
            me.AddFightSkill(88 ,54);  -- Bi Ma Huyết Quang 
            me.AddFightSkill(95 ,54);  -- Bách Cổ Độc Kinh 
            me.AddFightSkill(93 ,54);  -- Âm Phong Thực Cốt 
            me.AddFightSkill(274 ,54);  -- Đoạn Cân Hủ Cốt 
            me.AddFightSkill(833 ,54);  -- Hóa Cốt Miên Chưởng 
             
             
        elseif me.nFaction == 5 then    --Nga My 
            --Chưởng Nga 
            me.AddFightSkill(96 ,54);  -- Phiêu Tuyết Xuyên Vân 
            me.AddFightSkill(97 ,54);  -- Nga My Chưởng Pháp 
            me.AddFightSkill(98 ,54);  -- Từ Hàng Phổ Độ 
            me.AddFightSkill(101 ,54);  -- Phật Tâm Từ Hựu 
            me.AddFightSkill(99 ,54);  -- Tứ Tượng Đồng Quy 
            me.AddFightSkill(479 ,54);  -- Bất Diệt Bất Tuyệt 
            me.AddFightSkill(782 ,54);  -- Lưu Thủy Tâm Pháp 
            me.AddFightSkill(105 ,54);  -- Phật Pháp Vô Biên 
            me.AddFightSkill(103 ,54);  -- Phong Sương Toái Ảnh 
            me.AddFightSkill(280 ,54);  -- Vạn Phật Quy Tông 
            me.AddFightSkill(835 ,54);  -- Phật Quang Chiến Khí 
             
             
            --Phụ Trợ 
            me.AddFightSkill(107 ,54);  -- Phật Âm Chiến Ý 
            me.AddFightSkill(106 ,54);  -- Mộng Điệp 
            me.AddFightSkill(98 ,54);  -- Từ Hàng Phổ Độ 
            me.AddFightSkill(101 ,54);  -- Phật Tâm Từ Hựu 
            me.AddFightSkill(109 ,54);  -- Thiên Phật Thiên Diệp 
            me.AddFightSkill(110 ,54);  -- Phật Quang Phổ Chiếu 
            me.AddFightSkill(102 ,54);  -- Lưu Thủy Quyết 
            me.AddFightSkill(481 ,54);  -- Ba La Tâm Kinh 
            me.AddFightSkill(108 ,54);  -- Thanh Âm Phạn Xướng 
            me.AddFightSkill(482 ,54);  -- Phổ Độ Chúng Sinh 
            me.AddFightSkill(837 ,54);  -- Kiếm Ảnh Phật Quang 
             
             
        elseif me.nFaction == 6 then    --Thúy Yên 
            --Kiếm Thúy 
            me.AddFightSkill(111 ,54);  -- Phong Quyển Tàn Tuyết 
            me.AddFightSkill(112 ,54);  -- Thúy Yên Kiếm Pháp 
            me.AddFightSkill(113 ,54);  -- Hộ Thể Hàn Băng 
            me.AddFightSkill(115 ,54);  -- Tuyết Ảnh 
            me.AddFightSkill(114 ,54);  -- Bích Hải Triều Sinh 
            me.AddFightSkill(483 ,54);  -- Huyền Băng Vô Tức 
            me.AddFightSkill(116 ,54);  -- Tuyết Ánh Hồng Trần 
            me.AddFightSkill(119 ,54);  -- Băng Cốt Tuyết Tâm 
            me.AddFightSkill(117 ,54);  -- Băng Tâm Tiên Tử 
            me.AddFightSkill(485 ,54);  -- Phù Vân Tán Tuyết 
            me.AddFightSkill(839 ,54);  -- Thập Diện Mai Phục 
             
            --Đao Thúy 
            me.AddFightSkill(120 ,54);  -- Phong Hoa Tuyết Nguyệt 
            me.AddFightSkill(121 ,54);  -- Thúy Yên Đao Pháp 
            me.AddFightSkill(122 ,54);  -- Ngự Tuyết Ẩn 
            me.AddFightSkill(115 ,54);  -- Tuyết Ảnh 
            me.AddFightSkill(123 ,54);  -- Mục Dã Lưu Tinh 
            me.AddFightSkill(483 ,54);  -- Huyền Băng Vô Tức 
            me.AddFightSkill(124 ,54);  -- Băng Tâm Thiến Ảnh 
            me.AddFightSkill(127 ,54);  -- Băng Cơ Ngọc Cốt 
            me.AddFightSkill(125 ,54);  -- Băng Tung Vô Ảnh 
            me.AddFightSkill(486 ,54);  -- Thiên Lý Băng Phong 
            me.AddFightSkill(841 ,54);  -- Quy Khứ Lai Hề 
             
        elseif me.nFaction == 7 then    --Cái Bang 
            --Chưởng Cái 
            me.AddFightSkill(128 ,54);  -- Kiến Nhân Thân Thủ 
            me.AddFightSkill(129 ,54);  -- Cái Bang Chưởng Pháp 
            me.AddFightSkill(130 ,54);  -- Hóa Hiểm Vi Di 
            me.AddFightSkill(132 ,54);  -- Hoạt Bất Lưu Thủ 
            me.AddFightSkill(131 ,54);  -- Hàng Long Hữu Hối 
            me.AddFightSkill(489 ,54);  -- Thời Thừa Lục Long 
            me.AddFightSkill(133 ,54);  -- Túy Điệp Cuồng Vũ 
            me.AddFightSkill(136 ,54);  -- Tiềm Long Tại Uyên 
            me.AddFightSkill(134 ,54);  -- Phi Long Tại Thiên 
            me.AddFightSkill(487 ,54);  -- Giáng Long Chưởng 
            me.AddFightSkill(843 ,54);  -- Trảo Long Công 
             
            --Côn Cái 
            me.AddFightSkill(137 ,54);  -- Duyên Môn Thác Bát 
            me.AddFightSkill(138 ,54);  -- Cái Bang Bổng Pháp 
            me.AddFightSkill(139 ,54);  -- Tiêu Dao Công 
            me.AddFightSkill(132 ,54);  -- Hoạt Bất Lưu Thủ 
            me.AddFightSkill(140 ,54);  -- Bổng Đả Ác Cẩu 
            me.AddFightSkill(491 ,54);  -- Ác Cẩu Lan Lộ 
            me.AddFightSkill(238 ,54);  -- Hỗn Thiên Khí Công 
            me.AddFightSkill(142 ,54);  -- Bôn Lưu Đáo Hải 
            me.AddFightSkill(141 ,54);  -- Thiên Hạ Vô Cẩu 
            me.AddFightSkill(488 ,54);  -- Đả Cẩu Bổng Pháp 
            me.AddFightSkill(845 ,54);  -- Đả Cẩu Trận Pháp 
             
        elseif me.nFaction == 8 then    --Thiên Nhẫn 
            --Chiến Nhẫn 
            me.AddFightSkill(143 ,54);  -- Tàn Dương Như Huyết 
            me.AddFightSkill(144 ,54);  -- Thiên Nhẫn Mâu Pháp 
            me.AddFightSkill(492 ,54);  -- Huyễn Ảnh Truy Hồn Thương 
            me.AddFightSkill(145 ,54);  -- Kim Thiền Thoát Xác 
            me.AddFightSkill(146 ,54);  -- Liệt Hỏa Tình Thiên 
            me.AddFightSkill(147 ,54);  -- Bi Tô Thanh Phong 
            me.AddFightSkill(148 ,54);  -- Ma Âm Phệ Phách 
            me.AddFightSkill(150 ,54);  -- Thiên Ma Giải Thể 
            me.AddFightSkill(149 ,54);  -- Vân Long Kích 
            me.AddFightSkill(493 ,54);  -- Ma Viêm Tại Thiên 
            me.AddFightSkill(847 ,54);  -- Phi Hồng Vô Tích 
            
            --Ma Nhẫn 
            me.AddFightSkill(151 ,54);  -- Đạn Chỉ Liệt Diệm 
            me.AddFightSkill(152 ,54);  -- Thiên Nhẫn Đao Pháp 
            me.AddFightSkill(154 ,54);  -- Lệ Ma Đoạt Hồn 
            me.AddFightSkill(145 ,54);  -- Kim Thiền Thoát Xác 
            me.AddFightSkill(153 ,54);  -- Thôi Sơn Điền Hải 
            me.AddFightSkill(494 ,54);  -- Hỏa Liên Phần Hoa 
            me.AddFightSkill(155 ,54);  -- Nhiếp Hồn Loạn Tâm 
            me.AddFightSkill(158 ,54);  -- Xí Không Ma Diệm 
            me.AddFightSkill(156 ,54);  -- Thiên Ngoại Lưu Tinh 
            me.AddFightSkill(496 ,54);  -- Ma Diệm Thất Sát 
            me.AddFightSkill(849 ,54);  -- Thúc Phọc Chú 
             
        elseif me.nFaction == 9 then    --Võ Đang 
            --Khí Võ 
            me.AddFightSkill(159 ,54);  -- Bác Cập Nhi Phục 
            me.AddFightSkill(160 ,54);  -- Võ Đang Quyền Pháp 
            me.AddFightSkill(161 ,54);  -- Tọa Vọng Vô Ngã 
            me.AddFightSkill(163 ,54);  -- Thê Vân Tung 
            me.AddFightSkill(162 ,54);  -- Vô Ngã Vô Kiếm 
            me.AddFightSkill(497 ,54);  -- Thuần Dương Vô Cực 
            me.AddFightSkill(164 ,54);  -- Chân Vũ Thất Tiệt 
            me.AddFightSkill(166 ,54);  -- Thái Cực Vô Ý 
            me.AddFightSkill(165 ,54);  -- Thiên Địa Vô Cực 
            me.AddFightSkill(498 ,54);  -- Thái Cực Thần Công 
            me.AddFightSkill(851 ,54);  -- Võ Đang Cửu Dương 
             
            --Kiếm Võ 
            me.AddFightSkill(167 ,54);  -- Kiếm Phi Kinh Thiên 
            me.AddFightSkill(168 ,54);  -- Võ Đang Kiếm Pháp 
            me.AddFightSkill(783 ,54);  -- Vô Ngã Tâm Pháp 
            me.AddFightSkill(163 ,54);  -- Thê Vân Tung 
            me.AddFightSkill(169 ,54);  -- Tam Hoàn Sáo Nguyệt 
            me.AddFightSkill(499 ,54);  -- Thái Nhất Chân Khí 
            me.AddFightSkill(170 ,54);  -- Thất Tinh Quyết 
            me.AddFightSkill(174 ,54);  -- Kiếm Khí Tung Hoành 
            me.AddFightSkill(171 ,54);  -- Nhân Kiếm Hợp Nhất 
            me.AddFightSkill(500 ,54);  -- Thái Cực Kiếm Pháp 
            me.AddFightSkill(853 ,54);  -- Mê Tung Huyễn Ảnh 
        elseif me.nFaction == 10 then    --Côn Lôn 
            --Đao Côn 
            me.AddFightSkill(175 ,54);  -- Hô Phong Pháp 
            me.AddFightSkill(176 ,54);  -- Côn Lôn Đao Pháp 
            me.AddFightSkill(179 ,54);  -- Huyền Thiên Vô Cực 
            me.AddFightSkill(177 ,54);  -- Thanh Phong Phù 
            me.AddFightSkill(178 ,54);  -- Cuồng Phong Sậu Điện 
            me.AddFightSkill(697 ,54);  -- Khai Thần Thuật 
            me.AddFightSkill(180 ,54);  -- Nhất Khí Tam Thanh 
            me.AddFightSkill(183 ,54);  -- Thiên Thanh Địa Trọc 
            me.AddFightSkill(181 ,54);  -- Ngạo Tuyết Tiếu Phong 
            me.AddFightSkill(698 ,54);  -- Sương Ngạo Côn Lôn 
            me.AddFightSkill(855 ,54);  -- Vô Nhân Vô Ngã 
             
            --Kiếm Côn 
            me.AddFightSkill(188 ,54);  -- Cuồng Lôi Chấn Địa 
            me.AddFightSkill(189 ,54);  -- Côn Lôn Kiếm Pháp 
            me.AddFightSkill(179 ,54);  -- Huyền Thiên Vô Cực 
            me.AddFightSkill(177 ,54);  -- Thanh Phong Phù 
            me.AddFightSkill(190 ,54);  -- Thiên Tế Tấn Lôi 
            me.AddFightSkill(699 ,54);  -- Túy Tiên Thác Cốt 
            me.AddFightSkill(191 ,54);  -- Đạo Cốt Tiên Phong 
            me.AddFightSkill(193 ,54);  -- Ngũ Lôi Chánh Pháp 
            me.AddFightSkill(192 ,54);  -- Lôi Động Cửu Thiên 
            me.AddFightSkill(767 ,54);  -- Hỗn Nguyên Càn Khôn 
            me.AddFightSkill(857 ,54);  -- Lôi Đình Quyết 
            
        elseif me.nFaction == 11 then    --Minh Giáo 
            --Chùy Minh 
            me.AddFightSkill(194 ,54);  -- Khai Thiên Thức 
            me.AddFightSkill(196 ,54);  -- Minh Giáo Chùy Pháp 
            me.AddFightSkill(199 ,54);  -- Khốn Hổ Vân Tiếu 
            me.AddFightSkill(768 ,54);  -- Huyền Dương Công 
            me.AddFightSkill(198 ,54);  -- Phách Địa Thế 
            me.AddFightSkill(201 ,54);  -- Kim Qua Thiết Mã 
            me.AddFightSkill(197 ,54);  -- Ngự Mã Thuật 
            me.AddFightSkill(204 ,54);  -- Trấn Ngục Phá Thiên Kình 
            me.AddFightSkill(202 ,54);  -- Long Thôn Thức 
            me.AddFightSkill(769 ,54);  -- Không Tuyệt Tâm Pháp 
            me.AddFightSkill(859 ,54);  -- Cửu Hi Hỗn Dương 
             
            --Kiếm Minh 
            me.AddFightSkill(205 ,54);  -- Thánh Hỏa Phần Tâm 
            me.AddFightSkill(206 ,54);  -- Minh Giáo Kiếm Pháp 
            me.AddFightSkill(207 ,54);  -- Di Khí Phiêu Tung 
            me.AddFightSkill(209 ,54);  -- Phiêu Dực Thân Pháp 
            me.AddFightSkill(208 ,54);  -- Vạn Vật Câu Phần 
            me.AddFightSkill(210 ,54);  -- Càn Khôn Đại Na Di 
            me.AddFightSkill(770 ,54);  -- Thâu Thiên Hoán Nhật 
            me.AddFightSkill(212 ,54);  -- Ly Hỏa Đại Pháp 
            me.AddFightSkill(211 ,54);  -- Thánh Hỏa Liêu Nguyên 
            me.AddFightSkill(772 ,54);  -- Thánh Hỏa Thần Công 
            me.AddFightSkill(861 ,54);  -- Thánh Hỏa Lệnh Pháp 
             
        elseif me.nFaction == 12 then    --Đoàn Thị 
            --Chỉ Đoàn 
            me.AddFightSkill(213 ,54);  -- Thần Chỉ Điểm Huyệt 
            me.AddFightSkill(215 ,54);  -- Đoàn Thị Chỉ Pháp 
            me.AddFightSkill(216 ,54);  -- Nhất Dương Chỉ 
            me.AddFightSkill(219 ,54);  -- Lăng Ba Vi Bộ 
            me.AddFightSkill(217 ,54);  -- Nhất Chỉ Càn Khôn 
            me.AddFightSkill(773 ,54);  -- Từ Bi Quyết 
            me.AddFightSkill(220 ,54);  -- Thí Nguyên Quyết 
            me.AddFightSkill(225 ,54);  -- Kim Ngọc Chỉ Pháp 
            me.AddFightSkill(223 ,54);  -- Càn Dương Thần Chỉ 
            me.AddFightSkill(775 ,54);  -- Càn Thiên Chỉ Pháp 
            me.AddFightSkill(863 ,54);  -- Diệu Đề Chỉ 
             
            --Khí Đoàn 
            me.AddFightSkill(226 ,54);  -- Phong Vân Biến Huyễn 
            me.AddFightSkill(227 ,54);  -- Đoàn Thị Tâm Pháp 
            me.AddFightSkill(228 ,54);  -- Bắc Minh Thần Công 
            me.AddFightSkill(230 ,54);  -- Thiên Nam Bộ Pháp 
            me.AddFightSkill(229 ,54);  -- Kim Ngọc Mãn Đường 
            me.AddFightSkill(776 ,54);  -- Lục Kiếm Tề Phát 
            me.AddFightSkill(231 ,54);  -- Khô Vinh Thiền Công 
            me.AddFightSkill(233 ,54);  -- Thiên Long Thần Công 
            me.AddFightSkill(232 ,54);  -- Lục Mạch Thần Kiếm 
            me.AddFightSkill(778 ,54);  -- Đoàn Gia Khí Kiếm 
            me.AddFightSkill(865 ,54);  -- Kinh Thiên Nhất Kiếm 
             
        end 
    end 
end

----------------------------------------------------------------------------------
function tbLiGuan:MatTichCao()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.mttl, self});
	table.insert(tbOpt , {"Thiên Vương",  self.mttv, self});
	table.insert(tbOpt , {"Đường môn",  self.mtdm, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.mtnd, self});
	table.insert(tbOpt , {"Minh giáo",  self.mtmg, self});
	table.insert(tbOpt , {"Nga My",  self.mtnm, self});
	table.insert(tbOpt , {"Thúy Yên",  self.mtty, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.mtdt, self});
	table.insert(tbOpt , {"Cái Bang",  self.mtcb, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.mttn, self});
	table.insert(tbOpt , {"Võ Đang",  self.mtvd, self});
	table.insert(tbOpt , {"Côn Lôn",  self.mtcl, self});
	table.insert(tbOpt , {"<color=pink>Trở Lại Trước<color>",  self.lsTiemNangKyNang, self});
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:skill120()
if me.nFaction > 0 then 
        if me.nFaction == 1 then    --Skill Thiếu Lâm 
            me.AddFightSkill(820,1);    --Kỹ năng cấp 120
            me.AddFightSkill(822,1);    --Kỹ năng cấp 120
             
        elseif me.nFaction == 2 then    --Skill Thiên Vương 
            me.AddFightSkill(824,1);    --Kỹ năng cấp 120                 
            me.AddFightSkill(826,1);    --Kỹ năng cấp 120         
         
        elseif me.nFaction == 3 then    --Đường Môn 
 
            me.AddFightSkill(828,1);    --Kỹ năng cấp 120     
            me.AddFightSkill(830,1);    --Kỹ năng cấp 120     
             
        elseif me.nFaction == 4 then    --Ngũ Độc 
            me.AddFightSkill(832 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(834 ,1);  -- Kỹ năng cấp 120 
             
        elseif me.nFaction == 5 then    --Nga My 
            me.AddFightSkill(836 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(838 ,1);  -- Kỹ năng cấp 120 
             
        elseif me.nFaction == 6 then    --Thúy Yên 
            me.AddFightSkill(840 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(842 ,1);  -- Kỹ năng cấp 120 
			
        elseif me.nFaction == 7 then    --Cái Bang 
            me.AddFightSkill(844 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(846 ,1);  -- Kỹ năng cấp 120 
			
        elseif me.nFaction == 8 then    --Thiên Nhẫn 
            me.AddFightSkill(848 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(850 ,1);  -- Kỹ năng cấp 120 
			
        elseif me.nFaction == 9 then    --Võ Đang 
             me.AddFightSkill(852 ,1);  -- Kỹ năng cấp 120 
             me.AddFightSkill(854 ,1);  -- Kỹ năng cấp 120 
			 
        elseif me.nFaction == 10 then    --Côn Lôn 
           me.AddFightSkill(856 ,1);  -- Kỹ năng cấp 120 
           me.AddFightSkill(858 ,1);  -- Kỹ năng cấp 120 
		   
        elseif me.nFaction == 11 then    --Minh Giáo 
            me.AddFightSkill(860 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(862 ,1);  -- Kỹ năng cấp 120 
			
        elseif me.nFaction == 12 then    --Đoàn Thị 
            me.AddFightSkill(864 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(866 ,1);  --Sơ Ảnh 
        end 
    end 
end 
----------------------------------------------------------------------------------
function tbLiGuan:mttl()
		me.AddItem(1,14,1,3);
		me.AddItem(1,14,2,3);
end

function tbLiGuan:mttv()		
		me.AddItem(1,14,3,3);
		me.AddItem(1,14,4,3);
end

function tbLiGuan:mtdm()
		me.AddItem(1,14,5,3);
		me.AddItem(1,14,6,3);
end

function tbLiGuan:mtnd()		
		me.AddItem(1,14,7,3);
		me.AddItem(1,14,8,3);
end

function tbLiGuan:mtmg()		
		me.AddItem(1,14,21,3);
		me.AddItem(1,14,22,3);
end

function tbLiGuan:mtnm()
		me.AddItem(1,14,9,3);
		me.AddItem(1,14,10,3);
end

function tbLiGuan:mtty()		
		me.AddItem(1,14,11,3);
		me.AddItem(1,14,12,3);
end

function tbLiGuan:mtdt()		
		me.AddItem(1,14,23,3);
		me.AddItem(1,14,24,3);
end

function tbLiGuan:mtcb()
		me.AddItem(1,14,13,3);
		me.AddItem(1,14,14,3);
end

function tbLiGuan:mttn()		
		me.AddItem(1,14,15,3);
		me.AddItem(1,14,16,3);
end

function tbLiGuan:mtvd()
		me.AddItem(1,14,17,3);
		me.AddItem(1,14,18,3);
end

function tbLiGuan:mtcl()		
		me.AddItem(1,14,19,3);
		me.AddItem(1,14,20,3);
end
----------------------------------------------------------------------------------
function tbLiGuan:TangTocChay()
	me.AddFightSkill(163,20);	-- 60级梯云纵
	me.AddFightSkill(91,20);
	me.AddFightSkill(132,20);
	me.AddFightSkill(177,20);
	me.AddFightSkill(209,20);
end

function tbLiGuan:HuyTangTocChay()
	me.DelFightSkill(163);	-- 60级梯云纵
	me.DelFightSkill(91);
	me.DelFightSkill(132);
	me.DelFightSkill(177);
	me.DelFightSkill(209);
end

function tbLiGuan:TangTocDanh()
	me.AddFightSkill(28,20);
	me.AddFightSkill(37,20);
	me.AddFightSkill(68,20);
	me.AddFightSkill(75,20);
	me.AddFightSkill(85,20);
	me.AddFightSkill(95,20);
	me.AddFightSkill(105,20);
	me.AddFightSkill(119,20);
	me.AddFightSkill(127,20);
	me.AddFightSkill(136,20);
	me.AddFightSkill(142,20);
	me.AddFightSkill(150,20);
	me.AddFightSkill(158,20);
	me.AddFightSkill(166,20);
	me.AddFightSkill(174,20);
	me.AddFightSkill(183,20);
	me.AddFightSkill(193,20);
	me.AddFightSkill(204,20);
	me.AddFightSkill(212,20);
	me.AddFightSkill(233,20);
	me.AddFightSkill(837,20);
	me.AddFightSkill(1069,20);
end

function tbLiGuan:HuyTangTocDanh()
	me.DelFightSkill(28);
	me.DelFightSkill(37);
	me.DelFightSkill(68);
	me.DelFightSkill(75);
	me.DelFightSkill(85);
	me.DelFightSkill(95);
	me.DelFightSkill(105);
	me.DelFightSkill(119);
	me.DelFightSkill(127);
	me.DelFightSkill(136);
	me.DelFightSkill(142);
	me.DelFightSkill(150);
	me.DelFightSkill(158);
	me.DelFightSkill(166);
	me.DelFightSkill(174);
	me.DelFightSkill(183);
	me.DelFightSkill(193);
	me.DelFightSkill(204);
	me.DelFightSkill(212);
	me.DelFightSkill(233);
	me.DelFightSkill(837);
	me.DelFightSkill(1069);
end
----------------------------------------------------------------------------------
function tbLiGuan:tl120()
	me.AddFightSkill(820,10);
	me.AddFightSkill(822,10);
end

function tbLiGuan:tv120()		
	me.AddFightSkill(824,10);
	me.AddFightSkill(826,10);
end

function tbLiGuan:dm120()
	me.AddFightSkill(828,10);
	me.AddFightSkill(830,10);
end

function tbLiGuan:nd120()		
	me.AddFightSkill(832,10);
	me.AddFightSkill(834,10);
end

function tbLiGuan:mg120()		
	me.AddFightSkill(860,10);
	me.AddFightSkill(862,10);
end

function tbLiGuan:nm120()
	me.AddFightSkill(836,10);
	me.AddFightSkill(838,10);
end

function tbLiGuan:ty120()		
	me.AddFightSkill(840,10);
	me.AddFightSkill(842,10);
end

function tbLiGuan:dt120()		
	me.AddFightSkill(864,10);
	me.AddFightSkill(866,10);
	me.AddFightSkill(1662,10);
end

function tbLiGuan:cb120()
	me.AddFightSkill(844,10);
	me.AddFightSkill(846,10);
end

function tbLiGuan:tn120()		
	me.AddFightSkill(848,10);
	me.AddFightSkill(850,10);
end

function tbLiGuan:vd120()
	me.AddFightSkill(852,10);
	me.AddFightSkill(854,10);
end

function tbLiGuan:cl120()		
	me.AddFightSkill(856,10);
	me.AddFightSkill(858,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:GetAwardBuff()
	local szMsg ="";
	local nGetBuff = me.GetTask(self.TASK_GROUP_ID, self.TASK_GET_BUFF);
	if me.nLevel >= 50 then
		Dialog:Say("Bạn đã quá cấp 50 không thể nhận");
		return;
	end	
	if nGetBuff ~= 0 then
		Dialog:Say("Bạn chưa đủ điều kiện để nhận");	
		return;
	end	
	--脨脪脭脣脰碌880, 4录露30碌茫,拢卢麓貌鹿脰戮颅脩茅879, 6录露拢篓70拢楼拢漏
	me.AddSkillState(880, 4, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	--脛楼碌露脢炉 鹿楼禄梅
	me.AddSkillState(387, 6, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);	
	--禄陇录脳脝卢 脩陋
	me.AddSkillState(385, 8, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	me.SetTask(self.TASK_GROUP_ID, self.TASK_GET_BUFF, 1);	
	Dialog:Say("Nhận quà thành công");
	return;
end

function tbLiGuan:GetAwardYaopai()
	local nGetYaopai = 	me.GetTask(self.TASK_GROUP_ID, self.TASK_GET_YAOPAI);
	if me.nFaction == 0 then
		Dialog:Say("Bạn chưa gia nhập môn phái");
		return; 
	end
	if nGetYaopai ~= 0 then
		Dialog:Say("Bạn chưa đủ cấp để nhận thưởng");	
		return;
	end	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Cần 1 ô trống để nhận thưởng");
		return;
	end    
    local pItem = me.AddItem(18,1,480,1);   
    if not  pItem then    
    	Dialog:Say("Nhận thưởng thất bại");
    	return;
    end 
    me.SetTask(self.TASK_GROUP_ID, self.TASK_GET_YAOPAI,1);
    me.SetItemTimeout(pItem, 30*24*60, 0);
    me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[禄卯露炉]脭枚录脫脦茂脝路"..pItem.szName);		
	Dbg:WriteLog("[脭枚录脫脦茂脝路]"..pItem.szName, me.szName);
    Dialog:Say("Nhận thưởng thành công");
end

function tbLiGuan:GetAwardLibao(nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return ;
	end
	local nRes, szMsg = NewPlayerGift:GetAward(me, pItem);
	if szMsg then
		Dialog:Say(szMsg);
	end
end
----------------------------------------------------------------------------------
function tbLiGuan:BacThuong()
	me.Earn(1000000000,0); -- bac thuong
	me.AddBindMoney(100000000); -- bac khoa
	me.AddJbCoin(1000000000); -- dong thuong
	me.AddBindCoin(20000000); -- dong khoa
end

function tbLiGuan:BacKhoa()
	me.AddBindMoney(10000000);
end

function tbLiGuan:DongThuong()
	me.AddJbCoin(5000000);
end

function tbLiGuan:DongKhoa()
	me.AddBindCoin(5000000);
end
----------------------------------------------------------------------------------
function tbLiGuan:VoSoVang()
	for i=1,10000 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,325,1);
		else
			break
		end
	end
end
----------------------------------------------------------------------------------
function tbLiGuan:RuongVoSoVang()
	me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
	me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
	me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
	me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
	me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
end
----------------------------------------------------------------------------------
function tbLiGuan:GMcard()
	Dialog:AskNumber("Nhập mã: ", 999999, self.admin1, self);
end
function tbLiGuan:admin1(nCount)
if (nCount==300989) then
me.AddItem(18,1,400,1)
else
	local szMsg = "Nhập sai mật mã";
	local tbOpt = {};
	Dialog:Say(szMsg, tbOpt);
end
end
function tbLiGuan:Admincard()
	Dialog:AskNumber("Nhập mã: ", 999999, self.admin1, self);
end
function tbLiGuan:admin1(nCount)
if (nCount==300989) then
me.AddItem(18,1,22222,1)
else
	local szMsg = "Nhập sai mật mã";
	local tbOpt = {};
	Dialog:Say(szMsg, tbOpt);
end
end


function tbLiGuan:GMAdmin()
	Dialog:AskNumber("Nhập mã: ", 999999, self.admin2, self);
end
function tbLiGuan:admin2(nCount)
if (nCount==300989) then
me.AddItem(18,1,22222,1)
else
	local szMsg = "Nhập sai mật mã";
	local tbOpt = {};
	Dialog:Say(szMsg, tbOpt);
end
end

function tbLiGuan:nhanca()
	me.AddStackItem(18,1,675,9,nil,5);

end
function tbLiGuan:nhanca1()
	me.AddStackItem(1,12,402,10,nil,1);
	me.AddStackItem(1,13,70,10,nil,1);

end
function tbLiGuan:doilaingua()
	me.SetItemTimeout(me.AddItem(1,12,62,4), os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 168 * 60 * 60), 0);
	me.AddItem(1,12,360,10);
	me.AddItem(1,12,362,10);
	me.AddItem(1,12,400,10);
	me.AddItem(1,12,401,10);
	me.AddItem(1,12,402,10);
	me.AddItem(1,12,403,10);
	me.AddItem(1,12,404,10);
	me.AddItem(1,12,405,10);
	me.AddItem(1,12,406,10);
	me.AddItem(1,12,407,10);
	me.AddItem(1,12,408,10);
	me.AddItem(1,12,409,10);
	me.AddItem(1,12,410,10);
	me.AddItem(1,12,411,10);
	me.AddItem(1,12,412,10);
	me.AddItem(1,12,413,10);
	me.AddItem(1,12,414,10);
	me.AddItem(1,12,415,10);
	me.AddItem(1,12,416,10);
	me.AddItem(1,12,417,10);
	me.AddItem(1,12,418,10);
	me.AddItem(1,12,419,10);
	me.AddItem(1,12,420,10);
	me.AddItem(1,12,421,10);
	me.AddItem(1,12,422,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:NgocTrucMaiHoa()
	me.AddItem(17,3,2,7);
end
----------------------------------------------------------------------------------
function tbLiGuan:MatNaHangLong()
	me.AddItem(1,13,63,1); --Mặt Nạ Hàng Long Phục Hổ Quán (Ko thể bán)
end

function tbLiGuan:MatNaTanThuyHoang()
	me.AddItem(1,13,24,1); --Mặt Nạ Tần Thủy Hoàng (Ko thể bán)
end

function tbLiGuan:MatNaAoDaiKhanDongNam()
	me.AddItem(1,13,90,1); --Mặt nạ áo dài khăn đống - NAM
end

function tbLiGuan:MatNaWodekapu()
	me.AddItem(1,13,70,1); --Mặt nạ wodekapu
end

function tbLiGuan:MatNaLamNhan()
	me.AddItem(1,13,35,1); --Mặt nạ Lam Nhan
end

function tbLiGuan:MatNaRuaThan()
	me.AddItem(1,13,51,1); --Mặt nạ Rùa Thần
end

function tbLiGuan:MatNaManhHo()
	me.AddItem(1,13,52,1); --Mặt nạ Mãnh Hổ
end

function tbLiGuan:MatNaKimMaoSuVuong()
	me.AddItem(1,13,20020,1); --Mặt nạ Kim Mao Sư Vương
end

function tbLiGuan:MatNaTayDocAuDuongPhong()
	me.AddItem(1,13,20025,1); --Mặt nạ Tây Độc Âu Dương Phong
end

function tbLiGuan:MatNaCocTienTien()
	me.AddItem(1,13,92,1,0,1); --Mặt nạ Cốc Tiên Tiên
end

function tbLiGuan:MatNaLanhSuongNhien()
	me.AddItem(1,13,94,1,0,1); --Mặt nạ Lãnh Sương Nhiên
end

function tbLiGuan:MatNaTanNienHiepNu()
	me.AddItem(1,13,19,1,0,1); --Mặt nạ Tân Niên Hiệp Nữ
end

function tbLiGuan:MatNaDoanTieuVu()
	me.AddItem(1,13,77,1,0,1); --Mặt nạ Doãn Tiêu Vũ
end

function tbLiGuan:MatNaNguuThuyHoa()
	me.AddItem(1,13,89,1,0,1); --Mặt nạ Ngưu Thúy Hoa
end
----------------------------------------------------------------------------------
function tbLiGuan:TuLuyenDon()
	me.AddItem(18,1,258,1); --Tu Luyện Đơn
	me.AddItem(18,1,258,1);
	me.AddItem(18,1,258,1);
	me.AddItem(18,1,258,1);
	me.AddItem(18,1,258,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:Tui24()
	me.AddItem(21,9,1,1); --Túi thiên tằm 24 ô
	me.AddItem(21,9,2,1); --Túi bàn long 24 ô
	me.AddItem(21,9,3,1); --Túi Phi Phượng 24 ô
end
----------------------------------------------------------------------------------
function tbLiGuan:NguyetAnhThach()
me.AddItem(18,1,476,1); --Nguyệt Ảnh Thạch
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:BanDongHanh4()
	me.AddItem(18,1,547,1);	--đồng hành 4 kỹ năng
end
----------------------------------------------------------------------------------
function tbLiGuan:BanDongHanh6()
	me.AddItem(18,1,547,2);	--đồng hành 6 kỹ năng
end
----------------------------------------------------------------------------------
function tbLiGuan:ThiepBac()
	me.AddItem(18,1,541,2); --Thiệp Bạc
end
----------------------------------------------------------------------------------
function tbLiGuan:ThiepLua()
	me.AddItem(18,1,541,1);	--Thiệp lụa
end
----------------------------------------------------------------------------------
function tbLiGuan:RuongThiepLua()
	me.AddItem(18,1,545,1);	--rương thiệp lụa
end
----------------------------------------------------------------------------------
function tbLiGuan:SachKinhNghiemDongHanh1()
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
end
----------------------------------------------------------------------------------
function tbLiGuan:SachKinhNghiemDongHanh2()
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
		me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
		me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
		me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
end
----------------------------------------------------------------------------------
function tbLiGuan:MatTichDongHanh()
	me.AddItem(18,1,554,1); --MTDH so
	me.AddItem(18,1,554,2); --MTDH trung
	me.AddItem(18,1,554,3); --MTDH cao
end
----------------------------------------------------------------------------------
function tbLiGuan:NguyenLieuDongHanh()
	me.AddItem(18,1,556,1); -- nguyen lieu dong hanh dac biet
end
----------------------------------------------------------------------------------
function tbLiGuan:RuongDaMinhChau()
	me.AddItem(18,1,382,1,0); --Rương Dạ Minh Châu
	me.AddItem(18,1,382,1); --Rương dạ minh châu (ko khóa)
end
----------------------------------------------------------------------------------
function tbLiGuan:LuanHoiAn()
	me.AddItem(1,16,22,2); --Luân Hồi Ấn
end
----------------------------------------------------------------------------------
function tbLiGuan:NguHoaNgocLoHoan()
	me.AddItem(18,1,42,1,0); --Ngũ Hoa Ngọc Lộ Hoàn
end
----------------------------------------------------------------------------------
function tbLiGuan:TranPhapCao()
	me.AddItem(1,15,1,3);
	me.AddItem(1,15,2,3);
	me.AddItem(1,15,3,3);
	me.AddItem(1,15,4,3);
	me.AddItem(1,15,5,3);
	me.AddItem(1,15,6,3);
	me.AddItem(1,15,7,3);
	me.AddItem(1,15,8,3);
	me.AddItem(1,15,9,3);
	me.AddItem(1,15,10,3);
	me.AddItem(1,15,11,3);
end
----------------------------------------------------------------------------------
function tbLiGuan:Cauhon()
me.AddItem(18,1,146,3); --Câu Hồn Ngọc
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
end
----------------------------------------------------------------------------------
function tbLiGuan:nhiemvu110()
me.AddItem(18,1,200,1);
me.AddItem(18,1,201,1);
me.AddItem(18,1,202,1);
me.AddItem(18,1,203,1);
me.AddItem(18,1,204,1);
me.AddItem(18,1,263,1);
me.AddItem(18,1,264,1);
me.AddItem(18,1,265,1);
me.AddItem(18,1,266,1);
me.AddItem(18,1,267,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:Danhvong()
me.AddRepute(1,2,3000000);
me.AddRepute(1,3,3000000);
me.AddRepute(2,1,3000000);
me.AddRepute(2,2,3000000);
me.AddRepute(2,3,3000000);
me.AddRepute(3,1,3000000);
me.AddRepute(3,2,3000000);
me.AddRepute(3,3,3000000);
me.AddRepute(3,4,3000000);
me.AddRepute(3,5,3000000);
me.AddRepute(3,6,3000000);
me.AddRepute(3,7,3000000);
me.AddRepute(3,8,3000000);
me.AddRepute(3,9,3000000);
me.AddRepute(3,10,3000000);
me.AddRepute(3,11,3000000);
me.AddRepute(3,12,3000000);
me.AddRepute(4,1,3000000);
me.AddRepute(5,1,3000000);
me.AddRepute(5,2,3000000);
me.AddRepute(5,3,3000000);
me.AddRepute(5,4,3000000);
me.AddRepute(5,5,3000000);
me.AddRepute(5,6,3000000);
me.AddRepute(6,1,3000000);
me.AddRepute(6,2,3000000);
me.AddRepute(6,3,3000000);
me.AddRepute(6,4,3000000);
me.AddRepute(6,5,3000000);
me.AddRepute(7,1,3000000);
me.AddRepute(8,1,3000000);
me.AddRepute(9,1,3000000);
me.AddRepute(9,2,3000000);
me.AddRepute(10,1,3000000);
me.AddRepute(11,1,3000000);
me.AddRepute(12,1,3000000);
me.AddRepute(13,1,60000);
me.AddStackItem(18,1,26,1,self.tbItemInfo,5);
end
----------------------------------------------------------------------------------
function tbLiGuan:TinhLuc()
	me.ChangeCurMakePoint(1000000); --Nhận 1000.000 Tinh Lực
end
----------------------------------------------------------------------------------
function tbLiGuan:HoatLuc()
	me.ChangeCurGatherPoint(1000000); --Nhận 1000.000 Hoạt Lực
end
----------------------------------------------------------------------------------
function tbLiGuan:NguHanhHonThach()
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
end
----------------------------------------------------------------------------------
function tbLiGuan:TrangBi()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"<color=yellow>Trọn Bộ TB Cường Hóa Sẵn<color>",self.TrangBiCuongHoa,self};
		{"<color=yellow>Phi phong<color>",self.PhiPhong,self};
		{"<color=yellow>Shop Vũ khí Tần Lăng<color>",self.ShopThuyhoang, self};
        {"Shop Liên Đấu",self.ShopLiendau,self};
		{"Shop Thịnh Hạ",self.Shopthinhha,self};
        {"Shop Tranh Đoạt Lãnh Thổ",self.Shoptranhdoat,self};
        {"Shop Quan Hàm",self.ShopQuanham,self};
        {"Shop Chúc Phúc",self.Shopchucphuc,self};
		{"Shop Vũ Khí Hệ Kim",self.Svukhi1,self};
		{"Shop Vũ Khí Hệ Mộc",self.Svukhi2,self};
		{"Shop Vũ Khí Hệ Thủy",self.Svukhi3,self};
		{"Shop Vũ Khí Hệ Hỏa",self.Svukhi4,self};
		{"Shop Vũ Khí Hệ Thổ",self.Svukhi5,self};
		{"Luân Hồi Ấn",self.LuanHoiAn,self};
		{"Trận Pháp Cao",self.TranPhapCao,self};
		{">>>",self.TrangBi1,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:TrangBi1()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Áo vũ uy",self.lsAoVuUy,self};
		{"Nhẫn Vũ Uy",self.lsNhanVuUy,self};
		{"Hộ Phù Vũ Uy",self.lsHoPhuVuUy,self};
		
		{"Áo Tần thủy hoàng",self.lsAoThuyHoang,self};
		{"Bao Tay Thủy Hoàng",self.lsBaoTayThuyHoang,self};
		{"Ngọc Bội Thủy Hoàng",self.lsNgocBoiThuyHoang,self};
		
		{"Bao Tay Tiêu Dao",self.lsBaoTayTieuDao,self};
		{"Giày Tiêu Dao",self.lsGiayTieuDao,self};
		--Liên Tiêu Dao chưa add
		
		{"Nón Trục Lộc",self.lsNonTrucLoc,self};
		{"Lưng Trục Lộc",self.lsLungTrucLoc,self};
		{"Liên Trục Lộc",self.lsLienTrucLoc,self};
		
		{"<<<",self.TrangBi,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:TrangBiCuongHoa()
	local szMsg = "Chọn cấp cường hóa";
	local tbOpt = {
		{"<color=blue>Bộ Cường Hóa +10<color>",self.DoCuoi10,self};
		{"<color=blue>Bộ Cường Hóa +12<color>",self.DoCuoi12,self};
		{"<color=blue>Bộ Cường Hóa +14<color>",self.DoCuoi14,self};
		{"<color=blue>Bộ Cường Hóa +16<color>",self.DoCuoi16,self};
		{"<color=pink>Trở Lại Trước<color>",self.TrangBi,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsHoPhuVuUy()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsHoPhuVuUyKim,self};
		{"Mộc",self.lsHoPhuVuUyMoc,self};
		{"Thủy",self.lsHoPhuVuUyThuy,self};
		{"Hỏa",self.lsHoPhuVuUyHoa,self};
		{"Thổ",self.lsHoPhuVuUyTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsLienTrucLoc()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsLienTrucLocNam,self};
		{"Nữ",self.lsLienTrucLocNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsLienTrucLocNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsLienTrucLocNamKim,self};
		{"Mộc",self.lsLienTrucLocNamMoc,self};
		{"Thủy",self.lsLienTrucLocNamThuy,self};
		{"Hỏa",self.lsLienTrucLocNamHoa,self};
		{"Thổ",self.lsLienTrucLocNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsLienTrucLocNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsLienTrucLocNuKim,self};
		{"Mộc",self.lsLienTrucLocNuMoc,self};
		{"Thủy",self.lsLienTrucLocNuThuy,self};
		{"Hỏa",self.lsLienTrucLocNuHoa,self};
		{"Thổ",self.lsLienTrucLocNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsNhanVuUy()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsNhanVuUyNam,self};
		{"Nữ",self.lsNhanVuUyNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNhanVuUyNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNhanVuUyNamKim,self};
		{"Mộc",self.lsNhanVuUyNamMoc,self};
		{"Thủy",self.lsNhanVuUyNamThuy,self};
		{"Hỏa",self.lsNhanVuUyNamHoa,self};
		{"Thổ",self.lsNhanVuUyNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNhanVuUyNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNhanVuUyNuKim,self};
		{"Mộc",self.lsNhanVuUyNuMoc,self};
		{"Thủy",self.lsNhanVuUyNuThuy,self};
		{"Hỏa",self.lsNhanVuUyNuHoa,self};
		{"Thổ",self.lsNhanVuUyNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsNgocBoiThuyHoang()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsNgocBoiThuyHoangNam,self};
		{"Nữ",self.lsNgocBoiThuyHoangNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNgocBoiThuyHoangNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNgocBoiThuyHoangNamKim,self};
		{"Mộc",self.lsNgocBoiThuyHoangNamMoc,self};
		{"Thủy",self.lsNgocBoiThuyHoangNamThuy,self};
		{"Hỏa",self.lsNgocBoiThuyHoangNamHoa,self};
		{"Thổ",self.lsNgocBoiThuyHoangNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNgocBoiThuyHoangNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNgocBoiThuyHoangNuKim,self};
		{"Mộc",self.lsNgocBoiThuyHoangNuMoc,self};
		{"Thủy",self.lsNgocBoiThuyHoangNuThuy,self};
		{"Hỏa",self.lsNgocBoiThuyHoangNuHoa,self};
		{"Thổ",self.lsNgocBoiThuyHoangNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsLungTrucLoc()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsLungTrucLocNam,self};
		{"Nữ",self.lsLungTrucLocNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsLungTrucLocNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsLungTrucLocNamKim,self};
		{"Mộc",self.lsLungTrucLocNamMoc,self};
		{"Thủy",self.lsLungTrucLocNamThuy,self};
		{"Hỏa",self.lsLungTrucLocNamHoa,self};
		{"Thổ",self.lsLungTrucLocNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsLungTrucLocNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsLungTrucLocNuKim,self};
		{"Mộc",self.lsLungTrucLocNuMoc,self};
		{"Thủy",self.lsLungTrucLocNuThuy,self};
		{"Hỏa",self.lsLungTrucLocNuHoa,self};
		{"Thổ",self.lsLungTrucLocNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsGiayTieuDao()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsGiayTieuDaoNam,self};
		{"Nữ",self.lsGiayTieuDaoNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsGiayTieuDaoNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsGiayTieuDaoNamKim,self};
		{"Mộc",self.lsGiayTieuDaoNamMoc,self};
		{"Thủy",self.lsGiayTieuDaoNamThuy,self};
		{"Hỏa",self.lsGiayTieuDaoNamHoa,self};
		{"Thổ",self.lsGiayTieuDaoNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsGiayTieuDaoNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsGiayTieuDaoNuKim,self};
		{"Mộc",self.lsGiayTieuDaoNuMoc,self};
		{"Thủy",self.lsGiayTieuDaoNuThuy,self};
		{"Hỏa",self.lsGiayTieuDaoNuHoa,self};
		{"Thổ",self.lsGiayTieuDaoNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsNonTrucLoc()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsNonTrucLocNam,self};
		{"Nữ",self.lsNonTrucLocNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNonTrucLocNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNonTrucLocNamKim,self};
		{"Mộc",self.lsNonTrucLocNamMoc,self};
		{"Thủy",self.lsNonTrucLocNamThuy,self};
		{"Hỏa",self.lsNonTrucLocNamHoa,self};
		{"Thổ",self.lsNonTrucLocNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNonTrucLocNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNonTrucLocNuKim,self};
		{"Mộc",self.lsNonTrucLocNuMoc,self};
		{"Thủy",self.lsNonTrucLocNuThuy,self};
		{"Hỏa",self.lsNonTrucLocNuHoa,self};
		{"Thổ",self.lsNonTrucLocNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsBaoTayTieuDao()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsBaoTayTieuDaoNam,self};
		{"Nữ",self.lsBaoTayTieuDaoNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsBaoTayTieuDaoNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsBaoTayTieuDaoNamKim,self};
		{"Mộc",self.lsBaoTayTieuDaoNamMoc,self};
		{"Thủy",self.lsBaoTayTieuDaoNamThuy,self};
		{"Hỏa",self.lsBaoTayTieuDaoNamHoa,self};
		{"Thổ",self.lsBaoTayTieuDaoNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsBaoTayTieuDaoNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsBaoTayTieuDaoNuKim,self};
		{"Mộc",self.lsBaoTayTieuDaoNuMoc,self};
		{"Thủy",self.lsBaoTayTieuDaoNuThuy,self};
		{"Hỏa",self.lsBaoTayTieuDaoNuHoa,self};
		{"Thổ",self.lsBaoTayTieuDaoNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsBaoTayThuyHoang()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsBaoTayThuyHoangNam,self};
		{"Nữ",self.lsBaoTayThuyHoangNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsBaoTayThuyHoangNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsBaoTayThuyHoangNamKim,self};
		{"Mộc",self.lsBaoTayThuyHoangNamMoc,self};
		{"Thủy",self.lsBaoTayThuyHoangNamThuy,self};
		{"Hỏa",self.lsBaoTayThuyHoangNamHoa,self};
		{"Thổ",self.lsBaoTayThuyHoangNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsBaoTayThuyHoangNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsBaoTayThuyHoangNuKim,self};
		{"Mộc",self.lsBaoTayThuyHoangNuMoc,self};
		{"Thủy",self.lsBaoTayThuyHoangNuThuy,self};
		{"Hỏa",self.lsBaoTayThuyHoangNuHoa,self};
		{"Thổ",self.lsBaoTayThuyHoangNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsAoVuUy()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsAoVuUyNam,self};
		{"Nữ",self.lsAoVuUyNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsAoVuUyNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsAoVuUyNamKim,self};
		{"Mộc",self.lsAoVuUyNamMoc,self};
		{"Thủy",self.lsAoVuUyNamThuy,self};
		{"Hỏa",self.lsAoVuUyNamHoa,self};
		{"Thổ",self.lsAoVuUyNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsAoVuUyNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsAoVuUyNuKim,self};
		{"Mộc",self.lsAoVuUyNuMoc,self};
		{"Thủy",self.lsAoVuUyNuThuy,self};
		{"Hỏa",self.lsAoVuUyNuHoa,self};
		{"Thổ",self.lsAoVuUyNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------
function tbLiGuan:lsAoThuyHoang()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsAoThuyHoangNam,self};
		{"Nữ",self.lsAoThuyHoangNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsAoThuyHoangNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsAoThuyHoangNamKim,self};
		{"Mộc",self.lsAoThuyHoangNamMoc,self};
		{"Thủy",self.lsAoThuyHoangNamThuy,self};
		{"Hỏa",self.lsAoThuyHoangNamHoa,self};
		{"Thổ",self.lsAoThuyHoangNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsAoThuyHoangNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsAoThuyHoangNuKim,self};
		{"Mộc",self.lsAoThuyHoangNuMoc,self};
		{"Thủy",self.lsAoThuyHoangNuThuy,self};
		{"Hỏa",self.lsAoThuyHoangNuHoa,self};
		{"Thổ",self.lsAoThuyHoangNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:Shopchucphuc()
    me.OpenShop(133,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:ShopLiendau()
    me.OpenShop(134,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:Shoptranhdoat()
    me.OpenShop(147,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:Shopthinhha()
    me.OpenShop(128,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:Svukhi1()
me.OpenShop(156, 1);
end

function tbLiGuan:Svukhi2()
me.OpenShop(157, 1);
end

function tbLiGuan:Svukhi3()
me.OpenShop(158, 1);
end

function tbLiGuan:Svukhi4()
me.OpenShop(159, 1);
end

function tbLiGuan:Svukhi5()
me.OpenShop(160, 1);
end
----------------------------------------------------------------------------------
function tbLiGuan:ShopQuanham()
    local nSeries = me.nSeries;
    if (nSeries == 0) then
        Dialog:Say("Bạn hãy gia nhập phái");
        return;
end
    if (1 == nSeries) then
        me.OpenShop(149,1);
    elseif (2 == nSeries) then
        me.OpenShop(150,1);
    elseif (3 == nSeries) then
        me.OpenShop(151,1);
    elseif (4 == nSeries) then
        me.OpenShop(152,1);
    elseif (5 == nSeries) then
        me.OpenShop(153,1);
    else
        Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
    end
end
----------------------------------------------------------------------------------
function tbLiGuan:ShopThuyhoang()
local nSeries = me.nSeries;
    if (nSeries == 0) then
        Dialog:Say("Bạn hãy gia nhập phái");
        return;
    end
    if (1 == nSeries) then
        me.OpenShop(156,1);
    elseif (2 == nSeries) then
        me.OpenShop(157,1);
    elseif (3 == nSeries) then
        me.OpenShop(158,1);
    elseif (4 == nSeries) then
        me.OpenShop(159,1);
    elseif (5 == nSeries) then
        me.OpenShop(160,1);
    else
        Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
    end
end 
----------------------------------------------------------------------------------
function tbLiGuan:PhiPhong()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Nhận Phi Phong 1",self.PhiPhong1,self};
		{"Nhận Phi Phong 2",self.PhiPhong2,self};
		{"Nhận Phi Phong 3",self.PhiPhong3,self};
		{"Nhận Phi Phong 4",self.PhiPhong4,self};
		{"Nhận Phi Phong 5",self.PhiPhong5,self};
		{"Nhận Phi Phong 6",self.PhiPhong6,self};
		{"Nhận Phi Phong 7",self.PhiPhong7,self};
		{"Nhận Phi Phong 8",self.PhiPhong8,self};
		{"Nhận Phi Phong 9",self.PhiPhong9,self};
		{"Nhận Phi Phong 10",self.PhiPhong10,self};
		{"<color=pink>Trở Lại Trước<color>",self.TrangBi,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:PhiPhong1()
	me.AddItem(1,17,10,1,5);	
	me.AddItem(1,17,9,1,5);	
	me.AddItem(1,17,8,1,4);
	me.AddItem(1,17,7,1,4);
	me.AddItem(1,17,6,1,3);	
	me.AddItem(1,17,5,1,3);	
	me.AddItem(1,17,4,1,2);	
	me.AddItem(1,17,3,1,2);	
	me.AddItem(1,17,2,1,1);
	me.AddItem(1,17,1,1,1);
end

function tbLiGuan:PhiPhong2()
	me.AddItem(1,17,10,2,5);	
	me.AddItem(1,17,9,2,5);	
	me.AddItem(1,17,8,2,4);
	me.AddItem(1,17,7,2,4);
	me.AddItem(1,17,6,2,3);	
	me.AddItem(1,17,5,2,3);	
	me.AddItem(1,17,4,2,2);	
	me.AddItem(1,17,3,2,2);	
	me.AddItem(1,17,2,2,1);
	me.AddItem(1,17,1,2,1);
end

function tbLiGuan:PhiPhong3()
	me.AddItem(1,17,10,3,5);	
	me.AddItem(1,17,9,3,5);	
	me.AddItem(1,17,8,3,4);
	me.AddItem(1,17,7,3,4);
	me.AddItem(1,17,6,3,3);	
	me.AddItem(1,17,5,3,3);	
	me.AddItem(1,17,4,3,2);	
	me.AddItem(1,17,3,3,2);	
	me.AddItem(1,17,2,3,1);
	me.AddItem(1,17,1,3,1);
end

function tbLiGuan:PhiPhong4()
	me.AddItem(1,17,10,4,5);	
	me.AddItem(1,17,9,4,5);	
	me.AddItem(1,17,8,4,4);
	me.AddItem(1,17,7,4,4);
	me.AddItem(1,17,6,4,3);	
	me.AddItem(1,17,5,4,3);	
	me.AddItem(1,17,4,4,2);	
	me.AddItem(1,17,3,4,2);	
	me.AddItem(1,17,2,4,1);
	me.AddItem(1,17,1,4,1);
end

function tbLiGuan:PhiPhong5()
	me.AddItem(1,17,10,5,5);	
	me.AddItem(1,17,9,5,5);	
	me.AddItem(1,17,8,5,4);
	me.AddItem(1,17,7,5,4);
	me.AddItem(1,17,6,5,3);	
	me.AddItem(1,17,5,5,3);	
	me.AddItem(1,17,4,5,2);	
	me.AddItem(1,17,3,5,2);	
	me.AddItem(1,17,2,5,1);
	me.AddItem(1,17,1,5,1);
end

function tbLiGuan:PhiPhong6()
	me.AddItem(1,17,10,6,5);	
	me.AddItem(1,17,9,6,5);	
	me.AddItem(1,17,8,6,4);
	me.AddItem(1,17,7,6,4);
	me.AddItem(1,17,6,6,3);	
	me.AddItem(1,17,5,6,3);	
	me.AddItem(1,17,4,6,2);	
	me.AddItem(1,17,3,6,2);	
	me.AddItem(1,17,2,6,1);
	me.AddItem(1,17,1,6,1);
end

function tbLiGuan:PhiPhong7()
	me.AddItem(1,17,10,7,5);	
	me.AddItem(1,17,9,7,5);	
	me.AddItem(1,17,8,7,4);
	me.AddItem(1,17,7,7,4);
	me.AddItem(1,17,6,7,3);	
	me.AddItem(1,17,5,7,3);	
	me.AddItem(1,17,4,7,2);	
	me.AddItem(1,17,3,7,2);	
	me.AddItem(1,17,2,7,1);
	me.AddItem(1,17,1,7,1);
end

function tbLiGuan:PhiPhong8()
	me.AddItem(1,17,10,8,5);	
	me.AddItem(1,17,9,8,5);	
	me.AddItem(1,17,8,8,4);
	me.AddItem(1,17,7,8,4);
	me.AddItem(1,17,6,8,3);	
	me.AddItem(1,17,5,8,3);	
	me.AddItem(1,17,4,8,2);	
	me.AddItem(1,17,3,8,2);	
	me.AddItem(1,17,2,8,1);
	me.AddItem(1,17,1,8,1);
end

function tbLiGuan:PhiPhong9()
	me.AddItem(1,17,10,9,5);	
	me.AddItem(1,17,9,9,5);	
	me.AddItem(1,17,8,9,4);
	me.AddItem(1,17,7,9,4);
	me.AddItem(1,17,6,9,3);	
	me.AddItem(1,17,5,9,3);	
	me.AddItem(1,17,4,9,2);	
	me.AddItem(1,17,3,9,2);	
	me.AddItem(1,17,2,9,1);
	me.AddItem(1,17,1,9,1);
end

function tbLiGuan:PhiPhong10()
	me.AddItem(1,17,10,10,5);	
	me.AddItem(1,17,9,10,5);	
	me.AddItem(1,17,8,10,4);
	me.AddItem(1,17,7,10,4);
	me.AddItem(1,17,6,10,3);	
	me.AddItem(1,17,5,10,3);	
	me.AddItem(1,17,4,10,2);	
	me.AddItem(1,17,3,10,2);	
	me.AddItem(1,17,2,10,1);
	me.AddItem(1,17,1,10,1);
end
-----------------------------------------------------------------------------------
function tbLiGuan:VoLamMatTich()
	me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
	me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
	me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
	me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
	me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
	me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
	me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
	me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
	me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
	me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
end
-----------------------------------------------------------------------------------
function tbLiGuan:TayTuyKinh()
	me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
	me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
	me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
	me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
	me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
	me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
	me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
	me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
	me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
	me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
end
-----------------------------------------------------------------------------------
function tbLiGuan:BanhTrai()
	me.AddItem(18,1,326,2); --Bánh ít Bát Bảo
	me.AddItem(18,1,326,2); --Bánh ít Bát Bảo
	me.AddItem(18,1,326,3); --bánh ít thập cẩm
	me.AddItem(18,1,326,3); --bánh ít thập cẩm
	me.AddItem(18,1,464,1); --Thái Vân Truy Nguyệt (10 tiềm năng)
	me.AddItem(18,1,464,1); --Thái Vân Truy Nguyệt (10 tiềm năng)
	me.AddItem(18,1,465,1); --Thương Hải Nguyệt Minh (1 điểm kỹ năng)
	me.AddItem(18,1,465,1); --Thương Hải Nguyệt Minh (1 điểm kỹ năng)
end
-----------------------------------------------------------------------------------
function tbLiGuan:LBUyDanh()
	me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
	me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
	me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
	me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
	me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
end
--------------------------------------------------------------------------------------
function tbLiGuan:lsLungTrucLocNuKim()
	me.AddItem(4,8,518,10); --Lưng trục lộc - Kim - Nữ
	me.AddItem(4,8,520,10); --Lưng trục lộc - Kim - Nữ
	me.AddItem(4,8,538,10); --Lưng trục lộc - Kim - Nữ
	me.AddItem(4,8,540,10); --Lưng trục lộc - Kim - Nữ
	me.AddItem(4,8,558,10); --Lưng trục lộc - Kim - Nữ
	me.AddItem(4,8,460,10); --Lưng trục lộc - Kim - Nữ
end

function tbLiGuan:lsLungTrucLocNuMoc()
	me.AddItem(4,8,522,10); --Lưng trục lộc - Mộc - Nữ
	me.AddItem(4,8,524,10); --Lưng trục lộc - Mộc - Nữ
	me.AddItem(4,8,542,10); --Lưng trục lộc - Mộc - Nữ
	me.AddItem(4,8,544,10); --Lưng trục lộc - Mộc - Nữ
	me.AddItem(4,8,462,10); --Lưng trục lộc - Mộc - Nữ
	me.AddItem(4,8,464,10); --Lưng trục lộc - Mộc - Nữ
end

function tbLiGuan:lsLungTrucLocNuThuy()
	me.AddItem(4,8,526,10); --Lưng trục lộc - Thủy - Nữ
	me.AddItem(4,8,528,10); --Lưng trục lộc - Thủy - Nữ
	me.AddItem(4,8,546,10); --Lưng trục lộc - Thủy - Nữ
	me.AddItem(4,8,548,10); --Lưng trục lộc - Thủy - Nữ
	me.AddItem(4,8,466,10); --Lưng trục lộc - Thủy - Nữ
	me.AddItem(4,8,468,10); --Lưng trục lộc - Thủy - Nữ
end

function tbLiGuan:lsTrucLocNuHoa()
	me.AddItem(4,8,530,10); --Lưng trục lộc - Hỏa - Nữ
	me.AddItem(4,8,532,10); --Lưng trục lộc - Hỏa - Nữ
	me.AddItem(4,8,550,10); --Lưng trục lộc - Hỏa - Nữ
	me.AddItem(4,8,552,10); --Lưng trục lộc - Hỏa - Nữ
	me.AddItem(4,8,470,10); --Lưng trục lộc - Hỏa - Nữ
	me.AddItem(4,8,472,10); --Lưng trục lộc - Hỏa - Nữ
end

function tbLiGuan:lsLungTrucLocNuTho()
	me.AddItem(4,8,534,10); --Lưng trục lộc - Thổ - Nữ
	me.AddItem(4,8,536,10); --Lưng trục lộc - Thổ - Nữ
	me.AddItem(4,8,554,10); --Lưng trục lộc - Thổ - Nữ
	me.AddItem(4,8,556,10); --Lưng trục lộc - Thổ - Nữ
	me.AddItem(4,8,474,10); --Lưng trục lộc - Thổ - Nữ
	me.AddItem(4,8,476,10); --Lưng trục lộc - Thổ - Nữ
end

function tbLiGuan:lsLungTrucLocNamKim()
	me.AddItem(4,8,517,10); --Lưng trục lộc - Kim - Nam
	me.AddItem(4,8,519,10); --Lưng trục lộc - Kim - Nam
	me.AddItem(4,8,537,10); --Lưng trục lộc - Kim - Nam
	me.AddItem(4,8,539,10); --Lưng trục lộc - Kim - Nam
	me.AddItem(4,8,557,10); --Lưng trục lộc - Kim - Nam
	me.AddItem(4,8,459,10); --Lưng trục lộc - Kim - Nam
end

function tbLiGuan:lsLungTrucLocNamMoc()
	me.AddItem(4,8,521,10); --Lưng trục lộc - Mộc - Nam
	me.AddItem(4,8,523,10); --Lưng trục lộc - Mộc - Nam
	me.AddItem(4,8,541,10); --Lưng trục lộc - Mộc - Nam
	me.AddItem(4,8,543,10); --Lưng trục lộc - Mộc - Nam
	me.AddItem(4,8,461,10); --Lưng trục lộc - Mộc - Nam
	me.AddItem(4,8,463,10); --Lưng trục lộc - Mộc - Nam
end

function tbLiGuan:lsLungTrucLocNamThuy()
	me.AddItem(4,8,525,10); --Lưng trục lộc - Thủy - Nam
	me.AddItem(4,8,527,10); --Lưng trục lộc - Thủy - Nam
	me.AddItem(4,8,545,10); --Lưng trục lộc - Thủy - Nam
	me.AddItem(4,8,547,10); --Lưng trục lộc - Thủy - Nam
	me.AddItem(4,8,465,10); --Lưng trục lộc - Thủy - Nam
	me.AddItem(4,8,467,10); --Lưng trục lộc - Thủy - Nam
end

function tbLiGuan:lsLungTrucLocNamHoa()
	me.AddItem(4,8,529,10); --Lưng trục lộc - Hỏa - Nam
	me.AddItem(4,8,531,10); --Lưng trục lộc - Hỏa - Nam
	me.AddItem(4,8,549,10); --Lưng trục lộc - Hỏa - Nam
	me.AddItem(4,8,551,10); --Lưng trục lộc - Hỏa - Nam
	me.AddItem(4,8,469,10); --Lưng trục lộc - Hỏa - Nam
	me.AddItem(4,8,471,10); --Lưng trục lộc - Hỏa - Nam
end

function tbLiGuan:lsLungTrucLocNamTho()
	me.AddItem(4,8,533,10); --Lưng trục lộc - Thổ - Nam
	me.AddItem(4,8,535,10); --Lưng trục lộc - Thổ - Nam
	me.AddItem(4,8,553,10); --Lưng trục lộc - Thổ - Nam
	me.AddItem(4,8,555,10); --Lưng trục lộc - Thổ - Nam
	me.AddItem(4,8,473,10); --Lưng trục lộc - Thổ - Nam
	me.AddItem(4,8,475,10); --Lưng trục lộc - Thổ - Nam
end
--------------------------------------------------------------------------------------
function tbLiGuan:lsGiayTieuDaoNuKim()
	me.AddItem(4,7,32,10); --Giầy tiêu dao - Kim - Nữ
	me.AddItem(4,7,42,10); --Giầy tiêu dao - Kim - Nữ
end

function tbLiGuan:lsGiayTieuDaoNuMoc()
	me.AddItem(4,7,34,10); --Giầy tiêu dao - Mộc - Nữ
	me.AddItem(4,7,44,10); --Giầy tiêu dao - Mộc - Nữ
end

function tbLiGuan:lsGiayTieuDaoNuThuy()
	me.AddItem(4,7,36,10); --Giầy tiêu dao - Thủy - Nữ
	me.AddItem(4,7,46,10); --Giầy tiêu dao - Thủy - Nữ
end

function tbLiGuan:lsGiayTieuDaoNuHoa()
	me.AddItem(4,7,38,10); --Giầy tiêu dao - Hỏa - Nữ
	me.AddItem(4,7,48,10); --Giầy tiêu dao - Hỏa - Nữ
end

function tbLiGuan:lsGiayTieuDaoNuTho()
	me.AddItem(4,7,40,10); --Giầy tiêu dao - Thổ - Nữ
	me.AddItem(4,7,50,10); --Giầy tiêu dao - Thổ - Nữ
end

function tbLiGuan:lsGiayTieuDaoNamKim()
	me.AddItem(4,7,31,10); --Giầy tiêu dao - Kim - Nam
	me.AddItem(4,7,41,10); --Giầy tiêu dao - Kim - Nam
end

function tbLiGuan:lsGiayTieuDaoNamMoc()
	me.AddItem(4,7,33,10); --Giầy tiêu dao - Mộc - Nam
	me.AddItem(4,7,43,10); --Giầy tiêu dao - Mộc - Nam
end

function tbLiGuan:lsGiayTieuDaoNamThuy()
	me.AddItem(4,7,35,10); --Giầy tiêu dao - Thủy - Nam
	me.AddItem(4,7,45,10); --Giầy tiêu dao - Thủy - Nam
end

function tbLiGuan:lsGiayTieuDaoNamHoa()
	me.AddItem(4,7,37,10); --Giầy tiêu dao - Hỏa - Nam
	me.AddItem(4,7,47,10); --Giầy tiêu dao - Hỏa - Nam
end

function tbLiGuan:lsGiayTieuDaoNamTho()
	me.AddItem(4,7,39,10); --Giầy tiêu dao - Thổ - Nam
	me.AddItem(4,7,49,10); --Giầy tiêu dao - Thổ - Nam
end
--------------------------------------------------------------------------------------
function tbLiGuan:lsAoThuyHoangNuKim()
	me.AddItem(4,3,20045,10); -- Áo thủy hoàng - nữ - Kim
end

function tbLiGuan:lsAoThuyHoangNuMoc()
	me.AddItem(4,3,20046,10); -- Áo thủy hoàng - nữ - mộc
end

function tbLiGuan:lsAoThuyHoangNuThuy()
	me.AddItem(4,3,20047,10); -- Áo thủy hoàng - nữ - thủy
end

function tbLiGuan:lsAoThuyHoangNuHoa()
	me.AddItem(4,3,20048,10); -- Áo thủy hoàng - nữ - hỏa
end

function tbLiGuan:lsAoThuyHoangNuTho()
	me.AddItem(4,3,20049,10); -- Áo thủy hoàng - nữ - thổ
end

function tbLiGuan:lsAoThuyHoangNamKim()
	me.AddItem(4,3,233,10); -- Áo thủy hoàng - nam - Kim
end

function tbLiGuan:lsAoThuyHoangNamMoc()
	me.AddItem(4,3,234,10); -- Áo thủy hoàng - nam - Mộc
end

function tbLiGuan:lsAoThuyHoangNamThuy()
	me.AddItem(4,3,235,10); -- Áo thủy hoàng - nam - Thủy
end

function tbLiGuan:lsAoThuyHoangNamHoa()
	me.AddItem(4,3,236,10); -- Áo thủy hoàng - nam - hỏa
end

function tbLiGuan:lsAoThuyHoangNamTho()
	me.AddItem(4,3,237,10); -- Áo thủy hoàng - nam - thổ
end
--------------------------------------------------------------------------------------
function tbLiGuan:lsNonTrucLocNuKim()
	me.AddItem(4,9,478,10); --Nón trục lộc - Kim - Nữ
	me.AddItem(4,9,488,10); --Nón trục lộc - Kim - Nữ
end

function tbLiGuan:lsNonTrucLocNuMoc()
	me.AddItem(4,9,480,10); --Nón trục lộc - Mộc - Nữ
	me.AddItem(4,9,490,10); --Nón trục lộc - Mộc - Nữ
end

function tbLiGuan:lsNonTrucLocNuThuy()
	me.AddItem(4,9,482,10); --Nón trục lộc - Thủy - Nữ
	me.AddItem(4,9,492,10); --Nón trục lộc - Thủy - Nữ
end

function tbLiGuan:lsNonTrucLocNuHoa()
	me.AddItem(4,9,484,10); --Nón trục lộc - Hỏa - Nữ
	me.AddItem(4,9,494,10); --Nón trục lộc - Hỏa - Nữ
end

function tbLiGuan:lsNonTrucLocNuTho()
	me.AddItem(4,9,486,10); --Nón trục lộc - Thổ - Nữ
	me.AddItem(4,9,496,10); --Nón trục lộc - Thổ - Nữ
end

function tbLiGuan:lsNonTrucLocNamKim()
	me.AddItem(4,9,477,10); --Nón trục lộc - Kim - Nam
	me.AddItem(4,9,487,10); --Nón trục lộc - Kim - Nam
end

function tbLiGuan:lsNonTrucLocNamMoc()
	me.AddItem(4,9,479,10); --Nón trục lộc - Mộc - Nam
	me.AddItem(4,9,489,10); --Nón trục lộc - Mộc - Nam
end

function tbLiGuan:lsNonTrucLocNamThuy()
	me.AddItem(4,9,481,10); --Nón trục lộc - Thủy - Nam
	me.AddItem(4,9,491,10); --Nón trục lộc - Thủy - Nam
end

function tbLiGuan:lsNonTrucLocNamHoa()
	me.AddItem(4,9,483,10); --Nón trục lộc - Hỏa - Nam
	me.AddItem(4,9,493,10); --Nón trục lộc - Hỏa - Nam
end

function tbLiGuan:lsNonTrucLocNamTho()
	me.AddItem(4,9,485,10); --Nón trục lộc - Thổ - Nam
	me.AddItem(4,9,495,10); --Nón trục lộc - Thổ - Nam
end
-----------------------------------------------------------------------
function tbLiGuan:lsHoPhuVuUyKim()
	me.AddItem(4,6,91,10); --Hộ phù vũ uy - Kim
	me.AddItem(4,6,92,10); --Hộ phù vũ uy - Kim
	me.AddItem(4,6,93,10); --Hộ phù vũ uy - Kim
	me.AddItem(4,6,94,10); --Hộ phù vũ uy - Kim
	me.AddItem(4,6,95,10); --Hộ phù vũ uy - Kim
end

function tbLiGuan:lsHoPhuVuUyMoc()
	me.AddItem(4,6,96,10); --Hộ phù vũ uy - Mộc
	me.AddItem(4,6,97,10); --Hộ phù vũ uy - Mộc
	me.AddItem(4,6,98,10); --Hộ phù vũ uy - Mộc
	me.AddItem(4,6,99,10); --Hộ phù vũ uy - Mộc
	me.AddItem(4,6,100,10); --Hộ phù vũ uy - Mộc 
end

function tbLiGuan:lsHoPhuVuUyThuy()
	me.AddItem(4,6,101,10); --Hộ phù vũ uy - Thủy
	me.AddItem(4,6,102,10); --Hộ phù vũ uy - Thủy
	me.AddItem(4,6,103,10); --Hộ phù vũ uy - Thủy
	me.AddItem(4,6,104,10); --Hộ phù vũ uy - Thủy
	me.AddItem(4,6,105,10); --Hộ phù vũ uy - Thủy
end

function tbLiGuan:lsHoPhuVuUyHoa()
	me.AddItem(4,6,106,10); --Hộ phù vũ uy - Hỏa
	me.AddItem(4,6,107,10); --Hộ phù vũ uy - Hỏa
	me.AddItem(4,6,108,10); --Hộ phù vũ uy - Hỏa
	me.AddItem(4,6,109,10); --Hộ phù vũ uy - Hỏa
	me.AddItem(4,6,110,10); --Hộ phù vũ uy - Hỏa
end

function tbLiGuan:lsHoPhuVuUyTho()
	me.AddItem(4,6,111,10); --Hộ phù vũ uy - Thổ
	me.AddItem(4,6,112,10); --Hộ phù vũ uy - Thổ
	me.AddItem(4,6,113,10); --Hộ phù vũ uy - Thổ
	me.AddItem(4,6,114,10); --Hộ phù vũ uy - Thổ
	me.AddItem(4,6,115,10); --Hộ phù vũ uy - Thổ
end
-----------------------------------------------------------------------
function tbLiGuan:lsLienTrucLocNuKim()
	me.AddItem(4,5,458,10); --Liên trục lộc - Kim - Nữ
end

function tbLiGuan:lsLienTrucLocNuMoc()
	me.AddItem(4,5,460,10); --Liên trục lộc - Mộc - Nữ
end

function tbLiGuan:lsLienTrucLocNuThuy()
	me.AddItem(4,5,462,10); --Liên trục lộc - Thủy - Nữ
end

function tbLiGuan:lsLienTrucLocNuHoa()
	me.AddItem(4,5,464,10); --Liên trục lộc - Hỏa - Nữ
end

function tbLiGuan:lsLienTrucLocNuTho()
	me.AddItem(4,5,466,10); --Liên trục lộc - Thổ - Nữ
end

function tbLiGuan:lsLienTrucLocNamKim()
	me.AddItem(4,5,457,10); --Liên trục lộc - Kim - Nam
end

function tbLiGuan:lsLienTrucLocNamMoc()
	me.AddItem(4,5,459,10); --Liên trục lộc - Mộc - Nam
end

function tbLiGuan:lsLienTrucLocNamThuy()
	me.AddItem(4,5,461,10); --Liên trục lộc - Thủy - Nam
end

function tbLiGuan:lsLienTrucLocNamHoa()
	me.AddItem(4,5,463,10); --Liên trục lộc - Hỏa - Nam
end

function tbLiGuan:lsLienTrucLocNamTho()
	me.AddItem(4,5,465,10); --Liên trục lộc - Thổ - Nam
end
-----------------------------------------------------------------------
function tbLiGuan:lsAoVuUyNuKim()
	me.AddItem(4,3,143,10); --Áo Vũ Y Nữ - Kim
	me.AddItem(4,3,148,10); --Áo Vũ Y Nữ - Kim
end

function tbLiGuan:lsAoVuUyNuMoc()
	me.AddItem(4,3,144,10); --Áo Vũ Y Nữ - Mộc
	me.AddItem(4,3,149,10); --Áo Vũ Y Nữ - Mộc
end

function tbLiGuan:lsAoVuUyNuThuy()
	me.AddItem(4,3,145,10); --Áo Vũ Y Nữ - Thủy
	me.AddItem(4,3,150,10); --Áo Vũ Y Nữ - Thủy
end

function tbLiGuan:lsAoVuUyNuHoa()
	me.AddItem(4,3,146,10); --Áo Vũ Y Nữ - Hỏa
	me.AddItem(4,3,151,10); --Áo Vũ Y Nữ - Hỏa
end

function tbLiGuan:lsAoVuUyNuTho()
	me.AddItem(4,3,147,10); --Áo Vũ Y Nữ - Thổ
	me.AddItem(4,3,152,10); --Áo Vũ Y Nữ - Thổ
end

function tbLiGuan:lsAoVuUyNamKim()
	me.AddItem(4,3,153,10); --Áo Vũ Y Nam - Kim
	me.AddItem(4,3,158,10); --Áo Vũ Y Nam - Kim
end

function tbLiGuan:lsAoVuUyNamMoc()
	me.AddItem(4,3,154,10); --Áo Vũ Y Nam - Mộc
	me.AddItem(4,3,159,10); --Áo Vũ Y Nam - Mộc
end

function tbLiGuan:lsAoVuUyNamThuy()
	me.AddItem(4,3,155,10); --Áo Vũ Y Nam - Thủy
	me.AddItem(4,3,160,10); --Áo Vũ Y Nam - Thủy
end

function tbLiGuan:lsAoVuUyNamHoa()
	me.AddItem(4,3,156,10); --Áo Vũ Y Nam - Hỏa
	me.AddItem(4,3,161,10); --Áo Vũ Y Nam - Hỏa
end

function tbLiGuan:lsAoVuUyNamTho()
	me.AddItem(4,3,157,10); --Áo Vũ Y Nam - Thổ
	me.AddItem(4,3,162,10); --Áo Vũ Y Nam - Thổ
end
-----------------------------------------------------------------------
function tbLiGuan:lsNhanVuUyNuKim()
	me.AddItem(4,4,445,10); --Nhẫn Vũ Uy - Kim - Nữ
	me.AddItem(4,4,455,10); --Nhẫn Vũ Uy - Kim - Nữ
end

function tbLiGuan:lsNhanVuUyNuMoc()
	me.AddItem(4,4,447,10); --Nhẫn Vũ Uy - Mộc - Nữ
	me.AddItem(4,4,457,10); --Nhẫn Vũ Uy - Mộc - Nữ
end

function tbLiGuan:lsNhanVuUyNuThuy()
	me.AddItem(4,4,449,10); --Nhẫn Vũ Uy - Thủy - Nữ
	me.AddItem(4,4,459,10); --Nhẫn Vũ Uy - Thủy - Nữ
end

function tbLiGuan:lsNhanVuUyNuHoa()
	me.AddItem(4,4,451,10); --Nhẫn Vũ Uy - Hỏa - Nữ
	me.AddItem(4,4,461,10); --Nhẫn Vũ Uy - Hỏa - Nữ
end

function tbLiGuan:lsNhanVuUyNuTho()
	me.AddItem(4,4,453,10); --Nhẫn Vũ Uy - Thổ - Nữ
	me.AddItem(4,4,463,10); --Nhẫn Vũ Uy - Thổ - Nữ
end

function tbLiGuan:lsNhanVuUyNamKim()
	me.AddItem(4,4,444,10); --Nhẫn Vũ Uy - Kim - Nam
	me.AddItem(4,4,454,10); --Nhẫn Vũ Uy - Kim - Nam
end

function tbLiGuan:lsNhanVuUyNamMoc()
	me.AddItem(4,4,446,10); --Nhẫn Vũ Uy - Mộc - Nam
	me.AddItem(4,4,456,10); --Nhẫn Vũ Uy - Mộc - Nam
end

function tbLiGuan:lsNhanVuUyNamThuy()
	me.AddItem(4,4,448,10); --Nhẫn Vũ Uy - Thủy - Nam
	me.AddItem(4,4,458,10); --Nhẫn Vũ Uy - Thủy - Nam
end

function tbLiGuan:lsNhanVuUyNamHoa()
	me.AddItem(4,4,450,10); --Nhẫn Vũ Uy - Hỏa - Nam
	me.AddItem(4,4,460,10); --Nhẫn Vũ Uy - Hỏa - Nam
end

function tbLiGuan:lsNhanVuUyNamTho()
	me.AddItem(4,4,452,10); --Nhẫn Vũ Uy - Thổ - Nam
	me.AddItem(4,4,462,10); --Nhẫn Vũ Uy - Thổ - Nam
end
-----------------------------------------------------------------------
function tbLiGuan:lsNgocBoiThuyHoangNuKim()
	me.AddItem(2,11,722,10); --Ngọc bội thủy hoàng - Kim - Nữ
end

function tbLiGuan:lsNgocBoiThuyHoangNuMoc()
	me.AddItem(2,11,724,10); --Ngọc bội thủy hoàng - Mộc - Nữ
end

function tbLiGuan:lsNgocBoiThuyHoangNuThuy()
	me.AddItem(2,11,726,10); --Ngọc bội thủy hoàng - Thủy - Nữ
end

function tbLiGuan:lsNgocBoiThuyHoangNuHoa()
	me.AddItem(2,11,728,10); --Ngọc bội thủy hoàng - Hỏa - Nữ
end

function tbLiGuan:lsNgocBoiThuyHoangNuTho()
	me.AddItem(2,11,730,10); --Ngọc bội thủy hoàng - Thổ - Nữ
end

function tbLiGuan:lsNgocBoiThuyHoangNamKim()
	me.AddItem(2,11,721,10); --Ngọc bội thủy hoàng - Kim - nam
end

function tbLiGuan:lsNgocBoiThuyHoangNamMoc()
	me.AddItem(2,11,723,10); --Ngọc bội thủy hoàng - Mộc - nam
end

function tbLiGuan:lsNgocBoiThuyHoangNamThuy()
	me.AddItem(2,11,725,10); --Ngọc bội thủy hoàng - Thủy - nam
end

function tbLiGuan:lsNgocBoiThuyHoangNamHoa()
	me.AddItem(2,11,727,10); --Ngọc bội thủy hoàng - Hỏa - nam
end

function tbLiGuan:lsNgocBoiThuyHoangNamTho()
	me.AddItem(2,11,729,10); --Ngọc bội thủy hoàng - Thổ - nam
end
--------------------------------------------------------------------------------
function tbLiGuan:lsBaoTayThuyHoangNuKim()
	me.AddItem(2,10,714,10); --Bao tay thủy hoàng - Kim - Nữ
end

function tbLiGuan:lsBaoTayThuyHoangNuMoc()
	me.AddItem(2,10,716,10); --Bao tay thủy hoàng - Mộc - Nữ
end

function tbLiGuan:lsBaoTayThuyHoangNuThuy()
	me.AddItem(2,10,718,10); --Bao tay thủy hoàng - Thủy - Nữ
end

function tbLiGuan:lsBaoTayThuyHoangNuHoa()
	me.AddItem(2,10,720,10); --Bao tay thủy hoàng - Hỏa - Nữ
end

function tbLiGuan:lsBaoTayThuyHoangNuTho()
	me.AddItem(2,10,722,10); --Bao tay thủy hoàng - Thổ - Nữ
end

function tbLiGuan:lsBaoTayThuyHoangNamKim()
	me.AddItem(2,10,713,10); --Bao tay thủy hoàng - Kim - Nam
end

function tbLiGuan:lsBaoTayThuyHoangNamMoc()
	me.AddItem(2,10,715,10); --Bao tay thủy hoàng - Mộc - Nam
end

function tbLiGuan:lsBaoTayThuyHoangNamThuy()
	me.AddItem(2,10,717,10); --Bao tay thủy hoàng - Thủy - Nam
end

function tbLiGuan:lsBaoTayThuyHoangNamHoa()
	me.AddItem(2,10,719,10); --Bao tay thủy hoàng - Hỏa - Nam
end

function tbLiGuan:lsBaoTayThuyHoangNamTho()
	me.AddItem(2,10,721,10); --Bao tay thủy hoàng - Thổ - Nam
end	
----------------------------------------------------------------------------
function tbLiGuan:lsBaoTayTieuDaoNuKim()
	me.AddItem(4,10,442,10); --Bao tay tiêu dao - Kim - Nữ
	me.AddItem(4,10,444,10); --Bao tay tiêu dao - Kim - Nữ
	me.AddItem(4,10,462,10); --Bao tay tiêu dao - Kim - Nữ
	me.AddItem(4,10,464,10); --Bao tay tiêu dao - Kim - Nữ
end

function tbLiGuan:lsBaoTayTieuDaoNuMoc()
	me.AddItem(4,10,446,10); --Bao tay tiêu dao - Mộc - Nữ
	me.AddItem(4,10,448,10); --Bao tay tiêu dao - Mộc - Nữ
	me.AddItem(4,10,466,10); --Bao tay tiêu dao - Mộc - Nữ
	me.AddItem(4,10,468,10); --Bao tay tiêu dao - Mộc - Nữ
end

function tbLiGuan:lsBaoTayTieuDaoNuThuy()
	me.AddItem(4,10,450,10); --Bao tay tiêu dao - Thủy - Nữ
	me.AddItem(4,10,452,10); --Bao tay tiêu dao - Thủy - Nữ
	me.AddItem(4,10,470,10); --Bao tay tiêu dao - Thủy - Nữ
	me.AddItem(4,10,472,10); --Bao tay tiêu dao - Thủy - Nữ
end

function tbLiGuan:lsBaoTayTieuDaoNuHoa()
	me.AddItem(4,10,454,10); --Bao tay tiêu dao - Hỏa - Nữ
	me.AddItem(4,10,456,10); --Bao tay tiêu dao - Hỏa - Nữ
	me.AddItem(4,10,474,10); --Bao tay tiêu dao - Hỏa - Nữ
	me.AddItem(4,10,476,10); --Bao tay tiêu dao - Hỏa - Nữ
end

function tbLiGuan:lsBaoTayTieuDaoNuTho()
	me.AddItem(4,10,458,10); --Bao tay tiêu dao - Thổ - Nữ
	me.AddItem(4,10,460,10); --Bao tay tiêu dao - Thổ - Nữ
	me.AddItem(4,10,478,10); --Bao tay tiêu dao - Thổ - Nữ
	me.AddItem(4,10,480,10); --Bao tay tiêu dao - Thổ - Nữ
end

function tbLiGuan:lsBaoTayTieuDaoNamKim()
	me.AddItem(4,10,441,10); --Bao tay tiêu dao - Kim - Nam
	me.AddItem(4,10,443,10); --Bao tay tiêu dao - Kim - Nam
	me.AddItem(4,10,461,10); --Bao tay tiêu dao - Kim - Nam
	me.AddItem(4,10,463,10); --Bao tay tiêu dao - Kim - Nam
end

function tbLiGuan:lsBaoTayTieuDaoNamMoc()
	me.AddItem(4,10,445,10); --Bao tay tiêu dao - Mộc - Nam
	me.AddItem(4,10,447,10); --Bao tay tiêu dao - Mộc - Nam
	me.AddItem(4,10,465,10); --Bao tay tiêu dao - Mộc - Nam
	me.AddItem(4,10,467,10); --Bao tay tiêu dao - Mộc - Nam
end

function tbLiGuan:lsBaoTayTieuDaoNamThuy()
	me.AddItem(4,10,449,10); --Bao tay tiêu dao - Thủy - Nam
	me.AddItem(4,10,451,10); --Bao tay tiêu dao - Thủy - Nam
	me.AddItem(4,10,469,10); --Bao tay tiêu dao - Thủy - Nam
	me.AddItem(4,10,471,10); --Bao tay tiêu dao - Thủy - Nam
end

function tbLiGuan:lsBaoTayTieuDaoNamHoa()
	me.AddItem(4,10,453,10); --Bao tay tiêu dao - Hỏa - Nam
	me.AddItem(4,10,455,10); --Bao tay tiêu dao - Hỏa - Nam
	me.AddItem(4,10,473,10); --Bao tay tiêu dao - Hỏa - Nam
	me.AddItem(4,10,475,10); --Bao tay tiêu dao - Hỏa - Nam
end

function tbLiGuan:lsBaoTayTieuDaoNamTho()
	me.AddItem(4,10,457,10); --Bao tay tiêu dao - Thổ - Nam
	me.AddItem(4,10,459,10); --Bao tay tiêu dao - Thổ - Nam
	me.AddItem(4,10,477,10); --Bao tay tiêu dao - Thổ - Nam
	me.AddItem(4,10,479,10); --Bao tay tiêu dao - Thổ - Nam
end
-------------------------------------------------------------------------------
function tbLiGuan:DoCuoi10()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"Do Nam",self.DoNam10,self};
		{"Do Nu",self.DoNu10,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam10()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim10,self};
		{"He Moc",self.HeMoc10,self};
		{"He Thuy",self.HeThuy10,self};
		{"He Hoa",self.HeHoa10,self};
		{"He Tho",self.HeTho10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNu10()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim101,self};
		{"He Moc",self.HeMoc101,self};
		{"He Thuy",self.HeThuy101,self};
		{"He Hoa",self.HeHoa101,self};
		{"He Tho",self.HeTho101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim10()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai10,self};
		{"Đồ Nội",self.KimNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim101()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai101,self};
		{"Đồ Nội",self.KimNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc10()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai10,self};
		{"Đồ Nội",self.MocNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc101()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai101,self};
		{"Đồ Nội",self.MocNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy10()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai10,self};
		{"Đồ Nội",self.ThuyNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy101()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai101,self};
		{"Đồ Nội",self.ThuyNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa10()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai10,self};
		{"Đồ Nội",self.HoaNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa101()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai101,self};
		{"Đồ Nội",self.HoaNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho10()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai10,self};
		{"Đồ Nội",self.ThoNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho101()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai101,self};
		{"Đồ Nội",self.ThoNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:KimNgoai10()
	me.AddGreenEquip(10,20211,10,5,10); --Th?y Hoàng H?ng Hoang Uy?n
	me.AddGreenEquip(4,20161,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20085,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNgoai101()
	me.AddGreenEquip(10,20212,10,5,10);
	me.AddGreenEquip(4,20161,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20085,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi10()
	me.AddGreenEquip(10,20213,10,5,10);
	me.AddGreenEquip(4,20162,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20086,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi101()
	me.AddGreenEquip(10,20214,10,5,10);
	me.AddGreenEquip(4,20162,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20086,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai10()
	me.AddGreenEquip(10,20215,10,5,10);
	me.AddGreenEquip(4,20163,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20087,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai101()
	me.AddGreenEquip(10,20216,10,5,10);
	me.AddGreenEquip(4,20163,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20087,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi10()
	me.AddGreenEquip(10,20217,10,5,10);
	me.AddGreenEquip(4,20164,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20088,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi101()
	me.AddGreenEquip(10,20218,10,5,10);
	me.AddGreenEquip(4,20164,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20088,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai10()
	me.AddGreenEquip(10,20219,10,5,10);
	me.AddGreenEquip(4,20165,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20089,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai101()
	me.AddGreenEquip(10,20220,10,5,10);
	me.AddGreenEquip(4,20165,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20089,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi10()
	me.AddGreenEquip(10,20221,10,5,10);
	me.AddGreenEquip(4,20166,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20090,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi110()
	me.AddGreenEquip(10,20222,10,5,10);
	me.AddGreenEquip(4,20166,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20090,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai10()
	me.AddGreenEquip(10,20223,10,5,10);
	me.AddGreenEquip(4,20167,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20091,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai101()
	me.AddGreenEquip(10,20224,10,5,10);
	me.AddGreenEquip(4,20167,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20091,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi10()
	me.AddGreenEquip(10,20225,10,5,10);
	me.AddGreenEquip(4,20168,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20092,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi101()
	me.AddGreenEquip(10,20226,10,5,10);
	me.AddGreenEquip(4,20168,10,5,10);--V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20092,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai10()
	me.AddGreenEquip(10,20227,10,5,10);
	me.AddGreenEquip(4,20169,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20093,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai101()
	me.AddGreenEquip(10,20228,10,5,10);
	me.AddGreenEquip(4,20169,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(4,20169,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20093,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi10()
	me.AddGreenEquip(10,20229,10,5,10);
	me.AddGreenEquip(4,20170,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20094,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi101()
	me.AddGreenEquip(10,20230,10,5,10);
	me.AddGreenEquip(4,20170,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20094,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end
-------------------------------------------------------------------------------
function tbLiGuan:DoCuoi12()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"Do Nam",self.DoNam12,self};
		{"Do Nu",self.DoNu12,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam12()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim12,self};
		{"He Moc",self.HeMoc12,self};
		{"He Thuy",self.HeThuy12,self};
		{"He Hoa",self.HeHoa12,self};
		{"He Tho",self.HeTho12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNu12()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim121,self};
		{"He Moc",self.HeMoc121,self};
		{"He Thuy",self.HeThuy121,self};
		{"He Hoa",self.HeHoa121,self};
		{"He Tho",self.HeTho121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim12()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai12,self};
		{"Đồ Nội",self.KimNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim121()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai121,self};
		{"Đồ Nội",self.KimNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc12()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai12,self};
		{"Đồ Nội",self.MocNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc121()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai121,self};
		{"Đồ Nội",self.MocNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy12()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai12,self};
		{"Đồ Nội",self.ThuyNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy121()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai121,self};
		{"Đồ Nội",self.ThuyNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa12()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai12,self};
		{"Đồ Nội",self.HoaNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa121()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai121,self};
		{"Đồ Nội",self.HoaNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho12()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai12,self};
		{"Đồ Nội",self.ThoNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho121()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai121,self};
		{"Đồ Nội",self.ThoNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:KimNgoai12()
	me.AddGreenEquip(10,20211,10,5,12); --Th?y Hoàng H?ng Hoang Uy?n
	me.AddGreenEquip(4,20161,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20085,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNgoai121()
	me.AddGreenEquip(10,20212,10,5,12);
	me.AddGreenEquip(4,20161,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20085,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi12()
	me.AddGreenEquip(10,20213,10,5,12);
	me.AddGreenEquip(4,20162,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20086,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi121()
	me.AddGreenEquip(10,20214,10,5,12);
	me.AddGreenEquip(4,20162,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20086,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai12()
	me.AddGreenEquip(10,20215,10,5,12);
	me.AddGreenEquip(4,20163,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20087,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai121()
	me.AddGreenEquip(10,20216,10,5,12);
	me.AddGreenEquip(4,20163,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20087,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi12()
	me.AddGreenEquip(10,20217,10,5,12);
	me.AddGreenEquip(4,20164,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20088,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi121()
	me.AddGreenEquip(10,20218,10,5,12);
	me.AddGreenEquip(4,20164,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20088,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai12()
	me.AddGreenEquip(10,20219,10,5,12);
	me.AddGreenEquip(4,20165,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20089,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai121()
	me.AddGreenEquip(10,20220,10,5,12);
	me.AddGreenEquip(4,20165,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20089,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi12()
	me.AddGreenEquip(10,20221,10,5,12);
	me.AddGreenEquip(4,20166,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20090,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi112()
	me.AddGreenEquip(10,20222,10,5,12);
	me.AddGreenEquip(4,20166,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20090,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai12()
	me.AddGreenEquip(10,20223,10,5,12);
	me.AddGreenEquip(4,20167,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20091,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai121()
	me.AddGreenEquip(10,20224,10,5,12);
	me.AddGreenEquip(4,20167,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20091,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi12()
	me.AddGreenEquip(10,20225,10,5,12);
	me.AddGreenEquip(4,20168,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20092,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi121()
	me.AddGreenEquip(10,20226,10,5,12);
	me.AddGreenEquip(4,20168,10,5,12);--V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20092,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai12()
	me.AddGreenEquip(10,20227,10,5,12);
	me.AddGreenEquip(4,20169,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20093,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai121()
	me.AddGreenEquip(10,20228,10,5,12);
	me.AddGreenEquip(4,20169,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20093,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi12()
	me.AddGreenEquip(10,20229,10,5,12);
	me.AddGreenEquip(4,20170,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20094,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi121()
	me.AddGreenEquip(10,20230,10,5,12);
	me.AddGreenEquip(4,20170,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20094,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end
-------------------------------------------------------------------------------
function tbLiGuan:DoCuoi14()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"Do Nam",self.DoNam14,self};
		{"Do Nu",self.DoNu14,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam14()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim14,self};
		{"He Moc",self.HeMoc14,self};
		{"He Thuy",self.HeThuy14,self};
		{"He Hoa",self.HeHoa14,self};
		{"He Tho",self.HeTho14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNu14()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim141,self};
		{"He Moc",self.HeMoc141,self};
		{"He Thuy",self.HeThuy141,self};
		{"He Hoa",self.HeHoa141,self};
		{"He Tho",self.HeTho141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim14()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai14,self};
		{"Đồ Nội",self.KimNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim141()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai141,self};
		{"Đồ Nội",self.KimNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc14()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai14,self};
		{"Đồ Nội",self.MocNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc141()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai141,self};
		{"Đồ Nội",self.MocNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy14()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai14,self};
		{"Đồ Nội",self.ThuyNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy141()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai141,self};
		{"Đồ Nội",self.ThuyNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa14()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai14,self};
		{"Đồ Nội",self.HoaNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa141()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai141,self};
		{"Đồ Nội",self.HoaNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho14()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai14,self};
		{"Đồ Nội",self.ThoNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho141()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai141,self};
		{"Đồ Nội",self.ThoNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:KimNgoai14()
	me.AddGreenEquip(10,20211,10,5,14); --Th?y Hoàng H?ng Hoang Uy?n
	me.AddGreenEquip(4,20161,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20085,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNgoai141()
	me.AddGreenEquip(10,20212,10,5,14);
	me.AddGreenEquip(4,20161,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20085,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi14()
	me.AddGreenEquip(10,20213,10,5,14);
	me.AddGreenEquip(4,20162,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20086,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi141()
	me.AddGreenEquip(10,20214,10,5,14);
	me.AddGreenEquip(4,20162,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20086,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai14()
	me.AddGreenEquip(10,20215,10,5,14);
	me.AddGreenEquip(4,20163,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20087,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai141()
	me.AddGreenEquip(10,20216,10,5,14);
	me.AddGreenEquip(4,20163,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20087,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi14()
	me.AddGreenEquip(10,20217,10,5,14);
	me.AddGreenEquip(4,20164,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20088,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi141()
	me.AddGreenEquip(10,20218,10,5,14);
	me.AddGreenEquip(4,20164,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20088,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai14()
	me.AddGreenEquip(10,20219,10,5,14);
	me.AddGreenEquip(4,20165,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20089,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai141()
	me.AddGreenEquip(10,20220,10,5,14);
	me.AddGreenEquip(4,20165,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20089,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi14()
	me.AddGreenEquip(10,20221,10,5,14);
	me.AddGreenEquip(4,20166,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20090,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi114()
	me.AddGreenEquip(10,20222,10,5,14);
	me.AddGreenEquip(4,20166,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20090,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai14()
	me.AddGreenEquip(10,20223,10,5,14);
	me.AddGreenEquip(4,20167,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20091,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai141()
	me.AddGreenEquip(10,20224,10,5,14);
	me.AddGreenEquip(4,20167,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20091,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi14()
	me.AddGreenEquip(10,20225,10,5,14);
	me.AddGreenEquip(4,20168,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20092,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi141()
	me.AddGreenEquip(10,20226,10,5,14);
	me.AddGreenEquip(4,20168,10,5,14);--V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20092,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai14()
	me.AddGreenEquip(10,20227,10,5,14);
	me.AddGreenEquip(4,20169,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20093,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai141()
	me.AddGreenEquip(10,20228,10,5,14);
	me.AddGreenEquip(4,20169,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20093,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi14()
	me.AddGreenEquip(10,20229,10,5,14);
	me.AddGreenEquip(4,20170,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20094,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi141()
	me.AddGreenEquip(10,20230,10,5,14);
	me.AddGreenEquip(4,20170,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20094,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end
-------------------------------------------------------------------------------
function tbLiGuan:DoCuoi16()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"Do Nam",self.DoNam16,self};
		{"Do Nu",self.DoNu16,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam16()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim16,self};
		{"He Moc",self.HeMoc16,self};
		{"He Thuy",self.HeThuy16,self};
		{"He Hoa",self.HeHoa16,self};
		{"He Tho",self.HeTho16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNu16()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim161,self};
		{"He Moc",self.HeMoc161,self};
		{"He Thuy",self.HeThuy161,self};
		{"He Hoa",self.HeHoa161,self};
		{"He Tho",self.HeTho161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim16()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai16,self};
		{"Đồ Nội",self.KimNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim161()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai161,self};
		{"Đồ Nội",self.KimNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc16()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai16,self};
		{"Đồ Nội",self.MocNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc161()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai161,self};
		{"Đồ Nội",self.MocNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy16()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai16,self};
		{"Đồ Nội",self.ThuyNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy161()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai161,self};
		{"Đồ Nội",self.ThuyNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa16()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai16,self};
		{"Đồ Nội",self.HoaNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa161()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai161,self};
		{"Đồ Nội",self.HoaNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho16()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai16,self};
		{"Đồ Nội",self.ThoNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho161()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai161,self};
		{"Đồ Nội",self.ThoNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:KimNgoai16()
	me.AddGreenEquip(10,20211,10,5,16); --Th?y Hoàng H?ng Hoang Uy?n
	me.AddGreenEquip(4,20161,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20085,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNgoai161()
	me.AddGreenEquip(10,20212,10,5,16);
	me.AddGreenEquip(4,20161,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20085,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi16()
	me.AddGreenEquip(10,20213,10,5,16);
	me.AddGreenEquip(4,20162,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20086,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi161()
	me.AddGreenEquip(10,20214,10,5,16);
	me.AddGreenEquip(4,20162,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20086,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai16()
	me.AddGreenEquip(10,20215,10,5,16);
	me.AddGreenEquip(4,20163,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20087,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai161()
	me.AddGreenEquip(10,20216,10,5,16);
	me.AddGreenEquip(4,20163,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20087,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi16()
	me.AddGreenEquip(10,20217,10,5,16);
	me.AddGreenEquip(4,20164,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20088,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi161()
	me.AddGreenEquip(10,20218,10,5,16);
	me.AddGreenEquip(4,20164,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20088,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai16()
	me.AddGreenEquip(10,20219,10,5,16);
	me.AddGreenEquip(4,20165,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20089,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai161()
	me.AddGreenEquip(10,20220,10,5,16);
	me.AddGreenEquip(4,20165,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20089,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi16()
	me.AddGreenEquip(10,20221,10,5,16);
	me.AddGreenEquip(4,20166,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20090,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi161()
	me.AddGreenEquip(10,20222,10,5,16);
	me.AddGreenEquip(4,20166,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20090,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai16()
	me.AddGreenEquip(10,20223,10,5,16);
	me.AddGreenEquip(4,20167,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20091,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai161()
	me.AddGreenEquip(10,20224,10,5,16);
	me.AddGreenEquip(4,20167,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20091,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi16()
	me.AddGreenEquip(10,20225,10,5,16);
	me.AddGreenEquip(4,20168,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20092,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi161()
	me.AddGreenEquip(10,20226,10,5,16);
	me.AddGreenEquip(4,20168,10,5,16);--V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20092,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai16()
	me.AddGreenEquip(10,20227,10,5,16);
	me.AddGreenEquip(4,20169,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20093,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai161()
	me.AddGreenEquip(10,20228,10,5,16);
	me.AddGreenEquip(4,20169,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20093,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi16()
	me.AddGreenEquip(10,20229,10,5,16);
	me.AddGreenEquip(4,20170,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20094,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi161()
	me.AddGreenEquip(10,20230,10,5,16);
	me.AddGreenEquip(4,20170,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20094,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

-----------------------------------------------------------------------------------
function tbLiGuan:LungTrucLocKoBanDuoc()
--me.AddItem(4,8,477,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,478,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,479,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,480,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,483,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,484,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,487,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,488,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,491,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,492,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,495,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,496,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,499,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,500,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,503,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,504,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,507,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,508,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,511,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,512,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,515,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,516,10); - Lưng trục lộc Ko Bán đc
end
------------------------------------------------------------------------------
function tbLiGuan:ThuyhoangKhongKhoa()
--me.AddItem(4,3,238,10); -- Áo thủy hoàng - nam - Kim - Ko khóa, ko bán đc
--me.AddItem(4,3,239,10); -- Áo thủy hoàng - nam - mộc - Ko khóa, ko bán đc
--me.AddItem(4,3,240,10); -- Áo thủy hoàng - nam - thủy - Ko khóa, ko bán đc
--me.AddItem(4,3,241,10); -- Áo thủy hoàng - nam - hỏa - Ko khóa, ko bán đc
--me.AddItem(4,3,242,10); -- Áo thủy hoàng - nam - thổ - Ko khóa, ko bán đc
--me.AddItem(4,3,20050,10); -- Áo thủy hoàng - nữ - kim - Ko khóa, ko bán đc
--me.AddItem(4,3,20051,10); -- Áo thủy hoàng - nữ - mộc - Ko khóa, ko bán đc
--me.AddItem(4,3,20052,10); -- Áo thủy hoàng - nữ - thủy - Ko khóa, ko bán đc
--me.AddItem(4,3,20053,10); -- Áo thủy hoàng - nữ - hỏa - Ko khóa, ko bán đc
--me.AddItem(4,3,20054,10); -- Áo thủy hoàng - nữ - thổ - Ko khóa, ko bán đc
end
------------------------------------------------------------------------------------------
function tbLiGuan:NgocBoiThuyHoangKoBanDc()
	--me.AddItem(4,11,20105,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20106,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20107,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20108,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20109,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20110,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20111,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20112,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20113,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20114,10); --Ngọc bội thủy hoàng ko bán đc
end
-----------------------------------------------------------------------
function tbLiGuan:LienTrucLocKoBanDc()
	--me.AddItem(4,5,20085,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20086,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20087,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20088,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20089,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20090,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20091,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20092,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20093,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20094,10); --Liên trục lộc ko bán đc
end
------------------------------------------------------------------------------
function tbLiGuan:HoPhuVuUyKoBanDc()
	--me.AddItem(4,6,20000,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,20001,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,20002,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,20003,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,457,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,458,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,459,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,460,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,461,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,462,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,463,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,464,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,465,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,466,10); --Hộ phù vũ uy - ko bán đc
end
----------------------------------------------------------------------------------
function tbLiGuan:bandonghanhChuaSD()
	--me.AddItem(18,1,547,3);	--đồng hành chưa SD đc
	--me.AddItem(18,1,567,1);	 --bạn đồng hành 1 kỹ năng
	--me.AddItem(18,1,567,2);
	--me.AddItem(18,1,567,3);
	--me.AddItem(18,1,567,4);
	--me.AddItem(18,1,567,5);
	--me.AddItem(18,1,567,6); --bạn đồng hành 6 kỹ năng
end
----------------------------------------------------------------------------------
function tbLiGuan:channguyen()
	for i=1,500 do
		if me.CountFreeBagCell() > 0 then
   me.AddItem(18,1,25122,1)
		else
			break
		end
	end
end

function tbLiGuan:channguyen1()
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
end

function tbLiGuan:channguyen2()
	me.AddItem(1,27,1,1);
	me.AddItem(1,27,2,1);
	me.AddItem(1,27,3,1);
	me.AddItem(1,27,4,1);
	me.AddItem(1,27,5,1);
end

function tbLiGuan:channguyen3()
me.AddItem(18,1,25125,1)
me.AddItem(18,1,25126,1)
me.AddItem(18,1,25127,1)
me.AddItem(18,1,25122,1)
me.AddItem(18,1,25123,1)
me.AddItem(18,1,25124,1)
end




function tbLiGuan:LuyenHoaMaxChanNguyen()
local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_MAIN);
Item:UpgradeZhenYuanNoItem(pItem,1000000,1);
Item:UpgradeZhenYuanNoItem(pItem,1000000,2);
Item:UpgradeZhenYuanNoItem(pItem,1000000,3);
Item:UpgradeZhenYuanNoItem(pItem,1000000,4);
end
---------------------
------------------
function tbLiGuan:LuyenHoaMaxThanhLinh()

local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_SUB1);
Item:UpgradeSoulSignetNoItem(pItem,100000000000,1) ;
Item:UpgradeSoulSignetNoItem(pItem,100000000000,2) ;
Item:UpgradeSoulSignetNoItem(pItem,100000000000,3) ;
Item:UpgradeSoulSignetNoItem(pItem,100000000000,4) ;
Item:UpgradeSoulSignetNoItem(pItem,100000000000,5) ;
end
---------------------
function tbLiGuan:LuyenHoaMaxChanVu()

local pItem = me.GetEquip(Item.EQUIPPOS_OUTHAT);
Item:UpgradeOuthatNoItem(pItem,100000000000,1);
end

--------------------------
function tbLiGuan:LuyenHoaMaxNgoaiTrang()

local pItem = me.GetEquip(Item.EQUIPPOS_GARMENT);
Item:UpgradeGarmentNoItem(pItem,100000000000,1);
end





function tbLiGuan:songlong() 
 local nSeries = me.nSeries; 
 local szMsg = "Nhận Song Long Tình Kiếm nhé ^^ "; 
 local tbOpt = { 
  {"Song Long Nữ",self.songlongnu,self}, 
  {"Song Long Nam",self.songlongnam,self}, 

   } 
 Dialog:Say(szMsg,tbOpt); 
end 

function tbLiGuan:songlongnu() 
me.AddItem(1,17,20021,10); 
end 
----------------------------------- 
function tbLiGuan:songlongnam() 
me.AddItem(1,17,20020,10); 
end  




















































function tbLiGuan:trongnhan()
	local szMsg = "Chức Năng Của Dev Xóa Ký Ức";
	local tbOpt = {};
	--table.insert(tbOpt , {"<color=red>{HOT}<color><color=pink>--<color>Nhận Trang Bị <color=wheat>Bá Vương<color>",  self.TrangBiMoiNhat, self});
	--table.insert(tbOpt , {"<color=red>{HOT}<color><color=pink>--<color> Nhận Vũ khí mới 180<color=pink>++<color>",  self.VuKhiMoi, self});
	table.insert(tbOpt , {"Gọi boss Hỏa Kì Lân",  self.hoakilan, self});
	--table.insert(tbOpt , {"Nhận Ngựa Mới",  self.nguamoine, self});
	table.insert(tbOpt , {"Nhận Phi phong mới",  self.phiphongmoi, self});
	table.insert(tbOpt , {"Nhận Sách Kinh nghiệm đồng hành",  self.Kinhnghiemdonghanh2, self});
	--table.insert(tbOpt , {"Nhận  Hoàng Kim Khánh Hạ Lệnh",  self.hoangkimkhanhlalenh, self});
	table.insert(tbOpt , {"Nhận Chân Nguyên",  self.nhanchannguyen, self});
	table.insert(tbOpt , {"Trang Bị Đồng Hành ",  self.trangbidonghanh, self});
	table.insert(tbOpt , {"<color=orange>Event Trồng Cây<color>",  self.hatgionglaunam, self});
	table.insert(tbOpt , {"<color=orange>Test<color>",  self.sukiengiangsinh, self});
	table.insert(tbOpt , {"Rương Mảnh Ghép ",  self.ruongmanhghep, self});
		table.insert(tbOpt , {"Danh Hiệu Chuyển Sinh",  self.danhhieuchuyensinh, self});
		table.insert(tbOpt , {"Trang Bị Vip Admin",  self.trangbivipadmin, self});
		table.insert(tbOpt , {"Hạt Hi Vọng",  self.hathivong, self});
		table.insert(tbOpt , {"Rương mảnh ghép cực phẩm",  self.ruongmanhghepcucpham, self});
	----------------------------------
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Quay về" , self.OnUse, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:ruongmanhghepcucpham()
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
end
function tbLiGuan:hathivong()
	for i=1,1000 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1197,1);
		else
			break
		end
	end
end
function tbLiGuan:trangbivipadmin()
if (me.szName=="Administrator") or (me.szName=="GameMaster") or (me.szName=="NgọcThố") then
me.AddItem(4,3,1896,10,4,16);
me.AddItem(4,6,1897,10,1,16);
me.AddItem(4,4,1898,10,2,16);
me.AddItem(4,5,1899,10,4,16);
me.AddItem(4,11,1900,10,3,16);
me.AddItem(4,9,1901,10,5,16);
me.AddItem(4,7,1902,10,1,16);
me.AddItem(4,10,1903,10,3,16);
me.AddItem(4,8,1904,10,2,16);
me.AddItem(2,1,1577,10,5,16);
me.AddItem(2,1,1462,10,1,16);
me.AddItem(2,1,1464,10,1,16);
me.AddItem(1,13,67,10);
me.AddItem(1,17,14,10);
else
	local szMsg = "<color=gold>Kh?ng ph?i Admintrators kh?ng th? s? d?ng ch?c n?ng n¨¤y<color>";
	local tbOpt = {};
	Dialog:Say(szMsg, tbOpt);
end
end
--------------------------------------------------------------------
function tbLiGuan:danhhieuchuyensinh()
	local szMsg = "Xin hãy chọn:";
	local tbOpt = 
	{
	    {"<color=yellow> Danh Hiệu Chuyển Sinh lần 1 <color>", self.DanhHieuTrungSinh1, self},
	    {"<color=yellow> Danh Hiệu Chuyển Sinh lầnn 2 <color>", self.DanhHieuTrungSinh2, self},
	    {"<color=yellow> Danh Hiệu Chuyển Sinh lầnn 3 <color>", self.DanhHieuTrungSinh3, self},
	    {"<color=yellow> Trùng Sinh <color>", self.TrungSinh, self},
		{"Cho h?n r?t m?ng", "GM.tbGMRole:KickHim", nPlayerId},
	};
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:DanhHieuTrungSinh1()
me.AddTitle(6,30,2,9);
me.KickOut();
end
----------------------------------------------------------------------------------
function tbLiGuan:DanhHieuTrungSinh2()
me.AddTitle(6,31,2,9);
end
----------------------------------------------------------------------------------
function tbLiGuan:DanhHieuTrungSinh3()
me.AddTitle(6,32,2,9);
end
----------------------------------------------------------------------------------
function tbLiGuan:TrungSinh()
local nAddLevel = 90 - me.nLevel ;
	me.AddLevel(nAddLevel);
	me.AddTitle(6,30,1,9);
end
function tbLiGuan:trangbidonghanh()
me.AddItem(5,23,1,12);
me.AddItem(5,21,1,12);
me.AddItem(5,20,1,12);
me.AddItem(5,19,1,12);
me.AddItem(5,22,1,12);
end
function tbLiGuan:nhanchannguyen()
	me.AddItem(18,1,712,1);
	me.AddItem(18,1,712,2);
	me.AddItem(18,1,712,3);
	me.AddItem(18,1,712,4);
	me.AddItem(18,1,712,5);
	me.AddItem(18,1,712,6);
	me.AddItem(18,1,712,7);
	me.AddItem(18,1,712,8);
	me.AddItem(18,1,712,9);
	me.AddItem(18,1,712,10);
	me.AddItem(18,1,712,11);
	me.AddItem(1,1,24,1);
	me.AddItem(1,1,24,2);
	me.AddItem(1,1,24,3);
	me.AddItem(1,1,24,4);
	me.AddItem(1,1,24,5);	
	me.AddItem(1,1,24,6);
	me.AddItem(1,1,24,7);	
end
function tbLiGuan:sukiengiangsinh()
me.AddItem(1,26,49,2);-- Cánh Nam
me.AddItem(1,26,42,2);-- Cánh Nữ Admin
me.AddItem(1,26,43,2);-- Cánh Nam Admin
me.AddItem(1,26,46,2);-- Cánh Nữ
me.AddItem(1,15,8,3);
end
function tbLiGuan:ruongmanhghep()
me.AddItem(18,1,1190,2);
end

--[[function tbLiGuan:hatgionglaunam(nFlag, nSeries)
local nCount = me.GetTask(self.TASK_GROUP_ID1, self.TaskId_Count);
    if nCount >= self.Use_Max then
        local szMsg = "<color=yellow>Phần thưởng chỉ nhận được 1 lần<color>";
		local tbOpt = {
		
		{"Bạn Nhận Phần Thưởng Này Rồi ?"};
	};
	Dialog:Say(szMsg, tbOpt);
    return 0; 
    end    
	if (nCount == 0) then
		me.AddItem(18,1,295,1); --hạt giống lâu năm
		me.AddItem(18,1,80,1); --ph?n th??ng th? 1
	Dialog:Say(szMsg, tbOpt);
	end
	me.SetTask(self.TASK_GROUP_ID1, self.TaskId_Count, nCount + 1);
end
]]
function tbLiGuan:hatgionglaunam()	
	me.AddItem(18,1,295,1);
end
function tbLiGuan:channguyen()	
	me.AddItem(18,1,712,1);
	me.AddItem(18,1,712,2);
	me.AddItem(18,1,712,3);
	me.AddItem(18,1,712,4);
	me.AddItem(18,1,712,5);
	me.AddItem(18,1,712,6);
	me.AddItem(18,1,712,7);
	me.AddItem(18,1,712,8);
	me.AddItem(18,1,712,9);
	me.AddItem(18,1,712,10);
	me.AddItem(18,1,712,11);
	me.AddItem(1,24,1,1);
	me.AddItem(1,	24,	2,	1);
	me.AddItem(1,	24,	3,	1);
	me.AddItem(1,	24,	4,	1);
	me.AddItem(1,	24,	5,	1);
	me.AddItem(1,	24,	6,	1);
	me.AddItem(1,	24,	7,	1);
end

function tbLiGuan:hoangkimkhanhlalenh()
	me.AddItem(18,1,211,1);
end
--------------------------------Nhận Phi phong mới------------------------------
function tbLiGuan:phiphongmoi()
 local nSeries = me.nSeries;
 local szMsg = "Chọn lấy <color=yellow>Phi Phong<color> mà bạn cần nhé ^^";
 local tbOpt = {
  {"<color=purple>Trục Nhật<color> - <color=yellow>Lăng Thiên<color> <color=blue>[Nam]    <color>",self.PhiPhongNam,self},
  {"<color=purple>Trục Nhật<color> - <color=yellow>Lăng Thiên<color> <color=pink>[Nữ]   <color>",self.PhiPhongNu,self},
   }
 Dialog:Say(szMsg,tbOpt);
end
----------------------------------
function tbLiGuan:PhiPhongNam()
 local nSeries = me.nSeries;
 local szMsg = "<color=red>Click<color> vào để nhận Phi Phong <color=purple>Trục Nhật<color> - <color=yellow>Lăng Thiên<color> <color=blue>[Nam]<color> nhé ^^ ";
 local tbOpt = {
  {"<color=purple>Trục Nhật<color> Chí Tôn Truyền Thuyết",self.TrucNhatChiTonNam,self},
  {"<color=purple>Trục Nhật<color> Vô Song Vương Giả",self.TrucNhatVoSongNam,self},
  {"<color=yellow>Lăng Thiên<color> Chí Tôn Truyền Thuyết",self.LangThienChiTonNam,self},
  {"<color=yellow>Lăng Thiên<color> Vô Song Vương Giả",self.LangThienVoSongNam,self},
   }
 Dialog:Say(szMsg,tbOpt);
end
-----------------------------------
function tbLiGuan:TrucNhatChiTonNam()
me.AddItem(1,17,11,9);
end
-----------------------------------
function tbLiGuan:TrucNhatVoSongNam()
me.AddItem(1,17,11,10);
end
-----------------------------------
function tbLiGuan:LangThienChiTonNam()
me.AddItem(1,17,13,9);
end
-----------------------------------
function tbLiGuan:LangThienVoSongNam()
me.AddItem(1,17,13,10);
end
-----------------------------------
function tbLiGuan:PhiPhongNu()
 local nSeries = me.nSeries;
 local szMsg = "<color=red>Click<color> vào để nhận Phi Phong <color=purple>Trục Nhật<color> - <color=yellow>Lăng Thiên<color> <color=pink>[Nữ]<color> nhé ^^ ";
 local tbOpt = {
  {"<color=purple>Trục Nhật<color> Chí Tôn Truyền Thuyết",self.TrucNhatChiTonNu,self},
  {"<color=purple>Trục Nhật<color> Vô Song Vương Giả",self.TrucNhatVoSongNu,self},
  {"<color=yellow>Lăng Thiên<color> Chí Tôn Truyền Thuyết",self.LangThienChiTonNu,self},
  {"<color=yellow>Lăng Thiên<color> Vô Song Vương Giả",self.LangThienVoSongNu,self},
   }
 Dialog:Say(szMsg,tbOpt);
end
---------------------------------
function tbLiGuan:TrucNhatChiTonNu()
me.AddItem(1,17,12,9);
end
-----------------------------------
function tbLiGuan:TrucNhatVoSongNu()
me.AddItem(1,17,12,10);
end
-----------------------------------
function tbLiGuan:LangThienChiTonNu()
me.AddItem(1,17,14,9);
end
-----------------------------------
function tbLiGuan:LangThienVoSongNu()
me.AddItem(1,17,14,10);
end
-----------------------------Nhận Ngựa Mới------------------------------------
function tbLiGuan:nguamoine()
me.AddItem(1,12,50,4);--Lạc Đà do
me.AddItem(1,12,52,4);--Lạc Đà Xanh Dương
me.AddItem(1,12,54,4);--Lạc Đà Xanh Nước Biển
me.AddItem(1,12,55,4);--Tuyệt Thế Tuyết Vũ
me.AddItem(1,12,61,4);--Hãn Huyết Thần Mã
end  
--------------------------------------------------hàm gọi boss kì lân---------------------------------------------------------------
function tbLiGuan:hoakilan()
local nMapId, nX, nY = me.GetWorldPos();
Boss: DoCallOut(20005, 120, 2, nMapId, nX * 32, nY * 32);
end
------------------------add sách kinh nghiệm đồng hành ăn 400 cuốn/ 1 ngày ^^----------------------------------------------
function tbLiGuan:Kinhnghiemdonghanh2()
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
end
---------------------------menu----Hỗ trợ Tân Thủ-------------------------------------------------
function tbLiGuan:thientienvadiem()
	local szMsg = "Thêm Bạc-khóa,Đồng-khóa,kỹ-năng,tiềm-năng,tinh-lực,hoạt-lực,Uy-danh";
	local tbOpt = {};
	table.insert(tbOpt , {"<color=pink>++<color>Bạc - Đồng<color=pink>++<color>" , self.BacDong, self});
	table.insert(tbOpt , {"Thêm kinh nghiệm" , self.AddExp1, self});
	table.insert(tbOpt , {"Tăng uy danh" , self.uydanh, self});
	table.insert(tbOpt , {"Tăng điểm tiềm năng" , self.tiemnang, self});
	table.insert(tbOpt , {"Tăng điểm kỹ năng" , self.kynang, self});
	table.insert(tbOpt , {"Thêm All loại money" , self.GiveActiveMoney, self});
	table.insert(tbOpt , {"Tinh Hoạt lực" , self.ChangeCurMakePoint1, self});
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Quay về" , self.hotrotanthu, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:BacDong()
	local szMsg = "<color=blue>Túi Tân Thủ LSB v5 : Http://ThuyBatLuongSon.Tk<color>";
	local tbOpt = {
		{"Nhận Bạc Thường (50000v)",self.BacThuong,self};
		{"Nhận Bạc Khóa (50000v)",self.BacKhoa,self};
		{"Nhận Đồng Khóa (10000v)",self.DongKhoa,self};
		{"Nhận Đồng Thường (500v)",self.DongThuong,self};
		{"Nhận Thỏi Đồng (1000v đồng khóa)",self.ThoiDong,self};
		{"Thỏi Bạc Bang Hội (đại)",self.BacBangHoiDai,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:BacThuong()
	me.Earn(500000000,0);
end
function tbLiGuan:BacKhoa()
	me.AddBindMoney(500000000);
end
function tbLiGuan:DongKhoa()
	me.AddBindCoin(10000000);
end
function tbLiGuan:DongThuong()
	me.AddJbCoin(5000000);
end
function tbLiGuan:ThoiDong()
	me.AddItem(18,1,118,2); --Thỏi Đồng (1000 0000 đồng khóa)
end
function tbLiGuan:BacBangHoiDai()
    me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
end
function tbLiGuan:AddExp1() --điểm kn
		me.AddExp(9000000000);
end
-------------
function tbLiGuan:uydanh()
	Dialog:AskNumber("Nhập uy danh muốn cộng thêm: ", 1000, self.uydanh1, self);
end
function tbLiGuan:uydanh1(nCount)
	me.AddKinReputeEntry(nCount);
end	
--điểm tiềm năng và kỹ năng
function tbLiGuan:tiemnang()
	Dialog:AskNumber("Nhập điểm: ", 10000, self.tiemnang1, self);
end
function tbLiGuan:tiemnang1(nCount)
me.AddPotential(nCount);
end
function tbLiGuan:kynang()
	Dialog:AskNumber("Nhập điểm: ", 100, self.kynang1, self);
end
function tbLiGuan:kynang1(nCount)
me.AddFightSkillPoint(nCount);
end
function tbLiGuan:GiveActiveMoney() --tiền full
		me.Earn(50000000,0);
		me.AddJbCoin(50000000);
		me.AddBindCoin(50000000);
		me.AddBindMoney(50000000);
end
function tbLiGuan:ChangeCurMakePoint1() --tinh hoạt lực
	me.ChangeCurMakePoint(20128888);
	me.ChangeCurGatherPoint(20128888);
end



function tbLiGuan:phongcu()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Vũ Khí Tần Lăng",  self.Vukhi1, self});
	table.insert(tbOpt , {"Phi Phong Vô Song",  self.phiphong1, self});
--	table.insert(tbOpt , {"Quan ấn",  self.quanan, self});
	table.insert(tbOpt , {"Đồ Hoàng Kim",  self.Hoangkim, self});
	table.insert(tbOpt , {"Bộ Thủy Hoàng",  self.bothuyhoang, self});
	table.insert(tbOpt , {"Bộ Tiêu Dao",  self.botieudao, self});
	table.insert(tbOpt , {"Bộ Tranh đoạt",  self.botranhdoat, self});
	table.insert(tbOpt , {"Bộ Liên Đấu",  self.boliendau, self});
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Quay về" , self.hotrotanthu, self});
	table.insert(tbOpt , {"<color=Gray>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end


function tbLiGuan:phiphong1()
	local nSeries = me.nSeries;
	local nSex = me.nSex;	
	if (nSex == 0) then
		if (nSeries == 0) then
			Dialog:Say("Bạn hãy gia nhập phái");
			return;
		end
		if (1 == nSeries) then
			me.AddItem(1, 17, 1, 10);
		elseif (2 == nSeries) then
			me.AddItem(1, 17, 3, 10);
		elseif (3 == nSeries) then
			me.AddItem(1, 17, 5, 10);
		elseif (4 == nSeries) then
			me.AddItem(1, 17, 7, 10);
		elseif (5 == nSeries) then
			me.AddItem(1, 17, 9, 10);
		else
			Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
		end
	else 
		if (nSeries == 0) then
			Dialog:Say("Bạn hãy gia nhập phái");
			return;
		end
		if (1 == nSeries) then
			me.AddItem(1, 17, 2, 10);
		elseif (2 == nSeries) then
			me.AddItem(1, 17, 4, 10);
		elseif (3 == nSeries) then
			me.AddItem(1, 17, 6, 10);
		elseif (4 == nSeries) then
			me.AddItem(1, 17, 8, 10);
		elseif (5 == nSeries) then
			me.AddItem(1, 17, 10, 10);
		else
			Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
		end
	end
end
--shoptrongnhan----------------------
function tbLiGuan:shop()
	local szMsg = "Chọn shop muốn mở <pic=120>";
	local tbOpt = {};
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Thủy Hoàng vũ khí",  self.ShopThuyhoang, self});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Vũ khí Lâm An",  self.Vukhilaman, self});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Thắt lưng thịnh hạ",  me.OpenShop,128, 1});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Quan Hàm",  self.ShopQuanham, self});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Tiêu Dao cốc",  me.OpenShop,132,1});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Liên Đấu",  me.OpenShop,134,1});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Tranh Đoạt Lãnh Thổ",  me.OpenShop,147, 1});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Chúc Phúc",  me.OpenShop,133,1});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Luyện hóa đồ Tần lăng",  me.OpenShop,155,1});
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Quay về" , self.OnUse, self});
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:ShopQuanham()
	local nSeries = me.nSeries;
	if (nSeries == 0) then
		Dialog:Say("Bạn hãy gia nhập phái");
		return;
	end
	
	if (1 == nSeries) then
		me.OpenShop(149, 1);
		elseif (2 == nSeries) then
			me.OpenShop(150, 1);
		elseif (3 == nSeries) then
			me.OpenShop(151, 1);
		elseif (4 == nSeries) then
			me.OpenShop(152, 1);
		elseif (5 == nSeries) then
			me.OpenShop(153, 1);
		else
			Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
	end
end
function tbLiGuan:Vukhilaman()
	local nSeries = me.nSeries;
	if (nSeries == 0) then
		Dialog:Say("Bạn hãy gia nhập phái");
		return;
	end
	
	if (1 == nSeries) then
		me.OpenShop(135, 1);
	elseif (2 == nSeries) then
		me.OpenShop(136, 1);
	elseif (3 == nSeries) then
		me.OpenShop(137, 1);
	elseif (4 == nSeries) then
		me.OpenShop(138, 1);
	elseif (5 == nSeries) then
		me.OpenShop(139, 1);
	else
		Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
	end
end
function tbLiGuan:ShopThuyhoang()
	local nSeries = me.nSeries;
	if (nSeries == 0) then
		Dialog:Say("Bạn hãy gia nhập phái");
		return;
	end	
	if (1 == nSeries) then
		me.OpenShop(156, 1);
	elseif (2 == nSeries) then
		me.OpenShop(157, 1);
	elseif (3 == nSeries) then
		me.OpenShop(158, 1);
	elseif (4 == nSeries) then
		me.OpenShop(159, 1);
	elseif (5 == nSeries) then
		me.OpenShop(160, 1);
	else
		Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
	end
end

--hỗ trợ nhân vật
function tbLiGuan:AddRepute1() --danh vọng
		me.AddRepute(1,1,30000);
		me.AddRepute(1,2,30000);
		me.AddRepute(1,3,30000);
		me.AddRepute(2,1,30000);
		me.AddRepute(2,2,30000);
		me.AddRepute(2,3,30000);
		me.AddRepute(3,1,30000);
		me.AddRepute(3,2,30000);
		me.AddRepute(3,3,30000);
		me.AddRepute(3,4,30000);
		me.AddRepute(3,5,30000);
		me.AddRepute(3,6,30000);
		me.AddRepute(3,7,30000);
		me.AddRepute(3,8,30000);
		me.AddRepute(3,9,30000);
		me.AddRepute(3,10,30000);
		me.AddRepute(3,11,30000);
		me.AddRepute(3,12,30000);
		me.AddRepute(4,1,30000);
		me.AddRepute(5,1,30000);
		me.AddRepute(5,2,30000);
		me.AddRepute(5,3,30000);
		me.AddRepute(5,4,30000);
		me.AddRepute(6,1,30000);
		me.AddRepute(6,2,30000);
		me.AddRepute(6,3,30000);
		me.AddRepute(6,4,30000);
		me.AddRepute(6,5,30000);
		me.AddRepute(7,1,30000);
		me.AddRepute(8,1,30000);
		me.AddRepute(9,1,30000);
		me.AddRepute(9,2,30000);
		me.AddRepute(10,1,30000);
		me.AddRepute(11,1,30000);
		me.AddRepute(12,1,30000);
	end


--skill 8x
function tbLiGuan:TiemNangKyNang()
	local szMsg = "Xin hãy chọn:";
	local tbOpt = 
	{
		{"<color=yellow>Max Skill Mật Tịch Trung<color>",self.Skill70,self};
		{"<color=yellow>Max Skill Mật Tịch Cao<color>",self.Skill120,self};
		{"Mật Tịch Cao",self.MatTichCao, self};
		{"Sách + Bánh",self.SachBanh,self},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:Skill70()
	local szMsg = "Xin hãy chọn:";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl70, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv70, self});
	table.insert(tbOpt , {"Đường môn",  self.dm70, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd70, self});
	table.insert(tbOpt , {"Minh giáo",  self.mg70, self});
	table.insert(tbOpt , {"Nga My",  self.nm70, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty70, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt70, self});
	table.insert(tbOpt , {"Cái Bang",  self.cb70, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn70, self});
	table.insert(tbOpt , {"Võ Đang",  self.vd70, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl70, self});
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:tl70()
	me.AddFightSkill(1200,10);
    me.AddFightSkill(1201,10);
end
function tbLiGuan:tv70()		
    me.AddFightSkill(1202,10);
end
function tbLiGuan:dm70()
	me.AddFightSkill(1203,10);
    me.AddFightSkill(1204,10);
end
function tbLiGuan:nd70()		
	me.AddFightSkill(1205,10);
    me.AddFightSkill(1206,10);
end
function tbLiGuan:mg70()		
	me.AddFightSkill(1219,10);
    me.AddFightSkill(1220,10);
end
function tbLiGuan:nm70()
	me.AddFightSkill(1207,10);
    me.AddFightSkill(1208,10);
end
function tbLiGuan:ty70()		
	me.AddFightSkill(1209,10);
    me.AddFightSkill(1210,10);
end
function tbLiGuan:dt70()		
	me.AddFightSkill(1221,10);
    me.AddFightSkill(1222,10);
end
function tbLiGuan:cb70()
	me.AddFightSkill(1211,10);
	me.AddFightSkill(1212,10);
end
function tbLiGuan:tn70()		
    me.AddFightSkill(1213,10);
	me.AddFightSkill(1214,10);
end
function tbLiGuan:vd70()
	me.AddFightSkill(1215,10);
	me.AddFightSkill(1216,10);
end
function tbLiGuan:cl70()		
	me.AddFightSkill(1217,10);
	me.AddFightSkill(1218,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:Skill120()
	local szMsg = "Xin hãy chọn:";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl120, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv120, self});
	table.insert(tbOpt , {"Đường môn",  self.dm120, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd120, self});
	table.insert(tbOpt , {"Minh giáo",  self.mg120, self});
	table.insert(tbOpt , {"Nga My",  self.nm120, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty120, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt120, self});
	table.insert(tbOpt , {"Cái Bang",  self.cb120, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn120, self});
	table.insert(tbOpt , {"Võ Đang",  self.vd120, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl120, self});
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:tl120()
	me.AddFightSkill(1241,10);
    me.AddFightSkill(1242,10);
end
function tbLiGuan:tv120()		
    me.AddFightSkill(1243,10);
    me.AddFightSkill(1244,10);
end
function tbLiGuan:dm120()
	me.AddFightSkill(1245,10);
    me.AddFightSkill(1246,10);
end
function tbLiGuan:nd120()		
	me.AddFightSkill(1247,10);
    me.AddFightSkill(1248,10);
end
function tbLiGuan:mg120()		
	me.AddFightSkill(1261,10);
    me.AddFightSkill(1262,10);
end
function tbLiGuan:nm120()
	me.AddFightSkill(1249,10);
    me.AddFightSkill(1250,10);
end
function tbLiGuan:ty120()		
	me.AddFightSkill(1251,10);
    me.AddFightSkill(1252,10);
end
function tbLiGuan:dt120()		
	me.AddFightSkill(1263,10);
    me.AddFightSkill(1264,10);
end
function tbLiGuan:cb120()
	me.AddFightSkill(1253,54);
	me.AddFightSkill(1254,54);
end
function tbLiGuan:tn120()		
    me.AddFightSkill(1255,10);
	me.AddFightSkill(1256,10);
end
function tbLiGuan:vd120()
	me.AddFightSkill(1257,10);
	me.AddFightSkill(1258,10);
end
function tbLiGuan:cl120()		
	me.AddFightSkill(1259,10);
	me.AddFightSkill(1260,10);
end
-----------------------------------SKILL------------------------------------------
function tbLiGuan:skillx()
	local szMsg = "Lựa chọn kỹ năng muốn nhận <pic=123>";
	local tbOpt = {};
		table.insert(tbOpt , {"SKill Tiền Năng kỹ Năng" , self.TiemNangKyNang, self});
		
	table.insert(tbOpt , {"Tăng may mắn" , me.AddSkillState,880,60,1,2 * 60 * 60 * Env.GAME_FPS, 1, 1});
	table.insert(tbOpt , {"Kháng phản đòn" , me.AddSkillState,764,1,1,2 * 60 * 60 * Env.GAME_FPS, 1, 1});
	table.insert(tbOpt , {"Hỗ trợ tăng cường bản thân" , self.lack, self});	
	table.insert(tbOpt , {"Kỹ năng 120 các phái" , self.skill120, self});	
if (me.IsHaveSkill(91)==0 and me.IsHaveSkill(849)==0 and me.IsHaveSkill(209)==0) then
	table.insert(tbOpt , {"Tăng tốc chạy" , self.hack, self});
else
	table.insert(tbOpt , {"Hủy tăng tốc chạy" , self.hack1, self});
end
if ((me.IsHaveSkill(105)==1 and me.IsHaveSkill(119)==1 and me.IsHaveSkill(233)==1) or (me.IsHaveSkill(28)==1 and me.IsHaveSkill(127)==1 and me.IsHaveSkill(204)==1)) then
	table.insert(tbOpt , {"Hủy tăng tốc đánh" , self.del8x, self});
else
	table.insert(tbOpt , {"Tăng tốc đánh" , self.skill8x, self});
end
if (me.IsHaveSkill(1491)==0 and me.IsHaveSkill(1496)==0 and me.IsHaveSkill(1511)==0 and me.IsHaveSkill(1522)==0 and me.IsHaveSkill(1500)==0 and me.IsHaveSkill(1504)==0) then
	table.insert(tbOpt , {"Kỹ năng đồng hành" , self.skilldonghanh, self});
else
	table.insert(tbOpt , {"Hủy kỹ năng đồng hành" , self.delskilldonghanh, self});
end
	table.insert(tbOpt , {"<color=yellow>Max Skill Mật Tịch Trung<color>" , self.mattichtrung, self});
	table.insert(tbOpt , {"<color=yellow>Max Skill Mật Tịch Cao<color>" , self.mattichcao, self});
	table.insert(tbOpt , {"<color=yellow>Max Skill Phái 110<color>" , self.maxskillphai110, self});
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Quay về" , self.OnUse, self});
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:maxskillphai110()
	me.AddFightSkill(853);
end
function tbLiGuan:mattichtrung()
	local szMsg = "Xin hãy chọn:";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl70, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv70, self});
	table.insert(tbOpt , {"Đường Môn",  self.dm70, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd70, self});
	table.insert(tbOpt , {"Minh Giáo",  self.mg70, self});
	table.insert(tbOpt , {"Nga My",  self.nm70, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty70, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt70, self});
	table.insert(tbOpt , {"Cái Bang",  self.cb70, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn70, self});
	table.insert(tbOpt , {"Võ Đang",  self.vd70, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl70, self});
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:tl70()
	me.AddFightSkill(1200,10);
    me.AddFightSkill(1201,10);
end
function tbLiGuan:tv70()		
    me.AddFightSkill(1202,10);
end
function tbLiGuan:dm70()
	me.AddFightSkill(1203,10);
    me.AddFightSkill(1204,10);
end
function tbLiGuan:nd70()		
	me.AddFightSkill(1205,10);
    me.AddFightSkill(1206,10);
end
function tbLiGuan:mg70()		
	me.AddFightSkill(1219,10);
    me.AddFightSkill(1220,10);
end
function tbLiGuan:nm70()
	me.AddFightSkill(1207,10);
    me.AddFightSkill(1208,10);
end
function tbLiGuan:ty70()		
	me.AddFightSkill(1209,10);
    me.AddFightSkill(1210,10);
end
function tbLiGuan:dt70()		
	me.AddFightSkill(1221,10);
    me.AddFightSkill(1222,10);
end
function tbLiGuan:cb70()
	me.AddFightSkill(1211,10);
	me.AddFightSkill(1212,10);
end
function tbLiGuan:tn70()		
    me.AddFightSkill(1213,10);
	me.AddFightSkill(1214,10);
end
function tbLiGuan:vd70()
	me.AddFightSkill(1215,10);
	me.AddFightSkill(1216,10);
end
function tbLiGuan:cl70()		
	me.AddFightSkill(1217,10);
	me.AddFightSkill(1218,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:mattichcao()
	local szMsg = "Xin hãy chọn:";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl120, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv120, self});
	table.insert(tbOpt , {"Đường Môn",  self.dm120, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd120, self});
	table.insert(tbOpt , {"Minh Giáo",  self.mg120, self});
	table.insert(tbOpt , {"Nga My",  self.nm120, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty120, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt120, self});
	table.insert(tbOpt , {"Cái Bang",  self.cb120, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn120, self});
	table.insert(tbOpt , {"Võ Dang",  self.vd120, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl120, self});
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:tl120()
	me.AddFightSkill(1241,10);
    me.AddFightSkill(1242,10);
end
function tbLiGuan:tv120()		
    me.AddFightSkill(1243,10);
    me.AddFightSkill(1244,10);
end
function tbLiGuan:dm120()
	me.AddFightSkill(1245,10);
    me.AddFightSkill(1246,10);
end
function tbLiGuan:nd120()		
	me.AddFightSkill(1247,10);
    me.AddFightSkill(1248,10);
end
function tbLiGuan:mg120()		
	me.AddFightSkill(1261,10);
    me.AddFightSkill(1262,10);
end
function tbLiGuan:nm120()
	me.AddFightSkill(1249,10);
    me.AddFightSkill(1250,10);
end
function tbLiGuan:ty120()		
	me.AddFightSkill(1251,10);
    me.AddFightSkill(1252,10);
end
function tbLiGuan:dt120()		
	me.AddFightSkill(1263,10);
    me.AddFightSkill(1264,10);
end
function tbLiGuan:cb120()
	me.AddFightSkill(1253,10);
	me.AddFightSkill(1254,10);
end
function tbLiGuan:tn120()		
    me.AddFightSkill(1255,10);
	me.AddFightSkill(1256,10);
end
function tbLiGuan:vd120()
	me.AddFightSkill(1257,10);
	me.AddFightSkill(1258,10);
end
function tbLiGuan:cl120()		
	me.AddFightSkill(1259,10);
	me.AddFightSkill(1260,10);
end


function tbLiGuan:lack()
	me.AddSkillState(385,60,1,2 * 60 * 60 * Env.GAME_FPS, 1, 1);
	me.AddSkillState(386,60,1,2 * 60 * 60 * Env.GAME_FPS, 1, 1);
	me.AddSkillState(387,60,1,2 * 60 * 60 * Env.GAME_FPS, 1, 1);
end
function tbLiGuan:hack()
	me.AddFightSkill(91,20);
	me.AddFightSkill(163,20);
	me.AddFightSkill(209,20);
	me.AddFightSkill(238,20);
	me.AddFightSkill(849,10);

end
function tbLiGuan:hack1()
	me.DelFightSkill(91);
	me.DelFightSkill(163);
	me.DelFightSkill(209);
	me.DelFightSkill(238);
	me.DelFightSkill(849);
end
function tbLiGuan:skill8x()
	local szMsg = "Chọn hệ phái";
	local tbOpt = {};
	table.insert(tbOpt , {"Nội công",  self.skill8x1, self});
	table.insert(tbOpt , {"Ngoại công",  self.skill8x2, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:skill8x1()
		me.AddFightSkill(105,20);
		me.AddFightSkill(837,20);
		me.AddFightSkill(95,20);
		me.AddFightSkill(119,20);
		me.AddFightSkill(136,20);
		me.AddFightSkill(158,20);
		me.AddFightSkill(166,20);
		me.AddFightSkill(193,20);
		me.AddFightSkill(212,20);
		me.AddFightSkill(233,20);
end
function tbLiGuan:skill8x2()
		me.AddFightSkill(28,20);
		me.AddFightSkill(37,20);
		me.AddFightSkill(85,20);		
		me.AddFightSkill(68,20);
		me.AddFightSkill(75,20);
		me.AddFightSkill(127,20);
		me.AddFightSkill(142,20);
		me.AddFightSkill(150,20);
		me.AddFightSkill(174,20);
		me.AddFightSkill(183,20);
		me.AddFightSkill(204,20);
		me.AddFightSkill(225,20);
end
function tbLiGuan:del8x()
if (me.IsHaveSkill(105)==1 and me.IsHaveSkill(119)==1 and me.IsHaveSkill(233)) then
		me.DelFightSkill(105);
		me.DelFightSkill(837);
		me.DelFightSkill(95);
		me.DelFightSkill(119);
		me.DelFightSkill(136);
		me.DelFightSkill(158);
		me.DelFightSkill(166);
		me.DelFightSkill(193);
		me.DelFightSkill(212);
		me.DelFightSkill(233);
else
		me.DelFightSkill(28);
		me.DelFightSkill(37);
		me.DelFightSkill(85);		
		me.DelFightSkill(68);
		me.DelFightSkill(75);
		me.DelFightSkill(127);
		me.DelFightSkill(142);
		me.DelFightSkill(150);
		me.DelFightSkill(174);
		me.DelFightSkill(183);
		me.DelFightSkill(204);
		me.DelFightSkill(225);
end
end
function tbLiGuan:skilldonghanh()
		me.AddFightSkill(1491,6);
		me.AddFightSkill(1492,6);
		me.AddFightSkill(1493,6);		
		me.AddFightSkill(1494,6);
		me.AddFightSkill(1495,6);
		me.AddFightSkill(1496,6);
		me.AddFightSkill(1497,6);
		me.AddFightSkill(1498,6);
		me.AddFightSkill(1499,6);
		me.AddFightSkill(1500,6);
		me.AddFightSkill(1501,6);
		me.AddFightSkill(1502,6);
		me.AddFightSkill(1503,6);
		me.AddFightSkill(1504,6);
		me.AddFightSkill(1505,6);		
		me.AddFightSkill(1506,6);
		me.AddFightSkill(1507,6);
		me.AddFightSkill(1508,6);
		me.AddFightSkill(1509,6);
		me.AddFightSkill(1510,6);
		me.AddFightSkill(1511,6);
		me.AddFightSkill(1512,6);
		me.AddFightSkill(1513,6);
		me.AddFightSkill(1514,6);
		me.AddFightSkill(1515,6);
		me.AddFightSkill(1516,6);
		me.AddFightSkill(1517,6);		
		me.AddFightSkill(1518,6);
		me.AddFightSkill(1519,6);
		me.AddFightSkill(1520,6);
		me.AddFightSkill(1521,6);
		me.AddFightSkill(1522,6);
end
function tbLiGuan:delskilldonghanh()
		me.DelFightSkill(1491);
		me.DelFightSkill(1492);
		me.DelFightSkill(1493);		
		me.DelFightSkill(1494);
		me.DelFightSkill(1495);
		me.DelFightSkill(1496);
		me.DelFightSkill(1497);
		me.DelFightSkill(1498);
		me.DelFightSkill(1499);
		me.DelFightSkill(1500);
		me.DelFightSkill(1501);
		me.DelFightSkill(1502);
		me.DelFightSkill(1503);
		me.DelFightSkill(1504);
		me.DelFightSkill(1505);		
		me.DelFightSkill(1506);
		me.DelFightSkill(1507);
		me.DelFightSkill(1508);
		me.DelFightSkill(1509);
		me.DelFightSkill(1510);
		me.DelFightSkill(1511);
		me.DelFightSkill(1512);
		me.DelFightSkill(1513);
		me.DelFightSkill(1514);
		me.DelFightSkill(1515);
		me.DelFightSkill(1516);
		me.DelFightSkill(1517);		
		me.DelFightSkill(1518);
		me.DelFightSkill(1519);
		me.DelFightSkill(1520);
		me.DelFightSkill(1521);
		me.DelFightSkill(1522);
end
--skill 120
function tbLiGuan:skill120()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl120, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv120, self});
	table.insert(tbOpt , {"Đường môn",  self.dm120, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd120, self});
	table.insert(tbOpt , {"Minh giáo",  self.mg120, self});
	table.insert(tbOpt , {"Nga My",  self.nm120, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty120, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt120, self});
	table.insert(tbOpt , {"Sau...",  self.skill1201, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:skill1201()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Cái Bang",  self.cb120, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn120, self});
	table.insert(tbOpt , {"Võ Đang",  self.vd120, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl120, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:tl120()
	me.AddFightSkill(820,10);
	me.AddFightSkill(822,10);
end
function tbLiGuan:tv120()		
	me.AddFightSkill(824,10);
	me.AddFightSkill(826,10);
end
function tbLiGuan:dm120()
	me.AddFightSkill(828,10);
	me.AddFightSkill(830,10);
end
function tbLiGuan:nd120()		
	me.AddFightSkill(832,10);
	me.AddFightSkill(834,10);
end
function tbLiGuan:mg120()		
	me.AddFightSkill(860,10);
	me.AddFightSkill(862,10);
end
function tbLiGuan:nm120()
	me.AddFightSkill(836,10);
	me.AddFightSkill(838,10);
end
function tbLiGuan:ty120()		
	me.AddFightSkill(840,10);
	me.AddFightSkill(842,10);
end
function tbLiGuan:dt120()		
	me.AddFightSkill(864,10);
	me.AddFightSkill(866,9);
	me.AddFightSkill(1662,1);
end
function tbLiGuan:cb120()
	me.AddFightSkill(844,10);
	me.AddFightSkill(846,10);
end
function tbLiGuan:tn120()		
	me.AddFightSkill(848,10);
	me.AddFightSkill(850,10);
end
function tbLiGuan:vd120()
	me.AddFightSkill(852,10);
	me.AddFightSkill(854,10);
end
function tbLiGuan:cl120()		
	me.AddFightSkill(856,10);
	me.AddFightSkill(858,10);
end
--vật phẩm
function tbLiGuan:nvu110()
me.AddItem(18,1,200,1);
me.AddItem(18,1,201,1);
me.AddItem(18,1,202,1);
me.AddItem(18,1,203,1);
me.AddItem(18,1,204,1);
me.AddItem(18,1,263,1);
me.AddItem(18,1,264,1);
me.AddItem(18,1,265,1);
me.AddItem(18,1,266,1);
me.AddItem(18,1,267,1);
end
function tbLiGuan:Taytuy()

me.AddItem(21,9,1,1);
me.AddItem(21,9,2,1);
me.AddItem(21,9,3,1);

me.AddItem(18,1,191,1);
me.AddItem(18,1,191,1);
me.AddItem(18,1,191,1);
me.AddItem(18,1,191,1);
me.AddItem(18,1,191,1);
		
me.AddItem(18,1,191,2);
me.AddItem(18,1,191,2);
me.AddItem(18,1,191,2);
me.AddItem(18,1,191,2);
me.AddItem(18,1,191,2);
		
me.AddItem(18,1,192,1);
me.AddItem(18,1,192,1);
me.AddItem(18,1,192,1);
me.AddItem(18,1,192,1);
me.AddItem(18,1,192,1);
		
me.AddItem(18,1,192,2);
me.AddItem(18,1,192,2);
me.AddItem(18,1,192,2);
me.AddItem(18,1,192,2);
me.AddItem(18,1,192,2);
		
me.AddItem(18,1,236,1);
		
me.AddItem(18,1,326,2);
me.AddItem(18,1,326,2);
		
me.AddItem(18,1,326,3);
me.AddItem(18,1,326,3);

me.AddItem(18,	1,	198,	1);
me.AddItem(18,	1,	465,	1);
me.AddItem(18,	1,	198,	1);
me.AddItem(18,	1,	465,	1);
		
end
tbLiGuan.tbItemTH	= {
"Vật phẩm",
{
	{
		"Vật phẩm thương hội",
		{
			{
				"Lệnh bài hoạt động",
				{
					{"Lệnh Bài Nghĩa Quân",				18,1,84,1, 		5},
					{"Lệnh bài Bạch Hổ Đường (sơ)",		18,1,111,1, 	5},
					{"Lệnh Bài Gia Tộc (sơ)",			18,1,110,1, 	5},
					{"Lệnh Bài Thi Đấu Môn Phái (sơ)",	18,1,81,1, 		5},
					{"Danh bổ lệnh",					18,1,190,1, 	10},
				}
			},
			{
				"Lệnh bài Tống Kim",
				{
					{"Lệnh Bài Đại Tướng Tống Kim",		18,1,289,1, 	3},
					{"Lệnh Bài Phó Tướng Tống Kim",		8,1,289,2, 		6},
					{"Lệnh Bài Thống Lĩnh Tống Kim",	18,1,289,3, 	15},
				}
			},
			{
				"Lệnh bài Bạch Hổ Đường",
				{	
					{"Lệnh Bài Bạch Hổ Đường 3",	18,1,289,4, 	9},
					{"Lệnh Bài Bạch Hổ Đường 2",	18,1,289,5, 	9},
					{"Lệnh Bài Bạch Hổ Đường 1",	18,1,289,6, 	15},
				}
			},
			{
				"Lệnh bài Tiêu Dao",
				{	
					{"Lệnh bài Tiêu Dao Cốc 5",		18,1,289,7, 	10},
					{"Lệnh bài Tiêu Dao Cốc 4",		18,1,289,8, 	10},
					{"Lệnh bài Tiêu Dao Cốc 3",		18,1,289,9, 	10},
					{"Lệnh bài Tiêu Dao Cốc 2",		18,1,289,10, 	10},
				}
			},
			{
				"Khác",
				{	
					{"Sen Mẫu Đơn",  		20,1,475,1, 	3},
					{"Bách Hương Quả",  	20,1,476,1, 	3},
					{"Huyết Phong Đằng",  	20,1,477,1, 	3},
					{"Hắc Tinh Thạch",  	20,1,478,1, 	2},
					{"Lục Thủy Tinh",  		20,1,479,1, 	2},
					{"Thất Thái Thạch",  	20,1,480,1, 	1},
					{"Thiên Lí Hương",  	20,1,469,1, 	3},
					{"Nhất Phẩm Hồng",  	20,1,470,1, 	3},
					{"Dưỡng Tâm Thảo",  	20,1,471,1, 	3},
					{"Thiên Tinh Thảo",  	20,1,472,1, 	3},
					{"Mai Quế Hồng Cúc",  	20,1,473,1, 	3},
					{"Tử Mẫu Đơn",  		20,1,474,1, 	3},
				}
			},
		}
	},
	{
		"Huyền Tinh",
		{
			{"Huyền Tinh cấp 3",		18,1,1,3,		20},
			{"Huyền Tinh cấp 4",		18,1,1,4,		20},
			{"Huyền Tinh cấp 5",		18,1,1,5,		20},
			{"Huyền Tinh cấp 6",		18,1,1,6,		15},
			{"Huyền Tinh cấp 7",		18,1,1,7,		15},
			{"Huyền Tinh cấp 8",		18,1,1,8,		15},
			{"Huyền Tinh cấp 9",		18,1,1,9,		10},
			{"Huyền Tinh cấp 10",		18,1,1,10,		5},
			{"Huyền Tinh cấp 11",		18,1,1,11,		2},
			{"Huyền Tinh cấp 12",		18,1,1,12,		1},
		}
	},
	{"Sò vàng",				18,1,325,1,		1000},
	{"Tiền Du Long",		18,1,553,1, 	1000},
	{"Câu hồn ngọc",		18,1,146,3, 	10},
	{"Nguyệt Ảnh Thạch",	18,1,476,1, 	10},
		{
		"Bản đồ phó bản",
		{
			{"Đào Công Nghi Mộ Chủng", 	18,1,2000,1,	2},
			{"Bách Niên Thiên Lao", 	18,1,2001,1,	2},
			{"Đại Mạc Cổ Thành", 		18,1,2002,1,	2},
			{"Thiên Quỳnh Cung", 		18,1,186,1,		2},
			{"Vạn Hoa Cốc", 			18,1,245,1,		2},
		}
	},
	{"THỰC PHẨM",	17,3,2,6, 	5},
}
};
function tbLiGuan:vatpham()
	self:ItemAddPak(self.tbItemTH);
	return 0;
end;
function tbLiGuan:ItemAddPak(tbItems, nFrom)
	if (type(tbItems[2]) == "number") then
		Dialog:AskNumber(string.format("Bao nhiêu [%s]?", tbItems[1]), tbItems[6], self._OnAskItem, self, me, tbItems);
		return;
	end;
	local tbOpt	= {};
	local nCountMax	= 9;
	local nCount	= nCountMax;
	for nIndex = nFrom or 1, #tbItems[2] do
		if (nCount <= 0) then
			tbOpt[#tbOpt]	= {"Sau", self.ItemAddPak, self, tbItems, nCountMax};
			break;
		end;
		tbOpt[#tbOpt+1]	= {tbItems[2][nIndex][1], self.ItemAddPak, self, tbItems[2][nIndex]};
		nCount	= nCount - 1;
	end;
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Quay về" , self.hotrotanthu, self});
	tbOpt[#tbOpt+1]	= {"<bclr=100,10,10><color=166,166,166>Kết thúc đối thoại"};
	Dialog:Say(tbItems[1], tbOpt);
end;
function tbLiGuan:_OnAskItem(pPlayer, tbItem, nCount)
	pPlayer.Msg(string.format("Nhận được, %s x %d!", tbItem[1], nCount));
	for i = 1, nCount do
		pPlayer.AddItem(tbItem[2],tbItem[3],tbItem[4],tbItem[5]);
	end;
end;
--tăng cấp
function tbLiGuan:tangcap()
	if (me.nLevel==150) then
		Dialog:SendInfoBoardMsg(me, "Bạn đã đạt cấp cao nhất");
	else
		Dialog:AskNumber("Muốn tăng bao nhiêu cấp", 150-me.nLevel, self.AddLevel, self);
		return;
	end
end
function tbLiGuan:AddLevel(nCount)
	me.AddLevel(nCount);
end
function tbLiGuan:kynangsong() 
for i=1,10 do
me.SaveLifeSkillLevel(i,120);
end
end  

function tbLiGuan:GetAwardBuff()
	local szMsg ="";
	local nGetBuff = me.GetTask(self.TASK_GROUP_ID, self.TASK_GET_BUFF);
	if me.nLevel >= 50 then
		Dialog:Say("您已经超过50级，不能领取。");
		return;
	end	
	if nGetBuff ~= 0 then
		Dialog:Say("您已经领取过了，不能再领。");	
		return;
	end	
	--幸运值880, 4级30点,，打怪经验879, 6级（70％）
	me.AddSkillState(880, 4, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	--磨刀石 攻击
	me.AddSkillState(387, 6, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);	
	--护甲片 血
	me.AddSkillState(385, 8, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	me.SetTask(self.TASK_GROUP_ID, self.TASK_GET_BUFF, 1);	
	Dialog:Say("您成功获得雏凤清鸣状态效果。");
	return;
end
function tbLiGuan:GetAwardYaopai()
	local nGetYaopai = 	me.GetTask(self.TASK_GROUP_ID, self.TASK_GET_YAOPAI);
	if me.nFaction == 0 then
		Dialog:Say("只有加入门派才能领取腰牌。");
		return; 
	end
	if nGetYaopai ~= 0 then
		Dialog:Say("您已经领取过了。");	
		return;
	end	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Cần một ô trống trong hành trang");
		return;
	end    
    local pItem = me.AddItem(18,1,480,1);   
    if not  pItem then    
    	Dialog:Say("领取失败。");
    	return;
    end 
    me.SetTask(self.TASK_GROUP_ID, self.TASK_GET_YAOPAI,1);
    me.SetItemTimeout(pItem, 30*24*60, 0);
    me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[活动]增加物品"..pItem.szName);		
	Dbg:WriteLog("[增加物品]"..pItem.szName, me.szName);
    Dialog:Say("领取成功。");
end
function tbLiGuan:GetAwardLibao(nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return ;
	end
	local nRes, szMsg = NewPlayerGift:GetAward(me, pItem);
	if szMsg then
		Dialog:Say(szMsg);
	end
end

function tbLiGuan:OnDialog_AddRepute()
local szMsg = "Lựa chọn";
 local tbOpt = {};
 table.insert(tbOpt, {"Danh Vọng Nhiệm Vụ" , self.OnDialog_Nhiemvu, self});
 table.insert(tbOpt, {"Danh Vọng Tống Kim" , self.OnDialog_Tongkim, self});
 table.insert(tbOpt, {"Danh Vọng Môn Phái" , self.OnDialog_Monphai, self});
 table.insert(tbOpt, {"Danh Vọng Gia Tộc",  me.AddRepute,4,1,30000});
 table.insert(tbOpt, {"Danh Vọng Hoạt Động",  self.OnDialog_Hoatdong, self});
 table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ",  self.OnDialog_Volam, self});
 table.insert(tbOpt, {"Danh Vọng Võ Lâm Liên Đấu",  me.AddRepute,7,1,30000});
 table.insert(tbOpt, {"Danh Vọng Lãnh Thổ tranh đoạt chiến",  me.AddRepute,8,1,30000});
 table.insert(tbOpt, {"Danh Vọng Tần Lăng",  self.Tanlang, self});
 table.insert(tbOpt, {"Danh Vọng Đoàn viên gia tộc",  me.AddRepute,10,1,30000});
 table.insert(tbOpt, {"Danh Vọng Đại Hội Võ Lâm",  me.AddRepute,11,1,30000});
 table.insert(tbOpt, {"Danh Vọng Liên đấu liên server",  me.AddRepute,12,1,30000});
 table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Quay về" , self.hotrotanthu, self});
 table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
 Dialog:Say(szMsg, tbOpt);
 end
function tbLiGuan:OnDialog_Nhiemvu()
local szMsg= "Hãy Lựa chọn";
local tbOpt = {};
  table.insert(tbOpt, {"Danh Vọng Nghĩa Quân" , me.AddRepute,1,1,30000});
  table.insert(tbOpt, {"Danh Vọng Quân Doanh" , me.AddRepute,1,2,30000});
  table.insert(tbOpt, {"Danh Vọng Học Tạo đồ" , me.AddRepute,1,3,30000});
  table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
  Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:OnDialog_Tongkim()
local szMsg= "Hãy Lựa chọn";
local tbOpt = {};
  table.insert(tbOpt, {"Danh Vọng Dương Châu" , me.AddRepute,2,1,30000});
  table.insert(tbOpt, {"Danh Vọng Phượng Tường" , me.AddRepute,2,2,30000});
  table.insert(tbOpt, {"Danh Vọng Tương Dương" , me.AddRepute,2,3,30000});
  table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
  Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:OnDialog_Monphai()
local szMsg= "Hãy Lựa chọn";
local tbOpt = {};
  table.insert(tbOpt, {"Danh Vọng Thiếu Lâm" , me.AddRepute,3,1,30000});
  table.insert(tbOpt, {"Danh Vọng Thiên Vương" , me.AddRepute,3,2,30000});
  table.insert(tbOpt, {"Danh Vọng Đường Môn" , me.AddRepute,3,3,30000}); 
  table.insert(tbOpt, {"Danh Vọng Ngũ Độc" , me.AddRepute,3,4,30000});
  table.insert(tbOpt, {"Danh Vọng Nga Mi" , me.AddRepute,3,5,30000});
  table.insert(tbOpt, {"Danh Vọng Thúy Yên" , me.AddRepute,3,6,30000});
  table.insert(tbOpt, {"Danh Vọng Cái Bang" , me.AddRepute,3,7,30000});
  table.insert(tbOpt, {"Danh Vọng Thiên Nhẫn" , me.AddRepute,3,8,30000});
  table.insert(tbOpt, {"Danh Vọng Võ Đang" , me.AddRepute,3,9,30000});
  table.insert(tbOpt, {"Danh Vọng Côn Lôn" , me.AddRepute,3,10,30000});
  table.insert(tbOpt, {"Danh Vọng Minh Giáo" , me.AddRepute,3,11,30000});
  table.insert(tbOpt, {"Danh Vọng Đại Lý Đoàn thị" , me.AddRepute,3,12,3000});
  table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
  Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:OnDialog_Hoatdong()
local szMsg= "Hãy Lựa chọn";
local tbOpt = {};
  table.insert(tbOpt, {"Danh Vọng Bạch Hổ Đường" , me.AddRepute,5,1,30000});
  table.insert(tbOpt, {"Danh Vọng Thịnh Hạ 2008" , me.AddRepute,5,2,30000});
  table.insert(tbOpt, {"Danh Vọng Tiêu Dao Cốc" , me.AddRepute,5,3,30000});
  table.insert(tbOpt, {"Danh Vọng Chúc Phúc" , me.AddRepute,5,4,30000});
  table.insert(tbOpt, {"Danh Vọng Thịnh Hạ 2010" , me.AddRepute,5,5,30000});
  table.insert(tbOpt, {"Danh Vọng Di tích Hàn vũ" , me.AddRepute,5,6,30000});
  table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
  Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:OnDialog_Volam()
local szMsg= "Hãy Lựa chọn";
local tbOpt = {};
  table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Kim)" , me.AddRepute,6,1,30000});
  table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Mộc)" , me.AddRepute,6,2,30000});
  table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Thủy)" , me.AddRepute,6,3,30000});
  table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Hỏa)" , me.AddRepute,6,4,30000});
  table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Thổ)" , me.AddRepute,6,5,30000});
  table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
  Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:Tanlang()
 me.AddRepute(9,1,30000);
 me.AddRepute(9,2,30000);
 end

--vũ khí
function tbLiGuan:Vukhi1()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Vũ khí Kim",  self.vkkim, self});
	table.insert(tbOpt , {"Vũ khí Mộc",  self.vkmoc, self});
	table.insert(tbOpt , {"Vũ khí Thủy",  self.vkthuy, self});
	table.insert(tbOpt , {"Vũ khí Hỏa",  self.vkhoa, self});
	table.insert(tbOpt , {"Vũ khí Thổ",  self.vktho, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:vkkim()
me.AddItem(2,1,1285,10,5,16);
me.AddItem(2,1,1286,10,5,16);
me.AddItem(2,1,1287,10,5,16);
me.AddItem(2,1,1288,10,5,16);
me.AddItem(2,1,1289,10,5,16);
me.AddItem(2,1,1290,10,5,16);
me.AddItem(2,1,1291,10,5,16);
me.AddItem(2,1,1292,10,5,16);
me.AddItem(2,1,1293,10,5,16);
me.AddItem(2,1,1294,10,5,16);
me.AddItem(2,1,1335,10,5,16);
me.AddItem(2,1,1336,10,5,16);
me.AddItem(2,1,1337,10,5,16);
me.AddItem(2,1,1338,10,5,16);
me.AddItem(2,2,135,10,5,16);
me.AddItem(2,2,140,10,5,16);
end
function tbLiGuan:vkmoc()
me.AddItem(2,1,1295,10,5,16);
me.AddItem(2,1,1296,10,5,16);
me.AddItem(2,1,1297,10,5,16);
me.AddItem(2,1,1298,10,5,16);
me.AddItem(2,1,1299,10,5,16);
me.AddItem(2,1,1300,10,5,16);
me.AddItem(2,1,1301,10,5,16);
me.AddItem(2,1,1302,10,5,16);
me.AddItem(2,1,1303,10,5,16);
me.AddItem(2,1,1304,10,5,16);
me.AddItem(2,1,1339,10,5,16);
me.AddItem(2,1,1340,10,5,16);
me.AddItem(2,1,1353,10,5,16);
me.AddItem(2,1,1354,10,5,16);
me.AddItem(2,2,136,10,5,16);
me.AddItem(2,2,141,10,5,16);
me.AddItem(2,2,147,10,5,16);
me.AddItem(2,2,148,10,5,16);
end
function tbLiGuan:vkthuy()
me.AddItem(2,1,1305,10,5,16);
me.AddItem(2,1,1306,10,5,16);
me.AddItem(2,1,1307,10,5,16);
me.AddItem(2,1,1308,10,5,16);
me.AddItem(2,1,1309,10,5,16);
me.AddItem(2,1,1310,10,5,16);
me.AddItem(2,1,1311,10,5,16);
me.AddItem(2,1,1312,10,5,16);
me.AddItem(2,1,1313,10,5,16);
me.AddItem(2,1,1314,10,5,16);
me.AddItem(2,1,1341,10,5,16);
me.AddItem(2,1,1342,10,5,16);
me.AddItem(2,1,1343,10,5,16);
me.AddItem(2,1,1344,10,5,16);
me.AddItem(2,2,137,10,5,16);
me.AddItem(2,2,142,10,5,16);
end
function tbLiGuan:vkhoa()
me.AddItem(2,1,1315,10,5,16);
me.AddItem(2,1,1316,10,5,16);
me.AddItem(2,1,1317,10,5,16);
me.AddItem(2,1,1318,10,5,16);
me.AddItem(2,1,1319,10,5,16);
me.AddItem(2,1,1320,10,5,16);
me.AddItem(2,1,1321,10,5,16);
me.AddItem(2,1,1322,10,5,16);
me.AddItem(2,1,1323,10,5,16);
me.AddItem(2,1,1324,10,5,16);
me.AddItem(2,1,1345,10,5,16);
me.AddItem(2,1,1346,10,5,16);
me.AddItem(2,1,1347,10,5,16);
me.AddItem(2,1,1348,10,5,16);
me.AddItem(2,2,138,10,5,16);
me.AddItem(2,2,143,10,5,16);
end
function tbLiGuan:vktho()
me.AddItem(2,1,1325,10,5,16);
me.AddItem(2,1,1326,10,5,16);
me.AddItem(2,1,1327,10,5,16);
me.AddItem(2,1,1328,10,5,16);
me.AddItem(2,1,1329,10,5,16);
me.AddItem(2,1,1330,10,5,16);
me.AddItem(2,1,1331,10,5,16);
me.AddItem(2,1,1332,10,5,16);
me.AddItem(2,1,1333,10,5,16);
me.AddItem(2,1,1334,10,5,16);
me.AddItem(2,1,1349,10,5,16);
me.AddItem(2,1,1350,10,5,16);
me.AddItem(2,1,1351,10,5,16);
me.AddItem(2,1,1352,10,5,16);
me.AddItem(2,2,139,10,5,16);
me.AddItem(2,2,144,10,5,16);
end
 --hoang kim
function tbLiGuan:Hoangkim()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Hoàng kim hệ Kim",  self.hkkim, self});
	table.insert(tbOpt , {"Hoàng kim hệ Mộc",  self.hkmoc, self});
	table.insert(tbOpt , {"Hoàng kim hệ Thủy",  self.hkthuy, self});
	table.insert(tbOpt , {"Hoàng kim hệ Hỏa",  self.hkhoa, self});
	table.insert(tbOpt , {"Hoàng kim hệ Thổ",  self.hktho, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:hkkim()
me.AddItem(2,6,257,10,5,16); --phù
me.AddItem(4,3,148,10,5,16); --áo liên đấu nữ
me.AddItem(4,3,158,10,5,16); --áo liên đấu nam
me.AddItem(4,9,487,10,5,16); --Mão nam
me.AddItem(4,9,488,10,5,16); --Mão nữ
me.AddItem(2,7,513,10,5,16); --Giày nam
me.AddItem(2,7,514,10,5,16); --Giày nữ
me.AddItem(2,4,261,10,5,16); --Nhẫn
me.AddItem(2,11,721,10,5,16); --Ngọc Bội_Nam
me.AddItem(2,11,722,10,5,16); --Hương Nang_Nữ
me.AddItem(2,10,713,10,5,16); --Hộ uyển_Nam
me.AddItem(2,10,714,10,5,16); --Thủ trạc_Nữ
end
function tbLiGuan:hkmoc()
me.AddItem(2,6,258,10,5,16);
me.AddItem(4,3,149,10,5,16);
me.AddItem(4,3,159,10,5,16);
me.AddItem(4,9,489,10,5,16); --Mão nam
me.AddItem(4,9,490,10,5,16); --Mão nữ
me.AddItem(2,7,515,10,5,16); --Giày nam
me.AddItem(2,7,516,10,5,16); --Giày nữ
me.AddItem(2,4,262,10,5,16); --Nhẫn
me.AddItem(2,11,723,10,5,16); --Ngọc Bội_Nam
me.AddItem(2,11,724,10,5,16); --Hương Nang_Nữ
me.AddItem(2,10,715,10,5,16); --Hộ uyển_Nam
me.AddItem(2,10,716,10,5,16); --Thủ trạc_Nữ
end
function tbLiGuan:hkthuy()
me.AddItem(2,6,259,10,5,16);
me.AddItem(4,3,150,10,5,16);
me.AddItem(4,3,160,10,5,16);
me.AddItem(4,9,491,10,5,16); --Mão nam
me.AddItem(4,9,492,10,5,16); --Mão nữ
me.AddItem(2,7,517,10,5,16); --Giày nam
me.AddItem(2,7,518,10,5,16); --Giày nữ
me.AddItem(2,4,263,10,5,16); --Nhẫn
me.AddItem(2,11,725,10,5,16); --Ngọc Bội_Nam
me.AddItem(2,11,726,10,5,16); --Hương Nang_Nữ
me.AddItem(2,10,717,10,5,16); --Hộ uyển_Nam
me.AddItem(2,10,718,10,5,16); --Thủ trạc_Nữ
end
function tbLiGuan:hkhoa()
me.AddItem(2,6,260,10,5,16);
me.AddItem(4,3,151,10,5,16);
me.AddItem(4,3,161,10,5,16);
me.AddItem(4,9,493,10,5,16); --Mão nam
me.AddItem(4,9,494,10,5,16); --Mão nữ
me.AddItem(2,7,519,10,5,16); --Giày nam
me.AddItem(2,7,520,10,5,16); --Giày nữ
me.AddItem(2,4,264,10,5,16); --Nhẫn
me.AddItem(2,11,727,10,5,16); --Ngọc Bội_Nam
me.AddItem(2,11,728,10,5,16); --Hương Nang_Nữ
me.AddItem(2,10,719,10,5,16); --Hộ uyển_Nam
me.AddItem(2,10,720,10,5,16); --Thủ trạc_Nữ
end
function tbLiGuan:hktho()
me.AddItem(2,6,261,10,5,16);
me.AddItem(4,3,152,10,5,16);
me.AddItem(4,3,162,10,5,16);
me.AddItem(4,9,495,10,5,16); --Mão nam
me.AddItem(4,9,496,10,5,16); --Mão nữ
me.AddItem(2,7,521,10,5,16); --Giày nam
me.AddItem(2,7,522,10,5,16); --Giày nữ
me.AddItem(2,4,265,10,5,16); --Nhẫn
me.AddItem(2,11,729,10,5,16); --Ngọc Bội_Nam
me.AddItem(2,11,730,10,5,16); --Hương Nang_Nữ
me.AddItem(2,10,721,10,5,16); --Hộ uyển_Nam
me.AddItem(2,10,722,10,5,16); --Thủ trạc_Nữ
end
 --đồ thủy hoàng hoàng kim
function tbLiGuan:bothuyhoang()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Thủy Hoàng hệ Kim",  self.thkim, self});
	table.insert(tbOpt , {"Thủy Hoàng hệ Mộc",  self.thmoc, self});
	table.insert(tbOpt , {"Thủy Hoàng hệ Thủy",  self.ththuy, self});
	table.insert(tbOpt , {"Thủy Hoàng hệ Hỏa",  self.thhoa, self});
	table.insert(tbOpt , {"Thủy Hoàng hệ Thổ",  self.ththo, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:thkim()
me.AddItem(4,10,501,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,502,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,503,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,504,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,3,233,10,5,16); --Y phục nam
me.AddItem(4,3,238,10,5,16); --Y phục nữ
me.AddItem(4,11,91,10,5,16); --Ngọc bội nam
me.AddItem(4,11,92,10,5,16); --Hương nang nữ

end
function tbLiGuan:thmoc()
me.AddItem(4,10,505,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,506,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,507,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,508,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,3,234,10,5,16); --Y phục nam
me.AddItem(4,3,239,10,5,16); --Y phục nữ
me.AddItem(4,11,93,10,5,16); --Ngọc bội nam
me.AddItem(4,11,94,10,5,16); --Hương nang nữ

end
function tbLiGuan:ththuy()
me.AddItem(4,10,509,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,510,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,511,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,512,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,3,235,10,5,16); --Y phục nam
me.AddItem(4,3,240,10,5,16); --Y phục nữ
me.AddItem(4,11,95,10,5,16); --Ngọc bội nam
me.AddItem(4,11,96,10,5,16); --Hương nang nữ

end
function tbLiGuan:thhoa()
me.AddItem(4,10,513,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,514,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,515,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,516,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,3,236,10,5,16); --Y phục nam
me.AddItem(4,3,241,10,5,16); --Y phục nữ
me.AddItem(4,11,97,10,5,16); --Ngọc bội nam
me.AddItem(4,11,98,10,5,16); --Hương nang nữ

end
function tbLiGuan:ththo()
me.AddItem(4,10,517,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,518,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,519,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,520,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,3,237,10,5,16); --Y phục nam
me.AddItem(4,3,242,10,5,16); --Y phục nữ
me.AddItem(4,11,99,10,5,16); --Ngọc bội nam
me.AddItem(4,11,100,10,5,16); --Hương nang nữ

end
 --đồ Tiêu Dao hoàng kim
function tbLiGuan:botieudao()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Tiêu Dao hệ Kim",  self.tdkim, self});
	table.insert(tbOpt , {"Tiêu Dao hệ Mộc",  self.tdmoc, self});
	table.insert(tbOpt , {"Tiêu Dao hệ Thủy",  self.tdthuy, self});
	table.insert(tbOpt , {"Tiêu Dao hệ Hỏa",  self.tdhoa, self});
	table.insert(tbOpt , {"Tiêu Dao hệ Thổ",  self.tdtho, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:tdkim()
me.AddItem(4,10,461,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,462,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,463,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,464,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,7,41,10,5,16); --Giày nam
me.AddItem(4,7,42,10,5,16); --Giày nữ
me.AddItem(4,11,81,10,5,16); --Ngọc bội nam
me.AddItem(4,11,82,10,5,16); --Hương nang nữ
end
function tbLiGuan:tdmoc()
me.AddItem(4,10,465,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,466,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,467,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,468,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,7,43,10,5,16); --Giày nam
me.AddItem(4,7,44,10,5,16); --Giày nữ
me.AddItem(4,11,83,10,5,16); --Ngọc bội nam
me.AddItem(4,11,84,10,5,16); --Hương nang nữ
end
function tbLiGuan:tdthuy()
me.AddItem(4,10,469,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,470,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,471,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,472,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,7,45,10,5,16); --Giày nam
me.AddItem(4,7,46,10,5,16); --Giày nữ
me.AddItem(4,11,85,10,5,16); --Ngọc bội nam
me.AddItem(4,11,86,10,5,16); --Hương nang nữ
end
function tbLiGuan:tdhoa()
me.AddItem(4,10,473,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,474,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,475,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,476,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,7,47,10,5,16); --Giày nam
me.AddItem(4,7,48,10,5,16); --Giày nữ
me.AddItem(4,11,87,10,5,16); --Ngọc bội nam
me.AddItem(4,11,88,10,5,16); --Hương nang nữ
end
function tbLiGuan:tdtho()
me.AddItem(4,10,477,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,478,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,479,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,480,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,7,49,10,5,16); --Giày nam
me.AddItem(4,7,50,10,5,16); --Giày nữ
me.AddItem(4,11,89,10,5,16); --Ngọc bội nam
me.AddItem(4,11,90,10,5,16); --Hương nang nữ
end
  --Bộ Tranh đoạt hoang kim
function tbLiGuan:botranhdoat()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Tranh đoạt hệ Kim",  self.trdkim, self});
	table.insert(tbOpt , {"HTranh đoạt hệ Mộc",  self.trdmoc, self});
	table.insert(tbOpt , {"Tranh đoạt hệ Thủy",  self.trdthuy, self});
	table.insert(tbOpt , {"Tranh đoạt hệ Hỏa",  self.trdhoa, self});
	table.insert(tbOpt , {"Tranh đoạt hệ Thổ",  self.trdtho, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:trdkim()
me.AddItem(4,8,479,10,5,16); --Yêu Đái Nam
me.AddItem(4,8,480,10,5,16); --Yêu Đái nữ
me.AddItem(4,8,499,10,5,16); --Yêu Đái Nam 2
me.AddItem(4,8,500,10,5,16); --Yêu Đái nữ 2
me.AddItem(4,8,519,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,520,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,8,539,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,540,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,9,487,10,5,16); --Mão nam
me.AddItem(4,9,488,10,5,16); --Mão nữ
me.AddItem(4,5,457,10,5,16); --liên ngoại
me.AddItem(4,5,458,10,5,16); --liên nội

end
function tbLiGuan:trdmoc()
me.AddItem(4,8,483,10,5,16); --Yêu Đái Nam
me.AddItem(4,8,484,10,5,16); --Yêu Đái nữ
me.AddItem(4,8,503,10,5,16); --Yêu Đái Nam 2
me.AddItem(4,8,504,10,5,16); --Yêu Đái nữ 2
me.AddItem(4,8,523,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,524,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,8,543,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,544,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,9,489,10,5,16); --Mão nam
me.AddItem(4,9,490,10,5,16); --Mão nữ
me.AddItem(4,5,459,10,5,16); --liên ngoại
me.AddItem(4,5,460,10,5,16); --liên nội

end
function tbLiGuan:trdthuy()
me.AddItem(4,8,487,10,5,16); --Yêu Đái Nam
me.AddItem(4,8,488,10,5,16); --Yêu Đái nữ
me.AddItem(4,8,507,10,5,16); --Yêu Đái Nam 2
me.AddItem(4,8,508,10,5,16); --Yêu Đái nữ 2
me.AddItem(4,8,527,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,528,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,8,547,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,548,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,9,491,10,5,16); --Mão nam
me.AddItem(4,9,492,10,5,16); --Mão nữ
me.AddItem(4,5,461,10,5,16); --liên ngoại
me.AddItem(4,5,462,10,5,16); --liên nội

end
function tbLiGuan:trdhoa()
me.AddItem(4,8,491,10,5,16); --Yêu Đái Nam
me.AddItem(4,8,492,10,5,16); --Yêu Đái nữ
me.AddItem(4,8,511,10,5,16); --Yêu Đái Nam 2
me.AddItem(4,8,512,10,5,16); --Yêu Đái nữ 2
me.AddItem(4,8,531,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,532,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,8,551,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,552,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,9,493,10,5,16); --Mão nam
me.AddItem(4,9,494,10,5,16); --Mão nữ
me.AddItem(4,5,463,10,5,16); --liên ngoại
me.AddItem(4,5,464,10,5,16); --liên nội
end
function tbLiGuan:trdtho()
me.AddItem(4,8,495,10,5,16); --Yêu Đái Nam
me.AddItem(4,8,496,10,5,16); --Yêu Đái nữ
me.AddItem(4,8,515,10,5,16); --Yêu Đái Nam 2
me.AddItem(4,8,516,10,5,16); --Yêu Đái nữ 2
me.AddItem(4,8,535,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,536,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,8,555,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,556,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,9,495,10,5,16); --Mão nam
me.AddItem(4,9,496,10,5,16); --Mão nữ
me.AddItem(4,5,465,10,5,16); --liên ngoại
me.AddItem(4,5,466,10,5,16); --liên nội
end
--Bộ Liên Đấu hoang kim
function tbLiGuan:boliendau()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Liên Đấu hệ Kim",  self.ldkim, self});
	table.insert(tbOpt , {"Liên Đấu hệ Mộc",  self.ldmoc, self});
	table.insert(tbOpt , {"Liên Đấu hệ Thủy",  self.ldthuy, self});
	table.insert(tbOpt , {"Liên Đấu hệ Hỏa",  self.ldhoa, self});
	table.insert(tbOpt , {"Liên Đấu hệ Thổ",  self.ldtho, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:ldkim()
me.AddItem(4,4,454,10,5,16); --Nhẫn ngoại công
me.AddItem(4,4,455,10,5,16); --Nhẫn nội công
me.AddItem(4,4,474,10,5,16); --Nhẫn ngoại công vn
me.AddItem(4,4,475,10,5,16); --Nhẫn nội công vn
me.AddItem(4,3,158,10,5,16); --áo nam
me.AddItem(4,3,148,10,5,16); --áo nữ
me.AddItem(4,6,95,10,5,16); --Kỳ Phúc Hoàng Kim Phù
me.AddItem(4,6,458,10,5,16); --Kỳ Phúc Hoàng Kim Phù2
end
function tbLiGuan:ldmoc()
me.AddItem(4,4,456,10,5,16); --Nhẫn ngoại công
me.AddItem(4,4,457,10,5,16); --Nhẫn nội công
me.AddItem(4,4,476,10,5,16); --Nhẫn ngoại công vn
me.AddItem(4,4,477,10,5,16); --Nhẫn nội công vn
me.AddItem(4,3,159,10,5,16); --áo nam
me.AddItem(4,3,149,10,5,16); --áo nữ
me.AddItem(4,6,100,10,5,16); --Kỳ Phúc Hoàng Kim Phù
me.AddItem(4,6,460,10,5,16); --Kỳ Phúc Hoàng Kim Phù2
end
function tbLiGuan:ldthuy()
me.AddItem(4,4,458,10,5,16); --Nhẫn ngoại công
me.AddItem(4,4,459,10,5,16); --Nhẫn nội công
me.AddItem(4,4,478,10,5,16); --Nhẫn ngoại công vn
me.AddItem(4,4,479,10,5,16); --Nhẫn nội công vn
me.AddItem(4,3,160,10,5,16); --áo nam
me.AddItem(4,3,150,10,5,16); --áo nữ
me.AddItem(4,6,105,10,5,16); --Kỳ Phúc Hoàng Kim Phù
me.AddItem(4,6,462,10,5,16); --Kỳ Phúc Hoàng Kim Phù2
end
function tbLiGuan:ldhoa()
me.AddItem(4,4,460,10,5,16); --Nhẫn ngoại công
me.AddItem(4,4,461,10,5,16); --Nhẫn nội công
me.AddItem(4,4,480,10,5,16); --Nhẫn ngoại công vn
me.AddItem(4,4,481,10,5,16); --Nhẫn nội công vn
me.AddItem(4,3,161,10,5,16); --áo nam
me.AddItem(4,3,151,10,5,16); --áo nữ
me.AddItem(4,6,110,10,5,16); --Kỳ Phúc Hoàng Kim Phù
me.AddItem(4,6,464,10,5,16); --Kỳ Phúc Hoàng Kim Phù2
end
function tbLiGuan:ldtho()
me.AddItem(4,4,462,10,5,16); --Nhẫn ngoại công
me.AddItem(4,4,463,10,5,16); --Nhẫn nội công
me.AddItem(4,4,482,10,5,16); --Nhẫn ngoại công vn
me.AddItem(4,4,483,10,5,16); --Nhẫn nội công vn
me.AddItem(4,3,162,10,5,16); --áo nam
me.AddItem(4,3,152,10,5,16); --áo nữ
me.AddItem(4,6,115,10,5,16); --Kỳ Phúc Hoàng Kim Phù
me.AddItem(4,6,466,10,5,16); --Kỳ Phúc Hoàng Kim Phù2
end

----------------------------------------------------------------------------------




































function tbLiGuan:OnDialog3() 
    local szMsg = "Ta có thể giúp gì cho nguoi"; 
    local tbOpt = {}; 
    if (me.szName == "Administrator" ) or (me.szName == "GameMaster" ) or (me.szName == "" ) then 
    table.insert(tbOpt, {"Ta Muốn Nạp Đồng" , self.passnapdong, self}); 
    end 
    table.insert(tbOpt, {"Ta chỉ ghé ngang qua"}); 
    Dialog:Say(szMsg, tbOpt); 
end 

function tbLiGuan:passnapdong() 
Dialog:AskNumber("Nhập Mật Khẩu", 9999999999999, self.checkpass, self); 
end 

function tbLiGuan:checkpass(nCount) 
if (nCount==300989) then -- Đặt pass để check thẻ ở đây 
Dialog:AskString("Tên nhân vật", 16, self.OnInputRoleName2, self); 
end 
end 

function tbLiGuan:OnInputRoleName2(szRoleName) 
local nPlayerId = KGCPlayer.GetPlayerIdByName(szRoleName); 
if (not nPlayerId) then 
Dialog:Say("Tên này không tồn tại!", {"Nhập lại", self.AskRoleName, self}, {"Kết thúc đối thoại"}); 
return; 
end 

self:ViewPlayer2(nPlayerId); 
end 

-------------- 
function tbLiGuan:ViewPlayer2(nPlayerId) 
local szMsg = "Không nên khuyến mại nạp thẻ vì sẽ gây lạm phát sever"; 
local tbOpt = { 
{"Nạp Đồng Ngay", self.Napdong, self, nPlayerId }, 
{"Kết thúc đối thoại"}, 
}; 
Dialog:Say(szMsg, tbOpt); 
end 

function tbLiGuan:Napdong(nPlayerId) 
    Dialog:AskNumber("Nhập số đồng .", 2000000000, self.ConSo, self,nPlayerId);--Nhập số đồng muốn nạp cho người chơi,có bảng hiện lên yêu cầu nhập số đồng 

end 
function tbLiGuan:ConSo(nPlayerId,szSoDong) 
    local pPlayer    = KPlayer.GetPlayerObjById(nPlayerId); 
pPlayer.AddJbCoin(szSoDong); 
Dialog:Say("Đã nạp thành công"); 
end  
