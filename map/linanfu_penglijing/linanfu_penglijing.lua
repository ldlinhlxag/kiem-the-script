-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(490); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �������޸�ۡ---1��---------------
local tbTestTrap	= tbTest:GetTrapClass("to_zhaoruyu")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(515,1555,3119)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;
