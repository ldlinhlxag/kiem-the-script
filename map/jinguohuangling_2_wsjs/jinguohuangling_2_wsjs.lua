-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(451); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("wsjs2jinguohuangling")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
    me.NewWorld(67,1588,3349)	-- ����,[��ͼId,����X,����Y]
    me.SetFightState(1);	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;