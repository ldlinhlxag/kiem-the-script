-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(515); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪�����޷��䡿---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit515")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(29,1581,3818)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

