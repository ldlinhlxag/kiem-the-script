-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(107); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ��ȥ��һ���ķ���---6�š�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_diyimei")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(218,1722,3306)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;


-------------- ��ȥ����˵ķ���---26�š�---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_miaofazhenren")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	me.NewWorld(218,1578,3941)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0);
end;



-------------- ��ȥ�ؽ�---17�š�---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_dijiao")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()	

local task_value = me.GetTask(1024,23)
	if (task_value == 1) then 
		me.NewWorld(218,1578,3728)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		me.NewWorld(218,1664,3610)
		me.SetFightState(1);
		return;
	end		
end;

