-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(817); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���ٹƶ�1�㡿---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_1ceng")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	   me.NewWorld(816,1602,3090);	-- ����,[��ͼId,����X,����Y]	
	   me.SetFightState(1);
	
end;
