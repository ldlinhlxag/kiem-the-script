-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(101); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ��ȥ�õ꡿---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_lvdian")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	me.NewWorld(543,1605,3189)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;



-------------- ��һƷ�ñ�Ӫ�� ---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_chalahan")

function tbTestTrap7:OnPlayer()
  
local task_value = me.GetTask(1024,25)
	if (task_value == 2) then 
         TaskAct:Talk("<npc=971>:\"ʲô�˵����Ҵ���Ӫ��\"")
		 return;
	else	
     	 me.NewWorld(544,1633,3239)	-- ����,[��ͼId,����X,����Y]	
		 me.SetFightState(1)
		return; 
	end		

end	
