-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(486); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����丮ۡ---1��---------------
local tbTestTrap	= tbTest:GetTrapClass("to_zhuxifu")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(487,1554,3119)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

-------------- �������޸�ۡ---1��---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_zhaoruyu")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(485,1555,3119)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

-------------- ����Χ����---2��---------------
local tbTestTrap2	= tbTest:GetTrapClass("huifu1trap")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	me.NewWorld(486,1616,3829)	-- ����,[��ͼId,����X,����Y]
	TaskAct:Talk("���ڲ����й��ʱ�򣬻�����ȥ�����°ɡ�");	
	me.SetFightState(1)
end;

-------------- ����Χ����---3��---------------
local tbTestTrap3	= tbTest:GetTrapClass("huifu2trap")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()	
	me.NewWorld(486,1577,3875)	-- ����,[��ͼId,����X,����Y]	
	TaskAct:Talk("���ڲ����й��ʱ�򣬻�����ȥ�����°ɡ�");	
	me.SetFightState(1)
end;

-------------- ����Χ����---4��---------------
local tbTestTrap4	= tbTest:GetTrapClass("huifu3trap")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()	
	me.NewWorld(486,1527,3824)	-- ����,[��ͼId,����X,����Y]	
	TaskAct:Talk("���ڲ����й��ʱ�򣬻�����ȥ�����°ɡ�");	
	me.SetFightState(1)
end;

-------------- ����Χ����---5��---------------
local tbTestTrap5	= tbTest:GetTrapClass("huifu4trap")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()	
	me.NewWorld(486,1509,3940)	-- ����,[��ͼId,����X,����Y]	
	TaskAct:Talk("���ڲ����й��ʱ�򣬻�����ȥ�����°ɡ�");	
	me.SetFightState(1)
end;

-------------- ����Χ����---6��---------------
local tbTestTrap6	= tbTest:GetTrapClass("huifu5trap")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	me.NewWorld(486,1526,3964)	-- ����,[��ͼId,����X,����Y]	
	TaskAct:Talk("���ڲ����й��ʱ�򣬻�����ȥ�����°ɡ�");	
	me.SetFightState(1)
end;