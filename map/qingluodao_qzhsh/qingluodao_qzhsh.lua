-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(404); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("qiuzhishui2qingluodao")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(55,1810,3487)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;