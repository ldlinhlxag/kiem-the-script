local tb = { 
    caibangr150={ --飞龙在天 
        appenddamage_p= {{{1,15*FightSkill.tbParam.nS1},{10,15},{20,15*FightSkill.tbParam.nS20},{21,15*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,350*0.9*FightSkill.tbParam.nS1},{10,350*0.9},{20,350*0.9*FightSkill.tbParam.nS20},{21,350*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,350*1.1*FightSkill.tbParam.nS1},{10,350*1.1},{20,350*1.1*FightSkill.tbParam.nS20},{21,350*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_burn_attack={{{1,5},{10,10},{20,15}},{{1,36},{20,54},{21,54}}},
		skill_missilenum_v={{{1,4},{20,4}}},
		skill_vanishedevent={{{1,135},{20,135}}},
		skill_showevent={{{1,8},{20,8}}},
		missile_range={1,0,1},
		missile_speed_v={40},
        skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
    }, 
} 
FightSkill:AddMagicData(tb)  