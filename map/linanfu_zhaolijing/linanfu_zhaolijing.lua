-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(491); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����丮ۡ---1��---------------
local tbTestTrap	= tbTest:GetTrapClass("to_zhuxifu")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(487,1554,3119)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;