-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(529); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ���뿪���á� ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit529")

function tbTestTrap1:OnPlayer()	
	me.NewWorld(95,1818,3824)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;
