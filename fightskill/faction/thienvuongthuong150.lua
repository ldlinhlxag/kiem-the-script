local tb = { 
    thienvuongthuong150={ --天王战意_20
		appenddamage_p= {{{1,30*FightSkill.tbParam.nS1},{10,30},{20,56*FightSkill.tbParam.nS20},{21,56*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,120*FightSkill.tbParam.nS1},{10,120},{20,120*FightSkill.tbParam.nS20},{21,120*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,700*0.9*FightSkill.tbParam.nS1},{10,700*0.9},{20,700*0.9*FightSkill.tbParam.nS20},{21,700*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,700*1.1*FightSkill.tbParam.nS1},{10,700*1.1},{20,700*1.1*FightSkill.tbParam.nS20},{21,700*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		seriesdamage_r={{{1,100},{20,200},{21,210}}},
		skill_cost_v={{{1,22},{20,45},{21,45}}},
		state_hurt_attack={{{1,21},{2,22}},{{1,3*18},{20,3*18}}},
		state_hurt_attacktime={{{1,110},{2,120}}},
		--missile_hitcount={{{1,3},{20,3}}},
		skill_vanishedevent={{{1,1998},{20,1998}}},
		skill_missilenum_v={{{1,3},{10,3}}},
		--skill_showevent={{{1,8},{20,8}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
} 
FightSkill:AddMagicData(tb)  