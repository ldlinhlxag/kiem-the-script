-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(48); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_yinshan")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	local task_value = me.GetTask(1022,57)
	if (task_value == 1) then 	
		me.NewWorld(431,1555,3120);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	elseif (task_value == 2) then 
		me.NewWorld(432,1555,3120);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		me.NewWorld(431,1555,3120);
		return;
	end	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

