-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(128); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����չ⡿---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_wanyanguang")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(812,1607,3208)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)	
end;

-------------- ���¼�����---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_chenjichang")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	me.NewWorld(813,1617,3218)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)	
end;