-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(508); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ���뿪ɽ���� ---------------
local tbTestTrap18	= tbTest:GetTrapClass("to_exit508")

function tbTestTrap18:OnPlayer()
	me.NewWorld(88,1853,3210)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

