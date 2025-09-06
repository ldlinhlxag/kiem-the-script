-- �ļ�������console_global.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-04-23 17:59:30
-- ��  ��  ��

--�����µ���
function Console:New(nDegree)
	Console:NewBase(nDegree);
	return Console:GetBase(nDegree);
end

function Console:NewBase(nDegree)
	Console.tbConsole = Console.tbConsole or {};
	Console.tbConsole[nDegree] = Lib:NewClass(self.Base);
	Console.tbConsole[nDegree].nDegree 	= nDegree;
end

function Console:GetBase(nDegree)
	return Console.tbConsole[nDegree];
end

--�Ƿ�����
function Console:IsFull(nDegree, nPlayerCount)
	local tbBase = self:GetBase(nDegree);
	return tbBase:IsFull(nPlayerCount)
end

--����׼������������
function Console:JoinGroupList(nDegree, nMapId, tbPlayerList)
	local tbBase = self:GetBase(nDegree);
	tbBase:JoinGroupList(nMapId, tbPlayerList);
end

--�뿪׼����
function Console:LeaveGroupList(nDegree, nMapId, nId)
	local tbBase = self:GetBase(nDegree);
	tbBase:LeaveGroupList(nMapId, nId);
end
