-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(201); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_exit17")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(63,1591,3433)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit21")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	me.NewWorld(63,1827,3410)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit22")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	me.NewWorld(63,1557,3542)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit23")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()	
	me.NewWorld(63,1573,3561)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit24")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()
	me.NewWorld(63,1686,3424)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_exit25")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	me.NewWorld(63,1827,3410)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

