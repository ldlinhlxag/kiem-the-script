-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(816); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���ٹƶ�2�㡿---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_2ceng")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	   me.NewWorld(817,1603,3225);	-- ����,[��ͼId,����X,����Y]	
	   me.SetFightState(1);
	
end;

-------------- ������Ħ�ҡ�---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_erhaimoyan")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	   me.NewWorld(91,1841,3238);	-- ����,[��ͼId,����X,����Y]	
	   me.SetFightState(1);
	
end;