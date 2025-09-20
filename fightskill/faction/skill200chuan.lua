local tb = { 
    DTK200={ --?????_?
		appenddamage_p= {{{1,42*FightSkill.tbParam.nS1},{10,42},{20,42*FightSkill.tbParam.nS20},{21,42*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,700*0.9*FightSkill.tbParam.nS1},{10,700*0.9},{20,700*0.9*FightSkill.tbParam.nS20},{21,700*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,700*1.1*FightSkill.tbParam.nS1},{10,700*1.1},{20,700*1.1*FightSkill.tbParam.nS20},{21,700*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_stun_attack={{{1,10},{29,17}},{{1,18},{29,3*18}}},
		state_slowall_attack={{{1,10},{29,58}},{{1,18},{29,4*18}}},
		state_burn_attack_attack={{{1,10},{29,22}},{{1,18},{29,3*18}}},
		state_weak_attack={{{1,10},{29,25}},{{1,18},{29,3*18}}},
		state_hurt_attack={{{1,10},{29,35}},{{1,18},{29,3*27}}},
		missile_range={1,0,1},
		missile_hitcount={{{1,4},{2,4}}},
	},
	DTK200_1={ --?????_?
		appenddamage_p= {{{1,10*FightSkill.tbParam.nS1},{10,10},{20,10*FightSkill.tbParam.nS20},{21,10*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,120*0.9*FightSkill.tbParam.nS1},{10,120*0.9},{20,120*0.9*FightSkill.tbParam.nS20},{21,120*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,120*1.1*FightSkill.tbParam.nS1},{10,120*1.1},{20,120*1.1*FightSkill.tbParam.nS20},{21,120*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
	},
	DTK200_2={ --?????_?
		appenddamage_p= {{{1,7*FightSkill.tbParam.nS1},{10,7},{20,7*FightSkill.tbParam.nS20},{21,7*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,50*0.9*FightSkill.tbParam.nS1},{10,50*0.9},{20,50*0.9*FightSkill.tbParam.nS20},{21,50*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,50*1.1*FightSkill.tbParam.nS1},{10,50*1.1},{20,50*1.1*FightSkill.tbParam.nS20},{21,50*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		state_stun_attack={{{1,10},{29,15}},{{1,18},{29,4*18}}},
	},

	DTC200={ --????_20
		appenddamage_p= {{{1,75*FightSkill.tbParam.nS1},{10,75},{20,75*FightSkill.tbParam.nS20},{21,75*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		colddamage_v={
			[1]={{1,600*0.9*FightSkill.tbParam.nS1},{10,600*0.9},{20,600*0.9*FightSkill.tbParam.nS20},{21,600*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,600*1.1*FightSkill.tbParam.nS1},{10,600*1.1},{20,600*1.1*FightSkill.tbParam.nS20},{21,600*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,45},{20,90},{21,90}}},
		state_hurt_attack={{{1,10},{29,50}},{{1,18},{29,3*18}}},
		state_hurt_attacktime={{{1,110},{2,130}}},
		state_slowall_attack={{{1,10},{29,60}},{{1,18},{29,4*18}}},
		state_slowall_attacktime={{{1,150},{2,170}}},
		missile_hitcount={{{1,5},{20,5}}},
		attackratingenhance_p={{{1,50},{10,150},{11,165}}},
	},
	DTC200_1={ --????_20
		appenddamage_p= {{{1,75*FightSkill.tbParam.nS1},{10,75},{20,75*FightSkill.tbParam.nS20},{21,75*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		colddamage_v={
			[1]={{1,790*0.9*FightSkill.tbParam.nS1},{10,790*0.9},{20,790*0.9*FightSkill.tbParam.nS20},{21,790*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,790*1.1*FightSkill.tbParam.nS1},{10,790*1.1},{20,790*1.1*FightSkill.tbParam.nS20},{21,790*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		state_hurt_attack={{{1,10},{29,50}},{{1,18},{29,4*18}}},
		state_slowall_attack={{{1,10},{29,60}},{{1,18},{29,3*18}}},
	},
	DTC200_2={ --????_20
		appenddamage_p= {{{1,75*FightSkill.tbParam.nS1},{10,75},{20,75*FightSkill.tbParam.nS20},{21,75*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		colddamage_v={
			[1]={{1,790*0.9*FightSkill.tbParam.nS1},{10,790*0.9},{20,790*0.9*FightSkill.tbParam.nS20},{21,790*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,790*1.1*FightSkill.tbParam.nS1},{10,790*1.1},{20,790*1.1*FightSkill.tbParam.nS20},{21,790*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		state_hurt_attack={{{1,10},{29,50}},{{1,18},{29,3*18}}},
		state_slowall_attack={{{1,10},{29,60}},{{1,18},{29,3*18}}},
	},
	
	CBR200={ --????
		appenddamage_p= {{{1,18*FightSkill.tbParam.nS1},{10,18},{20,18*FightSkill.tbParam.nS20},{21,18*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,325*0.9*FightSkill.tbParam.nS1},{10,325*0.9},{20,325*0.9*FightSkill.tbParam.nS20},{21,325*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,325*1.1*FightSkill.tbParam.nS1},{10,375*1.1},{20,325*1.1*FightSkill.tbParam.nS20},{21,325*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_burn_attack={{{1,10},{29,60}},{{1,18},{29,3*18}}},
		state_burn_attacktime={{{1,50},{20,250},{29,390}}},
		skill_missilenum_v={{{1,5},{20,5}}},
		skill_showevent={{{1,8},{20,8}}},
		missile_range={1,0,1},
		missile_speed_v={40},
	},
	CBR200_1={ --????,???????
		appenddamage_p= {{{1,85*FightSkill.tbParam.nS1},{10,85},{20,85*FightSkill.tbParam.nS20},{21,85*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,1900*0.8*FightSkill.tbParam.nS1},{10,1900*0.8},{20,1900*0.8*FightSkill.tbParam.nS20},{21,1900*0.8*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,1900*1.2*FightSkill.tbParam.nS1},{10,1900*1.2},{20,1900*1.2*FightSkill.tbParam.nS20},{21,1900*1.2*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
		missile_missrate={{{1,90},{2,90}}},
		missile_range={5,0,5},
	},
	CBR200_2={ --????,???????
		appenddamage_p= {{{1,10*FightSkill.tbParam.nS1},{10,10},{20,10*FightSkill.tbParam.nS20},{21,10*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,150*0.8*FightSkill.tbParam.nS1},{10,150*0.8},{20,150*0.8*FightSkill.tbParam.nS20},{21,150*0.8*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,150*1.2*FightSkill.tbParam.nS1},{10,150*1.2},{20,150*1.2*FightSkill.tbParam.nS20},{21,150*1.2*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
	},
	CBR200_3={ --????,???????
		appenddamage_p= {{{1,6*FightSkill.tbParam.nS1},{10,6},{20,6*FightSkill.tbParam.nS20},{21,6*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,150*0.8*FightSkill.tbParam.nS1},{10,150*0.8},{20,150*0.8*FightSkill.tbParam.nS20},{21,150*0.8*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,150*1.2*FightSkill.tbParam.nS1},{10,150*1.2},{20,150*1.2*FightSkill.tbParam.nS20},{21,150*1.2*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
	},
	
	NDC200={ --????
		appenddamage_p= {{{1,33*FightSkill.tbParam.nS1},{10,33},{20,33*FightSkill.tbParam.nS20},{21,33*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,800*FightSkill.tbParam.nS1},{10,800},{20,800*FightSkill.tbParam.nS20},{21,800*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,4*9},{20,4*9}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_stun_attack={{{1,10},{29,15}},{{1,18},{29,3*18}}},
		state_weak_attack={{{1,10},{29,45}},{{1,18},{29,4*18}}},
		state_weak_attacktime={{{1,110},{2,134}}},
		state_hurt_attack={{{1,10},{29,65}},{{1,18},{29,3*18}}},
		skill_showevent={{{1,8},{20,8}}},
		missile_hitcount={{{1,5},{5,6},{10,8},{15,9},{20,10},{21,10}}},
		missile_range={9,0,9},
	},
	NDC200_1={ --????,???????
		appenddamage_p= {{{1,33*FightSkill.tbParam.nS1},{10,33},{20,33*FightSkill.tbParam.nS20},{21,33*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,800*FightSkill.tbParam.nS1},{10,800},{20,800*FightSkill.tbParam.nS20},{21,800*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,4*9},{20,4*9}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_weak_attack={{{1,10},{29,45}},{{1,18},{29,3*18}}},
		missile_hitcount={{{1,5},{5,6},{10,8},{15,9},{20,10},{21,10}}},
		missile_range={11,0,11},
	},
	TLD200={ --????_20
		appenddamage_p= {{{1,55*FightSkill.tbParam.nS1},{10,55},{20,55*FightSkill.tbParam.nS20},{21,55*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,75*FightSkill.tbParam.nS1},{10,75},{20,75*FightSkill.tbParam.nS20},{21,75*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,800*0.9*FightSkill.tbParam.nS1},{10,800*0.9},{20,800*0.9*FightSkill.tbParam.nS20},{21,800*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,800*1.1*FightSkill.tbParam.nS1},{10,800*1.1},{20,800*1.1*FightSkill.tbParam.nS20},{21,800*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,10},{29,54}},{{1,18},{29,4*18}}},
		state_hurt_attacktime={{{1,150},{2,170}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
	},
	TLD200_1={ --????_20
		appenddamage_p= {{{1,50*FightSkill.tbParam.nS1},{10,50},{20,50*FightSkill.tbParam.nS20},{21,50*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,75*FightSkill.tbParam.nS1},{10,75},{20,75*FightSkill.tbParam.nS20},{21,75*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,350*0.9*FightSkill.tbParam.nS1},{10,350*0.9},{20,350*0.9*FightSkill.tbParam.nS20},{21,350*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,350*1.1*FightSkill.tbParam.nS1},{10,350*1.1},{20,350*1.1*FightSkill.tbParam.nS20},{21,350*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		state_hurt_attack={{{1,10},{29,45}},{{1,18},{29,3*18}}},
	},
	TLD200_2={ --????_20
		appenddamage_p= {{{1,30*FightSkill.tbParam.nS1},{10,30},{20,20*FightSkill.tbParam.nS20},{21,30*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,65*FightSkill.tbParam.nS1},{10,65},{20,65*FightSkill.tbParam.nS20},{21,65*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,350*0.9*FightSkill.tbParam.nS1},{10,350*0.9},{20,350*0.9*FightSkill.tbParam.nS20},{21,350*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,350*1.1*FightSkill.tbParam.nS1},{10,350*1.1},{20,350*1.1*FightSkill.tbParam.nS20},{21,350*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
	},
	TLB200={ --?????
		appenddamage_p= {{{1,85*FightSkill.tbParam.nS1},{10,85},{20,85*FightSkill.tbParam.nS20},{21,85*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,145*FightSkill.tbParam.nS1},{10,145},{20,145*FightSkill.tbParam.nS20},{21,145*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,750*0.9*FightSkill.tbParam.nS1},{10,750*0.9},{20,750*0.9*FightSkill.tbParam.nS20},{21,750*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,750*1.1*FightSkill.tbParam.nS1},{10,750*1.1},{20,750*1.1*FightSkill.tbParam.nS20},{21,750*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,10},{29,67}},{{1,18},{29,4*18}}},
		state_stun_attack={{{1,7},{29,14}},{{1,0.5*18},{29,3*18}}},
		state_hurt_attacktime={{{1,100},{2,130}}},
		missile_hitcount={{{1,5},{5,6},{10,7},{15,8},{20,9},{21,9}}},
	},
	TLB200_1={ --?????
		appenddamage_p= {{{1,75*FightSkill.tbParam.nS1},{10,75},{20,75*FightSkill.tbParam.nS20},{21,75*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,110*FightSkill.tbParam.nS1},{10,110},{20,110*FightSkill.tbParam.nS20},{21,110*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,750*0.9*FightSkill.tbParam.nS1},{10,750*0.9},{20,750*0.9*FightSkill.tbParam.nS20},{21,750*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,750*1.1*FightSkill.tbParam.nS1},{10,750*1.1},{20,750*1.1*FightSkill.tbParam.nS20},{21,750*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		state_hurt_attack={{{1,10},{29,45}},{{1,18},{29,4*18}}},
		state_stun_attack={{{1,7},{29,12}},{{1,0.5*18},{29,3*18}}},
		state_hurt_attacktime={{{1,80},{2,100}}},
		missile_hitcount={{{1,5},{5,6},{10,7},{15,8},{20,9},{21,9}}},
	},
	NDD200={ --???
		appenddamage_p= {{{1,70*FightSkill.tbParam.nS1},{10,70},{20,70*FightSkill.tbParam.nS20},{21,70*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,120*FightSkill.tbParam.nS1},{10,120},{20,120*FightSkill.tbParam.nS20},{21,120*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,650*FightSkill.tbParam.nS1},{10,650},{20,650*FightSkill.tbParam.nS20},{21,650*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,9*9},{20,9*9}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,10},{29,45}},{{1,18},{29,3*18}}},
		state_weak_attack={{{1,10},{29,30}},{{1,18},{29,4*18}}},
		state_hurt_attacktime={{{1,120},{2,132}}},
		state_weak_attacktime={{{1,120},{2,141}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
	},
	NDD200_1={ --???,??????
		appenddamage_p= {{{1,65*FightSkill.tbParam.nS1},{10,65},{20,65*FightSkill.tbParam.nS20},{21,65*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,300*FightSkill.tbParam.nS1},{10,300},{20,300*FightSkill.tbParam.nS20},{21,300*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,9*9},{20,9*9}}},
		state_hurt_attack={{{1,10},{29,45}},{{1,18},{29,2*18}}},
		state_weak_attack={{{1,10},{29,60}},{{1,18},{29,2*18}}},
	},
	NDD200_2={ --???,??????
		appenddamage_p= {{{1,20*FightSkill.tbParam.nS1},{10,20},{20,20*FightSkill.tbParam.nS20},{21,20*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,120*FightSkill.tbParam.nS1},{10,120},{20,120*FightSkill.tbParam.nS20},{21,120*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,9*9},{20,9*9}}},
		state_hurt_attack={{{1,10},{29,45}},{{1,18},{29,2*18}}},
		state_weak_attack={{{1,10},{29,60}},{{1,18},{29,2*18}}},
	},
	CBB200={ --????
		appenddamage_p= {{{1,15*FightSkill.tbParam.nS1},{10,15},{20,15*FightSkill.tbParam.nS20},{21,15*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,34*FightSkill.tbParam.nS1},{10,34},{20,34*FightSkill.tbParam.nS20},{21,34*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,280*0.9*FightSkill.tbParam.nS1},{10,280*0.9},{20,280*0.9*FightSkill.tbParam.nS20},{21,280*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,280*1.1*FightSkill.tbParam.nS1},{10,280*1.1},{20,280*1.1*FightSkill.tbParam.nS20},{21,280*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,10},{29,55}},{{1,18},{29,3*18}}},
		state_burn_attack={{{1,10},{29,30}},{{1,18},{29,4*18}}},
		state_drag_attack={{{1,10},{29,30}},{{1,3},{10,10},{20,10}},{{1,12},{2,12}}},
		state_knock_attack={{{1,15},{30,25}},{{1,3},{10,10},{20,10}},{{1,14},{2,14}}},
		state_burn_attacktime={{{1,50},{20,250},{29,390}}},
	},
	CBB200_1={ --????
		appenddamage_p= {{{1,8*FightSkill.tbParam.nS1},{10,8},{20,8*FightSkill.tbParam.nS20},{21,8*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,25*FightSkill.tbParam.nS1},{10,25},{20,25*FightSkill.tbParam.nS20},{21,25*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,280*0.9*FightSkill.tbParam.nS1},{10,280*0.9},{20,280*0.9*FightSkill.tbParam.nS20},{21,280*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,280*1.1*FightSkill.tbParam.nS1},{10,280*1.1},{20,280*1.1*FightSkill.tbParam.nS20},{21,280*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		state_hurt_attack={{{1,10},{29,25}},{{1,18},{29,3*18}}},
		state_burn_attack={{{1,10},{29,15}},{{1,18},{29,3*18}}},
	},
	CBB200_2={ --????
		appenddamage_p= {{{1,10*FightSkill.tbParam.nS1},{10,10},{20,10*FightSkill.tbParam.nS20},{21,10*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,25*FightSkill.tbParam.nS1},{10,25},{20,25*FightSkill.tbParam.nS20},{21,25*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,100*0.9*FightSkill.tbParam.nS1},{10,100*0.9},{20,100*0.9*FightSkill.tbParam.nS20},{21,100*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,100*1.1*FightSkill.tbParam.nS1},{10,100*1.1},{20,100*1.1*FightSkill.tbParam.nS20},{21,100*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		state_hurt_attack={{{1,10},{29,25}},{{1,18},{29,2*18}}},
		state_burn_attack={{{1,10},{29,15}},{{1,18},{29,2*18}}},
	},
	NMK200={ --????_10
		appenddamage_p= {{{1,130*0.7},{10,130},{11,130*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,1800*0.7*0.9},{10,1800*0.9},{11,1800*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,1800*0.7*1.1},{10,1800*1.1},{11,1800*FightSkill.tbParam.nSadd*1.1}}
		},
		state_slowall_attack={{{1,10},{29,60}},{{1,18},{29,3*18}}},
		state_fixed_attack={{{1,0.5},{2,1}},{{1,2*18},{2,2*18}}},
		state_slowall_attacktime={{{1,110},{2,150}}},
		seriesdamage_r={{{1,250},{10,250},{11,250}}},
		missile_hitcount={{{1,7},{10,7},{11,7}}},
		skill_cost_v={{{1,100},{10,200},{11,200}}},
		missile_speed_v={60},
	},
	NMK200_1={ --?????_10
		appenddamage_p= {{{1,130*0.7},{10,130},{11,130*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,1800*0.7*0.9},{10,1800*0.9},{11,1800*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,1800*0.7*1.1},{10,1800*1.1},{11,1800*FightSkill.tbParam.nSadd*1.1}}
		},
		state_slowall_attack={{{1,35},{10,65},{11,66}},{{1,45},{10,45},{11,45}}},
		skill_statetime={{{1,2*18},{20,5*18}}},
	},
	NMC200={ --????
		appenddamage_p= {{{1,88*FightSkill.tbParam.nS1},{10,88},{20,88*FightSkill.tbParam.nS20},{21,88*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,1900*0.9*FightSkill.tbParam.nS1},{10,1900*0.9},{20,1900*0.9*FightSkill.tbParam.nS20},{21,1900*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,1900*1.1*FightSkill.tbParam.nS1},{10,1900*1.1},{20,1900*1.1*FightSkill.tbParam.nS20},{21,1900*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_slowall_attack={{{1,10},{29,60}},{{1,18},{29,4*18}}},
		state_slowall_attacktime={{{1,100},{2,131}}},
		state_hurt_attack={{{1,10},{29,55}},{{1,18},{29,3*18}}},
		skill_showevent={{{1,1},{20,1}}},
		missile_hitcount={{{1,5},{10,6},{20,7},{21,7}}},
	},
	NMC200_1={ --????,???????
		appenddamage_p= {{{1,11*FightSkill.tbParam.nS1},{10,11},{20,11*FightSkill.tbParam.nS20},{21,11*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,300*0.9*FightSkill.tbParam.nS1},{10,300*0.9},{20,300*0.9*FightSkill.tbParam.nS20},{21,300*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,300*1.1*FightSkill.tbParam.nS1},{10,300*1.1},{20,300*1.1*FightSkill.tbParam.nS20},{21,300*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		state_slowall_attack={{{1,10},{29,85}},{{1,18},{29,2*18}}},
	},
	NMC200_2={ --????,???????
		appenddamage_p= {{{1,10*FightSkill.tbParam.nS1},{10,10},{20,10*FightSkill.tbParam.nS20},{21,10*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,300*0.9*FightSkill.tbParam.nS1},{10,300*0.9},{20,300*0.9*FightSkill.tbParam.nS20},{21,300*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,300*1.1*FightSkill.tbParam.nS1},{10,300*1.1},{20,300*1.1*FightSkill.tbParam.nS20},{21,300*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		state_slowall_attack={{{1,10},{29,45}},{{1,18},{29,4*18}}},
		state_hurt_attack={{{1,10},{29,55}},{{1,18},{29,3*18}}},
	},
	TYD200={ --????
		appenddamage_p= {{{1,75*FightSkill.tbParam.nS1},{10,75},{20,75*FightSkill.tbParam.nS20},{21,75*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,90*FightSkill.tbParam.nS1},{10,90},{20,90*FightSkill.tbParam.nS20},{21,90*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,550*0.9*FightSkill.tbParam.nS1},{10,550*0.9},{20,550*0.9*FightSkill.tbParam.nS20},{21,550*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,550*1.1*FightSkill.tbParam.nS1},{10,550*1.1},{20,550*1.1*FightSkill.tbParam.nS20},{21,550*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		attackrating_p={{{1,100},{20,100}}},
		state_slowall_attack={{{1,10},{29,55}},{{1,18},{29,4*18}}},
		state_hurt_attack={{{1,10},{29,55}},{{1,18},{29,3*18}}},
		state_slowall_attacktime={{{1,180},{2,200}}},
		missile_range={1,0,1},
		missile_speed_v={50},
	},
	TYD200_1={ --????,??????? --co the loi doan nay
		appenddamage_p= {{{1,75*FightSkill.tbParam.nS1},{10,75},{20,75*FightSkill.tbParam.nS20},{21,75*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,90*FightSkill.tbParam.nS1},{10,90},{20,90*FightSkill.tbParam.nS20},{21,90*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,550*0.9*FightSkill.tbParam.nS1},{10,550*0.9},{20,550*0.9*FightSkill.tbParam.nS20},{21,550*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,550*1.1*FightSkill.tbParam.nS1},{10,550*1.1},{20,550*1.1*FightSkill.tbParam.nS20},{21,550*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		state_hurt_attack={{{1,10},{29,30}},{{1,18},{29,2*27}}},
		state_slowall_attack={{{1,15},{20,55},{21,55}},{{1,36},{20,45},{21,45}}},
		missile_speed_v={50},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
	},
	
	TYK200={ --????
		appenddamage_p= {{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,989*0.9*FightSkill.tbParam.nS1},{10,989*0.9},{20,989*0.9*FightSkill.tbParam.nS20},{21,989*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,989*1.1*FightSkill.tbParam.nS1},{10,989*1.1},{20,989*1.1*FightSkill.tbParam.nS20},{21,989*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_slowall_attack={{{1,10},{29,60}},{{1,18},{29,3*18}}},
		state_slowall_attacktime={{{1,100},{2,160}}},
		skill_showevent={{{1,2},{20,2}}},
		missile_hitcount={{{1,5},{5,5},{10,6},{15,6},{20,7},{21,7}}},
		missile_speed_v={60},
	},
	TYK200_1={ --????,???????
		appenddamage_p= {{{1,90*FightSkill.tbParam.nS1},{10,90},{20,90*FightSkill.tbParam.nS20},{21,90*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,350*0.9*FightSkill.tbParam.nS1},{10,350*0.9},{20,350*0.9*FightSkill.tbParam.nS20},{21,350*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,350*1.1*FightSkill.tbParam.nS1},{10,350*1.1},{20,350*1.1*FightSkill.tbParam.nS20},{21,350*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_slowall_attack={{{1,10},{29,60}},{{1,18},{29,4*18}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
	},
	VDK200={ --????
		appenddamage_p= {{{1,70*FightSkill.tbParam.nS1},{10,70},{20,70*FightSkill.tbParam.nS20},{21,70*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,110*FightSkill.tbParam.nS1},{10,110},{20,110*FightSkill.tbParam.nS20},{21,110*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,420*0.9*FightSkill.tbParam.nS1},{10,420*0.9},{20,420*0.9*FightSkill.tbParam.nS20},{21,420*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,420*1.1*FightSkill.tbParam.nS1},{10,420*1.1},{20,420*1.1*FightSkill.tbParam.nS20},{21,420*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_stun_attack={{{1,10},{29,78}},{{1,18},{29,3*18}}},
		state_stun_attacktime={{{1,140},{2,170}}},
		state_hurt_attack={{{1,10},{29,30}},{{1,18},{29,3*18}}},
		skill_showevent={{{1,1},{20,1}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
	},
	VDK200_1={ --????,???????
		state_stun_attack={{{1,10},{29,88}},{{1,18},{29,3*18}}},
	},
	VDKH200={ --????
		appenddamage_p= {{{1,75*FightSkill.tbParam.nS1},{10,75},{20,75*FightSkill.tbParam.nS20},{21,75*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,1050*0.9*FightSkill.tbParam.nS1},{10,1050*0.9},{20,1050*0.9*FightSkill.tbParam.nS20},{21,1050*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,1050*1.1*FightSkill.tbParam.nS1},{10,1050*1.1},{20,1050*1.1*FightSkill.tbParam.nS20},{21,1050*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_stun_attack={{{1,10},{29,59}},{{1,18},{29,4*18}}},
		state_stun_attacktime={{{1,110},{2,190}}},
		missile_hitcount={{{1,5},{5,6},{10,8},{15,9},{20,10},{21,10}}},
	},
	CLK200={ --????
		appenddamage_p= {{{1,80*FightSkill.tbParam.nS1},{10,80},{20,80*FightSkill.tbParam.nS20},{21,80*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,1400*0.9*FightSkill.tbParam.nS1},{10,1400*0.9},{20,1400*0.9*FightSkill.tbParam.nS20},{21,1400*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,1400*1.1*FightSkill.tbParam.nS1},{10,1400*1.1},{20,1400*1.1*FightSkill.tbParam.nS20},{21,1400*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,150},{20,300},{21,300}}},
		state_stun_attack={{{1,10},{29,60}},{{1,18},{29,3*27}}},
		state_stun_attacktime={{{1,110},{2,142}}},
		missile_hitcount={{{1,5},{10,7},{20,9},{21,9}}},
	},
	CLK200_1={ --???? --doan nay cung co the loi
		appenddamage_p= {{{1,80*FightSkill.tbParam.nS1},{10,80},{20,80*FightSkill.tbParam.nS20},{21,80*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,1100*0.9*FightSkill.tbParam.nS1},{10,1100*0.9},{20,1100*0.9*FightSkill.tbParam.nS20},{21,1100*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,1100*1.1*FightSkill.tbParam.nS1},{10,1100*1.1},{20,1100*1.1*FightSkill.tbParam.nS20},{21,1100*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		state_stun_attack={{{1,10},{29,56}},{{1,18},{29,3*18}}},
		state_stun_attacktime={{{1,60},{2,100}}},
		missile_range={3,0,3},
	},
	CLD200={ --???? --them cai lightingdamage_v
		appenddamage_p= {{{1,75*FightSkill.tbParam.nS1},{10,75},{20,75*FightSkill.tbParam.nS20},{21,75*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,125*FightSkill.tbParam.nS1},{10,125},{20,125*FightSkill.tbParam.nS20},{21,125*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,850*0.9*FightSkill.tbParam.nS1},{10,850*0.9},{20,850*0.9*FightSkill.tbParam.nS20},{21,850*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,850*1.1*FightSkill.tbParam.nS1},{10,850*1.1},{20,850*1.1*FightSkill.tbParam.nS20},{21,850*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		skill_attackradius={900}, --da chinh dong nay
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_stun_attack={{{1,10},{29,71}},{{1,18},{29,3*18}}},
		state_hurt_attack={{{1,10},{29,56}},{{1,18},{29,3*18}}},
		state_stun_attacktime={{{1,130},{2,172}}},
		state_hurt_attacktime={{{1,110},{2,144}}},
		state_drag_attack={{{1,20},{20,40},{29,50}},{{1,11},{10,11}},{{1,12},{2,12}}},
		missile_speed_v={70},		
	},
	CLD200_1={ --?????,???????
		appenddamage_p= {{{1,75*FightSkill.tbParam.nS1},{10,75},{20,75*FightSkill.tbParam.nS20},{21,75*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,125*FightSkill.tbParam.nS1},{10,125},{20,125*FightSkill.tbParam.nS20},{21,125*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,850*0.9*FightSkill.tbParam.nS1},{10,850*0.9},{20,850*0.9*FightSkill.tbParam.nS20},{21,850*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,850*1.1*FightSkill.tbParam.nS1},{10,850*1.1},{20,850*1.1*FightSkill.tbParam.nS20},{21,850*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		state_stun_attack={{{1,10},{29,65}},{{1,18},{29,3*18}}},
		state_hurt_attack={{{1,10},{29,40}},{{1,18},{29,2*18}}},
		missile_speed_v={40},
		missile_range={4,0,4},
		missile_hitcount={{{1,2},{10,3},{20,3}}},
	},
	DMTT200={ --????
		appenddamage_p= {{{1,52*FightSkill.tbParam.nS1},{10,52},{20,52*FightSkill.tbParam.nS20},{21,52*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,450*FightSkill.tbParam.nS1},{10,450},{20,450*FightSkill.tbParam.nS20},{21,450*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,9*9},{20,9*9}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,10},{29,61}},{{1,18},{29,3*18}}},
		state_weak_attack={{{1,10},{29,47}},{{1,18},{29,4*28}}},
		state_weak_attacktime={{{1,110},{10,200}}},
		state_hurt_attacktime={{{1,110},{2,150}}},
		missile_hitcount={{{1,5},{2,5}}},
		skill_showevent={{{1,2},{20,2}}},
	},
	DMTT200_1={ --????,???????
		appenddamage_p= {{{1,52*FightSkill.tbParam.nS1},{10,52},{20,52*FightSkill.tbParam.nS20},{21,52*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,450*FightSkill.tbParam.nS1},{10,450},{20,450*FightSkill.tbParam.nS20},{21,450*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,9*9},{20,9*9}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,10},{29,45}},{{1,18},{29,3*18}}},
		state_weak_attack={{{1,10},{29,60}},{{1,18},{29,3*18}}},
	},
	DMHT200={ --???
		appenddamage_p= {{{1,93*FightSkill.tbParam.nS1},{10,93},{20,93*FightSkill.tbParam.nS20},{21,93*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,150},{2,170},{20,410},{29,800}},{{1,6*18},{29,6*18}}},
		skill_attackradius={520},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,150},{20,300},{21,300}}},
		state_hurt_attack={{{1,10},{29,40}},{{1,18},{29,4*18}}},
		state_weak_attack={{{1,10},{29,60}},{{1,18},{29,4*18}}},
		state_weak_attacktime={{{1,110},{10,170}}},
		state_drag_attack={{{1,10},{29,20}},{{1,3},{10,10},{20,10}},{{1,16},{2,16}}},
		state_knock_attack={{{1,10},{29,20}},{{1,3},{10,10},{20,10}},{{1,18},{2,18}}},		
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
	},
	DMHT200_1={ --????2
		appenddamage_p= {{{1,93*FightSkill.tbParam.nS1},{10,93},{20,93*FightSkill.tbParam.nS20},{21,93*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,150},{2,170},{20,410},{29,800}},{{1,6*18},{29,6*18}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_drag_attack={{{1,10},{29,20}},{{1,3},{10,10},{20,10}},{{1,16},{2,16}}},
		state_knock_attack={{{1,10},{29,20}},{{1,3},{10,10},{20,10}},{{1,18},{2,18}}},
		missile_hitcount={{{1,2},{10,3},{20,3},{21,3}}},
	},
	MN200={ --????
		appenddamage_p= {{{1,55*FightSkill.tbParam.nS1},{10,55},{20,55*FightSkill.tbParam.nS20},{21,55*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,630*0.9*FightSkill.tbParam.nS1},{10,630*0.9},{20,630*0.9*FightSkill.tbParam.nS20},{21,630*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,630*1.1*FightSkill.tbParam.nS1},{10,630*1.1},{20,630*1.1*FightSkill.tbParam.nS20},{21,630*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_burn_attack={{{1,10},{29,65}},{{1,18},{29,4*18}}},
		state_palsy_attack={{{1,5},{20,10},{29,19}},{{1,18*2},{29,3*18}}},
		state_burn_attacktime={{{1,50},{2,60}}},
		missile_speed_v={70},
	},
	MN200_1={ --????,???????
		appenddamage_p= {{{1,20*FightSkill.tbParam.nS1},{10,20},{20,20*FightSkill.tbParam.nS20},{21,20*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,423*0.9*FightSkill.tbParam.nS1},{10,423*0.9},{20,423*0.9*FightSkill.tbParam.nS20},{21,423*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,423*1.1*FightSkill.tbParam.nS1},{10,423*1.1},{20,423*1.1*FightSkill.tbParam.nS20},{21,423*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
	},
	
	CN200={ --???
		appenddamage_p= {{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,140*FightSkill.tbParam.nS1},{10,140},{20,140*FightSkill.tbParam.nS20},{21,140*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,1050*0.9*FightSkill.tbParam.nS1},{10,1050*0.9},{20,1050*0.9*FightSkill.tbParam.nS20},{21,1050*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,1050*1.1*FightSkill.tbParam.nS1},{10,1050*1.1},{20,1050*1.1*FightSkill.tbParam.nS20},{21,1050*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,10},{29,55}},{{1,18},{29,3*18}}},
		state_hurt_attacktime={{{1,110},{2,140}}},
		state_burn_attack={{{1,10},{29,60}},{{1,18},{29,4*18}}},
		state_burn_attacktime={{{1,140},{2,200}}},
		steallife_p={{{1,1},{20,10}},{{1,100},{20,100}}},
		stealmana_p={{{1,1},{20,10}},{{1,100},{20,100}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
	},
	CN200_1={ --???
		appenddamage_p= {{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,140*FightSkill.tbParam.nS1},{10,140},{20,140*FightSkill.tbParam.nS20},{21,140*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,1050*0.9*FightSkill.tbParam.nS1},{10,1050*0.9},{20,1050*0.9*FightSkill.tbParam.nS20},{21,1050*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,1050*1.1*FightSkill.tbParam.nS1},{10,1050*1.1},{20,1050*1.1*FightSkill.tbParam.nS20},{21,1050*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		state_hurt_attack={{{1,10},{29,35}},{{1,18},{29,3*18}}},
		state_burn_attack={{{1,10},{29,60}},{{1,18},{29,4*18}}},
		steallife_p={{{1,1},{20,10}},{{1,100},{20,100}}},
		stealmana_p={{{1,1},{20,10}},{{1,100},{20,100}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
	},
	
	MGK200={ --???? -- co the loi do chinh dong fixed
		appenddamage_p= {{{1,2*63*FightSkill.tbParam.nS1},{10,2*63},{20,2*63*FightSkill.tbParam.nS20},{21,2*63*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,2*2122*FightSkill.tbParam.nS1},{10,2*2122},{20,2*2122*FightSkill.tbParam.nS20},{21,2*2122*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,4*9},{20,4*9}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,150},{20,300},{21,300}}},
		state_weak_attack={{{1,10},{29,60}},{{1,18},{29,5*18}}},
		state_fixed_attack={{{1,5},{20,15},{29,18}},{{1,18*2},{29,2*18}}},
		state_weak_attacktime={{{1,150},{2,170}}},
		missile_range={4,0,4},
	},
	MGK200_1={ --????
		appenddamage_p= {{{1,2*48*FightSkill.tbParam.nS1},{10,2*48},{20,2*48*FightSkill.tbParam.nS20},{21,2*48*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,2*430*FightSkill.tbParam.nS1},{10,2*430},{20,2*430*FightSkill.tbParam.nS20},{21,2*430*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,4*9},{20,4*9}}},
		state_weak_attack={{{1,10},{29,60}},{{1,18},{29,2*18}}},
		sstate_weak_attack={{{1,10},{29,60}},{{1,18},{29,2*18}}},
		state_fixed_attack={{{1,5},{20,7},{29,8}},{{1,18*2},{29,2*18}}},
		missile_range={2,0,2},
	},
	MGK200_2={ --????
		appenddamage_p= {{{1,2*25*FightSkill.tbParam.nS1},{10,2*25},{20,2*25*FightSkill.tbParam.nS20},{21,2*25*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,2*300*FightSkill.tbParam.nS1},{10,2*300},{20,2*300*FightSkill.tbParam.nS20},{21,2*300*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,4*9},{20,4*9}}},
		state_weak_attack={{{1,10},{29,60}},{{1,18},{29,2*18}}},
		state_fixed_attack={{{1,5},{20,7},{29,8}},{{1,18*2},{29,2*18}}},
		missile_range={2,0,2},
	},
		
	MGC200={ --??? --sua thoi gian rut doc
		appenddamage_p= {{{1,65*FightSkill.tbParam.nS1},{10,65},{20,65*FightSkill.tbParam.nS20},{21,65*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,78*FightSkill.tbParam.nS1},{10,78},{20,78*FightSkill.tbParam.nS20},{21,78*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		poisondamage_v={{{1,982*FightSkill.tbParam.nS1},{10,982},{20,982*FightSkill.tbParam.nS20},{21,982*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},{{1,5*9},{20,5*9}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,27},{20,54},{21,54}}},
		skill_attackradius={160},
		state_hurt_attack={{{1,10},{29,65}},{{1,18},{29,4*18}}},
		state_weak_attack={{{1,10},{29,25}},{{1,18},{29,3*18}}},
		state_weak_attacktime={{{1,110},{2,140}}},
	},
	MGC200_1={ --???
		appenddamage_p= {{{1,65*FightSkill.tbParam.nS1},{10,65},{20,65*FightSkill.tbParam.nS20},{21,65*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,78*FightSkill.tbParam.nS1},{10,78},{20,78*FightSkill.tbParam.nS20},{21,78*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		poisondamage_v={{{1,982*FightSkill.tbParam.nS1},{10,982},{20,982*FightSkill.tbParam.nS20},{21,982*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},{{1,5*9},{20,5*9}}},
		state_hurt_attack={{{1,10},{29,65}},{{1,18},{29,4*18}}},
		state_weak_attack={{{1,10},{29,25}},{{1,18},{29,4*18}}},
	},
	TVC200={ --???_20
		appenddamage_p= {{{1,60*FightSkill.tbParam.nS1},{10,60},{20,60*FightSkill.tbParam.nS20},{21,60*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,95*FightSkill.tbParam.nS1},{10,95},{20,95*FightSkill.tbParam.nS20},{21,95*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,750*0.9*FightSkill.tbParam.nS1},{10,750*0.9},{20,750*0.9*FightSkill.tbParam.nS20},{21,750*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,750*1.1*FightSkill.tbParam.nS1},{10,750*1.1},{20,750*1.1*FightSkill.tbParam.nS20},{21,750*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		skill_cost_v={{{1,22},{20,45},{21,45}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,10},{29,70}},{{1,18},{29,4*18}}},
		state_hurt_attacktime={{{1,150},{2,170}}},
		missile_hitcount={{{1,4},{20,4}}},
	},
	TVC200_1={ --???_20
		appenddamage_p= {{{1,60*FightSkill.tbParam.nS1},{10,60},{20,60*FightSkill.tbParam.nS20},{21,60*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,95*FightSkill.tbParam.nS1},{10,95},{20,95*FightSkill.tbParam.nS20},{21,95*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,750*0.9*FightSkill.tbParam.nS1},{10,750*0.9},{20,750*0.9*FightSkill.tbParam.nS20},{21,750*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,750*1.1*FightSkill.tbParam.nS1},{10,750*1.1},{20,750*1.1*FightSkill.tbParam.nS20},{21,750*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		state_hurt_attack={{{1,10},{29,70}},{{1,18},{29,4*18}}},
		missile_hitcount={{{1,4},{20,4}}},
	},
	TVC200_2={ --???_20
		appenddamage_p= {{{1,60*FightSkill.tbParam.nS1},{10,60},{20,60*FightSkill.tbParam.nS20},{21,60*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,95*FightSkill.tbParam.nS1},{10,95},{20,95*FightSkill.tbParam.nS20},{21,95*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,750*0.9*FightSkill.tbParam.nS1},{10,750*0.9},{20,750*0.9*FightSkill.tbParam.nS20},{21,750*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,750*1.1*FightSkill.tbParam.nS1},{10,750*1.1},{20,750*1.1*FightSkill.tbParam.nS20},{21,750*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		state_hurt_attack={{{1,10},{29,70}},{{1,18},{29,4*18}}},
		missile_hitcount={{{1,4},{20,4}}},
	},
	TVT200={ --????
		appenddamage_p= {{{1,60*FightSkill.tbParam.nS1},{10,60},{20,60*FightSkill.tbParam.nS20},{21,60*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,670*0.9*FightSkill.tbParam.nS1},{10,670*0.9},{20,670*0.9*FightSkill.tbParam.nS20},{21,670*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,670*1.1*FightSkill.tbParam.nS1},{10,670*1.1},{20,670*1.1*FightSkill.tbParam.nS20},{21,670*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,22},{20,45},{21,45}}},
		state_hurt_attack={{{1,10},{29,70}},{{1,18},{29,3*18}}},
		state_hurt_attacktime={{{1,220},{2,232}}},
		missile_hitcount={{{1,4},{20,4}}},
	},
	TVT200_1={ --????
		appenddamage_p= {{{1,60*FightSkill.tbParam.nS1},{10,60},{20,60*FightSkill.tbParam.nS20},{21,60*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,670*0.9*FightSkill.tbParam.nS1},{10,670*0.9},{20,670*0.9*FightSkill.tbParam.nS20},{21,670*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,670*1.1*FightSkill.tbParam.nS1},{10,670*1.1},{20,670*1.1*FightSkill.tbParam.nS20},{21,670*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		state_hurt_attack={{{1,10},{29,70}},{{1,18},{29,3*18}}},
		missile_hitcount={{{1,4},{20,4}}},
	},
	TVT200_2={ --????
		appenddamage_p= {{{1,60*FightSkill.tbParam.nS1},{10,60},{20,60*FightSkill.tbParam.nS20},{21,60*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,670*0.9*FightSkill.tbParam.nS1},{10,670*0.9},{20,670*0.9*FightSkill.tbParam.nS20},{21,670*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,670*1.1*FightSkill.tbParam.nS1},{10,670*1.1},{20,670*1.1*FightSkill.tbParam.nS20},{21,670*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		state_hurt_attack={{{1,10},{29,70}},{{1,18},{29,3*18}}},
		missile_hitcount={{{1,4},{20,4}}},
	},
}
FightSkill:AddMagicData(tb) 