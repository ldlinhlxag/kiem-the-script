-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(66); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_chuzuan")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(446,1637,3245);	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(0);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_huifengjiao")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	local task_value = me.GetTask(1022,69)
	if (task_value == 1) then 	
		me.NewWorld(448,1632,3240);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	elseif (task_value == 2) then 
		me.NewWorld(449,1632,3240);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		me.NewWorld(448,1632,3240);
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_jingangling")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	local task_value = me.GetTask(1022,70)
	if (task_value == 1) then 	
		me.NewWorld(444,1622,3562);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	elseif (task_value == 2) then 
		me.NewWorld(445,1622,3562);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_pomiao")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()

end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_qianfoxiagu1")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()

end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_qianfoxiagu2")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_qianfoxiagu3")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()

end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

