

EPlatForm.GTASK_MACTH_SESSION 		= DBTASD_EVENT_SESSION;		--��������
EPlatForm.GTASK_MACTH_LASTSESSION	= DBTASD_EVENT_LASTSESSION; --�Ͻ������������¼����ʹ�ã���ֹ�������������ʱ����
EPlatForm.GTASK_MACTH_STATE 	 	= DBTASD_EVENT_STATE;		--�����׶�(0,δ����, 1��Ъ��,2.�����ڵ�һ�׶�,3.�����ڵڶ��׶� 4.��ǿ����)
EPlatForm.GTASK_MACTH_MAP_STATE		= DBTASD_EVENT_MAP_STATE;	--׼��������״̬��0��δ����1������
EPlatForm.GTASK_MACTH_RANK			= DBTASD_EVENT_RANK;		--�Ƿ���������ɱ�־
EPlatForm.GTASK_MACTH_MAX_SCORE_FOR_NEXT	= DBTASD_EVENT_MAX_SCORE_FOR_NEXT;

EPlatForm.DEF_STATE_CLOSE			= 0;		--δ����
EPlatForm.DEF_STATE_REST			= 1;		--��Ъ��
EPlatForm.DEF_STATE_MATCH_1		= 2;		--�����ڵ�һ�׶�
EPlatForm.DEF_STATE_MATCH_2		= 3;		--�����ڵڶ��׶�
EPlatForm.DEF_STATE_ADVMATCH		= 4;		--��ǿ����

EPlatForm.DEF_STATE_MSG = {
	[EPlatForm.DEF_STATE_CLOSE]			= "δ����״̬",
	[EPlatForm.DEF_STATE_REST]			= "��Ъ��",
	[EPlatForm.DEF_STATE_MATCH_1]		= "����ѡ����",
	[EPlatForm.DEF_STATE_MATCH_2]		= "����Ԥѡ��",	
	[EPlatForm.DEF_STATE_ADVMATCH]		= "�������",
};


-- ��һ�׶��ò���ս�ӣ����ڶ��׶�֮���õ�
EPlatForm.LGTYPE	= 7;	--�ƽ̨ս��ϵͳ����

--LG Task ID--
EPlatForm.LGTASK_MSESSION	= 1;		--����
EPlatForm.LGTASK_MTYPE		= 2;		--��������
EPlatForm.LGTASK_MEXPARAM	= 3;		--���ƶ������(������,�Ա��)
EPlatForm.LGTASK_MLEVEL		= 4;		--�����ȼ���1�ͼ�, 2�߼���
EPlatForm.LGTASK_RANK		= 5;		--ս�ӻ�����Σ����������������ã�
EPlatForm.LGTASK_WIN		= 6;		--ʤ������
EPlatForm.LGTASK_TIE		= 7;		--ƽ�ִ���
EPlatForm.LGTASK_TOTAL		= 8;		--����������ʧ�ܴ��� = TOTAL - WIN - TIE��
EPlatForm.LGTASK_TIME		= 9;		--ս��ʱ���ܼ�
EPlatForm.LGTASK_EMY1		= 10;		--����һ�����������Ķ��֣�ս����String2ID��
EPlatForm.LGTASK_EMY2		= 11;		--�����ڶ������������Ķ���
EPlatForm.LGTASK_EMY3		= 12;		--�������������������Ķ���
EPlatForm.LGTASK_ATTEND		= 13;		--δ����0�ͽ���׼����Id(����׼����Ϊ�Ѳ���)
EPlatForm.LGTASK_ENTER		= 14;		--����׼������Ա����.
EPlatForm.LGTASK_EMY4		= 15;		--�������ĳ����������Ķ���
EPlatForm.LGTASK_EMY5		= 16;		--�������峡���������Ķ���
EPlatForm.LGTASK_RANK_ADV	= 17;		--��ǿ��������
EPlatForm.LGTASK_DYNID		= 18;		--����ĳ��׼�������ĳ��������
EPlatForm.LGTASK_DALIYCOUNT	= 19;		--�μӻ�ĸ���
EPlatForm.LGTASK_DALIYCHANGETIME	= 20;		--�μӻ�ĸ���

--LG MemberTask ID--
EPlatForm.LGMTASK_JOB		= 1;	--ְλ:0����Ա��1���ӳ�
EPlatForm.LGMTASK_AWARD		= 2;	--��������:0���޲��콱����1��ʤ������,�����Զ���ȡ. 2.ƽ����, 3������
EPlatForm.LGMTASK_FACTION	= 3;	--����
EPlatForm.LGMTASK_ROUTEID	= 4;	--·��
EPlatForm.LGMTASK_CAMP		= 5;	--��Ӫ
EPlatForm.LGMTASK_SEX		= 6;	--�Ա�
EPlatForm.LGMTASK_SERIES	= 7;	--����


--Task ID--
EPlatForm.TASKID_GROUP			= 2103;		--���������
EPlatForm.TASKID_MATCH_TOTLE	= 1;		--�ܳ���
EPlatForm.TASKID_MATCH_WIN		= 2;		--ʤ����
EPlatForm.TASKID_MATCH_TIE		= 3;		--ƽ����
EPlatForm.TASKID_MATCH_FIRST	= 4;		--�ھ�����
EPlatForm.TASKID_MATCH_SECOND	= 5;		--��������
EPlatForm.TASKID_MATCH_THIRD	= 6;		--�Ǿ�����
EPlatForm.TASKID_MATCH_BEST		= 7;		--�������
EPlatForm.TASKID_MATCH_FINISH	= 8;		--�Ƿ���ȡ��������
EPlatForm.TASKID_HELP_SESSION	= 9;		--�������ң�ս�ӻƽ̨����
EPlatForm.TASKID_HELP_TOTLE		= 10;		--�������ң�ս���ܳ���
EPlatForm.TASKID_HELP_WIN		= 11;		--�������ң�ս��Ӯ����
EPlatForm.TASKID_HELP_TIE		= 12;		--�������ң�ս�Ӹ�����
EPlatForm.TASKID_MATCH_WIN_AWARD = 13;		--����ʤ����ȡ������־
EPlatForm.TASKID_AWARD_LOG		= 14;		--������ȡ����log��������(3λ) + �����Σ�3λ�� * 1000 + �����߼����ͣ�1λ�� * 1000000��
EPlatForm.TASKID_ENTER_READY	= 15;
EPlatForm.TASKID_ENTER_DYN		= 16;
EPlatForm.TASKID_DALIYEVENTCOUNT= 17;
EPlatForm.TASKID_COUNTCHANGETIME= 18;
EPlatForm.TASKID_SESSIONFLAG	= 19;		-- ��¼��Ҳμӵı����ͼ�¼�ı����ڼ��׶�
EPlatForm.TASKID_ATTEND_AWARD	= 20;
EPlatForm.TASKID_AWARDFLAG		= 21;		-- ��ҽ���
EPlatForm.TASKID_KINAWARDFLAG	= 22;		-- ��Ҽ��影��
EPlatForm.TASKID_KINAWARDEXFLAG	= 24;		-- ��Ҽ��影���������
EPlatForm.TASKID_MATCH_TOTLE_MATCH1	= 25;		-- ��ҵ�һ�׶��Ѳμӳ��δ���
EPlatForm.TASKID_PLAYER_LOGINRV	= 26;		-- ��������弼��

--��������弼��ʱ��
EPlatForm.PLAYER_LOGINRV_DATE	= 20100211;		-- ��������弼��ʱ��


--����ѡ�ֲ���
EPlatForm.PLAYER_ATTEND_LEVEL 		= 100;		--��͵ȼ�����;
EPlatForm.MAP_SELECT_MIN			= 8;		--ÿ��׼���������Ƚ�����ٶӡ�
EPlatForm.MAP_SELECT_SUBAREA		= 8;		--ƥ��ԭ��,��ʤ�ʶ��ٶ�Ϊһ������
EPlatForm.MAP_SELECT_MAX			= 100;		--ÿ�ű�����ͼ����м���������̨��
EPlatForm.MACTH_LEAGUE_MIN			= 4;		--׼����������Ҫ�ж��ٶӲ��ܿ�����
EPlatForm.MACTH_ATTEND_MAX			= 48;		--ÿ��ս�����μӶ��ٳ�
EPlatForm.MACTH_POINT_WIN 			= 3;		--ʤ����û���
EPlatForm.MACTH_POINT_TIE 			= 2;		--ƽ��û���
EPlatForm.MACTH_POINT_LOSS 			= 1;		--���������û���
EPlatForm.MACTH_TIME_BYE  			= 300;		--�ֿռ���ı���ʱ�������
EPlatForm.MACTH_NEW_WINRATE  		= 50;		--һ��û����鰴50��ʤ�ʼ���
EPlatForm.nCurReadyMaxCount			= 24;		-- ���׶�׼������������
EPlatForm.nCurMatchMaxTeamCount		= 8;		-- ���׶α���������������
EPlatForm.nCurMatchMinTeamCount		= 8;		-- ���׶α������ٿ�����������
EPlatForm.MACTH_MAX_JOINCOUNT		= 14;
EPlatForm.MIN_TEAM_EVENT_NUM		= 3;		-- �μӱ����Ķ����Ա��������
EPlatForm.MAX_KINRANK_NEXTMATCH		= 120;		-- �μ���һ�׶α����ļ�����������
EPlatForm.DEF_MIN_KINSCORE			= 0;		-- ��С�ܲμӵڶ��׶εļ������
EPlatForm.DEF_MIN_KINSCORE_PLAYER	= 24;		-- ��С�ܲμӵڶ��׶εĸ��˻���
EPlatForm.DEF_MIN_KINAWARD_SCORE	= 24;
EPlatForm.DEF_MAX_KINAWARDCOUNT		= 40;
EPlatForm.DEF_DEADLINE_CHECKDAY		= 1;		-- �����Զ���֤����,��һ�׶α������һ��
EPlatForm.DEF_MAX_TOTALCOUNT		= 28;		-- һ������ڵ�һ�׶����μӳ���

EPlatForm.MATCH_WELEE				= 1;
EPlatForm.MATCH_TEAMMATCH			= 2;
EPlatForm.MATCH_KINAWARD			= 3;

--��ǿ�����ζ�Ӧ��
EPlatForm.MACTH_STATE_ADV_TASK = 
{
	[1] = 8,
	[2] = 4,
	[3] = 2,
	[4] = 2,
	[5] = 2,
};

-- �ֶӹ���
EPlatForm.MATCH_TEAM_PART = {
	[1] = 1,
	[2] = 2,
	[3] = 2,	
	[4] = 1,
	[5] = 1,
	[6] = 2,	
	[7] = 2,
	[8] = 1,
	[9] = 1,	
	[10] = 2,
};

--����������
EPlatForm.MACTH_TIME_READY 			= Env.GAME_FPS * 280;		--׼����׼��ʱ��;
EPlatForm.MACTH_TIME_READY_LASTENTER = Env.GAME_FPS * 5;			--����5�벻�������;
EPlatForm.MACTH_TIME_PK_DAMAGE 		= Env.GAME_FPS * 5;			--ͬ����Ѫ��ʱ��;
EPlatForm.MACTH_TIME_UPDATA_RANK 	= Env.GAME_FPS * 610;		--׼��ʱ�����������������ʱ���������;
EPlatForm.DEF_READY_TIME_ENTER		= Env.GAME_FPS * 10

EPlatForm.MACTH_TIME_ADVMATCH 		= Env.GAME_FPS * 900;		--��ǿ��ÿ�����ʱ��;
EPlatForm.MACTH_TIME_ADVMATCH_MAX 	= 5;						--��ǿ���ܳ�����5��;

EPlatForm.MACTH_TIME_RANK_FINISH 	= Env.GAME_FPS * 60;		--Ԥ��������������Ҫ����ʱ�䣬��Ҳ�����ȡ����

EPlatForm.MIS_LIST 	= 
{	
	{"PkToPkStart", 	Env.GAME_FPS * 15, 	"OnGamePk"	},	--Pk׼��ʱ�� 15��
	{"PkStartToEnd", 	Env.GAME_FPS * 585, "OnGameOver"},	--����ʱ�� 585��
};
EPlatForm.MIS_UI 	= 
{
	[1] = {"<color=gold>%s Vs %s\n\n", "<color=green>������ʼʣ��ʱ�䣺<color=white>%s<color>\n\n", "<color=green>�Է�����������<color=red>%s\n<color=green>��������������<color=blue>%s"};
	[2] = {"<color=gold>%s Vs %s\n\n", "<color=green>ʣ��ʱ�䣺<color=white>%s<color>\n\n", "<color=green>�Է�����������<color=red>%s\n<color=green>��������������<color=blue>%s"};
}
EPlatForm.MIS_UI_LOOKER = "<color=green>%s����Ѫ����<color=red>\n    %s\n\n<color=green>%s����Ѫ����\n    <color=blue>%s";

EPlatForm.MACTH_TRAP_ENTER ={{50464/32, 103712/32}, {53600/32, 106912/32}, {48000/32, 105024/32}, {51872/32, 109696/32}};	--����׼��������
EPlatForm.MACTH_TRAP_LEAVE ={{1392,3091},};	--����᳡����
EPlatForm.MACTH_TRAP_LEAVE_MAPID = 1;
EPlatForm.SNOWFIGHT_ITEM_SINGLEWIN	= 	{18,1,282,1}


--�ڴ��¼��
EPlatForm.MissionList 	= EPlatForm.MissionList   or {};		--mission
EPlatForm.GroupList 		= EPlatForm.GroupList 	 or {};		--ս����ʱ����;
EPlatForm.GroupListTemp 	= EPlatForm.GroupListTemp or {};		--ս����ʱ����2;
EPlatForm.ReadyTimerId 	= EPlatForm.ReadyTimerId  or 0;			--׼������ʱ��Id;
EPlatForm.GameState 		= EPlatForm.GameState	 or 0;			--���������׶�,0δ��ʼ,1׼���׶�,2pk�׶�
EPlatForm.PosGamePk 		= EPlatForm.PosGamePk 	 or {};			--pk�����������
EPlatForm.PosGameReady 		= EPlatForm.PosGameReady 	 or {};			--pk�����������
EPlatForm.AdvMatchState	= EPlatForm.AdvMatchState or 0;			--��ǿ���׶Σ���1��8��4��2��4��2��3��������1��4��������2��5��������3����
EPlatForm.AdvMatchLists	= EPlatForm.AdvMatchLists or {};			--��ǿ��������
EPlatForm.WaitMapMemList = EPlatForm.WaitMapMemList or {};		--�᳡�������

EPlatForm.SEASON_TB 			= EPlatForm.SEASON_TB 			or {};		--������
EPlatForm.AWARD_LEVEL 		= EPlatForm.AWARD_LEVEL 			or {};		--�����ֲ�
EPlatForm.MACTH_ENTER_FLAG 	= EPlatForm.MACTH_ENTER_FLAG 	or {};		--��ҽ����������־
EPlatForm.AWARD_FINISH_LIST  = EPlatForm.AWARD_FINISH_LIST 	or {};		--���ս�����
EPlatForm.AWARD_SINGLE_LIST  = EPlatForm.AWARD_SINGLE_LIST 	or {};		--����������

--���ݴ���
EPlatForm.RankFrameCount 	= 1000;							--ÿ֡����1000��ս�ӽ������ݴ���
EPlatForm.RankLeagueList 	= EPlatForm.RankLeagueList 	or {};	--ս�������,��֡�����������ʹ��
EPlatForm.RankLeagueId 		= EPlatForm.RankLeagueId		or 0;	--ս�������¼,��֡�����������ʹ��
EPlatForm.ClsLeagueList 		= EPlatForm.ClsLeagueList	or {};	--ս�������,��֡�����������ʹ��
EPlatForm.ClsLeagueId 		= EPlatForm.ClsLeagueId		or 0;	--ս�������¼,��֡�����������ʹ��

--��ս����
EPlatForm.LookerLeagueMap 	= EPlatForm.LookerLeagueMap or {};
EPlatForm.LookPlayerCount 	= EPlatForm.LookPlayerCount or {};
EPlatForm.tbLookerReady		= EPlatForm.tbLookerReady or {};
EPlatForm.tbLook				= EPlatForm.tbLook or {};

--��ҩ��ʾ
EPlatForm.ForbidItem = 
{
	{18,1,28,1},	--��ҩ��С������
	{18,1,29,1},	--���񵤣�С������
	{18,1,30,1},	--�����ۣ�С������
	{18,1,31,1},	--��ҩ���У�����
	{18,1,32,1},	--���񵤣��У�����
	{18,1,33,1},	--�����ۣ��У�����
	{18,1,34,1},	--��ҩ���󣩡���
	{18,1,35,1},	--���񵤣��󣩡���
	{18,1,36,1},	--�����ۣ��󣩡���
	{18,1,37,1},	--���쵤����
	{18,1,38,1},	--��ɢ����
	{18,1,39,1},	--���ɲ��ĵ�����
	{18,1,40,1},	--��ת���굤����
	{18,1,41,1},	--���ڻ��񵤡���
	{18,1,42,1},	--�廨��¶�衤��
};

EPlatForm.SERIES_RESTRAINT_TABLE = {
	[Env.SERIES_METAL]		= {Env.SERIES_WOOD, Env.SERIES_FIRE},		-- ��ϵ
	[Env.SERIES_WOOD]		= {Env.SERIES_EARTH, Env.SERIES_METAL},		-- ľϵ
	[Env.SERIES_WATER]		= {Env.SERIES_FIRE, Env.SERIES_EARTH},		-- ˮϵ
	[Env.SERIES_FIRE]		= {Env.SERIES_METAL, Env.SERIES_WATER},		-- ��ϵ
	[Env.SERIES_EARTH]		= {Env.SERIES_WATER, Env.SERIES_WOOD},		-- ��ϵ
}

EPlatForm.SERIES_COLOR = {
	[Env.SERIES_METAL]		= "<color=orange>%s<color>",		-- ��ϵ
	[Env.SERIES_WOOD]		= "<color=green>%s<color>",			-- ľϵ
	[Env.SERIES_WATER]		= "<color=blue>%s<color>",			-- ˮϵ
	[Env.SERIES_FIRE]		= "<color=salmon>%s<color>",		-- ��ϵ
	[Env.SERIES_EARTH]		= "<color=wheat>%s<color>",			-- ��ϵ	
};

