-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(517); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪С�����䡿---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit517")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()	
	me.NewWorld(29,1430,3964)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

