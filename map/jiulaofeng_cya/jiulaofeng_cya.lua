-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(456); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("cya2jiulaofeng")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(51,1623,3128)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);		
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

