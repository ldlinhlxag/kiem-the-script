-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(221); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪һ��������---5�š�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit5")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(113,1553,3301)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;




-------------- ���뿪ʯ��ԯ---21�š�---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_exit21")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()	
	me.NewWorld(113,1352,3189)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

