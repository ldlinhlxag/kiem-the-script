-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(518); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;



-------------- ���뿪�Դ����䡿---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_exit518")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()	
	me.NewWorld(29,1491,3761)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;
