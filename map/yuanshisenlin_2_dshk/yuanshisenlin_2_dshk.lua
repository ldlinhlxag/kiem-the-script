-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(413); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("dshk2ganglou")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	-- local task_value = me.GetTask(1022,76)
	-- if (task_value == 1) then 	
	-- return;
	-- else
		me.NewWorld(424,1605,3218);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	-- end	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

