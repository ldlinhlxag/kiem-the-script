-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(199); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_exit3")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(59,1531,2832)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);		
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit17")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	me.NewWorld(59,1545,3139)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit21")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
    me.NewWorld(59,1475,3114)	-- ����,[��ͼId,����X,����Y]
    me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit22")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()
	me.NewWorld(59,1475,3114)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit23")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()
	me.NewWorld(59,1441,2588)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_exit24")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	me.NewWorld(59,1531,2832)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_exit25")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()
	me.NewWorld(59,1409,2919)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap8	= tbTest:GetTrapClass("to_exit26")

-- �������Trap�¼�
function tbTestTrap8:OnPlayer()
	me.NewWorld(59,1531,2832)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap9	= tbTest:GetTrapClass("to_exit27")

-- �������Trap�¼�
function tbTestTrap9:OnPlayer()
	me.NewWorld(59,1441,2588)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap10	= tbTest:GetTrapClass("to_exit28")

-- �������Trap�¼�
function tbTestTrap10:OnPlayer()
	me.NewWorld(199,1667,3944)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(0);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap11	= tbTest:GetTrapClass("to_exit29")

-- �������Trap�¼�
function tbTestTrap11:OnPlayer()
	me.NewWorld(59,1531,2832)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

