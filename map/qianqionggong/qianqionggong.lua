-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(513); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪ǧ���� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit513")

function tbTestTrap4:OnPlayer()
	me.NewWorld(87,1917,3323)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);

end;

-------------- ��ȥ�����졿 ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_tianwaitian")

function tbTestTrap5:OnPlayer()
	me.NewWorld(514,1611,3226)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0);
end;


-------------- ���뿪21ȥ17�� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_exit21")

function tbTestTrap6:OnPlayer()
	me.NewWorld(206,1586,3697)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);

	
end;
