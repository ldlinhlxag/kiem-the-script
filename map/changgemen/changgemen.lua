-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(21); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("xizuo")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	local task_value = me.GetTask(1022,151)
	if (task_value == 1) then 	
		me.NewWorld(800,1605,3190);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	elseif (task_value == 2) then 
		me.NewWorld(801,1605,3190);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	elseif (task_value == 3) then 
		me.NewWorld(810,1605,3190);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("qiehuan")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	if (me.nFightState == 1) then 	
		me.NewWorld(21,1723,3428);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
	else
		me.NewWorld(21,1727,3436);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	end	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

