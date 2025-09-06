local tb = { 
    ngudocdao150={ --玄阴斩
		appenddamage_p= {{{1,40*FightSkill.tbParam.nS1},{10,40},{20,40*FightSkill.tbParam.nS20},{21,40*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,144*FightSkill.tbParam.nS1},{10,144},{20,144*FightSkill.tbParam.nS20},{21,144*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,60*FightSkill.tbParam.nS1},{10,60},{20,60*FightSkill.tbParam.nS20},{21,60*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,9*9},{20,9*9}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,15},{10,25},{20,30}},{{1,18},{20,18}}},
		skill_collideevent={{{1,84},{20,84}}},
		skill_showevent={{{1,4},{20,4}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  