-------------------------------------------------------
-- �ļ�������youlongmibao_def.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-10-29 14:30:36
-- �ļ�������
-------------------------------------------------------

Youlongmibao.TASK_GROUP_ID 				= 2106;	-- ������Ҥ
Youlongmibao.TASK_YOULONG_HAVEAWARD		= 1;	-- �н�δ��
Youlongmibao.TASK_YOULONG_INTERVAL		= 2;	-- ��ս���
Youlongmibao.TASK_YOULONG_COUNT			= 3;	-- �ۼƴ���
Youlongmibao.TASK_YOULONG_HAPPY_EGG		= 6;	-- �Ƿ��Ѿ��ù����ĵ���0Ϊδ��

Youlongmibao.MAX_TIMES 					= 4;	-- ������4��
Youlongmibao.MAX_GRID					= 25;	-- ��������
Youlongmibao.MAX_INTERVAL				= 20;	-- ��ս���20��

-- ITEM ID
Youlongmibao.ITEM_YUEYING	= {18, 1, 476, 1};	-- ��Ӱ֮ʯ
Youlongmibao.ITEM_ZHANSHU	= {18, 1, 524, 1};	-- ����ս��
Youlongmibao.ITEM_COIN		= {18, 1, 553, 1};	-- �����ű�
Youlongmibao.ITEM_HAPPYEGG	= "18,1,525,1" 		-- ���ĵ�
Youlongmibao.DEF_GET_HAPPYEGG_COUNT	= 5;		-- ǰ5�αص�һ�����ĵ�

-- NPC ID
Youlongmibao.NPC_DIALOG			= 3690;
Youlongmibao.NPC_FIGHT			= 3689;

-- �����Կ���
Youlongmibao.bOpen = EventManager.IVER_bOpenYoulongmibao;
--Youlongmibao.bOpen = 1;

-- ���·��
Youlongmibao.TYPE_RATE_PATH = "\\setting\\event\\youlongmibao\\youlongmibao_rate.txt";
