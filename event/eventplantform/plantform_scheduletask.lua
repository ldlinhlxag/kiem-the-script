--��������
--��������
--�����
--2008.09.18

if (not MODULE_GC_SERVER) then
	return 0;
end

Require("\\script\\event\\eventplantform\\plantform_def.lua")


-- ʱ��ϵͳ���趨������ÿ����Լ�ȥ����
-- ��̬ע�ᵽʱ������ϵͳ
function EPlatForm:RegisterScheduleTask()
	
	-- ʱ��ϵͳ�������Ƴ��������ɸ�δ֪��ϵͳ����
	
	local nTaskId = KScheduleTask.AddTask("�ƽ̨ʱ���Ὺ��", "EPlatForm", "ScheduleCallOut_TimerFrame");
	assert(nTaskId > 0);
	KScheduleTask.RegisterTimeTask(nTaskId, 0, 1);

	local tbCommon = self.CALEMDAR.tbCommon;
	local tbCommon_Adv = self.CALEMDAR.tbCommon_Adv;
	local tbAdvMatch = self.CALEMDAR.tbAdvMatch;
	
	local nRankSession	= EPlatForm:GetMacthSession();
	local tbMCfg		= EPlatForm:GetMacthTypeCfg(EPlatForm:GetMacthType(nRankSession));
	if (tbMCfg) then
		local tbCfg			= tbMCfg.tbMacthCfg;
		
		if (tbCfg and tbCfg.tbCommon and #tbCfg.tbCommon > 0) then
			tbCommon = tbCfg.tbCommon;
			self.CALEMDAR.tbCommon = tbCommon;
		end

		if (tbCfg and tbCfg.tbAdvMatch and #tbCfg.tbAdvMatch > 0) then
			tbAdvMatch = tbCfg.tbAdvMatch;
			self.CALEMDAR.tbAdvMatch = tbAdvMatch;
		end
		
		if (tbCfg and tbCfg.tbCommon_Adv and #tbCfg.tbCommon_Adv > 0) then
			tbCommon_Adv = tbCfg.tbCommon_Adv;
			self.CALEMDAR.tbCommon_Adv = tbCommon_Adv;
		end		
	end

	nTaskId = KScheduleTask.AddTask("�ƽ̨[�ճ�]", "EPlatForm", "ScheduleCallOut_Common");
	assert(nTaskId > 0);
	for nTaskSeriel, nTimeState in pairs(tbCommon) do
		KScheduleTask.RegisterTimeTask(nTaskId, nTimeState, nTaskSeriel);
	end
	
	nTaskId = KScheduleTask.AddTask("�ƽ̨�ڶ��׶�[�ճ�]", "EPlatForm", "ScheduleCallOut_Common_Adv");
	assert(nTaskId > 0);
	for nTaskSeriel, nTimeState in pairs(tbCommon_Adv) do
		KScheduleTask.RegisterTimeTask(nTaskId, nTimeState, nTaskSeriel);
	end
	
	nTaskId = KScheduleTask.AddTask("�ƽ̨[��ǿ]", "EPlatForm", "ScheduleCallOut_AdvMatch");
	assert(nTaskId > 0);
	KScheduleTask.RegisterTimeTask(nTaskId, tbAdvMatch[1], 1);	
end

--��ĩ
function EPlatForm:ScheduleCallOut_Weekend(nTaskId)
	local nWeek = tonumber(GetLocalDate("%w"));
	
	if (EPlatForm:GetMacthState() ~= EPlatForm.DEF_STATE_MATCH_1 or EPlatForm:GetMatchStateForDate() ~= EPlatForm.DEF_STATE_MATCH_1) then
		return;
	end
	
	if EPlatForm.CALEMDAR.tbWeekDay[nWeek] then
		self:ScheduleCallOut(nTaskId);
	end
end

--ƽʱ
function EPlatForm:ScheduleCallOut_Common(nTaskId)
	local nWeek = tonumber(GetLocalDate("%w"));

	if (EPlatForm:GetMacthState() ~= EPlatForm.DEF_STATE_MATCH_1 or EPlatForm:GetMatchStateForDate() ~= EPlatForm.DEF_STATE_MATCH_1) then
		return;
	end
	self:ScheduleCallOut(nTaskId);
end

--��ĩ�ڶ��׶�
function EPlatForm:ScheduleCallOut_Weekend_Adv(nTaskId)
	if (EPlatForm:GetMacthState() ~= EPlatForm.DEF_STATE_MATCH_2 or EPlatForm:GetMatchStateForDate() ~= EPlatForm.DEF_STATE_MATCH_2) then
		return;
	end	
	
	local nWeek = tonumber(GetLocalDate("%w"));
	if EPlatForm.CALEMDAR.tbWeekDay[nWeek] then
		self:ScheduleCallOut(nTaskId);
	end
end

--ƽʱ�ڶ��׶�
function EPlatForm:ScheduleCallOut_Common_Adv(nTaskId)
	if (EPlatForm:GetMacthState() ~= EPlatForm.DEF_STATE_MATCH_2 or EPlatForm:GetMatchStateForDate() ~= EPlatForm.DEF_STATE_MATCH_2) then
		return;
	end
	self:ScheduleCallOut(nTaskId);
end


--��ǿ��
function EPlatForm:ScheduleCallOut_AdvMatch(nTaskId)
	if (EPlatForm._TestCloseAutoOpen and EPlatForm._TestCloseAutoOpen == 1) then
		return 0;
	end	
	
	if EPlatForm:GetMacthType() <= 0 then
		return 0;
	end
	
	--������ڱ�����
	if EPlatForm:GetMacthState() ~= EPlatForm.DEF_STATE_ADVMATCH or EPlatForm:GetMatchStateForDate() ~= EPlatForm.DEF_STATE_ADVMATCH then
		return 0;
	end
	
	EPlatForm:Game8PkStart(1);
	
	return 0;
end

--������ǿ��
function EPlatForm:Game8PkStart(nTaskId)
	--������һ��������ʱ��
	if nTaskId <= EPlatForm.MACTH_TIME_ADVMATCH_MAX then
		Timer:Register(EPlatForm.MACTH_TIME_ADVMATCH,  self.Game8PkStart,  self, (nTaskId + 1));
	end
	
	if nTaskId > 0 and nTaskId <= EPlatForm.MACTH_TIME_ADVMATCH_MAX then
		EPlatForm:GamePkStart(nTaskId);
	end
	
	if nTaskId > EPlatForm.MACTH_TIME_ADVMATCH_MAX then
		EPlatForm:GameState4Into1();
	end
	return 0;
end

--ʱ���Ὺ����һ��
function EPlatForm:ScheduleCallOut_TimerFrame(nTaskId)
	
	if EPlatForm:GetTimeFrameState() ~= 1 then
		return;
	end
	
	--�������������Ъ��
	EPlatForm:GameState0Into1();
	
	--��Ъ�ڽ�������ڵ�һ�׶�
	if EPlatForm:GetMatchStateForDate() == EPlatForm.DEF_STATE_MATCH_1 then
		EPlatForm:GameState1Into2();
	end
	
	--��һ�׶ν���ڶ��׶�
	if EPlatForm:GetMatchStateForDate() == EPlatForm.DEF_STATE_MATCH_2 then
		EPlatForm:GameState2Into3();
	end	
	
	--�����ڽ����ǿ����
	if EPlatForm:GetMatchStateForDate() == EPlatForm.DEF_STATE_ADVMATCH then
		EPlatForm:GameState3Into4();
	end
	
	--��ǿ���ڽ������ս�����Ъ��
	if EPlatForm:GetMatchStateForDate() == EPlatForm.DEF_STATE_REST then
		EPlatForm:GameState4Into1();
	end
	
end

function EPlatForm:ScheduleCallOut(nTaskId)
	if (EPlatForm._TestCloseAutoOpen and EPlatForm._TestCloseAutoOpen == 1) then
		return 0;
	end	
	
	if EPlatForm:GetMacthType() <= 0 then
		return 0;
	end
	
	--������ڱ�����
	if (EPlatForm:GetMacthState() == EPlatForm.DEF_STATE_MATCH_1 and EPlatForm:GetMatchStateForDate() == EPlatForm.DEF_STATE_MATCH_1) or
	(EPlatForm:GetMacthState() == EPlatForm.DEF_STATE_MATCH_2 and EPlatForm:GetMatchStateForDate() == EPlatForm.DEF_STATE_MATCH_2) then
		EPlatForm:GamePkStart(0);
		return 1;
	end
	
	return 0;
end

function EPlatForm:GamePkStart(nTaskId)
	
	if (EPlatForm:GetMacthSession() <= 0) then
		return 0;
	end
	
	if (EPlatForm:GetMacthType() <= 0) then
		return 0;
	end
	
	if (EPlatForm:GetMacthState() == self.DEF_STATE_REST or EPlatForm:GetMacthState() == self.DEF_STATE_CLOSE) then
		return 0;
	end
	
	EPlatForm:InitGameDateGC(nTaskId);
	self.ReadyTimerId = Timer:Register(self.MACTH_TIME_READY,  self.OnGamePkStart,  self, nTaskId);
	GlobalExcute{"EPlatForm:GameStart", nTaskId};	
end

function EPlatForm:OnGamePkStart(nTaskId)
	--����pk����mission��
	self.ReadyTimerId = 0;
	GlobalExcute{"EPlatForm:GamePkStart", nTaskId};
	
	--ˢ�����а�.
	if nTaskId == 0 then
--		Timer:Register(EPlatForm.MACTH_TIME_UPDATA_RANK,  self.OnGameLeagueRank,  self);
	end
	return 0;
end

--��������
function EPlatForm:OnGameLeagueRank()
	EPlatForm:LeagueRank(0);
	return 0;
end

function EPlatForm:InitGameDateGC(nTaskId)
	if self.ReadyTimerId > 0 then
		if Timer:GetRestTime(self.ReadyTimerId) > 0 then
			Timer:Close(self.ReadyTimerId);
			self.ReadyTimerId = 0;
		end
	end	
	self.GroupList = {};
	self.GroupListTemp = {};
	KGblTask.SCSetDbTaskInt(EPlatForm.GTASK_MACTH_MAP_STATE, 0);
	if tonumber(nTaskId) then
		EPlatForm.AdvMatchState	= nTaskId;
	end
	GlobalExcute{"EPlatForm:InitDate", nTaskId};
end

GCEvent:RegisterGCServerStartFunc(EPlatForm.RegisterScheduleTask, EPlatForm);
GCEvent:RegisterGCServerStartFunc(EPlatForm.ScheduleCallOut_TimerFrame, EPlatForm);
