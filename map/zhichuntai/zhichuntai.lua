-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(522); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ���뿪�շŷ��䡿---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit522")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()	
	me.NewWorld(29,1640,3868)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

