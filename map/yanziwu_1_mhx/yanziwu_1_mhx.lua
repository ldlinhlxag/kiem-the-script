-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(407); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("menghu2huweipo")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(60,1420,2712)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;
