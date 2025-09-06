local tb = { 
    thieulambong_150={ --天竺绝刀_20
		appenddamage_p= {{{1,70*FightSkill.tbParam.nS1},{10,70},{20,70*FightSkill.tbParam.nS20},{25,105*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,125*FightSkill.tbParam.nS1},{10,125},{20,125*FightSkill.tbParam.nS20},{25,125*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,500*0.9*FightSkill.tbParam.nS1},{10,500*0.9},{20,500*0.9*FightSkill.tbParam.nS20},{25,500*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,550*1.1*FightSkill.tbParam.nS1},{10,550*1.1},{20,550*1.1*FightSkill.tbParam.nS20},{25,550*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,25},{10,45},{20,50}},{{1,18},{20,18}}},
		missile_hitcount={{{1,5},{5,6},{10,7},{15,8},{20,9},{21,9}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  