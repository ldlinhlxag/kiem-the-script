-- ���������ڵĽű���ͼ

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(554); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �뿪 ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_exit554")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(112,1891,3641)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1)  	
end;
