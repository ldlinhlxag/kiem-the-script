local tb = { 
    duongmonbay150={ --乱环击
		appenddamage_p= {{{1,40*1.2*FightSkill.tbParam.nS1},{10,40*1.2},{20,40*1.2*FightSkill.tbParam.nS20},{21,40*1.2*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,45*1.2*FightSkill.tbParam.nS1},{10,45*1.2},{20,45*1.2*FightSkill.tbParam.nS20},{21,45*1.2*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,2*9},{20,2*9}}},
		physicsdamage_v={
			[1]={{1,135*1.2*0.9*FightSkill.tbParam.nS1},{10,135*1.2*0.9},{20,135*1.2*0.9*FightSkill.tbParam.nS20},{21,135*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,135*1.2*1.1*FightSkill.tbParam.nS1},{10,135*1.2*1.1},{20,135*1.2*1.1*FightSkill.tbParam.nS20},{21,135*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		colddamage_v={
			[1]={{1,135*1.2*0.9*FightSkill.tbParam.nS1},{10,135*1.2*0.9},{20,135*1.2*0.9*FightSkill.tbParam.nS20},{21,135*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,135*1.2*1.1*FightSkill.tbParam.nS1},{10,135*1.2*1.1},{20,135*1.2*1.1*FightSkill.tbParam.nS20},{21,135*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		firedamage_v={
			[1]={{1,135*1.2*0.9*FightSkill.tbParam.nS1},{10,135*1.2*0.9},{20,135*1.2*0.9*FightSkill.tbParam.nS20},{21,135*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,135*1.2*1.1*FightSkill.tbParam.nS1},{10,135*1.2*1.1},{20,135*1.2*1.1*FightSkill.tbParam.nS20},{21,135*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		lightingdamage_v={
			[1]={{1,135*1.2*0.9*FightSkill.tbParam.nS1},{10,135*1.2*0.9},{20,135*1.2*0.9*FightSkill.tbParam.nS20},{21,135*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,135*1.2*1.1*FightSkill.tbParam.nS1},{10,135*1.2*1.1},{20,135*1.2*1.1*FightSkill.tbParam.nS20},{21,135*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,150},{20,300},{21,300}}},

		skill_maxmissile={{{1,2},{10,3},{20,4}}},
		skill_mintimepercast_v={{{1,2.5*18},{20,2.5*18},{21,2.5*18}}},
		state_knock_attack={{{1,30},{10,50},{20,80}},{{1,3},{10,10},{20,10}},{{1,32},{2,32}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
		missile_lifetime_v={30*18},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  