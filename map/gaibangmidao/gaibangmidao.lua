-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(505); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪ؤ��ֶ�2ľ����--18ȥ���⡿ ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit505")

function tbTestTrap1:OnPlayer()
	me.NewWorld(88,1668,3795)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;


-------------- ���뿪ؤ��ֶ�2ľ����--18ȥ���⡿ ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_midaowai")

function tbTestTrap2:OnPlayer()
	me.NewWorld(88,1665,3799)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

