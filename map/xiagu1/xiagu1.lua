-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(549); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪Ͽ�ȡ�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit549")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(548,1600,3093)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

