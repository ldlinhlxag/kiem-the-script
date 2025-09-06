-------------------------------------------------------
-- �ļ�������wldh_battle_def.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-08-20 09:56:23
-- �ļ��������̳��޸��ν�����
-------------------------------------------------------

local tbBattle = Wldh.Battle or {};
Wldh.Battle = tbBattle;

-- ��ʱ�����
tbBattle.TIMER_SIGNUP		= Env.GAME_FPS * 60 * 10;	-- ����ʱ�䣨�ȴ�����ʱ�䣩
tbBattle.TIMER_SIGNUP_MSG	= Env.GAME_FPS * 60 * 5;	-- �����ڼ�Ĺ㲥��Ϣ
tbBattle.TIMER_GAME			= Env.GAME_FPS * 60 * 50;	-- ����ʱ�䣨�ȴ���������ʱ�䣩
tbBattle.TIMER_GAME_MSG		= Env.GAME_FPS * 20;		-- �����ڼ�Ĺ㲥��Ϣ
tbBattle.TIMER_SYNCDATA		= Env.GAME_FPS * 10;		-- �����ڼ��ͬ���ͻ�������
tbBattle.TIMER_ADD_BOUNS	= Env.GAME_FPS * 60;		-- ÿ���Ӽ�һ�λ���

tbBattle.TIME_DEATHWAIT		= 10;	-- ��������Ҫ�ں�Ӫ�ȴ�������
tbBattle.TIME_PLAYER_STAY 	= 120;	-- �ں�Ӫ���ɴ�120��
tbBattle.TIME_PALYER_LIVE 	= 60;	-- 60������ʱ�� 

tbBattle.CAMPID_SONG		= 1;	-- �η�ID;
tbBattle.CAMPID_JIN			= 2;	-- ��ID;

tbBattle.NAME_CAMP			= {"��", "��"};				-- ��Ӫ��
tbBattle.NPC_CAMP_MAP		= {1, 2};					-- �ν�˫����NPC��Ӫ����ɫ��

tbBattle.NPCID_WUPINBAOGUANYUAN		= 2599;				-- ������ID
tbBattle.NPCID_HOUYINGJUNYIGUAN		= 3705;				-- �����ID
tbBattle.NPCID_CHEFU				= 3700;				-- ����ID

-- ս������������ȫ�ֱ���4��
tbBattle.DBTASKID_PLAYER_COUNT	= 
{
	[1] = {DBTASK_WLDH_BATTLE_SONG1, DBTASK_WLDH_BATTLE_JIN1},
	[2] = {DBTASK_WLDH_BATTLE_SONG2, DBTASK_WLDH_BATTLE_JIN2},
	[3] = {DBTASK_WLDH_BATTLE_SONG3, DBTASK_WLDH_BATTLE_JIN3},
	[4] = {DBTASK_WLDH_BATTLE_SONG4, DBTASK_WLDH_BATTLE_JIN4},
	[5] = {DBTASK_WLDH_BATTLE_SONG5, DBTASK_WLDH_BATTLE_JIN5},
	[6] = {DBTASK_WLDH_BATTLE_SONG6, DBTASK_WLDH_BATTLE_JIN6},
};

-- �������
tbBattle.RESULT_WIN		= 1;		-- �η���ʤ
tbBattle.RESULT_TIE		= 0;		-- ƽ��
tbBattle.RESULT_LOSE	= -1;		-- �𷽻�ʤ

-- ��������
tbBattle.BTPLNUM_LOWBOUND	= 0;	-- ս����ս˫��������������
tbBattle.BTPLNUM_HIGHBOUND	= 150;	-- ˫����Ӫ�޶���ս�������

-- ���⼼�ܴ���
tbBattle.SKILL_DAMAGEDEFENCE_ID 	= 395;						-- ս�⼼��id
tbBattle.SKILL_DAMAGEDEFENCE_TIME	= Env.GAME_FPS * 60 * 3;	-- ս��ʱ��

-- �������
tbBattle.tbPOINT_TIMES_SHARETEAM 	= {1, 1, 1, 1, 1, 1};		-- 9����ͬ����������µĹ�����ֱ���

-- ������mapid
tbBattle.MAPID_SIGNUP = 
{
	[1] = 1623,
	[2] = 1624,
	[3] = 1625,
	[4] = 1626,
	[5] = 1627,
	[6] = 1628,
};

-- ������pos
tbBattle.POS_SIGNUP	= 
{
	[1] = {1671, 3281},
	[2] = {1672, 3305},
	[3] = {1688, 3306},
};

-- ������ͼid
tbBattle.MAPID_MATCH = 
{
	[1] = 1631,
	[2] = 1632,
	[3] = 1633,
	[4] = 1634,
	[5] = 1629,
	[6] = 1630,
}

-- ��ɫս����¼
tbBattle.TASK_GROUP_ID					= 2102;				-- �������GroupId
tbBattle.TASKID_CAMP					= 11;				-- ս����Ӫ
tbBattle.TASKID_PLAYER_KEY				= 12;				-- ս��key
tbBattle.TASKID_INDEX					= 13;				-- �Ŀ鳡��
tbBattle.TASKID_CAPTAIN					= 14;				-- �Ƿ��Ƕӳ�
tbBattle.TASKID_AWARD					= 15;				-- �Ƿ���ȡ��������
tbBattle.TASKID_SERVER					= 16;				-- �Ƿ���ȡ��������
tbBattle.TASKID_SERVER_DAY				= 17;				-- ����������ȡ����
				
-- ������Ϣ
tbBattle.tbBounsBase = 
{
	KILLPLAYER = 75,
	MAXSERIESKILL = 150,
};
	
-- ��ն����
tbBattle.SERIESKILLBOUNS = 150;
	
-- ���ȼ������������
tbBattle.RANKBOUNS = {0, -1, 1000, -1, 3000, -1, 6000, -1, 10000, -1};	

-- ��������
tbBattle.NAME_RANK = 
{
	"<color=white>ʿ��<color>", 
	"<color=white>��ʿ<color>",
	"<color=0xa0ff>Уξ<color>", 
	"<color=0xa0ff>��ξ<color>",
	"<color=yellow>ͳ��<color>",
	"<color=yellow>����<color>",
	"<color=0xff>����<color>",  
	"<color=0xff>ͳ��<color>",
	"<color=yellow><bclr=red>��<bclr><color>", 
	"<color=yellow><bclr=red>Ԫ˧<bclr><color>",
};

-- ������Ϣ
tbBattle.MSG_CAMP_RESULT = 
{
	[tbBattle.RESULT_WIN]	= "%s ������%s���������񣬴��ȫʤ��",
	[tbBattle.RESULT_TIE]	= "%s ������˫��δ��ʤ������������ս ��",
	[tbBattle.RESULT_LOSE]	= "%s ������%s����ս���У������ձ���",
};

-- ���ս��
tbBattle.tbLeagueName = 
{
	[101] = {"������",   1609},
	[102] = {"������",   1610},
	[103] = {"������",   1611},
	[104] = {"�����",   1612},
	[105] = {"�����",   1613},
	[107] = {"��Ȫ��",   1614},
	[108] = {"������",   1615},
	[110] = {"���Ϸ�",   1644},
	[112] = {"���ݵ�",   1645},
	[113] = {"������",   1646},
	[114] = {"佻�Ϫ",   1647},
	[116] = {"��ˮ��",   1648},
	[118] = {"�����",   1649},
	[201] = {"�����ӹ�", 1609},
	[202] = {"�㵴����", 1610},
	[203] = {"��ͥ����", 1611},
	[207] = {"����ŵ�", 1612},
	[209] = {"�����þ�", 1613},
	[210] = {"��������", 1614},
	[213] = {"ĺѩɽׯ", 1615},
	[215] = {"����ɽׯ", 1644},
	[301] = {"���Ź�",   1609},
	[302] = {"����ɽ",   1610},
	[304] = {"����Ԩ",   1611},
	[307] = {"����¥",   1612},
	[308] = {"��ʯ�",   1613},
	[312] = {"��ɽ��",   1614},
	[316] = {"������",   1615},
	[321] = {"������",   1644},
	[401] = {"��¶��",   1609},
	[403] = {"����ɽ",   1610},
	[404] = {"����ɽ",   1611},
	[405] = {"�����",   1612},
	[408] = {"�����",   1613},
	[409] = {"������",   1614},
	[410] = {"ժ��ƺ",   1615},
	[414] = {"������",   1644},
	[416] = {"��ԯ��",   1645},
	[420] = {"����Ϫ",   1646},
	[421] = {"���ع�",   1647},
	[422] = {"������",   1648},
	[426] = {"������",   1649},
	[501] = {"��ң��ջ", 1609},
	[504] = {"��÷����", 1610},
	[509] = {"��ɽ����", 1611},
	[511] = {"���ĺ���", 1612},
	[512] = {"�յ̴���", 1613},
	[514] = {"��̶�Ĺ�", 1614},
	[602] = {"��ϼ��",   1609},
	[603] = {"����̶",   1610},
	[605] = {"���Ź�",   1611},
	[606] = {"Ī�߿�",   1612},
	[611] = {"����̶",   1613},
	[616] = {"����Ϫ",   1614},
	[618] = {"���ɽ",   1615},
	[620] = {"��ɳɽ",   1644},
	[621] = {"������",   1645},
}

-- ����id
tbBattle.tbLGName_GateWay = {};
for nId, tbInfo in pairs(tbBattle.tbLeagueName) do
	tbBattle.tbLGName_GateWay[tbInfo[1]] = nId;
end

-- ս��id
tbBattle.tbLeagueId_Name = {};
for _, tbInfo in pairs(tbBattle.tbLeagueName) do
	local nLeagueId = tonumber(KLib.String2Id(tbInfo[1]));
	tbBattle.tbLeagueId_Name[nLeagueId] = tbInfo[1];
end

-- ������mapid
tbBattle.tbShiliangu = 
{
	[1] = 1616,
	[2] = 1617,
	[3] = 1618,
	[4] = 1619,
	[5] = 1620,
	[6] = 1621,
	[7] = 1622,
};

-- ʱ���
tbBattle.FINAL_TIME	= 20091102;
tbBattle.PRE_TIME =
{
	{20091010, 20091011},
	{20091017, 20091018},
	{20091024, 20091025},
}

-- ȫ�ֱ�����
tbBattle.GBTASK_BATTLE_GROUP = 1;
tbBattle.GBTASK_BATTLE_FINAL = 
{
	[1] = 11,
	[2] = 12,
	[3] = 13,
	[4] = 14,
};

-- ���μ�24��
tbBattle.MAX_MATCH = 6;

-- �����б�
tbBattle.tbAward = 
{
	[1] = { 
		Captain = { Item = {18, 1, 487, 1}, Num = 48, nNeedBag = 1, Title = {11, 5, 1, 0}},
		Member = { Item = {18, 1, 488, 1}, Num = 5, nNeedBag = 5, Title = {11, 5, 5, 0}},	
	},
	[2] = { 
		Captain = { Item = {18, 1, 487, 1}, Num = 16, nNeedBag = 1, Title = {11, 5, 2, 0}},
		Member = { Item = {18, 1, 488, 1}, Num = 3, nNeedBag = 3, Title = {11, 5, 6, 0}},
	},
	[3] = { 
		Captain = { Item = {18, 1, 487, 1}, Num = 8, nNeedBag = 1, Title = {11, 5, 3, 0}},
		Member = { Item = {18, 1, 488, 1}, Num = 2, nNeedBag = 2, Title = {11, 5, 7, 0}},
	},
	[4] = { 
		Captain = { Item = {18, 1, 487, 1}, Num = 8, nNeedBag = 1, Title = {11, 5, 4, 0}},
		Member = { Item = {18, 1, 488, 1}, Num = 2, nNeedBag = 2, Title = {11, 5, 8, 0}},
	},
	Normal = {
		Captain = { Item = {18, 1, 488, 1}, Num = 5, nNeedBag = 5},
		Member = { Item = {18, 1, 488, 1}, Num = 1, nNeedBag = 1},
	},
};

tbBattle.tbServerAward = 
{
	[1] = { Fudai = 2, Xiulian = 0.5, Xingyun = 3, Exp = 8, Level = 7, Day = 20 },
	[2] = { Fudai = 1, Xiulian = 0.5, Xingyun = 1, Exp = 7, Level = 6, Day = 20 },
	[3] = { Fudai = 1, Xiulian = 0.5, Xingyun = 1, Exp = 7, Level = 6, Day = 10 },
	[4] = { Fudai = 1, Xiulian = 0.5, Xingyun = 1, Exp = 7, Level = 6, Day = 10 },
	Normal = { Fudai = 1, Xiulian = 0, Xingyun = 1, Exp = 7, Level = 0, Day = 5 },
};

function tbBattle:CheckTime()
	
	if Wldh.IS_OPEN == 0 then
		return 0;
	end

	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	
	for _, tbTime in pairs(self.PRE_TIME) do
		if nNowDate >= tbTime[1] and nNowDate <= tbTime[2] then
			return 1;
		end
	end
	
	if nNowDate == self.FINAL_TIME then
		return 2;
	end

	return 0;
end
