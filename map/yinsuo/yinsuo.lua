-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(503); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪������ ---------------
local tbTestTrap17	= tbTest:GetTrapClass("to_exit503")

function tbTestTrap17:OnPlayer()
	me.NewWorld(88,1909,3624)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;
