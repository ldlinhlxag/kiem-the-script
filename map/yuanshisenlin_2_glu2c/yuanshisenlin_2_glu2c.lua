-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(415); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("ceng22ceng1")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(414,1704,3299)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);		
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("ceng22jintou")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	if (me.nSex == 1) then
    		me.NewWorld(417,1594,3193)	-- ����,[��ͼId,����X,����Y]
    		me.SetFightState(1);
	else
    		me.NewWorld(416,1594,3193)	-- ����,[��ͼId,����X,����Y]
    		me.SetFightState(1);
	end
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

