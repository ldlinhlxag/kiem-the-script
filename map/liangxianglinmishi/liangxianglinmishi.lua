-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(528); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����������ҡ� ---------------
local tbTestTrap1= tbTest:GetTrapClass("to_exit528")

function tbTestTrap1:OnPlayer()	
	me.NewWorld(527,1612,3205)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;
