--激活码认证卡
--孙多良
--2008.10.16
if not MODULE_GAMESERVER then
	return 0;
end

Require("\\script\\event\\presendcard\\presendcard_def.lua");

function PresendCard:MyCoinCardCheck(nFlag, szCDKey)
	if not nFlag then
		Dialog:AskString("Hãy nhập mã: ", 32, self.MyCoinCardCheck, self, 1);
		return 0;
	end
	if (nFlag ~= 1) then
		return 0;
	end
	if not szCDKey or szCDKey == "" or string.len(szCDKey) > 30 then
		me.Msg(szCDKey);
		Dialog:Say("Mã nạp đồng của ngươi không đúng đừng lừa ta.");
		return 0;
	end
	local nRet = me.HaveJbCard(szCDKey);
	if (nRet == 0) then
		Dialog:Say("Mã nạp không hợp lệ hoặc đã được sử        dụng, xin vui lòng kiểm tra lại hoặc liên hệ yahoo: <color=red>gm_hackiem<color> để được trợ giúp.\n\n <color=red>Hình Thức Nạp Thẻ Mới :<color>\n Lưu ý: Nếu có chương trình khuyến mại    nạp thẻ hình thức này sẽ tạm mất\n\n <color=yellow>     1, Nạp thẻ 20.000 nhận ngay :<color>\n 1 lệnh bài chúc phúc cao \n + thêm 20 vạn đồng khóa\n <color=yellow>     2, Nạp thẻ 50.000 nhận ngay :<color>\n Du long danh vọng lệnh Giày\n + thêm 50v đồng khóa\n     <color=yellow>3, Nạp thẻ 100.000 nhận ngay :<color>\n Du long danh vọng lệnh Mũ\n Bạn đồng hành 4 skill \n + thêm 100 vạn đồng khóa\n     <color=yellow>4, Nạp thẻ 200.000 nhận ngay :<color>\n Du long Danh vọng Hộ Thân Phù \n 3 Lệnh Bài Chúc Phúc Cao\n + thêm 200 vạn đồng khóa\n     <color=yellow>5, Nạp thẻ 500.000 nhận ngay :<color>\n Danh Vọng Lệnh Áo và Lưng \n 5 Lệnh Bài Chúc Phúc Cao\n + thêm 500 vạn đồng khóa\n<color>");
	else
		me.AddJbCoin(nRet);
		Dialog:Say(nRet.." đồng đã được chuyển vào tài khoản, hãy kiểm tra lại hành trang của mình. \n\n <color=red>Hình Thức Nạp Thẻ Mới :<color>\n Lưu ý: Nếu có chương trình khuyến mại    nạp thẻ hình thức này sẽ tạm mất\n\n <color=yellow>     1, Nạp thẻ 20.000 nhận ngay :<color>\n 1 lệnh bài chúc phúc cao \n + thêm 20 vạn đồng khóa\n <color=yellow>     2, Nạp thẻ 50.000 nhận ngay :<color>\n Du long danh vọng lệnh Giày\n + thêm 50v đồng khóa\n     <color=yellow>3, Nạp thẻ 100.000 nhận ngay :<color>\n Du long danh vọng lệnh Mũ\n Bạn đồng hành 4 skill \n + thêm 100 vạn đồng khóa\n     <color=yellow>4, Nạp thẻ 200.000 nhận ngay :<color>\n Du long Danh vọng Hộ Thân Phù \n 3 Lệnh Bài Chúc Phúc Cao\n + thêm 200 vạn đồng khóa\n     <color=yellow>5, Nạp thẻ 500.000 nhận ngay :<color>\n Danh Vọng Lệnh Áo và Lưng \n 5 Lệnh Bài Chúc Phúc Cao\n + thêm 500 vạn đồng khóa\n<color>");
	end
	
PresendCard.tbItemInfo = {
        bForceBind=1,
};  
	if nRet == 100000 then
	me.AddItem(18,1,212,3);
	me.AddBindCoin(200000);
	end
	if nRet == 250000 then
	me.AddItem(18,1,529,5);
	me.AddBindCoin(500000);
	end
	if nRet == 500000 then
	me.AddItem(18,1,529,2);
	me.AddItem(18,1,666,4);
	me.AddBindCoin(1000000);
	end
	if nRet == 1000000 then
	me.AddItem(18,1,529,1)
	me.AddItem(18,1,212,3);
	me.AddItem(18,1,212,3);
	me.AddItem(18,1,212,3);
	me.AddBindCoin(2000000);
	
	end
	if nRet == 2500000 then
	me.AddItem(18,1,529,3)
	me.AddItem(18,1,529,4)
	me.AddItem(18,1,666,8);
	me.AddItem(18,1,212,3);
	me.AddItem(18,1,212,3);
	me.AddItem(18,1,212,3);
	me.AddItem(18,1,212,3);
	me.AddItem(18,1,212,3);
	me.AddBindCoin(5000000);
	end
end

function PresendCard:ErrorCard(nResult)
	local szMsg = self.RESULT_DESC[nResult] or "Nạp thất bại";
	Dialog:Say(szMsg);
end

--nPresentType:类型
--nResult:1代表成功，2代表失败，3代表帐号不存在，1009代表传入的参数非法或为空，1500代表礼品序列号不存在，1501礼品已被使用,1502礼品已过期
function PresendCard:VerifyResult(nPresentType, nResult)
	me.AddWaitGetItemNum(-1);
	if self.PRESEND_TYPE[nPresentType] then
		if nResult ~= 1 then
			Lib:CallBack({self.PRESEND_TYPE[0][self.INDEX_CALLBACKFUNC], nResult})
		else
			if self.PRESEND_TYPE[nPresentType][self.INDEX_CALLBACKFUNC] then
				Lib:CallBack({self.PRESEND_TYPE[nPresentType][self.INDEX_CALLBACKFUNC], nResult});
			else
				self:OnCheckResult(nPresentType,nResult);
			end
		end
	end
	
end

function PresendCard:OnDialogCard(nFlag, szCDKey)
	if not nFlag then
		Dialog:AskString("Hãy nhập mã nạp đồng: ", 20, self.OnDialogCard, self, 1);
		return 0;
	end
	
	if (nFlag ~= 1) then
		return 0;
	end

	szCDKey = string.upper(szCDKey);

	local szKeyFlag = self:GetCDKeyFlag(szCDKey);
	
	local nPresentType = self:GetTypeByKeyFlag(szKeyFlag);	
	
	local tbInfo = self.PRESEND_TYPE[nPresentType];
	if (not tbInfo) then
		Dialog:Say(string.format("Mã nạp không hợp lệ."));
		return 0;
	end
	
	--增加网关判断
	if self:CmpGateWay(nPresentType) == 0 then
		Dialog:Say(string.format("Mã kích hoạt có thể không sử dụng được nữa, hãy thử lại."));
		return 0;
	end
	
	
	if (tbInfo[self.INDEX_STARTTIME]) then
		local nNowDay = tonumber(GetLocalDate("%Y%m%d"));
		if (nNowDay >= tbInfo[self.INDEX_STARTTIME]) then
			if (tbInfo[self.INDEX_ENDTIME] and tbInfo[self.INDEX_ENDTIME] > 0 and nNowDay > tbInfo[self.INDEX_ENDTIME]) then
				Dialog:Say(string.format("%s活动已经结束。", tbInfo[self.INDEX_NAME]));
				return 0;
			end
		elseif (nNowDay > 0 and nNowDay < tbInfo[self.INDEX_STARTTIME]) then
			Dialog:Say(string.format("%s活动还未开始！", tbInfo[self.INDEX_NAME]));
			return 0;
		end
	end	

	if (not tbInfo[self.INDEX_TASKGROUP] or not tbInfo[self.INDEX_TASKID]) then
		return 0;
	end

	--任务变量为0则表示不需要判断
	--如果该角色已经激活了
	if tbInfo[self.INDEX_TASKGROUP] ~= 0 or tbInfo[self.INDEX_TASKID] ~= 0 then
		if me.GetTask(tbInfo[self.INDEX_TASKGROUP], tbInfo[self.INDEX_TASKID]) > 0 then
			Dialog:Say(string.format("您已经激活过并领取过%s活动奖励", tbInfo[self.INDEX_NAME]));
			return 0;
		end
	end
	
	local nCount = tbInfo[self.INDEX_COUNT];
	if (me.CountFreeBagCell() < nCount) then
		Dialog:Say(string.format("Hành trang không đủ chỗ trống."));
		return 0;
	end

	local szMsg = string.format("您现在激活的是<color=yellow>%s<color>活动奖励，您确定要领取吗？", tbInfo[self.INDEX_NAME]);
	local tbOpt = {
		{"Tôi chắc chắn mã đúng", self.OnCheckKey, self, nPresentType, szCDKey},
		{"Để tôi xem lại."},
	}
	Dialog:Say(szMsg, tbOpt);
end

function PresendCard:GetTypeByKeyFlag(szKey)
	if (not szKey) then
		return -1;
	end
	for nType, tbInfo in pairs(self.PRESEND_TYPE) do
		if (tbInfo[self.INDEX_CDKEYFLAG] and tbInfo[self.INDEX_CDKEYFLAG] == szKey) then
			return nType;
		end
	end
	return -1;
end

function PresendCard:OnCheckKey(nPresentType, szCDKey)
	--检查激活码
	--if not szCDKey or szCDKey == "" or string.len(szCDKey) > 20 or string.len(szCDKey) < 10 then
	--	Dialog:Say("输入激活码的长度不符合要求。");
	--	return 1;
	--end
	
	--- todo 大小写转换
	szCDKey = string.upper(szCDKey);
	
	local tbInfo = self.PRESEND_TYPE[nPresentType];
	if (not tbInfo) then
		Dialog:Say("这个礼包不存在，请与系统管理员联系！");
		return 0;
	end

	if (not tbInfo[self.INDEX_CDKEYFLAG]) then
		return 0;
	end

	local szKeyFlag = self:GetCDKeyFlag(szCDKey);

	if (tbInfo[self.INDEX_CDKEYFLAG] and (not szKeyFlag or tbInfo[self.INDEX_CDKEYFLAG] ~= szKeyFlag)) then
		Dialog:Say("这个激活码不能验证，不是这个活动的激活码！");
		return 0;
	end

	if tbInfo[self.INDEX_OTHER] then
		Lib:CallBack({tbInfo[self.INDEX_OTHER], szCDKey});
	end

	-- test
	
--	self:VerifyResult(nPresentType, 1);
--	me.AddWaitGetItemNum(1);



	if (self._FLAG_TEST[nPresentType] and self._FLAG_TEST[nPresentType] == 1) then
		self:VerifyResult(nPresentType, 1);
		Dbg:WriteLog("PresendCard",  "OnCheckKey", me.szName, szCDKey, "目前的激活码机制状态是测试状态，不通过正常渠道走激活流程，请慎重使用！");		
		return 1;
	end


	if SendPresentKey(szCDKey) == 1 then
		me.AddWaitGetItemNum(1);
		return 1;
	end

	Dialog:Say("输入的激活码不符合要求。");
end

-- 这样有个缺陷，今后将会定死这个生成激活码规则
function PresendCard:GetCDKeyFlag(szCDKey)
	for i, tbInfo in pairs(self.PRESEND_TYPE) do
		if (i >= 2 and tbInfo) then
			local tbKeySer = tbInfo[self.INDEX_KEYINDEX];
			if (tbKeySer) then
				local szFlag = "";
				for _, nNum in ipairs(tbKeySer) do
					local szOneKey = string.sub(szCDKey, nNum, nNum);
					if (not szOneKey) then
						break;
					end
					szFlag = string.format("%s%s", szFlag, szOneKey);
				end
				if (szFlag ~= "" and szFlag == tbInfo[self.INDEX_CDKEYFLAG]) then
					return szFlag;
				end
			end
		end
	end
	
	return nil;
end


function PresendCard:OnCheckResult(nPresentType,nResult)
	if nResult == 1 then
		self:OnGetAward(nPresentType);
		return 1;
	end
	Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");
end


function PresendCard:OnCheckResult_LX(nResult)
	if nResult == 1 then
		self:OnGetAward(2);
		return 1;
	end
	Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");
end

function PresendCard:OnCheckResult_JN(nResult)
	if nResult == 1 then
		self:OnGetAward(3);
		return 1;
	end
	Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");	
end

function PresendCard:OnCheckResult_DL(nResult)
	if nResult == 1 then
		self:OnGetAward(4);
		return 1;
	end
	Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");	
end

function PresendCard:OnCheckResult_YY(nResult)
	if nResult == 1 then
		if not me.GetTempTable("Player").tbPresend or type(me.GetTempTable("Player").tbPresend) ~= "string" then
			Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");	
			print("error ,OnCheckResult_YY ");
			return;
		end
		local szPresend = me.GetTempTable("Player").tbPresend;
		local nSecType = self.PresendCardParamYY[szPresend];
		if not nSecType then
			Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");	
			return;
		end		
		self:OnGetAward(6,nSecType);
		me.GetTempTable("Player").tbPresend = nil;
		return 1;
	end
	me.GetTempTable("Player").tbPresend = nil;
	Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");		
end

function PresendCard:OnCheckBefore_YY(szCDKey)
	me.GetTempTable("Player").tbPresend = string.sub(szCDKey,3,4);
end

function PresendCard:OnCheckResult_MLXS(nResult)
	if nResult == 1 then
		self:OnGetAward(2000);
		return 1;
	end
	Dialog:Say(self.RESULT_DESC[nResult] or "激活码异常");	
end

function PresendCard:OnGetAward(nPresentType, nSecondType)
	local tbInfo = self.PRESEND_TYPE[nPresentType];
	if (not tbInfo) then
		Dbg:WriteLog("PresendCard",  "OnGetAward", me.szName,  string.format("%d号这个礼包不存在，请与系统管理员联系", nPresentType));
		Dialog:Say("这个礼包不存在，请与系统管理员联系！");
		return 0;
	end
	
	if (not tbInfo[self.INDEX_TASKGROUP] or not tbInfo[self.INDEX_TASKID]) then
		return 0;
	end
	
	if (not tbInfo[self.INDEX_ITEMTABLE] or type(tbInfo[self.INDEX_ITEMTABLE]) ~= "table") then
		Dbg:WriteLog("PresendCard",  "OnGetAward", me.szName,  string.format("%d号这个礼包有问题", nPresentType));
		Dialog:Say("这个礼包不存在，请与系统管理员联系！");
	end
	
	local pItem = me.AddItem(unpack(tbInfo[self.INDEX_ITEMTABLE]));
	if (not pItem) then
		Dbg:WriteLog("PresendCard",  "OnGetAward", me.szName,  string.format("获得大礼包失败!"));
		return 0;
	end
	pItem.SetCustom(Item.CUSTOM_TYPE_MAKER, tbInfo[self.INDEX_NAME] or "");
	pItem.SetGenInfo(1,nPresentType);
	if nSecondType then
		pItem.SetGenInfo(2,nSecondType);
	end
	pItem.SetTimeOut(0, (GetTime() + self.ITEM_TIMEOUT)); -- 加过期时间
	pItem.Sync();  	
	
	local nTaskGroup 	= tonumber(pItem.GetExtParam(1));
	local nTaskId		= tonumber(pItem.GetExtParam(2));
	local nNum			= self:SetPresentTypeFlag(0, nPresentType);
	if nTaskId ~= 0 and nTaskGroup ~= 0 then
		me.SetTask(nTaskGroup, nTaskId, nNum);
	end
	if tbInfo[self.INDEX_TASKGROUP] ~= 0 and tbInfo[self.INDEX_TASKID] ~= 0 then
		me.SetTask(tbInfo[self.INDEX_TASKGROUP], tbInfo[self.INDEX_TASKID], GetTime());
	end
	Dbg:WriteLog("PresendCard",  "OnGetAward", me.szName,  string.format("激活了%s礼包，并获得了大礼包一份", tbInfo[self.INDEX_NAME]));
end

function PresendCard:SetPresentTypeFlag(nResult, nPresentType)
	local nTempA = math.floor(nPresentType / 16);
	local nTempB = math.fmod(nPresentType, 16);
	local nResult = KLib.SetByte(nResult, 4, nTempB);
	nResult = KLib.SetByte(nResult, 3, nTempA);
	return nResult;
end

function PresendCard:GetPresentTypeFlag(nFlag)
	local nTempA = KLib.GetByte(nFlag, 3);
	local nTempB = KLib.GetByte(nFlag, 4);
	local nResult = nTempB + nTempA * 16;
	return nResult;
end

function PresendCard:_SetTestFlag(nPresentType, nFlag)
	self._FLAG_TEST[nPresentType] = nFlag;
	return;
end

function PresendCard:_GetTestFlag(nPresentType)
	return self._FLAG_TEST[nPresentType] or 0;
end


function PresendCard:CmpGateWay(nPresentType)
	local szWay = self.PRESEND_TYPE[nPresentType][self.INDEX_GATEWAYLIMIT];
	if not szWay then
		return 1;
	end
	
	local szGate =  GetGatewayName();	
	local bSuit = 0;
	local tbWay = Lib:SplitStr(szWay);
	for _, szStr in ipairs(tbWay) do
		if szGate == szStr then
			bSuit = 1;
			break;
		end
	end
	return bSuit;
end






--BUF 相关
function PresendCard:GetGblBuf()
	local tbBuf = GetGblIntBuf(GBLINTBUF_PRESENDCARD, 0, 1);
	if tbBuf and type(tbBuf)=="table"  then
		self.tbGblBuf = tbBuf;
	end
	if not self.tbGblBuf then
		self.tbGblBuf = {};
	end
	return self.tbGblBuf;	
end

function PresendCard:ReLoadBuf()
	if not self.PRESEND_TYPE_BAK then	
	 	self.PRESEND_TYPE_BAK = Lib:CopyTB1(self.PRESEND_TYPE);
	 end

	local tbBuf = self:GetGblBuf();

	self.PRESEND_TYPE = Lib:CopyTB1(self.PRESEND_TYPE_BAK);
	for nType, tbInfo in pairs(tbBuf) do
		self.PRESEND_TYPE[nType] = tbInfo;
	end	
end

ServerEvent:RegisterServerStartFunc(PresendCard.ReLoadBuf, PresendCard);