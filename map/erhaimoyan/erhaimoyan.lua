-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(91); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ��ǰ����ĸǰ��--25�š�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_guimuqiandong")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(209,1886,3851);	-- ����,[��ͼId,����X,����Y]	
end;

-------------- ���ٹƶ�1�㡿---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_baiguzhen")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	   me.NewWorld(816,1562,3255);	-- ����,[��ͼId,����X,����Y]	
	   me.SetFightState(1);
	
end;

-------------- �����鶴��---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_lingdong")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()	
	   me.NewWorld(818,1618,3158);	-- ����,[��ͼId,����X,����Y]	
	   me.SetFightState(0);
	
end;
