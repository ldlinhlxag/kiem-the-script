-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(414); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("ceng12yuanshisenlin")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(74,1757,3660)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("ceng12ceng2")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	me.NewWorld(415,1596,3217);	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

