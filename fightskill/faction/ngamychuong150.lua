local tb = { 
    ngamychuong150={ --风霜碎影
		appenddamage_p= {{{1,96*FightSkill.tbParam.nS1},{10,96},{20,96*FightSkill.tbParam.nS20},{21,96*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,2200*0.9*FightSkill.tbParam.nS1},{10,2200*0.9},{20,2200*0.9*FightSkill.tbParam.nS20},{21,2200*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,2200*1.1*FightSkill.tbParam.nS1},{10,2200*1.1},{20,2200*1.1*FightSkill.tbParam.nS20},{21,2200*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_slowall_attack={{{1,15},{10,40},{20,45}},{{1,27},{20,45}}},
		skill_startevent={{{1,104},{20,104}}},
		skill_showevent={{{1,1},{20,1}}},
		missile_hitcount={{{1,5},{10,6},{20,7},{21,7}}},
		missile_range={9,0,9},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  