--���̽�

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(10); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;


tbTest:GetTrapClass("to_bingqipu").OnPlayer	= function (self)
	me.NewWorld(147,1605,3230)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_fangjupu").OnPlayer	= function (self)
	me.NewWorld(147,1728,3235)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_yaodian").OnPlayer	= function (self)
	me.NewWorld(147,1842,3230)	-- ����,[��ͼId,����X,����Y]	
end;

tbTest:GetTrapClass("to_zahuodian").OnPlayer	= function (self)
	me.NewWorld(147,1948,3229)	-- ����,[��ͼId,����X,����Y]	
end;

-- ����Npc Trap�¼�
tbTest:GetTrapClass("digong_yunzhongzhen").OnNpc	= function (self)
	him.AI_ClearPath();
	him.AI_AddMovePos(51424, 109664);
	him.SetNpcAI(9, 0, 1,-1, 0, 0, 0, 0, 0, 0, 0);
end;

tbTest:GetTrapClass("digong_bianjingfu").OnNpc	= function (self)
	him.AI_ClearPath();
	him.AI_AddMovePos(52608, 111776);
	him.SetNpcAI(9, 0, 1,-1, 0, 0, 0, 0, 0, 0, 0);
end;

tbTest:GetTrapClass("digong_tianrenjiaojindi").OnNpc	= function (self)
	him.AI_ClearPath();
	him.AI_AddMovePos(56000, 104832);
	him.SetNpcAI(9, 0, 1,-1, 0, 0, 0, 0, 0, 0, 0);
end;

tbTest:GetTrapClass("digong_liangshanpo").OnNpc	= function (self)
	him.AI_ClearPath();
	him.AI_AddMovePos(58112, 118752);
	him.SetNpcAI(9, 0, 1,-1, 0, 0, 0, 0, 0, 0, 0);	
end;
