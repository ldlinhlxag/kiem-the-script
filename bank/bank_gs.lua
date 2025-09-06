-- �ļ�������bank.lua
-- �����ߡ���furuilei
-- ����ʱ�䣺2008-11-24 14:57:51

if MODULE_GAMECLIENT then
	return;
end

Bank.tbc2sFun = {};

if (GLOBAL_AGENT) then
	Bank.nBankState = 0;
else
	Bank.nBankState = 1;
end;


function Bank:SetBankState(nState)
	self.nBankState = nState;
end

-- ������
function Bank:GoldSave(nValue)
	if (not nValue or 0 == Lib:IsInteger(nValue)) then
		return;
	end
	if (not nValue or nValue <= 0 or nValue > me.nCoin) then
		local szMsg = "Bạn không mang theo đủ bạc, không thể thực hiện thao tác vừa chọn.";
		me.Msg(szMsg);
		return;
	end
	local nMoneyOld = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_SUM);
--	me.Msg("��ǰ��������ǰ��Ǯׯ�ڽ������Ϊ��"..nMoneyOld.."����");
	local bRet = me.RestoreCoin(nValue);
	if (bRet == 0) then
		me.Msg("Bây giờ các trò chơi đang chạy từ từ, tôi sẽ đi một lần nữa để tiết kiệm tiền.");
	else
		if (nMoneyOld == 0) then
			me.CallClientScript({"Bank:UpdateInfo", nValue});
		end;
	end
end
Bank.tbc2sFun["GoldSave"] = Bank.GoldSave;

-- ��Ǯׯȡ�����
function Bank:GoldDraw(nGoldDrawCount)
	if (not nGoldDrawCount or 0 == Lib:IsInteger(nGoldDrawCount)) then
		return;
	end
	local nGoldSum = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_SUM);
	if (not nGoldDrawCount or nGoldDrawCount <= 0 or nGoldDrawCount > nGoldSum) then
		local szMsg = "Số tiền bạn vừa nhập không đúng, xin vui lòng nhập lại.";
		me.Msg(szMsg);
		return;
	end
	
	local nGoldLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_LIMIT);
	local nHaveDraw = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_TODAYTAKEOUTGOLDCOUNT);
	local nDate = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_TAKEOUTGOLD_DATE);
	local nTime = GetTime();
	
	if (nTime - nDate >= self.DAYSECOND) then
		if (nGoldDrawCount > nGoldLimit)then
			me.Msg("Bạn muốn loại bỏ vàng quá mức giới hạn.");
			return;
		end
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_TAKEOUTGOLD_DATE, nTime);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_TODAYTAKEOUTGOLDCOUNT, nGoldDrawCount);
	else
		if ((nGoldDrawCount + nHaveDraw) > nGoldLimit) then
			local nCanDrawCount = nGoldLimit - nHaveDraw;
			if (nCanDrawCount < 0) then
				nCanDrawCount = 0;
			end
			local szMsg = "Bạn loại bỏ trong vòng 24 giờ vàng vượt quá giới hạn, bạn có thể đưa ra lên tới<color=yellow>" .. nCanDrawCount .. "<color>��ҡ�";
			me.Msg(szMsg);
			return;
		end
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_TODAYTAKEOUTGOLDCOUNT, nGoldDrawCount + nHaveDraw);
	end
	local bRet = me.TakeOutCoin(nGoldDrawCount);
	if (bRet == 0) then
		me.Msg("Game đang bị chạy chậm, hãy nhận lại tiền của bạn");
	end
end
Bank.tbc2sFun["GoldDraw"] = Bank.GoldDraw;

-- ȡ��δ��Ч�Ľ��֧ȡ����
function Bank:CancelGoldLimit()
	me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_EFFICIENT_DAY, 0);
	me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_UNEFFICIENT_LIMIT, 0);
	me.Msg("Bạn đã hủy bỏ rút tiền");	
	me.CallClientScript({"Bank:UpdateInfo"});
end
Bank.tbc2sFun["CancelGoldLimit"] = Bank.CancelGoldLimit;

-- �޸Ľ��֧ȡ����
function Bank:ModifyGoldLimit(nNewGoldLimit)
	if (not nNewGoldLimit or 0 == Lib:IsInteger(nNewGoldLimit)) then
		return;
	end
	if (not nNewGoldLimit or nNewGoldLimit <= 0 or nNewGoldLimit > Bank.MAX_COIN) then
		me.Msg("Số bạn nhập vào không đúng, xin vui lòng nhập lại.");
		return;
	end
	
	local nOldGoldLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_LIMIT);
	local szMsg = "";
	local nTime = GetTime();
	
	if nNewGoldLimit <= nOldGoldLimit then
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_LIMIT, nNewGoldLimit);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_UNEFFICIENT_LIMIT, 0);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_EFFICIENT_DAY, 0);
		szMsg = "Số vàng mới của bạn <color=yellow>" .. nNewGoldLimit .. "<color> Đã có hiệu lực";
	else
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_UNEFFICIENT_LIMIT, nNewGoldLimit);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_EFFICIENT_DAY, nTime + self.EFFECITDAYS * self.DAYSECOND);
		szMsg = "Số vàng mới của bạn <color=yellow>" .. nNewGoldLimit .. "<color> sẽ được "..self.EFFECITDAYS.."	ngay sau đó.";
	end
	
	me.Msg(szMsg);
	me.CallClientScript({"Bank:UpdateInfo"});
end
Bank.tbc2sFun["ModifyGoldLimit"] = Bank.ModifyGoldLimit;

-- ���������������
function Bank:SilverSave(nValue)
	if (not nValue or 0 == Lib:IsInteger(nValue)) then
		return;
	end
	if (not nValue or nValue <= 0 or nValue > me.nCashMoney) then
		me.Msg("Số bạn nhập vào không đúng, xin vui lòng nhập lại.");
		return;
	end
	local nMoney = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_SUM) + nValue;
	if (nMoney > me.GetMaxCarryMoney()) then
		me.Msg("Bạn có mức tiền gửi hiện tại của bạc đạt đến số lượng tối đa cho phép để lưu trữ.");
		return;
	end
	me.CostMoney(nValue, Player.emKPAY_RESTOREBANK);
	me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_SUM, nMoney);
	
	local szMsg = "Bạn đã gửi bạc <color=yellow>" .. nValue .. "<color> .";
	me.Msg(szMsg);
	me.CallClientScript({"Bank:UpdateInfo"});
	
	szMsg = "Gửi bạc vào tiền trang: " .. nValue;
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_COINBANK, szMsg);
end
Bank.tbc2sFun["SilverSave"] = Bank.SilverSave;

-- ȡ����������
function Bank:SilverDraw(nSilverDrawCount)	
	if (not nSilverDrawCount or 0 == Lib:IsInteger(nSilverDrawCount)) then
		return;
	end
	local nSilverSum = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_SUM);
	if (not nSilverDrawCount or nSilverDrawCount <= 0 or nSilverDrawCount > nSilverSum) then
		me.Msg("Số bạn nhập vào không đúng, xin vui lòng nhập lại.");
		return;
	end	
	
	local nSilverLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_LIMIT);
	local nHaveDraw = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_TODAYTAKEOUTSILVERCOUNT);
	local nTime = GetTime();
	local nDate = me.GetTask(self.TASK_GROUP, self.TASK_ID_TAKEOUTSILVER_DATE);
	
	if (me.nCashMoney + nSilverDrawCount > me.GetMaxCarryMoney()) then
		me.Msg("Bạn không thể rút quá số tiền mình đã gửi.");
		return;	
	end
	
	if (nTime - nDate >= self.DAYSECOND) then
		if (nSilverDrawCount > nSilverLimit) then
			me.Msg("Bạn muốn loại bỏ bạc giới hạn ?");
			return;
		end
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_TAKEOUTSILVER_DATE, nTime);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_TODAYTAKEOUTSILVERCOUNT, nSilverDrawCount);
	else
		if ((nSilverDrawCount + nHaveDraw) > nSilverLimit) then
			local nCanDrawCount = nSilverLimit - nHaveDraw;
			if (nCanDrawCount < 0) then
				nCanDrawCount = 0;
			end
			local szMsg = "Bạn loại bỏ trong vòng 24 giờ so với giới hạn nhiều hơn, bạn cũng có thể loại bỏ lên đến: <color=yellow>" .. nCanDrawCount .. "<color> bạc."
			me.Msg(szMsg);
			return;
		end
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_TODAYTAKEOUTSILVERCOUNT, nHaveDraw + nSilverDrawCount);
	end	
	
	local nMoney = nSilverSum - nSilverDrawCount;	
	me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_SUM, nMoney);
	me.Earn(nSilverDrawCount, Player.emKEARN_DRAWBANK);
		
	local szMsg = "Bạn đã xóa thành công với: <color=yellow>" .. nSilverDrawCount .. "<color> giới hạn";
	me.Msg(szMsg);
	me.CallClientScript({"Bank:UpdateInfo"});
	
	szMsg = "Rút bạc: " .. nSilverDrawCount;
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_COINBANK, szMsg);
end
Bank.tbc2sFun["SilverDraw"] = Bank.SilverDraw;

-- ȡ��δ��Ч������֧ȡ����
function Bank:CancelSilverLimit()
	me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_EFFICIENT_DAY, 0);
	me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_UNEFFICIENT_LIMIT, 0);
	me.Msg("Bạn đã huỷ bỏ hiệu lực của bạc không giới hạn thu hồi.");	
	me.CallClientScript({"Bank:UpdateInfo"});
end
Bank.tbc2sFun["CancelSilverLimit"] = Bank.CancelSilverLimit;

-- �޸�����֧ȡ����
function Bank:ModifySilverLimit(nNewSilverLimit)
	if (not nNewSilverLimit or 0 == Lib:IsInteger(nNewSilverLimit)) then
		return;
	end
	if (not nNewSilverLimit or nNewSilverLimit <= 0 or nNewSilverLimit > Bank.MAX_MONEY) then
		me.Msg("Số bạn nhập vào không đúng, xin vui lòng nhập lại.");
		return;
	end
	local nOldSilverLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_LIMIT);
	local szMsg = "";
	local nTime = GetTime();
	
	if nNewSilverLimit <= nOldSilverLimit then
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_LIMIT, nNewSilverLimit);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_UNEFFICIENT_LIMIT, 0);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_EFFICIENT_DAY, 0);
		szMsg = "Bạn đã sửa giới hạn bạc mới: <color=yellow>" .. nNewSilverLimit .. "<color> đã có hiệu lực";
	else
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_UNEFFICIENT_LIMIT, nNewSilverLimit);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_EFFICIENT_DAY, nTime + self.EFFECITDAYS * self.DAYSECOND);
		szMsg = "Bạn đã sửa giới hạn bạc mới: <color=yellow>" .. nNewSilverLimit .. "<color> sẽ được "..self.EFFECITDAYS.." ó hiệu lực vào ngày";
	end
	
	me.Msg(szMsg);
	me.CallClientScript({"Bank:UpdateInfo"});
end
Bank.tbc2sFun["ModifySilverLimit"] = Bank.ModifySilverLimit;

-- �жϲ�ִ�н���Լ���������Ч����
function Bank:DoEfficient()
	self:DoGoldEfficient();
	self:DoSilverEfficient();
	me.CallClientScript({"Bank:UpdateInfo"});
end
Bank.tbc2sFun["DoEfficient"] = Bank.DoEfficient;

-- �жϲ�ִ�н�ҵ���Ч����,�������0ֵ,�Ѹ�ֵ��ֵΪĬ��ֵ
function Bank:DoGoldEfficient()
	local nEfficientTime = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_EFFICIENT_DAY);
	local nTime = GetTime();
		
	if (nEfficientTime > 0 and nTime >= nEfficientTime) then
		local nNewGoldLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_UNEFFICIENT_LIMIT);
		if (nNewGoldLimit == 0) then
			return 0;
		end
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_LIMIT, nNewGoldLimit);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_EFFICIENT_DAY, 0);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_UNEFFICIENT_LIMIT, 0);
	end	
	
	local nGoldLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_LIMIT);
	if (0 == nGoldLimit) then
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_LIMIT, Bank.DEFAULTCOINLIMIT);
	end
end

-- �жϲ�ִ����������Ч�������������0ֵ���Ѹ�ֵ��ֵΪĬ��ֵ
function Bank:DoSilverEfficient()
	local nEfficientTime = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_EFFICIENT_DAY);
	local nTime = GetTime();
	
	if (nEfficientTime > 0 and nTime >= nEfficientTime) then
		local nNewSilverLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_UNEFFICIENT_LIMIT);
		if (0 == nNewSilverLimit) then
			return 0;
		end
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_LIMIT, nNewSilverLimit);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_EFFICIENT_DAY, 0);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_UNEFFICIENT_LIMIT, 0);
	end
	
	local nSilverLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_LIMIT);
	if (0 == nSilverLimit) then
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_LIMIT, Bank.DEFAULTMONEYLIMIT);
	end
end
