-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(113); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ��ȥһ��������---5�š�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_yidengshiweizhang")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(221,1602,3318)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ��ȥʯ��ԯ---21�š�---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_shixuanyuan")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()	
	me.NewWorld(221,1580,3847)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;


