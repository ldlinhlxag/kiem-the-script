-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(536); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)

end;


-------------- ���뿪���ر�Ժ�� ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit536")

function tbTestTrap1:OnPlayer()
		me.NewWorld(104,1895,3321)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1);
end;

