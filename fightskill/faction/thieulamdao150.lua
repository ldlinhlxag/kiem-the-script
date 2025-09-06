local tb = { 
    thieulamdao150={ --天竺绝刀_20
		appenddamage_p= {{{1,50*FightSkill.tbParam.nS1},{10,50},{20,50*FightSkill.tbParam.nS20},{21,50*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,115*FightSkill.tbParam.nS1},{10,115},{20,115*FightSkill.tbParam.nS20},{21,115*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,775*0.9*FightSkill.tbParam.nS1},{10,775*0.9},{20,775*0.9*FightSkill.tbParam.nS20},{21,775*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,775*1.1*FightSkill.tbParam.nS1},{10,775*1.1},{20,775*1.1*FightSkill.tbParam.nS20},{21,775*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,20},{10,25},{20,30}},{{1,18},{20,18}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  