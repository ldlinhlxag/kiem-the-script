--ȫ����������
--zhouchenfei
--2009-12-16 15:37:34

Require("\\script\\mission\\wlls\\wlls_def.lua")

GbWlls.IsOpen = 1; -- ������־�����ֶ��ر���

GbWlls.GTASK_MACTH_SESSION		= Wlls.GTASK_MACTH_SESSION;
GbWlls.GTASK_MACTH_STATE		= Wlls.GTASK_MACTH_STATE;
GbWlls.DEF_STATE_CLOSE			= Wlls.DEF_STATE_CLOSE;
GbWlls.DEF_STATE_REST			= Wlls.DEF_STATE_REST;
GbWlls.DEF_STATE_MATCH			= Wlls.DEF_STATE_MATCH;
GbWlls.DEF_STATE_ADVMATCH		= Wlls.DEF_STATE_ADVMATCH;
GbWlls.GTASK_STARSERVERFLAG		= DBTASD_GBWLLS_STARSERVER_RANK;		--���Ƿ��������
GbWlls.GTASK_STARSERVERFLAG_TIME= DBTASD_GBWLLS_STARSERVER_RANK_TIME;	--���Ƿ��������
GbWlls.GTASK_MAX_GUESS_TICKET	= DBTASD_GBWLLS_GUESS_MAX_TICKET;

-- �����ұ���
GbWlls.GBTASKID_GROUP				= 2;		-- ���������
GbWlls.GBTASKID_SESSION				= 1;		-- ��¼��Ҳμӵ�ȫ�ַ������������Ľ���
GbWlls.GBTASKID_MATCH_LEVEL			= 2;		-- ��¼��Ҳμӵ�ȫ�ַ������������ȼ�
GbWlls.GBTASKID_MATCH_RANK			= 3;		-- ��¼��Ҳμӵ�ȫ�ַ�������������
GbWlls.GBTASKID_MATCH_WIN_AWARD		= 4;		-- ��ҵ���ʤ������
GbWlls.GBTASKID_MATCH_TIE_AWARD		= 5;		-- ��ҵ���ƽ������
GbWlls.GBTASKID_MATCH_LOSE_AWARD	= 6;		-- ��ҵ�����������
GbWlls.GBTASKID_MATCH_FINAL_AWARD	= 7;		-- ������ս���
GbWlls.GBTASKID_MATCH_ADVRANK		= 8;		-- ��¼��Ҳμӵ�ȫ�ַ�����������ǿ������
GbWlls.GBTASKID_MATCH_TYPE_PAREM	= 9;		-- ��¼�������һЩ��Ҫ��Ϣ�������������ı������ɣ������������ı�������
GbWlls.GBTASKID_MATCH_DAILY_RESULT	= 10;		-- ��¼�����������Ƿ�Ӯ�ñ�����ʱ��

-- �������������
GbWlls.GBTASK_GROUP					= 2;		-- ���ȫ�ֱ�����
GbWlls.GBTASK_SESSION				= 11;		-- ��¼ȫ�ַ�������������
GbWlls.GBTASK_FIRSTOPENTIME			= 12;		-- ��¼ȫ�ַ�������һ������ʱ��
GbWlls.GBTASK_MATCH_STATE			= 13;		-- ��¼�������״̬
GbWlls.GBTASK_MATCH_RANK			= 14;		-- �Ƿ�������ı�־


GbWlls.TASKID_GROUP					= 2111;		-- ���������
GbWlls.TASKID_MONEY_RANK			= 1;		-- �Ƹ���������
GbWlls.TASKID_WLLS_RANK				= 2;		-- ��������
GbWlls.TASKID_MATCH_SESSION			= 3;		-- �����ĵ���������
GbWlls.TASKID_MATCH_WIN_AWARD		= 4;		-- ��ҵ���ʤ������
GbWlls.TASKID_MATCH_TIE_AWARD		= 5;		-- ��ҵ���ƽ������
GbWlls.TASKID_MATCH_LOSE_AWARD		= 6;		-- ��ҵ�����������
GbWlls.TASKID_MATCH_FINAL_AWARD		= 7;		-- ������ս���
GbWlls.TASKID_MATCH_FIRST			= 8;		-- �ھ�����
GbWlls.TASKID_MATCH_SECOND			= 9;		-- ��������
GbWlls.TASKID_MATCH_THIRD			= 10;		-- �Ǿ�����
GbWlls.TASKID_MATCH_BEST			= 11;		-- �������
GbWlls.TASKID_AWARD_LOG				= 12;		-- ������ȡ����log��������(3λ) + �����Σ�3λ�� * 1000 + �����߼����ͣ�1λ�� * 1000000��
GbWlls.TASKID_ENTERFLAG				= 13;		-- ͨ������;�����¼���
GbWlls.TASKID_STATUARY_TYPE			= 14;		-- ����ı��
GbWlls.TASKID_GETFINALAWARD_TIME	= 15;		-- ��¼��ȡ���ս�����ʱ��
GbWlls.TASKID_PRAY_TIME				= 16;		-- ��¼�����ʱ�䣬ÿ��һ��
GbWlls.TASKID_STARSERVER_FLAG		= 17;		-- ���Ƿ�������ȡ�������
GbWlls.TASKID_GUESS_SESSION			= 18;		-- ���µĽ���
GbWlls.TASKID_GUESS_PLAYER_FLAG1	= 19;		-- ���ͶƱ��¼����Ͷ���
GbWlls.TASKID_GUESS_PLAYER_COUNT1	= 20;		-- ��ͶƱ��
GbWlls.TASKID_GUESS_PLAYER_FLAG2	= 21;
GbWlls.TASKID_GUESS_PLAYER_COUNT2	= 22;
GbWlls.TASKID_GUESS_PLAYER_FLAG3	= 23;
GbWlls.TASKID_GUESS_PLAYER_COUNT3	= 24;

GbWlls.DEF_ZONESERVERCOUNT	= 1;

GbWlls.MACTH_PRIM			= 1;		--��������
GbWlls.MACTH_ADV			= 2;		--�߼�����

GbWlls.DEF_MAXGBWLLS_MONEY_RANK = 200;	-- �μӿ��������������ͲƸ�����
GbWlls.DEF_MAXGBWLLS_WLLS_RANK = 150;	-- �μӿ���������������������������

GbWlls.DEF_ADV_MAXGBWLLS_MONEY_RANK = 200;	-- �μӿ���߼�������������ͲƸ�����
GbWlls.DEF_ADV_MAXGBWLLS_WLLS_RANK = 150;	-- �μӿ���߼��������������������������

GbWlls.DEF_OPENGBWLLSSESSION	= 4; 	-- ��������������Ľ�����4��
GbWlls.DEF_MIN_PLAYERLEVEL		= 100;	-- ����μӿ�������ĵȼ�

GbWlls.SEASON_TB 			= GbWlls.SEASON_TB 			or {};		--������
GbWlls.AWARD_LEVEL 			= GbWlls.AWARD_LEVEL 		or {};		--�����ֲ�
GbWlls.MACTH_ENTER_FLAG 	= GbWlls.MACTH_ENTER_FLAG 	or {};		--��ҽ����������־
GbWlls.AWARD_FINISH_LIST  	= GbWlls.AWARD_FINISH_LIST 	or {[GbWlls.MACTH_PRIM]={}, [GbWlls.MACTH_ADV] ={}};		--���ս�����
GbWlls.AWARD_SINGLE_LIST  	= GbWlls.AWARD_SINGLE_LIST 	or {[GbWlls.MACTH_PRIM]={}, [GbWlls.MACTH_ADV] ={}};		--����������

GbWlls.DEF_OPEN_MONTH		= {1, 4, 7, 10}; -- ��������������·�

GbWlls.DEF_SEND_MAIL_DAY	= 1;
GbWlls._DEF_MATCHLEVEL_CHANGETIME = 20100129;

GbWlls.DEF_ADV_PK_STARTDAY	= 29;
GbWlls.DEF_ADV_GUESS_TICKET_ENDTIME	= 19;

-- �����´�����Ҫά��
GbWlls.tbZoneName	= {
	[1] = {"������", 1},
	[2]	= {"�׻���", 2},
	[3]	= {"��ȸ��", 3},
	[4]	= {"������", 4},
	[5]	= {"��ޱ��", 5},
	[6]	= {"������", 6},
	[7]	= {"������", 7},
	[10]	= {"������", 8},
	[11]	= {"������", 9},
};

GbWlls.MAIL_JOINGBWLLS = {
	szTitle		= "�������%s", 
	szContent	= "����%s�����������ٶ����λӢ�۷������룡����������Ϊ<color=yellow>%s<color>��<color=yellow>%s��7��-27�ո�·Ӣ�۽���սѭ������%s��ȫ��8ǿ����ս����<color>��<color=green>��ϲ���ѻ�ñ����ʸ�<color>����ȥ��<color=orange>�ٰ���<color><link=npcpos:�������������,0,3718>��ȥӢ�۵����������ɣ�ȫ��������Ҷ���Ϊ��ף����",
};

GbWlls.MAIL_JOINGBWLLS_ADV = {
	szTitle		= "���%s����ǿ��", 
	szContent	= "Ӣ�۹�Ȼ�Ǹ����еĸ��֣���ϲ������<color=green>%sȫ����ǿ<color>����������<color=yellow>%s��%s��<color>չ�����޵е���į���˾������ˣ���",
};

GbWlls.MSG_JOIN_SUCCESS_FOR_ALL = "<color=yellow>%s<color>�ѱ����μӵ�%s��������<color=yellow>%s<color>����ȥ<color=yellow>�ٰ����Ŀ������������<color>Ϊ��ף���ɣ�";
GbWlls.MSG_JOIN_SUCCESS_FOR_MY	= "���ѱ����ɹ������μӵ�%s������������%s���������ȫ����ҵ�ף����";

GbWlls.MSG_MATCH_RESULT_COMMON_FACTION		= "%s�ڱ���%s�����������Ŀǰ����%s���ɵ�%s����";
GbWlls.MSG_MATCH_RESULT_ADV_FINAL_RESULT_1	= "��%s����%s��ɵ�ս��%s�ڱ���%s����������л����%s��%s��";
GbWlls.MSG_MATCH_RESULT_ADV_FACTION_2		= "%s�ڱ���%s����������л����%s���ɵ�%s����";

GbWlls.MSG_MATCH_TIME_GLOBALMSG_COMMON		= "<color=yellow>����%s����������<color>¡�ؿ��������콫����<color=yellow>%s��%s��7��-27�Ž���ѭ����<color>����λ������ȥ<color=yellow>�ٰ���<color>��<color=yellow>�������������<color>�Ƕ�Ϊ�������õ�ѡ������ף���ɣ�";
GbWlls.MSG_MATCH_TIME_GLOBALMSG_ADV			= "<color=yellow>����%s����������<color>�ѽ�����Ȼ��׶Σ�����ȫ������8ǿ��ѡ�ֽ���<color=yellow>%s�ž���<color>�����������F12��������-������Ϣ����ҿ�ȥ�������������֧����ϲ����ѡ�ְɣ�";
GbWlls.MSG_MATCH_TIME_GLOBALMSG_STAR		= "<color=yellow>��%s��<color>�������������Ļ�������ڱ����ڼ䱾���������ܻ���λ��<color=yellow>%sǰ����<color>�����<color=yellow>�����Ƿ�������<color>�ĳƺţ�����ȫ��������ҹ�ͬ����ҫ����ȥ�ٰ����Ŀ�����������Ĺ�����ҫ֮��ɣ�";

GbWlls.MSG_8RANK_GUESS	= [[    ����������ɵ�����Ԥ���Ѿ���һ���䣬�ھ�����������ɰ�ǿ�Ѿ��������������������ѡ��������˽��ѡ�����ϡ�
    �����ڿ��Զ��Լ���ǰ�����е�����Ŀ�е���ǿ�߱�ʾ֧�֣���ֻ��һ��֧�ֵĻ��ᣬ����֧�ֵ�ѡ�����ջ�ùھ�����Ҳ�����ã�<color=gold>�����������<color>��<color=gold>������������˷�˿��<color>�ĳƺ��Լ�����һ�ܵ�<color=gold>�����⻷<color>Ӵ��ͶƱ��ֹʱ��Ϊ<color=green>4��29��19��<color>��ǧ��Ҫ�����Ӵ��
    ��ʮ�������л��֧������ߵ�����Ҳ���Ի��Ϊ��һ���µ����سƺź͹⻷��
]]; -- ��ǿ���¶Ի���ʾ

GbWlls.MSG_STARPLAYER	= "��ϲ<color=yellow>%s<color>��Ϊ<color=yellow>%s����<color>��ÿ�����������֧������ѡ�֣�������Ϊ��������";

GbWlls.JOIN_TITLE = {6,23,1,0};

GbWlls.DEF_PRAY_MIN_LEVEL				= 69;		-- ��ף����͵ȼ�
GbWlls.DEF_PRAY_MIN_PRESTIGE			= 200;		-- ��ף���������
GbWlls.DEF_PRAY_MIN_MONEY_HONOR_RANK	= 5000;		-- ��ף����ͲƸ���������

GbWlls.DEF_ITEM_LUCK_GBWLLS_CARD		= {18,1,912,1}; -- ���˹ιο�
GbWlls.DEF_ITEM_WINGUESS				= {18,1,913,1};		-- ���˹ιο�ʤ����������
GbWlls.DEF_ITEM_STAR_FLOWER				= {18,1,914,1}; -- ���Ƿ�������

GbWlls.DEF_GUESS_MIN_PRESTIGE_RANK		= 5000;		-- �����������Ҫ��

GbWlls.DEF_NOT_OPEN_LUCKCARD_TIME_START	= 15;
GbWlls.DEF_NOT_OPEN_LUCKCARD_TIME_END	= 22;		-- ���ιο�ʱ�䣬������ÿ��22�����ܿ��ιο�

GbWlls.DEF_ITEM_LOSTGUESS				= {18,1,80,1}; -- ���˹ιο���Ҿ���ʧ�ܵĽ���
GbWlls.DEF_ITEM_LOSTGUESS_COUNT			= 2;	-- ����

GbWlls.DEF_ITEM_WINGUESS8RANK			= {18,1,553,1};	-- �����ű�
GbWlls.DEF_ITEM_LOSTGUESS8RANK			= {18,1,80,1}; -- ���˹ιο���Ҿ���ʧ�ܵĽ���
GbWlls.DEF_ITEM_LOSTGUESS8RANK_COUNT	= 2;	-- ����


GbWlls.DEF_ITEM_GUESS					= {18,1,476,1};	-- ������Ҫ����Ʒ
GbWlls.DEF_COUNT_MAX_GUESS				= 10;	-- һ����ͶƱ�����Ͷ10��

GbWlls.DEF_ITEM_WINGUESS_COUNT			= 1;

GbWlls.tbMatchPlayerList				= {};		-- ���������Ѿ������μӿ����������Ұ�
GbWlls.tb8RankInfo						= {};		-- ����ǰ�������

GbWlls.DEF_MAX_NUM_MONEY_HONOR			= 1000;		-- ȡ1000���Ƹ��������
GbWlls.DEF_MAX_NUM_WLLS_HONOR			= 1000;		-- ȡ1000�������������


GbWlls.DEF_INDEX_GBWLLS_8RANK_LEAGUENAME	= 1;
GbWlls.DEF_INDEX_GBWLLS_8RANK_MAPTYPE 		= 2;
GbWlls.DEF_INDEX_GBWLLS_8RANK_GATEWAY 		= 3;
GbWlls.DEF_INDEX_GBWLLS_8RANK_WIN 			= 4;
GbWlls.DEF_INDEX_GBWLLS_8RANK_TIE 			= 5;
GbWlls.DEF_INDEX_GBWLLS_8RANK_TOTAL 		= 6;
GbWlls.DEF_INDEX_GBWLLS_8RANK_RANK 			= 7;
GbWlls.DEF_INDEX_GBWLLS_8RANK_ADVRANK		= 8;
GbWlls.DEF_INDEX_GBWLLS_8RANK_TIME			= 9;
GbWlls.DEF_INDEX_GBWLLS_8RANK_ADVID			= 10;
GbWlls.DEF_INDEX_GBWLLS_8RANK_MATCHTYPE		= 11;

GbWlls.DEF_DAY_STARSERVER_1	= 20;	-- �񻨻����ʱ��
GbWlls.DEF_DAY_STARSERVER_2	= 20;	-- �񻨻����ʱ��
GbWlls.DEF_DAY_STARSERVER_3	= 10;	-- �񻨻����ʱ��
GbWlls.DEF_DAY_STARSERVER_4	= 5;	-- �񻨻����ʱ��

GbWlls.DEF_MAX_NUM_GUESS_TICKET				= 1000;	-- ÿ���˶�һ���������Ͷ1000Ʊ

GbWlls.DEF_NUM_PER_TICKET		= 3; -- ÿ��Ͷע��3�������ű�
GbWlls.DEF_TIME_MSG_MAX_COUNT	= 6; -- ÿ�η�6��
GbWlls.DEF_TIME_MSG_TIME		= 10 * 60; -- 10����һ��
GbWlls.DEF_TIME_SEND_JOINMAIL	= 5 * 60;

GbWlls.IsOpenEvent1	= 1;	-- �Ƿ��������
GbWlls.IsOpenEvent2	= 1;	-- �Ƿ������˿��
GbWlls.IsOpenEvent3	= 1;	-- �Ƿ�����ǿ���»

GbWlls.DEF_STARPLAYER_FAC_TITLE	= {12, 10};
GbWlls.DEF_STARFANS_TITLE	= {6,24,1,0};

GbWlls.DEF_STARNUM = 4;

GbWlls.DEF_TIME_SAVE_GBWLLSBUF	= 10 * 60;
GbWlls.DEF_TIME_ADV_STARTMSG	= 25;
