local tb = { 
    vokhi150={ --天地无极
		appenddamage_p= {{{1,45*FightSkill.tbParam.nS1},{10,45},{20,45*FightSkill.tbParam.nS20},{21,45*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,825*0.9*FightSkill.tbParam.nS1},{10,825*0.9},{20,825*0.9*FightSkill.tbParam.nS20},{21,825*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,825*1.1*FightSkill.tbParam.nS1},{10,825*1.1},{20,825*1.1*FightSkill.tbParam.nS20},{21,825*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_stun_attack={{{1,12},{10,17},{20,22}},{{1,18},{20,18}}},
		missile_hitcount={{{1,5},{5,6},{10,8},{15,9},{20,10},{21,10}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  