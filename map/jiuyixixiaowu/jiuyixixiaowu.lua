-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(541); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪Ǯ���ϡ� ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit541")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()
	me.NewWorld(106,1606,3604)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;
