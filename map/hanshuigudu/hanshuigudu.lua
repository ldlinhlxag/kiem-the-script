-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(88); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ��ؤ��ֶ桿---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_gaibangfenduo1")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(504,1605,3189)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ��ɽ���� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_shanshenmiao")
function tbTestTrap2:OnPlayer()
  
local task_value = me.GetTask(1024,37)
	if (task_value == 1) then 
     	 me.NewWorld(506,1618,3158)	-- ����,[��ͼId,����X,����Y]	
		 me.SetFightState(0)
	     return;
    elseif (task_value == 2) then
		 me.NewWorld(507,1618,3158)	-- ����,[��ͼId,����X,����Y]	
		 me.SetFightState(0)
		 return;
	else
			return;
	end		
end;

-------------- ��ؤ���ص���--------
local tbTestTrap3	= tbTest:GetTrapClass("to_gaibangfenduo3")

function tbTestTrap3:OnPlayer()	
	me.NewWorld(505,1590,3208)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- �������� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_yusoujia")

function tbTestTrap4:OnPlayer()
	me.NewWorld(503,1607,3208)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ��ɽ���� ---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_zeixue")

function tbTestTrap5:OnPlayer()
	me.NewWorld(508,1613,3237)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ����Ӫ�ڲ��� ---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_junyingneibu")

function tbTestTrap6:OnPlayer()
	
	me.NewWorld(509,1633,3239)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;


-------------- ��������é�ݡ� ---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_kouruixiaowu")

function tbTestTrap7:OnPlayer()
  
local task_value = me.GetTask(1024,1)
	if (task_value == 1) then 
     	 me.NewWorld(502,1610,3217)	-- ����,[��ͼId,����X,����Y]	
		 me.SetFightState(1)
	     return;
    elseif (task_value == 2) then
		 me.NewWorld(501,1610,3217)	-- ����,[��ͼId,����X,����Y]	
		 me.SetFightState(0)
		 return;
	else
			return;
	end		
end;
