-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(72); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_chunmeiyazhu")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	local task_value = me.GetTask(1022,51)
	if (task_value == 1) then 	
		me.NewWorld(464,1528,3126);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	elseif (task_value == 2) then 
		me.NewWorld(465,1528,3126);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	elseif (task_value == 3) then 
		me.NewWorld(466,1528,3126);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		me.NewWorld(464,1528,3126);
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_chunmeiyazhu2")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	local task_value = me.GetTask(1022,52)
	if (task_value == 1) then 	
		me.NewWorld(468,1528,3126);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	elseif (task_value == 2) then 
		me.NewWorld(467,1528,3126);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		me.NewWorld(467,1528,3126);
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_guanyi")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	local task_value = me.GetTask(1022,53)
	if (task_value == 1) then
		return;
	else
		me.NewWorld(72,1960,3473)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		TaskAct:Talk("���й�ͣ����������");
		return;
	end			
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_guanyi2")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()
	local task_value = me.GetTask(1022,54)
	if (task_value == 1) then 	
		me.NewWorld(469,1617,3201);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	elseif (task_value == 2) then 
		me.NewWorld(470,1617,3201);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		me.NewWorld(470,1617,3201);
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_pinhetang")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()
	me.NewWorld(475,1554,3119);
	--[[local task_value = me.GetTask(1022,55)
	if (task_value == 1) then 	
		me.NewWorld(475,1554,3119);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_qiushuangge")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_xiacengzhenfa")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()
	local task_value = me.GetTask(1022,56)
	if (task_value == 1) then 	
		me.NewWorld(471,1632,3212);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;	
	else
		me.NewWorld(472,1660,3177);
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap8	= tbTest:GetTrapClass("to_xuanyuedazhen")

-- �������Trap�¼�
function tbTestTrap8:OnPlayer()
	me.NewWorld(473,1619,3209);	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
	--[[local task_value = me.GetTask(1022,56)
	if (task_value == 1) then 	
		me.NewWorld(204,1858,3956);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	elseif (task_value == 2) then 
		me.NewWorld(204,1608,3716);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	elseif (task_value == 3) then 
		me.NewWorld(204,1756,3956);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;		
	else
		me.NewWorld(204,1608,3716);
		return;
	end	]]--
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

