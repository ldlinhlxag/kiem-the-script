-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(98); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �������Ժ--ս��7����ս��20����---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_bieyuan")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	local task_value = me.GetTask(1024,10)
	if (task_value == 1) then 
		me.NewWorld(533,1597,3251)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1);
	  	return; 	  			
 	elseif (task_value == 2) then 
	  	me.NewWorld(534,1597,3251);	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(0);
		return;
  	else
  		return;
	end
end	


-------------- ��ɽկ������18��˫��19�� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_shanzhai")
function tbTestTrap2:OnPlayer()
	
local task_value = me.GetTask(1024,9)
	  if (task_value == 1) then 
		me.NewWorld(531,1605,3188);	-- ����,[��ͼId,����X,����Y]	
	  	me.SetFightState(0);
	  	return; 
  	elseif (task_value == 2) then 
	  	me.NewWorld(532,1605,3188);	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(0);
		return;
  	else
  		return;
	end
end	



 

