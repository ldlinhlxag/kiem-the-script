-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(568); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪�ʹ���---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_exit568")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()		
	me.NewWorld(29,1489,3761)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;


local tbTrap7 = tbTest:GetTrapClass("to_huanggongyushufang");

function tbTrap7:OnPlayer()
	me.NewWorld(564, 1554, 3119)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

