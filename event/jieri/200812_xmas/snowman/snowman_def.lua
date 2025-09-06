-- �ļ�������snowman_def.lua
-- �����ߡ���zounan
-- ����ʱ�䣺2009-11-24 14:32:42
-- ��  ��  ��

SpecialEvent.Xmas2008 = SpecialEvent.Xmas2008 or {};
SpecialEvent.Xmas2008.XmasSnowman = SpecialEvent.Xmas2008.XmasSnowman or {};
local XmasSnowman = SpecialEvent.Xmas2008.XmasSnowman;

--�������
XmasSnowman.TSKG_GROUP 		   = 2027;
XmasSnowman.TSK_AWARD_COUNT    = 99;              
XmasSnowman.TSK_AWARD_DATE	   = 100;

--��������и���
XmasSnowman.TSK_AWARD_FUDAI    = 98;       
  

XmasSnowman.AWARD_LEVEL_LIMIT  = 60;           -- �ȼ�����
XmasSnowman.AWARD_JINGHUO_LIMIT = 60;          -- ��������
XmasSnowman.AWARD_COUNT		   = 5;            --һ����ȡ��������
XmasSnowman.FUDAI_ID           = {18,1,80,1};  --����ID

XmasSnowman.EVENT_START 	   = 20091222;     -- ���ʼ����
XmasSnowman.EVENT_END		   = 20100104;	   -- ���������

XmasSnowman.MAXMAN_END		   = 20100119;	   -- ˢ��ѩ�˽�������

XmasSnowman.REFRESH_TIME       = 2400;		   -- �ˢ��ʱ��

--ѩ�� ��ͬ�ȼ���ͬ���
XmasSnowman.SNOWMAN_LEVEL 	  = {[1] ={nClassId = 3710, nCount = 1500},
								 [2] ={nClassId = 3711, nCount = 2000},
								 [3] ={nClassId = 3712, nCount = 2500},
								 [4] ={nClassId = 3713, nCount = 3000},
								 [5] ={nClassId = 3714, nCount = 0},
								};
XmasSnowman.SNOWMAN_DISTANCE   = 40;          -- ѩ�˵���Ч����
XmasSnowman.SNOWMAN_SKILL 	   = 1490;        -- ѩ�˳ɳ�����ID

XmasSnowman.SNOWBALL_ID        = 3716;        -- ѩ�ѵ�ID
XmasSnowman.SNOWBALL_INTERVAL  = 3; 	      -- ѩ����ʧ��3��ļ�ʱ�� ����

XmasSnowman.SNOWBALL_CATCHTIME = 1;     	  -- �ɼ�ѩƬ��ʱ��
XmasSnowman.SNOWFLAKE_ID 	   = {18,1,535,1};  -- СѩƬ��ID
XmasSnowman.SNOWFLAKE_TIMEOUT  = 3;			  -- СѩƬ��ʱ��

XmasSnowman.CHEST_ID 		   = 3717;        -- ����ID 
XmasSnowman.CHEST_START 	   = 2100;		  -- ˢ�������ʱ��
XmasSnowman.CHEST_CATCHTIME    = 2;           -- �ɼ������ʱ��
XmasSnowman.CHEST_INTERVAL     = 3;           -- ˢ�±����ʱ��
XmasSnowman.CHEST_COUNT        = 5;           -- ˢ�±���Ĵ���
XmasSnowman.CHEST_LIVETIME     = 1;           -- ˢ�±����ʱ��
XmasSnowman.CHEST_NUMBER       = {60,80,100}; -- һ��ˢ�±���ĸ���


XmasSnowman.YANHUA_SKILLID 	   = {1327};      -- �̻�����ID
XmasSnowman.YANHUA_INTERVAL    = 5;		      -- �ͷż��ܵļ��
XmasSnowman.YANHUA_COUNT       = 15;		  -- �̻�����1����

XmasSnowman.EXP_NPC            = 3715;        -- ���Ӿ����NPC
XmasSnowman.EXP_INTERVAL       = 6;           -- ÿ6���һ�ξ���
XmasSnowman.EXP_TIME 		   = 3 * 60;      -- ����ʱ��
XmasSnowman.EXP_RATE           = 1400;        -- ���鱶�� 
XmasSnowman.EXP_ROUND          = 90;          -- ���Ӿ��鷶Χ

XmasSnowman.XUETUAN_DISTANCE   =  10;         -- ѩ�ŵ���Ч����

XmasSnowman.BOX_ID 			   = {18,1,536,1};
						
						  
--�ڴ����						  
XmasSnowman.tbSnowmanMgr  = XmasSnowman.tbSnowmanMgr  or {};    -- ѩ�˹���
XmasSnowman.tbSnowballMgr = XmasSnowman.tbSnowballMgr or {};	-- ѩ�����			
XmasSnowman.tbChestMgr    = XmasSnowman.tbChestMgr    or {};    -- �������

--������ �ļ���ȡ
XmasSnowman.SNOWMAN_POS  = XmasSnowman.SNOWMAN_POS or {};	
XmasSnowman.CHEST_POS    = XmasSnowman.CHEST_POS   or {};	
XmasSnowman.SNOWBALL_POS = XmasSnowman.SNOWBALL_POS or {};
XmasSnowman.SNOWSEED_POS = XmasSnowman.SNOWSEED_POS or {};

XmasSnowman.nState        = 0;     -- ��׶�
XmasSnowman.nChestCount   = 0;     -- ��ˢ����Ĵ���
XmasSnowman.nYanhuaCount  = 0;     -- �̻�����
							
							