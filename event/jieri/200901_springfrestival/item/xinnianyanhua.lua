--�����̻�
--2008.12.31
--sunduoliang

local tbItem = Item:GetClass("xinnianyanhua");
tbItem.nSkillExpId 		= 377;	--������Ч
tbItem.nSkillId 		= 1327;	--�̻���Ч
tbItem.nSkillId2 		= 1328;	--���������Ч
tbItem.nSkillBuffId 	= 1331;	--�̻�buf
tbItem.nNpcId   		= 3627;	--�̻�Npc
tbItem.nLastTime 		= 3 * 60 * Env.GAME_FPS	--3����

function tbItem:InitGenInfo()
	-- �趨��Ч����
	it.SetTimeOut(0, (GetTime() + 24 * 3600));
	return	{ };
end

function tbItem:OnUse()
	
	local szMsg = "����ã����һ����̻���\n�����̻�ȼ��ʱ�����������ȼ���̻��ĳ�ԱԽ�࣬����ҲԽ�ḻ��\n\n<color=yellow>���뵽��ٸ���ȼ�Ų���Ч����<color>\n���Ƿ�ȷ������ٸ���ȼ���̻���";
	local tbOpt = {
		{"ȼ���̻�", self.OnUseSure, self, it.dwId},
		{"�ٵȵ�"},
	}
	Dialog:Say(szMsg, tbOpt);
	return 0;
end

function tbItem:OnUseSure(nItemId)
	local nCurTime = tonumber(GetLocalDate("%H%M"));
	if nCurTime < 2000 or nCurTime >= 2400 then
		Dialog:Say("����ã��̻�ȼ��ֻ����ÿ�����ϵ�8�㵽12�㣬����ٸ�������ȼ�ţ����ڵ�ʱ��β�����ȼ���̻���");
		return 0;
	end
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0
	end
	if me.nFightState == 1 then
		Dialog:Say("����Ҫ�����ִ�ͳ��е���ٸ�������ȼ���̻����������ط�ȼ���̻�����û���κ�Ч����");
		return 0;
	end
	if me.GetSkillState(self.nSkillBuffId) > 0 then
		Dialog:Say("������ȼ��һ���̻����벻Ҫ�ظ�ʹ�á�");		
		return 0;
	end
	if me.DelItem(pItem) == 1 then
		me.AddSkillState(self.nSkillBuffId, 1, 1, self.nLastTime, 0);
		me.Msg("�ɹ�ʹ���̻���������Ҫ����ٸ�������Ч���뱣������ٸ�����");
	end
end
