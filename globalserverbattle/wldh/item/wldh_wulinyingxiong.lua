-- �ļ�������wldh_wulinyingxiong.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-09-23 16:11:42
-- ��  ��  ��

local tbItem = Item:GetClass("wldh_wulinyingxiong");

function tbItem:OnUse()
	
	-- add bind to no bind
	if it.IsBind() == 1 then
		if me.CountFreeBagCell() < 1 then
			Dialog:SendBlackBoardMsg(me, "�㱳�����ˣ��Ų��£���1��ռ������ɡ�");
			return 0;
		end
		me.AddItem(18, 1, 487, 1);
		me.Msg("�����а󶨵�����Ӣ�����ƣ��Ѿ��ɹ�ת��Ϊ���󶨡�");
		return 1;
	end
	
	local nFlag = Player:AddRepute(me, 11, 1, 300);
	if (0 == nFlag) then
		return;
	elseif (1 == nFlag) then
		me.Msg("���Ѿ��ﵽ���ִ��������ߵȼ������޷����ִ������");
		return;
	end
	return 1;
end
