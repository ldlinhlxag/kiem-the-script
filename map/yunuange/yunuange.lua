-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(566); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪��ů��---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_exit566")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	me.NewWorld(29,1740,3820)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

