-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(544); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ��һƷ�ñ�Ӫ��---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit544")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(101,1765,3266)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

