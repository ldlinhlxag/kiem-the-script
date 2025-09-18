local tb = { 
    chiennhan150={ --云龙击
		appenddamage_p= {{{1,105*FightSkill.tbParam.nS1},{10,105},{20,105*FightSkill.tbParam.nS20},{21,105*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,145*FightSkill.tbParam.nS1},{10,145},{20,145*FightSkill.tbParam.nS20},{21,145*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,1000*0.9*FightSkill.tbParam.nS1},{10,1000*0.9},{20,1000*0.9*FightSkill.tbParam.nS20},{21,1000*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,1000*1.1*FightSkill.tbParam.nS1},{10,1000*1.1},{20,1000*1.1*FightSkill.tbParam.nS20},{21,1000*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,15},{10,35},{20,50}},{{1,18},{20,18}}},
		state_burn_attack={{{1,15},{10,35},{20,40}},{{1,36},{20,54},{21,54}}},
		steallife_p={{{1,1},{20,10}},{{1,100},{20,100}}},
		stealmana_p={{{1,1},{20,10}},{{1,100},{20,100}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
}
FightSkill:AddMagicData(tb) 