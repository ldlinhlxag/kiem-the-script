-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(521); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪���Ϸ��䡿---------------
local tbTestTrap8	= tbTest:GetTrapClass("to_exit521")

-- �������Trap�¼�
function tbTestTrap8:OnPlayer()	
	me.NewWorld(29,1491,3761)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;
