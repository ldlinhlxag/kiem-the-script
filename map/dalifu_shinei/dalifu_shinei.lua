-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(165); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪�����˷��䡿---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit13")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(28,1764,3306)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;


-------------- ���뿪���ʺ󷿼䡿---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit14")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	me.NewWorld(28,1719,3289)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;


-------------- ����ѩ���䡿---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit15")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()	
	me.NewWorld(28,1651,3465)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

-------------- ����ɣ�����䡿---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit16")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()	
	me.NewWorld(28,1611,3501)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;


-------------- �����������䡿---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit12")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()	
	me.NewWorld(28,1782,3356)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;


-------------- ���뿪���������ҡ�---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_exit11")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	me.NewWorld(165,1978,3492)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

-------------- �����������ҡ�---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_guifeimishi")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()	
	me.NewWorld(165,1837,3513)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;
