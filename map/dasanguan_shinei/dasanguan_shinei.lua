-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(206); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ����ڣǰ������ʹ--1ȥ17����---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_jianzhongmishi")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(206,1575,3725)	-- ����,[��ͼId,����X,����Y]	
 	me.SetFightState(1);
 		
end;
		

-------------- ������ʹȥ��ȫ̩17--21�š� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_mishichukou")

function tbTestTrap2:OnPlayer()	
	me.NewWorld(206,1580,3847)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0);
 	
end;



-------------- ����ȫ̩���ӳ�ȥ��ڣ��--21�ų����⡿ ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_jianzhongwai")

function tbTestTrap3:OnPlayer()
	me.NewWorld(87,1916,3324)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
		
end;

-------------- ���뿪1ȥ���⡿ ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit1")

function tbTestTrap4:OnPlayer()
	me.NewWorld(87,1917,3323)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);

end;

-------------- ���뿪17ȥ1�� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit17")

function tbTestTrap5:OnPlayer()
	me.NewWorld(206,1597,3031)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;


-------------- ���뿪21ȥ17�� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_exit21")

function tbTestTrap6:OnPlayer()
	me.NewWorld(206,1586,3697)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);

	
end;
