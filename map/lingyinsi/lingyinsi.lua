-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(524); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ���뿪�����¡�---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit524")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()	
	me.NewWorld(29,1447,3896)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;


