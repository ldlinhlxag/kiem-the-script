
-- ĥ��ʯ
-- �Ҽ����ʹ�ã�ʹ�ú���һ��ʱ���ڹ���������
--ĥ��ʯ����10�����ȼ�Խ�����������Ĺ�����Խ�ߣ�������ҵ����и�����Ӧ�Ĺ����ӳɣ����磺����ʹ�ú��չ���ߣ��䵱ʹ�ú��׹���ߣ�

local tbItem 	= Item:GetClass("modaoshi");
tbItem.nDuration	= Env.GAME_FPS * 60 * 60;


function tbItem:OnUse()
	me.AddSkillState(387, it.nLevel, 2, self.nDuration, 1, 0, 1);
	
	return 1;
end

function tbItem:GetTip()
	return FightSkill:GetSkillItemTip(387, it.nLevel);
end