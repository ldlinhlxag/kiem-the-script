-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(216); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)

end;

		
-------------- ���뿪��·���----28ȥ���⡿ ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit28")

function tbTestTrap1:OnPlayer()
		me.NewWorld(104,1793,3526)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);	
end;

-------------- ���뿪��ȱ����----14ȥ���⡿ ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit14")

function tbTestTrap2:OnPlayer()
		me.NewWorld(104,1927,3311)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);	
end;



-------------- ���뿪��ʹ����----20ȥ���⡿ ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit20")

function tbTestTrap3:OnPlayer()
		me.NewWorld(104,1612,3565)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1);
end;




-------------- ���뿪��ȱ����----15ȥ���⡿ ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit15")

function tbTestTrap4:OnPlayer()
		me.NewWorld(104,1927,3311)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1);
end;


-------------- ���뿪��ʯ����----26ȥ���⡿ ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit26")

function tbTestTrap5:OnPlayer()
		me.NewWorld(104,1895,3321)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1);
end;

