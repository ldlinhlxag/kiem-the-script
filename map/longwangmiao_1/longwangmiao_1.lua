-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(506); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪������ ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit506")

function tbTestTrap3:OnPlayer()
	me.NewWorld(88,1882,3831)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

