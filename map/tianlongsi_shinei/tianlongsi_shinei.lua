-- ���������ڵĽű���ͼ

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(220); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �뿪��ʹС�ݡ�17�� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_exit17")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(112,1596,3609)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1)  	
end;

-------------- �뿪կ�����䡾18��---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit18")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()
	me.NewWorld(112,1890,3637)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1)  	
end;

-------------- �뿪�����˷��䡾19��---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit19")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	me.NewWorld(112,1828,3685)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)  
end;

--------------�뿪�������䡾20��---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit20")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	me.NewWorld(112,1855,3646)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1) 
end;

-------------- �뿪���ҡ�9��---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit9")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()
	me.NewWorld(112,1898,3782)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1) 
end;

-------------- �뿪����ɽׯ��21��---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit21")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()
	me.NewWorld(112,1721,3783)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1) 
end;

-------------- �뿪����¥һ�㡾23��---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_exit23")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()
	me.NewWorld(112,1634,3378)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1) 	
end;

-------------- ��������ȥ�������䡾18-24��---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_guizhudezhufang")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()
	me.NewWorld(220,1802,3864)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0) 
end;

-------------- �뿪�����ķ���---------------
local tbTestTrap8	= tbTest:GetTrapClass("to_exit24")

-- �������Trap�¼�
function tbTestTrap8:OnPlayer()
	me.NewWorld(112,1890,3637)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1) 
end;


-------------- �������¥1�㴫�͵�����¥2�㡾23-25��---------------
local tbTestTrap10	= tbTest:GetTrapClass("to_guanrilouerceng")

-- �������Trap�¼�
function tbTestTrap10:OnPlayer()
	me.NewWorld(220,1886,3851)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1) 	
end;

-------------- �������¥2�㴫�͵�����¥1�㡾25-23��---------------
local tbTestTrap11	= tbTest:GetTrapClass("to_exit25")

-- �������Trap�¼�
function tbTestTrap11:OnPlayer()
	me.NewWorld(220,1731,3840)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1) 
end;

-------------- �������¥1�㴫�͵�����¥�ؽѡ�23-26��---------------
local tbTestTrap12	= tbTest:GetTrapClass("to_guanriloudijiao")

-- �������Trap�¼�
function tbTestTrap12:OnPlayer()

	me.NewWorld(220,1578,3941)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0) 
end;

-------------- �������¥�ؽѴ��͵�����¥1��---------------
local tbTestTrap13	= tbTest:GetTrapClass("to_exit26")

-- �������Trap�¼�
function tbTestTrap13:OnPlayer()
	me.NewWorld(112,1634,3378)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1) 	
end;

