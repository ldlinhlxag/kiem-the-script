-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(210); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ������������--9�š� ---------------
local tbTestTrap1= tbTest:GetTrapClass("to_exit9")

function tbTestTrap1:OnPlayer()	
	me.NewWorld(94,1739,3829)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- ���ķ�����--8�š� ---------------
local tbTestTrap2= tbTest:GetTrapClass("to_exit8")

function tbTestTrap2:OnPlayer()	
	me.NewWorld(94,1926,3260)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;


-------------- ��³��--29�š� ---------------
local tbTestTrap3= tbTest:GetTrapClass("to_exit29")

function tbTestTrap3:OnPlayer()	
	me.NewWorld(94,1872,3488)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;
