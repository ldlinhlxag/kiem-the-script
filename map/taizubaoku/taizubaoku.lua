-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(553); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪̫�汦�⡿---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit553")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	

local task_value = me.GetTask(1024,2)
	if (task_value == 3) then 
		 me.NewWorld(551,1636,3066)	-- ����,[��ͼId,����X,����Y]	
		 me.SetFightState(1)
	     return;		 		 
	else
		 me.NewWorld(552,1636,3066)	-- ����,[��ͼId,����X,����Y]	
		 me.SetFightState(1)
		 return;
	end		
end;
