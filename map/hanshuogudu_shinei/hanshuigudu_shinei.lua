-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(207); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪ؤ��ֶ�1ľ����--21ȥ���⡿ ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit21")

function tbTestTrap1:OnPlayer()
	me.NewWorld(88,1631,3705)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ���뿪ؤ��ֶ�2ľ����--18ȥ���⡿ ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit18")

function tbTestTrap2:OnPlayer()
	me.NewWorld(88,1668,3795)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;


-------------- ���뿪ɽ����--23ȥ���⡿ ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit23")

function tbTestTrap3:OnPlayer()
	me.NewWorld(88,1882,3831)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;


-------------- ����һ��ȥؤ��ֶ��ڲ�������һ�䷿��17�š�---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_gaibangfenduo2")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()	
	me.NewWorld(207,1575,3725)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ���뿪���17ȥ21�� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit17")

function tbTestTrap5:OnPlayer()
	me.NewWorld(207,1580,3847)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ��ȥ�ܵ�1--24�š� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_midao1")

function tbTestTrap6:OnPlayer()	
	me.NewWorld(207,1802,3864)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ���뿪�ܵ�1--24ȥ18�� ---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_exit24")

function tbTestTrap7:OnPlayer()
	me.NewWorld(207,1673,3728)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ��ȥ�ܵ�2--25�š� ---------------
local tbTestTrap8	= tbTest:GetTrapClass("to_midao2")

function tbTestTrap8:OnPlayer()
	me.NewWorld(207,1886,3851)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ���뿪�ܵ�2--25ȥ24�� ---------------
local tbTestTrap9	= tbTest:GetTrapClass("to_exit25")

function tbTestTrap9:OnPlayer()
	me.NewWorld(207,1802,3864)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ��ȥ�ܵ�3--20�š� ---------------
local tbTestTrap10	= tbTest:GetTrapClass("to_midao3")

function tbTestTrap10:OnPlayer()
	me.NewWorld(207,1867,3737)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ���뿪�ܵ�3--20ȥ25�� ---------------
local tbTestTrap11	= tbTest:GetTrapClass("to_exit20")

function tbTestTrap11:OnPlayer()
	me.NewWorld(207,1886,3851)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ��ȥ�ܵ�4--16�š� ---------------
local tbTestTrap12	= tbTest:GetTrapClass("to_midao4")

function tbTestTrap12:OnPlayer()
	me.NewWorld(207,1928,3596)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ���뿪�ܵ�4--16ȥ20�� ---------------
local tbTestTrap13	= tbTest:GetTrapClass("to_exit16")

function tbTestTrap13:OnPlayer()
	me.NewWorld(207,1867,3737)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ��ȥ�ܵ�����--16�š� ---------------
local tbTestTrap14	= tbTest:GetTrapClass("to_midaochukou")

function tbTestTrap14:OnPlayer()
	me.NewWorld(88,1687,3892)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ��ȥ���ź�Ժ--29�š� ---------------
local tbTestTrap15	= tbTest:GetTrapClass("to_yusouhouyuan")

function tbTestTrap15:OnPlayer()

	me.NewWorld(207,1861,3954)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
	
end;


-------------- ���뿪���ź�Ժ--29ȥ28�� ---------------
local tbTestTrap16	= tbTest:GetTrapClass("to_exit29")

function tbTestTrap16:OnPlayer()
	me.NewWorld(207,1756,3953)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;


-------------- ���뿪���ż�--28ȥ���⡿ ---------------
local tbTestTrap17	= tbTest:GetTrapClass("to_exit28")

function tbTestTrap17:OnPlayer()
	me.NewWorld(88,1909,3624)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ���뿪��Ѩ--19ȥ���⡿ ---------------
local tbTestTrap18	= tbTest:GetTrapClass("to_exit19")

function tbTestTrap18:OnPlayer()
	me.NewWorld(88,1853,3210)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;


-------------- ���뿪��Ӫ��--22ȥ���⡿ ---------------
local tbTestTrap19	= tbTest:GetTrapClass("to_exit22")

function tbTestTrap19:OnPlayer()
	me.NewWorld(88,1743,3351)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;


-------------- ���뿪����С��1--26ȥ���⡿ ---------------
local tbTestTrap20	= tbTest:GetTrapClass("to_exit26")

function tbTestTrap20:OnPlayer()
	me.NewWorld(88,1705,3484)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;


-------------- ���뿪����С��2--27ȥ���⡿ ---------------
local tbTestTrap21	= tbTest:GetTrapClass("to_exit27")

function tbTestTrap21:OnPlayer()
	me.NewWorld(88,1705,3484)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;


-------------- ������������ ---------------
local tbTestTrap22	= tbTest:GetTrapClass("to_exit14")

function tbTestTrap22:OnPlayer()
	me.NewWorld(88,1882,3831)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;
