function Lottery:GSSynStart()
	self.nInSyn = 1;
end

function Lottery:GSSynEnd()
	self.nInSyn = 0;
end

function Lottery:GSDataIsValid()
	if not self.nInSyn or self.nInSyn == 1 then
		return 0;
	else
		return 1;
	end
end

function Lottery.__sort_dialog_cmp(tb1, tb2)
	return tb1[4] < tb2[4];
end

function Lottery:OnDialog()
	local nRes, var = Lottery:GetPlayerAwardList(me);
	if nRes == 0 then
		Dialog:Say(var);
		return;
	end
	
	local tbOpt = {};
	for nDate, tbAwardInDate in pairs(var) do
		local nTime = Lib:GetDate2Time(nDate);
		local hasAward = 0;
		local szMsg = string.format(" Tháng %d %d ngày nhận thưởng", tonumber(os.date("%m", nTime)), tonumber(os.date("%d", nTime)));
		local tbAward = {}
		for nAward, nAwardNum in pairs(tbAwardInDate) do
			if nAwardNum > 0 then
				hasAward = 1;
				tbAward[nAward] = nAwardNum;
			end
		end
		
		if hasAward == 1 then
			table.insert(tbOpt, {szMsg, Lottery.OnDialog2, Lottery, nDate, tbAward});
		end
	end
	
	table.sort(tbOpt, self.__sort_dialog_cmp);
	table.insert(tbOpt, {"Tôi chỉ muốn xem"});
	Dialog:Say("bạn là người may mắn bạn trúng rút thăm bên dưới là một phần thưởng dành cho bạn.", tbOpt);
end

function Lottery:OnDialog2(nDate, tbAward)
	local tbOpt = {}
	for nAward, szAwardName in ipairs(self.tbAwardName) do
		local nAwardNum = tbAward[nAward];
		if nAwardNum then
			local szMsg = string.format("%s %d Trung", szAwardName, nAwardNum);
			table.insert(tbOpt, {szMsg, Lottery.GetAward, Lottery, me, nDate, nAward, nAwardNum});		
		end
	end
	
	table.insert(tbOpt, "Tôi chỉ muốn xem");
	local nTime = Lib:GetDate2Time(nDate);
	local szMsg = string.format("Nhận phẩn thưởng ngày %d tháng %d", tonumber(os.date("%d", nTime)), tonumber(os.date("%m", nTime)));
	Dialog:Say(szMsg, tbOpt);
end

