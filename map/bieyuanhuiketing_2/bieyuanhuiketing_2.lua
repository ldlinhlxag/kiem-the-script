-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(538); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;



-------------- ���뿪��Ժ�����2�� ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit538")

function tbTestTrap1:OnPlayer()
		me.NewWorld(104,1927,3311)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1);
end;


