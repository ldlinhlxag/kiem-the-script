local tb = { 
    doanthikiem150={ --六脉神剑主_伤
		appenddamage_p= {{{1,30*FightSkill.tbParam.nS1},{10,30},{20,30*FightSkill.tbParam.nS20},{21,30*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,475*0.9*FightSkill.tbParam.nS1},{10,475*0.9},{20,475*0.9*FightSkill.tbParam.nS20},{21,475*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,475*1.1*FightSkill.tbParam.nS1},{10,475*1.1},{20,475*1.1*FightSkill.tbParam.nS20},{21,475*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_hurt_attack={{{1,5},{10,10},{20,15}},{{1,18},{20,18}}},
		missile_hitcount={{{1,4},{2,4}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  