-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(95); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ����ţɽׯ�����˹�� ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_fotang")

function tbTestTrap1:OnPlayer()	
	me.NewWorld(529,1604,3187)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;


