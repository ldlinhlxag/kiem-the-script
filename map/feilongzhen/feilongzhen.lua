-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(512); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪������---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit512")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(511,1645,3195)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(0)	
	
end;
