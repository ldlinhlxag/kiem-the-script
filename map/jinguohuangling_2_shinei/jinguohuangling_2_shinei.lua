-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(203); -- ��ͼId

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

	local task_value = me.GetTask(1022,58)
	if (task_value == 1) then 
		return;
	else
		me.NewWorld(67,1563,3479)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1);
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit21")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
    me.NewWorld(67,1588,3349)	-- ����,[��ͼId,����X,����Y]
    me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit22")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	me.NewWorld(67,1614,3322)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit23")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()
	me.NewWorld(67,1580,3319)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit24")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()	
	me.NewWorld(67,1604,3360)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

