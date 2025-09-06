--ʥ���ǹ�
--�����
--2008.12.16
if  MODULE_GC_SERVER then
	return;
end
local tbItem = Item:GetClass("xmas_sweet");
tbItem.MAX_USE_COUNT = 100;
tbItem.TSK_GROUP = 2027;
tbItem.TSK_ID = 96;

function tbItem:InitGenInfo()
	-- �趨��Ч����
	local nSec = GetTime() + 30 * 24 * 3600;
	it.SetTimeOut(0, nSec);
	return	{ };
end

function tbItem:OnUse()
	local nUse = me.GetTask(self.TSK_GROUP, self.TSK_ID);
	if nUse >= self.MAX_USE_COUNT then
		me.Msg(string.format("�õ����������<color=yellow>%s<color>���������������ˡ�", self.MAX_USE_COUNT));
		return 0;
	end
	
	if me.nLevel < 60 then
		me.Msg("���ĵȼ�����60�����޷�ʹ�á�");
		return 0;
	end
	
	local nAddExp = 130 * me.nLevel^2 + 2600 * me.nLevel + 9750;
	
	me.AddExp(nAddExp);
	me.SetTask(self.TSK_GROUP, self.TSK_ID, nUse + 1);
	me.Msg(string.format("���Ѿ�ʹ����<color=yellow>%s<color>��ʥ���ǹ����������<color=yellow>%s<color>����", (nUse + 1), self.MAX_USE_COUNT));
	return 1;
end

function tbItem:GetTip(nState)
	local nAddExp = 130 * me.nLevel^2 + 2600 * me.nLevel + 9750;
	local nUse = me.GetTask(self.TSK_GROUP, self.TSK_ID);
	local szTip = string.format("ʹ�ø���Ʒ���Ի��<color=yellow>%s<color>���顣", nAddExp);
	szTip = szTip .. string.format("\n\n<color=green>��ʹ��%s������Ʒ<color>", nUse);
	return szTip;
end
