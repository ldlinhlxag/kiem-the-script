-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(209); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ��ǰ����ĸ��--29�š�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_guimuhoudong")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(209,1861,3954)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ���뿪��ĸ��--29ȥ25�š�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit29")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(209,1886,3834)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;


-------------- ���뿪��ĸǰ��--25ȥ���⡿---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit25")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(91,1659,3658)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;
