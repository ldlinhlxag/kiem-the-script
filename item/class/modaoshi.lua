
-- 磨刀石
-- 右键点击使用，使用后在一定时间内攻击力上升
--磨刀石共分10级，等级越高所能提升的攻击力越高，按照玩家的五行给与相应的攻击加成（比如：天王使用后普攻提高，武当使用后雷攻提高）

local tbItem 	= Item:GetClass("modaoshi");
tbItem.nDuration	= Env.GAME_FPS * 60 * 60;


function tbItem:OnUse()
	me.AddSkillState(387, it.nLevel, 2, self.nDuration, 1, 0, 1);
	
	return 1;
end

function tbItem:GetTip()
	return FightSkill:GetSkillItemTip(387, it.nLevel);
end