-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(805); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ���뿪���䷿�䡿---------------
local tbTestTrap	= tbTest:GetTrapClass("to_linanfu")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(29,1530,3956);	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

