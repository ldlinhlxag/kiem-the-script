-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(401); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("2ceng21ceng")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(400,1625,3218)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(0);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("2ceng23ceng")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	local task_value = me.GetTask(1022,9)
	if (task_value == 1) then 
		return;
	else
		me.NewWorld(402,1604,3257)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	end	
end;