
-- �ؼ���Ϊ�������

-- ���ܺ���/�ص������ӿڣ������ؼ���Ϊ������ˣ�

Item.emXIUWEI_ADD_TYPE_NORMAL			= 0;	-- ֱ�ӻ����Ϊ
Item.emXIUWEI_ADD_TYPE_XIULIANZHU		= 1;	-- ͨ����������������Ϊ

function Item:AddBookKarma(pPlayer, nAddKarma, nAddType)
	if (0 == self:IsCanAddBookKarma(pPlayer, nAddType)) then
		return 0;
	end

	local pItem = pPlayer.GetEquip(Item.EQUIPPOS_BOOK);
	if (not pItem) then
		return	0;								-- ����û���ؼ���ʧ��
	end

	local tbSetting = self:GetExternSetting("book", pItem.nVersion);
	if (not tbSetting) then
		return	0;
	end

	local tbSkill =								-- �ؼ�����Ӧ����ID�б�
	{
		pItem.GetExtParam(17),
		pItem.GetExtParam(18),
		pItem.GetExtParam(19),
		pItem.GetExtParam(20),
	};

	local nLevel = pItem.GetGenInfo(1);			-- �ؼ���ǰ�ȼ�
	local nKarma = pItem.GetGenInfo(2);			-- �ؼ���ǰ��Ϊ
	
	local nUpExp;
	if pItem.nLevel == 3 then 
		nUpExp = tbSetting.m_tbHighLevelKarma[nLevel];
	else
		nUpExp = tbSetting.m_tbLevelKarma[nLevel];
	end
	
	if ((not nUpExp) or (nUpExp <= 0)) then		-- ����������
		return 1;
	end
	
	if (nLevel > pPlayer.nLevel + 5) then		-- �ؼ��ȼ�������ɫ�ȼ�5�����ϣ����ټ���Ϊ
			return	1;								
	elseif (nLevel == pPlayer.nLevel + 5) then	-- �ؼ��ȼ����ڽ�ɫ�ȼ�5����ʱ��ֻ�ӵ���Ϊֹ����
		if (nKarma >= nUpExp) then
			return 1;
		end
		if (nAddKarma + nKarma > nUpExp) then
			nAddKarma = nUpExp - nKarma;
		end
	end
	
	local nOrgLevel = nLevel;
	nKarma = nKarma + nAddKarma;

	for _, nSkill in ipairs(tbSkill) do
		if (nSkill > 0) then
			if (1 ~= pPlayer.IsHaveSkill(nSkill)) then
				pPlayer.AddFightSkill(nSkill, 1);		-- ��ɫû���ؼ���Ӧ�ļ��ܣ�����ϸü���
			end
			pPlayer.AddSkillExp(nSkill, nAddKarma);	-- ���ӽ�ɫ�ļ���������
		end
	end

	while (true) do
		local nLevelUp;	-- �ؼ�������һ���������Ϊ
		if pItem.nLevel == 3 then
			nLevelUp = tbSetting.m_tbHighLevelKarma[nLevel];
		else
			nLevelUp = tbSetting.m_tbLevelKarma[nLevel];
		end
		if (not nLevelUp) or (nLevelUp <= 0) then
			nKarma = 0;							-- �Ѿ���������������������Ϊ
			pPlayer.Msg("����ǰװ�����ؼ��Ѵﵽ���������������Ļ��޷������ؼ����ܡ�");
			break;
		end
		if (nKarma > nLevelUp) then			-- ����
			nLevel = nLevel + 1;
			nKarma = nKarma - nLevelUp;
		else
			break;
		end
	end

	if (pPlayer.UpdateBook(nLevel, nKarma) == 1) then		-- �ؼ����Ը��´���
		pPlayer.Msg("�������"..nAddKarma.."���ؼ���Ϊ��");	-- ����ϵͳ��Ϣ
	end

	if (nLevel ~= nOrgLevel) then				-- �ȼ������仯
		pPlayer.Msg("�����ؼ��ȼ�������");		-- ����ϵͳ��Ϣ
	end

	return	1;

end

function Item:IsCanAddBookKarma(pPlayer, nAddType)
	if (not pPlayer) then
		return 0;
	end
	if (not nAddType) then
		return 1;
	end
	
	-- ͨ�������鿪�������Ϊ
	if (nAddType == self.emXIUWEI_ADD_TYPE_XIULIANZHU) then
		local nXiuSkillLevel = pPlayer.GetSkillState(380);
		if (not nXiuSkillLevel or nXiuSkillLevel <= 0) then
			return 0;
		end
	end
	return 1;
end
