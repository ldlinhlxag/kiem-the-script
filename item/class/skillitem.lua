
-- ���ܵ��ߣ�ͨ�ù��ܽű�

------------------------------------------------------------------------------------------
-- initialize

local tbSkillItem = Item:GetClass("skillitem");

local CASTTYPE_LAUNCHER_POS	= 1;			-- ʹ�ø���Ʒʱֱ���õ�ǰ��ҵ�����λ��Ϊ������������
local CASTTYPE_LAUNCHER_ID	= 2;			-- ʹ�ø���Ʒʱֱ���Ե�ǰ��ҵ�IDΪ������������
local CASTTYPE_TARGET_POS	= 3;			-- ʹ�ø���Ʒʱ����Ҫ�����ָ��ĳ��λ��
local CASTTYPE_TARGET_ID	= 4;			-- ʹ�ø���Ʒʱ����Ҫ�����ָ��ĳ��Ŀ��

------------------------------------------------------------------------------------------
-- public

function tbSkillItem:OnUse()				-- �ż���

	local pNpc = me.GetNpc();
	local nSkillId    = it.GetExtParam(1);	-- ����ID
	local nSkillLevel = it.GetExtParam(2);	-- ���ܼ���
	local nCastType   = it.GetExtParam(3);	-- �ż�������
	local bBroadcast  = it.GetExtParam(4);	-- �Ƿ�����Χ�㲥
	local nParam1     = 0;
	local nParam2     = 0;

	if		(CASTTYPE_LAUNCHER_POS	== nCastType) then
		nParam1, nParam2 = pNpc.GetMpsPos();
	elseif	(CASTTYPE_LAUNCHER_ID	== nCastType) then
		nParam1 = -1;
		nParam2 = pNpc.nIndex;
	elseif	(CASTTYPE_TARGET_POS	== nCastType) then
		-- TODO: �ݲ��ṩ
		return	0;
	elseif	(CASTTYPE_TARGET_ID		== nCastType) then
		-- TODO: �ݲ��ṩ
		return	0;
	end

	pNpc.CastSkill(nSkillId, nSkillLevel, nParam1, nParam2, bBroadcast);
	return	1;

end
