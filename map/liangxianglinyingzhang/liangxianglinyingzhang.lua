-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(527); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����������ӡ� ---------------
local tbTestTrap1= tbTest:GetTrapClass("to_exit527")

function tbTestTrap1:OnPlayer()	
	me.NewWorld(94,1739,3829)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- ������528�� ---------------
local tbTestTrap2= tbTest:GetTrapClass("to_mishi")

function tbTestTrap2:OnPlayer()	
	me.NewWorld(528,1632,3239)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;
