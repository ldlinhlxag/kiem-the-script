-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(813); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ���¼�����---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_suoyunyuan")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(128,1844,3451)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)	
end;