-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(29); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ��������---13��---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_zhaoruyu")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
local task_value = me.GetTask(1022,137)
	if (task_value == 1) then 
		me.NewWorld(485,1555,3119)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(0)
	else
		me.NewWorld(515,1555,3119)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(0)
	end		
end;


-------------- �������з���--14��---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_hantuozhou")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()
local task_value = me.GetTask(1022,153)
	if (task_value == 1) then 
		me.NewWorld(809,1555,3119)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1)
	else
		me.NewWorld(516,1555,3119)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1)
	end		
end;


-------------- ���Ը�ƫ�᡿---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_xiaoman")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()	
	me.NewWorld(517,1528,3125)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

-------------- ���շŷ���---16��---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_sufang")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()	
	me.NewWorld(522,1582,3213)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;



-------------- ��������---9��---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_lingyinsi")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()	
local task_value = me.GetTask(1024,38)
	if (task_value == 1) then 
		 TaskAct:Talk("<npc=949>:\"�ʺ��������Ҫ�����㻹Ը�������˵Ȳ������ڡ�\"")
	     return;
	else
		 me.NewWorld(524,1639,3246)	-- ����,[��ͼId,����X,����Y]	
		 me.SetFightState(1)
		return;
	end		
end;

-------------- ��֪��̨---10��---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_zhichuntai")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	me.NewWorld(478,1611,3224)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- �����丮ۡ---11��---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_zhuxifu")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()	
	local task_value = me.GetTask(1022,141)
	if (task_value == 1) then 
		me.NewWorld(487,1554,3119)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(0)
	elseif (task_value == 2) then
		me.NewWorld(805,1554,3119)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1)
	else
		me.NewWorld(479,1554,3119)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(0)
	end		
end;

-------------- ������긮ۡ---12��---------------
local tbTestTrap8	= tbTest:GetTrapClass("to_pengfu")

-- �������Trap�¼�
function tbTestTrap8:OnPlayer()	
	me.NewWorld(483,1527,3126)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;
-------------- ����������---11��---------------
local tbTestTrap9	= tbTest:GetTrapClass("to_mishi")

-- �������Trap�¼�
function tbTestTrap9:OnPlayer()	
	local task_value = me.GetTask(1022,152)
	if (task_value == 1) then 
		me.NewWorld(806,1625,3218)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(0)
	elseif (task_value == 2) then
		me.NewWorld(807,1625,3218)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(0)
	else
		return;
	end		
end;
----------------------------------------------------------------------

-------------- �����ʺ��޹���---------------
local tbTestTrap11	= tbTest:GetTrapClass("to_hanhuanghouqingong")

-- �������Trap�¼�
function tbTestTrap11:OnPlayer()	
	me.NewWorld(565,1580,3214)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

-------------- ����ů��---------------
local tbTestTrap12	= tbTest:GetTrapClass("to_yunuange")

-- �������Trap�¼�
function tbTestTrap12:OnPlayer()	
	me.NewWorld(566,1580, 3214)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

-------------- ����������---------------
local tbTestTrap13	= tbTest:GetTrapClass("to_jinyuexuan")

-- �������Trap�¼�
function tbTestTrap13:OnPlayer()	
	me.NewWorld(567, 1579, 3214)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

-------------- ���ʹ���---------------
local tbTestTrap14	= tbTest:GetTrapClass("to_huanggongdadian")

-- �������Trap�¼�
function tbTestTrap14:OnPlayer()	
	me.NewWorld(568,1578,3259)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;
