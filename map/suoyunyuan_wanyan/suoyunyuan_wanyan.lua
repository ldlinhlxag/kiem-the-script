-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(812); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����չ⡿---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_suoyunyuan")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(128,1857,3448)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)	
end;
