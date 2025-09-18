local tb = { 
    caibangbong150={ --天下无狗
		appenddamage_p= {{{1,39*FightSkill.tbParam.nS1},{10,39},{20,39*FightSkill.tbParam.nS20},{21,39*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,66*FightSkill.tbParam.nS1},{10,66},{20,66*FightSkill.tbParam.nS20},{21,66*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,275*0.9*FightSkill.tbParam.nS1},{10,275*0.9},{20,275*0.9*FightSkill.tbParam.nS20},{21,275*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,275*1.1*FightSkill.tbParam.nS1},{10,275*1.1},{20,275*1.1*FightSkill.tbParam.nS20},{21,275*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,20},{20,25}},{{1,18},{20,18}}},
		state_burn_attack={{{1,10},{10,20},{20,25}},{{1,36},{20,54},{21,54}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
} 
FightSkill:AddMagicData(tb)  