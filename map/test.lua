-- Map �����ӼӲ���
-- ��ӭɾ����

local tbTest = Map:GetClass(835);

-------------- �����ض���ͼ�ص� ---------------
-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	print("EnterTestMap:", me.szName);
	me.Msg("EnterTestMap");
	self:CallParam(szParam, 1);	-- ͨ�ÿ���
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	print("LeaveTestMap:", me.szName);
	me.Msg("LeaveTestMap");
	self:CallParam(szParam, 0);	-- ͨ�ÿ���
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("fighttrap1")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	print("OnPlayerTestTrap:", me.szName, me.GetMapId(), self.szName);
	me.Msg("OnPlayerTestTrap:"..self.szName);
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	print("OnNpcTestTrap:", him.szName, me.GetMapId(), self.szName);
end;

