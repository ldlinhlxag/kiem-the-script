-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(501); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪����С��1--26ȥ���⡿ ---------------
local tbTestTrap20	= tbTest:GetTrapClass("to_exit501")

function tbTestTrap20:OnPlayer()
	me.NewWorld(88,1705,3484)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

