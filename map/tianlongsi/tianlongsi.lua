-- �����µĽű���ͼ

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(112); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ������ ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_dariluo")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(554,1604,3187)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;


-------------- ����ׯ ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_shangxianzhuang")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()
	me.NewWorld(555,1554,3119)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;




