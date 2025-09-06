-------------------------------------------------------------------
--File: 	factionbattle_def.lua
--Author: 	zhengyuhua
--Date: 	2008-1-8 17:38
--Describe:	门派战定义
-------------------------------------------------------------------

if not FactionBattle then --调试需要
	FactionBattle = {};
	print(GetLocalDate("%Y\\%m\\%d  %H:%M:%S").." build ok ..");
end

local preEnv = _G;	--保存旧的环境
setfenv(1, FactionBattle);	--设置当前环境为FactionBattle

SETTING_PATH 	= "\\setting\\factionbattle\\";
ARENA_RANGE		= "arena_range.txt";
ARENA_POINT		= "arena_point.txt";
BOX_POINT		= "box_point.txt";
	
MAX_ATTEND_PLAYER			= 400; 		-- 最大参赛人数
MIN_ATTEND_PLAYER			= 2;		-- 最小参加人数 		
MIN_RESTART_MELEE			= 8;		-- 最少分场人数	
PLAYER_PER_ARENA			= 50;		-- 每个混战场所容纳的最大人数
MAX_ARENA					= 8;		-- 最大混战场个数
MELEE_PROTECT_TIME			= 15;		-- 混战前保护时间 15秒
MELEE_RESTART_PROTECT		= 10;		-- 混战重分场地后保护时间 10秒
ELIMI_PROTECT_TIME			= 30;		-- 淘汰赛保护时间 30秒
END_DELAY					= 5;		-- 战区剩余唯一一人时要传出的传送延迟
ADD_BOX_DELAY				= 5; 		-- 决出胜负后宝箱刷出延迟时间
ADDEXP_SECOND_PRE_TIME		= 30;		-- 每次+经验间隔时间 30秒
ADDEXP_QUEUE_NUM			= 10;		-- +经验队列数
RATIO						= 1;		-- +经验为基准经验的倍数
TAKE_BOX_TIME				= 5;		-- 拾取奖励箱子的时间
REST_ACTITIVE_TIME			= 7*60;		-- 每次休息活动的时间 7分钟	
FLAG_NPC_TAMPLATE_ID		= 2702;		-- 冠军旗子NPC模板ID
FLAG_X						= 1575;		-- 冠军旗子坐标
FLAG_Y						= 3375;		-- 冠军旗子坐标
FLAG_EXIST_TIME				= 10*60;		-- 冠军旗子生存期			
ANOUNCE_TIME				= 6*60;		-- 经过多久提示剩余时间		
YANHUA_SKILL_ID				= 391;		-- 烟花的技能ID
AWARD_ITEM_ID				= {1,78,1};	-- 箱子道具ID
GOUHUO_NPC_ID				= 2728;		-- 多人篝火ID
GOUHUO_EXISTENTIME 			= 600; 		-- 篝火持续时间
GOUHUO_BASEMULTIP			= 400; 		-- 篝火获得经验倍率百分比
TITLE_GROUP					= 4;		-- 冠军称号组
TITLE_ID					= 1;		-- 称号ID
MIN_LEVEL					= 50;		-- 参加等级下限
--MAX_LEVEL					= 100; 		-- 参加等级上限

TASK_GROUP_ID				= 2016		-- 任务变量组ID
DEGREE_TASK_ID				= 1;		-- 届任务ID
SCORE_TASK_ID				= 2;		-- 旗子积分 ID
TASK_USED_LINGPAI			= 3;		-- 当天使用个数任务变量
TASK_LINGPAI_DATE 			= 4;		-- 记录使用的日期任务变量
ELIMINATION_TASK_ID			= 5;		-- 记录各玩家进入了几强的任务ID（换积分用）

HONOR_CLASS					= 2;		-- 荣誉大类
HONOR_WULIN_TYPE			= 0;		-- 武林荣誉小类

NOTHING					= 0;		-- 活动未启动
SIGN_UP					= 1;  		-- 报名阶段
MELEE					= 2;		-- 混战阶段
READY_ELIMINATION		= 3;		-- 淘汰准备阶段
ELIMINATION				= 4;		-- 淘汰赛阶段
CHAMPION_AWARD			= 5;		-- 冠军颁奖
END						= 6;		-- 结束

-- 开启在周2，4
OPEN_WEEK_DATE = {2,5};

-- 自由PK重新投入战斗时间表
RETURN_TO_MELEE_TIME = 
{	-- 死亡次数			等待时间
		[1] = 			10,
		[2] = 			20,
		[3] = 			40,
		[4] = 			60,
}

-- 注意：奖励会叠加，各个奖励是上个奖励之后再加上去的
AWARD_TABLE = 
{--		心得		威望		门派声望	额外奖励（X分钟经验、X个箱子）  股份基数	荣誉
	{	200000,		0,			160,		0,			0,					0,			0	},	-- 无杀人奖励
	{	100000,		0,			80,			0,			0,					0,			0	},	-- 有杀人奖励
	{	100000,		6,			110,		90,			1,					100,			40	},	-- 晋级16强奖励
	{	200000,		6,			50,			120,		2,					100,			10	},	-- 16进8奖励
	{	200000,		10,			100,		180,		4,					300,			10	},	-- 8进4奖励
	{	0,			0,			0,			180,		4,					0,			20	},	-- 4进2奖励
	{	200000,		10,			100,		240,		8,					500,			20	},	-- 2进1奖励
	{	0,			0,			0,			0,			0,					0,			0	},	-- 冠军奖励
}	

-- 混战阶段荣誉、威望
MELEE_HONOR = 
{
	--比率	-- 荣誉	-- 威望
	{0.1,	50,		0,		50},
	{0.3,	40,		0,		40},
	{0.7,	30,		0,		30},
	{0.9,	20,		0,		20},
	{1,		10,		0,		10},
}

-- 刷不同箱子的人数段
PLAYER_COUNT_LIMIT	= 
{
	[1]	= 16, [2] = 50, [3] = 100, [4] = 150, [5] = 100000 --(无限大,假如因为人数>10W人而造成BUG，我们该庆祝了)
}

-- 淘汰赛刷箱子数量表
BOX_NUM =
{--	 比赛各强	散落宝箱数(2)	(3)		(4)		(5)
	{16, 			1,			2,		3,		4};			-- 16进8奖励
	{8, 			2,			4,		6,		8};			-- 8进4奖励
	{4,				4, 			8,		12,		16};		-- 4进2奖励
	{2,				8, 			16,		24,		30};		-- 2进1奖励
	{1,				8, 			16,		24,		30};		-- 冠军奖励
}

-- 对阵表
ELIMI_VS_TABLE =
{
	{1, 16},
	{8,	9},
	{4,	13},
	{5,	12},
	{2,	15},
	{7,	10},
	{3,	14},
	{6,	11},
}

-- 门派竞技地图对应表
FACTION_TO_MAP =
{
	[1] 	= 241,
	[2] 	= 242,
	[3] 	= 243,
	[4] 	= 244,
	[5] 	= 245,
	[6] 	= 246,
	[7] 	= 247,
	[8] 	= 248,
	[9] 	= 249,
	[10] 	= 250,
	[11] 	= 251,
	[12] 	= 252
};

-- 进入点与重生点
REV_POINT = 
{
	{1470, 3426},
	{1517, 3377},
	{1542, 3492},
	{1590, 3442}
};

STATE_TRANS	=
{
--	 状态 					定时时间				时间到回调函数(函数返回0表示不在继续定时，结束活动)
	{SIGN_UP, 				30 * 60, 				"StartMelee"		},		-- 报名定时
	{MELEE,					5 * 60,					"RestartMelee"		},		-- 混战定时
	{MELEE,					5 * 60,					"RestartMelee"		},		-- 混战定时
	{MELEE,					5 * 60,					"RestartMelee"		},		-- 混战定时
--	{MELEE,					6 * 60,					"RestartMelee"		},		-- 混战定时
	{MELEE,					5 * 60,					"EndMelee"			},		
	{READY_ELIMINATION,		3 * 60,					"StartElimination"	}, 		-- 淘汰赛准备
	{ELIMINATION,			7 * 60,					"EndElimination"	}, 		-- 淘汰赛1阶	决出8强
	{READY_ELIMINATION,		7 * 60,					"StartElimination"	}, 		-- 淘汰赛准备
	{ELIMINATION,			7 * 60,					"EndElimination"	}, 		-- 淘汰赛2阶	决出4强
	{READY_ELIMINATION,		7 * 60,					"StartElimination"	}, 		-- 淘汰赛准备
	{ELIMINATION,			7 * 60,					"EndElimination"	}, 		-- 淘汰赛3阶	决出2强
	{READY_ELIMINATION,		7 * 60,					"StartElimination"	}, 		-- 淘汰赛准备
	{ELIMINATION,			7 * 60,					"EndElimination"	}, 		-- 淘汰赛4阶	冠军
	{CHAMPION_AWARD,		10 * 60,				"EndChampionAward"	}, 		-- 冠军奖励
	{END}
};

preEnv.setfenv(1, preEnv);	--恢复全局环境
