-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(74); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_shandi")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_yucangfeng")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	me.NewWorld(424,1605,3218);
	--[[local task_value = me.GetTask(1022,26)
	if (task_value == 1) then 	
		me.NewWorld(424,1605,3218)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		me.NewWorld(413,1756,3727)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);		
		return;
	end]]--	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_yinfang")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	me.NewWorld(423,1554,3120);
	--[[local task_value = me.GetTask(1022,27)
	if (task_value == 1) then 	
		me.NewWorld(205,1578,3850)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		return;
	end ]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_yintong")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()
	me.NewWorld(422,1528,3125);
	--[[local task_value = me.GetTask(1022,28)
	if (task_value == 1) then 	
		me.NewWorld(205,1655,3842)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		return;
	end	]]--		
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_wuguigu")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()
	local task_value = me.GetTask(1022,29)
	if (task_value == 1) then 	
		return;
	else
		me.NewWorld(74,1875,3625)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		TaskAct:Talk("�������գ����ǲ�Ҫ��ȥ�ˡ�");
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_ganlugu")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()		
	me.NewWorld(414,1596,3217);	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_dingtaoling1")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()
	me.NewWorld(425,1604,3189);
	--[[local task_value = me.GetTask(1022,31)
	if (task_value == 1) then 	
		me.NewWorld(205,1667,3949)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap8	= tbTest:GetTrapClass("to_dingtaoling2")

-- �������Trap�¼�
function tbTestTrap8:OnPlayer()
	me.NewWorld(425,1604,3189);
	--[[local task_value = me.GetTask(1022,31)
	if (task_value == 1) then 	
		me.NewWorld(205,1754,3955)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap9	= tbTest:GetTrapClass("to_nvwushouling")

-- �������Trap�¼�
function tbTestTrap9:OnPlayer()
	me.NewWorld(421,1619,3220);
	--[[local task_value = me.GetTask(1022,32)
	if (task_value == 1) then 	
		me.NewWorld(205,1767,3736)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap10	= tbTest:GetTrapClass("to_gexialing")

-- �������Trap�¼�
function tbTestTrap10:OnPlayer()
	if (me.nSex == 1) then
		me.NewWorld(427,1609,3252)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1);
	else
    		me.NewWorld(426,1609,3252)	-- ����,[��ͼId,����X,����Y]
    		me.SetFightState(1);
	end
	--[[local task_value = me.GetTask(1022,33)
	if (task_value == 1) then 	
		if (me.nSex == 1) then
			me.NewWorld(205,1825,3091)	-- ����,[��ͼId,����X,����Y]	
			me.SetFightState(1);
		else
    		me.NewWorld(205,1823,2978)	-- ����,[��ͼId,����X,����Y]
    		me.SetFightState(1);
		end
	else
		return;
	end]]--	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap11	= tbTest:GetTrapClass("to_shedong")

-- �������Trap�¼�
function tbTestTrap11:OnPlayer()
	me.NewWorld(412,1603,3225);
	--[[local task_value = me.GetTask(1022,31)
	if (task_value == 1) then 	
		me.NewWorld(205,1754,3955)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		return;
	end	]]--
end;
-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

