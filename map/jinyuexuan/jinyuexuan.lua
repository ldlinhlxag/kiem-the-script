-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(567); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪��������---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_exit567")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	me.NewWorld(29,1731,3849)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

