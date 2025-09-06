
local tbSystem = Npc:GetClass("hethongtraodoi");
local REQUIRE_ITEM = 
{ 
	[1] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 252, 1),}, 100},	--Rương tranh đoạt lãnh thổ
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 1},	--Kim nguyên bảo [Tiểu]
	},
	[2] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 252, 1),}, 100},	--Rương tranh đoạt lãnh thổ
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 1},	--Kim nguyên bảo [Tiểu]
	},
	[3] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 252, 1),}, 100},	--
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 1},	--Kim nguyên bảo [Tiểu]
	},
	[4] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 252, 1),}, 100},	--
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 1},	--Kim nguyên bảo [Tiểu]
	},
	[5] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 1332, 1),}, 100},	--Mảnh hoàng kim
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 1},	--Kim nguyên bảo [Tiểu]
	},
	[6] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 1332, 1),}, 100},	--Mảnh hoàng kim
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 1},	--Kim nguyên bảo [Tiểu]
	},
	[7] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 920, 1),}, 100},	--Huân Chương Vinh Dự
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 1},	--Kim nguyên bảo [Tiểu]
	},
	[8] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 920, 1),}, 100},	--Huân Chương Vinh Dự
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 1},	--Kim nguyên bảo [Tiểu]
	},
	[9] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 1332, 1),}, 100},	--
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 1},	--Kim nguyên bảo [Tiểu]
	},
	[10] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 1332, 1),}, 100},	--
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 1},	--Kim nguyên bảo [Tiểu]
	},
};

tbSystem.tbItemInfo = {bForceBind=1,};

function tbSystem:OnDialog()
	local szMsg = "<color=yellow>[Hệ Thống Trao đổi]<color> Sử dụng những nguồn nguyên liệu không cần thiết có thể đổi những nguyên liệu khác, đương nhiên phải có lệ phí";
	local tbOpt = {{"Kết thúc đối thoại..."},};
	table.insert(tbOpt, 1, {"<color=yellow>Rương Tranh Đoạt Lãnh Thổ", self.TraoDoi, self, 1});
	table.insert(tbOpt, 2, {"<color=yellow>Mảnh Hoàng Kim", self.TraoDoi, self, 2});
	table.insert(tbOpt, 3, {"<color=yellow>Huân Chương Vinh Dự", self.TraoDoi, self, 3});
	Dialog:Say(szMsg, tbOpt);
end

function tbSystem:TraoDoi(nValue)
	local szMsg = "";
	local tbOpt = {{"Kết thúc đối thoại..."},};
	if nValue == 1 then
		szMsg = "<color=yellow>[Hệ Thống Trao đổi]<color>\n- 100 rương TĐLT->100 Chân Nguyên Tu Luyện Đơn\n- 100 rương TĐLT->100 Thánh Linh Bảo Hạp Hồn";
		table.insert(tbOpt, 1, {"<color=yellow>Chân Nguyên Tu Luyện Đơn", self.LuaChon, self, 1});
		table.insert(tbOpt, 2, {"<color=yellow>Thánh Linh Bảo Hạp Hồn", self.LuaChon, self, 2});
	elseif nValue == 2 then
		szMsg = "<color=yellow>[Hệ Thống Trao đổi]<color>\n- 100 Mảnh Hoàng Kim->100 Chân Nguyên Tu Luyện Đơn\n- 100 Mảnh Hoàng Kim->100 Thánh Linh Bảo Hạp Hồn";
		table.insert(tbOpt, 1, {"<color=yellow>Chân Nguyên Tu Luyện Đơn", self.LuaChon, self, 5});
		table.insert(tbOpt, 2, {"<color=yellow>Thánh Linh Bảo Hạp Hồn", self.LuaChon, self, 6});
	elseif nValue == 3 then
		szMsg = "<color=yellow>[Hệ Thống Trao đổi]<color>\n- 100 Huân Chương Vinh Dự->100 Chân Nguyên Tu Luyện Đơn\n- 100 Huân Chương Vinh Dự->100 Thánh Linh Bảo Hạp Hồn";
		table.insert(tbOpt, 1, {"<color=yellow>Chân Nguyên Tu Luyện Đơn", self.LuaChon, self, 7});
		table.insert(tbOpt, 2, {"<color=yellow>Thánh Linh Bảo Hạp Hồn", self.LuaChon, self, 8});
	end;
	Dialog:Say(szMsg, tbOpt);
end

function tbSystem:LuaChon(nValue)
	local szMsg = "<color=yellow>[Hệ Thống Trao Đổi]<color>";
	if (nValue == 1) then
		szMsg = "Đặt vào:\n<color=yellow>- 100 Rương Tranh Đoạt Lãnh Thổ\n- Lệ Phí : 1 Kim nguyên bảo [Tiểu]\n- Tỷ lệ thành công: 100%<color>";
	end;
	if (nValue == 2) then
		szMsg = "Đặt vào:\n<color=yellow>- 100 Rương Tranh Đoạt Lãnh Thổ\n- Lệ Phí : 1 Kim nguyên bảo [Tiểu]\n- Tỷ lệ thành công: 100%<color>";
	end;
	if (nValue == 5) then
		szMsg = "Đặt vào:\n<color=yellow>- 100 Mảnh hoàng kim\n- Lệ Phí : 1 Kim nguyên bảo [Tiểu]\n- Tỷ lệ thành công: 100%<color>";
	end;
	if (nValue == 6) then
		szMsg = "Đặt vào:\n<color=yellow>- 100 Mảnh hoàng kim\n- Lệ Phí : 1 Kim nguyên bảo [Tiểu]\n- Tỷ lệ thành công: 100%<color>";
	end;
	if (nValue == 7) then
		szMsg = "Đặt vào:\n<color=yellow>- 100 Huân Chương Vinh Dự\n- Lệ Phí : 1 Kim nguyên bảo [Tiểu]\n- Tỷ lệ thành công: 100%<color>";
	end;
	if (nValue == 8) then
		szMsg = "Đặt vào:\n<color=yellow>- 100 Huân Chương Vinh Dự\n- Lệ Phí : 1 Kim nguyên bảo [Tiểu]\n- Tỷ lệ thành công: 100%<color>";
	end;
	Dialog:OpenGift(szMsg, nil, {self.OnOpenGiftOk, self, nValue});
end;

function tbSystem:OnOpenGiftOk(nValue, tbItemObj)
	local tbItemList	= {};
	for _, pItem in pairs(tbItemObj) do
		if (self:ChechItem(pItem, REQUIRE_ITEM[nValue], tbItemList) ~= 1) then
			Dialog:Say("\nKhông phải vật phẩm đúng yêu cầu ta sẽ không nhận <pic=26>!",tbOpt);
			return 0;
		end;
	end
	local bResult 	= false;
	for i = 1, #REQUIRE_ITEM[nValue] do
		if (REQUIRE_ITEM[nValue][i][2] ~= tbItemList[i]) then
			bResult = true;
		end;
	end
	if (bResult) then
		Dialog:Say("\nSố lượng vật phẩm đặt vào không hợp lệ <pic=16>!",tbOpt);
		return 0;
	end;
	for _, pItem in pairs(tbItemObj) do
		if me.DelItem(pItem[1]) ~= 1 then
			return 0;
		end;
	end
	if (nValue == 1) then
		me.AddStackItem(18,1,1335,1,self.tbItemInfo,100);--Chân Nguyên Tu Luyện Đơn
	end;
	if (nValue == 2) then
		me.AddStackItem(18,1,1334,1,self.tbItemInfo,100);--Thánh Linh Bảo Hạp Hồn
	end;
	if (nValue == 5) then
		me.AddStackItem(18,1,1335,1,self.tbItemInfo,100);--Chân Nguyên Tu Luyện Đơn
	end;
	if (nValue == 6) then
		me.AddStackItem(18,1,1334,1,self.tbItemInfo,100);--Thánh Linh Bảo Hạp Hồn
	end;
	if (nValue == 7) then
		me.AddStackItem(18,1,1335,1,self.tbItemInfo,100);--Chân Nguyên Tu Luyện Đơn
	end;
	if (nValue == 8) then
		me.AddStackItem(18,1,1334,1,self.tbItemInfo,100);--Thánh Linh Bảo Hạp Hồn
	end;
end;

function tbSystem:ChechItem(pItem, tbItemList, tbCountList)
	if (not pItem) then
		return 0;
	end;
	local szItem		= string.format("%s,%s,%s,%s",pItem[1].nGenre, pItem[1].nDetail, pItem[1].nParticular, pItem[1].nLevel);
	for i = 1, #tbItemList do
		local tbI = tbItemList[i];
		for j = 1, #tbI[1] do
			if (szItem == tbI[1][j]) then
				tbCountList[i] = (tbCountList[i] or 0) + pItem[1].nCount;
				return 1;
			end;
		end
	end
	return 0;
end;