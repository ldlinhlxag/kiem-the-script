Require("\\script\\fightskill\\fightskill.lua")
--ͬ��
local tb	= {
	yishouyinyang={ --��������
        lifemax_p={{{1,12},{3,72*FightSkill.tbParam.nTongBan/100},{6,72},{7,72*FightSkill.tbParam.nTAdd}}},
		manamax_p={{{1,6},{3,36*FightSkill.tbParam.nTongBan/100},{6,36},{7,36*FightSkill.tbParam.nTAdd}}},
		lifemax_v={{{1,120},{3,720*FightSkill.tbParam.nTongBan/100},{6,720},{7,720*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	yishouyinyang_jue={ --������������
		lifemax_p={{{1,9},{3,56*FightSkill.tbParam.nTongBan/100},{6,56},{7,56*FightSkill.tbParam.nTAdd}}},
		manamax_p={{{1,5},{3,28*FightSkill.tbParam.nTongBan/100},{6,28},{7,28*FightSkill.tbParam.nTAdd}}},
		lifemax_v={{{1,90},{3,560*FightSkill.tbParam.nTongBan/100},{6,560},{7,560*FightSkill.tbParam.nTAdd}}},
		state_hurt_resisttime={{{1,45},{3,280*FightSkill.tbParam.nTongBan/100},{6,280},{7,280*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
	yishouyinyang_ji={ --������������
		lifemax_p={{{1,9},{3,56*FightSkill.tbParam.nTongBan/100},{6,56},{7,56*FightSkill.tbParam.nTAdd}}},
		manamax_p={{{1,5},{3,28*FightSkill.tbParam.nTongBan/100},{6,28},{7,28*FightSkill.tbParam.nTAdd}}},
		lifemax_v={{{1,90},{3,560*FightSkill.tbParam.nTongBan/100},{6,560},{7,560*FightSkill.tbParam.nTAdd}}},
        state_weak_resisttime={{{1,45},{3,280*FightSkill.tbParam.nTongBan/100},{6,280},{7,280*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
	yishouyinyang_zhen={ --������������
		lifemax_p={{{1,9},{3,56*FightSkill.tbParam.nTongBan/100},{6,56},{7,56*FightSkill.tbParam.nTAdd}}},
		manamax_p={{{1,5},{3,28*FightSkill.tbParam.nTongBan/100},{6,28},{7,28*FightSkill.tbParam.nTAdd}}},
		lifemax_v={{{1,90},{3,560*FightSkill.tbParam.nTongBan/100},{6,560},{7,560*FightSkill.tbParam.nTAdd}}},
		state_slowall_resisttime={{{1,45},{3,280*FightSkill.tbParam.nTongBan/100},{6,280},{7,280*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
	yishouyinyang_han={ --������������
		lifemax_p={{{1,9},{3,56*FightSkill.tbParam.nTongBan/100},{6,56},{7,56*FightSkill.tbParam.nTAdd}}},
		manamax_p={{{1,5},{3,28*FightSkill.tbParam.nTongBan/100},{6,28},{7,28*FightSkill.tbParam.nTAdd}}},
		lifemax_v={{{1,90},{3,560*FightSkill.tbParam.nTongBan/100},{6,560},{7,560*FightSkill.tbParam.nTAdd}}},
		state_burn_resisttime={{{1,45},{3,280*FightSkill.tbParam.nTongBan/100},{6,280},{7,280*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
	yishouyinyang_ming={ --����������ڤ
		lifemax_p={{{1,9},{3,56*FightSkill.tbParam.nTongBan/100},{6,56},{7,56*FightSkill.tbParam.nTAdd}}},
		manamax_p={{{1,5},{3,28*FightSkill.tbParam.nTongBan/100},{6,28},{7,28*FightSkill.tbParam.nTAdd}}},
		lifemax_v={{{1,90},{3,560*FightSkill.tbParam.nTongBan/100},{6,560},{7,560*FightSkill.tbParam.nTAdd}}},
		state_stun_resisttime={{{1,45},{3,280*FightSkill.tbParam.nTongBan/100},{6,280},{7,280*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	rumuchunfeng_jue={ --���崺�硤��
		lifemax_p={{{1,9},{3,56*FightSkill.tbParam.nTongBan/100},{6,56},{7,56*FightSkill.tbParam.nTAdd}}},
		manamax_p={{{1,5},{3,28*FightSkill.tbParam.nTongBan/100},{6,28},{7,28*FightSkill.tbParam.nTAdd}}},
		lifemax_v={{{1,90},{3,560*FightSkill.tbParam.nTongBan/100},{6,560},{7,560*FightSkill.tbParam.nTAdd}}},
		state_hurt_resisttime={{{1,45},{3,280*FightSkill.tbParam.nTongBan/100},{6,280},{7,280*FightSkill.tbParam.nTAdd}}},
		expenhance_p={{{1,6},{3,24*FightSkill.tbParam.nTongBan/100},{6,24},{7,24*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
	rumuchunfeng_ji={ --���崺�硤��
		lifemax_p={{{1,9},{3,56*FightSkill.tbParam.nTongBan/100},{6,56},{7,56*FightSkill.tbParam.nTAdd}}},
		manamax_p={{{1,5},{3,28*FightSkill.tbParam.nTongBan/100},{6,28},{7,28*FightSkill.tbParam.nTAdd}}},
		lifemax_v={{{1,90},{3,560*FightSkill.tbParam.nTongBan/100},{6,560},{7,560*FightSkill.tbParam.nTAdd}}},
        state_weak_resisttime={{{1,45},{3,280*FightSkill.tbParam.nTongBan/100},{6,280},{7,280*FightSkill.tbParam.nTAdd}}},
		expenhance_p={{{1,6},{3,24*FightSkill.tbParam.nTongBan/100},{6,24},{7,24*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
		rumuchunfeng_zhen={ --���崺�硤��
		lifemax_p={{{1,9},{3,56*FightSkill.tbParam.nTongBan/100},{6,56},{7,56*FightSkill.tbParam.nTAdd}}},
		manamax_p={{{1,5},{3,28*FightSkill.tbParam.nTongBan/100},{6,28},{7,28*FightSkill.tbParam.nTAdd}}},
		lifemax_v={{{1,90},{3,560*FightSkill.tbParam.nTongBan/100},{6,560},{7,560*FightSkill.tbParam.nTAdd}}},
		state_slowall_resisttime={{{1,45},{3,280*FightSkill.tbParam.nTongBan/100},{6,280},{7,280*FightSkill.tbParam.nTAdd}}},
		expenhance_p={{{1,6},{3,24*FightSkill.tbParam.nTongBan/100},{6,24},{7,24*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
	rumuchunfeng_han={ --���崺�硤��
		lifemax_p={{{1,9},{3,56*FightSkill.tbParam.nTongBan/100},{6,56},{7,56*FightSkill.tbParam.nTAdd}}},
		manamax_p={{{1,5},{3,28*FightSkill.tbParam.nTongBan/100},{6,28},{7,28*FightSkill.tbParam.nTAdd}}},
		lifemax_v={{{1,90},{3,560*FightSkill.tbParam.nTongBan/100},{6,560},{7,560*FightSkill.tbParam.nTAdd}}},
		state_burn_resisttime={{{1,45},{3,280*FightSkill.tbParam.nTongBan/100},{6,280},{7,280*FightSkill.tbParam.nTAdd}}},
		expenhance_p={{{1,6},{3,24*FightSkill.tbParam.nTongBan/100},{6,24},{7,24*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
	rumuchunfeng_ming={ --���崺�硤ڤ
		lifemax_p={{{1,9},{3,56*FightSkill.tbParam.nTongBan/100},{6,56},{7,56*FightSkill.tbParam.nTAdd}}},
		manamax_p={{{1,5},{3,28*FightSkill.tbParam.nTongBan/100},{6,28},{7,28*FightSkill.tbParam.nTAdd}}},
		lifemax_v={{{1,90},{3,560*FightSkill.tbParam.nTongBan/100},{6,560},{7,560*FightSkill.tbParam.nTAdd}}},
		state_stun_resisttime={{{1,45},{3,280*FightSkill.tbParam.nTongBan/100},{6,280},{7,280*FightSkill.tbParam.nTAdd}}},
		expenhance_p={{{1,6},{3,24*FightSkill.tbParam.nTongBan/100},{6,24},{7,24*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
     wuxingwuxiang={ --��������
		damage_all_resist={{{1,14},{3,84*FightSkill.tbParam.nTongBan/100},{6,84},{7,84*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	        
	wuxingwuxiang_fushi={ --�������ࡤ��ʯ
		damage_all_resist={{{1,11},{3,66*FightSkill.tbParam.nTongBan/100},{6,66},{7,66*FightSkill.tbParam.nTAdd}}},
		damage_physics_resist={{{1,7},{3,42*FightSkill.tbParam.nTongBan/100},{6,42},{7,42*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
	wuxingwuxiang_zhuchan={ --�������ࡤ���
		damage_all_resist={{{1,11},{3,66*FightSkill.tbParam.nTongBan/100},{6,66},{7,66*FightSkill.tbParam.nTAdd}}},
		damage_poison_resist={{{1,15},{3,90*FightSkill.tbParam.nTongBan/100},{6,90},{7,90*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
	wuxingwuxiang_nishui={ --�������ࡤ��ˮ
		damage_all_resist={{{1,11},{3,66*FightSkill.tbParam.nTongBan/100},{6,66},{7,66*FightSkill.tbParam.nTAdd}}},
		damage_cold_resist={{{1,15},{3,90*FightSkill.tbParam.nTongBan/100},{6,90},{7,90*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
	wuxingwuxiang_yueguang={ --�������ࡤԽ��
		damage_all_resist={{{1,11},{3,66*FightSkill.tbParam.nTongBan/100},{6,66},{7,66*FightSkill.tbParam.nTAdd}}},
		damage_fire_resist={{{1,15},{3,90*FightSkill.tbParam.nTongBan/100},{6,90},{7,90*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
	wuxingwuxiang_jumu={ --�������ࡤ��ľ
		damage_all_resist={{{1,11},{3,66*FightSkill.tbParam.nTongBan/100},{6,66},{7,66*FightSkill.tbParam.nTAdd}}},
		damage_light_resist={{{1,15},{3,90*FightSkill.tbParam.nTongBan/100},{6,90},{7,90*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
	zhuiyingjue={ --׷Ӱ��
		ignoredefenseenhance_v={{{1,80},{3,480*FightSkill.tbParam.nTongBan/100},{6,480},{7,480*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
	wunianjing={ --���
		ignoredefenseenhance_v={{{1,64},{3,384*FightSkill.tbParam.nTongBan/100},{6,384},{7,384*FightSkill.tbParam.nTAdd}}},
		attackratingenhance_p={{{1,28},{3,128*FightSkill.tbParam.nTongBan/100},{6,128},{7,128*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},		
	huishenjingxin={ --������
		deadlystrikeenhance_r={{{1,60},{3,360*FightSkill.tbParam.nTongBan/100},{6,360},{7,360*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},			
	jinghongyiji={ --����һ��
		deadlystrikeenhance_r={{{1,48},{3,288*FightSkill.tbParam.nTongBan/100},{6,288},{7,288*FightSkill.tbParam.nTAdd}}},
		deadlystrikedamageenhance_p={{{1,6},{3,36*FightSkill.tbParam.nTongBan/100},{6,36},{7,36*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
	tabumizong={ --̤������
		adddefense_v={{{1,80},{3,480*FightSkill.tbParam.nTongBan/100},{6,480},{7,480*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
	xukongshanying={ --�����Ӱ
		adddefense_v={{{1,64},{3,384*FightSkill.tbParam.nTongBan/100},{6,384},{7,384*FightSkill.tbParam.nTAdd}}},
        defencedeadlystrikedamagetrim={{{1,5},{3,30*FightSkill.tbParam.nTongBan/100},{6,30},{7,30*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},	
    miaoshouhuichun={ --���ֻش�
	    fastlifereplenish_v={{{1,25},{3,150*FightSkill.tbParam.nTongBan/100},{6,150},{7,150*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
    cibeixiyu={ --�ȱ�ϸ��
	    fastlifereplenish_v={{{1,20},{3,120*FightSkill.tbParam.nTongBan/100},{6,120},{7,120*FightSkill.tbParam.nTAdd}}},
	    fastmanareplenish_v={{{1,16},{3,96*FightSkill.tbParam.nTongBan/100},{6,96},{7,96*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	pokongzhanying={ --�ƿ�նӰ
		skilldamageptrim={{{1,3},{3,18*FightSkill.tbParam.nTongBan/100},{6,18},{7,18*FightSkill.tbParam.nTAdd}}},
		skillselfdamagetrim={{{1,3},{3,18*FightSkill.tbParam.nTongBan/100},{6,18},{7,18*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	pokongzhanying_xuanwu={ --�ƿ�նӰ������
		skilldamageptrim={{{1,2},{3,12*FightSkill.tbParam.nTongBan/100},{6,12},{7,12*FightSkill.tbParam.nTAdd}}},
		skillselfdamagetrim={{{1,2},{3,12*FightSkill.tbParam.nTongBan/100},{6,12},{7,12*FightSkill.tbParam.nTAdd}}},
		state_slowall_attacktime={{{1,40},{3,280*FightSkill.tbParam.nTongBan/100},{6,280},{7,280*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	pokongzhanying_huanglong={ --�ƿ�նӰ������
		skilldamageptrim={{{1,2},{3,12*FightSkill.tbParam.nTongBan/100},{6,12},{7,12*FightSkill.tbParam.nTAdd}}},
		skillselfdamagetrim={{{1,2},{3,12*FightSkill.tbParam.nTongBan/100},{6,12},{7,12*FightSkill.tbParam.nTAdd}}},
		state_stun_attacktime={{{1,40},{3,280*FightSkill.tbParam.nTongBan/100},{6,280},{7,280*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	pokongzhanying_qinglong={ --�ƿ�նӰ������
		skilldamageptrim={{{1,2},{3,12*FightSkill.tbParam.nTongBan/100},{6,12},{7,12*FightSkill.tbParam.nTAdd}}},
		skillselfdamagetrim={{{1,2},{3,12*FightSkill.tbParam.nTongBan/100},{6,12},{7,12*FightSkill.tbParam.nTAdd}}},
		state_weak_attacktime={{{1,40},{3,280*FightSkill.tbParam.nTongBan/100},{6,280},{7,280*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	pokongzhanying_baihu={ --�ƿ�նӰ���׻�
		skilldamageptrim={{{1,2},{3,12*FightSkill.tbParam.nTongBan/100},{6,12},{7,12*FightSkill.tbParam.nTAdd}}},
		skillselfdamagetrim={{{1,2},{3,12*FightSkill.tbParam.nTongBan/100},{6,12},{7,12*FightSkill.tbParam.nTAdd}}},
		state_hurt_attacktime={{{1,40},{3,280*FightSkill.tbParam.nTongBan/100},{6,280},{7,280*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	pokongzhanying_zhuque={ --�ƿ�նӰ����ȸ
		skilldamageptrim={{{1,2},{3,12*FightSkill.tbParam.nTongBan/100},{6,12},{7,12*FightSkill.tbParam.nTAdd}}},
		skillselfdamagetrim={{{1,2},{3,12*FightSkill.tbParam.nTongBan/100},{6,12},{7,12*FightSkill.tbParam.nTAdd}}},
		state_burn_attacktime={{{1,40},{3,280*FightSkill.tbParam.nTongBan/100},{6,280},{7,280*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	ganyulinhua={ --�����ػ�
		lifereplenish_p={{{1,4},{3,24*FightSkill.tbParam.nTongBan/100},{6,24},{7,24*FightSkill.tbParam.nTAdd}}},
		manareplenish_p={{{1,2},{3,12*FightSkill.tbParam.nTongBan/100},{6,12},{7,12*FightSkill.tbParam.nTAdd}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
}
FightSkill:AddMagicData(tb)