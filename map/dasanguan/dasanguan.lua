-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(87); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ��ǧ����---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_jianzhong")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(513,1578,3242)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

