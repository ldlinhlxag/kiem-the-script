-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(196); -- ��ͼId

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
	me.NewWorld(48,1794,3273)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit21")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	me.NewWorld(48,1766,3455)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit22")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	me.NewWorld(48,1766,3455)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit18")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()
	me.NewWorld(48,1789,3293)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit19")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()
	me.NewWorld(48,1802,3302)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

