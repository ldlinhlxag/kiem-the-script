-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(122); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ������ɽ��---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_wanglongshan")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	   me.NewWorld(561,1483,2771);	-- ����,[��ͼId,����X,����Y]	
	   me.SetFightState(1);
	
end;

