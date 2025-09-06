
local tbSystem = Npc:GetClass("ghepmanhluyenhoa");
local REQUIRE_ITEM = 
{ 
	[1] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 1340, 1),}, 10},	--[Mảnh Ghép]Tinh Thạch Phượng Hoàng
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 1},	--Kim nguyên bảo [Tiểu]
	},
	[2] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 1340, 2),}, 10},	--[Mảnh Ghép]Tinh Thạch Ảnh Nguyệt
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 1},	--Kim nguyên bảo [Tiểu]
	},
	[3] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 1340, 3),}, 10},	--[Mảnh Ghép]Tinh Thạch Đoạn Hải
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 1},	--Kim nguyên bảo [Tiểu]
	},
	[4] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 1340, 4),}, 10},	--[Mảnh Ghép]Tinh Thạch Thánh Hỏa
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 2},	--Kim nguyên bảo [Tiểu]
	},
	[5] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 1340, 1),}, 10},	--[Mảnh Ghép]Tinh Thạch Phượng Hoàng
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 2},	--Kim nguyên bảo [Tiểu]
		{{string.format("%s,%s,%s,%s", 18, 10, 11, 2),}, 1},	--Đồng tiền vàng
	},
	[6] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 1340, 2),}, 10},	--[Mảnh Ghép]Tinh Thạch Ảnh Nguyệt
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 2},	--Kim nguyên bảo [Tiểu]
		{{string.format("%s,%s,%s,%s", 18, 10, 11, 2),}, 1},	--Đồng tiền vàng
	},
	[7] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 1340, 3),}, 10},	--[Mảnh Ghép]Tinh Thạch Đoạn Hải
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 2},	--Kim nguyên bảo [Tiểu]
		{{string.format("%s,%s,%s,%s", 18, 10, 11, 2),}, 2},	--Đồng tiền vàng
	},
	[8] = {
		{{string.format("%s,%s,%s,%s", 18, 1, 1340, 4),}, 10},	--[Mảnh Ghép]Tinh Thạch Thánh Hỏa
		{{string.format("%s,%s,%s,%s", 18, 1, 1338, 2),}, 2},	--Kim nguyên bảo [Tiểu]
		{{string.format("%s,%s,%s,%s", 18, 10, 11, 2),}, 2},	--Đồng tiền vàng
	},
};

function tbSystem:OnDialog()
	local szMsg = "<color=yellow>[Hệ Thống Luyện Hóa]<color> Mang về cho ta 10 mảnh ghép và kinh phí, ta sẽ cho ngươi cơ hội để hợp thành mảnh hoàn chỉnh\n\n Với cách ghép VIP, tỷ lệ thành công sẽ nâng cao đáng kể";
	local tbOpt = {{"Kết thúc đối thoại..."},};
	table.insert(tbOpt, 1, {"<color=yellow>Ghép Tinh Thạch", self.GhepManh, self, 1});
	table.insert(tbOpt, 2, {"<color=yellow>Ghép Tinh Thạch (Vip)", self.GhepManh, self, 2});
	Dialog:Say(szMsg, tbOpt);
end

function tbSystem:GhepManh(nValue)
	local szMsg = "<color=yellow>[Hệ Thống Luyện Hóa]<color> Mang về cho ta 10 mảnh ghép và kinh phí, ta sẽ cho ngươi cơ hội để hợp thành mảnh hoàn chỉnh\n\n Với cách ghép VIP, tỷ lệ thành công sẽ nâng cao đáng kể";
	local tbOpt = {{"Kết thúc đối thoại..."},};
	if nValue == 1 then
		table.insert(tbOpt, 1, {"<color=yellow>Tinh Thạch Phượng Hoàng[Cấp 1]", self.LuaChon, self, 1});
		table.insert(tbOpt, 2, {"<color=yellow>Tinh Thạch Ảnh Nguyệt[Cấp 2]", self.LuaChon, self, 2});
		table.insert(tbOpt, 3, {"<color=yellow>Tinh Thạch Đoạn Hải[Cấp 3]", self.LuaChon, self, 3});
		table.insert(tbOpt, 4, {"<color=yellow>Tinh Thạch Thánh Hỏa[Cấp 4]", self.LuaChon, self, 4});
	elseif nValue == 2 then
		table.insert(tbOpt, 1, {"<color=yellow>Tinh Thạch Phượng Hoàng[Cấp 1]", self.LuaChon, self, 5});
		table.insert(tbOpt, 2, {"<color=yellow>Tinh Thạch Ảnh Nguyệt[Cấp 2]", self.LuaChon, self, 6});
		table.insert(tbOpt, 3, {"<color=yellow>Tinh Thạch Đoạn Hải[Cấp 3]", self.LuaChon, self, 7});
		table.insert(tbOpt, 4, {"<color=yellow>Tinh Thạch Thánh Hỏa[Cấp 4]", self.LuaChon, self, 8});
	end;
	Dialog:Say(szMsg, tbOpt);
end

function tbSystem:LuaChon(nValue)
	local szMsg = "<color=yellow>Ghép mãnh Luyện hóa Chân Vũ + Ngoại Trang<color>";
	if (nValue == 1) then
		szMsg = "Đặt vào:\n- 10 [Mảnh Ghép]Tinh Thạch Phượng Hoàng\n- Lệ Phí : 1 Kim nguyên bảo [Tiểu]\n- Tỷ lệ thành công: 60%";
	end;
	if (nValue == 2) then
		szMsg = "Đặt vào:\n- 10 [Mảnh Ghép]Tinh Thạch Ảnh Nguyệt\n- Lệ Phí : 2 Kim nguyên bảo [Tiểu]\n- Tỷ lệ thành công: 50%";
	end;
	if (nValue == 3) then
		szMsg = "Đặt vào:\n- 10 [Mảnh Ghép]Tinh Thạch Đoạn Hải\n- Lệ Phí : 3 Kim nguyên bảo [Tiểu]\n- Tỷ lệ thành công: 40%";
	end;
	if (nValue == 4) then
		szMsg = "Đặt vào:\n- 10 [Mảnh Ghép]Tinh Thạch Thánh Hỏa\n- Lệ Phí : 4 Kim nguyên bảo [Tiểu]\n- Tỷ lệ thành công: 30%";
	end;
	if (nValue == 5) then
		szMsg = "Đặt vào:\n- 10 [Mảnh Ghép]Tinh Thạch Phượng Hoàng\n- Lệ Phí : 1 Kim nguyên bảo [Tiểu]\n- 1 Đồng tiền vàng\n- Tỷ lệ thành công: 80%";
	end;
	if (nValue == 6) then
		szMsg = "Đặt vào:\n- 10 [Mảnh Ghép]Tinh Thạch Ảnh Nguyệt\n- Lệ Phí : 2 Kim nguyên bảo [Tiểu]\n- 1 Đồng tiền vàng\n- Tỷ lệ thành công: 75%";
	end;
	if (nValue == 7) then
		szMsg = "Đặt vào:\n- 10 [Mảnh Ghép]Tinh Thạch Đoạn Hải\n- Lệ Phí : 3 Kim nguyên bảo [Tiểu]\n- 2 Đồng tiền vàng\n- Tỷ lệ thành công: 70%";
	end;
	if (nValue == 8) then
		szMsg = "Đặt vào:\n- 10 [Mảnh Ghép]Tinh Thạch Thánh Hỏa\n- Lệ Phí : 4 Kim nguyên bảo [Tiểu]\n- 2 Đồng tiền vàng\n- Tỷ lệ thành công: 65%";
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
		local i = 0;
		local nAdd = 0;
		local nRand = 0;
		local nIndex = 0;
		nRand = MathRandom(1, 100);
		local tbRate = {60,40};
		for i = 1, 2 do
			nAdd = nAdd + tbRate[i];
			if nAdd >= nRand then
				nIndex = i;
				break;
			end
		end
		if nIndex == 1 then
			me.AddItem(18,1,1331,1);
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thành công<color>"));
		else
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thất bại<color>"));
		end;
	end;
	if (nValue == 2) then
		local i = 0;
		local nAdd = 0;
		local nRand = 0;
		local nIndex = 0;
		nRand = MathRandom(1, 100);
		local tbRate = {50,50};
		local tbAward = {2};
		for i = 1, 2 do
			nAdd = nAdd + tbRate[i];
			if nAdd >= nRand then
				nIndex = i;
				break;
			end
		end
		if nIndex == 1 then
			me.AddItem(18,1,1331,2);
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thành công<color>"));
		else
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thất bại<color>"));
		end;
	end;
	if (nValue == 3) then
		local i = 0;
		local nAdd = 0;
		local nRand = 0;
		local nIndex = 0;
		nRand = MathRandom(1, 100);
		local tbRate = {40,60};
		local tbAward = {3};
		for i = 1, 2 do
			nAdd = nAdd + tbRate[i];
			if nAdd >= nRand then
				nIndex = i;
				break;
			end
		end
		if nIndex == 1 then
			me.AddItem(18,1,1331,3);
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thành công<color>"));
		else
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thất bại<color>"));
		end;
	end;
	if (nValue == 4) then
		local i = 0;
		local nAdd = 0;
		local nRand = 0;
		local nIndex = 0;
		nRand = MathRandom(1, 100);
		local tbRate = {30,70};
		local tbAward = {4};
		for i = 1, 2 do
			nAdd = nAdd + tbRate[i];
			if nAdd >= nRand then
				nIndex = i;
				break;
			end
		end
		if nIndex == 1 then
			me.AddItem(18,1,1331,4);
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thành công<color>"));
		else
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thất bại<color>"));
		end;
	end;
	---------------------------------------------------------------
	if (nValue == 5) then
		local i = 0;
		local nAdd = 0;
		local nRand = 0;
		local nIndex = 0;
		nRand = MathRandom(1, 100);
		local tbRate = {80,20};
		for i = 1, 2 do
			nAdd = nAdd + tbRate[i];
			if nAdd >= nRand then
				nIndex = i;
				break;
			end
		end
		if nIndex == 1 then
			me.AddItem(18,1,1331,1);
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thành công<color>"));
		else
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thất bại<color>"));
		end;
	end;
	if (nValue == 6) then
		local i = 0;
		local nAdd = 0;
		local nRand = 0;
		local nIndex = 0;
		nRand = MathRandom(1, 100);
		local tbRate = {75,25};
		local tbAward = {2};
		for i = 1, 2 do
			nAdd = nAdd + tbRate[i];
			if nAdd >= nRand then
				nIndex = i;
				break;
			end
		end
		if nIndex == 1 then
			me.AddItem(18,1,1331,2);
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thành công<color>"));
		else
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thất bại<color>"));
		end;
	end;
	if (nValue == 7) then
		local i = 0;
		local nAdd = 0;
		local nRand = 0;
		local nIndex = 0;
		nRand = MathRandom(1, 100);
		local tbRate = {70,30};
		local tbAward = {3};
		for i = 1, 2 do
			nAdd = nAdd + tbRate[i];
			if nAdd >= nRand then
				nIndex = i;
				break;
			end
		end
		if nIndex == 1 then
			me.AddItem(18,1,1331,3);
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thành công<color>"));
		else
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thất bại<color>"));
		end;
	end;
	if (nValue == 8) then
		local i = 0;
		local nAdd = 0;
		local nRand = 0;
		local nIndex = 0;
		nRand = MathRandom(1, 100);
		local tbRate = {65,35};
		local tbAward = {4};
		for i = 1, 2 do
			nAdd = nAdd + tbRate[i];
			if nAdd >= nRand then
				nIndex = i;
				break;
			end
		end
		if nIndex == 1 then
			me.AddItem(18,1,1331,4);
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thành công<color>"));
		else
			Dialog:SendBlackBoardMsg(me, string.format("<color=yellow>Ghép thất bại<color>"));
		end;
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