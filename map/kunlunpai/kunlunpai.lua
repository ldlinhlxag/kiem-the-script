--������

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(12); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


tbTest:GetTrapClass("to_bingqipu").OnPlayer	= function (self)
	me.NewWorld(149,1605,3230)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_fangjupu").OnPlayer	= function (self)
	me.NewWorld(149,1728,3235)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_yaodian").OnPlayer	= function (self)
	me.NewWorld(149,1842,3230)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_zahuodian").OnPlayer	= function (self)
	me.NewWorld(149,1948,3229)	-- ����,[��ͼId,����X,����Y]	
end;
