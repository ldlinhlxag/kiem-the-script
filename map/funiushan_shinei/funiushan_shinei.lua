-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(211); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪��Ԫ�Է���---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit7")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(95,1850,3377)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ���뿪���á� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit6")

function tbTestTrap2:OnPlayer()	
	me.NewWorld(95,1818,3824)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;
