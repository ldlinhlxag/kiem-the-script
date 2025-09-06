-------------------------------------------------------
-- �ļ�������qinshihuang_def.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-06-20 14:20:37
-- �ļ�������
-------------------------------------------------------

local tbQinshihuang = {};
Boss.Qinshihuang = tbQinshihuang;

tbQinshihuang.TASK_GROUP_ID = 2098;		-- ���������

tbQinshihuang.TASK_USE_TIME = 1;		-- ÿ�ջ���ʹ��ʱ��
tbQinshihuang.TASK_START_TIME = 2		-- ���һ�λ��꿪��ʱ��
tbQinshihuang.TASK_BUFF_LEVEL = 3;		-- ����buff�ȼ�
tbQinshihuang.TASK_BUFF_FRAME = 4;		-- ����buffʣ��ʱ��
tbQinshihuang.TASK_PROTECT = 5;			-- 崻�����
tbQinshihuang.TASK_SAVEDATE = 8;
tbQinshihuang.TASK_REFINE_ITEM = 10;		-- ÿ��ʹ������������Ʒ�ĸ���

tbQinshihuang.MAX_DAILY_TIME = 60 * 60 * 2;	-- ÿ��2Сʱ
tbQinshihuang.MAX_DAILY_REFINEITEM = 10;	-- ÿ��ʹ������������Ʒ�ĸ���

tbQinshihuang.SMALL_BOSS_POS_PATH = "\\setting\\boss\\qinshihuang\\smallboss_pos.txt";

tbQinshihuang.tbYemingzhu =				-- ҹ����������ʱ�������ñ���
{
	[1] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	[2] = {0, 0, 0, 0, 0, 0, 1, 1, 3, 5},
	[3] = {0, 0, 0, 0, 0, 1, 1, 3, 9, 15},
	[4] = {0, 0, 0, 1, 1, 1, 2, 6, 18, 30},
	[5] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
};

if not tbQinshihuang.tbBoss then	
	tbQinshihuang.tbBoss = {};			-- {{nTempId, nStep, nDeathCount}}
end

if not tbQinshihuang.tbPlayerList then
	tbQinshihuang.tbPlayerList = {}; 	-- {{PlayerId, {MapLevel, StartTime}}}
end

tbQinshihuang._bOpen = 1;				-- ϵͳ����
tbQinshihuang.bOpenQinFive = 0;			-- ����㿪��