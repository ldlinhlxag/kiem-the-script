-- �ļ�������girl_vote_def.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-06-05 14:14:15
-- ��  ��  ��

SpecialEvent.Girl_Vote = SpecialEvent.Girl_Vote or {};
local tbGirl = SpecialEvent.Girl_Vote;

tbGirl.TSK_GROUP 		= 2095;
tbGirl.TSKSTR_FANS_NAME = {1, 250};	--�洢��Ů����Ʊ��,���50����Ů����250���������(�������ܸ���,����ƫ�ƴ���)
tbGirl.TSK_FANS_GATEWAYID = {260, 510};	--�洢����ͶƱ���������(�������ܸ���,����ƫ�ƴ���)
tbGirl.TSK_Vote_Girl 	= 256;	--��¼��Ů������ı�־��Ԥ�����������Բ�ѯ����Щ��Ů�����ˣ�
tbGirl.TSK_Award_State1 = 257;	--�콱
tbGirl.TSK_Award_StateEx1= 258; --��˿�콱
tbGirl.TSK_FANS_CLEAR	 = 259; --�ڶ��ּ�¼���������0��־;
tbGirl.TSK_Award_State2	 = 511; --�����콱
tbGirl.TSK_Award_StateEx2= 512; --������˿�콱
tbGirl.TSK_Award_Buff	 = 513; --����buff�����������¼ʱ�䣩
tbGirl.TSK_Award_Buff_Level	= 514; --����buff�����������¼�ȼ���

tbGirl.DEF_TASK_OFFSET 	 = 259; 	--��˿�洢��Ů����������ƫ��ֵ
tbGirl.DEF_TASK_SAVE_FANS= 10; 		--���ٸ����������¼һ��ͶƱ��Һ�Ʊ��(Ӱ��TSKSTR_FANS_NAME�洢����Ů����)

tbGirl.ITEM_MEIGUI		= {18,1,373,1}; --õ��
tbGirl.ITEM_MEIGUI_REBACK 	= {18,1,374,1}; --���յĻ���
tbGirl.DEF_AWARD_ALL_RANK 	= 20; 	--ǰ20��
tbGirl.DEF_AWARD_PASS_RANK 	= 10; 	--ǰ10����Χ
tbGirl.DEF_AWARD_TICKETS 	= 499; 	--499Ʊ

tbGirl.DEF_FINISH_MATCH_TITLE = {6,6,3,0};

tbGirl.DEF_SKILL_LASTTIME = 90*24*3600;	--�⻷���ܳ���ʱ��,����⻷�����쳣��ʧ,�������ʱ���Զ�����

tbGirl.DEF_AWARD_LIST = {
	--����ǰ20���������Χǰ10������ҽ���
	[1] = {
		mask = {1,13,25,1},
		skill= {1415,1,2,18* tbGirl.DEF_SKILL_LASTTIME, 1,0,1},
		title= {6,6,2,0},
		freebag=1,	--�����ռ�
	},
	
	--����ǰ20�����Χǰ10������
	[2] = {
		mask = {1,13,26,1},
		skill= {1415,2,2,18*tbGirl.DEF_SKILL_LASTTIME, 1,0,1},
		title= {6,6,4,0},
		item = {18,1,1,10, {bForceBind=1}, 1},
		freebag=2,	--�����ռ�		
	},
	
	--����ǰ20����ﵽ499Ʊ����Ů׷���߽���
	[3] = {
		title= {6,10,1,0},
		freebag=0,	--�����ռ�		
	},
	
	--����ȫ��ȫ��ǰ10������
	[4] = {
		mask = {1,13,27,1},
		skill= {1415,3,2,18*tbGirl.DEF_SKILL_LASTTIME, 1,0,1},
		title= {6,6,5,0},
		item = {18,1,1,10, {bForceBind=1}, 10},
		freebag=11,	--�����ռ�		
	},
	--����ȫ��ȫ����һ������
	[5] = {
		mask = {1,13,27,1},
		skill= {1415,3,2,18*tbGirl.DEF_SKILL_LASTTIME, 1,0,1},
		title= {6,6,6,0},
		item = {18,1,1,10, {bForceBind=1}, 10},
		freebag=11,	--�����ռ�		
	},
	
	--����ȫ��ȫ��ǰ10����˿����
	[6] = {
		title= {6,11,1,0},
		freebag=0,	--�����ռ�	
	},
};

tbGirl.STATE	=	
{
	20091109,	--1.��ʼ����
	20091114,	--2.��ʼͶƱ������õ��
	20091128,	--3.��������
	20091202,	--4.����ͶƱ
	20091209,	--5.�ڶ���ͶƱ
	20091222,	--6.�ڶ��ֽ�������������õ��
	20091229,	--7.��ѯ����
	20100208,	--8.ȫ�����
};

tbGirl.STATE_AWARD	=
{
	20100122,	--1.�����콱��ʼʱ��
	20100129,	--2.�����콱����ʱ��
	20100122,	--3.�����콱��ʼʱ��
	20100205,	--4.�����콱����ʱ��
	20100208,	--5.(�������,��������)
};

--������,����Id����
tbGirl.GATEWAY_TRANS = 
{
	--ԭ���� = �����
	--gate0425 = {"gate0423"},
}
