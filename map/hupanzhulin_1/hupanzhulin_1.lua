-- Map �����ӼӲ���
-- ��ӭɾ��

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(63); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_xixiang")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(462,1528,3126);
	--[[local task_value = me.GetTask(1022,43)
	if (task_value == 1) then 	
		me.NewWorld(201,1654,3841);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_zhengting")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	me.NewWorld(463,1555,3120);	
	--[[local task_value = me.GetTask(1022,44)
	if (task_value == 1) then 	
		me.NewWorld(201,1726,3856);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_zhuozheju")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	me.NewWorld(461,1611,3216);
	--[[local task_value = me.GetTask(1022,45)
	if (task_value == 1) then 	
		me.NewWorld(201,1800,3865);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_buyige")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()
	local task_value = me.GetTask(1022,46)
	if (task_value == 1) then 	
		me.NewWorld(460,1607,3208);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		me.NewWorld(459,1607,3208)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_jianlongdong")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()
	me.NewWorld(458,1609,3455);
	--[[local task_value = me.GetTask(1022,47)
	if (task_value == 1) then 	
		me.NewWorld(201,1572,3727);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_liechang")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	local task_value = me.GetTask(1022,48)
	if (task_value == 1) then 	
		TaskAct:Talk("�����Գ������������");
		return;
	else
		me.NewWorld(63,1624,3263)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	end	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

