
if (not PlayerEvent.tbGlobalEvent) then
	PlayerEvent.tbGlobalEvent	= {};
end

-- ע���ض�����¼��ص�
function PlayerEvent:Register(szEvent, varCallBack, varSelfParam)
	local tbPlayerData	= me.GetTempTable("PlayerEvent");
	local tbPlayerEvent	= tbPlayerData.tbPlayerEvent;
	if (not tbPlayerEvent) then
		tbPlayerEvent	= {};
		tbPlayerData.tbPlayerEvent	= tbPlayerEvent;
	end;
	local tbEvent	= tbPlayerEvent[szEvent];
	if (not tbEvent) then
		tbEvent	= {};
		tbPlayerEvent[szEvent]	= tbEvent;
	end;
	local nRegisterId	= #tbEvent + 1;
	tbEvent[nRegisterId]= {varCallBack, varSelfParam};
	return nRegisterId;
end;

-- ע���ض�����¼��ص�
function PlayerEvent:UnRegister(szEvent, nRegisterId)
	local tbPlayerEvent	= me.GetTempTable("PlayerEvent").tbPlayerEvent;
	if (not tbPlayerEvent) then
		return;
	end;
	local tbEvent	= tbPlayerEvent[szEvent];
	if (not tbEvent or not tbEvent[nRegisterId]) then
		return;
	end
	tbEvent[nRegisterId]	= nil;
	return 1;
end;

-- ע��ȫ������¼��ص�
function PlayerEvent:RegisterGlobal(szEvent, varCallBack, varSelfParam)
	local tbEvent	= self.tbGlobalEvent[szEvent];
	if (not tbEvent) then
		tbEvent	= {};
		self.tbGlobalEvent[szEvent]	= tbEvent;
	end;
	local nRegisterId	= #tbEvent + 1;
	tbEvent[nRegisterId]= {varCallBack, varSelfParam};
	return nRegisterId;
end;

-- ע��ȫ������¼��ص�
function PlayerEvent:UnRegisterGlobal(szEvent, nRegisterId)
	local tbEvent	= self.tbGlobalEvent[szEvent];
	if (not tbEvent or not tbEvent[nRegisterId]) then
		return;
	end;
	tbEvent[nRegisterId]	= nil;
	return 1;
end;

-- ��ϵͳ���ã�ĳ�¼�����
function PlayerEvent:OnEvent(szEvent, ...)
	-- �ȼ��ȫ��ע��ص�
	self:_CallBack(self.tbGlobalEvent[szEvent], arg);
	
	-- Ȼ���鱾���ע��ص�
	local tbPlayerEvent	= me.GetTempTable("PlayerEvent").tbPlayerEvent;
	if (not tbPlayerEvent) then
		return;
	end;
	self:_CallBack(tbPlayerEvent[szEvent], arg);
end;

function PlayerEvent:_CallBack(tbEvent, tbArg)
	if (not tbEvent) then
		return;
	end
	--Ϊ�˷�ֹѭ���г�����ע�ᵼ�³�������Copy��ʽ
	for nRegisterId, tbCallFunc in pairs(Lib:CopyTB1(tbEvent)) do
		if (tbEvent[nRegisterId]) then	-- ����Ƿ�δ��ɾ��
			local varCallBack	= tbCallFunc[1];
			local varSelfParam	= tbCallFunc[2];
			local tbCallBack	= nil;
			if (varSelfParam) then
				tbCallBack	= {varCallBack, varSelfParam, unpack(tbArg)};
			else
				tbCallBack	= {varCallBack, unpack(tbArg)};
			end
			Lib:CallBack(tbCallBack);
		end
	end
end


function PlayerEvent:OnLoginDelay(nStep)
	-- TODO: FanZai	��Ϊע��ʽ�����Կ���ʹ�ýű�ʵ���ӳ١�
	-- ִ�е�½����
	if self.tbLoginFun then
		for i, tbLogin in pairs(self.tbLoginFun) do
			if tbLogin.fun then
				tbLogin.fun(unpack(tbLogin.tbParam));
			end
		end
	end	
	
	-- �ж��Ƿ񶳽ᣬ������
	Player:OnLogin_CheckFreeze()
	return 1;	-- ����1��ʾ����
end

--ע����ҵ�½��ִ���¼�
function PlayerEvent:RegisterOnLoginEvent(fnStartFun, ...)
	if not self.tbLoginFun then
		self.tbLoginFun = {}
	end
	local nRegisterId = #self.tbLoginFun + 1;
	self.tbLoginFun[nRegisterId]  = {fun=fnStartFun, tbParam=arg};	
	return nRegisterId;
end

--ע����ҵ�½��ִ���¼�
function PlayerEvent:UnRegisterOnLoginEvent(nRegisterId)
	if not self.tbLoginFun or not self.tbLoginFun[nRegisterId] then
		return;
	end
	self.tbLoginFun[nRegisterId] = nil;
	return 1;
end

-- �¼���ɫ�����Ĭ�Ϸ��õ���Ʒ
local tbShortCutItem = {	
	{nGenre = 19, nDetail = 3, nParticular = 1, nLevel = 1, nSeries = 0},
	{nGenre = 17, nDetail = 1, nParticular = 1, nLevel = 1, nSeries = 0},
	{nGenre = 17, nDetail = 2, nParticular = 1, nLevel = 1, nSeries = 0},
};

local SHORTCUT_TASK_GROUP	= 3;		-- ���������������
local SHORTCUT_FLAG_TASK	= 21;		-- ���ͱ�־���������

local SHORT_CUT_VALUE = 
{
	{0,0,0},{0,0,0},{0,0,0}
};

	local nFlags = 0;
for nPosition = 1,3 do
	local tbObj = tbShortCutItem[nPosition];
	nFlags = Lib:SetBits(nFlags, 1, nPosition * 3 - 3, nPosition * 3 -1);
	local nLow  = Lib:SetBits(tbObj.nGenre, tbObj.nDetail, 16, 31);
	local nHigh = Lib:SetBits(tbObj.nParticular, tbObj.nLevel, 16, 23);
	nHigh = Lib:SetBits(nHigh, tbObj.nSeries, 24, 31);
	SHORT_CUT_VALUE[nPosition][1] = nFlags;
	SHORT_CUT_VALUE[nPosition][2] = nLow;
	SHORT_CUT_VALUE[nPosition][3] = nHigh;
end

-- �½���ɫ�״ε�¼
function PlayerEvent:OnFirstLogin()
	--���ÿ����ǰ����
	for i = 1,3 do
		me.SetTask(SHORTCUT_TASK_GROUP, SHORTCUT_FLAG_TASK, SHORT_CUT_VALUE[i][1]);
		me.SetTask(SHORTCUT_TASK_GROUP, i * 2 - 1, SHORT_CUT_VALUE[i][2]);
		me.SetTask(SHORTCUT_TASK_GROUP, i * 2, SHORT_CUT_VALUE[i][3]);
	end
	
	--�����½���ɫ����
	for i = 1, 9 do
		me.AddFightSkill(i, 1);
	end
	me.AddFightSkill(281, 1);
	me.AddItem(20,1,800,1);
	me.AddItem(18,1,351,1);
	SpecialEvent.NewPlayerGift:GiveGift();
end

PlayerEvent.tbProtocolRule = 
{
	--[89] = {szMsg = "���棡��ʹ�õ��ߵ�Ƶ��̫�ߣ�"},
	--[169] = {szMsg = "���Ĳ���漰Υ����Ϊ������ʹ�ÿ��ܻᱻǿ���������������ʺţ�"},
}

function PlayerEvent:OnTooManyProtocol(nProtocol)
	if self.tbProtocolRule[nProtocol] and self.tbProtocolRule[nProtocol].szMsg then
		me.Msg(self.tbProtocolRule[nProtocol].szMsg);
	end
end
