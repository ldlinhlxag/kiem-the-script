-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(802); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_wuyishan")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(120,1704,3280);	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_shutong")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	me.NewWorld(803,1625,3218);	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(0);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_liniang")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	me.NewWorld(804,1528,3126);	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(0);	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_mudi")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()
	me.NewWorld(808,1594,3193);	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(0);	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

