-- ����������


-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(153); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


tbTest:GetTrapClass("to_exit1").OnPlayer	= function (self)
	me.NewWorld(16,1732,3298)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_exit2").OnPlayer	= function (self)
	me.NewWorld(16,1751,3320)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_exit3").OnPlayer	= function (self)
	me.NewWorld(16,1835,3411)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_exit4").OnPlayer	= function (self)
	me.NewWorld(16,1851,3426)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_exit_south").OnPlayer	= function (self)
	me.NewWorld(51,1780,3126)	-- ����,[��ͼId,����X,����Y]	
end;
