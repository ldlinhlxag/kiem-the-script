-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(102); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ��ȥ����---21�š�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_jiayin")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(215,1580,3847)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;
