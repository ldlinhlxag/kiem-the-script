-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(218); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪��һ���ķ���---6�š�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit6")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(107,1709,3242)	-- ����,[��ͼId,����X,����Y]	
end;


-------------- ���뿪����˵ķ���---26�š�---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit26")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	me.NewWorld(107,1681,3454)	-- ����,[��ͼId,����X,����Y]	
end;



-------------- ���뿪�ؽ�---17�š�---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit17")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()	
	me.NewWorld(107,1710,3459)	-- ����,[��ͼId,����X,����Y]	
end;


-------------- ��ȥ����ͷ---17��13�š�---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_guailaotou")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()	
	
local task_value = me.GetTask(1024,23)
	if (task_value == 2) then 
		me.NewWorld(218,1664,3610)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		return;
	end		
end;	

-------------- ���뿪����ͷ---13�š�---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit13")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()	
	me.NewWorld(107,1710,3459)	-- ����,[��ͼId,����X,����Y]	
end;
