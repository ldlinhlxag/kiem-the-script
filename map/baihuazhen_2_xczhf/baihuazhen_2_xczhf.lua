-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(471); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("xczhf2baihuazhen")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(72,1966,3785)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

