-- �ļ�������gamecode.lua
-- �����ߡ���FanZai
-- ����ʱ�䣺2008-06-27 11:54:33
-- �ļ�˵����ͨ��������֤�ͻ��˶Խű�ֵ�Ľ������жϿͻ����Ƿ�Ϊ�ѻ����
-- ע�������ύ���ͻ��ˣ�����

Player.emKGAMECODE_TYPE_Login		= 0;
Player.emKGAMECODE_TYPE_Ping		= 1;
Player.emKGAMECODE_TYPE_ActionLock	= 2;

Player.emKGAMECODE_TYPE_Count		= 3;

Player.tbErrorHistory	= Player.tbErrorHistory or {};

Player.tbGameCodeCase	= {
	[Player.emKGAMECODE_TYPE_Login]	= {	-- ����ʱ�ļ��
		fnClient	= [[
			return function()	-- �ͻ��˼������
				local s="tt"..string.lower(me.szAccount);
				return string.byte(s,#s-1) * 45678 + string.byte(s,#s) * 56789 * 213 - #s*110;
			end]],
		fnServer	= nil,			-- ����˼�����룬Ĭ����ͻ���һ��
	},
	[Player.emKGAMECODE_TYPE_Ping]	= {
		fnClient	= [[
			return function()
				return me.nBindCoin*321+me.nTotalMoney+123;
			end]],
		fnServer	= nil,
	},
	[Player.emKGAMECODE_TYPE_ActionLock]	= {
		fnClient	= [[
			return function()	-- �ͻ��˼������
				return me.nId+me.nLevel*123;
			end]],
		fnServer	= nil,
	},
};


-- �յ��ͻ��˷��ص�����
function Player:OnRetGameCode(nType, nValue, bOk)
	local tbPlayerGameCodeTable		= self:GetPlayerGameCodeTable();
	local nNeedValue	= tbPlayerGameCodeTable[nType];
	self:DbgOut("OnRetGameCode", nType, nValue, bOk, me.szName, nNeedValue);
	tbPlayerGameCodeTable[nType]	= nil;
	if (bOk ~= 1 or nValue ~= nNeedValue) then
		local bQuiteSure	= 1;
		if (not nNeedValue) then	-- �����û��nNeedValue�������ǿ����ԭ���¿ͻ���Э�鷢���ˣ�
			bQuiteSure	= 0;
		elseif (math.abs(nValue - nNeedValue) < 100) then	-- ���ֻ��������������ֵ���
			bQuiteSure	= 0;
		end
		self:CheckError(bQuiteSure, string.format("Ret:%d,%d Ok:%d Need:%s", nType, nValue, bOk, tostring(nNeedValue)));
	else
		self.tbAntiBot:OnSaveRoleScore(me.szAccount, me.szName, "gamecode", false);	--û�г���
	end
end

-- ���غ��ʵı��ʽ���ͻ��˼���
function Player:GetSendGameCode(nType)
	local tbCase	= self.tbGameCodeCase[nType];
	local fnServer	= loadstring(tbCase.fnServer or tbCase.fnClient, "")();
	local nValue	= KLib.Number2Int(fnServer());
	self:DbgOut("GetSendGameCode", nType, me.szName, nValue);
	local tbPlayerGameCodeTable		= self:GetPlayerGameCodeTable();
	assert(not tbPlayerGameCodeTable[nType]);	-- �ظ����ã�
	tbPlayerGameCodeTable[nType]	= nValue;
	return string.dump(loadstring(tbCase.fnClient, "")());
end

-- ������©����֤����
function Player:OnLostGameCode(nType)
	local tbPlayerGameCodeTable		= self:GetPlayerGameCodeTable();
	local nValue	= tbPlayerGameCodeTable[nType] or 0;
	self:CheckError(1, string.format("Lost:%d,%d", nType, nValue));
end

-- ���ִ����쳣����
function Player:CheckError(bQuiteSure, szMsg)
	local szError		= (bQuiteSure == 1 and "CheckGameCodeError") or "CheckGameCodeWarning"
	local tbErrorInfo	= self.tbErrorHistory[me.nId];
	if (not tbErrorInfo) then
		tbErrorInfo	= {
			szName		= me.szName,
			szAccount	= me.szAccount,
			nErrorTimes	= 0,
			nWarnTimes	= 0,
		};
		self.tbErrorHistory[me.nId]	= tbErrorInfo;
	end
	if (bQuiteSure == 1) then
		self.tbAntiBot:OnSaveRoleScore(me.szAccount, me.szName, "gamecode", true);		--����
		tbErrorInfo.nErrorTimes	= tbErrorInfo.nErrorTimes + 1;
	else
		tbErrorInfo.nWarnTimes	= tbErrorInfo.nWarnTimes + 1;
	end
	tbErrorInfo.szIp		= me.GetPlayerIpAddress();
	tbErrorInfo.nLevel		= me.nLevel;
	tbErrorInfo.nLastTime	= GetTime();
	self:WriteLog(Dbg.LOG_WARNING, szError, me.szName, szMsg);
end

-- ���ִ����쳣����
function Player:ClearCheckHistory(nTimeSec)
	if (not nTimeSec) then	-- ȫ��
		self.tbErrorHistory	= {};
		return;
	end

	local nClearTime	= GetTime() - nTimeSec;	-- ��ʱ����ǰ����
	for nId, tbErrorInfo in pairs(self.tbErrorHistory) do
		if (tbErrorInfo.nLastTime <= nClearTime) then
			tbErrorHistory[nId]	= nil;
		end
	end
end

-- �õ�����������
function Player:GetPlayerGameCodeTable()
	local tbPlayerTable	= self:GetPlayerTempTable(me);
	local tbPlayerGameCodeTable	= tbPlayerTable.tbPlayerGameCodeTable;
	if (not tbPlayerGameCodeTable) then
		tbPlayerGameCodeTable	= {};
		tbPlayerTable.tbPlayerGameCodeTable	= tbPlayerGameCodeTable;
	end
	return tbPlayerGameCodeTable;
end

-- ���
function Player:ShowCheckHistory(szFlag)
	local szFlag	= szFlag or GetLocalDate("Cat%m%d");
	print(szFlag..":	RoleName	Account	IpAddress:Port	Level	Error	Warning	LastTime");
	for nId, tbErrorInfo in pairs(Player.tbErrorHistory) do
		if (tbErrorInfo.nErrorTimes > 0) then
			print(string.format("%s:	%s	%s	%s	%d	%d	%d	%s", szFlag,
				tbErrorInfo.szName, tbErrorInfo.szAccount, tbErrorInfo.szIp,
				tbErrorInfo.nLevel, tbErrorInfo.nErrorTimes, tbErrorInfo.nWarnTimes,
				os.date("%m-%d %H:%M:%S", tbErrorInfo.nLastTime)));
		end
	end
end
