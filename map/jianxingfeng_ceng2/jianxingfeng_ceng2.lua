-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(429); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("2ceng2jianxingfeng")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(48,1789,3293)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("zhongxin2bianyuan")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
	me.NewWorld(429,1641,3138)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("bianyuan2zhongxin")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	me.NewWorld(429,1608,3201)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;


-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

