--��ţɽ��Ӫ
--90�����������̯

-------------- �����ض���ͼ�ص� ---------------
local tbMap = Map:GetClass(556); -- ��ͼId

-- ������ҽ����¼�
function tbMap:OnEnter()
	if me.nLevel < 90 then
		me.DisabledStall(1);
	end
end;

-- ��������뿪�¼�
function tbMap:OnLeave()
	me.DisabledStall(0);
end;

local tbMap2 = Map:GetClass(558); -- ��ͼId

-- ������ҽ����¼�
function tbMap2:OnEnter()
	if me.nLevel < 90 then
		me.DisabledStall(1);
	end
end;

-- ��������뿪�¼�
function tbMap2:OnLeave()
	me.DisabledStall(0);
end;

local tbMap3 = Map:GetClass(559); -- ��ͼId

-- ������ҽ����¼�
function tbMap3:OnEnter()
	if me.nLevel < 90 then
		me.DisabledStall(1);
	end
end;

-- ��������뿪�¼�
function tbMap3:OnLeave()
	me.DisabledStall(0);
end;
