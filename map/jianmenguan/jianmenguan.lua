-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(111); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ����ʯ�ȡ�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_xiaoshigu")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(545,1703,3291)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

