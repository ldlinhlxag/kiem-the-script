-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(219); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪̫���Ǽ�---26�š�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit26")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(108,1948,3148)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;


-------------- ���뿪��������---20�š�---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit20")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	me.NewWorld(108,1917,3258)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;



-------------- ���뿪ʬ��---29�š�---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit29")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()	
	me.NewWorld(108,1781,3587)	-- ����,[��ͼId,����X,����Y]	
end;


