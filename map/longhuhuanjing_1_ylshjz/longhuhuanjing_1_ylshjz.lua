-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(438); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("zhadou2ylshj")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	local task_value = me.GetTask(1022,66)
	if (task_value == 1) then 	
		me.NewWorld(437,1540,3115)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);	
		return;
	else
		me.NewWorld(436,1540,3115)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);	
		return;
	end	
	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

