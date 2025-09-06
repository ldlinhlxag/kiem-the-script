local tb = { 
    vokiem150={ --人剑合一
		appenddamage_p= {{{1,35*FightSkill.tbParam.nS1},{10,35},{20,35*FightSkill.tbParam.nS20},{21,35*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,80*FightSkill.tbParam.nS1},{10,80},{20,80*FightSkill.tbParam.nS20},{21,80*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,350*0.9*FightSkill.tbParam.nS1},{10,350*0.9},{20,350*0.9*FightSkill.tbParam.nS20},{21,350*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,350*1.1*FightSkill.tbParam.nS1},{10,350*1.1},{20,350*1.1*FightSkill.tbParam.nS20},{21,350*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_stun_attack={{{1,12},{10,25},{20,35}},{{1,18},{20,18}}},
		state_hurt_attack={{{1,10},{20,15}},{{1,18},{20,18}}},
		skill_startevent={{{1,172},{20,172}}},
		skill_showevent={{{1,1},{20,1}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  