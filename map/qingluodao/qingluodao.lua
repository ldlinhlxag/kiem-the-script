-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(55); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_zhuyingfang")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(198,1575,3725)	-- ����,[��ͼId,����X,����Y]	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_dilao")

function tbTestTrap2:OnPlayer()	
	me.NewWorld(198,1802,3864)	-- ����,[��ͼId,����X,����Y]
	--[[ local task_value = me.GetTask(1022,1)
	if (task_value == 1) then 
		me.NewWorld(198,1802,3864)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		return;
	end]]--	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_peiyifei")

function tbTestTrap3:OnPlayer()
	me.NewWorld(403,1603,3219)
	--[[ local task_value = me.GetTask(1022,2)
	if (task_value == 1) then 
		me.NewWorld(198,1578,3941)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		return;
	end	]]--		
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_qiuzhishui")

function tbTestTrap4:OnPlayer()
	me.NewWorld(404,1619,3220)
	--[[local task_value = me.GetTask(1022,3)
	if (task_value == 1) then 
		me.NewWorld(198,1669,3946)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(0);
		return;
	else
		return;
	end	]]--	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_shangrentouling")

function tbTestTrap5:OnPlayer()
	me.NewWorld(198,1886,3851)
	--[[local task_value = me.GetTask(1022,4)
	if (task_value == 1) then 
		me.NewWorld(198,1886,3851)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1);
		return;
	else
		return;
	end	]]--		
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_shenmixiaojing")

function tbTestTrap6:OnPlayer()
	local task_value = me.GetTask(1022,5)
	if (task_value == 1) then 
		return;
	else
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_xingying")

function tbTestTrap7:OnPlayer()

end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap8	= tbTest:GetTrapClass("to_xingtianling")

function tbTestTrap8:OnPlayer()
	local task_value = me.GetTask(1022,6)
	if (task_value == 1) then 
		return;
	else
		return;
	end	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;

