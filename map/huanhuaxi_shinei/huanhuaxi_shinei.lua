-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(208); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪��������--27ȥ���⡿---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit27")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(90,1700,3545)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1)	
	
end;

-------------- ���뿪���¹�--8ȥ���⡿ ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit8")

function tbTestTrap2:OnPlayer()	
	me.NewWorld(90,1902,3160)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- �����¹�ȥľ����--8ȥ9�� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_murenzhen")

function tbTestTrap3:OnPlayer()

	me.NewWorld(208,1698,3453)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1)	
	
end;
	

-------------- ��ľ�������--9ȥ8�� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_murenzhenchukou")

function tbTestTrap4:OnPlayer()
	
	me.NewWorld(208,1628,3449)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0);
	
end;
	
