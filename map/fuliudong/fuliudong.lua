-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(129); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ����Ů����---------------
local tbTestTrap	= tbTest:GetTrapClass("to_luonvdong")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(814,1603,3224)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)	
end;
