-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(525); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���ķ����ӡ� ---------------
local tbTestTrap1= tbTest:GetTrapClass("to_exit525")

function tbTestTrap1:OnPlayer()	
	me.NewWorld(94,1926,3260)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

