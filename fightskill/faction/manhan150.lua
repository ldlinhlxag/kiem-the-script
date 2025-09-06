local tb = { 
    manhan150={ --天外流星
		appenddamage_p= {{{1,80*FightSkill.tbParam.nS1},{10,80},{20,80*FightSkill.tbParam.nS20},{21,80*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,750*0.9*FightSkill.tbParam.nS1},{10,750*0.9},{20,750*0.9*FightSkill.tbParam.nS20},{21,750*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,750*1.1*FightSkill.tbParam.nS1},{10,750*1.1},{20,750*1.1*FightSkill.tbParam.nS20},{21,750*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_burn_attack={{{1,15},{20,30}},{{10,36},{20,36}}},
		skill_vanishedevent={{{1,157},{20,157}}},
		skill_showevent={{{1,8},{20,8}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
}
FightSkill:AddMagicData(tb) 