-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(99); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ������̶2--23�š� ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_heilongtan")

function tbTestTrap1:OnPlayer()
	me.NewWorld(530,1592,3303)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

