-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(166); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪�����޷��䡿---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit13")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(29,1581,3818)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;


-------------- ���뿪�����С�---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit14")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	me.NewWorld(29,1415,3964)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;


-------------- ���뿪С�����䡿---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit15")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()	
	me.NewWorld(29,1430,3964)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

-------------- ���뿪�շŷ��䡿---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit16")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()	
	me.NewWorld(29,1640,3868)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;


-------------- ���뿪̫�󷿼䡿---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit9")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()	
	me.NewWorld(29,1447,3896)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;


-------------- ���뿪��---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_exit10")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	me.NewWorld(29,1491,3761)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;



-------------- ���뿪�Դ����䡿---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_exit7")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()	
	me.NewWorld(29,1491,3761)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

-------------- ���뿪���Ϸ���-������---------------
local tbTestTrap8	= tbTest:GetTrapClass("to_exit8")

-- �������Trap�¼�
function tbTestTrap8:OnPlayer()	
	me.NewWorld(29,1491,3761)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

-------------- ���뿪���Ϸ��䡿---------------
local tbTestTrap9	= tbTest:GetTrapClass("to_exit11")

-- �������Trap�¼�
function tbTestTrap9:OnPlayer()	
	me.NewWorld(29,1491,3761)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

-------------- ���뿪���ϡ�---------------
local tbTestTrap10	= tbTest:GetTrapClass("to_exit12")

-- �������Trap�¼�
function tbTestTrap10:OnPlayer()	
	me.NewWorld(29,1491,3761)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;
