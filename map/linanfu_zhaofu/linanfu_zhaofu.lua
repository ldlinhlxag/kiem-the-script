-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(485); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪�����޷��䡿---------------
local tbTestTrap	= tbTest:GetTrapClass("to_linanfu")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	

	local task_value = me.GetTask(1022,138)
	if (task_value == 1) then 	
		me.NewWorld(486,1581,3818)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(0)
		return;
	elseif (task_value == 2) then 
		me.NewWorld(490,1581,3818)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(0)
		return;
	else
		me.NewWorld(29,1581,3818)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(0)
	end
end;

