-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(94); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ������������--527�� ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_liangxianglin")

function tbTestTrap1:OnPlayer()	
	
	me.NewWorld(527,1600,3237)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);	
end;



-------------- ��³��--526�� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_lubing")

function tbTestTrap2:OnPlayer()	
	
	me.NewWorld(526,1617,3217)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0);	
end;



-------------- ���ķ�---525�� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_dufang")

function tbTestTrap3:OnPlayer()	
	
	me.NewWorld(525,1611,3224)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);	
end;

