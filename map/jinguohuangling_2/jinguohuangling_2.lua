-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(67); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_gongshentai")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_ninglizhou")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()

end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_tianxingdian")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	me.NewWorld(452,1527,3126);
	--[[local task_value = me.GetTask(1022,75)
	if (task_value == 1) then 
		me.NewWorld(203,1619,3220)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);	
		return;
	else
		return;
	end	]]--		
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_weichangfeng")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()

end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_wusajusuo")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()
	me.NewWorld(451,1619,3220);
	--[[local task_value = me.GetTask(1022,74)
	if (task_value == 1) then 
		me.NewWorld(203,1577,3849)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);	
		return;
	else
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_yelvchou")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	

end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_zhongchengdian")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()
	me.NewWorld(453,1555,3120)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(0);
	return;
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;
