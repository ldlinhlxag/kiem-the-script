
-- װ������⹦�ܽű�

------------------------------------------------------------------------------------------
-- initialize

local STUFF1_DETAIL_INDEX  		= 1;
local STUFF1_PARTICULAR_INDEX	= 2;
local STUFF2_DETAIL_INDEX  		= 3;
local STUFF2_PARTICULAR_INDEX	= 4;
local LIFESKILL_ID				= 11;		-- װ���������Ӧ�������ID

------------------------------------------------------------------------------------------
-- private

local function CheckEquip(pEquip)		-- ����˼��װ���ĺϷ���
	if (not pEquip) or (pEquip.nGenre ~= Item.EQUIP_GENERAL) then
		return 0;						-- ��һ��װ�����ܲ��
	end
	if (pEquip.nDetail < Item.MIN_COMMON_EQUIP) or (pEquip.nDetail > Item.MAX_COMMON_EQUIP) then
		return 0;						-- ֻ�в������м����װ�����ܲ��
	end
	if (pEquip.nEnhTimes > 0) or (pEquip.IsBind() == 1) then
		return 0;						-- �ѱ�ǿ�������Ѱ�װ�����ܲ��
	end
	return 1;
end

local function CalcLifeSkillExp(tbStuff)	-- ���ݲ��ϼ������ӵļӹ�ϵ����ܾ���
	local tbExp = {};
	for _, tb in ipairs(tbStuff) do
		local nRecipeId = 0;
		for nId, tbRecipe in ipairs(LifeSkill.tbRecipeDatas) do
			for _, v in ipairs(tbRecipe.tbProductSet) do
				local tbItem = v.tbItem;
				if (tb.nGenre == tbItem[1]) and (tb.nDetail == tbItem[2]) and (tb.nParticular == tbItem[3]) and
				(tb.nLevel == tbItem[4]) and (tb.nSeries == tbItem[6]) then
					nRecipeId = nId;		-- �ҵ���Ӧ�Ĳ����䷽
					break;
				end
			end
			if (nRecipeId > 0) then
				break;
			end
		end
		if (nRecipeId > 0) then
			local nSkillId 	  = LifeSkill:GetBelongSkillId(nRecipeId);	-- ���϶�Ӧ�ӹ�ϵ�����ID
			local nExp	   	  = tb.nValue * tb.nCount;					-- �������Ӿ��飨���ֵ������1:1��
			local tbSkill 	  = LifeSkill.tbLifeSkillDatas[nSkillId];
			local szSkillName = tbSkill and tbSkill.Name or "";			-- �ӹ�ϵ���������
			local bMerge      = 0;
			for _, v in ipairs(tbExp) do
				if (v.nSkillId == nSkillId) then
					v.nExp = v.nExp + nExp;
					bMerge  = 1;
					break;
				end
			end
			if (bMerge ~= 1) then
				table.insert(tbExp, { nSkillId = nSkillId, nExp = nExp, szSkillName = szSkillName });
			end
		end
	end
	return tbExp;
end

------------------------------------------------------------------------------------------
-- public

function Item:CalcBreakUpStuff(pEquip)		-- �������Ʒ���������ģ��ͻ��������˹���

	if CheckEquip(pEquip) ~= 1 then
		return 0;
	end

	local nLevel 		= pEquip.nLevel;
	local nStuffCount 	= 0;
	local tbStuff		= {};
	local tbStuffInfo	= {};
	local tbParam 		=
	{
		{ pEquip.GetExtParam(STUFF1_DETAIL_INDEX), pEquip.GetExtParam(STUFF1_PARTICULAR_INDEX) },
		{ pEquip.GetExtParam(STUFF2_DETAIL_INDEX), pEquip.GetExtParam(STUFF2_PARTICULAR_INDEX) },
	};

	for i, v in ipairs(tbParam) do
		if (v[1] > 0) and (v[2] > 0) then
			local tb = {};
			tb.nGenre		= Item.STUFFITEM;
			tb.nDetail		= v[1];
			tb.nParticular	= v[2];
			tb.nCount		= 0;
			tb.bBind		= 0;
			table.insert(tbStuffInfo, tb);
		end
	end

	if #tbStuffInfo <= 0 then
		return 0;				-- ����װ��û�пɲ��Ĳ���
	end

	local nEquipValue = math.floor(pEquip.nValue * 0.8);

	while (#tbStuff < 2) and (nLevel > 0) do

		local tbSort = {};
		local nCurLevel = nLevel;
		for i, v in ipairs(tbStuffInfo) do
			local tbBaseProp = KItem.GetItemBaseProp(v.nGenre, v.nDetail, v.nParticular, nCurLevel);
			if tbBaseProp and tbBaseProp.nValue > 0 then
				v.nLevel = nCurLevel;
				v.nValue = tbBaseProp.nValue;
				table.insert(tbSort, v);
			end
			nCurLevel = nCurLevel - 1;
		end

		table.sort(tbSort, function(tbL, tbR) return tbL.nValue > tbR.nValue end);	-- �����ϼ�ֵ��������

		for i, v in ipairs(tbSort) do
			local nCount = math.floor(nEquipValue / v.nValue);
			if (nCount > 0) then
				nEquipValue = nEquipValue - nCount * v.nValue;
				-- �ҵ����ʵĲ��ϣ���¼
				local tb = {};
				tb.nGenre		= v.nGenre;
				tb.nDetail		= v.nDetail;
				tb.nParticular	= v.nParticular;
				tb.nLevel		= v.nLevel;
				tb.nSeries		= Env.SERIES_NONE;
				tb.nValue		= v.nValue;
				tb.nCount		= nCount;
				tb.bBind		= 0;
				table.insert(tbStuff, tb);
				if (#tbStuff >= 2) then
					break;
				end
			end
		end

		nLevel = nLevel - 1;	-- �ݼ����ϼ���Ѱ�Һ��ʵ�������

	end

	local nGTPCost = math.floor(math.floor(pEquip.nValue * 0.4) * 0.1);
	if nGTPCost < 1 then
		nGTPCost = 1;		-- �������1�����
	end

	return nGTPCost, tbStuff, CalcLifeSkillExp(tbStuff);

end

function Item:BreakUp(pEquip)			-- ����ӿڣ������ִ��װ�����

	if me.HasLearnLifeSkill(LIFESKILL_ID) ~= 1 then
		return 0;
	end
	
	if me.IsAccountLock() ~= 0 then
		me.Msg("����˺���������״̬������ִ�иò�����");
		return;
	end
	
	if (me.nFightState > 0) then
		me.Msg("ս��״̬�²���ʹ������ܡ�");
		return 0;
	end

	if (me.GetNpc().nDoing ~= Npc.DO_STAND) then
		me.Msg("ֻ��������״̬����ʹ������ܡ�");
		return 0;
	end

	local nGTP, tbStuff, tbExp = Item:CalcBreakUpStuff(pEquip);
	if (nGTP <= 0) or (#tbStuff <= 0) then
		return 0;		-- ���ܲ��
	end

	if (me.dwCurGTP < nGTP) or (me.CanAddItemIntoBag(unpack(tbStuff)) ~= 1) then
		return 0;			-- ����֮������߱������Ӳ���
	end

	if (me.DelItem(pEquip, Player.emKLOSEITEM_BREAKUP) ~= 1) then
		return 0;			-- ɾ��װ��ʧ��
	end

	me.ChangeCurGatherPoint(-nGTP);		-- �۳�����

	-- ���ɲ���
	for _, tb in ipairs(tbStuff) do
		for i = 1, tb.nCount do
			me.AddStuffItem(tb.nDetail, tb.nParticular, tb.nLevel, tb.nSeries);	-- TODO: xyf �÷���Ч�ʵ�
		end
	end

	-- ��������ܾ���
	for _, tb in ipairs(tbExp) do
		me.AddLifeSkillExp(tb.nSkillId, tb.nExp);
	end

	return 1;

end
