-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(453); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("zhchd2jinguohuangling")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(67,1580,3319)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;


-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

