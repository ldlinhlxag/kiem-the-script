-- ����������


-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(146); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


tbTest:GetTrapClass("to_exit1").OnPlayer	= function (self)
	me.NewWorld(9,1732,3298)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_exit2").OnPlayer	= function (self)
	me.NewWorld(9,1751,3320)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_exit3").OnPlayer	= function (self)
	me.NewWorld(9,1835,3411)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_exit4").OnPlayer	= function (self)
	me.NewWorld(9,1851,3426)	-- ����,[��ͼId,����X,����Y]	
end;

-------------- ���뿪֪�ͷ�--16�š� ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit16")

function tbTestTrap1:OnPlayer()	
	
		local task_value = me.GetTask(1024,6)
	if (task_value == 1) then 
	  me.NewWorld(9,1832,3070)	-- ����,[��ͼId,����X,����Y]	
    me.SetFightState(0);
		return;
	else
		return;
	end		
end;
