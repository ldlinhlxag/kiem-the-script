-- �ļ�������stats_def.lua
-- �����ߡ���furuilei
-- ����ʱ�䣺2009-05-21 20:16:58

if (MODULE_GAMECLIENT) then
	return;
end

--========================================================
Stats.TASK_GROUP = 2094;
Stats.TASK_ID_STATS_KEY	= 1;			-- ͳ�ƵĿ���
Stats.TASK_ID_UNLOGINTIME = 2;			-- ���û�����ߵ��������
Stats.TASK_ID_LASTGETREPUTETIME = 3;	-- ������һ�λ��������ʱ��
Stats.TASK_ID_UNGETREPUTETIME = 4;		-- �������û�л���������������
Stats.TASK_ID_PLAYERTYPE = 5;			-- ��¼������ࣨ0�������ͳ���ڼ�û�����ߣ�1��û�дﵽ��ȡ�����ı�׼��2���ﵽ��׼����û����ȡ���3���ﵽ��׼������ȡ�˾��
Stats.TASK_ID_LASTGETFULITIME = 6;		-- ����ϴ���ȡ���������ʱ��
Stats.TASK_ID_UNUSEFULITIME = 7;		-- �ﵽ��׼����û����ȡ����������������
Stats.TASK_ID_TODAYONLINETIME = 8;		-- ��ҵ����������ʱ��
Stats.TASK_ID_BELOWHALFTIME = 9;		-- һ��������ʱ�䲻��ƽ������ʱ��һ����������
Stats.TASK_ID_CURBELOWHALFTIME = 10		-- ��ҵ�ǰ����������ƽ��ʱ��һ�������
Stats.TASK_ID_BELOW4HOURSTIME = 11;		-- һ��������ʱ�䲻��4Сʱ���������
Stats.TASK_ID_CURBELOW4HOURSTIME = 12;	-- ��ҵ�ǰ����������4Сʱ������

-- ע�⣺�Ժ�����Ӻ�Ǳ����ʧͳ����ص��������ʱ��ÿ����һ��������Ӧ��Ҫ������������ı�ʾ�����������
Stats.COUNT_TASK_ID	= 12;	
--========================================================			

-- ��ʾ��ҵ�½ʱ����������
Stats.TASK_GROUP_LOGIN = 2063;
Stats.TASK_ID_LOGINTIME = 2;

-- ��ʾ���߻�������ʱ��ִ�еı�־
Stats.LOGINEXE = 1;
Stats.LOGOUTEXE = 2;

Stats.ONLINETIME = 4 * 3600;		-- 4Сʱ������ʱ��
Stats.ONEDAYTIME = 24 * 3600;		-- һ���ʱ��

Stats.PLAYER_STATE_NEVERLOGIN = 0;		-- ��ʾ���û���Ϲ���
Stats.PLAYER_STATE_TODAY_NOTADD = 1;	-- ��ʾ��ҵ���û�н��й���1�Ĳ����ı�ʶ
Stats.PLAYER_STATE_TODAY_ADD = 2;		-- ��ʾ��ҵ����н��й���1�����ı�ʶ



--========================================================
-- ��ɫ�μӻ�ܴ�����ͳ��
Stats.TASK_COUNT_ACTIVITY_KEY = 50;	-- ��ɫ�����ܴ���ͳ�ƵĿ���

Stats.TASK_COUNT_XIULIANZHU	= 51;	-- ���ʹ��������ļ���
Stats.TASK_COUNT_BAIHUTANG = 52;	-- ��ҲμӰ׻��õļ���
Stats.TASK_COUNT_BATTLE	= 53;		-- ��Ҳμ��ν�Ĵ���
Stats.TASK_COUNT_YIJUN	= 54;		-- ��Ҳμ��Ծ�����Ĵ���
Stats.TASK_COUNT_KINGAME = 55;		-- ��ҲμӼ��帱���Ĵ���
Stats.TASK_COUNT_FACTION = 56;		-- ��Ҳμ����ɾ����Ĵ���
Stats.TASK_COUNT_CANGBAOTU = 57;	-- ����ڱ��Ĵ���
Stats.TASK_COUNT_SHANGHUI = 58;		-- �������̻�����Ĵ���
Stats.TASK_COUNT_WANTED = 59;		-- ��Ҳμӹٸ�ͨ������Ĵ���
Stats.TASK_COUNT_ARMYCAMP = 60;		-- ��ҲμӾ�Ӫ�����Ĵ���
Stats.TASK_COUNT_GUESS = 61;		-- ��Ҳμӻ��Ʋ��յĴ���
Stats.TASK_COUNT_XOYOGAME = 62;		-- ��Ҳμ���ң�ȴ��صĴ���
Stats.TASK_COUNT_WLLS = 63;			-- ��Ҳμ����������Ĵ���
Stats.TASK_COUNT_QINSHIHUANG = 64;	-- ��ҽ�����ʼ����ļ�������ȥ����������
Stats.TASK_COUNT_DOMAIN = 65;		-- ��Ҳμ���������Ĵ���
Stats.TASK_COUNT_FULIJINGHUO = 66;	-- �����ȡ��������ļ�����������
Stats.TASK_COUNT_COINEX = 67;		-- ��Ұ����������Ĵ���
Stats.TASK_COUNT_SALARY = 68;		-- �����ȡ���ʵļ���
Stats.TASK_COUNT_WEEKLYTASK = 69;	-- �����ȡ��������Ŀ�꽱���Ĵ���

Stats.TASK_ACTIVITY_COUNT = 19;		-- ��ʾĿǰ��Ҫͳ�ƵĻ��Ŀ
