-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(516); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ���뿪�����С�---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit516")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	me.NewWorld(29,1415,3964)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

