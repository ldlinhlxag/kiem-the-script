-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(110); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����߶���---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_mangshedong")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(548,1563,3253)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

