-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(514); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ����ڣǰ������ʹ--1ȥ17����---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit514")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(513,1619,3093)	-- ����,[��ͼId,����X,����Y]	
 	me.SetFightState(1);
 		
end;
		
