local tb = { 
    ngudocchuong150={ --阴风蚀骨
		appenddamage_p= {{{1,40*FightSkill.tbParam.nS1},{10,40},{20,40*FightSkill.tbParam.nS20},{21,40*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,250*FightSkill.tbParam.nS1},{10,250},{20,250*FightSkill.tbParam.nS20},{21,250*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,4*9},{20,4*9}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		skill_vanishedevent={{{1,94},{20,94}}},
		skill_showevent={{{1,8},{20,8}}},
		missile_hitcount={{{1,5},{5,6},{10,8},{15,9},{20,10},{21,10}}},
		missile_range={9,0,9},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  