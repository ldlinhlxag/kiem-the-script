local tb = { 
    chuythien150={ --乘龙诀_20
		appenddamage_p= {{{1,65*FightSkill.tbParam.nS1},{10,65},{20,65*FightSkill.tbParam.nS20},{21,65*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,250*0.9*FightSkill.tbParam.nS1},{10,250*0.9},{20,250*0.9*FightSkill.tbParam.nS20},{21,250*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,250*1.1*FightSkill.tbParam.nS1},{10,250*1.1},{20,250*1.1*FightSkill.tbParam.nS20},{21,250*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		skill_cost_v={{{1,22},{20,45},{21,45}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,15},{10,25},{20,35}},{{1,18},{20,18}}},
		missile_hitcount={{{1,4},{20,4}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  