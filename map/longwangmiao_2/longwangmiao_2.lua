-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(507); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪������2�� ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit507")

function tbTestTrap1:OnPlayer()
	me.NewWorld(88,1882,3831)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

