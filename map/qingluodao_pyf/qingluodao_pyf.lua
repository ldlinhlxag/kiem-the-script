-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(403); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("peiyifei2qingluodao")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(55,1833,3477)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;