-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(551); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪Ͽ�ȡ�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit551")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(548,1600,3093)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;


-------------- ��̫�汦�⡿---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_taizubaoku1")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	

local task_value = me.GetTask(1024,3)
	if (task_value == 1) then 
	     return;		 		 
	else
		 me.NewWorld(553,1535,3212)	-- ����,[��ͼId,����X,����Y]	
		 me.SetFightState(1)
		 return;
	end		
end;

