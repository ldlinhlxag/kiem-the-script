-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(400); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("1ceng2qingluodao")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(55,1614,3198)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("1ceng22ceng")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	--local task_value = me.GetTask(1022,8)
	if (task_value == 1) then 
		return;
	else
		me.NewWorld(401,1574,3273)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	end	
end;