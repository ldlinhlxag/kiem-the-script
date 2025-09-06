
local tbPhanThuong = {};
SpecialEvent.PhanThuong = tbPhanThuong;

tbPhanThuong.TaskGourp = 3000; --task mới phải add vào gameserver\setting\player\task_def.txt
tbPhanThuong.TaskId_Day = 1; --task lưu ngày
tbPhanThuong.TaskId_Count = 2; --task lưu lần nhận
tbPhanThuong.TaskId_Last = 3; --task lưu thời gian nhận
tbPhanThuong.Relay_Time = 30*60; --thời gian giữa 2 lần nhận mình để 30p 1 lần
tbPhanThuong.Use_Max =1; --số lần nhận tối đa

function tbPhanThuong:OnDialog()
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	if me.GetTask(self.TaskGourp, self.TaskId_Day) < nDate then
		me.SetTask(self.TaskGourp, self.TaskId_Day, nDate);
		me.SetTask(self.TaskGourp, self.TaskId_Count, 0);
		me.SetTask(self.TaskGourp, self.TaskId_Last, 0);
	end 
	local nCount = me.GetTask(self.TaskGourp, self.TaskId_Count);
	local szMsg = "";
	szMsg = string.format("Hàng Ngày <color=yellow>online<color> có thể nhận thưởng, tối đa <color=yellow>%d<color> lần.\n\n",self.Use_Max);
	local szColor = "<color=Gray>"
	local szColorx = "<color>"
	szMsg = szMsg.."\n<color=yellow><color> "..((nCount >= 1 and szColor) or "").."Nhận Phần Thưởng Hàng Ngày<color>";
	szMsg = szMsg..string.format("\n\n<color=yellow>Hôm nay bạn đã nhận "..((nCount >= self.Use_Max and "đủ") or nCount).." phần thưởng.<color>");
	local tbOpt = {};
	if (nCount<self.Use_Max) then
		table.insert(tbOpt , {"Nhận thưởng ngay",  self.nhanthuong, self});
	end
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end

function tbPhanThuong:nhanthuong()
	local nCount = me.GetTask(self.TaskGourp, self.TaskId_Count);
    if nCount >= self.Use_Max then
        Dialog:Say(string.format("Hôm nay bạn đã nhận đủ phần thưởng."));
        return 0; 
    end    
	local nLast = me.GetTask(self.TaskGourp, self.TaskId_Last);
	local nHour = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	local nSec1 = Lib:GetDate2Time(nHour);
	local nSec2 = nLast + self.Relay_Time;
		if nSec1 < nSec2 then
			if ((nSec2 - nSec1)<=60) then
				me.Msg(string.format("Còn <color=yellow>%s giây<color> nữa mới nhận được phần thưởng tiếp theo.", (nSec2 - nSec1)));
			else
				me.Msg(string.format("Còn <color=yellow>%d phút<color> nữa mới nhận được phần thưởng tiếp theo.", (nSec2 - nSec1)/60));
			end
			return 0;
		end
	if (nCount == 0) then
		me.AddItem(18,	1,	295,	1);
		me.AddItem(18,	1,	1190,	1); --phần thưởng thứ 4
		me.AddItem(18,	1,	1190,	1); --phần thưởng thứ 4
		me.AddItem(18,	1,	1190,	1); --phần thưởng thứ 4
		me.AddItem(18,	1,	1190,	1); --phần thưởng thứ 4
		me.AddItem(18,	1,	1190,	1); --phần thưởng thứ 4
		me.AddItem(18,	1,	1190,	1); --phần thưởng thứ 4
		me.AddItem(18,	1,	1190,	1); --phần thưởng thứ 4
		me.AddItem(18,	1,	1190,	1); --phần thưởng thứ 4
		me.AddItem(18,	1,	1190,	1); --phần thưởng thứ 4
		me.AddItem(18,	1,	1190,	1); --phần thưởng thứ 4
		me.AddBindMoney(20000000); --phần thưởng thứ 2
		me.AddBindCoin(10000000); --phần thưởng thứ 3
		me.AddItem(18,	1,	114,	11); 
		me.AddItem(18,	1,	114,	11);--phần thưởng thứ 5
	elseif (nCount == 1) then
	end
	me.Msg(string.format("Bạn đã nhận được phần thưởng hàng ngày lần <color=yellow>%d<color>",nCount + 1));
	me.SetTask(self.TaskGourp, self.TaskId_Count, nCount + 1);
	local nHourS = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	local nSec3 = Lib:GetDate2Time(nHourS);
	me.SetTask(self.TaskGourp, self.TaskId_Last, nSec3);
end
