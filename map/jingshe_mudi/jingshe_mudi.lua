-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(808); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_jingshe")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(802,1643,3196)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(0);		
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

