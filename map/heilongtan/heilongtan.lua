-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(530); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪����̶��---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit530")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(99,1373,2669)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;
