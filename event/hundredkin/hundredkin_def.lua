

if not SpecialEvent.HundredKin then
	SpecialEvent.HundredKin = {}
end

local HundredKin = SpecialEvent.HundredKin;

HundredKin.EVENT_TIME = 
{
	["songjin"] 		= { 20090727, 20090803 },
	["baihutang"] 		= { 20090803, 20090810 },
	["xoyogame"]		= { 20090810, 20090817 },
	["menpaijingji"]	= {	20090727, 20090817 },
	["score"]			= {	20090727, 20090817 },
}

HundredKin.EVENT_TIME2 = 
{
	["award"]			= { 20090818, 20090825 },
	["view"]			= { 20090727, 20090825 },
}
HundredKin.TASK_GROUP 			= 2039
HundredKin.TASK_SCORE_ID 		= 5;		-- ����Լ��Ļ���
HundredKin.TASK_AWARD_ID 		= 6;		-- �Ƿ��콱
HundredKin.TASK_SONGJIN_NUM 	= 7;		-- �ν����
HundredKin.TASK_SONGJIN_DATE 	= 8;		-- �μ��ν������
HundredKin.TASK_XOYO_SOCRE 		= 9;		-- ��ң����ܷ�


HundredKin.TAKE_AWARD_MIN_SCORE = 500	-- ������Ҫ�ۼƶ��ٷֲ�����ȡ��
HundredKin.TAKE_AWARD_MAX_COUNT = 40	-- ÿ���������40����ȡ
HundredKin.TAKE_SOCRE_MAX_XOYO  = 700	-- ��ң��߷�


HundredKin.DOUBLE_DATE = {20080816, 20080816};

HundredKin.CLEAR_DATE = 20090727;	--������ǰÿ����������������ٴ��������

HundredKin.KIN_AWARD = 
{
	--1��
	{
		{
			bindmoney = 10000000,
			item = {18,1,381,1, {bForceBind=1}, 3},
			repute=1000,
			leader=5000,
			freebag=3,
		}, --�峤
		{
			item = {18,1,381,1, {bForceBind=1}, 3},
			repute=500,
			freebag=3,			
		} --��Ա
	},
	--2-10��
	{
		{
			bindmoney = 5000000,
			item = {18,1,381,1, {bForceBind=1}, 2},
			repute=600,
			leader=3000,
			freebag=2,
		},--�峤
		{
			item = {18,1,381,1, {bForceBind=1}, 2},
			repute=300,
			freebag=2,			
		} --��Ա	
	},
	--11-30��
	{
		{
			bindmoney = 3000000,
			item = {18,1,381,1, {bForceBind=1}, 1},
			repute=400,
			leader=2000,
			freebag=1,
		}, --�峤
		{
			item = {18,1,381,1, {bForceBind=1}, 1},
			repute=200,
			freebag=1,			
		} --��Ա	
	},
	--31-60��
	{
		{
			bindmoney = 1000000,
			item = {18,1,381,2, {bForceBind=1}, 2},
			repute=200,
			leader=1000,
			freebag=2,
		}, --�峤
		{
			item = {18,1,381,2, {bForceBind=1}, 2},
			repute=100,
			freebag=2,			
		} --��Ա	
	},
	--61-100��
	{
		{
			bindmoney = 500000,
			item = {18,1,381,2, {bForceBind=1}, 1},
			leader=500,
			freebag=1,
		}, --�峤
		{
			item = {18,1,381,2, {bForceBind=1}, 1},
			freebag=1,		
		} --��Ա	
	},
}
