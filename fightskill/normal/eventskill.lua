--���ա������
local tb	= {

	--2009����
	snowball_damage={
		appenddamage_p={{{1,0},{2,0}}},
		magicdamage_v={
			[1]={{1,1},{2,2},{3,3},{4,4}},
			[3]={{1,1},{2,2},{3,3},{4,4}}
		},
		missile_speed_v={40},
	},
	snowball_xuejinzhen={
		appenddamage_p={{{1,0},{2,0}}},
		magicdamage_v={
			[1]={{1,1},{2,2},{3,3},{4,3}},
			[3]={{1,1},{2,2},{3,3},{4,3}}
		},
		missile_speed_v={60},
	},
	snowball_fixed={
		state_fixed_attack={{{1,100},{2,100}},{{1,18*1},{2,18*1},{3,18*1},{4,18*2}}},
	},
	snowball_freeze={
		state_freeze_attack={{{1,100},{2,100}},{{1,18*2},{2,18*2},{3,18*2},{4,18*2}}},
	},
	snowball_confuse={
		state_confuse_attack={{{1,100},{2,100}},{{1,18*1},{2,18*1},{3,18*1},{4,18*1}}},
	},
	snowball_stun={
		state_stun_attack={{{1,100},{2,100}},{{1,18*1},{2,18*1},{3,18*1},{4,18*2}}},
	},
	snowball_slowall={
		state_slowall_attack={{{1,100},{2,100}},{{1,18*2},{2,18*2},{3,18*1},{4,18*2}}},
	},
	snowball_duixueji={
		state_stun_attack={{{1,100},{2,100}},{{1,18*1},{2,18*1},{3,18*1},{4,18*2}}},
		appenddamage_p={{{1,0},{2,0}}},
		magicdamage_v={
			[1]={{1,1},{2,2},{3,3},{4,3}},
			[3]={{1,1},{2,2},{3,3},{4,3}}
		},
		missile_speed_v={40},
	},
	snowball_water={
		state_slowall_attack={{{1,100},{2,100}},{{1,18*3},{5,18*3}}},
		appenddamage_p={{{1,0},{2,0}}},
		magicdamage_v={
			[1]={{1,1},{2,2},{3,3},{4,3}},
			[3]={{1,1},{2,2},{3,3},{4,3}}
		},
	},
	tabingjue={
		fastwalkrun_p={{{1,10},{2,20}}},
		skill_statetime={{{1,18*30},{2,18*30}}},
	},
	chengshuangshi={
		addenchant={21, {{1,1}, {2, 2}}},
		skill_statetime={{{1,18*30},{2,18*30}}},
	},
	snowglove={
		addenchant={22, {{1,1}, {2, 2}}},
		skill_statetime={{{1,18*30},{2,18*30}}},
	},
	xueyingwu={
		state_slowall_ignore={1},
		state_stun_ignore={1},
		state_fixed_ignore={1},
		state_freeze_ignore={1},
		state_confuse_ignore={1},
		skill_statetime={{{1,18*30},{2,18*30}}},
	},
	jiangbinyu={
		prop_invincibility={1},
		skill_statetime={{{1,18*20},{2,18*20}}},
	},
	newyearmonsteratk={		--���������޹�������
		appenddamage_p={{{1,0},{2,0}}},
		magicdamage_v={
			[1]={{1,1},{2,2},{3,3},{4,3}},
			[3]={{1,1},{2,2},{3,3},{4,3}}
		},
	},
	newyear_transmutation={ --������
		domainchangeself={{{1,3605},{2,3606},{3,3607},{4,3608},{5,4286},{8,4289},{9,4483}},{{1,1},{2,1}}},
		adddomainskill1={{{1,1300},{4,1300},{5,1451},{8,1451},{9,1430}},{{1,1},{20,1}}},
		adddomainskill2={{{1,0},{4,0},{5,0},{8,0},{9,0}},{{1,2},{20,2}}},
		skill_statetime={{{1,18*60*30},{10,18*60*30},{11,18*60*30}}},
	},
	addpower1329={ --���޳�̹�����͸�������
		--addpowerwhencol = {1329, {{1,10}, {10, 10}}, {{1,200}, {10, 200}}},
		skill_statetime={{{1,18*60*30},{10,18*60*30},{11,18*60*30}}},
	},
---------------------------------------
--��������ۼ���
--1���췣,2���̶�����,3������,4�����ѧϰ,11��ײǽ
	lz_chihuan={ --�ı�,�ٻ�5��
		state_slowall_attack	={{{1,100},{10,100},{11,1000}},{{1,18*5},{2,18*5},{10,18*5},{11,18*6}}},
	},
	lz_yunxuan={ --����,��ѣ2��
		state_stun_attack		={{{1,100},{10,100},{11,1000}},{{1,18*2},{2,18*2},{10,18*2},{11,18*3}}},
	},
	lz_dingshen={ --����,����3��
		state_fixed_attack		={{{1,100},{10,100},{11,1000}},{{1,18*3},{2,18*3},{10,18*3},{11,18*4}}},
	},
	lz_hunluan={ --����,����2��
		state_confuse_attack	={{{1,100},{10,100},{11,1000}},{{1,18*2},{2,18*3},{10,18*4},{11,18*3}}},
	},
	lz_lahui={ --����,���ض���
		state_drag_attack		={{{1,100},{10,100},{11,1000}},{{1,25},{10,25}},{{1,32},{2,32}}},
		state_fixed_attack		={{{1,100},{10,100},{11,1000}},{{1,18*3},{10,18*3},{11,18*3}}},
	},
	lz_jitui={ --ɨβ,����400
		state_knock_attack		={{{1,100},{10,100},{11,1000}},{{1,20},{10,20}},{{1,20},{2,20}}},
	},

--��������
	shifu={ --ʯ��,���ٻ��Ͷ���40%
		state_slowall_resistrate={{{1,166},{2,166}}},
		state_fixed_resistrate={{{1,166},{2,166}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	longxin={ --����,���ٻ��ͻ���40%
		state_slowall_resistrate={{{1,166},{2,166}}},
		state_confuse_resistrate={{{1,166},{2,166}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	haihun={ --����,���ٻ�����ѣ40%
		state_slowall_resistrate={{{1,166},{2,166}}},
		state_stun_resistrate={{{1,166},{2,166}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	nilin={ --����,�����и��漸��30%
		allseriesstateresistrate={{{1,107},{2,107}}},
		allspecialstateresistrate={{{1,107},{2,107}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
--��������
	zhuihunyin={ --׷����,�������50%,����6��
		fastwalkrun_p={{{1,50},{2,50}}},
		skill_statetime={{{1,6*18},{2,6*18}}},
	},
	zhaohunqu={ --�л���,���߸���״̬8��
		state_fixed_ignore={1},
		state_stun_ignore={1},
		state_slowall_ignore={1},
		state_knock_ignore={1},
		state_drag_ignore={1},
		state_confuse_ignore={1},
		skill_statetime={{{1,8*18},{2,8*18}}},
	},
	huihunjue={ --�ػ��,����8��
		hide={0,{{1,8*18},{2,8*18}}, 1},
	},

	longzhou_transmutation={ --������
		domainchangeself={{{1,3645},{2,3646},{3,3647},{4,3648}},{{1,99},{2,99}}},
		skill_statetime={{{1,18*60*30},{10,18*60*30},{11,18*60*30}}},
	},
-----------------��Ů�⻷----------------------
	bellebuff={
		autoskill={{{1,50},{2,50}},{{1,1},{2,2}}},
	},
	bellebuff_team={
		expenhance_p=	{{{1,5},{2,10}}},
		lucky_v=		{{{1,5},{2,10}}},
	},
-------------------������ս--------------------
	spectator_state={
		hide_all={{{1,1},{10,1}}},
	},
------------------���Ｐ����---------------------
	defencestate={--���ܱ�����
		defense_state={1}
	},
------------------���ϵͳ---------------------
	jiehunxitongyanhua={ --���ϵͳ�̻�
		skill_startevent={{{1,1529},{2,1530}}},
		skill_showevent={{{1,1},{20,1}}},
		skill_startevent={{{1,1529},{2,1530}}},
		skill_showevent={{{1,1},{20,1}}},
	},
	jiehunxitongziti={ --���ϵͳ����
		skill_startevent={{{1,1556},{2,1557}}},
		skill_showevent={{{1,1},{20,1}}},
		skill_startevent={{{1,1556},{2,1557}}},
		skill_showevent={{{1,1},{20,1}}},
	},
----------------------------------������ֲ���ս��ʬ-----------------------------------	
	npc_liferefleshstate2={	--ÿ5�������ظ�
		lifereplenish_v={{{1,5},{2,10},{3,15}}},
	},
	npc_maxhpstate2={	--������������
		lifemax_p={{{1,5},{2,10}}},
	},
	qingming_transmutation={ --������
		domainchangeself={{{1,6692},{6,6697}},{{1,100},{2,100}}},
		adddomainskill1={{{1,1616},{4,1616}},{{1,1},{20,1}}},
		adddomainskill2={{{1,0},{4,0},{5,0},{8,0},{9,0}},{{1,2},{20,2}}},
		skill_statetime={{{1,18*60*30},{10,18*60*30},{11,18*60*30}}},
	},
	npc_changehp={	--�Ӽ�Ѫ
		fastlifereplenish_v={{{1,30},{2,-30}}},
	},
--��������ҿ��Ƽ���
	qmj_chihuan={ --�ı�,�ٻ�5��
		state_slowall_attack	={{{1,100},{10,100},{11,1000}},{{1,18*5},{2,18*5},{10,18*5},{11,18*6}}},
		magicdamage_v={
			[1]={{1,2},{2,2}},
			[3]={{1,2},{2,2}}
		},
	},
	qmj_yunxuan={ --����,��ѣ2��
		state_stun_attack		={{{1,100},{10,100},{11,1000}},{{1,18*2},{2,18*2},{10,18*2},{11,18*3}}},
		magicdamage_v={
			[1]={{1,2},{2,2}},
			[3]={{1,2},{2,2}}
		},
	},
	qmj_dingshen={ --����,����3��
		state_fixed_attack		={{{1,100},{10,100},{11,1000}},{{1,18*3},{2,18*3},{10,18*3},{11,18*4}}},
		magicdamage_v={
			[1]={{1,2},{2,2}},
			[3]={{1,2},{2,2}}
		},
	},
	qmj_hunluan={ --����,����2��
		state_confuse_attack	={{{1,100},{10,100},{11,1000}},{{1,18*2},{2,18*3},{10,18*4},{11,18*3}}},
		magicdamage_v={
			[1]={{1,2},{2,2}},
			[3]={{1,2},{2,2}}
		},
	},
	qmj_lahui={ --����,���ض���
		state_drag_attack		={{{1,100},{10,100},{11,1000}},{{1,25},{10,25}},{{1,32},{2,32}}},
		state_fixed_attack		={{{1,100},{10,100},{11,1000}},{{1,18*3},{10,18*3},{11,18*3}}},
		magicdamage_v={
			[1]={{1,2},{2,2}},
			[3]={{1,2},{2,2}}
		},
	},
	qmj_jitui={ --ɨβ,����400
		state_knock_attack		={{{1,100},{10,100},{11,1000}},{{1,20},{10,20}},{{1,20},{2,20}}},
		magicdamage_v={
			[1]={{1,2},{2,2}},
			[3]={{1,2},{2,2}}
		},
	},
-------------------------------------5.1�-------------------------------------------------
	workday_transmutation={ --������
		--����1,����npcid,����2����npc�ȼ�,����3��������:1�����,2������,4�ı似��
		domainchangeself={{{1,6807},{5,6811},{6,6811}},{{1,100},{2,100}},{{1,1},{2,1}}},
		skill_statetime={{{1,18*60*60},{10,18*60*60},{11,18*60*60}}},
	},
}

FightSkill:AddMagicData(tb)

local tbSkill	= FightSkill:GetClass("bellebuff");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("\nÿ��%s���ͷţ�<color=green>�»�ǧ��<color>\n����ֵ������<color=gold>%s��<color>\nɱ�����˵ľ��飺����<color=gold>%s%%<color>\n����ʱ��<color=gold>%s��<color>",
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime),
		tbChildInfo.tbWholeMagic["lucky_v"][1],
		tbChildInfo.tbWholeMagic["expenhance_p"][1],
		FightSkill:Frame2Sec(tbChildInfo.nStateTime));
	return szMsg;
end;
