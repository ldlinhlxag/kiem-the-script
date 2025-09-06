local tbChuyenSinh = Npc:GetClass("chuyensinh");

tbChuyenSinh.TaskGourp_CS = 8888;
tbChuyenSinh.TaskId_Count_CS = 1;
tbChuyenSinh.Status = 1; --0: chưa mở		1: đang mở		2: bảo trì

local REQUIRECS_ITEM = 
	{ 
		[0] = {{{string.format("%s,%s,%s,%s", 18, 1, 205, 1),},100000},},
		[1] = {{{string.format("%s,%s,%s,%s", 18, 1, 205, 1),},100000},},
		[2] = {{{string.format("%s,%s,%s,%s", 18, 1, 205, 1),},100000},},
		[3] = {{{string.format("%s,%s,%s,%s", 18, 1, 205, 1),},100000},},
		[4] = {{{string.format("%s,%s,%s,%s", 18, 1, 205, 1),},100000},},
		[5] = {{{string.format("%s,%s,%s,%s", 18, 1, 205, 1),},100000},},
		[6] = {{{string.format("%s,%s,%s,%s", 18, 1, 205, 1),},100000},},
		[7] = {{{string.format("%s,%s,%s,%s", 18, 1, 205, 1),},100000},},
		[8] = {{{string.format("%s,%s,%s,%s", 18, 1, 205, 1),},100000},},
		[9] = {{{string.format("%s,%s,%s,%s", 18, 1, 205, 1),},100000},},
	};

function tbChuyenSinh:OnDialog()
	local nLan = me.GetTask(tbChuyenSinh.TaskGourp_CS,tbChuyenSinh.TaskId_Count_CS);
	local szMsg = "Ta Sẽ Giúp nhà ngươi chuyển sinh. Sẵn sàng chưa ?\n Ngươi đã chuyển sinh <color=red>"..nLan.." lần<color>";
	local tbOpt =
	{
		{"<color=yellow>Tìm hiểu thêm Chuyển Sinh.<color>", self.OnDialog_3, self},--
		{"<color=yellow>Ta Muốn Chuyển Sinh.<color>", self.DoItemCs, self},--
		{"Kết thúc đối thoại"},
	}
	Dialog:Say(szMsg, tbOpt);
end;

function tbChuyenSinh:OnDialog_3()
	local tbOpt = {};
	tbOpt = Lib:MergeTable( tbOpt,{
		{"Trở về",  self.OnDialog, self},
		{"Đóng"},
	});
	Dialog:Say(
		"   Tối đa nhà ngươi chỉ có thể chuyển sinh <color=Red>10 lần<color>,phí chuyển sinh là <color=gold>10 vạn Ngũ Hành Hồn Thạch và 1 Ức Bạc thường<color>,mỗi lần sẽ tính theo quy tắc sau:\n"..
		"   Từ lần 1->4 Yêu cầu:<color=Red>Cấp 170<color>, các lần sau tăng thêm 10 cấp, sau chuyển sinh Nhà ngươi nhận được <color=gold><color=red>Số lần CS*100<color> điểm tiềm năng<color> và <color=gold>Số lần chuyển sinh * <color=red>2<color> điểm kĩ năng<color>,được <color=red>Cộng dồn<color> với số điểm lần 1\n"..
		"   Từ lần 5->10 cần: <color=red>cấp 200<color>, sau chuyển sinh Nhà ngươi nhận được <color=gold><color=red>số lần chuyển sinh*100<color> điểm tiềm năng<color> và <color=gold><color=red>số lần chuyển sinh*2<color> điểm kĩ năng<color>,được <color=red>Cộng dồn<color> với tất cả các lần trước đó."
	,tbOpt);
	return 0;
end;

function tbChuyenSinh:DoItemCs(nValue)
	local pItem1 = me.GetEquip(Item.EQUIPPOS_HEAD);
	local pItem2 = me.GetEquip(Item.EQUIPPOS_BODY);
	local pItem3 = me.GetEquip(Item.EQUIPPOS_BELT);
	local pItem4 = me.GetEquip(Item.EQUIPPOS_WEAPON);
	local pItem5 = me.GetEquip(Item.EQUIPPOS_FOOT);
	local pItem6 = me.GetEquip(Item.EQUIPPOS_CUFF);
	local pItem7 = me.GetEquip(Item.EQUIPPOS_AMULET);
	local pItem8 = me.GetEquip(Item.EQUIPPOS_RING);
	local pItem9 = me.GetEquip(Item.EQUIPPOS_NECKLACE);
	local pItem10 = me.GetEquip(Item.EQUIPPOS_PENDANT);
	if (pItem1 == nil) and (pItem2 == nil) and (pItem3 == nil) and (pItem4 == nil) and (pItem5 == nil) and (pItem6 == nil) and (pItem7 == nil) and (pItem8 == nil) and (pItem9 == nil) and (pItem10 == nil) then
		local nValue = me.GetTask(tbChuyenSinh.TaskGourp_CS,tbChuyenSinh.TaskId_Count_CS);
		local szMsg = "Chuyển sinh Nhân Vật";
		if (self.Status == 1) then
			if (nValue == 0) then
				if me.nLevel < 170 then
					Dialog:SendBlackBoardMsg(me, string.format("Cấp độ dưới <color=yellow>170<color> không thể chuyển sinh !"));
				return 0;
				end
				szMsg = "Để thực hiện việc chuyển sinh bạn cần nộp 10 vạn Ngũ Hành Hồn Thạch & 1 Ức bạc thường";
			end;
			if (nValue == 1) then
				if me.nLevel < 180 then
					Dialog:SendBlackBoardMsg(me, string.format("Cấp độ dưới <color=yellow>180<color> không thể chuyển sinh !"));
				return 0;
				end
				szMsg = "Để thực hiện việc chuyển sinh bạn cần nộp 10 vạn Ngũ Hành Hồn Thạch & 1 Ức bạc thường";
			end;
			if (nValue == 2) then
				if me.nLevel < 190 then
					Dialog:SendBlackBoardMsg(me, string.format("Cấp độ dưới <color=yellow>190<color> không thể chuyển sinh !"));
				return 0;
				end
				szMsg = "Để thực hiện việc chuyển sinh bạn cần nộp 10 vạn Ngũ Hành Hồn Thạch & 1 Ức bạc thường";
			end;
			if (nValue == 3) then
				if me.nLevel < 200 then
					Dialog:SendBlackBoardMsg(me, string.format("Cấp độ dưới <color=yellow>200<color> không thể chuyển sinh !"));
				return 0;
				end
				szMsg = "Để thực hiện việc chuyển sinh bạn cần nộp 10 vạn Ngũ Hành Hồn Thạch & 1 Ức bạc thường";
			end;
			if (nValue == 4) then
				if me.nLevel < 200 then
					Dialog:SendBlackBoardMsg(me, string.format("Cấp độ dưới <color=yellow>200<color> không thể chuyển sinh !"));
				return 0;
				end
				szMsg = "Để thực hiện việc chuyển sinh bạn cần nộp 10 vạn Ngũ Hành Hồn Thạch & 1 Ức bạc thường";
			end;
			if (nValue == 5) then
				if me.nLevel < 200 then
					Dialog:SendBlackBoardMsg(me, string.format("Cấp độ dưới <color=yellow>200<color> không thể chuyển sinh !"));
				return 0;
				end
				szMsg = "Để thực hiện việc chuyển sinh bạn cần nộp 10 vạn Ngũ Hành Hồn Thạch & 1 Ức bạc thường";
			end;
			if (nValue == 6) then
				if me.nLevel < 200 then
					Dialog:SendBlackBoardMsg(me, string.format("Cấp độ dưới <color=yellow>200<color> không thể chuyển sinh !"));
				return 0;
				end
				szMsg = "Để thực hiện việc chuyển sinh bạn cần nộp 10 vạn Ngũ Hành Hồn Thạch & 1 Ức bạc thường";
			end;
			if (nValue == 7) then
				if me.nLevel < 200 then
					Dialog:SendBlackBoardMsg(me, string.format("Cấp độ dưới <color=yellow>200<color> không thể chuyển sinh !"));
				return 0;
				end
				szMsg = "Để thực hiện việc chuyển sinh bạn cần nộp 10 vạn Ngũ Hành Hồn Thạch & 1 Ức bạc thường";
			end;
			if (nValue == 8) then
				if me.nLevel < 200 then
					Dialog:SendBlackBoardMsg(me, string.format("Cấp độ dưới <color=yellow>200<color> không thể chuyển sinh !"));
				return 0;
				end
				szMsg = "Để thực hiện việc chuyển sinh bạn cần nộp 10 vạn Ngũ Hành Hồn Thạch & 1 Ức bạc thường";
			end;
			if (nValue == 9) then
				if me.nLevel < 200 then
					Dialog:SendBlackBoardMsg(me, string.format("Cấp độ dưới <color=yellow>200<color> không thể chuyển sinh !"));
				return 0;
				end
				szMsg = "Để thực hiện việc chuyển sinh bạn cần nộp 10 vạn Ngũ Hành Hồn Thạch & 1 Ức bạc thường";
			end;
			if (nValue > 9) then
				Dialog:SendBlackBoardMsg(me, string.format("Bạn Đã chuyển sinh <color=yellow>10 lần<color> không thể chuyển sinh !"));
				return 0;
			end;
		elseif (self.Status == 2) then
			Dialog:SendBlackBoardMsg(me, string.format("Hệ thống đang bảo trì để nâng cấp !!!"));
			return 0;
		elseif (self.Status == 0) then
			Dialog:SendBlackBoardMsg(me, string.format("Hệ thống chưa mở !!!"));
			return 0;
		end;
		Dialog:OpenGift(szMsg, nil, {self.OnCsOpenGiftOk, self, nValue});
	else
		me.Msg("Ngươi chưa tháo trang bị xuống, chuyển sinh có thể kẹt acc");
		return 0;
	end
end;

function tbChuyenSinh:OnCsOpenGiftOk(nValue, tbItemObj)
	local nBac = me.GetBindMoney();
	if nBac < 100000000 then
		me.Msg("Ngươi không mang đủ Bạc !");
		return 0;
	end;
	local szMsg = string.format("Chúc mừng người chơi <color=cyan>%s<color> Chuyển Sinh lần thứ <color=cyan>%s<color>", me.szName, nValue+1 );
	local tbItemList	= {};
	for _, pItem in pairs(tbItemObj) do
		if (self:CheckCSItem(pItem, REQUIRECS_ITEM[nValue], tbItemList) ~= 1) then
			me.Msg("Không có vật phẩm yêu cầu!");
			return 0;
		end;
	end
	local bResult 	= false;
	for i = 1, #REQUIRECS_ITEM[nValue] do
		if (REQUIRECS_ITEM[nValue][i][2] ~= tbItemList[i]) then
			bResult = true;
		end;
	end;
	if (bResult) then
		me.Msg("Số lượng vật phẩm không chính xác!");
		return 0;
	end;
	for _, pItem in pairs(tbItemObj) do
		if me.DelItem(pItem[1]) ~= 1 then
			return 0;
		end
	end
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT, szMsg);
	KDialog.MsgToGlobal(szMsg);			
	me.SendMsgToFriend("Hảo hữu của bạn [<color=yellow>".. me.szName .."<color>] Chuyển Sinh lần thứ  <color=cyan>".. nValue+1 .."<color>");                              
	if (nValue == 0) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 110
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		me.AddPotential(100); -- add diem tiem nang
		me.SetTask(8888,2,1);
		Player:SetFree(me.szName);
		me.SetTask(tbChuyenSinh.TaskGourp_CS, tbChuyenSinh.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
		me.CostMoney(nBac,0);
	end;
	if (nValue == 1) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		me.AddPotential(200); -- add diem tiem nang
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(200); -- add diem tiem nang
			me.AddPotential(-1*100)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbChuyenSinh.TaskGourp_CS, tbChuyenSinh.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
		me.CostMoney(nBac,0);
	end;
	if (nValue == 2) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(300); -- add diem tiem nang
			me.AddPotential(-1*300)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbChuyenSinh.TaskGourp_CS, tbChuyenSinh.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
		me.CostMoney(nBac,0);
	end;
	if (nValue == 3) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(400); -- add diem tiem nang
			me.AddPotential(-1*600)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbChuyenSinh.TaskGourp_CS, tbChuyenSinh.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
		me.CostMoney(nBac,0);
	end;
	if (nValue == 4) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 110
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(500); -- add diem tiem nang
			me.AddPotential(-1*1000)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbChuyenSinh.TaskGourp_CS, tbChuyenSinh.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
		me.CostMoney(nBac,0);
	end;
	if (nValue == 5) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(600); -- add diem tiem nang
			me.AddPotential(-1*1500)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbChuyenSinh.TaskGourp_CS, tbChuyenSinh.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
		me.CostMoney(nBac,0);
	end;
	if (nValue == 6) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(700); -- add diem tiem nang
			me.AddPotential(-1*2100)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbChuyenSinh.TaskGourp_CS, tbChuyenSinh.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
		me.CostMoney(nBac,0);
	end;
	if (nValue == 7) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(800); -- add diem tiem nang
			me.AddPotential(-1*2800)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbChuyenSinh.TaskGourp_CS, tbChuyenSinh.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
		me.CostMoney(nBac,0);
	end;
	if (nValue == 8) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(900); -- add diem tiem nang
			me.AddPotential(-1*3600)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbChuyenSinh.TaskGourp_CS, tbChuyenSinh.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
		me.CostMoney(nBac,0);
	end;
	if (nValue == 9) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(1000); -- add diem tiem nang
			me.AddPotential(-1*4500)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbChuyenSinh.TaskGourp_CS, tbChuyenSinh.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
		me.CostMoney(nBac,0);
	end;
end;

function tbChuyenSinh:CheckCSItem(pItem, tbItemList, tbCountList)
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
		end;
	end;
	return 0;
end;