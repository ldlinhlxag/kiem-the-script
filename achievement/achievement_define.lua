-- �ļ�������achievement_define.lua
-- �����ߡ���furuilei
-- ����ʱ�䣺2009-10-21 15:45:42
-- �����������ɾ�ϵͳ����Ҫ�ĺ궨��

Achievement.TASKGROUP	= 2107;		-- �ɾ͵�������

-- �����ʱ�䶨��Ҫ��"\\setting\\achievement\\achievement.txt"�ļ��е��¼���˳����ȫһ�£����Ҳ�Ҫ���׸Ķ�
Achievement.JXCIDIAN				= 1;	-- ��ȫ�ش�һ�����͵Ľ����ʵ�����
Achievement.LIFISKILL_20			= 2;	-- �κ�һ������ܴﵽ20��
Achievement.YIJUN					= 3;	-- ���һ���Ծ�����
Achievement.CANGBAOTU_CHUJI			= 4;	-- �ɹ��ھ�һ�γ����ر�ͼ
Achievement.MAINTASK_50				= 5;	-- ���50�����߾���
Achievement.LIFISKILL_30			= 6;	-- ����ܴﵽ30��
Achievement.DENGMI					= 7;	-- ��һ�ε��ջ�лش��������е�����
Achievement.FUBEN_BAINIANTIANLAO	= 8;	-- �ɹ�ͨ���ر�ͼ�������� - ��������
Achievement.MAINTASK_59				= 9;	-- ���59�����߾���
Achievement.QIFU					= 10;	-- ������һ��
Achievement.ENTER_KIN				= 11;	-- �ɹ��������
Achievement.CANGBAOTU_ZHONGJI		= 12;	-- �ɹ��ھ�һ���м��ر�ͼ
Achievement.FUBEN_TAOZHUGONG		= 13;	-- �ɹ�ͨ���ر�ͼ�м����� - ���칫
Achievement.TONGJI_55				= 14;	-- �ɹ����һ��55���ٸ�ͨ������
Achievement.BAIHUTANG_CHUJI			= 15;	-- ̽��һ�γ����׻���
Achievement.XINDESHU				= 16;	-- ����һ���ĵ���
Achievement.MAINTASK_69				= 17;	-- ���69����������
Achievement.BATTLE_YANGZHOU			= 18;	-- �μ�һ�γ����ν𡪡�����
Achievement.FACTION					= 19;	-- �μ�һ�����ɾ���
Achievement.TONGJI_65				= 20;	-- ���һ��65���ٸ�ͨ������
Achievement.FUBEN_DAMOGUCHENG		= 21;	-- �ɹ�ͨ���ر�ͼ�Թ��м�����������Į�ų�
Achievement.MAINTASK_79				= 22;	-- ���79����������
Achievement.TONGJI_75				= 23;	-- ���75���ٸ�ͨ������
Achievement.MAINTASK_89				= 24;	-- ���89����������
Achievement.CANGBAOTU_GAOJI			= 25;	-- �ɹ��ھ�һ�θ߼��ر�ͼ
Achievement.XOYOGAME				= 26;	-- �μ�һ����ң�Ȼ
Achievement.DOMAINBATTLE			= 27;	-- �μ�һ����������ս
Achievement.TONGJI_85				= 28;	-- ���һ��85��ͨ������
Achievement.ARMYCAMP				= 29;	-- ���һ�ξ�Ӫ����
Achievement.TONGJI_95				= 30;	-- ���һ��95���ٸ�ͨ������
Achievement.XOYOGAME_PASS			= 31;	-- �ɹ�����ң�ȴ���ͨ��5��
Achievement.FUBEN_QIANQIONG			= 32;	-- �ɹ�ͨ���߼�����-ǧ��
Achievement.FUBEN_WANHUA			= 33;	-- �ɹ�ͨ���߼�����-�򻨹�
Achievement.BAIHUTANG_GAOJI			= 34;	-- �ɹ�ͨ���߼��׻���һ��
Achievement.QINSHIHUANG_5			= 35;	-- �ɹ�������ʼ����5��
Achievement.SHANGHUI_40				= 36;	-- �ɹ����һ��40�ε��̻�����
Achievement.BATTLE_GAOJI_20			= 37;	-- �ڸ߼��ν�ս����ȡ��ǰ20��
Achievement.COUNT 					= 38;	-- �¼�������


--=================================================================
-- �ɾ�ϵͳ��Ҫ�õ��������������壨ÿ�������Ӧ���ݷֱ����������id����id��
Achievement.tbMainTaskId = {
	[Achievement.MAINTASK_50] = {{4, 38}, {5, 51}, {12, 95}, {9, 74}},
	[Achievement.MAINTASK_59] = {{15, 110}},
	[Achievement.MAINTASK_69] = {{18, 127}},
	[Achievement.MAINTASK_79] = {{21, 150}},
	[Achievement.MAINTASK_89] = {{24, 172}},
	[Achievement.ARMYCAMP]	  = {{225, 400}},
	[Achievement.XINDESHU]	  = {{161, 144}, {162, 145}, {163, 146}},
	};
