-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(51); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_biyueshantang")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	local task_value = me.GetTask(1022,34)
	if (task_value == 1) then 	
		return;
	else
		me.NewWorld(51,1572,3153)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		me.Msg("���й�ͣ������˵Ȳ������ڡ�");
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_xingzaineiying")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	--local task_value = me.GetTask(1022,35)
	--if (task_value == 2) then 
		me.NewWorld(454,1554,3119)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	--[[else
		me.NewWorld(197,1572,3727);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	end]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_ciyunan")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	me.NewWorld(456,1619,3220)
	--[[local task_value = me.GetTask(1022,36)
	if (task_value == 1) then 	
		me.NewWorld(197,1579,3848)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_chouxuewoshi")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()
	me.NewWorld(457,1606,3209)
	--[[local task_value = me.GetTask(1022,37)
	if (task_value == 1) then 	
		me.NewWorld(457,1606,3209)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_jianxueting")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()
	local task_value = me.GetTask(1022,38)
	if (task_value == 1) then 	
		return;
	else
		me.NewWorld(51,1436,3429)	-- ����,[��ͼId,����X,����Y]
		TaskAct:Talk("���й�ͣ������˵Ȳ������ڡ�");
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_xingzaidamen")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	--[[local task_value = me.GetTask(1022,35)
	if (task_value == 1) then
		me.NewWorld(197,1572,3727);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		return;
	end]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_houshanxiaojing")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()	
	me.NewWorld(197,1679,3721);
	--[[local task_value = me.GetTask(1022,39)
	if (task_value == 1) then 	
		me.NewWorld(197,1679,3721);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		return;
	end	]]--
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

