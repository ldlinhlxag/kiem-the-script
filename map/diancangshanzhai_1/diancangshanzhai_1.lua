-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(531); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪ɽկ�� ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit531")

function tbTestTrap1:OnPlayer()
		me.NewWorld(98,1826,3694)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1)  	
end;
		
