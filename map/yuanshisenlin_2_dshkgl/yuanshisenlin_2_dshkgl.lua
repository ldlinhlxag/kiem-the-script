-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(424); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("dshk2yuanshisenlin")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	local task_value = me.GetTask(1022,26)
	if (task_value == 1) then 	
		me.NewWorld(413,1756,3727)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		me.NewWorld(74,1755,3726)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);		
		return;
	end
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

