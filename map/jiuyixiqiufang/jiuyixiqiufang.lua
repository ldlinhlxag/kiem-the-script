-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(540); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ҷ�ȥ����--21ȥ���⡿ ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_exit540")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(106,1612,3572)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

