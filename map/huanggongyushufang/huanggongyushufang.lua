-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(564); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪�ʹ����鷿��---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_exit564")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	me.NewWorld(568, 1635, 3234)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

