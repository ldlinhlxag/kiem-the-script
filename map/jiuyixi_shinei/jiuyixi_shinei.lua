-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(217); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ҷ�ȥ����--21ȥ���⡿ ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_exit21")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(106,1609,3568)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ���뿪Ǯ����--26ȥ���⡿ ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit26")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	me.NewWorld(106,1609,3600)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ���뿪���ܷ��ζ���--29ȥ���⡿ ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit29")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	me.NewWorld(106,1623,3603)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ���뿪�����ֶ�¦һ��--27ȥ���⡿ ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit27")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()
	me.NewWorld(106,1781,3419)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;




