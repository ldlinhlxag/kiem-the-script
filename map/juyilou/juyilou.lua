-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(546); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪����¥��---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit546")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(109,1697,3282)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;


-------------- ����¥��---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_gelou")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	me.NewWorld(547,1582,3211)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

