
-- ӡ����������
-- zhengyuhua

-- define

Item.UPGRADE_EXP_PER_ITEM		= 10;				-- ÿ����ʯͷ�ľ���
Item.UPGRADE_ITEM_CLASS			= "spiritstore"		-- ��ʯClassname
Item.UPGRADE_EQUIP_CLASS		= "signet"			-- ӡ��Classname

----------------------------------------------------------------------

function Item:SetSignetMagic(pSignet, nMagicIndex, nLevel, nExp)
	pSignet.SetGenInfo(nMagicIndex * 2 - 1, nLevel);
	pSignet.SetGenInfo(nMagicIndex * 2, nExp);
	local nRet = pSignet.Regenerate(
		pSignet.nGenre,
		pSignet.nDetail,
		pSignet.nParticular,
		pSignet.nLevel,
		pSignet.nSeries,
		pSignet.nEnhTimes,
		pSignet.nLucky,
		pSignet.GetGenInfo(),
		0,
		pSignet.dwRandSeed,
		0
	);
	if nRet == 1 then
		Dbg:WriteLog("Upgrade", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "������ӡ�ĵ�"..nMagicIndex.."����������Ϊ", nLevel, nExp);
	else
		Dbg:WriteLog("Upgrade", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "��������ӡʧ��,Regenerate");
	end
end

function Item:CalcUpgrade(pSignet, nMagicIndex, nItemNum)
	if not pSignet or pSignet.szClass ~= self.UPGRADE_EQUIP_CLASS then
		return 0;
	end
	if nMagicIndex <= 0 or nMagicIndex > self.SIGNET_ATTRIB_NUM then
		return 0;
	end
	local nLevel 	= pSignet.GetGenInfo(nMagicIndex * 2 - 1, 0);
	local nExp		= pSignet.GetGenInfo(nMagicIndex * 2, 0);
	
	-- zhengyuhua:�칫����ʱ����
	local nMuti = 100;
	local nBufLevel = me.GetSkillState(881);
	if nBufLevel > 0 then
		nMuti = nMuti * 1.2;
	end
	
	nExp = nExp + math.floor(nItemNum * self.UPGRADE_EXP_PER_ITEM * nMuti / 100);
	local tbSetting = Item:GetExternSetting("signet", pSignet.nVersion);
	if nLevel < self.MIN_SIGNET_LEVEL then
		return 0;
	end
	while (nLevel < self.MAX_SIGNET_LEVEL and nExp >= tbSetting.m_LevelExp[nLevel]) do
		nExp = nExp - tbSetting.m_LevelExp[nLevel];
		nLevel = nLevel + 1;
	end
	local nResCount = 0;
	if nLevel >= self.MAX_SIGNET_LEVEL and  nExp > tbSetting.m_LevelExp[nLevel] then
		nResCount = math.floor(nExp / (self.UPGRADE_EXP_PER_ITEM * nMuti / 100));
	end
	return nLevel, nExp, tbSetting.m_LevelExp[nLevel] or 0, nResCount;
end

-- ��������ӡ  
-- 		����˵����pSignet:����ӡָ�룬tbUpgradeItem:�����������ĵ��ߣ�nMagicIndex:ѡ��Ҫ����������
function Item:UpgradeSignet(pSignet, tbUpgradeItem, nMagicIndex)
	if not pSignet or pSignet.szClass ~= self.UPGRADE_EQUIP_CLASS then
		return 0;
	end

	local nItemNum = 0;
	for _, pItem in pairs(tbUpgradeItem) do
		if pItem.szClass == self.UPGRADE_ITEM_CLASS then	-- ����Ƿ��ǻ�ʯ
			local nCurCount = pItem.nCount;
			local nLevel, nExp, _, nResCount = self:CalcUpgrade(pSignet, nMagicIndex, nCurCount);
			local nRet = 0;
			if nResCount > 0 then
				nRet = pItem.SetCount(nResCount);
			elseif nResCount == 0 then
				nRet = me.DelItem(pItem, Player.emKLOSEITEM_SERIES_STONE);		-- �۳���ʯ
			end
			if nRet ~= 1 then
				Dbg:WriteLog("Upgrade", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "�۳���ʯʧ�ܣ�������:", nCurCount);
			else
				nItemNum = nItemNum + nCurCount;
				self:SetSignetMagic(pSignet, nMagicIndex, nLevel, nExp);
			end
			if nLevel >= self.MAX_SIGNET_LEVEL then -- ������������
				break;
			end
		else
			Dbg:WriteLog("Upgrade", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "���Ի���ǻ�ʯ������������ӡ")
		end
	end
	if nItemNum == 0 then
		return 0;
	end

	return 1;
end


