-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(200); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_exit5")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(60,1484,2977)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit6")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	me.NewWorld(60,1494,3268)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit8")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	me.NewWorld(60,1420,2712)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit9")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()
	me.NewWorld(60,1287,3204)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit10")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()
    me.NewWorld(60,1363,2731)	-- ����,[��ͼId,����X,����Y]
    me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_exit11")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	

end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_exit21")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()
	me.NewWorld(60,1533,3020)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap8	= tbTest:GetTrapClass("to_exit22")

-- �������Trap�¼�
function tbTestTrap8:OnPlayer()
	me.NewWorld(200,1596,3240)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(0);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap9	= tbTest:GetTrapClass("to_exit23")

-- �������Trap�¼�
function tbTestTrap9:OnPlayer()
	me.NewWorld(60,1442,3119)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

