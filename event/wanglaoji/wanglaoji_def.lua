--���ϼ��
--�����
--2008.08.25

if not SpecialEvent.WangLaoJi then
	SpecialEvent.WangLaoJi = {};
end

local WangLaoJi = SpecialEvent.WangLaoJi;

WangLaoJi.TIME_STATE =
{
	20080916,
	20081104,
	20081110,
	20081116,
}

WangLaoJi.TIME_STATE_NEW =
{
	20080916,
	20081111,
	20081125,
	20081203,
	20081226,
}

--����
WangLaoJi.TIME_STATE_WEEK =
{
	[20080923] = 1,
	[20080930] = 2,
	[20081007] = 3,
	[20081014] = 4,
	[20081021] = 5,
	[20081028] = 6,
	[20081104] = 7,
	[20081111] = 8,
	[20081118] = 9,
	[20081125] = 10,
}

--������ʾʹ�á�
WangLaoJi.WEEK_MSG =
{
	[1] = "(09/23)",
	[2] = "(09/30)",
	[3] = "(10/07)",
	[4] = "(10/14)",
	[5] = "(10/21)",
	[6] = "(10/28)",
	[7] = "(11/04)",
	[8] = "(11/11)",
	[9] = "(11/18)",
	[10]= "(11/25)",
}

--��¼ÿ�ܵ�һ��
WangLaoJi.KEEP_SORT =
{
	[1] = DBTASD_EVENT_KEEP01,
	[2] = DBTASD_EVENT_KEEP02,
	[3] = DBTASD_EVENT_KEEP03,
	[4] = DBTASD_EVENT_KEEP04,
	[5] = DBTASD_EVENT_KEEP05,
	[6] = DBTASD_EVENT_KEEP06,
	[7] = DBTASD_EVENT_KEEP07,
	[8] = DBTASD_EVENT_KEEP08,
	[9] = DBTASD_EVENT_KEEP09,
	[10]= DBTASD_EVENT_TEMP_01,
}

WangLaoJi.TASK_GROUP = 2047;
WangLaoJi.TASK_GRAGE = 1;	--����
WangLaoJi.TASK_WEEK	 = 2; 	--���е��ڼ���; 
WangLaoJi.TASK_AWARD = 3;	--��ȡ���ս�����־; 
WangLaoJi.TASK_EXAWARD = 14;	--��ȡ���������⽱����־
WangLaoJi.TASK_WEEK_AWARD =  
{
	--��ȡ�ܽ�����Ӧ���������
	[1] = 4,
	[2] = 5,
	[3] = 6,
	[4] = 7,
	[5] = 8,
	[6] = 9,
	[7] = 10,
	[8] = 11,
	[9] = 12,
	[10] = 13,
}

WangLaoJi.DEF_WEEK_GRAGE = 5000; --��һ���Ҵﵽ5000�ֲŻ�ñ��ܵ�һ��
WangLaoJi.DEF_CARD_GRAGE = 10; --ʹ�ÿ�Ƭ��û���
WangLaoJi.DEF_WEEK_EXGRAGE 		= 15000; --������������15000�ֿɶ�����һ������
WangLaoJi.DEF_WEEK_EXPREGRAGE 	= 10000; --ÿ��10000�֣��������һ������
WangLaoJi.CAN_GETCARD_FLAG = 0; --�ν��ÿ�Ƭ��־��1Ϊ�ɻ�ã��ù���ʹ�ûϵͳ��ɣ�

WangLaoJi.ITEM_CARD = {18,1,194,1} ; --���ϼ�����
WangLaoJi.ITEM_TOKEN = {18,1,179,1}; --�����������ƣ�
WangLaoJi.ITEM_XUANJIN = {18,1,1,7}; --������
WangLaoJi.ITEM_TOKEN500 = {18,1,179,3}; --500���������ƣ�

WangLaoJi.NEWS_INFO = 
{
	{
		nKey = 13,
		szTitle = "�����-���ϼ�����",
		szMsg = [[
�ʱ�䣺<color=yellow>9��17��ά���� �� 11��04�� 0��00<color>
    
����ݣ�
    ��ڼ䣬��Ұ�������ܵ���<color=green>���ϼ�����<color>��������ʱʹ��<color=green>���ϼ�����<color>��ȫ�Ӷ����Ի��10%��������ӳɣ�����5���ӡ����ظ�ʹ�ò����ӣ�
]],
	},
	{
		nKey = 14,
		szTitle = "�����-�������ϻ��ж�",
		szMsg = [[
�ʱ�䣺<color=yellow>9��17��ά���� �� 11��25�� 0��00<color>
    
�콱ʱ�䣺<color=yellow>12��02��24��00ǰ <color>
    
����ݣ�
    �ڻ�ڼ䣬�μӰ׻��ã��ν������л�����<color=green>���ϼ�����<color>
    �׻���ɱ��ÿ���Boss�������<color=green>���ϼ�����<color>
    �ν�ս�����7000�����ϵ���ҽ�����<color=green>���ϼ�����<color>
    �ν�ս�����3000��6999��֮�����ҽ�����һ�����ʻ��<color=green>���ϼ�����<color>
    <color=green>���ϼ�����<color>�����ֹʱ��11��04��0�㡣
        
�ռ����
    ��������ڼ䣬ÿ��<color=yellow>���ܶ�0�㵽���ܶ�0�㣩���ֵ�һ<color>������<color=yellow>���ֲ�����5000��<color>�������Ϊ����ͷ�����ɻ��ʢ�Ļ�������ƣ���ð󶨣���ʹ�ú����<color=yellow>�꾩��ң�ȿ���<color>�������½�����
      <color=gold>���������������У�<color>
      <color=gold>���ķɷ������Ů��<color>
				
    ���ʢ�Ļ�������Ƶ���ң����ֽ�����գ�������ҿ��Ա������ּ����μ���һ�ܵľ���
    �����ʱ�� <color=yellow>��������2��20<color>����ң����Ի�����½�����
      <color=green>7���������󶨣�<color>
      
    �콱�뵽���������<color=yellow>ʢ�Ļ�ƹ�Ա<color>��ȡ������
				
    ���⣬������������ߺ���������ǰ20λ����ң����л����������ϼ��ͳ������½�����������
      <color=green>�ʼǱ�����<color>
      <color=green>MP3<color>
      <color=green>���ϼ����裨�䣩<color>
				
]],	
	},
	{
		nKey = 15,
		szTitle = "�������ϻ��ж��ӳ���",
		szMsg = [[
�ʱ�䣺<color=yellow>11��4��0ʱ �� 11��25��0ʱ<color>
    
�콱ʱ�䣺<color=yellow>12��02��24��00ǰ <color>
    
����ݣ�
    �Դӽ������ϻ��ж�������������һ������룬�ܻ��ֲ����ʸߡ����������ܻ��ֺ��Ѿ����￪����<color=yellow>�������ϻ��ж��ӳ���<color>������������˱����������Զ��ӳ���<color=yellow>�������ϻ��ж�<color>��<color=green>3��<color>��
    ϸ�����£�
    1�������ϼ����𿨡���Ч���Զ��ӳ�һ�ܡ���<color=yellow>11��11��0ʱ<color>֮ǰʹ�õġ����ϼ����𿨡���Ȼ����10����֡�
    2�����������ϻ��ж�����ֹ�����Զ�<color=green>�Ӻ�3��<color>�����ֹ�����Զ��ӳ���<color=yellow>11��25��0ʱ<color>���ڼ䣬ÿ�ܣ��ܶ�0�㵽���ܶ�0�㣩���ֵ�һ�����ܻ��ֲ�����5000�ֵ���ң������á�<color=yellow>ʢ�Ļ��������<color>������ð󶨣���
    3�����ʢ�Ļ�������Ƶ���ң����ֽ�����գ�������ҿ��Ա������ּ����μ���һ�ܵľ���
    4�������ʱ��<color=yellow>��������2��20<color>����ң����Ի�����½�����<color=yellow>
      ����  ����
      2-20  7���������󶨣�<color>
]],	
	},	
	
}