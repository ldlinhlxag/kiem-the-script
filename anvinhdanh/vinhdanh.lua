--NPC Test1


local tbLegendKiem = Npc:GetClass("LegendKiem");


	
	
function tbLegendKiem:OnDialog()
	local szMsg = "Chào mừng bạn đến với kiếm thế <color=red>Tuyệt Tình Kiếm<color>.";
	local szMsg = "Chào mừng bạn đến với kiếm thế <color=red>Tuyệt Tình Kiếm<color>.";
	local tbOpt = {
		{"<color=red>Luyện Ấn Và Nâng Cấp<color>", self.LAVNC, self},
		{"<color=red>Luyện Hóa Trang Bị Đồng Hành<color>", self.LHTBDH, self},
		{"Hướng dẫn Vinh Danh.", self.hdvd, self},
		{"Kết Thúc Đối Thoại."},
	};
	Dialog:Say(szMsg, tbOpt);
	
end

function tbLegendKiem:LHTBDH()
	local szMsg = "Tính năng luyện hóa trang bị đồng hành <color=red> Tuyệt Tình Kiếm <color.";
	local szMsg = "Tính năng luyện hóa trang bị đồng hành <color=red> Tuyệt Tình Kiếm Kiếm <color.";
	local tbOpt = {
		{"<color=yellow>Trang bị đồng hành cấp 2<color>", self.TBDHC2, self},
		{"<color=yellow>Trang bị đồng hành cấp 3<color>", self.TBDHC3, self},
		{"Kết Thúc Đối Thoại."},
		};
		Dialog:Say(szMsg, tbOpt);
		end

function tbLegendKiem:TBDHC2()
	local szMsg = "Để luyện hóa được TBHD cấp 2 , yêu cầu <color=red>2500 VSV <color> và <color=red> 50 Linh hồn Trang Bị Đồng Hành<color>.";
	local szMsg = "Để luyện hóa được TBHD cấp 2 , yêu cầu <color=red>2500 VSV <color> và <color=red> 50 Linh hồn Trang Bị Đồng Hành<color>.";
	local tbOpt = {
		{"<color=yellow> Vũ khí<color>", self.vkdhc2, self},
		{"<color=yellow> Áo<color>", self.aodhc2, self},
		{"<color=yellow> Nhẫn<color>", self.nhandhc2, self},
		{"<color=yellow> Tay<color>", self.taydhc2, self},
		{"<color=yellow> Bội<color>", self.boidhc2, self},
		{"Kết Thúc Đối Thoại."},
		};
		Dialog:Say(szMsg, tbOpt);
		end
function tbLegendKiem:TBDHC3()
	local szMsg = "Để luyện hóa được TBHD cấp 3 , yêu cầu <color=red>7500 VSV <color> và <color=red> 150 Linh hồn Trang Bị Đồng Hành<color>.";
	local szMsg = "Để luyện hóa được TBHD cấp 3 , yêu cầu <color=red>7500 VSV <color> và <color=red> 150 Linh hồn Trang Bị Đồng Hành<color>.";
	local tbOpt = {
		{"<color=yellow> Vũ khí<color>", self.vkdhc3, self},
		{"<color=yellow> Áo<color>", self.aodhc3, self},
		{"<color=yellow> Nhẫn<color>", self.nhandhc3, self},
		{"<color=yellow> Tay<color>", self.taydhc3, self},
		{"<color=yellow> Bội<color>", self.boidhc3, self},
		{"Kết Thúc Đối Thoại."},
		};
		Dialog:Say(szMsg, tbOpt);
		end		



function tbLegendKiem:LAVNC()
	local szMsg = "Chào mừng bạn đến với kiếm thế <color=red>Tuyệt Tình Kiếm<color>.";
	local szMsg = "Chào mừng bạn đến với kiếm thế <color=red>Tuyệt Tình Kiếm<color>.";
	local tbOpt = {
		{"<color=yellow>Đổi ấn vinh danh<color>", self.AnVinhDanh, self},
		{"<color=yellow>Nâng cấp ấn vinh danh lên 2<color>", self.AnVinhDanh2, self},
		{"<color=yellow>Nâng cấp ấn vinh danh lên 3<color>", self.AnVinhDanh3, self},
		{"Hướng dẫn Vinh Danh.", self.hdvd, self},
		{"Kết Thúc Đối Thoại."},
	};
	Dialog:Say(szMsg, tbOpt);
	
end

function tbLegendKiem:hdvd()
local szMsg = "Bạn phải thu thập đủ 10000 tiền vinh danh mới có thể ép ấn vinh danh.<enter>Muốn nâng cấp ấn vinh danh lên 2 thì bạn phải có 2 Ấn Vinh Danh Cấp 1 <enter>Muốn nâng cấp lên ấn Vinh Danh Cấp 3 thì bạn phải có 2 Ân Vinh Danh Cấp 2.";
local tbOpt = {
	{"Tôi Đã Hiểu Rồi !!."},
	};
	Dialog:Say(szMsg, tbOpt);
end
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
--------------------------------------------TRANG BI DONG HANH CAP 2-----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
function tbLegendKiem:vkdhc2()
	local tbItemId1 = {18,1,2004,1,0,0}; -- Linh Hồn Vũ Khí
	local tbItemId2 = {18,1,325,1,0,0}; -- VSV
	local nCount1 = me.GetItemCountInBags(18,1,2004,1);
	local nCount2 = me.GetItemCountInBags(18,1,325,1);
	
if nCount1 < 50 and nCount2 < 2500 then
Dialog:Say("Khi nào đủ 50 Linh Hồn Vũ Khí và 2500 Vỏ Sò Vàng hãy đến tìm ta .")
	return 0;
		else
	Task:DelItem(me, tbItemId1, 50);
	Task:DelItem(me, tbItemId2, 2500);
	me.AddItem(5,19,1,2);
		 Dialog:Say("<color=wheat>Chức mừng <coloryellow>"  ..me.szName.. "<color> Nhận được Vũ Khí Đồng Hành Cấp <color=red>2<color>", {"..."});
		 GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Người chơi <color=cyan>"  ..me.szName.. "<color> đã chế tạo thành công Vũ Khí Đồng Hành Cấp <color=red>2<color>"});
	end
end

function tbLegendKiem:aodhc2()
	local tbItemId1 = {18,1,2005,1,0,0}; -- Linh Hồn Áo
	local tbItemId2 = {18,1,325,1,0,0}; -- VSV
	local nCount1 = me.GetItemCountInBags(18,1,2005,1);
	local nCount2 = me.GetItemCountInBags(18,1,325,1);
	
if nCount1 < 50 and nCount2 < 2500 then
Dialog:Say("Khi nào đủ 50 Linh Hồn Áo và 2500 Vỏ Sò Vàng hãy đến tìm ta .")
	return 0;
		else
	Task:DelItem(me, tbItemId1, 50);
	Task:DelItem(me, tbItemId2, 2500);
	me.AddItem(5,20,1,2);
		 Dialog:Say("<color=wheat>Chức mừng <coloryellow>"  ..me.szName.. "<color> Nhận được Áo Đồng Hành Cấp <color=red>2<color>", {"..."});
		 GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Người chơi <color=cyan>"  ..me.szName.. "<color> đã chế tạo thành công Áo Đồng Hành Cấp <color=red>2<color>"});
	end
end

function tbLegendKiem:nhandhc2()
	local tbItemId1 = {18,1,2006,1,0,0}; -- Linh Hồn Nhẫn
	local tbItemId2 = {18,1,325,1,0,0}; -- VSV
	local nCount1 = me.GetItemCountInBags(18,1,2006,1);
	local nCount2 = me.GetItemCountInBags(18,1,325,1);
	
if nCount1 < 50 and nCount2 < 2500 then
Dialog:Say("Khi nào đủ 50 Linh Hồn Nhẫn và 2500 Vỏ Sò Vàng hãy đến tìm ta .")
	return 0;
		else
	Task:DelItem(me, tbItemId1, 50);
	Task:DelItem(me, tbItemId2, 2500);
	me.AddItem(5,21,1,2);
		 Dialog:Say("<color=wheat>Chức mừng <coloryellow>"  ..me.szName.. "<color> Nhận được Nhẫn Đồng Hành Cấp <color=red>2<color>", {"..."});
		 GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Người chơi <color=cyan>"  ..me.szName.. "<color> đã chế tạo thành công Nhẫn Đồng Hành Cấp <color=red>2<color>"});
	end
end
function tbLegendKiem:taydhc2()
	local tbItemId1 = {18,1,2007,1,0,0}; -- Linh Hồn Tay
	local tbItemId2 = {18,1,325,1,0,0}; -- VSV
	local nCount1 = me.GetItemCountInBags(18,1,2007,1);
	local nCount2 = me.GetItemCountInBags(18,1,325,1);
	
if nCount1 < 50 and nCount2 < 2500 then
Dialog:Say("Khi nào đủ 50 Linh Hồn Tay và 2500 Vỏ Sò Vàng hãy đến tìm ta .")
	return 0;
		else
	Task:DelItem(me, tbItemId1, 50);
	Task:DelItem(me, tbItemId2, 2500);
	me.AddItem(5,22,1,2);
		 Dialog:Say("<color=wheat>Chức mừng <coloryellow>"  ..me.szName.. "<color> Nhận được Tay Đồng Hành Cấp <color=red>2<color>", {"..."});
		 GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Người chơi <color=cyan>"  ..me.szName.. "<color> đã chế tạo thành công Tay Đồng Hành Cấp <color=red>2<color>"});
	end
end
function tbLegendKiem:boidhc2()
	local tbItemId1 = {18,1,2008,1,0,0}; -- Linh Hồn Bội
	local tbItemId2 = {18,1,325,1,0,0}; -- VSV
	local nCount1 = me.GetItemCountInBags(18,1,2008,1);
	local nCount2 = me.GetItemCountInBags(18,1,325,1);
	
if nCount1 < 50 and nCount2 < 2500 then
Dialog:Say("Khi nào đủ 50 Linh Hồn Bội và 2500 Vỏ Sò Vàng hãy đến tìm ta .")
	return 0;
		else
	Task:DelItem(me, tbItemId1, 50);
	Task:DelItem(me, tbItemId2, 2500);
	me.AddItem(5,23,1,2);
		 Dialog:Say("<color=wheat>Chức mừng <coloryellow>"  ..me.szName.. "<color> Nhận được Bội Đồng Hành Cấp <color=red>2<color>", {"..."});
		 GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Người chơi <color=cyan>"  ..me.szName.. "<color> đã chế tạo thành công Bội Đồng Hành Cấp <color=red>2<color>"});
	end
end	
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
--------------------------------------------TRANG BI DONG HANH CAP 3-----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
function tbLegendKiem:vkdhc3()
	local tbItemId1 = {18,1,2004,1,0,0}; -- Linh Hồn Vũ Khí
	local tbItemId2 = {18,1,325,1,0,0}; -- VSV
	local nCount1 = me.GetItemCountInBags(18,1,2004,1);
	local nCount2 = me.GetItemCountInBags(18,1,325,1);
	
if nCount1 < 150 and nCount2 < 2500 then
Dialog:Say("Khi nào đủ 150 Linh Hồn Vũ Khí và 2500 Vỏ Sò Vàng hãy đến tìm ta .")
	return 0;
		else
	Task:DelItem(me, tbItemId1, 150);
	Task:DelItem(me, tbItemId2, 2500);
	me.AddItem(5,19,1,3);
		 Dialog:Say("<color=wheat>Chức mừng <coloryellow>"  ..me.szName.. "<color> Nhận được Vũ Khí Đồng Hành Cấp <color=red>3<color>", {"..."});
		 GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Người chơi <color=cyan>"  ..me.szName.. "<color> đã chế tạo thành công Vũ Khí Đồng Hành Cấp <color=red>3<color>"});
	end
end

function tbLegendKiem:aodhc3()
	local tbItemId1 = {18,1,2005,1,0,0}; -- Linh Hồn Áo
	local tbItemId2 = {18,1,325,1,0,0}; -- VSV
	local nCount1 = me.GetItemCountInBags(18,1,2005,1);
	local nCount2 = me.GetItemCountInBags(18,1,325,1);
	
if nCount1 < 150 and nCount2 < 2500 then
Dialog:Say("Khi nào đủ 150 Linh Hồn Áo và 2500 Vỏ Sò Vàng hãy đến tìm ta .")
	return 0;
		else
	Task:DelItem(me, tbItemId1, 150);
	Task:DelItem(me, tbItemId2, 2500);
	me.AddItem(5,20,1,3);
		 Dialog:Say("<color=wheat>Chức mừng <coloryellow>"  ..me.szName.. "<color> Nhận được Áo Đồng Hành Cấp <color=red>3<color>", {"..."});
		 GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Người chơi <color=cyan>"  ..me.szName.. "<color> đã chế tạo thành công Áo Đồng Hành Cấp <color=red>3<color>"});
	end
end

function tbLegendKiem:nhandhc3()
	local tbItemId1 = {18,1,2006,1,0,0}; -- Linh Hồn Nhẫn
	local tbItemId2 = {18,1,325,1,0,0}; -- VSV
	local nCount1 = me.GetItemCountInBags(18,1,2006,1);
	local nCount2 = me.GetItemCountInBags(18,1,325,1);
	
if nCount1 < 150 and nCount2 < 2500 then
Dialog:Say("Khi nào đủ 150 Linh Hồn Nhẫn và 2500 Vỏ Sò Vàng hãy đến tìm ta .")
	return 0;
		else
	Task:DelItem(me, tbItemId1, 150);
	Task:DelItem(me, tbItemId2, 2500);
	me.AddItem(5,21,1,3);
		 Dialog:Say("<color=wheat>Chức mừng <coloryellow>"  ..me.szName.. "<color> Nhận được Nhẫn Đồng Hành Cấp <color=red>3<color>", {"..."});
		 GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Người chơi <color=cyan>"  ..me.szName.. "<color> đã chế tạo thành công Nhẫn Đồng Hành Cấp <color=red>3<color>"});
	end
end
function tbLegendKiem:taydhc3()
	local tbItemId1 = {18,1,2007,1,0,0}; -- Linh Hồn Tay
	local tbItemId2 = {18,1,325,1,0,0}; -- VSV
	local nCount1 = me.GetItemCountInBags(18,1,2007,1);
	local nCount2 = me.GetItemCountInBags(18,1,325,1);
	
if nCount1 < 150 and nCount2 < 2500 then
Dialog:Say("Khi nào đủ 150 Linh Hồn Tay và 2500 Vỏ Sò Vàng hãy đến tìm ta .")
	return 0;
		else
	Task:DelItem(me, tbItemId1, 150);
	Task:DelItem(me, tbItemId2, 2500);
	me.AddItem(5,22,1,3);
		 Dialog:Say("<color=wheat>Chức mừng <coloryellow>"  ..me.szName.. "<color> Nhận được Tay Đồng Hành Cấp <color=red>3<color>", {"..."});
		 GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Người chơi <color=cyan>"  ..me.szName.. "<color> đã chế tạo thành công Tay Đồng Hành Cấp <color=red>3<color>"});
	end
end
function tbLegendKiem:boidhc3()
	local tbItemId1 = {18,1,2008,1,0,0}; -- Linh Hồn Bội
	local tbItemId2 = {18,1,325,1,0,0}; -- VSV
	local nCount1 = me.GetItemCountInBags(18,1,2008,1);
	local nCount2 = me.GetItemCountInBags(18,1,325,1);
	
if nCount1 < 150 and nCount2 < 2500 then
Dialog:Say("Khi nào đủ 150 Linh Hồn Bội và 2500 Vỏ Sò Vàng hãy đến tìm ta .")
	return 0;
		else
	Task:DelItem(me, tbItemId1, 150);
	Task:DelItem(me, tbItemId2, 2500);
	me.AddItem(5,23,1,3);
		 Dialog:Say("<color=wheat>Chức mừng <coloryellow>"  ..me.szName.. "<color> Nhận được Bội Đồng Hành Cấp <color=red>3<color>", {"..."});
		 GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Người chơi <color=cyan>"  ..me.szName.. "<color> đã chế tạo thành công Bội Đồng Hành Cấp <color=red>3<color>"});
	end
end		
function tbLegendKiem:AnVinhDanh()
	local tbItemId9 = {18,1,2003,1,0,0}; -- Đồng Tiền Vinh Danh
	local nCount9 = me.GetItemCountInBags(18,1,2003,1);
	
if nCount9 < 10000 then
Dialog:Say("Người không đủ 10.000 Tiền Vinh Danh, khi nào đủ hãy quay lại tìm ta")
	return 0;
		else
	Task:DelItem(me, tbItemId9, 10000);
	me.AddItem(1,16,22,2).Bind(1);
		 Dialog:Say("<color=wheat>Chúc mừng mi đã nhận được Ấn Vinh Danh Cao Thủ 9Game<colro>", {"..."});
		 GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Người chơi <color=cyan>"  ..me.szName.. "<color> đã chế tạo thành công Ấn Vinh Danh Cao Thủ 9Game"});
		-- me.CostMoney(50000,0);
	end
end

	
function tbLegendKiem:AnVinhDanh2()
	local tbItemId9 = {1,16,22,2,0,0}; -- Ấn Vinh Danh 1
	local nCount9 = me.GetItemCountInBags(1,16,22,2);
	
if nCount9 < 2 then
Dialog:Say("Người không đủ 2 Ấn Vinh Danh Cấp 1, khi nào đủ hãy quay lại tìm ta")
	return 0;
		else
	Task:DelItem(me, tbItemId9, 2);
	me.AddItem(1,16,23,2).Bind(1);
		 Dialog:Say("<color=wheat>Chúc mừng mi đã nhận được Ấn Vinh Danh Cao Thủ 9Game<colro>", {"..."});
		 GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Người chơi <color=cyan>"  ..me.szName.. "<color> đã chế tạo thành công Ấn Vinh Danh Cao Thủ 9Game"});
		-- me.CostMoney(50000,0);
	end
end

function tbLegendKiem:AnVinhDanh3()
	local tbItemId9 = {1,16,23,2,0,0}; -- Ấn Vinh Danh 1
	local nCount9 = me.GetItemCountInBags(1,16,23,2);
	
if nCount9 < 2 then
Dialog:Say("Người không đủ 2 Ấn Vinh Danh Cấp 2, khi nào đủ hãy quay lại tìm ta")
	return 0;
		else
	Task:DelItem(me, tbItemId9, 2);
	me.AddItem(1,16,24,2).Bind(1);
		 Dialog:Say("<color=wheat>Chúc mừng mi đã nhận được Ấn Vinh Danh Cao Thủ 9Game<colro>", {"..."});
		 GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Người chơi <color=cyan>"  ..me.szName.. "<color> đã chế tạo thành công Ấn Vinh Danh Cao Thủ 9Game"});
		-- me.CostMoney(50000,0);
	end
end


