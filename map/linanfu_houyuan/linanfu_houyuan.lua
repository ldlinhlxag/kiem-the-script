-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(484); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ������긮ۡ---1��---------------
local tbTestTrap	= tbTest:GetTrapClass("to_pengfu")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(483,1527,3126)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

-------------- ����Χ����---2��---------------
local tbTestTrap2	= tbTest:GetTrapClass("trappeng1")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	me.NewWorld(484,1767,3926)	-- ����,[��ͼId,����X,����Y]
	TaskAct:Talk("���ڲ����й��ʱ�򣬻�����ȥ�����°ɡ�");	
	me.SetFightState(1)
end;

-------------- ����Χ����---3��---------------
local tbTestTrap3	= tbTest:GetTrapClass("trappeng3")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()	
	me.NewWorld(484,1727,3031)	-- ����,[��ͼId,����X,����Y]	
	TaskAct:Talk("���ڲ����й��ʱ�򣬻�����ȥ�����°ɡ�");	
	me.SetFightState(1)
end;

-------------- ����Χ����---4��---------------
local tbTestTrap4	= tbTest:GetTrapClass("trappeng4")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()	
	me.NewWorld(483,1700,4103)	-- ����,[��ͼId,����X,����Y]	
	TaskAct:Talk("���ڲ����й��ʱ�򣬻�����ȥ�����°ɡ�");	
	me.SetFightState(1)
end;