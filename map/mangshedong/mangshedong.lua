-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(548); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪���߶���---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit548")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(110,1505,3311)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ��ǰ��Ͽ��1234�� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_xiagu")
function tbTestTrap2:OnPlayer()
  
local task_value = me.GetTask(1024,2)
	if (task_value == 1) then 
     	 me.NewWorld(549,1606,3220)	-- ����,[��ͼId,����X,����Y]	
		 me.SetFightState(1)
	     return;
    elseif (task_value == 2) then
		 me.NewWorld(550,1606,3220)	-- ����,[��ͼId,����X,����Y]	
		 me.SetFightState(1)
		 return;
    elseif (task_value == 3) then
		 me.NewWorld(551,1606,3220)	-- ����,[��ͼId,����X,����Y]	
		 me.SetFightState(1)
		 return;		 		 
	else
		 me.NewWorld(552,1606,3220)	-- ����,[��ͼId,����X,����Y]	
		 me.SetFightState(1)
		 return;
	end		
end;

