-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(198); -- ��ͼId

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
	me.NewWorld(55,1811,3456)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit24")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	me.NewWorld(55,1729,3208)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit25")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	me.NewWorld(55,1653,3371)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit26")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()	
	me.NewWorld(55,1833,3477)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit27")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()
	me.NewWorld(55,1810,3487)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_floor2")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()
	--local task_value = me.GetTask(1022,8)
	if (task_value == 1) then 
		return;
	else
		me.NewWorld(198,1656,3840)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_floor3")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()
	local task_value = me.GetTask(1022,9)
	if (task_value == 1) then 
		return;
	else
		me.NewWorld(198,1729,3858)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap8	= tbTest:GetTrapClass("to_exit21")

-- �������Trap�¼�
function tbTestTrap8:OnPlayer()	
	--me.NewWorld(198,1590,3839)
	me.NewWorld(55,1614,3198)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap9	= tbTest:GetTrapClass("to_exit22")

-- �������Trap�¼�
function tbTestTrap9:OnPlayer()
	me.NewWorld(198,1590,3839)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(0);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap10	= tbTest:GetTrapClass("to_exit23")

-- �������Trap�¼�
function tbTestTrap10:OnPlayer()
	me.NewWorld(198,1666,3831)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

