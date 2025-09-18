local tb = { 
    minhgiaokiem150={ --圣火燎原
		appenddamage_p= {{{1,2*65*FightSkill.tbParam.nS1},{10,2*65},{20,2*65*FightSkill.tbParam.nS20},{21,2*65*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,2*620*FightSkill.tbParam.nS1},{10,2*620},{20,2*620*FightSkill.tbParam.nS20},{21,2*620*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,4*9},{20,4*9}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,150},{20,300},{21,300}}},
		state_weak_attack={{{1,25},{10,50},{20,64}},{{1,72},{20,72}}},
		skill_mintimepercast_v={{{1,3.5*18},{2,3.5*18}}},
		missile_range={4,0,4},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  