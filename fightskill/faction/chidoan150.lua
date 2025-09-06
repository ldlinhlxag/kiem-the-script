local tb = { 
    chidoan150={ --乾阳神指_20
		appenddamage_p= {{{1,65*FightSkill.tbParam.nS1},{10,65},{20,65*FightSkill.tbParam.nS20},{21,65*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		colddamage_v={
			[1]={{1,550*0.9*FightSkill.tbParam.nS1},{10,550*0.9},{20,550*0.9*FightSkill.tbParam.nS20},{21,550*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,550*1.1*FightSkill.tbParam.nS1},{10,550*1.1},{20,550*1.1*FightSkill.tbParam.nS20},{21,550*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,45},{20,90},{21,90}}},
		state_hurt_attack={{{1,7},{10,20},{20,25}},{{1,18},{20,18}}},
		state_slowall_attack={{{1,7},{10,20},{20,25}},{{1,18},{20,36},{21,36}}},
		missile_hitcount={{{1,5},{20,5}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  