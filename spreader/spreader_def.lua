-- �ļ�������spreader_def.lua
-- �����ߡ���xiewen
-- ����ʱ�䣺2008-12-29 16:11:03

Spreader.ZoneGroup = nil;			-- ������

if MODULE_GAMESERVER then
	Spreader.TASK_GROUP = 2070;
	Spreader.TASKID_CONSUME = 1;	-- �ۻ������Ѷ�(GS)
end

if MODULE_GC_SERVER then
	-- �������Ѽ�¼����������(������һ����)
	Spreader.SEND_INTERVAL = 3600;	-- ���ϴη��ͳ���1Сʱ
	Spreader.MIN_CONSUME = 1000;	-- �ۼ����Ѷ����10.00
end

Spreader.ExchangeRate_Gold2JingHuo = 12.5;	-- ��ҶҾ���
Spreader.ExchangeRate_Gold2Jxb = 150;	-- ��һ�������Ĭ�ϻ���
Spreader.ExchangeRate_Rmb2Gold = 100;	-- ����Ҷҽ��

Spreader.GOUHUNYU = 12000;	-- �߼�������۸�


-----------------------����ö��Begin(��gamecenter/kgc_normalprotocoldef.h���Ҫһ��)-----------------
Spreader.emKTYPE_SPREADER = 1			-- �ƹ�Ա
Spreader.emKTYPE_REDUX_PLAYER = 2 		-- ������ٻ�
------------------------����ö��End(��gamecenter/kgc_normalprotocoldef.h���Ҫһ��)------------------

-----------------------����;��ö��Start(��kitemmgr.h���Ҫһ��)-------------------
Spreader.emITEM_CONSUMEMODE_NORMAL = 0
Spreader.emITEM_CONSUMEMODE_REALCONSUME_START = 1								-- ��ʵ����

Spreader.emITEM_CONSUMEMODE_SELL = Spreader.emITEM_CONSUMEMODE_REALCONSUME_START -- ���̵�
Spreader.emITEM_CONSUMEMODE_ENCHASER = 2										-- װ������
Spreader.emITEM_CONSUMEMODE_USINGTIMESEND = 3									-- ʹ�ô�������
Spreader.emITEM_CONSUMEMODE_USINGTIMEOUT = 4									-- ʹ��ʱ�䵽
Spreader.emITEM_CONSUMEMODE_EXPIREDTIMEOUT = 5									-- ��ֵ�ڵ�
Spreader.emITEM_CONSUMEMODE_EAT_QUICK = 6										-- ͨ���Ҽ����ݼ�ʹ��(�Ե�)
Spreader.emITEM_CONSUMEMODE_EAT = 7												-- ͨ���ű�ʹ��(�Ե�)
Spreader.emITEM_CONSUMEMODE_CONSUME = 8											-- ͨ���ű�����
Spreader.emITEM_CONSUMEMODE_ERRORLOST_STACK = 9									-- ����Ʒ�����쳣ɾ��
Spreader.emITEM_CONSUMEMODE_PICKUP = 10											-- ������ʧ
Spreader.emITEM_CONSUMEMODE_COMMONSCRIPT = 11									-- ͨ��ͨ�ýű�ɾ��
Spreader.emITEM_CONSUMEMODE_DUPEDITEM = 12										-- ����Ʒ����ɾ��
Spreader.emITEM_CONSUMEMODE_ERRORLOST_PK = 13									-- ��PKԭ��ʧ���쳣ɾ��
Spreader.emITEM_CONSUMEMODE_ERRORLOST_THROWALLITEM = 14							-- ����Ʒ�����ϣ��쳣ɾ��
Spreader.emITEM_CONSUMEMODE_ERRORLOST_ADDONBODY = 15							-- �������������Ʒʧ�ܣ��쳣ɾ��

Spreader.emITEM_CONSUMEMODE_REALCONSUME_END = Spreader.emITEM_CONSUMEMODE_ERRORLOST_ADDONBODY	-- ��������
Spreader.emITEM_CONSUMEMODE_STACK = 16											-- ����Ʒ����
-------------------------------����;��ö��End------------------------------------
