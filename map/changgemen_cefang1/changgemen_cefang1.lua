-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(800); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_changgemen")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(21,1567,3330);	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(0);
	return;	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

