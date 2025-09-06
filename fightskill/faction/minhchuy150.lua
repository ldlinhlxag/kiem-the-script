local tb = { 
    minhchuy150={ --龙吞式
		appenddamage_p= {{{1,80*FightSkill.tbParam.nS1},{10,80},{20,80*FightSkill.tbParam.nS20},{21,80*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		poisondamage_v={{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},{{1,2*9},{20,2*9}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,27},{20,54},{21,54}}},
		state_hurt_attack={{{1,5},{10,10},{20,15}},{{1,18},{20,18}}},
		state_weak_attack={{{1,10},{10,20},{20,25}},{{1,36},{20,54},{21,54}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  