-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(510); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪��������--27ȥ���⡿---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit510")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(90,1700,3545)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1)	
	
end;
