local tb = { 
    conlonkiem150={ --雷动九天
		appenddamage_p= {{{1,175*FightSkill.tbParam.nS1},{10,175},{20,175*FightSkill.tbParam.nS20},{21,175*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,2250*0.9*FightSkill.tbParam.nS1},{10,2250*0.9},{20,2250*0.9*FightSkill.tbParam.nS20},{21,2250*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,2250*1.1*FightSkill.tbParam.nS1},{10,2250*1.1},{20,2250*1.1*FightSkill.tbParam.nS20},{21,2250*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_stun_attack={{{1,15},{10,30},{20,40}},{{1,36},{20,36}}},
		skill_cost_v={{{1,150},{20,300},{21,300}}},
		skill_mintimepercast_v={{{1,5*18},{10,5*18}}},
		skill_mintimepercastonhorse_v={{{1,5*18},{10,5*18}}},
		missile_hitcount={{{1,5},{10,7},{20,9},{21,9}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  