-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(504); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪ؤ��ֶ桿 ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit504")

function tbTestTrap1:OnPlayer()
	me.NewWorld(88,1631,3705)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;
