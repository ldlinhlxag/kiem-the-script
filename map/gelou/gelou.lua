-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(547); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪��¥��---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit547")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(546,1613,3177)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

