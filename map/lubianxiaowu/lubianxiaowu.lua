-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(539); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


-------------- ���뿪·��С�ݡ� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit539")

function tbTestTrap3:OnPlayer()
		me.NewWorld(104,1612,3565)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1);
end;

