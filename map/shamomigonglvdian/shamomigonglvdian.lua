-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(543); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ���뿪�õ�---29�š�---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit543")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	me.NewWorld(101,1809,3678)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1)	
end;


