-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(450); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("xzl2jinguohuangling")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()

	local task_value = me.GetTask(1022,58)
	if (task_value == 1) then 
		return;
	else
		me.NewWorld(67,1563,3479)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1);
	end	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

