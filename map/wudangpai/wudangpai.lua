--�䵱��

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(14); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


tbTest:GetTrapClass("to_bingqipu").OnPlayer	= function (self)
	me.NewWorld(151,1605,3230)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_fangjupu").OnPlayer	= function (self)
	me.NewWorld(151,1728,3235)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_yaodian").OnPlayer	= function (self)
	me.NewWorld(151,1842,3230)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_zahuodian").OnPlayer	= function (self)
	me.NewWorld(151,1948,3229)	-- ����,[��ͼId,����X,����Y]	
end;



-------------- ���ֿ�--16�š� ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_cangku")

function tbTestTrap1:OnPlayer()	
	
local task_value = me.GetTask(1024,4)
	if (task_value == 1) then 
	  	me.NewWorld(151,1946,3654)	-- ����,[��ͼId,����X,����Y]	
   		me.SetFightState(1);
		return;
	else
		return;
	end		
end;

