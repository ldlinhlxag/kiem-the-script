-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(561); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ��������ݡ�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_huangwu")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	   me.NewWorld(562,1605,3210);	-- ����,[��ͼId,����X,����Y]	
	   me.SetFightState(1);
	
end;

-------------- ���������ҡ�---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_wangfumishi")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	   me.NewWorld(563,1591,3208);	-- ����,[��ͼId,����X,����Y]	
	   me.SetFightState(1);
	
end;


-------------- ��Į����ԭ��---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_mobeicaoyuan")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()	
	   me.NewWorld(122,1972,3503);	-- ����,[��ͼId,����X,����Y]	
	   me.SetFightState(1);
	
end;