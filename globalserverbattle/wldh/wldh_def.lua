--���ִ��
--�����
--2008.09.11
--ʱ���

Wldh.IS_OPEN = GLOBAL_AGENT or 0;	--����
Wldh.END_DATE = 20091110;	--���ִ�����ս���ʱ�䣨ȫ�ַ������ر����ִ�ᣩ
Wldh.STATE1_DATE = 
{
	--��ʼ����(0��), ��������(24��),�׶�
	{20091009, 20091013, 1}, --���������� 
	{20091014, 20091018, 2}, --˫�� 
	{20091019, 20091023, 3}, --���� 
	{20091024 ,20091028, 4}, --�������� 	
};

Wldh.STATE2_DATE = 
{
	--��ʼ����(0��), 32ǿ����ʱ��, ���򼸳�, �׶�
	{20091029, 7, 5}, --���������� 
	{20091103, 7, 6}, --˫�� 
	{20091031, 7, 7}, --���� 
	{20091101 ,7, 8}, --�������� 
};
Wldh.STATE3_DATE = {
	
	20091104,	--С�����콱��ʼʱ��
	20091109,	--С�����콱����ʱ��
}
Wldh.STATE4_DATE = {
	
	20091104,	--�����콱��ʱ�俪ʼʱ��
	20091130,	--�����콱��ʱ�����ʱ��
}
Wldh.STATE5_DATE = {
	
	20091104,	--�������콱��ʼʱ��
	20091105,	--�������콱����ʱ��
}

-- 11�º����б�
Wldh.COZONE_LIST = 
{
	[401] = 403,
	[403] = 401,
	[421] = 422,
	[422] = 421,
	[512] = 514,
	[514] = 512,
	[605] = 616,
	[616] = 605,
	[620] = 621,
	[621] = 620,
};

Wldh.STATE_TYPE = {
	--�׶Σ�{�������ͣ�����/����}
	[1] = {1, 0},
	[2] = {2, 0},
	[3] = {3, 0},
	[4] = {4, 0},
	[5] = {1, 1},
	[6] = {2, 1},
	[7] = {3, 1},
	[8] = {4, 1},
};

Wldh.STATE1_PRE_TIME = 
{
	2000,2015,2030,2045,2100,2115,2130,2145,
};

Wldh.OPEN_WLLS_DATA = 20091028; --��ʱ��֮ǰӵ�вμ����ִ���ʸ�ĳ�Ա���ܲμ���������������ս�ӡ�

--���ճ���ѭ�������ս��ʱ��
Wldh.STATE1_PRE_FINIAL_TIME = {2205};

--��������ʱ��
Wldh.STATE2_PRE_FINIAL_TIME = {2000};

Wldh.LADDER_ID = {
	[1] = {"���ɵ�����",	Ladder.LADDER_CLASS_WLDH, 1, 0, Task.tbHelp.NEWSKEYID.NEWS_WLDH_1},--���ɵ�����
	[2] = {"˫����", 		Ladder.LADDER_CLASS_WLDH, 2, 0, Task.tbHelp.NEWSKEYID.NEWS_WLDH_2},--˫����
	[3] = {"������", 		Ladder.LADDER_CLASS_WLDH, 3, 0, Task.tbHelp.NEWSKEYID.NEWS_WLDH_3},--������
	[4] = {"����������", 	Ladder.LADDER_CLASS_WLDH, 4, 0, Task.tbHelp.NEWSKEYID.NEWS_WLDH_4},--����������
	[5] = {"����������", 	Ladder.LADDER_CLASS_WLDH, 5, 0, Task.tbHelp.NEWSKEYID.NEWS_WLDH_5},--����������
};



--GTsk
Wldh.GTASK_MACTH_TYPE 	= DBTASD_WLDH_TYPE;		--��������

--LG Task ID--
Wldh.LGTASK_MSESSION= 1;		--����
Wldh.LGTASK_MTYPE	= 2;		--��������
Wldh.LGTASK_RANK	= 3;		--ս�ӻ�����Σ����������������ã�
Wldh.LGTASK_WIN		= 4;		--ʤ������
Wldh.LGTASK_TIE		= 5;		--ƽ�ִ���
Wldh.LGTASK_TOTAL	= 6;		--����������ʧ�ܴ��� = TOTAL - WIN - TIE��
Wldh.LGTASK_TIME	= 7;		--ս��ʱ���ܼ�
Wldh.LGTASK_EMY1	= 8;		--����һ�����������Ķ��֣�ս����String2ID��
Wldh.LGTASK_EMY2	= 9;		--�����ڶ������������Ķ���
Wldh.LGTASK_EMY3	= 10;		--�������������������Ķ���
Wldh.LGTASK_ATTEND	= 11;		--δ����0�ͽ���׼����Id(����׼����Ϊ�Ѳ���)
Wldh.LGTASK_ENTER	= 12;		--����׼������Ա����.
Wldh.LGTASK_EMY4	= 13;		--�������ĳ����������Ķ���
Wldh.LGTASK_EMY5	= 14;		--�������峡���������Ķ���
Wldh.LGTASK_RANK_ADV= 15;		--��ǿ��������

--LG MemberTask ID--
Wldh.LGMTASK_JOB	= 1;		--ְλ:0����Ա��1���ӳ�
Wldh.LGMTASK_AWARD	= 2;		--��������:0���޲��콱����1��ʤ������,�����Զ���ȡ. 2.ƽ����, 3������
Wldh.LGMTASK_FACTION= 3;		--����
Wldh.LGMTASK_ROUTEID= 4;		--·��
Wldh.LGMTASK_CAMP	= 5;		--��Ӫ
Wldh.LGMTASK_SEX	= 6;		--�Ա�
Wldh.LGMTASK_SERIES	= 7;		--����

--Task ID--
Wldh.TASKID_GROUP			= 2102;		--���������
Wldh.TASKID_ATTEND_TYPE		= 1;		--�μ�����
Wldh.TASKID_CHOSE_TYPE		= 2;		--3ѡ1ѡ������
Wldh.TASKID_Award	= {
	--����={�����콱�����ս���}
	[1] = {3,4},
	[2] = {5,6},
	[3] = {7,8},
	[4] = {9,10},
};

Wldh.GBTASKID_GROUP			= 1;		--���������
Wldh.GBTASKID_ATTEND_ID	= 
{
	[1] = 1,		--�������μ��ܳ���
 	[2] = 2,		--˫�����μ��ܳ���
 	[3] = 3,		--�������μ��ܳ���
 	[4] = 4,		--�������μ��ܳ���
};

Wldh.GBTASKID_FINAL_ID = 
{
	[1] = 5;		--������������������¼��ǿ��
	[2] = 6;		--˫����������������¼��ǿ��
	[3] = 7;		--������������������¼��ǿ��
	[4] = 8;		--������������������¼��ǿ��
}

Wldh.GBTASKID_BATTLE_WIN_ID = 9;	--����������ʤ������
Wldh.GBTASKID_CHOSE_TYPE = 10		--3ѡ1ѡ������
Wldh.GBTASKID_FACTION_ID = 11		--�������μӵ�����Id

Wldh.GBTASKID_BATTLE_ATTEND_ID 	= 12;	--���������˲μӴ���
Wldh.GBTASKID_BATTLE_RANK_ID 	= 13;	--��������������

--��᳡����׼�������ͣ�
Wldh.MAP_LINK_TYPE_RANDOM 	= 1;		--���ѡ�����;���׼����
Wldh.MAP_LINK_TYPE_SERIES 	= 2;		--���ж�Ӧ����;׼������ͼ���Ϊս������,������Ҳ��
Wldh.MAP_LINK_TYPE_FACTION 	= 3;		--���ɶ�Ӧ����;׼������ͼ���Ϊս������,������Ҳ��

--ս��������ͣ�
Wldh.LEAGUE_TYPE_SEX_FREE 			= 0;		--�����Ա�
Wldh.LEAGUE_TYPE_SEX_SINGLE 		= 1;		--ͬһ�Ա�;
Wldh.LEAGUE_TYPE_SEX_MIX 			= 2;		--����Ա�;
Wldh.LEAGUE_TYPE_CAMP_FREE 			= 0;		--������Ӫ;
Wldh.LEAGUE_TYPE_CAMP_SINGLE 		= 1;		--ͬһ��Ӫ;
Wldh.LEAGUE_TYPE_CAMP_MIX 			= 2;		--�����Ӫ;
Wldh.LEAGUE_TYPE_SERIES_FREE 		= 0;		--��������;
Wldh.LEAGUE_TYPE_SERIES_SINGLE 		= 1;		--ͬһ����;
Wldh.LEAGUE_TYPE_SERIES_MIX 		= 2;		--�������;
Wldh.LEAGUE_TYPE_SERIES_RESTRAINT	= 3;		--�������;�������ͱ��汾�ݲ�������
Wldh.LEAGUE_TYPE_FACTION_FREE 		= 0;		--��������;
Wldh.LEAGUE_TYPE_FACTION_SINGLE 	= 1;		--ͬһ����;
Wldh.LEAGUE_TYPE_FACTION_MIX 		= 2;		--�������;
Wldh.LEAGUE_TYPE_TEACHER_FREE 		= 0;		--����ʦͽ;
Wldh.LEAGUE_TYPE_TEACHER_MIX 		= 1;		--���ʦͽ;


--����ѡ�ֲ���
Wldh.PLAYER_ATTEND_LEVEL 		= 100;		--��͵ȼ�����;
Wldh.MAP_SELECT_MIN				= 10;		--ÿ��׼���������Ƚ�����ٶӡ�
Wldh.MAP_SELECT_SUBAREA			= 10;		--ƥ��ԭ��,��ʤ�ʶ��ٶ�Ϊһ������
Wldh.MAP_SELECT_MAX				= 100;		--ÿ�ű�����ͼ����м���������̨��
Wldh.MACTH_LEAGUE_MIN			= 2;		--׼����������Ҫ�ж��ٶӲ��ܿ�����
Wldh.MACTH_ATTEND_MAX			= 24;		--ÿ��ս�����μӶ��ٳ�
Wldh.MACTH_POINT_WIN 			= 3;		--ʤ����û���
Wldh.MACTH_POINT_TIE 			= 1;		--ƽ��û���
Wldh.MACTH_POINT_LOSS 			= 0;		--���������û���
Wldh.MACTH_TIME_BYE  			= 300;		--�ֿռ���ı���ʱ�������
Wldh.MACTH_NEW_WINRATE  		= 50;		--һ��û����鰴50��ʤ�ʼ���

--32ǿ�����ζ�Ӧ��
Wldh.MACTH_STATE_ADV_TASK = 
{
	[1] = 32,
	[2] = 16,
	[3] = 8,
	[4] = 4,
	[5] = 2,
	[6] = 2,
	[7] = 2,
	[8] = 1,
};

--����������
Wldh.MACTH_TIME_READY 			= Env.GAME_FPS * 280;		--׼����׼��ʱ��;
Wldh.MACTH_TIME_READY_LASTENTER = Env.GAME_FPS * 5;			--����5�벻�������;
Wldh.MACTH_TIME_PK_DAMAGE 		= Env.GAME_FPS * 5;			--ͬ����Ѫ��ʱ��;
Wldh.MACTH_TIME_UPDATA_RANK 	= Env.GAME_FPS * 900;		--��ʼ���������ʱ���������;

Wldh.MACTH_TIME_ADVMATCH 		= Env.GAME_FPS * 900;		--��ǿ��ÿ�����ʱ��;
Wldh.MACTH_TIME_ADVMATCH_MAX 	= 7;						--��ǿ���ܳ�����5��;

Wldh.MIS_LIST 	= 
{	
	{"PkToPkStart", 	Env.GAME_FPS * 15, 	"OnGamePk"	},	--Pk׼��ʱ�� 15��
	{"PkStartToEnd", 	Env.GAME_FPS * 585, "OnGameOver"},	--����ʱ�� 585��
};

Wldh.MIS_UI 	= 
{
	[1] = {"<color=gold>%s Vs %s\n\n", "<color=green>������ʼʣ��ʱ�䣺<color=white>%s<color>\n\n", "<color=green>�Է�����������<color=red>%s\n<color=green>��������������<color=blue>%s"};
	[2] = {"<color=gold>%s Vs %s\n\n", "<color=green>ʣ��ʱ�䣺<color=white>%s<color>\n\n", "<color=green>�Է�����������<color=red>%s\n<color=green>��������������<color=blue>%s"};
}

Wldh.MIS_UI_LOOKER = "<color=green>%s����Ѫ����<color=red>\n    %s\n\n<color=green>%s����Ѫ����\n    <color=blue>%s";
Wldh.MACTH_TRAP_ENTER ={{50464/32, 103712/32}, {53600/32, 106912/32}, {48000/32, 105024/32}, {51872/32, 109696/32}};	--����׼��������
Wldh.MACTH_TRAP_LEAVE ={{52672/32, 104192/32}, {54784/32, 106336/32}, {49824/32, 108320/32}, {52224/32, 110592/32}};	--����᳡����
Wldh.MACTH_ENTER_FLAG = {};

--�ڴ��¼��
Wldh.MissionList 	= {};		--mission
Wldh.GroupList 		= {};		--ս����ʱ����;
Wldh.GroupListTemp 	= {};		--ս����ʱ����2;
Wldh.tbReadyTimer 	= {};		--׼������ʱ��Id;
Wldh.tbGameState	= {};		--���������׶�,0δ��ʼ,1׼���׶�,2pk�׶�
Wldh.AdvMatchState	= {};		--32ǿ���׶Σ���1��32��16��2��16��8��3��8��4��4��4��2��5��������1��6��������2��7��������3��
Wldh.AdvMatchLists	= {};		--32ǿ
Wldh.WaitMapMemList = Wldh.WaitMapMemList or {};		--�᳡�������


--���ݴ���
Wldh.RankFrameCount 	= 1000;							--ÿ֡����1000��ս�ӽ������ݴ���
Wldh.RankLeagueList 	= Wldh.RankLeagueList 	or {};	--ս�������,��֡�����������ʹ��
Wldh.RankLeagueId 		= Wldh.RankLeagueId		or {};	--ս�������¼,��֡�����������ʹ��
Wldh.ClsLeagueList 		= Wldh.ClsLeagueList	or {};	--ս�������,��֡�����������ʹ��
Wldh.ClsLeagueId 		= Wldh.ClsLeagueId		or 0;	--ս�������¼,��֡�����������ʹ��

--��ҩ��ʾ
Wldh.ForbidItem = 
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

--�����
--Wldh.FINAL_VS_LIST = {
--	[1] = {[32]=1,  [16]=1, [8]=1, [4]=1, [2]=1},
--	[2] = {[32]=2,  [16]=2, [8]=2, [4]=2, [2]=1},
--	[3] = {[32]=3,  [16]=3, [8]=3, [4]=2, [2]=1},
--	[4] = {[32]=4,  [16]=4, [8]=4, [4]=1, [2]=1},
--	[5] = {[32]=5,  [16]=5, [8]=4, [4]=1, [2]=1},
--	[6] = {[32]=6,  [16]=6, [8]=3, [4]=2, [2]=1},
--	[7] = {[32]=7,  [16]=7, [8]=2, [4]=2, [2]=1},
--	[8] = {[32]=8,  [16]=8, [8]=1, [4]=1, [2]=1},
--	[9] = {[32]=9,  [16]=8, [8]=1, [4]=1, [2]=1},
--	[10]= {[32]=10, [16]=7, [8]=2, [4]=2, [2]=1},
--	[11]= {[32]=11, [16]=6, [8]=3, [4]=2, [2]=1},
--	[12]= {[32]=12, [16]=5, [8]=4, [4]=1, [2]=1},
--	[13]= {[32]=13, [16]=4, [8]=4, [4]=1, [2]=1},
--	[14]= {[32]=14, [16]=3, [8]=3, [4]=2, [2]=1},
--	[15]= {[32]=15, [16]=2, [8]=2, [4]=2, [2]=1},
--	[16]= {[32]=16, [16]=1, [8]=1, [4]=1, [2]=1},
--	[17]= {[32]=16, [16]=1, [8]=1, [4]=1, [2]=1},
--	[18]= {[32]=15, [16]=2, [8]=2, [4]=2, [2]=1},
--	[19]= {[32]=14, [16]=3, [8]=3, [4]=2, [2]=1},
--	[20]= {[32]=13, [16]=4, [8]=4, [4]=1, [2]=1},
--	[21]= {[32]=12, [16]=5, [8]=4, [4]=1, [2]=1},
--	[22]= {[32]=11, [16]=6, [8]=3, [4]=2, [2]=1},
--	[23]= {[32]=10, [16]=7, [8]=2, [4]=2, [2]=1},
--	[24]= {[32]=9,  [16]=8, [8]=1, [4]=1, [2]=1},
--	[25]= {[32]=8,  [16]=8, [8]=1, [4]=1, [2]=1},
--	[26]= {[32]=7,  [16]=7, [8]=2, [4]=2, [2]=1},
--	[27]= {[32]=6,  [16]=6, [8]=3, [4]=2, [2]=1},
--	[28]= {[32]=5,  [16]=5, [8]=4, [4]=1, [2]=1},
--	[29]= {[32]=4,  [16]=4, [8]=4, [4]=1, [2]=1},
--	[30]= {[32]=3,  [16]=3, [8]=3, [4]=2, [2]=1},
--	[31]= {[32]=2,  [16]=2, [8]=2, [4]=2, [2]=1},
--	[32]= {[32]=1,  [16]=1, [8]=1, [4]=1, [2]=1},
--}

--�ű����ɶ����
function Wldh:CreateVsList()
	Wldh.FINAL_VS_LIST ={};
	for nId, nCurState in ipairs(Wldh.MACTH_STATE_ADV_TASK) do
		if nCurState < 4 then
			break;
		end
		if nId == 1 then
			for nTRank=1, nCurState/2 do
				Wldh.FINAL_VS_LIST[nTRank] = Wldh.FINAL_VS_LIST[nTRank] or {}
				Wldh.FINAL_VS_LIST[nCurState-nTRank+1] = Wldh.FINAL_VS_LIST[nCurState-nTRank+1] or {}
				Wldh.FINAL_VS_LIST[nTRank][nCurState] = nTRank;
				Wldh.FINAL_VS_LIST[nCurState-nTRank+1][nCurState] = nTRank;
			end		
		end
		
		local tbTemp = {};
		for nTRank=1, nCurState/4 do
			tbTemp[nTRank] = nTRank;
			tbTemp[nCurState/2 - nTRank + 1] = nTRank;
		end
		
		for nTRank=1, 32 do
			for i=1, nCurState/2 do
				if Wldh.FINAL_VS_LIST[nTRank][nCurState] == i then
					Wldh.FINAL_VS_LIST[nTRank][nCurState/2] = tbTemp[i];
				end
			end
		end
	end
end
Wldh:CreateVsList();

Wldh.SERIES_COLOR = {
	[Env.SERIES_METAL]		= "<color=orange>%s<color>",		-- ��ϵ
	[Env.SERIES_WOOD]		= "<color=green>%s<color>",			-- ľϵ
	[Env.SERIES_WATER]		= "<color=blue>%s<color>",			-- ˮϵ
	[Env.SERIES_FIRE]		= "<color=salmon>%s<color>",		-- ��ϵ
	[Env.SERIES_EARTH]		= "<color=wheat>%s<color>",			-- ��ϵ	
};
