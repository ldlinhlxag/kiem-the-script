-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(402); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("3ceng22ceng")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(401,1629,3220)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;