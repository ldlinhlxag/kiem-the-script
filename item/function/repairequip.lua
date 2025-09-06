
-- װ�������ܽű�

local REPAIR_ITEM_CLASS	= "jinxi";				-- ��������Ʒ����Ϭ
------------------------------------------------------------------------------------------
--define
Item.DUR_COST_PER_YEAR = (2 / 5) * 3600 * 6 * 365 / 20;		--ÿ����6Сʱ,һ��365�����ĵ��;����޵���
Item.EQUIP_TOTAL_RATE = 4 * 1 + 1.5 * 4 + 1 * 5;			-- ����װ���ܱ��� ����*4������*1.5������*1
Item.ALL_EQUIP_MIN_VALUE = 5000000							-- ȫ��װ����ֵ����Сֵ��500W��
Item.ALL_EQUIP_MAX_VALUE = 500000000						-- ȫ��װ����ֵ�����ֵ��50000W��
Item.VALUEPERCEN_PER_YEAR = 0.3								-- ȫ������������ܼ�ֵ���� 30%

------------------------------------------------------------------------------------------
-- interface

function Item:CommonRepair()					-- ����ص��ӿڣ���ͨ����

	-- �Ƿ��������
	if (it.IsEquip() ~= 1) then					-- ����װ���Ͳ���
		return	0;
	end
	if (it.nCurDur >= it.nMaxDur) then			-- ����Ҫ����
		return	0;
	end

	-- ��Ǯ
	local nPrice = self:CalcCommonRepairPrice(it);
	if (me.nCashMoney < nPrice) then			-- Ǯ��������
		me.Msg("�������㣡");
		return	0;
	end
	if (me.CostMoney(nPrice, Player.emKPAY_REPAIR) ~= 1) then				-- ��Ǯʧ�ܣ��쳣����
		me.Msg("�������㣡");
		return	0;
	end
	if nPrice > 0 then
		KStatLog.ModifyAdd("jxb", "[����]װ������", "����", nPrice);
	end
	local nOldMax = math.floor(it.nMaxDur / 10);

	if (it.nMaxDur <= Item.DUR_WARNING) then	-- ����;�̫�ͣ�������ʾ
		if (MathRandom(100) < 30) then			-- 30%�ļ�����
			it.nMaxDur = 0;
			it.nCurDur = 0;
			me.Msg("����<"..it.szName..">�Ѿ��𻵣�������޸���������;ò��ܼ���ʹ�á�");
			return	1;
		end
	else
		local nMaxDur = self:CalcCommentDurReduce(it);
		if nMaxDur <= Item.DUR_WARNING then
			nMaxDur = Item.DUR_WARNING;
		end
		it.nMaxDur = nMaxDur;	-- ��������;�
	end

	if (it.nMaxDur <= Item.DUR_WARNING) then
		me.Msg("����<"..it.szName..">��ǰ����;��Ѿ���������ͼ��ޣ�����ʱ�п����𻵣�����Ҫ��<��Ϭ>�������Իָ���ǰ����;á�");
	end

	it.nCurDur = it.nMaxDur;	-- ��������
	local nDelta = nOldMax - math.floor(it.nMaxDur / 10);
	me.Msg("���ġ�"..it.szName.."���Ѿ��޸�������;��½���"..nDelta.."�㡣");
	return	1;

end

function Item:SpecialRepair()					-- ����ص��ӿڣ���������

	-- �Ƿ��������
	if (it.IsEquip() ~= 1) then					-- ����װ���Ͳ���
		return	0;
	end

	local nPrice = self:CalcSpecialRepairPrice(it);
	if (nPrice <= 0) then		-- ����Ҫ����
		return	0;
	end

	-- ��Ǯ
	if (me.CostBindMoney(nPrice, Player.emKBINDMONEY_COST_REPAIR2) ~= 1) then
		if (me.nCashMoney + me.GetBindMoney() < nPrice) then
			me.Msg("�����ϵ��������㣡");
			return -1;
		else
			local nBindMoney = me.GetBindMoney();
			me.CostBindMoney(nBindMoney, Player.emKBINDMONEY_COST_REPAIR2);
			me.CostMoney(nPrice - nBindMoney, Player.emKPAY_REPAIR2);
			KStatLog.ModifyAdd("bindjxb", "[����]װ������", "����", nBindMoney);
			KStatLog.ModifyAdd("jxb", "[����]װ������", "����", nPrice - nBindMoney);
		end
	else
		KStatLog.ModifyAdd("bindjxb", "[����]װ������", "����", nPrice);
	end

	-- �������
	it.nMaxDur = Item.DUR_MAX;					-- ��������;�
	it.nCurDur = it.nMaxDur;					-- ������ǰ�;�
	me.Msg("���ġ�"..it.szName.."������;��Ѿ��޸���");
	return	1;

end

function Item:ItemRepair(pUseItem)				-- ����ص��ӿڣ�ʹ�õ�������

	if (pUseItem.szClass ~= REPAIR_ITEM_CLASS) then
		return;									-- ������������Ʒ����������
	end

	-- ��������Ч�ԣ���ֹBUG
	local nItemDur = pUseItem.GetGenInfo(1);	-- ȡ��������Ʒ�;�
	if (nItemDur <= 0) then
		me.DelItem(pUseItem, Player.emKLOSEITEM_REPAIR);
	end

	-- �Ƿ��������
	if (it.IsEquip() ~= 1) then					-- ����װ���Ͳ���
		return	0;
	end

	-- �۵����;�
	local nPrice, nAddDur = self:CalcItemRepairPrice(it, nItemDur);
	if (nPrice < 0) then
		me.Msg("����װ������;�����������Ҫ����");
		return	0;
	end

	if (nAddDur <= 0) then
		me.Msg("���Ľ�Ϭ�;ò��㣡");
		return	0;
	end

	nItemDur = nItemDur - nPrice;

	if (nItemDur <= 0) then
		if me.DelItem(pUseItem, Player.emKLOSEITEM_REPAIR) ~= 1 then					-- ����;ü���0��۳���������Ʒ
			return 0;
		end
	else
		pUseItem.SetGenInfo(1, nItemDur);		-- �������;�
		pUseItem.Sync();
	end

	-- �������
	local nMaxDur = it.nMaxDur + nAddDur;		-- ��������;�
	if (nMaxDur > Item.DUR_MAX) then
		nMaxDur = Item.DUR_MAX;
	end
	it.nMaxDur = nMaxDur;
	it.nCurDur = it.nMaxDur;					-- ������ǰ�;�
	me.Msg("���ġ�"..it.szName.."������;��޸���"..nAddDur.."�㡣");
	return	1;

end

function Item:CalcCommonRepairPrice(pEquip)		-- ������ͨ�����Ǯ(JXB)
	return	0;									-- ���޲�ҪǮ
end

function Item:CalcCommentDurReduce(pEquip)		-- ������ͨ����������;�
	return pEquip.nMaxDur - math.ceil((pEquip.nMaxDur - pEquip.nCurDur) / 20);
end

function Item:CalcSpecialRepairPrice(pEquip)	-- �������������Ǯ(JXB)
	local nCurMaxDur = self:CalcCommentDurReduce(pEquip);
	local nAddDur = Item.DUR_MAX - nCurMaxDur;
	local nMoneyCostPerDur = self:CalcSpecialRepairCoin(pEquip) * self:GetJbPrice() * 100;	--����ÿ���;�������Ҫ����������
	if (nAddDur <= 0) then
		return -1;
	end
	return	math.max(math.ceil(nAddDur * nMoneyCostPerDur), 1);
end

function Item:CalcItemRepairPrice(pEquip, nItemDur)	-- �������������Ǯ(��������Ʒ���;�)
	local nCurMaxDur = self:CalcCommentDurReduce(pEquip);
	local nLostDur = Item.DUR_MAX - nCurMaxDur;
	local nAddDur  = nLostDur;
	local JINXI2COIN 	= 10000/600;	--600���10000���Ϭ�;�
	local JINXIAGIO		= 0.8;			--������Ϭ����,��8��
	if (nLostDur <= 0) then
		return -1;
	end
	local nItemDurCostPerDur = self:CalcSpecialRepairCoin(pEquip) * JINXI2COIN * JINXIAGIO;	--����ÿ���;�������Ҫ�Ľ�Ϭ�;�
	if nItemDur then	-- ����ָ��������Ʒ�;ÿ����޸����ٵ㵱ǰװ��������;�
		nAddDur = math.floor(nItemDur / nItemDurCostPerDur);
		if (nAddDur > nLostDur) then
			nAddDur = nLostDur;
		end
	end
	return math.max(math.ceil(nAddDur * nItemDurCostPerDur), 1), nAddDur;
end

function Item:CalcSpecialRepairCoin(pEquip)
	local tbSetting = Item:GetExternSetting("value", pEquip.nVersion);
	if (not tbSetting) then
		return -1;
	end
	local nRate = (tbSetting.m_tbEquipTypeRate[pEquip.nDetail] or 100) / 100;
	local nFinalValue = math.max(pEquip.nValue, self.ALL_EQUIP_MIN_VALUE * nRate / self.EQUIP_TOTAL_RATE);
	nFinalValue = math.min(nFinalValue, self.ALL_EQUIP_MAX_VALUE * nRate / self.EQUIP_TOTAL_RATE);
	local nCoinCostPerDur = (nFinalValue * self.VALUEPERCEN_PER_YEAR / self.DUR_COST_PER_YEAR)/100;--����ÿ���;�������Ҫ�Ľ����
	return nCoinCostPerDur;
end


