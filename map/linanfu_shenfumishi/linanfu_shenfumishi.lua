-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(489); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ���뿪�����ҡ�---------------
local tbTestTrap	= tbTest:GetTrapClass("to_linanfu")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(488,1774,3881);	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

