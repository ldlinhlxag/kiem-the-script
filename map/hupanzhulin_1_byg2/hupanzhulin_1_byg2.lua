-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(460); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("byg2hupanzhulin")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(63,1827,3410)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;


-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

