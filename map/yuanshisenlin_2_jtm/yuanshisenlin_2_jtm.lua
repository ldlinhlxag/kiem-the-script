-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(416); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("jintou2ceng2")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(415,1704,3299)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);		
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

