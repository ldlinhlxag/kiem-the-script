--boss����
local tb	= {
	--------------------------------55������boss������boss�ü���-----------------------
	boss_jinzhongzhao={ --������
		fastwalkrun_p={{{1,60},{20,60}}},
		state_hurt_ignore={1},
		state_weak_ignore={1},
		state_slowall_ignore={1},
		state_burn_ignore={1},
		state_stun_ignore={1},
		damage_all_resist={{{1,80},{2,80},{10,100},{20,260}}},
		skill_statetime={{{1,18*180},{20,18*300}}}
	},
	boss_duanhunci={ --�ϻ��
		state_fixed_attack={{{1,100},{10,100},{20,100}},{{1,18*1.5},{20,18*1.5}}},
		skill_eventskilllevel={{{1,1},{2,2},{3,3}}},
		skill_collideevent={{{1,551},{2,551},{3,564}}},
	--	skill_cost_v={{{1,20},{20,50}}},
	},
	boss_yangguansandie={ --��������
	--	physicsenhance_p={{{1,5},{10,140},{20,240}}},
		physicsdamage_v={
			[1]={{1,600*0.9},{2,400*0.9}},
			[3]={{1,600*1.1},{2,400*1.1}}
			},
	--	attackrating_p={{{1,30},{20,60}}},
		state_hurt_attack={{{1,50},{20,50}},{{1,18*1.5},{20,18*1.5}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,100},{20,100}}},
	},
	boss_shizihou={ --ʨ�Ӻ�
		state_fixed_attack={{{1,85},{10,85},{20,100}},{{1,18*3},{20,18*3}}},
	},
	boss_fixed={ --����
		state_fixed_attack={{{1,50},{20,50}},{{1,18*5},{20,18*5}}},
	},
	boss_fixedaoe={ --����ȫ������
		physicsdamage_v={
			[1]={{1,1200*0.9},{2,1000*0.9},{20,1200*0.9}},
			[3]={{1,1200*1.1},{2,1000*1.1},{20,1200*1.1}}
			},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,100},{20,100}}},		
		},
	boss_qixingluoshagun={ --������ɲ��
	--	physicsenhance_p={{{1,10},{20,400}}},
	--	attackrating_p={{{1,10},{20,30}}},
		physicsdamage_v={
			[1]={{1,800*0.9},{2,550*0.9},{20,1000*0.9}},
			[3]={{1,800*1.1},{2,550*1.1},{20,1000*1.1}}
			},
		state_hurt_attack={{{1,50},{20,50}},{{1,18*1.5},{20,18*1.5}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,100},{20,100}}},
	},
	boss_xingyunjue={ --���ƾ�
	--	physicsenhance_p={{{1,5},{10,95},{20,145}}},
	--	attackrating_p={{{1,50},{20,100}}},
		physicsdamage_v={
			[1]={{1,350*0.9},{2,300*0.9},{20,1000*0.9}},
			[3]={{1,350*1.1},{2,300*1.1},{20,1000*1.1}}
			},
		state_hurt_attack={{{1,50},{20,50}},{{1,18*1.5},{20,18*1.5}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,100},{20,100}}},
	},

	boss_dot={ --dot����
		fastlifereplenish_v={{{1,-100},{2,-100}}},
		skill_statetime={{{1,18*10},{2,18*10}}}
	},
	boss_miqipiaozong={ --����Ʈ��
		ignoreskill={{{1,50},{10,100},{20,100}},0,{{1,2},{2,2}}},
		state_hurt_ignore={1},
		state_weak_ignore={1},
		state_slowall_ignore={1},
		state_burn_ignore={1},
		state_stun_ignore={1},
		skill_statetime={{{1,18*180},{20,18*300}}},
	},
	boss_jiugongfeixing={ --�Ź�����
	--	physicsenhance_p={{{1,5},{20,190}}},
	--	attackrating_p={{{1,12},{20,99}}},
		state_hurt_attack={{{1,45},{20,45}},{{1,18*1.5},{20,18*1.5}}},
		state_weak_attack={{{1,75},{20,75}},{{1,18*5},{20,18*5}}},
		seriesdamage_r={{{1,500},{2,500},{3,250},{4,250}}},
		poisondamage_v={{{1,550},{2,75},{3,37},{20,1000}},{{1,9*1},{2,9*10},{3,9*10},{20,9*1}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_tiangangdisha={ --���ɷ
		seriesdamage_r={{{1,100},{20,500}}},
		state_weak_attack={{{1,75},{20,75}},{{1,18*5},{20,18*5}}},
		poisondamage_v={{{1,300},{2,200},{20,1000}},{{1,9*5},{20,9*5}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_sanhuabiao={ --ɢ����
	--	physicsenhance_p={{{1,5},{10,68},{20,118}}},
	--	attackrating_p={{{1,12},{20,100}}},
		state_hurt_attack={{{1,40},{20,40}},{{1,18*1.5},{20,18*1.5}}},
		state_weak_attack={{{1,75},{20,75}},{{1,18*5},{20,18*5}}},
		seriesdamage_r={{{1,100},{2,500},{3,100},{20,500}}},
		poisondamage_v={{{1,200},{2,75},{3,150},{4,100},{20,1000}},{{1,9*4},{2,9*15},{3,9*4},{4,9*4}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_tianluodiwang={ --���޵���
--		physicsenhance_p={{{1,5},{10,95},{20,125}}},
--		attackrating_p={{{1,12},{20,250}}},
		state_hurt_attack={{{1,45},{20,45}},{{1,18*1.5},{20,18*1.5}}},
		state_weak_attack={{{1,75},{20,75}},{{1,18*5},{20,18*5}}},
		seriesdamage_r={{{1,100},{20,100}}},
		poisondamage_v={{{1,150},{2,100}},{{1,9*5},{2,9*5}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_foxinciyou={ --���Ĵ���
		lifemax_p={{{1,30},{20,50}}},
	},
	boss_xueying={ --ѩӰ
		fastwalkrun_p={{{1,40},{20,40}}},
		state_hurt_ignore={1},
		state_weak_ignore={1},
		state_slowall_ignore={1},
		state_burn_ignore={1},
		state_stun_ignore={1},
		state_burn_resisttime={{{1,200},{20,200}}},
		skill_statetime={{{1,18*180},{20,18*300}}}
	},
	boss_cihangpudu={ --�Ⱥ��ն�
		fastlifereplenish_v={{
			{1,15000},
			{2,99999},		--�߹���С����
			{3,-5000},
			{20,50000},
		}},
		fastmanareplenish_v={{
			{1,15000},
			{2,99999},		--�߹���С����
			{3,-5000},
			{20,50000},
		}},
		skill_statetime={{
			{1,18*5},
			{2,18*2},
			{3,-1},
			{4,-1},
		}}
	},
	boss_suddendeath={	--�ٻ�С������������
		suddendeath={
			{	{1,100},
				{2,100}
			},
			{	{1,18*60*3},
				{2,18*3}}
			},
	},
	boss_muyeliuxing={ --��Ұ����
		seriesdamage_r={{{1,100},{20,100}}},
	--	physicsenhance_p={{{1,10},{20,110}}},
		colddamage_v={
			[1]={{1,550*0.9},{2,444*0.9},{20,1000*0.9}},
			[3]={{1,550*1.1},{2,444*1.1},{20,1000*1.1}}
		},
		state_slowall_attack={{{1,50},{20,50}},{{1,18*5},{20,18*5}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	--	attackrating_p={{{1,30},{20,90}}},
	},
	boss_sixiangtonggui={ --����ͬ��
		colddamage_v={
			[1]={{1,750*0.9},{2,600*0.9},{20,1000*0.9}},
			[3]={{1,750*1.1},{2,600*1.1},{20,1000*1.1}}
		},
		state_slowall_attack={{{1,50},{20,50}},{{1,18*10},{20,18*10}}},
		seriesdamage_r={{{1,100},{20,500}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_bihaichaosheng={ --�̺�����
		colddamage_v={
			[1]={{1,600*0.9},{2,400*0.9},{20,1000*0.9}},
			[3]={{1,600*1.1},{2,400*1.1},{20,1000*1.1}}
		},
		state_slowall_attack={{{1,50},{20,50}},{{1,18*5},{20,18*5}}},
		seriesdamage_r={{{1,100},{20,500}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_huabuliushou={ --��������
		fastwalkrun_p={{{1,30},{20,40}}},
		state_hurt_ignore={1},
		state_weak_ignore={1},
		state_slowall_ignore={1},
		state_burn_ignore={1},
		state_stun_ignore={1},
		state_hurt_resisttime={{{1,150},{20,250}}},
		skill_statetime={{{1,18*180},{20,18*300}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_huanyingfeihu={ --��Ӱ�ɺ�
		attackratingenhance_p={{{1,-150},{20,-250}}},
		deadlystrikeenhance_r={{{1,-50},{20,-150}}},
		skill_statetime={{{1,18*180},{20,18*300}}}
	},
	boss_limoduohun={ --��ħ���
		addphysicsdamage_p={{{1,-50},{20,-100}},0,0},
	--	skill_cost_v={{{1,20},{20,20}}},
		skill_statetime={{{1,18*180},{20,18*360}}}
	},
	boss_tuishantianhai={ --��ɽ�
		seriesdamage_r={{{1,100},{20,100}}},
		firedamage_v={
			[1]={{1,350*0.9},{2,300*0.8},{20,1000*0.9}},
			[3]={{1,350*1.1},{2,300*1.2},{20,1000*1.1}}
		},
		state_burn_attack={{{1,45},{20,45}},{{10,18*3},{20,18*3}}},
		skill_missilenum_v={{{1,8},{20,8}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_kanglongyouhui={ --�����л�
		seriesdamage_r={{{1,100},{2,500},{3,100}}},
		firedamage_v={
			[1]={{1,600*0.9},{2,1000*0.5},{3,400*0.8},{20,1000*0.9}},
			[3]={{1,600*1.1},{2,1000*1.5},{3,400*1.2},{20,1000*1.1}}
		},
		state_burn_attack={{{1,45},{20,45}},{{1,18*3},{20,18*3}}},
		skill_missilenum_v={{{1,15},{20,15}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_bangdaegou={ --�����
		seriesdamage_r={{{1,100},{20,100}}},
	--	physicsenhance_p={{{1,5},{10,23},{20,43}}},
		firedamage_v={
			[1]={{1,650*0.9},{2,450*0.9},{20,1000*0.9}},
			[3]={{1,650*1.1},{2,450*1.1},{20,1000*1.1}}
		},
		state_hurt_attack={{{1,35},{10,35},{20,35}},{{1,18*1.5},{20,18*1.5}}},
		state_burn_attack={{{1,45},{20,45}},{{1,18*3},{20,18*3}}},
		attackrating_p={{{1,100},{20,100}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_tanzhilieyan={ --��ָ����
		seriesdamage_r={{{1,100},{2,100}}},
		firedamage_v={
			[1]={{1,300*0.9},{2,200*0.9}},
			[3]={{1,300*1.1},{2,200*1.1}}
		},
		state_burn_attack={{{1,45},{20,45}},{{1,18*3},{20,18*3}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_yanmentuobo={ --�����в�
		seriesdamage_r={{{1,100},{20,100}}},
	--	physicsenhance_p={{{1,5},{10,50},{20,100}}},
		firedamage_v={
			[1]={{1,550*0.9},{2,400*0.9}},
			[3]={{1,550*1.1},{2,400*1.1}}
		},
		state_hurt_attack={{{1,35},{10,35},{20,35}},{{1,18*1.5},{20,18*1.5}}},
		state_burn_attack={{{1,45},{20,45}},{{1,18*3},{20,18*3}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_zhenwuqijie={ --�����߽�
		addphysicsmagic_p={{{1,5},{20,5}}},
	},
	boss_yiqisanqing={ --һ������
		addphysicsdamage_p={{{1,20},{20,50}},0,0},
		addphysicsmagic_p={{{1,20},{20,50}}},
		skill_statetime={{{1,18*180},{20,18*300}}}
	},
	boss_qingfengfu={ --����
		fastwalkrun_p={{{1,40},{20,50}}},
		state_hurt_ignore={1},
		state_weak_ignore={1},
		state_slowall_ignore={1},
		state_burn_ignore={1},
		state_stun_ignore={1},
		skill_statetime={{{1,18*180},{20,18*300}}}
	},
	boss_bojierfu={ --��������
		lightingdamage_v={
			[1]={{1,700*0.9},{2,500*0.9},{20,1000*0.9}},
			[3]={{1,700*1.1},{2,500*1.1},{20,1000*1.1}}
		},
		state_stun_attack={{{1,45},{20,45}},{{1,18*2},{20,18*2}}},
		seriesdamage_r={{{1,100},{20,500}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_sanhuantaoyue={ --��������
		seriesdamage_r={{{1,100},{20,100}}},
		physicsenhance_p={{{1,50},{2,50},{10,203},{20,353}}},
		lightingdamage_v={
			[1]={{1,600*0.9},{2,400*0.9},{20,1000*0.9}},
			[3]={{1,600*1.1},{2,400*1.1},{20,1000*1.1}}
		},
		state_stun_attack={{{1,45},{20,45}},{{1,18*2},{20,18*2}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	--	attackrating_p={{{1,50},{20,100}}},
	},
	boss_kuangfengzhoudian={ --������
		seriesdamage_r={{{1,100},{20,100}}},
	--	physicsenhance_p={{{1,5},{10,50},{20,73}}},
		lightingdamage_v={
			[1]={{1,750*0.9},{2,500*0.9},{20,1000*0.9}},
			[3]={{1,750*1.1},{2,500*1.1},{20,1000*1.1}}
		},
		state_stun_attack={{{1,45},{20,45}},{{1,18*2},{20,18*2}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	--	attackrating_p={{{1,50},{20,100}}},
	},
	boss_wuwowujian={ --�����޽�
	--	missile_hitcount={{{1,3},{5,4},{10,5},{15,6},{16,6}}},
		lightingdamage_v={
			[1]={{1,550*0.9},{2,400*0.9},{20,1000*0.9}},
			[3]={{1,550*1.1},{2,400*0.9},{20,1000*1.1}}
		},
		state_stun_attack={{{1,45},{20,45}},{{1,18*2},{20,18*2}}},
		seriesdamage_r={{{1,100},{20,100}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	--	skill_cost_v={{{1,100},{20,150}}}
	},
	--------------------------------75������boss������boss�ü���-----------------------
	boss_rage={ --��״̬
		attackspeed_v={{{1,40},{20,90}}},
		fastwalkrun_p={{{1,40},{20,60}}},
		--addphysicsdamage_p={{{1,50},{20,200}}},
		addphysicsdamage_v={{{1,500},{20,200}}},
		addphysicsmagic_v={{{1,500},{20,200}}},
		skill_statetime={{{1,18*45},{20,18*300}}}
	},
	boss_resistcurse={ --����ȫ������
		damage_all_resist={{{1,-500},{2,-5000}}},
		skill_statetime={{{1,18*3},{20,18*300}}}
	},
	boss_sectorknockback={ --���λ���
		state_knock_attack={{{1,100},{2,100}},{{1,16},{2,16}},{{1,32},{2,32}}},
	},
	boss_longaoe={ --��������Χ����
		physicsdamage_v={
			[1]={{1,1200*0.9},{20,1000*0.9}},
			[3]={{1,1200*1.1},{20,1000*1.1}}
			},
		--state_hurt_attack={{{1,40},{20,30}},{{1,18*1},{20,18*1}}},
		--skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_longaoe_child={ --��������Χ������
		physicsdamage_v={
			[1]={{1,1000*0.9},{20,1000*0.9}},
			[3]={{1,1000*1.1},{20,1000*1.1}}
			},
		--state_hurt_attack={{{1,40},{20,30}},{{1,18*1},{20,18*1}}},
		--skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_areafix={ --��Χ����,2��Ϊ��ң��ī��ʹ��
		state_fixed_attack={{{1,90},{2,50}},{{1,18*3},{2,18*10}}},
	},
	boss_stealhpknockback={ --����߹���Ѫ����
		physicsdamage_v={
			[1]={{1,3000*0.9},{2,2000*0.9},{20,1500*0.9}},
			[3]={{1,3000*1.1},{2,2000*1.1},{20,1500*1.1}}
			},
		state_knock_attack={{{1,100},{2,100}},{{1,16},{2,16}},{{1,32},{2,32}}},
		seriesdamage_r={{{1,500},{20,500}}},
		steallife_p={{{1,1000},{2,1500}}},
	},
	boss_ragegold={ --��ϵŭ������
		appenddamage_p= {{{1,0},{10,0},{20,0}}},
		physicsdamage_v={
			[1]={	{1,600*0.9},--��ϵ75��boss
					{2,300*0.9},--���帱��75��boss
					{3,300*0.9},--??
					{4,250*0.9},--90���ر�ͼboss
					{5,350*0.9},--100���ر�ͼboss
					{20,1000*0.9}},
			[3]={	{1,600*1.1},
					{2,300*1.1},
					{3,300*1.1},
					{4,250*1.1},
					{5,350*1.1},
					{20,1000*1.1}}
			},
		state_hurt_attack={{{1,40},{20,40}},{{1,18*1},{20,18*1}}},
		skill_deadlystrike_r={100000},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_areamanyattack={ --����Χ��ι���
		physicsdamage_v={
			[1]={{1,900*0.9},{2,450*0.9},{20,1000*0.9}},
			[3]={{1,900*1.1},{2,450*1.1},{20,1000*1.1}}
			},
		state_hurt_attack={{{1,10},{20,10}},{{1,18*1},{20,18*1}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_pojiedaofa={ --Զ��ֱ�ߴ�͸����
		physicsdamage_v={
			[1]={{1,2000*0.9},{2,1000*0.9}},
			[3]={{1,2000*1.1},{2,1000*1.1}}
			},
		state_hurt_attack={{{1,40},{20,40}},{{1,18*1},{20,18*1}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_fumodaofa={ --Զ��ֱ�ߵ��幥��
		physicsdamage_v={
			[1]={{1,2000*0.9},{2,1000*0.9}},
			[3]={{1,2000*1.1},{2,1000*1.1}}
			},
		state_hurt_attack={{{1,40},{2,40}},{{1,18*1},{20,18*1}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_meleeattack={ --�����㹥��
		physicsdamage_v={
			[1]={{1,1800*0.9},{2,500*0.8},{3,900*0.9},{4,300*0.9},{20,1000*0.9}},
			[3]={{1,1800*1.1},{2,500*1.2},{3,900*1.1},{4,300*1.1},{20,1000*1.1}}
			},
		state_hurt_attack={{{1,40},{2,50},{3,40},{4,50}},{{1,18*1},{20,18*1}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_callnpc={ --�ٻ�С��
		missile_callnpc={	--npcid*65536+nLevel
			{	{ 1,2418 * 65536 + 75},		--����ĻС��
				{ 2,2419 * 65536 + 75},		--ǿ��ĻС��
				{ 3,2412 * 65536 + 75},		--����С��
				{ 4,2413 * 65536 + 75},		--�߹�С��
				{ 5,2414 * 65536 + 75},		--����С��
				{ 6,2415 * 65536 + 75},		--���ι�С��
				{ 7,2416 * 65536 + 75},		--Ⱥ��С��
				{ 8,2417 * 65536 + 75},		--���Ҹ���С��
				{ 9,2420 * 65536 + 75},		--���Ҹ���С���ٻ�����
				
				{10,3596 * 65536 + 150},	--�ٻ�ľ׮��ƭ�Զ�ս��

				{11,2989 * 65536 + 75},		--����ĻС��
				{12,2990 * 65536 + 75},		--ǿ��ĻС��
				{13,2983 * 65536 + 75},		--����С��
				{14,2984 * 65536 + 75},		--�߹�С��
				{15,2985 * 65536 + 75},		--����С��
				{16,2986 * 65536 + 75},		--���ι�С��
				{17,2987 * 65536 + 75},		--Ⱥ��С��
				{18,2988 * 65536 + 75},		--���Ҹ���С��
				{19,2991 * 65536 + 75},		--���Ҹ���С���ٻ�����

			},
			{{ 1,18*180},{ 3,18*180},{ 4,0},{ 5,18*180},{ 9,18*180},{10,18*180},	},	--npc����ʱ��,0Ϊ����
			{{1,-1},{9,-1}},	--npcseries
		},
		skill_missilenum_v={	--���ӵ����������ٻ�npc������
			{	{ 1,3},
				{ 2,2},
				{ 3,5},
				{ 4,3},
				{ 5,2},
				{ 6,1},
				{ 7,3},
				{ 8,3},
				{ 9,1},
				
				{10,3},
				
				{11,2},
				{12,1},
				{13,3},
				{14,2},
				{15,1},
				{16,1},
				{17,2},
				{18,2},
				{19,1},
			}
		},
	},
	boss_ragewood={ --ľϵŭ������
		appenddamage_p= {{{1,0},{10,0},{11,25},{20,0}}},
		state_hurt_attack={{{1,5},{20,5}},{{1,18*1},{20,18*1}}},
		state_weak_attack={{{1,35},{20,35}},{{1,18*5},{20,18*5}}},
		poisondamage_v={	{	{1,1000},--75������boss
								{2,500},--���帱��75������boss
								{3,500},--�߼��ر�ͼboss
								{4,450},--80-90�����񸱱�boss
								{5,650},--100���ر�ͼ
								{11,1},--������ľϵŭ������
								},
							{	{1,9*1},
								{20,9*1}}},
		skill_deadlystrike_r={1900},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_barrage_centipede={ --����͵�Ļ
		state_hurt_attack={{{1,5},{20,5}},{{1,18*1},{20,18*1}}},
		state_weak_attack={{{1,35},{20,35}},{{1,18*5},{20,18*5}}},
		poisondamage_v={{{1,100},{2,50}},{{1,9*10},{20,9*10}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_barrage_jiugongfeixing={ --�Ź����ǵ�Ļ
		state_hurt_attack={{{1,5},{20,5}},{{1,18*1},{20,18*1}}},
		state_weak_attack={{{1,35},{20,35}},{{1,18*5},{20,18*5}}},
		poisondamage_v={{{1,100},{2,50}},{{1,9*10},{20,9*10}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_barrage_xiaoli={ --С��ɵ���Ļ������
		state_hurt_attack={{{1,5},{20,5}},{{1,18*1},{20,18*1}}},
		state_weak_attack={{{1,35},{20,35}},{{1,18*5},{20,18*5}}},
		poisondamage_v={{{1,100},{2,50}},{{1,9*10},{20,9*10}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_barrage_xiaoli_child1={ --С��ɵ���Ļ������
		poisondamage_v={{{1,100},{2,50},{20,100}},{{1,9*10},{20,9*10}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,500},{20,500}}},
		state_slowall_attack={{{1,45},{20,45}},{{1,18*3},{20,18*3}}},
	},
	boss_barrage_spray={ --ɨ�䵯Ļ
		state_hurt_attack={{{1,5},{20,5}},{{1,18*1},{20,18*1}}},
		state_weak_attack={{{1,35},{20,35}},{{1,18*5},{20,18*5}}},
		poisondamage_v={{{1,100},{2,50},{20,1050}},{{1,9*10},{20,9*10}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_barrage_round={ --���ι�����Ļ
		state_hurt_attack={{{1,5},{20,5}},{{1,18*1},{20,18*1}}},
		state_weak_attack={{{1,35},{20,35}},{{1,18*5},{20,18*5}}},
		poisondamage_v={{{1,100},{2,50},{20,1050}},{{1,9*10},{20,9*10}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_barrage_sixiang={ --����ͬ�鵯Ļ
		state_hurt_attack={{{1,5},{20,5}},{{1,18*1},{20,18*1}}},
		state_weak_attack={{{1,35},{20,35}},{{1,18*5},{20,18*5}}},
		poisondamage_v={{{1,100},{2,50},{20,1050}},{{1,9*10},{20,9*10}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_barrage_lineround={ --ֱ�߻��й�����Ļ
		state_hurt_attack={{{1,5},{20,5}},{{1,18*1},{20,18*1}}},
		state_weak_attack={{{1,35},{20,35}},{{1,18*5},{20,18*5}}},
		poisondamage_v={{{1,100},{2,75},{3,50},{4,37},{20,1050}},{{1,9*10},{20,9*10}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_jiugongfeixingmelee={ --�Ź����Ǹ�
		state_hurt_attack={{{1,5},{20,5}},{{1,18*1},{20,18*1}}},
		state_weak_attack={{{1,35},{20,35}},{{1,18*5},{20,18*5}}},
		seriesdamage_r={{{1,500},{20,500}}},
		poisondamage_v={{{1,100},{2,50},{20,100}},{{1,9*10},{20,9*10}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_barrage_tianluodiwang={ --���޵�����Ļ
		state_hurt_attack={{{1,5},{20,5}},{{1,18*1},{20,18*1}}},
		state_weak_attack={{{1,35},{20,35}},{{1,18*5},{20,18*5}}},
		poisondamage_v={{{1,75},{2,37}},{{1,9*10},{20,9*10}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_ragewater_child1={	--ˮϵŭ��������_����
		state_freeze_attack={{{1,100},{2,100}},{{1,18*2.5},{2,18*2.5}}},
	},
	boss_ragewater_child2={ --ˮϵŭ����������_����
		appenddamage_p= {{{1,0},{10,0},{20,0}}},
		seriesdamage_r={{{1,500},{20,500}}},
		colddamage_v={
			[1]={	{1,600*0.9},--75������boss
					{2,300*0.9},--���帱��75������boss
					{3,1000*0.9},--�߼��ر�ͼboss
				},
			[3]={	{1,600*1.1},
					{2,300*1.1},
					{3,1000*1.1},
				}
		},
		skill_deadlystrike_r={100000}
	},
	boss_meleeaoe={ --����С��Χ����
		seriesdamage_r={{{1,500},{20,500}}},
		colddamage_v={
			[1]={{1,1800*0.9},{2,1500*0.9},{3,2000*0.5},{4,900*0.9},{5,750*0.9},{6,1000*0.5},{20,1000*0.9}},
			[3]={{1,1800*1.1},{2,1500*1.1},{3,2000*1.5},{4,900*1.1},{5,750*1.1},{6,1000*1.5},{20,1000*1.1}}
		},
		state_slowall_attack={{{1,75},{2,50},{3,35},{20,35}},{{1,18*3},{20,18*3}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_fengjuancanxue={ --boss����ѩ
		seriesdamage_r={{{1,500},{20,500}}},
		colddamage_v={
			[1]={{1,100*0.8},{2,750*0.8},{20,1000*0.9}},
			[3]={{1,100*1.2},{2,750*1.2},{20,1000*1.1}}
		},
		state_slowall_attack={{{1,50},{2,25},{20,35}},{{1,18*3},{20,18*3}}},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_meleesingle={ --boss������
		seriesdamage_r={{{1,500},{20,500}}},
		colddamage_v={
			[1]={{1,2000*0.9},{2,1000*0.9}},
			[3]={{1,2000*1.1},{2,1000*1.1}}
		},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_wangushixin={ --���ʴ��
		damage_all_resist={{{1,-80},{10,-50},{20,-80}}},
		skill_statetime={{{1,18*60},{20,18*90}}}
	},
	boss_limoduohun2={ --��ħ���2
		addphysicsdamage_p={{{1,-150},{20,-50}}},
		addphysicsmagic_p={{{1,-150},{20,-50}}},
		skill_statetime={{{1,18*60},{20,18*90}}}
	},
	boss_bingpohanguang={ --���Ǻ���
		fastwalkrun_p={{{1,-50},{20,-30}}},
		skill_statetime={{{1,18*60},{20,18*90}}}
	},
	boss_wuxinggu={ --���ι�
		poisondamage_v={{{1,50},{20,1050}},{{1,9*1},{20,9*1}}},
		state_hurt_attack={{{1,25},{20,25}},{{1,18*1},{20,18*1}}},
	},
	boss_wateraoe_big={ --ˮϵ��Χ����
		seriesdamage_r={{{1,500},{20,500}}},
		state_slowall_attack={{{1,35},{20,35}},{{1,18*3},{20,18*3}}},
		colddamage_v={
			[1]={{1,1500*0.8},{2,750*0.8},{20,1000*0.9}},
			[3]={{1,1500*1.2},{2,750*1.2},{20,1000*1.1}}
		},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_wateraoe_small={ --ˮϵС��Χ����
		seriesdamage_r={{{1,500},{20,500}}},
		state_slowall_attack={{{1,35},{20,35}},{{1,18*3},{20,18*3}}},
		colddamage_v={
			[1]={{1,1800*0.9},{2,900*0.8},{20,1000*0.9}},
			[3]={{1,1800*1.1},{2,900*1.2},{20,1000*1.1}}
		},
		skill_deadlystrike_r={{{1,150},{20,150}}},
	},
	boss_hurtslowall={ --�ߺ����ٻ�����
		state_hurt_attack={{{1,75},{20,75}},{{1,18*1},{20,18*1}}},
		state_slowall_attack={{{1,75},{20,75}},{{1,18*3},{20,18*3}}},
	},
	boss_rageattack={ --�񱩼����ӹ�
--		addphysicsdamage_p={{{1,50},{20,200}}},
--		addphysicsmagic_p={{{1,50},{20,200}}},
		damage_all_resist={{{1,-500},{2,-500}}},
		addfiremagic_v={{{1,200},{20,1000}}},
		addfiredamage_v={{{1,200},{20,1000}}},
		skill_statetime={{{1,18*300},{20,18*300}}}
	},
	boss_firesquare={ --���λ���
		seriesdamage_r={{{1,500},{20,500}}},
		firedamage_v={
			[1]={{1,1800*0.8},{10,260},{20,485*0.9}},
			[3]={{1,1800*1.2},{10,260},{20,485*1.1}}
		},
		state_burn_attack={{{1,35},{20,40}},{{1,18*3},{20,18*3}}},
	},
	boss_chiyanshitian={ --����ʴ��
		damage_fire_resist={{{1,-300},{20,-1000}}},
		skill_statetime={{{1,18*15},{20,18*20}}}
	},
	boss_allslowrun={ --ȫ��������
		fastwalkrun_p={{{1,-60},{20,-60}}},
		skill_statetime={{{1,18*30},{20,18*90}}}
	},
	boss_confuse_middle={ --�з�Χ����
		state_confuse_attack={{{1,100},{20,100}},{{1,18*5},{20,18*5}}},
	},
	boss_fireball={ --��ʯ��
		seriesdamage_r={{{1,500},{20,500}}},
		firedamage_v={
			[1]={{1,450*0.8},{1,350*0.8},{10,260},{20,485*0.9}},
			[3]={{1,450*1.2},{1,350*1.2},{10,260},{20,485*1.1}}
		},
		state_stun_attack={{{1,5},{10,5},{20,5}},{{1,18*3},{20,18*3}}},
	},
	boss_roundfirewall={ --����Բ�λ�ǽ
		seriesdamage_r={{{1,500},{20,500}}},
		firedamage_v={
			[1]={{1,500*0.8},{10,260},{20,485*0.9}},
			[3]={{1,500*1.2},{10,260},{20,485*1.1}}
		},
	},
	boss_firetrap={ --������
		seriesdamage_r={{{1,100},{20,500}}},
		firedamage_v={
			[1]={{1,2450*0.8},{2,1450*0.8},{10,260},{20,485*0.9}},
			[3]={{1,2450*1.2},{2,1450*1.2},{10,260},{20,485*1.1}}
		},
	},
	boss_firetrap_child={ --��������
		seriesdamage_r={{{1,500},{20,500}}},
		firedamage_v={
			[1]={{1,1450*0.8},{2,750*0.8},{10,260},{20,485*0.9}},
			[3]={{1,1450*1.2},{2,750*1.2},{10,260},{20,485*1.1}}
		},
	},
	boss_ragefire={ --��ϵŭ������
		appenddamage_p= {{{1,0},{10,0},{20,0}}},
		seriesdamage_r={{{1,500},{20,500}}},
		firedamage_v={
			[1]={	{1,550*0.8},--75������boss
					{2,350*0.8},--���帱��75������boss
					{3,350*0.8},--�߼��ر�ͼboss
					{4,550*0.8},--100���ر�ͼboss
					{10,160},--�м��ر�ͼboss
					{20,485*0.9}},
			[3]={	{1,550*1.2},
					{2,350*1.2},
					{3,350*1.2},
					{4,550*0.8},--100���ر�ͼboss
					{10,160},
					{20,485*1.1}}
		},
		skill_deadlystrike_r={100000}
	},
	boss_tuishantianhai2={ --��ɽ�2
		seriesdamage_r={{{1,500},{20,500}}},
		firedamage_v={
			[1]={{1,750*0.8},{2,350*0.8},{10,260},{20,485*0.9}},
			[3]={{1,750*1.2},{2,350*1.2},{10,260},{20,485*1.1}}
		},
	},
	boss_bangdaegou2={ --�����2,���λ�������
		seriesdamage_r={{{1,500},{20,500}}},
		firedamage_v={
			[1]={{1,1800*0.8},{10,260},{20,485*0.9}},
			[3]={{1,1800*1.2},{10,260},{20,485*1.1}}
		},
		state_burn_attack={{{1,100},{20,100}},{{10,18*5},{20,18*5}}},
		state_knock_attack={{{1,100},{2,100}},{{1,16},{2,16}},{{1,32},{2,32}}},
	},
	boss_tianwailiuxing={ --��������
		appenddamage_p= {{{1,0},{10,0},{20,0}}},
		seriesdamage_r={{{1,500},{20,500}}},
		firedamage_v={
			[1]={{1,1600*0.8},{2,800*0.8},{10,560},{20,485*0.9}},
			[3]={{1,1600*1.2},{2,800*1.2},{10,760},{20,485*1.1}}
		},
		skill_deadlystrike_r={200}
	},
	boss_yehuofencheng={ --ҵ��ٳ�
		appenddamage_p= {{{1,100},{10,0},{20,100}}},
		seriesdamage_r={{{1,500},{10,500},{20,500}}},
		firedamage_v={
			[1]={{1,350*0.8},{2,250*0.8},{10,80},{20,485*0.9}},
			[3]={{1,350*1.2},{2,250*1.2},{10,150},{20,485*1.1}}
		},
		skill_deadlystrike_r={200}
	},
	boss_highreturn={ --ǿ������
		addphysicsdamage_p={{{1,500},{20,300}}},
		addphysicsmagic_p={{{1,500},{20,300}}},
		skill_statetime={{{1,18*30},{20,18*30}}}
	},
	boss_highreturn_child={ --ǿ��������
		meleedamagereturn_p={{{1,500},{20,300}}},
		rangedamagereturn_p={{{1,500},{20,300}}},
		poisondamagereturn_p={{{1,500},{20,300}}},
		skill_statetime={{{1,18*15},{20,18*15}}}
	},
	boss_silence={ --�������ڳ�Ĭ
		fastmanareplenish_v={{{1,-99999},{20,-99999}}},
		skill_statetime={{{1,18*30},{20,18*30}}}
	},
	boss_slowknock={ --�����ٻ���
		fastwalkrun_p={{{1,-119},{20,-119}}},
		skill_statetime={{{1,18*30},{20,18*90}}}
	},
	boss_slowknock_child={ --�����ٻ�����
		state_knock_attack={{{1,100},{2,100}},{{1,16},{2,16}},{{1,32},{2,32}}},
	},
	boss_hpreplenishdown={ --��ѪЧ�ʽ���
		lifereplenish_p={{{1,-100},{20,-100}}},
		skill_statetime={{{1,18*40},{20,18*30}}}
	},
	boss_hpmaxdown={ --�������ֵ����
		lifemax_p={{{1,-65},{20,-50}}},
		skill_statetime={{{1,18*45},{20,18*30}}}
	},
	boss_mpmaxdown={ --�������ֵ����
		manamax_p={{{1,-65},{20,-50}}},
		skill_statetime={{{1,18*60},{20,18*30}}}
	},
	boss_lightresdown={ --�׿�����
		damage_light_resist={{{1,-300},{20,-500}}},
		skill_statetime={{{1,18*60},{20,18*90}}}
	},
	boss_attackratingdown={ --��Ӱ�ɺ�
		attackratingenhance_p={{{1,-100},{20,-150}}},
		skill_statetime={{{1,18*60},{20,18*300}}}
	},
	boss_physicsdamagegdown={ --���⹥���ڹ�
		addphysicsdamage_p={{{1,-300},{20,-300}}},
		addphysicsmagic_p={{{1,300},{20,300}}},
		skill_statetime={{{1,18*45},{20,18*45}}}
	},
	boss_physicsmagicdown={ --���ڹ����⹥
		addphysicsdamage_p={{{1,300},{20,300}}},
		addphysicsmagic_p={{{1,-300},{20,-300}}},
		skill_statetime={{{1,18*45},{20,18*45}}}
	},
	boss_rageearth={	--��ϵŭ������,1��Ϊ75��boss��,2��Ϊ����75��boss��,3��Ϊ80-90�����񸱱���
		appenddamage_p= {{{1,0},{10,0},{20,0}}},
		state_stun_attack={{{1,45},{2,45}},{{1,18*2},{2,18*2}}},
		lightingdamage_v={
			[1]={{1,500*0.9},{2,250*0.9},{3,200*0.9},{20,1000*0.9}},
			[3]={{1,500*1.1},{2,250*1.1},{3,200*1.1},{20,1000*1.1}}
		},
		skill_deadlystrike_r={100000},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_rageearth_child={	--��ϵŭ����������_Բ����ʱ
		appenddamage_p= {{{1,0},{10,0},{20,0}}},
		lightingdamage_v={
			[1]={{1,500*0.9},{2,250*0.9},{20,1000*0.9}},
			[3]={{1,500*1.1},{2,250*1.1},{20,1000*1.1}}
		},
		skill_deadlystrike_r={100000},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_followmanyattack={	--�����ι���
		lightingdamage_v={
			[1]={{1,1500*0.9},{2,800*0.9},{3,1*0.9},{20,1000*0.9}},
			[3]={{1,1500*1.1},{2,800*1.1},{3,1*1.1},{20,1000*1.1}}
		},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		state_stun_attack={{{1,75},{20,75}},{{1,18*1},{20,18*1}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_followmanyattack_child={	--�����ι���
		lightingdamage_v={
			[1]={{1,1500*0.9},{2,800*0.9},{20,1000*0.9}},
			[3]={{1,1500*1.1},{2,800*1.1},{20,1000*1.1}}
		},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		state_stun_attack={{{1,100},{20,100}},{{1,18*1},{20,18*1}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_kuangleizhendi={	--�������
		lightingdamage_v={
			[1]={{1,1500*0.9},{2,600*0.9},{20,1000*0.9}},
			[3]={{1,1500*1.1},{2,600*1.1},{20,1000*1.1}}
		},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		state_stun_attack={{{1,35},{20,35}},{{1,18*2},{20,18*2}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_tianjixunlei={	--���Ѹ��
		lightingdamage_v={
			[1]={{1,1000*0.9},{2,600*0.9},{10,260},{20,1000*0.9}},
			[3]={{1,1000*1.1},{2,600*1.1},{10,260},{20,1000*1.1}}
		},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		state_stun_attack={{{1,35},{20,35}},{{1,18*1.5},{20,18*1.5}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_tianjixunlei_child={	--���Ѹ��_����
		lightingdamage_v={
			[1]={{1,750*0.9},{2,450*0.9},{10,260},{20,1000*0.9}},
			[3]={{1,750*1.1},{2,450*1.1},{10,260},{20,1000*1.1}}
		},
		skill_deadlystrike_r={{{1,150},{20,150}}},
		state_stun_attack={{{1,35},{20,35}},{{1,18*1.5},{20,18*1.5}}},
		seriesdamage_r={{{1,500},{20,500}}},
	},
	boss_autoqiwutuisan={ --�Զ��ͷ��������
		autoskill={{{1,19},{2,19}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	boss_eliminatemagicshield={	--��������޼�
		--removestate={{{1,497},{2,161},{3,132},{10,694}}},
		removeshield={1},
		--skill_statetime={{{1,18*20},{19,18*60},{20,-1}}},
	},
	boss_weakenmanashield={ --�������������˺�����
		manashield_p={{{1,-55},{10,-100},{20,-200}}},
		skill_statetime={{{1,18*300},{19,18*300},{20,-1}}},
	},
	boss_duchuanran={ --30���ڴ�Ⱦ���˺�
		infectpoison={{{1,10},{10,100},{20,200}}},
		skill_statetime={{{1,18*30},{19,18*30}}},
	},
-------------------------------------------------120��boss-------------------------------------------
	boss_seriesattack={ --����5������Ч��
		skill_deadlystrike_r={{{1,150},{20,150}}},
		state_stun_attack={{{1,2},{10,20}},{{1,18*1},{20,18*1}}},
		state_hurt_attack={{{1,2},{10,20}},{{1,18*1},{20,18*1}}},
		state_weak_attack={{{1,2},{10,20}},{{1,18*3},{20,18*3}}},
		state_burn_attack={{{1,2},{10,20}},{{1,18*3},{20,18*3}}},
		state_slowall_attack={{{1,2},{10,20}},{{1,18*2.5},{20,18*2.5}}},
	},
	boss_neigongmianyi_120={ --�ڹ�����
		ignoreskill={{{1,10},{10,100}},0,{{1,2},{2,2}}},
	},
	boss_waigongmianyi_120={ --�⹦����
		ignoreskill={{{1,10},{10,100}},0,{{1,4},{2,4}}},
	},
	boss_hitadd={ --�������
		attackratingenhance_p={{{1,50},{10,500}}},
	},
--��ʼ����debuff
	qinshihuang_debuff={
		damage_all_resist		={{{1,-999},{10,-999}}},
		skilldamageptrim		={{{1,-90},{10,-90}}},
		skillselfdamagetrim		={{{1,-90},{10,-90}}},
		fastwalkrun_p			={{{1,-80},{10,-80}}},
	},
	qinshihuang_buff={
		damage_all_resist		={{{1,999},{10,999}}},
		skilldamageptrim		={{{1,90},{10,90}}},
		skillselfdamagetrim		={{{1,90},{10,90}}},
		fastwalkrun_p			={{{1,80},{10,80}}},
	},
}

FightSkill:AddMagicData(tb)
