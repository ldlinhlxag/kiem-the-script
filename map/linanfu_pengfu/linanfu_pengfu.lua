-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(483); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ���뿪���䷿�䡿---------------
local tbTestTrap	= tbTest:GetTrapClass("to_linanfu")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	local task_value = me.GetTask(1022,135)
	if (task_value == 1) then 	
		me.NewWorld(484,1789,3949);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		me.NewWorld(29,1789,3949);	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(0)
	end
end;

