-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(204); -- ��ͼId

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
	me.NewWorld(204,1581,3721)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);		
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit17")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	me.NewWorld(72,2189,3650)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit21")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
    me.NewWorld(72,2193,3401)	-- ����,[��ͼId,����X,����Y]	
    me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit22")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()
	me.NewWorld(72,2193,3401)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit23")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()
	me.NewWorld(72,2193,3401)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_exit24")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	me.NewWorld(72,1868,3471)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_exit25")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()
	me.NewWorld(72,1868,3471)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap8	= tbTest:GetTrapClass("to_exit26")

-- �������Trap�¼�
function tbTestTrap8:OnPlayer()
	me.NewWorld(72,2283,3429)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap9	= tbTest:GetTrapClass("to_exit27")

-- �������Trap�¼�
function tbTestTrap9:OnPlayer()
	me.NewWorld(72,2283,3429)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap10	= tbTest:GetTrapClass("to_exit28")

-- �������Trap�¼�
function tbTestTrap10:OnPlayer()
	me.NewWorld(72,1971,3785)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap11	= tbTest:GetTrapClass("to_exit29")

-- �������Trap�¼�
function tbTestTrap11:OnPlayer()
	me.NewWorld(72,1966,3785)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap12	= tbTest:GetTrapClass("to_exit4")

-- �������Trap�¼�
function tbTestTrap12:OnPlayer()
	me.NewWorld(72,1828,3590)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

