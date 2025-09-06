-----------------------------------------------------------
-- �ļ�������jiguanshuxinde.lua
-- �ļ�������ʹ�ú����ӻ����;ö�
-- �����ߡ���ZhangDeheng
-- ����ʱ�䣺2008-11-17 11:28:11
-----------------------------------------------------------
local tbItem = Item:GetClass("jiguanshuxinde");

tbItem.AWARD 			= 20;	-- ����20������;ö�
tbItem.WEEK_USED_COUNT 	= 10; -- һ�ܿ���ʹ�õĸ���

function tbItem:OnUse()
	if (me.GetTask(1022, 117) ~= 1) then
		me.Msg("ֻ��ѧϰ�˻���������ʹ�ô���Ʒ��");
		return 0;
	end;
	
	local nCount = me.GetTask(1024, 57);
	if (nCount >= self.WEEK_USED_COUNT) then
		me.Msg("������ʹ���Ѵ����ޣ�������ʹ�ã�");
		return 0;		
	end;
	
	me.AddMachineCoin(self.AWARD);
	me.Msg(string.format("�������<color=yellow>%s��<color>�����;ö�", self.AWARD));
	nCount = nCount + 1;
	me.SetTask(1024, 57, nCount)
	return 1;
end

function tbItem:InitGenInfo()
	--���õ��ߵ�������
	it.SetTimeOut(0, GetTime() + 24 * 3600);
	return	{ };
end

-- ÿ����һ��
function tbItem:WeekEvent()
	me.SetTask(1024, 57, 0, 1);
end

PlayerSchemeEvent:RegisterGlobalWeekEvent({tbItem.WeekEvent, tbItem});