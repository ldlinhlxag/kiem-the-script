------------------------------------------------------------------------------------------
-- �ļ�˵����װ������
-- ���ߣ�fenghewen
-- ʱ�䣺2009.10.29
------------------------------------------------------------------------------------------

-- initialize

-- �������ClassName����
Item.STRENGTHEN_RECIPE_WEAPON = "strengthen_recipe_weapon";	-- ���������
Item.STRENGTHEN_RECIPE_JEWELRY = "strengthen_recipe_jewwlry";	-- ���θ����
Item.STRENGTHEN_RECIPE_ARMOR = "strengthen_recipe_armor";	-- ���߸����
-- ��������Ӧ����Ʒ����
Item.STRENGTHEN_RECIPE_CALSS =  {	-- ����
									[Item.STRENGTHEN_RECIPE_WEAPON] = {Item.EQUIP_MELEE_WEAPON, 
																	  Item.EQUIP_RANGE_WEAPON},
									-- ����									  
									[Item.STRENGTHEN_RECIPE_ARMOR] = {Item.EQUIP_ARMOR,
																		Item.EQUIP_BOOTS,
																		Item.EQUIP_BELT,
																		Item.EQUIP_HELM,
																		Item.EQUIP_CUFF},
									-- ��Ʒ							
									[Item.STRENGTHEN_RECIPE_JEWELRY] = {Item.EQUIP_RING,
																	   Item.EQUIP_NECKLACE,
																	   Item.EQUIP_AMULET,
																	   Item.EQUIP_PENDANT}
								};
-- ������ϵ������ͣ�����								
Item.STRENGTHEN_STUFF_CLASS = "xuanjing";	
-- �����޶���ǿ���ȼ�
Item.STRENGTHEN_TIMES = {15}
------------------------------------------------------------------------------------------

-- ����
function Item:Strengthen(pEquip, tbStrItem, nMoneyType, nParam)
	local nRes, szMsg = self:CheckStrengthenEquip(pEquip);
	if nRes ~= 1 then
		me.Msg(szMsg);
		return 0;
	end
	
	local nRes, szMsg, nStuffVal, bBind, tbStuffItem, pStrengthenRecipe = self:CalStrengthenStuff(pEquip, tbStrItem);
	if nRes ~= 1 then
		me.Msg(szMsg);
		return 0;
	end

	local nProb, nMoney, nTrueProb = Item:CalcProb(pEquip, nStuffVal, Item.ENHANCE_MODE_STRENGTHEN);
	-- ����ȵ���100%ʱ�����ɸ���
	-- ����ȳ���120%���ɸ���
	if nProb < 100 then
		me.Msg("�����δ��100%�������ܸ���");
		return 0;
	elseif (nTrueProb > 120) then
		me.Msg("��������������࣬�����˷ѡ�");
		return 0;
	elseif (nMoneyType == Item.BIND_MONEY and me.CostBindMoney(nMoney, Player.emKBINDMONEY_COST_STRENGTHEN) ~= 1) then
		me.Msg("�����ϰ��������㣬���ܸ��죡");
		return 0;
	elseif (nMoneyType == Item.NORMAL_MONEY and me.CostMoney(nMoney, Player.emKPAY_STRENGTHEN) ~= 1) then	-- �۳���Ǯ
		me.Msg("�������������㣬���ܸ��죡");
		return 0;
	elseif (nMoneyType ~= Item.NORMAL_MONEY)and (nMoneyType ~= Item.BIND_MONEY) then
		return 0;
	end
	
	if nMoneyType == Item.NORMAL_MONEY then
		KStatLog.ModifyAdd("jxb", "[����]װ������", "����", nMoney);
	end
	if nMoneyType == Item.BIND_MONEY then
		KStatLog.ModifyAdd("bindjxb", "[����]װ������", "����", nMoney);
	end
		
	local szSucc = "�����:"..nProb.."%%";
	Dbg:WriteLog("Strengthen", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "ԭ��:"..szMsg, szSucc, "�ͻ��˼�������:"..nParam.."%%");
	
	if nParam > nProb and self.__OPEN_ENHANCE_LIMIT == 1 then
		me.Msg("���Ŀͻ�����ʾ�ĸ��������Ϊ������ɲ���Ҫ����ʧ����ֹ���ĸ���������뾡����ͷ���ϵ��");
		return 0;
	end
	
	local nIbValue = 0;
	-- ������
	for i, pItem in ipairs(tbStuffItem) do
		if pItem.nBuyPrice > 0 then -- Ib�������ߴ�Ib�����ϳɶ���
			nIbValue = nIbValue + pItem.nBuyPrice;
		end
		
		if me.DelItem(pItem, Player.emKLOSEITEM_STRENGTHEN) ~= 1 then
			Dbg:WriteLog("Strengthen", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "�۳�����ʧ��", unpack(pItem));
			return 0;
		end
	end
	
	nIbValue = nIbValue + pStrengthenRecipe.nBuyPrice;
	-- �۸����
	if me.DelItem(pStrengthenRecipe) ~= 1 then
		Dbg:WriteLog("Strengthen", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "�۸����ʧ��", unpack(pStrengthenRecipe));
		return 0;
	end
	
	if pEquip.IsBind() ~= 1 then
		pEquip.nBuyPrice = pEquip.nBuyPrice + nIbValue;
	else
		Spreader:AddConsume(nIbValue);
	end

	local nRet = pEquip.Regenerate(
		pEquip.nGenre,
		pEquip.nDetail,
		pEquip.nParticular,
		pEquip.nLevel,
		pEquip.nSeries,
		pEquip.nEnhTimes,
		pEquip.nLucky,
		pEquip.GetGenInfo(),
		0,
		pEquip.dwRandSeed,
		1
	);
	
	if nRet == 0 then

		Dbg:WriteLog("Strengthen", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "װ������ʧ��", unpack(pEquip));
		return 0;
	end

	if nMoneyType == Item.BIND_MONEY then
		bBind = 1;
	end
	-- ������Ѱ�װ������Ҫ�ٰ�, ���װ���Ͳ��϶�����Ҳ����Ҫ�ٰ�
	local bNeedBind = 1;
	if (bBind == pEquip.IsBind()) then
		bNeedBind = 0;			
	end
	
	if bNeedBind == 1 then
		pEquip.Bind(1);					-- ǿ�ư�װ��
		Spreader:OnItemBound(pEquip);
	end

	Dbg:WriteLog("Strengthen", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "����ɹ�")

	return 1;
end

-- ������װ���Ƿ�Ϸ�
function Item:CheckStrengthenEquip(pEquip)
	if (not pEquip) or (pEquip.IsEquip() ~= 1) or (pEquip.IsWhite() == 1) then
		return 0, "����Ʒ����ǿ����";			-- ��װ�����ɫװ�����ܸ���
	end
	if pEquip.nStrengthen ~= 0 then
		return 0,"����Ʒ�Ѿ��������!";
	end
	if (pEquip.nDetail < Item.MIN_COMMON_EQUIP) or (pEquip.nDetail > Item.MAX_COMMON_EQUIP) then
		return 0, "�������м����װ������ǿ����";			-- �ǿ�ǿ������װ�����ܸ���
	end
	

	-- ���װ���ĸ������ԣ������Ƿ��ܸ���
	local tbMASS = pEquip.GetStrMASS();		-- ��õ���ǿ������ħ������
	local nCount = 0;					-- �������Լ���
	for _, tbMA in ipairs(tbMASS) do
		if (tbMA.szName ~= "") and (tbMA.bVisible == 1) then
			nCount = nCount + 1;
		end
	end
	if nCount == 0 then
		return 0, "��װ��û�и������ԣ����ܸ��졣";
	end
	
	-- ���װ����ǿ���Ĵ����Ƿ��ܸ���
	local bCanStrengthen = 0;
	for i = 1, #self.STRENGTHEN_TIMES do
		if pEquip.nEnhTimes == self.STRENGTHEN_TIMES[i] then
			bCanStrengthen = 1;
		end
	end	
	if bCanStrengthen == 0 then
		return 0, "��ǿ���ȼ���װ�����ܸ���";
	end
	return 1;
end

-- ��������Ƿ�Ϸ�
function Item:CheckRecipe(pItem, pEquip)
	if not pItem or not pEquip or not self.STRENGTHEN_RECIPE_CALSS[pItem.szClass] then
		return 0;
	end
	for i, nDetail in ipairs(self.STRENGTHEN_RECIPE_CALSS[pItem.szClass]) do
		if pEquip.nDetail == nDetail then
			if pEquip.nEnhTimes == pItem.nLevel then
				return 1;
			end
		end
	end

	return 0;
end	

-- ����������
function Item:CalStrengthenStuff(pEquip, tbStrItem)
	local pStrengthenRecipe = nil;
	local szMsg = "";
	local nStuffVal = 0;
	local tbStuff = {};
	local bBind  = 0;
	local tbCalcuate  = {};
	
	for _, pItem in ipairs(tbStrItem) do
		
		if self:CheckRecipe(pItem, pEquip) == 1 then
			if pStrengthenRecipe then
				return 0, "���������������ϵĸ����";
			end
			pStrengthenRecipe = pItem;
		elseif pItem.szClass == self.STRENGTHEN_STUFF_CLASS then
			nStuffVal = nStuffVal + pItem.nValue; -- �������������ļ�ֵ�ܺ�
			table.insert(tbStuff, pItem);
			if (pItem.IsBind() == 1) then
				bBind = 1;		-- ����а󶨵�������Ҫ��װ��
			end
			local szName = pItem.szName;
			if not tbCalcuate[szName] then
				tbCalcuate[szName] = 0;
			end
			tbCalcuate[szName] = tbCalcuate[szName] + 1;
		end
	end		
	
	if not pStrengthenRecipe then
		return 0, "û�и����";
	end
	
	if nStuffVal == 0 then
		return 0, "û������";
	end
	
	local szMsg = "";
	if MODULE_GAMESERVER then
		for szName, nCount in pairs(tbCalcuate) do
			szMsg = szMsg..szName..nCount.."��  ";
		end
	end
	
	return 1, szMsg, nStuffVal, bBind, tbStuff, pStrengthenRecipe;
end

-- ��������ֵ�ͻ������ͻ��������˹���
function Item:CalcProb(pEquip, nStuffVal, nModeType)
	local tbSetting = Item:GetExternSetting("value", pEquip.nVersion);
	if (not tbSetting) then
		return 0;
	end
	
	local nSrcValue = 0;
	if nModeType == Item.ENHANCE_MODE_STRENGTHEN then
		nSrcValue = tbSetting.m_tbStrengthenValue[pEquip.nEnhTimes];
		if (not nSrcValue) then
			return 0;
		end
	elseif nModeType == Item.ENHANCE_MODE_ENHANCE then
		nSrcValue = tbSetting.m_tbEnhanceValue[pEquip.nEnhTimes + 1];
		if (not nSrcValue) then
			return 0;
		end
		
		if pEquip.nStrengthen == 1 then
			nSrcValue = nSrcValue - tbSetting.m_tbStrengthenValue[pEquip.nEnhTimes];
		end
	else
		return 0;
	end
	
	local nTypeRate = (tbSetting.m_tbEquipTypeRate[pEquip.nDetail] or 100) / 100;
	local nCostValue = nSrcValue * nTypeRate;
	local nMoney	 = nCostValue * 0.1;
	nCostValue		 = nCostValue - nMoney;
	nMoney 			 = math.floor(nMoney * self:GetJbPrice()); 	-- ��ҽ������һ�ϵ��
	
	
	-- *******��ۿ���*******************
		--houxuan: 081110 װ��ǿ�����õ���ͳһ�ӿ�
	local nFreeCount, tbExecute, nExpMultipe = SpecialEvent.ExtendAward:DoCheck("EnhanceEquip", me);
	nMoney = math.ceil(nMoney * nExpMultipe);
		-- �Ϸ��Żݣ��Ϸ�7������
	if GetTime() < KGblTask.SCGetDbTaskInt(DBTASK_COZONE_TIME) + 7 * 24 * 60 * 60 and nExpMultipe == 1 then
		nMoney = math.floor(nMoney * 8 / 10);
	end
	-- *************************************

	local nProb = math.floor(nStuffVal / nCostValue * 100);
	-- ��ʵ�ɹ���
	local nTrueProb = nProb;
	if (nProb > 100) then
		nProb = 100;
	end
	return	nProb, nMoney, nTrueProb;
end
