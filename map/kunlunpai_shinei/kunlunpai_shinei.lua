-- ����������


-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(149); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


tbTest:GetTrapClass("to_exit1").OnPlayer	= function (self)
	me.NewWorld(12,1732,3298)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_exit2").OnPlayer	= function (self)
	me.NewWorld(12,1751,3320)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_exit3").OnPlayer	= function (self)
	me.NewWorld(12,1835,3411)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_exit4").OnPlayer	= function (self)
	me.NewWorld(12,1851,3426)	-- ����,[��ͼId,����X,����Y]	
end;
