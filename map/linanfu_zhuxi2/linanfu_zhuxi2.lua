-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(487); -- ��ͼId

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
	local task_value = me.GetTask(1022,139)
	if (task_value == 1) then 	
		me.NewWorld(488,1530,3956);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	elseif (task_value == 2) then 	
		me.NewWorld(491,1530,3956);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	elseif (task_value == 3) then 	
		me.NewWorld(492,1530,3956);	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		me.NewWorld(29,1530,3956);	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(0)
	end
end;

