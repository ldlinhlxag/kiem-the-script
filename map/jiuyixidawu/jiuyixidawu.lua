-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(542); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪���ܷ��ζ���-�� ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit542")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()
	me.NewWorld(106,1627,3608)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;
