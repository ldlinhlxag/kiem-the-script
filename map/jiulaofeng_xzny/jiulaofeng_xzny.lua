-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(454); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("xzny2jiulaofeng")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(51,1620,3452)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);	
end;


-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

