local tb = { 
    skill150dmtt={ --追星逐电，暴雨梨花第二式
		appenddamage_p= {{{1,45*FightSkill.tbParam.nS1},{10,45},{20,45*FightSkill.tbParam.nS20},{21,45*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,45*FightSkill.tbParam.nS1},{10,45},{20,45*FightSkill.tbParam.nS20},{21,45*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,9*9},{20,9*9}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,15},{20,30}},{{1,18},{20,18}}},
		state_weak_attack={{{1,10},{10,20},{20,30}},{{1,36},{20,54},{21,54}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
} 
FightSkill:AddMagicData(tb)  