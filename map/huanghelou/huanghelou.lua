-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(109); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ������¥��---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_juyilou")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(546,1612,3223)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

