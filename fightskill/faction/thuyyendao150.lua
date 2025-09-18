local tb = { 
    thuyyendao150={ --冰踪无影
		appenddamage_p= {{{1,30*1.1*FightSkill.tbParam.nS1},{10,30*1.1},{20,30*1.1*FightSkill.tbParam.nS20},{21,30*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,80*FightSkill.tbParam.nS1},{10,80},{20,80*FightSkill.tbParam.nS20},{21,80*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,350*0.9*FightSkill.tbParam.nS1},{10,350*0.9},{20,350*0.9*FightSkill.tbParam.nS20},{21,350*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,350*1.1*FightSkill.tbParam.nS1},{10,350*1.1},{20,350*1.1*FightSkill.tbParam.nS20},{21,350*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		attackrating_p={{{1,100},{20,100}}},
		state_hurt_attack={{{1,5},{20,10}},{{1,18},{20,18}}},
		skill_collideevent={{{1,126},{20,126}}},
		skill_showevent={{{1,4},{20,4}}},
		missile_range={1,0,1},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  