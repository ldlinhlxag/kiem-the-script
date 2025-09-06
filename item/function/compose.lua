
-- �����ϳɹ��ܽű�

------------------------------------------------------------------------------------------
local COMITEM_CLASS = "xuanjing";	-- �������ͣ�����
local PEEL_ITEM = { nGenre = Item.SCRIPTITEM, nDetail = 1, nParticular = 1 };	-- ����

-- ���ȼ���������Ϣ��
local tbCrystal;

local function InitCrystalTable(tbComItem)
	tbCrystal = {};
	for i = 1, 12 do
		tbCrystal[i] = KItem.GetItemBaseProp(18, 1, 1, i);
	end 
end

-- ����ϳɼ�ֵԤ��(����˿ͻ��˹���)
function Item:GetComposeBudget(tbComItem, nMoneyType)
	local nTotalValue = 0;
	local bBind = 0;
	if not tbCrystal then
		InitCrystalTable();
	end
	local nTime = 0;
	local tbAbsTime;
	local tbCalcuate = {};
	for i, pItem in pairs(tbComItem) do
		nTotalValue = nTotalValue + pItem.nValue;
		if pItem.IsBind() == 1 then	-- ��һ�����������
			bBind = 1;
		end
		if pItem.szClass ~= COMITEM_CLASS then
			return 0;
		end
		local tbTime = me.GetItemAbsTimeout(pItem);
		if tbTime then
			local nNewTime = tbTime[1] * 100000000 + tbTime[2] * 1000000 + 
				tbTime[3] * 10000 + tbTime[4] * 100 + tbTime[5];
			if nTime == 0 or nNewTime < nTime then
				nTime = nNewTime;
				tbAbsTime = tbTime;
			end
		end
		local szName = pItem.szName
		if not tbCalcuate[szName] then
			tbCalcuate[szName] = 0;
		end
		tbCalcuate[szName] = tbCalcuate[szName] + 1;
	end
	local szLog = ""
	if MODULE_GAMESERVER then
		for szName, nCount in pairs(tbCalcuate) do
			szLog = szLog..szName..nCount.."��  ";
		end
	end
	local nMinLevel = 0;
	for i = 1, 12 do
		if nTotalValue >= tbCrystal[i].nValue then
			nMinLevel = i;
		end
	end
	local nFee = math.ceil(nTotalValue / 10 * self:GetJbPrice());
	
	local nMinLevelRate = 0;
	local nMaxLevelRate = 0
	if nMinLevel >= 12 then
		nMinLevel = 11;
		nMinLevelRate = 0;
		nMaxLevelRate = 1;
	else
		nMinLevelRate = tbCrystal[nMinLevel + 1].nValue - nTotalValue;
		nMaxLevelRate = nTotalValue - tbCrystal[nMinLevel].nValue;
	end
	if (bBind == 0) and (nMoneyType == Item.BIND_MONEY) then
		bBind = 1;
	end
	return nMinLevel, nMinLevelRate, nMinLevel + 1, nMaxLevelRate, nFee, bBind, tbAbsTime, szLog;
end

function Item:Compose(tbComItem, nMoneyType, nParam)
	if (me.nFightState ~= 0) then
		me.Msg("ս��״̬�²��ܽ��д˲�����");
		return 0;
	end
	
	local nIbValue = 0;
	local nMinLevel, nMinLevelRate, nMaxLevel, nMaxLevelRate, nFee, bBind, tbAbsTime, szLog = Item:GetComposeBudget(tbComItem, nMoneyType);
	
	if nMinLevel < 1 then
		me.Msg("���ܺϳɣ��ϳ������з��������ߣ�")
		return 0;
	end
	
	-- �ϳ����������鱳���ռ��ǰ�����������ɵ��ӣ�����ɵ�����Ҫ��鱳���ռ�
	-- TODO
	if (nMoneyType == Item.NORMAL_MONEY and me.CostMoney(nFee, Player.emKPAY_COMPOSE) ~= 1) then	-- �۳���Ǯ
		me.Msg("�������������㣬���ܺϳɣ�");
		return 0;
	elseif (nMoneyType == Item.BIND_MONEY and me.CostBindMoney(nFee, Player.emKBINDMONEY_COST_COMPOSE) ~= 1) then
		me.Msg("�����ϵİ��������㣬���ܺϳɣ�");
		return 0;
	elseif (nMoneyType ~= Item.NORMAL_MONEY)and (nMoneyType ~= Item.BIND_MONEY) then
		return 0;
	end
	
	if nMoneyType == Item.NORMAL_MONEY then
		KStatLog.ModifyAdd("jxb", "[����]�����ϳ�", "����", nFee);
	end
	
	if nMoneyType == Item.BIND_MONEY then
		KStatLog.ModifyAdd("bindjxb", "[����]�����ϳ�", "����", nFee);
	end
	
	--if nMoneyType == Item.NORMAL_MONEY then
	--	nIbValue = nIbValue + nFee / Spreader.ExchangeRate_Gold2Jxb;
	--end
	
	local szSucc = "�ɹ���:"..nMaxLevelRate.."/"..(nMinLevelRate + nMaxLevelRate).."�ĸ����ܺϳ�"..nMaxLevel.."������";
	Dbg:WriteLog("Compose", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "ԭ��:"..szLog, szSucc);
	
	-- ɾ������
	for i = 1, #tbComItem do
		if tbComItem[i].nBuyPrice > 0 then -- ��Ib��ֵ��
			nIbValue = nIbValue + tbComItem[i].nBuyPrice; -- Ib��ֵ��Ȼ���ڷǰ�������
		end

		local szItemName = tbComItem[i].szName;
		local nRet = me.DelItem(tbComItem[i], Player.emKLOSEITEM_TYPE_COMPOSE);		-- �۳�����
		if nRet ~= 1 then
			Dbg:WriteLog("Compose", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "�۳�"..szItemName.."ʧ��");
			return 0;
		end
	end
	
	local nRandom = Random(nMinLevelRate + nMaxLevelRate);
	local nResultLevel = 0;
	if nRandom < nMinLevelRate then
		nResultLevel = nMinLevel;
	else
		-- �ϳ��˽ϸ߼�������
		nResultLevel = nMaxLevel;
	end
	-- ��������
	local pItem;
	local tbGive = {}
	tbGive.bForceBind = bBind;
	if tbAbsTime then
		tbGive.bTimeOut = 1;
	end
	pItem = me.AddItemEx(PEEL_ITEM.nGenre, PEEL_ITEM.nDetail, PEEL_ITEM.nParticular, nResultLevel, tbGive, Player.emKITEMLOG_TYPE_COMPOSE);
	if pItem and tbAbsTime then
		local nTime = os.time({year = tbAbsTime[1], month=tbAbsTime[2], day=tbAbsTime[3], hour=tbAbsTime[4], min=tbAbsTime[5]});
		me.SetItemTimeout(pItem, os.date("%Y/%m/%d/%H/%M/00", nTime));
	end
	if not pItem then
		-- ��������ʧ�ܣ��Ǹ�log��
		Dbg:WriteLog("Compose", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount,"����"..nResultLevel.."������ʧ�ܣ�");
		return 0;
	else
		Dbg:WriteLog("Compose", "��ɫ��:"..me.szName, "�ϳ�һ��"..pItem.szName);
	end

	if bBind ~= 1 then
		pItem.nBuyPrice = nIbValue;
	else
		Spreader:AddConsume(nIbValue);
	end

	return nResultLevel;
end

