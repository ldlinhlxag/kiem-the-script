-- �ļ�������girl_vote_meiguixiang.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-06-23 11:52:36
-- ��  ��  ��

------------------------------------------------------------------------------------------
-- initialize

local tbXiang = Item:GetClass("girl_vote_meiguixiang");

------------------------------------------------------------------------------------------

-- ����ֵ��	0��ɾ����1ɾ��
function tbXiang:OnUse()
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("�����ռ䲻�㡣");
		return 0;
	end
	local tbItemInfo = {};
	me.AddStackItem(18, 1, 373, 1, tbItemInfo, 99);
	return 1;
end
