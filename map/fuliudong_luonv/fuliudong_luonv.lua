-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(814); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ����������---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_fuliudong")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(129,1880,3225)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)	
end;