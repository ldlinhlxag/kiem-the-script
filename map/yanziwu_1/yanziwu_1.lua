-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(60); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("to_baishan1")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_baishan2")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()

end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_cangyunxuan")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()
	me.NewWorld(410,1606,3209);
	--[[local task_value = me.GetTask(1022,16)
	if (task_value == 1) then 	
		me.NewWorld(200,1580,3847)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		TaskAct:Talk("�����������Ի������������");
		return;
	end	]]--		
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_dishuidong")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()
	me.NewWorld(409,1609,3455);
	--[[local task_value = me.GetTask(1022,17)
	if (task_value == 1) then 	
		me.NewWorld(200,1809,3449)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		TaskAct:Talk("���صĶ��ڣ����ǲ�Ҫ��ȥΪ�á�");
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_fengyan")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()

end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_houdao")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	me.NewWorld(408,1609,3455);
	--[[local task_value = me.GetTask(1022,18)
	if (task_value == 1) then 	
		me.NewWorld(200,1698,3453)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		TaskAct:Talk("���صĶ��ڣ����ǲ�Ҫ��ȥΪ�á�");
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_huweipo")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()
	--[[local task_value = me.GetTask(1022,14)
	if (task_value == 1) then 	
		return;
	else
		TaskAct:Talk("������ؤ���ɽʯ�������������鲻�����ڡ�");
		me.NewWorld(60,1448,2801)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap8	= tbTest:GetTrapClass("to_liugui")

-- �������Trap�¼�
function tbTestTrap8:OnPlayer()
	me.NewWorld(411,1605,3190);
	--[[local task_value = me.GetTask(1022,19)
	if (task_value == 1) then 	
		me.NewWorld(200,1729,3858)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		TaskAct:Talk("������Ժ���������");
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap9	= tbTest:GetTrapClass("to_menghuxiang1")

-- �������Trap�¼�
function tbTestTrap9:OnPlayer()
	me.NewWorld(407,1560,3257);
	--[[local task_value = me.GetTask(1022,15)
	if (task_value == 1) then 	
		me.NewWorld(407,1585,3456)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		TaskAct:Talk("�ͻ������գ������򲻵��ѻ��ǲ�ȥΪ��");
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap10	= tbTest:GetTrapClass("to_tingtaoge")

-- �������Trap�¼�
function tbTestTrap10:OnPlayer()
	local task_value = me.GetTask(1022,20)
	if (task_value == 1) then 	
		return;
	else
		TaskAct:Talk("�˵�Ϊؤ��Ӵ���������������˵Ȳ������ڡ�");
		me.NewWorld(60,1473,3131)	-- ����,[��ͼId,����X,����Y]
		return;
	end	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap11	= tbTest:GetTrapClass("to_waizhong")
	
-- �������Trap�¼�
function tbTestTrap11:OnPlayer()
	me.NewWorld(405,1589,3205);
	--[[local task_value = me.GetTask(1022,21)
	if (task_value == 1) then 	
		me.NewWorld(200,1602,3318)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
		TaskAct:Talk("�������ڼ䣬������Ӣ��ڣ�뵽ִ�����Ӵ��Ǽǡ�");
		return;
	end	]]--	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap12	= tbTest:GetTrapClass("to_xiaojing")

-- �������Trap�¼�
function tbTestTrap12:OnPlayer()

end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap13	= tbTest:GetTrapClass("to_yingsunjiao")

-- �������Trap�¼�
function tbTestTrap13:OnPlayer()
	me.NewWorld(406,1638,3064);
	--[[local task_value = me.GetTask(1022,22)
	if (task_value == 1) then 	
		me.NewWorld(200,1722,3306)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);
		return;
	else
		return;
	end	]]--
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap13	= tbTest:GetTrapClass("to_jingyueyan")

-- �������Trap�¼�
function tbTestTrap13:OnPlayer()
	me.NewWorld(200,1889,3448)	-- ����,[��ͼId,����X,����Y]	
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;
