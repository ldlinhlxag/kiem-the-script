-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(478); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ���뿪�շŷ��䡿---------------
local tbTestTrap	= tbTest:GetTrapClass("zhichuntai2linanfu")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(29,1659,3868)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

