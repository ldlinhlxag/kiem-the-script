--�󷨼���
local tb	= {
	wuxingzhen={
		lifemax_p=			{{{1,1},{5,5}}},
		expenhance_p=		{{{1,1},{5,5}}},
		lucky_v=			{{{1,1},{5,5}}},
		manareplenish_v=	{{{1,2},{5,10}}},
	},
--����������ϵ��֮������Ч��
	zhenfa1_5_n={
		lifemax_p=			{{{1,5},{5,25}}},
		manamax_p=			{{{1,5},{5,25}}},
		lifereplenish_p=	{{{1,2},{5,10}}},
		manareplenish_p=	{{{1,2},{5,10}}},
		adddefense_v=		{{{1,30},{5,150}}},
	},
--����������ϵ��֮Զ����Ч��
	zhenfa1_f={
		state_hurt_resistrate=	{{{1,15},{5,75}}},
		damage_physics_resist=	{{{1,16},{5,80}}},
	},
	zhenfa2_f={
		state_weak_resistrate=	{{{1,15},{5,75}}},
		damage_physics_resist=	{{{1,8},{5,40}}},
		damage_poison_resist=	{{{1,10},{5,50}}},
	},
	zhenfa3_f={
		state_slowall_resistrate=	{{{1,15},{5,75}}},
		damage_physics_resist=		{{{1,8},{5,40}}},
		damage_cold_resist=			{{{1,10},{5,50}}},
	},
	zhenfa4_f={
		state_burn_resistrate=	{{{1,15},{5,75}}},
		damage_physics_resist=	{{{1,8},{5,40}}},
		damage_fire_resist=		{{{1,10},{5,50}}},
	},
	zhenfa5_f={
		state_stun_resistrate=	{{{1,15},{5,75}}},
		damage_physics_resist=	{{{1,8},{5,40}}},
		damage_light_resist=	{{{1,10},{5,50}}},
	},
--��߹������͹���Ч��
	zhenfa6_n={
		skilldamageptrim=		{{{1,1},{5,5}}},
		skillselfdamagetrim=	{{{1,1},{5,5}}},
		ignoredefenseenhance_v=	{{{1,30},{5,150}}},
	},
	zhenfa6_f={
		state_weak_attackrate=		{{{1,15},{5,75}}},
		state_stun_attackrate=		{{{1,15},{5,75}}},
		state_burn_attackrate=		{{{1,15},{5,75}}},
		state_hurt_attackrate=		{{{1,15},{5,75}}},
		state_slowall_attackrate=	{{{1,15},{5,75}}},
	},
--�ӻ����˺�
	zhenfa7_n={
		deadlystrikedamageenhance_p={{{1,3},{5,15}}},
	},
	zhenfa7_f={
		deadlystrikedamageenhance_p={{{1,3},{5,15}}},
	},
--�������˺�
	zhenfa8_n={
		defencedeadlystrikedamagetrim={{{1,3},{5,15}}},
	},
	zhenfa8_f={
		defencedeadlystrikedamagetrim={{{1,3},{5,15}}},
	},
--Զ�̷���,�������ֻ�н��̷�������
	zhenfa9_n={
		rangedamagereturn_p={{{1,2},{5,10}}},
	},
	zhenfa9_f={
		rangedamagereturn_p={{{1,3},{5,15}}},
	},
--�����ܵ��ķ����˺�
	zhenfa10_n={
		damage_return_receive_p={{{1,-2},{5,-10}}},
	},
	zhenfa10_f={
		damage_return_receive_p={{{1,-4},{5,-20}}},
	},
--������
	baihuazhen={
		lucky_v={{{1,5},{2,10},{55,275},{56,275}}},
	},
}

FightSkill:AddMagicData(tb)
