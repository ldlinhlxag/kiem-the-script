-- ���������ڵĽű���ͼ

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(555); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �뿪 ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_exit555")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(112,1721,3785)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1)  	
end;
