-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(59); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_jiejianchi")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	local task_value = me.GetTask(1022,61)
	if (task_value == 1) then 	
		me.NewWorld(433,1555,3106)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_laojunyan")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()

end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_qingxuzhenshi")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	local task_value = me.GetTask(1022,62)
	if (task_value == 1) then 	
		me.NewWorld(434,1606,3209);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	elseif (task_value == 2) then 
		me.NewWorld(435,1606,3209);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		me.NewWorld(434,1606,3209);	
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_taoju")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()
	local task_value = me.GetTask(1022,63)
	if (task_value == 1) then 	
		me.NewWorld(439,1619,3220);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	elseif (task_value == 2) then 
		me.NewWorld(440,1619,3220);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	elseif (task_value == 3) then 
		me.NewWorld(441,1619,3220);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	elseif (task_value == 4) then 
		me.NewWorld(442,1619,3220);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		me.NewWorld(439,1619,3220);
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_weiju")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()
	me.NewWorld(443,1619,3220)-- ����,[��ͼId,����X,����Y]
	me.SetFightState(0);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_yunlushuiju")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	local task_value = me.GetTask(1022,65)
	if (task_value == 1) then 	
		me.NewWorld(436,1527,3126);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	elseif (task_value == 2) then 
		me.NewWorld(437,1527,3126);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		me.NewWorld(436,1527,3126);
		return;
	end
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

