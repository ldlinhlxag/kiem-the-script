local tb = { 
    thuyyenkiem150={ --冰心仙子
		appenddamage_p= {{{1,90*FightSkill.tbParam.nS1},{10,90},{20,90*FightSkill.tbParam.nS20},{21,90*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,400*0.9*FightSkill.tbParam.nS1},{10,400*0.9},{20,400*0.9*FightSkill.tbParam.nS20},{21,400*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,400*1.1*FightSkill.tbParam.nS1},{10,400*1.1},{20,400*1.1*FightSkill.tbParam.nS20},{21,400*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		skill_flyevent={{{1,118},{20,118}},{{1,3},{2,3}}},
		skill_showevent={{{1,2},{20,2}}},
		missile_hitcount={{{1,5},{5,5},{10,6},{15,6},{20,7},{21,7}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  