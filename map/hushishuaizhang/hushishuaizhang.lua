-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(509); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪��ʦ�� ---------------
local tbTestTrap19	= tbTest:GetTrapClass("to_exit509")

function tbTestTrap19:OnPlayer()
	me.NewWorld(88,1743,3351)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

