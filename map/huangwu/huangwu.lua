-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(562); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪���ݡ�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit562")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	   me.NewWorld(561,1492,2782);	-- ����,[��ͼId,����X,����Y]	
	   me.SetFightState(1);
	
end;
