-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(432); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("yinshan2jianxingfeng")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(48,1766,3455)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;