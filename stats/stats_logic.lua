-- �ļ�������stats_logic.lua
-- �����ߡ���furuilei
-- ����ʱ�䣺2009-05-18 17:50:18
-- �����������������ʧ����ͳ�Ʒ���

if (MODULE_GAMECLIENT) then
	return;
end

-- ��¼û�е�½��Ϸ���������
function Stats:LogUnLoginTime(bIsExecute)
	if (bIsExecute == self.LOGINEXE) then
		if (me.nLastSaveTime == 0) then
			return;
		end
		local nUnLoginTime = math.floor(GetTime() / self.ONEDAYTIME - me.nLastSaveTime / self.ONEDAYTIME);
		if (nUnLoginTime > me.GetTask(self.TASK_GROUP, self.TASK_ID_UNLOGINTIME)) then
			me.SetTask(self.TASK_GROUP, self.TASK_ID_UNLOGINTIME, nUnLoginTime);
		end
	end
end

-- ��¼û�л�ȡ�������������������
function Stats:LogUnFetchReputeTime(bIsExecute)
	if (bIsExecute == self.LOGOUTEXE) then
		if (me.GetTask(self.TASK_GROUP, self.TASK_ID_LASTGETREPUTETIME) == 0) then
			return;
		end
		local nLastGetReputeTime = me.GetTask(self.TASK_GROUP, self.TASK_ID_LASTGETREPUTETIME);
		local nUnFetchReputeTime = math.floor(GetTime() / self.ONEDAYTIME - nLastGetReputeTime / self.ONEDAYTIME);
		if (nUnFetchReputeTime > me.GetTask(self.TASK_GROUP, self.TASK_ID_UNGETREPUTETIME)) then
			me.SetTask(self.TASK_GROUP, self.TASK_ID_UNGETREPUTETIME, nUnFetchReputeTime);
		end
	end
end

-- �ڻ�ȡ����������ʱ��ʵʱ�ش���
function Stats:UpdateGetReputeTime(pPlayer)
	local nLoginTime = pPlayer.GetTask(self.TASK_GROUP_LOGIN, self.TASK_ID_LOGINTIME);
	local nLastGetReputeTime = pPlayer.GetTask(self.TASK_GROUP, self.TASK_ID_LASTGETREPUTETIME);
	local nLastTimePoint = nLoginTime;
	if (nLastGetReputeTime > nLoginTime) then
		nLastTimePoint = nLastGetReputeTime;
	end
	local nDifTime = math.floor(GetTime() / self.ONEDAYTIME - nLastTimePoint / self.ONEDAYTIME);
	if (nDifTime > 0 and nDifTime > pPlayer.GetTask(self.TASK_GROUP, self.TASK_ID_UNGETREPUTETIME)) then
		pPlayer.SetTask(self.TASK_GROUP, self.TASK_ID_UNGETREPUTETIME, nDifTime);
	end
	
	pPlayer.SetTask(self.TASK_GROUP, self.TASK_ID_LASTGETREPUTETIME, GetTime());
end

-- �ﵽ������û��ʹ�ø���������������
function Stats:LogUnUseFuliJinghuoTime(bIsExecute)
	if (bIsExecute == self.LOGOUTEXE) then
		self:MarkPlayerType();
		local nPlayerType = me.GetTask(self.TASK_GROUP, self.TASK_ID_PLAYERTYPE);
		if (2 == nPlayerType) then
			if (me.GetTask(self.TASK_GROUP, self.TASK_ID_LASTGETFULITIME) == 0) then
				return;
			end
			local nLastGetFuliTime = me.GetTask(self.TASK_GROUP, self.TASK_ID_LASTGETFULITIME);
			local nUnUseFuliTime = math.floor(GetTime() / self.ONEDAYTIME - nLastGetFuliTime / self.ONEDAYTIME);
			local nMaxUnUseFuliTime = me.GetTask(self.TASK_GROUP, self.TASK_ID_UNUSEFULITIME);
			if (nUnUseFuliTime > nMaxUnUseFuliTime) then
				me.SetTask(self.TASK_GROUP, self.TASK_ID_UNUSEFULITIME, nUnUseFuliTime);
			end
		end
	end
end

-- �ڻ�ȡ���������ʱ��ʵʱ�ظ���
function Stats:UpdateGetFuliTime()
	local nLoginTime = me.GetTask(self.TASK_GROUP_LOGIN, self.TASK_ID_LOGINTIME);
	local nLastGetFuliTime = me.GetTask(self.TASK_GROUP, self.TASK_ID_LASTGETFULITIME);
	local nLastTimePoint = nLoginTime;
	if (nLastGetFuliTime > nLoginTime) then
		nLastTimePoint = nLastGetFuliTime;
	end
	local nDifTime = math.floor(GetTime() / self.ONEDAYTIME - nLastTimePoint /self.ONEDAYTIME);
	if (nDifTime > 0 and nDifTime > me.GetTask(self.TASK_GROUP, self.TASK_ID_UNUSEFULITIME)) then
		me.SetTask(self.TASK_GROUP, self.TASK_ID_UNUSEFULITIME, nDifTime);
	end
	
	me.SetTask(Stats.TASK_GROUP, self.TASK_ID_PLAYERTYPE, 3);
	me.SetTask(self.TASK_GROUP, self.TASK_ID_LASTGETFULITIME, GetTime());
end

function Stats:MarkPlayerType()
	local nPlayerType = 1;	-- Ĭ��Ϊû�дﵽ��ȡ�����ı�׼
	local tbBuyJinghuo = Player.tbBuyJingHuo;
	if (me.nLevel > tbBuyJinghuo.nLevelMax) then
		local nPrestige = tbBuyJinghuo:GetTodayPrestige();
		if (nPrestige > 0 and me.nPrestige >= nPrestige) then
			local nLastGetFuliTime = tonumber(os.date("%Y%m%d", me.GetTask(self.TASK_GROUP, self.TASK_ID_LASTGETFULITIME)));
			local nNowTime = tonumber(os.date("%Y%m%d", GetTime()));
			if (nLastGetFuliTime == nNowTime) then
				nPlayerType = 3;	-- �ﵽ��׼�����Ѿ���ȡ����
			else
				nPlayerType = 2;	-- �ﵽ��׼����û����ȡ����
			end
		end
	end
	me.SetTask(self.TASK_GROUP, self.TASK_ID_PLAYERTYPE, nPlayerType);
end

-- ��¼����ƽ������ʱ��һ����������
function Stats:LogHalfAvgTime(bIsExecute, bIsBelowHalfTime)
	if (not bIsBelowHalfTime or bIsBelowHalfTime ~= 1)then
		return;
	end
	local nBelowHalfAvgTime = self:GetTaskValue(self.TASK_ID_CURBELOWHALFTIME);
	local nMaxBelowHalfTime = me.GetTask(self.TASK_GROUP, self.TASK_ID_BELOWHALFTIME);
	if (nBelowHalfAvgTime > nMaxBelowHalfTime) then
		me.SetTask(self.TASK_GROUP, self.TASK_ID_BELOWHALFTIME, nBelowHalfAvgTime);
	end
end

-- ��¼����ʱ�䲻��4Сʱ���������
function Stats:LogBelow4HoursTime(bIsExecute, bIsBelow4HoursTime)
	if (not bIsBelow4HoursTime or bIsBelow4HoursTime ~= 1) then
		return;
	end
	local nBelow4HoursTime = self:GetTaskValue(self.TASK_ID_CURBELOW4HOURSTIME);
	local nMaxBelow4HoursTime = me.GetTask(self.TASK_GROUP, self.TASK_ID_BELOW4HOURSTIME);
	if (nBelow4HoursTime > nMaxBelow4HoursTime) then
		me.SetTask(self.TASK_GROUP, self.TASK_ID_BELOW4HOURSTIME, nBelow4HoursTime);
	end
end

-- ��¼��ҵĵ�������ʱ��
-- ������������ֵ���Ƿ񳬹�ƽ������ʱ���һ�룬�Ƿ񳬹�4Сʱ��
function Stats:RecordOnLineTime(bIsExecute)
	local nLastSaveTime  = tonumber(os.date("%Y%m%d", me.nLastSaveTime));
	local nNowTime = tonumber(os.date("%Y%m%d", GetTime()));
	local nHalfTime = self:CalcAvgTime() / 2;
	if (bIsExecute == self.LOGINEXE) then
		return self:ProcLoginOnlineTime(bIsExecute, nLastSaveTime, nNowTime, nHalfTime);
	elseif (bIsExecute == self.LOGOUTEXE) then
		return self:ProcLogoutOnlineTime(bIsExecute, nNowTime, nHalfTime);
	end
end

-- ���������¼ʱ������ʱ��
function Stats:ProcLoginOnlineTime(bIsExecute, nLastSaveTime, nNowTime, nHalfTime)
	local bIsBelowHalfTime = 0;
	local bIsBelow4Hours = 0;
	if (nLastSaveTime ~= nNowTime) then
		local nLastDayOnlineTime = me.GetTask(self.TASK_GROUP, self.TASK_ID_TODAYONLINETIME);
		self:SetTaskBitFlag(self.TASK_ID_CURBELOW4HOURSTIME, self.PLAYER_STATE_TODAY_NOTADD);
		self:SetTaskBitFlag(self.TASK_ID_CURBELOWHALFTIME, self.PLAYER_STATE_TODAY_NOTADD);
		me.SetTask(self.TASK_GROUP, self.TASK_ID_TODAYONLINETIME, 0);	-- ���ڷ����ı䣬�ѵ�������ʱ���������¼���
		bIsBelowHalfTime = self:AppHalfTimeStatus(bIsExecute, nLastDayOnlineTime, nHalfTime);
		bIsBelow4Hours = self:App4HourStatus(bIsExecute, nLastDayOnlineTime);
	end
	return bIsBelowHalfTime, bIsBelow4Hours;
end

-- ������������ʱ������ʱ��
function Stats:ProcLogoutOnlineTime(bIsExecute, nNowTime, nHalfTime)
	local bIsBelowHalfTime = 0;
	local bIsBelow4Hours = 0;
	local nLastLoginTime = me.GetTask(self.TASK_GROUP_LOGIN, self.TASK_ID_LOGINTIME);
	local nLoginTime = tonumber(os.date("%Y%m%d", nLastLoginTime));
	if (nLoginTime == nNowTime) then
		local nTodayOnlineTime = me.GetTask(self.TASK_GROUP, self.TASK_ID_TODAYONLINETIME) + (GetTime() - nLastLoginTime);
		me.SetTask(self.TASK_GROUP, self.TASK_ID_TODAYONLINETIME, nTodayOnlineTime);
		bIsBelowHalfTime = self:AppHalfTimeStatus(bIsExecute, nTodayOnlineTime, nHalfTime);
		bIsBelow4Hours = self:App4HourStatus(bIsExecute, nTodayOnlineTime);
	else
		-- ����ʱ���������
		local nZeroSec = Lib:GetDate2Time(nLoginTime) + self.ONEDAYTIME;	-- �������ʱ�����ʱ����¼ʱ���������24���Ӧ������
		local nTodayZeroSec = Lib:GetDate2Time(nNowTime);	-- �������ʱ�����ʱ������ʱ���������0���Ӧ������
		-- ��ҵ�½ʱ�������������ʱ��
		local nLastDayOnlineTime = me.GetTask(self.TASK_GROUP, self.TASK_ID_TODAYONLINETIME) + (nZeroSec - nLastLoginTime);
		local bIsCrossAbove1Day = 0;
		if ((nTodayZeroSec - nZeroSec) > self.ONEDAYTIME) then
			bIsCrossAbove1Day = 1;
		end
		
		
		me.SetTask(self.TASK_GROUP, self.TASK_ID_TODAYONLINETIME, GetTime() - nTodayZeroSec);
		self:Cross0Clock(nLastDayOnlineTime, self.TASK_ID_BELOW4HOURSTIME, bIsCrossAbove1Day);
		self:Cross0Clock(nLastDayOnlineTime, self.TASK_ID_BELOWHALFTIME, bIsCrossAbove1Day);
	end
	return bIsBelowHalfTime, bIsBelow4Hours;
end

-- �����������ʱ���������
function Stats:Cross0Clock(nLastDayOnlineTime, nTaskId, bIsCrossAbove1Day)
	local nTodayOnlineTime = me.GetTask(self.TASK_GROUP, self.TASK_ID_TODAYONLINETIME);
	local nHalfTime = self:CalcAvgTime() / 2;
	local nCmpTime = nHalfTime;
	local nCurTaskId = self.TASK_ID_CURBELOWHALFTIME;
	if (nTaskId == self.TASK_ID_BELOW4HOURSTIME) then
		nCmpTime = self.ONLINETIME;
		nCurTaskId = self.TASK_ID_CURBELOW4HOURSTIME;
	end
	if (nLastDayOnlineTime < nCmpTime) then
		if (self:GetTaskBitFlag(nCurTaskId) ~= self.PLAYER_STATE_TODAY_ADD) then
		 	local nTime = self:GetTaskValue(nCurTaskId) + 1;
			self:SetTaskBitFlag(nCurTaskId, self.PLAYER_STATE_TODAY_ADD);
			self:SetTaskValue(nCurTaskId, nTime);
		end
		if (nTaskId == self.TASK_ID_BELOWHALFTIME) then
			self:LogHalfAvgTime(self.LOGOUTEXE, 1);
		else
			self:LogBelow4HoursTime(self.LOGOUTEXE, 1);
		end
		
		if (bIsCrossAbove1Day == 1) then
			me.SetTask(self.TASK_GROUP, nCurTaskId, 0);
			self:SetTaskBitFlag(nCurTaskId, self.PLAYER_STATE_TODAY_NOTADD);
		end
		
		if (nTodayOnlineTime < nCmpTime) then
			local nCurTimes = self:GetTaskValue(nCurTaskId) + 1;
			self:SetTaskValue(nCurTaskId, nCurTimes);
			self:SetTaskBitFlag(nCurTaskId, self.PLAYER_STATE_TODAY_ADD);
		else
			me.SetTask(self.TASK_GROUP, nCurTaskId, 0);
			self:SetTaskBitFlag(nCurTaskId, self.PLAYER_STATE_TODAY_NOTADD);
		end
	else
		me.SetTask(self.TASK_GROUP, nCurTaskId, 0);
		self:SetTaskBitFlag(nCurTaskId, self.PLAYER_STATE_TODAY_NOTADD);
		if (nTodayOnlineTime < nCmpTime) then
			local nCurTimes = self:GetTaskValue(nCurTaskId) + 1;
			self:SetTaskValue(nCurTaskId, nCurTimes);
			self:SetTaskBitFlag(nCurTaskId, self.PLAYER_STATE_TODAY_ADD);
		end
	end
end

-- ������ҵ�һ��������ʱ���Ƿ񳬹�4Сʱ
function Stats:App4HourStatus(bIsExecute, nDayOnlineTime)
	local bIsBelow4Hours = 0;
	if (nDayOnlineTime <= self.ONLINETIME) then
		if (bIsExecute == self.LOGINEXE) then
			bIsBelow4Hours = 1;
		else
			if (self:GetTaskBitFlag(self.TASK_ID_CURBELOW4HOURSTIME) ~= self.PLAYER_STATE_TODAY_ADD) then
				local nCurBelow4HoursTime = self:GetTaskValue(self.TASK_ID_CURBELOW4HOURSTIME) + 1;
				self:SetTaskValue(self.TASK_ID_CURBELOW4HOURSTIME, nCurBelow4HoursTime);
				self:SetTaskBitFlag(self.TASK_ID_CURBELOW4HOURSTIME, self.PLAYER_STATE_TODAY_ADD);
			end
		end
	else
		me.SetTask(self.TASK_GROUP, self.TASK_ID_CURBELOW4HOURSTIME, 0);
		self:SetTaskBitFlag(self.TASK_ID_CURBELOW4HOURSTIME, self.PLAYER_STATE_TODAY_NOTADD);
	end
	return bIsBelow4Hours;
end

-- ������ҵ�һ��������ʱ���Ƿ����ƽ������ʱ���һ��
function Stats:AppHalfTimeStatus(bIsExecute, nDayOnlineTime, nHalfTime)
	local bIsBelowHalfTime = 0;
	if (nDayOnlineTime <= nHalfTime) then
		if (bIsExecute == self.LOGINEXE) then
			bIsBelowHalfTime = 1;
		else
			if (self:GetTaskBitFlag(self.TASK_ID_CURBELOWHALFTIME) ~= self.PLAYER_STATE_TODAY_ADD) then
				local nCurBelowHalfTime = self:GetTaskValue(self.TASK_ID_CURBELOWHALFTIME) + 1;
				self:SetTaskValue(self.TASK_ID_CURBELOWHALFTIME, nCurBelowHalfTime);
				self:SetTaskBitFlag(self.TASK_ID_CURBELOWHALFTIME, self.PLAYER_STATE_TODAY_ADD);
			end
		end
	else
		me.SetTask(self.TASK_GROUP, self.TASK_ID_CURBELOWHALFTIME, 0);
		self:SetTaskBitFlag(self.TASK_ID_CURBELOWHALFTIME, self.PLAYER_STATE_TODAY_NOTADD);
	end
	return bIsBelowHalfTime;
end

-- ������ҵ�ƽ������ʱ��
function Stats:CalcAvgTime()
	local nRoleCreateTime = Lib:GetDate2Time(me.GetRoleCreateDate());
	local nRoleExistDay = math.floor(GetTime() / self.ONEDAYTIME - nRoleCreateTime / self.ONEDAYTIME);
	if (nRoleExistDay == 0) then
		return me.nOnlineTime;
	else
		return math.floor(me.nOnlineTime / nRoleExistDay);
	end
end

-- �����ʼ��һ�ֵ�ͳ�ƵĻ����ѹ�ȥ��ͳ��ȫ�����㣬���¿�ʼͳ��
function Stats:Init()
	local nKey = me.GetTask(self.TASK_GROUP, self.TASK_ID_STATS_KEY);
	local nGlobleKey = KGblTask.SCGetDbTaskInt(DBTASK_STATS_KEY);
	if (nKey ~= nGlobleKey) then
		me.SetTask(self.TASK_GROUP, self.TASK_ID_STATS_KEY, nGlobleKey);
		for i = 2, self.COUNT_TASK_ID do
			me.SetTask(self.TASK_GROUP, i, 0);
		end
	end
end

function Stats:OnLogin(bExchangeServerComing)
	if (not bExchangeServerComing or 1 == bExchangeServerComing) then
		return;
	end
	
	self:Init();
	
	local bLoginExe = self.LOGINEXE;
	local bIsBelowHalfTime, bIsBelow4Hours = self:RecordOnLineTime(bLoginExe);
	self:LogUnLoginTime(bLoginExe);
	self:LogHalfAvgTime(bLoginExe, bIsBelowHalfTime);
	self:LogBelow4HoursTime(bLoginExe, bIsBelow4Hours);
end

function Stats:OnLogout(szReason)
	if (not szReason or "Logout" ~= szReason) then
		return;
	end
	
	local bLogoutExe = self.LOGOUTEXE;
	local bIsBelowHalfTime, bIsBelow4Hours = self:RecordOnLineTime(bLogoutExe);
	self:LogUnFetchReputeTime(bLogoutExe);
	self:LogUnUseFuliJinghuoTime(bLogoutExe);
	self:LogHalfAvgTime(bLogoutExe, bIsBelowHalfTime);
	self:LogBelow4HoursTime(bLogoutExe, bIsBelow4Hours);
end

-- ע��ͨ�������¼�
PlayerEvent:RegisterGlobal("OnLogin", Stats.OnLogin, Stats);

-- ע��ͨ�������¼�
PlayerEvent:RegisterGlobal("OnLogout", Stats.OnLogout, Stats);
