-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(410); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("cyx2yanziwu")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(60,1533,3020)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;
