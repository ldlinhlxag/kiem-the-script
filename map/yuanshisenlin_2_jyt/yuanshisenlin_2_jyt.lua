-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(420); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("juyiting2jueshiding")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	local task_value = me.GetTask(1022,25)
	if (task_value == 1) then 	
		return;
	else
		me.NewWorld(74,1857,3579);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	end	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

