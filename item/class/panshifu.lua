

-- �������������¼ӵ��ߣ���ʯ��
-- ���ã��Ҽ����ʹ�ã�ʹ�ú���һ��ʱ���ڼ�������״̬Ч��
-- ��ϸ˵������ʯ������10�����ȼ�Խ�����������ļ�������״̬Ч��Խ��


local tbItem 		= Item:GetClass("panshifu");
tbItem.nDuration	= Env.GAME_FPS * 60 * 60;
tbItem.nSkillId		= 887;

function tbItem:OnUse()
	me.AddSkillState(self.nSkillId, it.nLevel, 2, self.nDuration, 1, 0, 1);
	
	return 1;
end

function tbItem:GetTip()
	return FightSkill:GetSkillItemTip(self.nSkillId, it.nLevel);
end
