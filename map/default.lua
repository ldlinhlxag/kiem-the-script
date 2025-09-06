-- MapĬ��ģ�壨Ҳ�ǻ���ģ�壩

local tbMapBase	= Map.tbMapBase;

tbMapBase.tbTraps		= nil;	-- Trap�����

-- ���ݲ�����ִ�м�麯��
function tbMapBase:CallParam(tbSwitchExec, bIn)
	for _, fnCallBack in pairs(tbSwitchExec) do
		 Lib:CallBack({fnCallBack, Map.tbSwitchs, bIn});
	end
end

-- ��ҽ����ͼ״̬(����״̬��,����������)
function tbMapBase:OnEnterState(tbSwitchExec)
	self:CallParam(tbSwitchExec, 1);	-- ͨ�ÿ���
end

-- ��̬ע������ͼ�¼�
function tbMapBase:RegisterMapEnterFun(szKey, fnExcute, ...)
	if not self.tbEnterMapFun then
		self.tbEnterMapFun = {};	-- ��ҽ����ͼ�¼�������
	end
	self.tbEnterMapFun[szKey] = {fnProcess = fnExcute, tbParam = arg};
end

-- ��ע��
function tbMapBase:UnregisterMapEnterFun(szKey)
	if (not self.tbEnterMapFun or not self.tbEnterMapFun[szKey] )then
		return 0;
	end
	self.tbEnterMapFun[szKey] = nil;
end

-- ִ�н����ͼ�¼�
function tbMapBase:ExcuteEnterFun()
	if not self.tbEnterMapFun then
		return 0;
	end
	for _, tbExcute in pairs(self.tbEnterMapFun) do
		tbExcute.fnProcess(unpack(tbExcute.tbParam));
	end
end

-- ��̬ע���뿪��ͼ�¼�
function tbMapBase:RegisterMapLeaveFun(szKey, fnExcute, ...)
	if not self.tbLeaveMapFun then
		self.tbLeaveMapFun = {};	-- ��ҽ����ͼ�¼�������
	end
	self.tbLeaveMapFun[szKey] = {fnProcess = fnExcute, tbParam = arg};
end

-- ��ע��
function tbMapBase:UnregisterMapLeaveFun(szKey)
	if (not self.tbLeaveMapFun or not self.tbLeaveMapFun[szKey] )then
		return 0;
	end
	self.tbLeaveMapFun[szKey] = nil;
end

-- ִ�н����ͼ�¼�
function tbMapBase:ExcuteLeaveFun()
	if not self.tbLeaveMapFun then
		return 0;
	end
	for _, tbExcute in pairs(self.tbLeaveMapFun) do
		tbExcute.fnProcess(unpack(tbExcute.tbParam));
	end
end

--���忪��������¼�
function tbMapBase:OnEnterConsole()
end

-- ������ҽ����¼�Onloginǰ����
function tbMapBase:OnEnter()
end

-- ������ҽ����¼�Onlogin�����
function tbMapBase:OnEnter2()
end

-- 
function tbMapBase:OnLeaveState(tbSwitchExec)
	self:CallParam(tbSwitchExec, 0);	-- ͨ�ÿ���
end

function tbMapBase:OnDyLoad(nDynMapId)
end

--���忪�����뿪�¼�
function tbMapBase:OnLeaveConsole()
end

-- ��������뿪�¼�
function tbMapBase:OnLeave()
end

-- ��ȡ��ǰ��ͼ��ָ��Trap��
function tbMapBase:GetTrapClass(szClassName, bNotCreate)
	if (not self.tbTraps) then
		self.tbTraps	= {};
	end
	local tbTrap	= self.tbTraps[szClassName];
	-- ���û��bNotCreate�����Ҳ���ָ��ģ��ʱ���Զ�������ģ��
	if (not tbTrap and bNotCreate ~= 1) then
		-- ��ģ��ӻ���ģ������
		tbTrap	= Lib:NewClass(Map.tbTrapBase);
		tbTrap.szName	= szClassName;
		tbTrap.tbMap	= self;
		-- ���뵽ģ�������
		self.tbTraps[szClassName]	= tbTrap;
	end
	return tbTrap;
end

-- ��������ͼ�κ�Trap��
function tbMapBase:OnPlayerTrap(szClassName)
	self:GetTrapClass(szClassName):OnPlayer();
end
function tbMapBase:OnNpcTrap(szClassName)
	self:GetTrapClass(szClassName):OnNpc();
end

local tbTrapBase	= Map.tbTrapBase;

-- �������Trap�¼�
function tbTrapBase:OnPlayer()
	local tbToPos	= self.tbMap.tbTransmit[self.szName];
	Map:DbgOut("OnPlayerTrap:", me.szName, self.tbMap.nMapId, self.szName, tbToPos);
	if (tbToPos) then
		-- ���ڵ��߼���Ҫ��NewWorld��SetFightState
		local nRet, szMsg = Map:CheckTagServerPlayerCount(tbToPos[1]);
		if nRet ~= 1 then
			me.Msg(szMsg);
			return 0;
		end
		me.NewWorld(tbToPos[1], tbToPos[2], tbToPos[3]);
		if (tbToPos[4] ~= "") then
			me.SetFightState(tonumber(tbToPos[4]));
		end
		
		-- ����ĳЩ��ͼ��Ҫ����5����
		if (tbToPos[5] and tbToPos[5] > 0) then
			Player:AddProtectedState(me, 5);
		else
			Player:AddProtectedState(me, 0);
		end
	end
end

-- ����Npc Trap�¼�
function tbTrapBase:OnNpc()
	Map:DbgOut("OnNpcTrap:", him.szName, self.tbMap.nMapId, self.szName);
end

