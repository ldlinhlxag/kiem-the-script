local tbPhanThuong = Npc:GetClass("phanthuongthangcap");
tbPhanThuong.tbItemInfo = {bForceBind=1,};

tbPhanThuong.TaskGourp = 3003;
tbPhanThuong.TaskId_Level140 = 2;
tbPhanThuong.TaskId_Level150 = 3;
tbPhanThuong.TaskId_Level160 = 4;
tbPhanThuong.Use_Max =1;

function tbPhanThuong:OnDialog()
if me.CountFreeBagCell() < 25 then
		Dialog:Say("Phải Có 25 Ô Trống Trong Túi Hành Trang");
		return 0;
	end
	local szMsg = "[Phần Thưởng Thăng Cấp]";
	local tbOpt = {};
		if me.nLevel < 140 then
			table.insert(tbOpt, {"Đẳng cấp của ngươi quá thấp, chưa đủ khả năng nhận phần thưởng, ngươi cần lên 130 để nhận phần thưởng đầu tiên"});
		elseif me.nLevel >=160 then
			table.insert(tbOpt , {"Level 140",  self.ThuongLevel, self, 140});
			table.insert(tbOpt , {"Level 150",  self.ThuongLevel, self, 150});
			table.insert(tbOpt , {"Level 160",  self.ThuongLevel, self, 160});
		elseif me.nLevel >=150 then
			table.insert(tbOpt , {"Level 140",  self.ThuongLevel, self, 140});
			table.insert(tbOpt , {"Level 150",  self.ThuongLevel, self, 150});
		elseif me.nLevel >=140 then
			table.insert(tbOpt , {"Level 140",  self.ThuongLevel, self, 140});
		end;
	table.insert(tbOpt, {"Đóng lại"});
	Dialog:Say(szMsg, tbOpt);
end

function tbPhanThuong:ThuongLevel(nValue)
	local lv140 = me.GetTask(self.TaskGourp, self.TaskId_Level140);
	local lv150 = me.GetTask(self.TaskGourp, self.TaskId_Level150);
	local lv160 = me.GetTask(self.TaskGourp, self.TaskId_Level160);
	if (nValue == 140) then
		if lv140 >= 1 then
			Dialog:Say(string.format("Ngươi đã nhận thưởng."));
			return 0; 
		else
			me.AddStackItem(18,1,1,10,self.tbItemInfo,1);	-- 1 Huyền Tinh 10
			me.AddStackItem(18,1,377,1,self.tbItemInfo,50);	-- 50 Tần Lăng HTB
			me.AddItem(5,23,1,1); -- Phù Cấp 1
			me.AddItem(5,20,1,1); -- Áo Cấp 1
			me.AddItem(5,22,1,1); -- Bao Tay Cấp 1
			me.AddItem(5,21,1,1); -- Nhẫn Cấp 1
			me.AddItem(5,19,1,1); -- Vũ Khí Cấp 1
			me.SetTask(self.TaskGourp, self.TaskId_Level140, lv140 + 1);
			Dialog:SendBlackBoardMsg(me, string.format("Chúc mừng bạn nhận được phần thưởng <color=red>Cấp %d<color>!!!", nValue));
		end;
	end
	if (nValue == 150) then
		if lv150 >= 1 then
			Dialog:Say(string.format("Ngươi đã nhận thưởng."));
			return 0; 
		else
			me.AddStackItem(18,1,1,10,self.tbItemInfo,2);	-- 2 Huyền Tinh 10
			me.AddStackItem(18,1,377,1,self.tbItemInfo,70);	-- 70 Tần Lăng HTB
			me.AddStackItem(18,10,11,2,self.tbItemInfo,10);	-- 10 Đồng Tiền Vàng
			me.SetTask(self.TaskGourp, self.TaskId_Level150, lv150 + 1);
			Dialog:SendBlackBoardMsg(me, string.format("Chúc mừng bạn nhận được phần thưởng <color=red>Cấp %d<color>!!!", nValue));
		end;
	end
	
	if (nValue == 160) then
		if lv160 >= 1 then
			Dialog:Say(string.format("Ngươi đã nhận thưởng."));
			return 0; 
		else
			me.AddStackItem(18,1,1,10,self.tbItemInfo,2);	-- 3 Huyền Tinh 10
			me.AddStackItem(18,1,377,1,self.tbItemInfo,100);	-- 100 Tần Lăng HTB
			me.AddStackItem(18,10,11,2,self.tbItemInfo,20);	-- 20 Đồng Tiền Vàng
			me.SetTask(self.TaskGourp, self.TaskId_Level160, lv160 + 1);
			me.AddItem(5,23,1,2); -- Phù Cấp 2
			me.AddItem(5,20,1,2); -- Áo Cấp 2
			me.AddItem(5,22,1,2); -- Bao Tay Cấp 2
			me.AddItem(5,21,1,2); -- Nhẫn Cấp 2
			me.AddItem(5,19,1,2); -- Vũ Khí Cấp 2
			Dialog:SendBlackBoardMsg(me, string.format("Chúc mừng bạn nhận được phần thưởng <color=red>Cấp %d<color>!!!", nValue));
		end;
	end
end