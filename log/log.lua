-- �ļ�������log.lua
-- �����ߡ���wangbin
-- ����ʱ�䣺2008-3-11 21:07:00
-- �ļ�˵������־�ӿ�(д�����־���洢�����ݿ�)

-- ��־����
Log.LEVEL_DEBUG		= 1		-- ������Ϣ
Log.LEVEL_INFO		= 2		-- ��Ϣ����¼��Ϸ��������Ϊ�����ס���������Ʒ���ɵȣ�
Log.LEVEL_WARNING 	= 3		-- ������Ϣ�����Դ���ȣ�
Log.LEVEL_NOTICE	= 4		-- ��Ҫע�����Ϣ����������𻵵ȣ�
Log.LEVEL_CRITICAL	= 5		-- ���أ�ˢװ�����ظ���¼�ȣ�

-- ��־����
Log.TYPE_STATISTICS 	= 1		-- ͳ������
Log.TYPE_ROLEADMIN		= 2		-- ��ɫ����
Log.TYPE_PLAYERCOURSE 	= 3		-- �������
Log.TYPE_EQUIPHISTORY 	= 4		-- װ����ʷ
Log.TYPE_TONG		  	= 5		-- ���
Log.TYPE_PROMOTION	  	= 6		-- �

-- �����Ϊ��־���
Log.emKPLAYERLOG_TYPE_LOGIN			= 0;			-- ��ҵ�¼
Log.emKPLAYERLOG_TYPE_LOGOUT			= 1;			-- ����˳�
Log.emKPLAYERLOG_TYPE_FACTIONSPORTS	= 2;			-- ���ɾ���
Log.emKPLAYERLOG_TYPE_CREATEFAMILY		= 3;			-- ���彨��
Log.emKPLAYERLOG_TYPE_FAMILYAPPOINT	= 4;			-- ����ְλ����
Log.emKPLAYERLOG_TYPE_FAMILYDISMISS 	= 5;			-- �����ɢ
Log.emKPLAYERLOG_TYPE_CREATETONG		= 6;			-- ��Ὠ��
Log.emKPLAYERLOG_TYPE_TONGAPPOINT		= 7;			-- ���ְλ����
Log.emKPLAYERLOG_TYPE_TONGDISMISS		= 8;			-- ����ɢ
Log.emKPLAYERLOG_TYPE_TONGCONTRIBUTE	= 9;			-- ���װ�Ὠ�����
Log.emKPLAYERLOG_TYPE_TONGPAYOFF		= 10;			-- ����ʽ𷢷�
Log.emKPLAYERLOG_TYPE_BUYGOLDCOIN		= 11;			-- ����
Log.emKPLAYERLOG_TYPE_SELLGOLDCOIN		= 12;			-- �����
Log.emKPLAYERLOG_TYPE_USEGOLDCOIN_APP	= 13;			-- �������Ľ��
Log.emKPLAYERLOG_TYPE_USEGOLDCOIN_RES	= 14;			-- ���Ľ�ҽ��
Log.emKPLAYERLOG_TYPE_FINISHTASK		= 15;			-- �������
Log.emKPLAYERLOG_TYPE_JOINSPORT		= 16;			-- �μӻ
Log.emKPLAYERLOG_TYPE_LEVELUP			= 17;			-- �������
Log.emKPLAYERLOG_TYPE_JB_BILL_CANCEL 	= 18;			-- ����������
Log.emKPLAYERLOG_TYPE_PLAYERTRADE		= 19;			--  ��ҽ���
Log.emKPLAYERLOG_TYPE_STALLSELL			= 20;			--  ����
Log.emKPLAYERLOG_TYPE_STALLBUY			= 21;			--  �չ�
Log.emKPLAYERLOG_TYPE_GETACCOUNTMONEY	= 22;			--  ���˻���ȡǮ
Log.emKPLAYERLOG_TYPE_SENDMAIL_MONEYANDITEM	= 23;		--  �ʼĽ����һ���Ʒ
Log.emKPLAYERLOG_TYPE_GETFRIENDCOINBACK	= 24;			--  ���ѷ��ذ󶨽��
Log.emKPLAYERLOG_TYPE_AUCTION			= 25;			--  �����в�����Ϊ
Log.emKPLAYERLOG_TYPE_PROMOTION		= 26;			--  ����������ѽ�һ�ð󶨽��
Log.emKPLAYERLOG_TYPE_COINBANK			= 27;			--  ����Ҵ�������
Log.emKPLAYERLOG_TYPE_ANTIBOT_SCORE	= 28;			--  ������ҵķ�ֵ��¼,���淴���ϵͳ����ҵ�����
Log.emKPLAYERLOG_TYPE_ANTIBOT_PROCESS	= 29;			--  ȷ����ҵĴ���ʽ,���淴���ϵͳ����ҵĴ�����
Log.emKPLAYERLOG_TYPE_COINSTATE		= 30;			--  ��Ҷ��ᣬ�ⶳ��Ϊ
Log.emKPLAYERLOG_TYPE_BINDCOIN			= 31;			--  �󶨽������
Log.emKGLOBAL_TONGLOG_TYPE				= 32;		-- ȫ�ְ��log
Log.emKGLOBAL_KINLOG_TYPE				= 33;		-- ȫ�ּ���log
Log.emKPLAYERLOG_TYPE_REALTION			= 34;		-- ����˼ʹ�ϵ
Log.emKPLAYERLOG_TYPE_COMPENSATE		= 50;		-- �������
Log.emKPLAYERLOG_TYPE_GM_OPERATION		= 51;		-- GM����
Log.emKPLAYERLOG_TYPE_MOONSTONE		= 52;		-- ��Ӱ֮ʯ�һ�
-- ��Ʒ������־���
Log.emKITEMLOG_TYPE_USE				= 0;			-- ����ʹ��
Log.emKITEMLOG_TYPE_ADDITEM			= 1;			-- ��ȡ��Ʒ
Log.emKITEMLOG_TYPE_REMOVEITEM		= 2;			-- ʧȥ��Ʒ


-- ������־����
Log.emKKIN_LOG_TYPE_KINSTRUCTURE	= 1;  -- ����ṹ

-- �����־����
Log.emKTONG_LOG_TONGSTRUCTURE 	= 1; 	 -- "���ṹ"
Log.emKTONG_LOG_TONGBUILDFUN		= 2;	 --"��Ὠ���ʽ�"
Log.emKTONG_LOG_TONGFUND	  		= 3;  -- "����ʽ�"
