-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(412); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("chlshd2yuanshisenlin")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(74,1859,3474)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);		
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

