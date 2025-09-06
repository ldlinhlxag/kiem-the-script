-- �ļ�������ibshop_logic.lua
-- �����ߡ���������
-- ����ʱ�䣺2009-09-28 10:49:00
-- ˵���� client,gameserver,gamecenter�����߼��ļ�


-- �ڴ����Ż�ȯ������¼�����Ʒ���ܼ�ֵ
-- ������������й����۴������Ʒ������Ŀ�Ͷ�Ӧ��Ʒ��Ϣ{{nWareId����Ʒid��, nCount��������}, ...}���Ƿ������Ż�ȯ
-- ���ؽ�������й����۵���Ʒid�������Լ�����ۿۣ�ע�⣺����ۿ���0.01�ı�����
-- 			 {{nWareId = XXX, nDiscountCount = XXX, nRebate = XXX}, ...}
-- ע�⣺�ڱ���������Ҫ�õ���Ʒ�Ļ�������ͨ��me.IbShop_GetWareInf(nWareId)����ȡgdpls��Ȼ����KItem.CreateTempItem(...)������Ʒ
function IbShop:CalculateAmount(tbWareList, bUse)
	if (not tbWareList or Lib:CountTB(tbWareList) == 0 ) then
		return;
	end
	
	assert(it);
	
	bUse = bUse or 0;
	local tbRet = {};
	
	local pVoucher = KItem.GetObjById(it.dwId);
	if (not pVoucher) then
		return;
	end
	local tbItemCanuseVoucher = {};
	local nDiscountRate = pVoucher.GetExtParam(2);	-- �Ż�ȯ���ۿۣ���extparam2��������
	for _, tbWareInfo in pairs(tbWareList) do
		-- ֻ�����Ż�ȯ���ۿ۱�ԭ���ۿ۵͵�ʱ�򣬲�ʹ���Ż�ȯ���д���
		if (nDiscountRate < tbWareInfo.nDiscountRate) then
			table.insert(tbItemCanuseVoucher, tbWareInfo);
		end
	end
	if (Lib:CountTB(tbItemCanuseVoucher) <= 0) then
		return;
	end
	
	local tbRet = Item:CalDiscount(it.szClass, tbItemCanuseVoucher);
	
	--�����Ż�ȯ����
	if bUse ~= 0 then
		local szVoucher = it.szName;
		local nRes = Item:DecreaseCouponTimes(it.szClass, tbRet);

		self:WriteLog(szVoucher, nRes, tbRet);

		if nRes == 0 then
			return 0, {};
		end
	end
	
	return Lib:CountTB(tbRet), tbRet;
end


-- ��¼log
function IbShop:WriteLog(szVoucher, nRes, tbRet)
	local szLog = "";
	local szUseResult = (nRes == 0) and "ʧ��" or "�ɹ�";
	szLog = string.format("�۳��Ż�ȯ��%s�� %s ", szVoucher, szUseResult);
	if (0 == Lib:CountTB(tbRet)) then
		szLog = szLog .. "û�ж��κ���Ʒ�����Ż�";
	else
		for _, tbInfo in pairs(tbRet) do
			local tbWareInfo = me.IbShop_GetWareInf(tbInfo[1]);
			local tbBaseProp = KItem.GetItemBaseProp(tbWareInfo.nGenre, tbWareInfo.nDetailType, tbWareInfo.nParticular,
														tbWareInfo.nLevel);
			local szWareName = tbBaseProp.szName;
			szLog = szLog .. string.format("�� %s �� %s ��ٷ�֮ %s ���ۿ�",
											tbInfo[2], szWareName, tbInfo[3]);
		end
	end
	
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_USEGOLDCOIN_APP, szLog);
end
if (MODULE_GC_SERVER) then

-- ÿִ��һ������ibshopָ���ָ���¼����������gc�رյ�ʱ�������
function IbShop:SaveIbshopCmd(tbCmd, bSave)
	if (not tbCmd or Lib:CountTB(tbCmd) <= 1) then
		return;
	end

	-- ���ֻ�ǵ������޸��ۿۣ���ô����ۿ���100%�Ļ��Ͳ����޸���
	if (not tbCmd.WareId) then
		return;
	end
	
	if (not self.tbIbshopCmdBuff) then
		self.tbIbshopCmdBuff = {};
	end
	
	-- ��Ҫ�ж�buff�����Ƿ��Ѿ���������ָ����û�п���ֱ��д��
	-- ����Ѿ����ˣ�������ֶ��Ժ�����ָ��Ϊ׼�����޸�
	if (not self.tbIbshopCmdBuff[tbCmd.WareId]) then
		self.tbIbshopCmdBuff[tbCmd.WareId] = tbCmd;
	else			
		for szKeyName, szValue in pairs(tbCmd) do			
			self.tbIbshopCmdBuff[tbCmd.WareId][szKeyName] = szValue;			
		end		
	end
	
	if (bSave and bSave == 1) then
		IbShop:SaveBuf();
	end
	
	return 1;
end

-- gc����ʱ��ִ�д�buff���ж�ȡ����ָ��
function IbShop:ExecuteIbshopCmdBuf(tbIbshopCmdBuff)
	if (not tbIbshopCmdBuff or Lib:CountTB(tbIbshopCmdBuff) == 0) then
		return;
	end
	for _, tbCmd in pairs(tbIbshopCmdBuff) do
		if (self.tbPreloadWareInfo[tbCmd["WareId"]]) then
			ModifyIBWare(tbCmd);
		end
	end
end

end -- if (MODULE_GC_SERVER) then

function IbShop:ParseTime(szTime)	
	local tb1 = Lib:SplitStr(szTime, " ");
	local szTime = "";
	for _, v in ipairs(tb1) do
		szTime = szTime .. v;
	end
	local tb2 = Lib:SplitStr(szTime, "-");
	local szTime = "";
	for _, v in ipairs(tb2) do
		szTime = szTime .. self:ParseFormat(v);
	end
	local tb3 = Lib:SplitStr(szTime, ":");
	local szTime = "";
	for _, v in ipairs(tb3) do
		szTime = szTime .. self:ParseFormat(v);
	end
	return tonumber(szTime);
end

function IbShop:ParseFormat(szTime)
	if (string.len(szTime) < 2) then
		szTime = string.format("%s%s", 0, szTime);
	end
	return szTime;
end
