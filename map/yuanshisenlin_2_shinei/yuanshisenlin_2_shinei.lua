-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(205); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_exit5")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(74,1859,3474)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);		
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit6")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	-- local task_value = me.GetTask(1022,76)
	-- if (task_value == 1) then 	
	-- return;
	-- else
		me.NewWorld(74,1754,3724);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	-- end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit8")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	local task_value = me.GetTask(1022,30)
	if (task_value == 2) then 	
		if (me.nSex == 1) then
    		me.NewWorld(205,1727,3859)	-- ����,[��ͼId,����X,����Y]
    		me.SetFightState(1);
		else
    		me.NewWorld(205,1801,3865)	-- ����,[��ͼId,����X,����Y]
    		me.SetFightState(1);
		end
	else	
		me.NewWorld(74,1757,3660)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	end
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit17")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()
	-- local task_value = me.GetTask(1022,77)
	-- if (task_value == 1) then 	
	-- 	return;
	-- else
		me.NewWorld(74,1857,3579);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	-- end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit18")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()
	local task_value = me.GetTask(1022,25)
	if (task_value == 1) then 	
		return;
	else
		me.NewWorld(74,1857,3579);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_exit19")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	me.NewWorld(74,1612,3722)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_exit21")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()
	me.NewWorld(74,1793,3565)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap8	= tbTest:GetTrapClass("to_exit22")

-- �������Trap�¼�
function tbTestTrap8:OnPlayer()
	me.NewWorld(74,1793,3565)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap9	= tbTest:GetTrapClass("to_exit23")

-- �������Trap�¼�
function tbTestTrap9:OnPlayer()
	me.NewWorld(74,1757,3660)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap10	= tbTest:GetTrapClass("to_exit24")

-- �������Trap�¼�
function tbTestTrap10:OnPlayer()
    me.NewWorld(74,1757,3660)	-- ����,[��ͼId,����X,����Y]
    me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap11	= tbTest:GetTrapClass("to_exit25")

-- �������Trap�¼�
function tbTestTrap11:OnPlayer()
	me.NewWorld(74,1755,3726)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap12	= tbTest:GetTrapClass("to_exit26")

-- �������Trap�¼�
function tbTestTrap12:OnPlayer()
	me.NewWorld(74,1774,3487)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap13	= tbTest:GetTrapClass("to_exit27")

-- �������Trap�¼�
function tbTestTrap13:OnPlayer()
	me.NewWorld(74,1895,3474)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap14	= tbTest:GetTrapClass("to_exit28")

-- �������Trap�¼�
function tbTestTrap14:OnPlayer()
	me.NewWorld(74,1895,3474)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap15	= tbTest:GetTrapClass("to_exit3")

-- �������Trap�¼�
function tbTestTrap15:OnPlayer()
	me.NewWorld(74,1609,3247)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap16	= tbTest:GetTrapClass("to_exit4")

-- �������Trap�¼�
function tbTestTrap16:OnPlayer()
	me.NewWorld(74,1609,3247)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

