-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(534); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪��Ժ��---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit534")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(98,1826,3260)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)  
end;
