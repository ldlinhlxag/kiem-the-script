-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(526); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ��³���� ---------------
local tbTestTrap1= tbTest:GetTrapClass("to_exit526")

function tbTestTrap1:OnPlayer()	
	me.NewWorld(94,1872,3486)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

