-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(405); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("wyxz2yanziwu")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(60,1484,2977)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;