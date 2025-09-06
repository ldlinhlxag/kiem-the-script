-- �ļ�������test.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-05-15 17:54:02
-- ��  ��  ��������
-- ����ɲο�����д��\script\mission\dragonboat\console.lua


local DEF_TEST = 0;
local Test = Console:New(DEF_TEST);

GM.testConcole	= Test;

--GC����
function Test:InitGame()
	self.tbCfg ={
		--[׼����Id] = {tbInPos={����׼�����ĵ�},tbOutPos={�뿪׼�������ĵ�ͼ�͵�}}; û��tbOutPosΪĬ�ϱ����������ִ峵��������͵�
		tbMap 		= {[1]={tbInPos={1450, 3110},tbOutPos={1, 1450,3110}}}; 	
		nDynamicMap	= 2;						--��̬��ͼģ��Id
		nMaxDynamic = 1;				 		--��������̬��ͼ��������;
		nMaxPlayer  = 20;						--ÿ��׼������������;
		nReadyTime	= 60*18;					--׼����ʱ��(��);
	};
	
end
--Test:InitGame();

--GC��������
function Test:OnStartGame()
	self:StartSignUp()
end

--GS���������ص�
function Test:OnMySignUp()
	print("StartSignUp");
end

--GC
function GM.testConcole:OnStart()
	GlobalExcute{"GM.testConcole:Start"};
	self:Start()
end

--GS��ұ����볡��
function GM.testConcole:SignUp()
	Console:ApplySignUp(DEF_TEST, {me.nId});
end


--�������غ�
function Test:OnJoin()
	print("OnJoin", me.szName)
end

--�뿪����غ�
function Test:OnLeave()
	print("OnLeave", me.szName)
end

--����׼������
function Test:OnJoinWaitMap()
	print("OnJoinWaitMap", me.szName)
end

--�뿪׼������
function Test:OnLeaveWaitMap()
	print("OnLeaveWaitMap", me.szName)
end

--�����߼�
--tbCfg = {tbGroupLists={{PlayerId1,...},...}, nDyMapIndex = 1}
--6��һ�飻
function Test:GroupLogic(tbCfg)
	local nGroupDivide  = 0;
	for nGroup, tbGroup in ipairs(tbCfg.tbGroupLists) do
		for _, nPlayerId in pairs(tbGroup) do
			local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
			--���󣬷��䶯̬��ͼ��������ţ�
			if pPlayer then
				self:OnDyJoin(pPlayer, tbCfg.nDyMapIndex, nGroup);
				nGroupDivide = nGroupDivide + 1;
			end
		end
		if nGroupDivide >= 6 then
			nGroupDivide = 0;
			tbCfg.nDyMapIndex = tbCfg.nDyMapIndex + 1;
		end
	end
	print("GroupLogic");
end

--��ʼ�����
function Test:OnMyStart(tbCfg)
	print("OnMyStart")
	local nWaitMapId	= tbCfg.nWaitMapId;		--׼����Id
	local nDyMapId 	 	= tbCfg.nDyMapId;		--���Id
	local tbGroupLists 	= tbCfg.tbGroupLists;	--�����б�
	print(nWaitMapId, nDyMapId, tbGroupLists);
end
