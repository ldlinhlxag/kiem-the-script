-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(462); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("byxzh2hupanzhulin")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(63,1557,3542)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

