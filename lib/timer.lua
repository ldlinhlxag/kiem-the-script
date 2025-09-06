-- �ļ�������timer.lua
-- �����ߡ���FanZai
-- ����ʱ�䣺2007-10-08 22:09:05
-- �ļ�˵������ʱ��ϵͳ


-- ������������

if (not Timer.tbTimeTable) then
	-- ע��	��ϵͳ��ʹ�õ�uActiveTime������GC�ϱ�ʾ���룬GS��Client�ϱ�ʾ������
	--		��ϵͳ�Ķ���ӿڱ���һ�£�ʹ��������
	-- ʱ�̱�[uActiveTime] = {nRegisterId1, nRegisterId2, ...}
	Timer.tbTimeTable	= {};
	-- ע���[nRegisterId] = {uActiveTime=.., nIdx=.., tbCallBack=..}
	Timer.tbRegister	= {};
	
	if (not Timer.nHaveUsedTimerId) then
		Timer.nHaveUsedTimerId = 0;
	end;
	Timer.tbAttach	= {};
end

-- �ɳ������ע���������Ҫʱ����
function Timer:OnActive(uCurrentTime)
	local tbTime		= self.tbTimeTable[uCurrentTime];
	if (not tbTime) then
		return;
	end
	
	-- ����һ��table���ڴ���ڱ��ε����о����رյ�Timer
	self.tbToBeClose	= {};

	local oldme = me;
	local oldhim = him;
	-- ���ﲻ�����µ�Timerע���ڵ�ǰ֡�����Բ�����tbTime
	for nIdx, nRegisterId in pairs(tbTime) do
		if (not self.tbToBeClose[nRegisterId]) then	-- û�д���رմ�Timer
			local tbEvent		= self.tbRegister[nRegisterId];
			local tbGRoleArg	= tbEvent.tbGRoleArg;
			me = tbGRoleArg.pPlayer;
			him = tbGRoleArg.pNpc;
			
			local tbCallBack	= tbEvent.tbCallBack;
			local bOK, nRet		= Lib:CallBack(tbCallBack);	-- ���ûص�
			
			Dbg:Output("Timer", "OnTimer", nRegisterId, bOK, nRet);	-- ֪ͨ����ģ�飬OnTimer�������
			if (not bOK) then		-- ����ʧ�ܣ��رմ�Timer
				nRet	= 0;
				print("[ERROR]OnTimer", tbEvent.szRegInfo)
			elseif (not nRet) then	-- �޷���ֵ�����ʱ����ٴε���
				nRet	= tbEvent.nWaitTime;
			end
			if (nRet <= 0) then	-- ����0���رմ�Timer
				self.tbToBeClose[nRegisterId]	= 1;
			else	-- ��Ҫ�ٴδ�����Event��ʱ����ΪnRet
				local uNewTime	= RegisterTimerPoint(nRet);	-- ע�Ტ�õ��µĴ���ʱ��
				tbEvent.nWaitTime	= nRet;
				tbEvent.uActiveTime	= uNewTime;
				local tbNewTime		= self.tbTimeTable[uNewTime];
				if (not tbNewTime) then	-- ��ʱ������ע��
					self.tbTimeTable[uNewTime]	= {nRegisterId};
					tbEvent.nIdx				= 1;
				else	-- ��ʱ������ע��
					tbEvent.nIdx			= #tbNewTime + 1;
					tbNewTime[tbEvent.nIdx]	= nRegisterId;
				end
			end
		end
	end

	me = oldme;
	him = oldhim;
	
	-- ���ۻ�������Ҫ�رյ�Timerȫ���ر�
	for nRegisterId in pairs(self.tbToBeClose) do
		local tbEvent	= self.tbRegister[nRegisterId];
		local oldme = me;
		local oldhim = him;
		me = tbEvent.tbGRoleArg.pPlayer;
		him = tbEvent.tbGRoleArg.pNpc;
		self.tbRegister[nRegisterId]	= nil;
		if (tbEvent.uActiveTime ~= uCurrentTime) then
			self.tbTimeTable[tbEvent.uActiveTime][tbEvent.nIdx]	= nil;
		end
		if (tbEvent.OnDestroy) then	-- ��Ҫ֪ͨ����
			tbEvent:OnDestroy(nRegisterId);
		end
		
		--�������˵���
		Lib:CallBack({"Timer:_DebugMerchant", nRegisterId});
		
		me = oldme;
		him = oldhim;
	end
	
	self.tbTimeTable[uCurrentTime]	= nil;
	self.tbToBeClose				= nil;
end

--ע����Timer��
--	������nWaitTime�������ڿ�ʼ��������, fnCallBack, varParam1, varParam2, ...
--	���أ�nRegisterId
function Timer:Register(nWaitTime, ...)
	local tbEvent	= {
		nWaitTime	= nWaitTime,
		tbCallBack	= arg,
		szRegInfo	= debug.traceback("Register Timer", 2),
	};
	return self:RegisterEx(tbEvent);
end

-- ע����Timer�����װ�
function Timer:RegisterEx(tbEvent)
	assert(tbEvent.nWaitTime > 0);
	tbEvent.tbGRoleArg	= { pPlayer = me, pNpc = him };
	tbEvent.uActiveTime	= RegisterTimerPoint(tbEvent.nWaitTime)	-- ע�Ტ�õ��µĴ���ʱ��
	Timer.nHaveUsedTimerId = Timer.nHaveUsedTimerId + 1; 
	local nRegisterId	= Timer.nHaveUsedTimerId;
	self.tbRegister[nRegisterId] = tbEvent;
	local tbNewTime	= self.tbTimeTable[tbEvent.uActiveTime];
	if (not tbNewTime) then	-- ��ʱ������ע��
		self.tbTimeTable[tbEvent.uActiveTime] = {nRegisterId};
		tbEvent.nIdx 			= 1;
	else	-- ��ʱ������ע��
		tbEvent.nIdx			= #tbNewTime + 1;
		tbNewTime[tbEvent.nIdx]	= nRegisterId;
	end
	Dbg:PrintEvent("Timer", "Register", nRegisterId, tbEvent.nWaitTime);	-- ֪ͨ����ģ�飬ע����Timer
	return nRegisterId;
end

--�ر�Timer
function Timer:Close(nRegisterId)
	Dbg:PrintEvent("Timer", "Close", nRegisterId);	-- ֪ͨ����ģ�飬�ر�Timer
	
	if (self.tbAttach[nRegisterId]) then
		print("Close Timer Error:", debug.traceback());
	end;
	
	local tbEvent	= self.tbRegister[nRegisterId];
	if not tbEvent then
		print("CloseTimerWarring", debug.traceback());
		return;
	end
	local oldme = me;
	local oldhim = him;
	me 	= tbEvent.tbGRoleArg.pPlayer;
	him = tbEvent.tbGRoleArg.pNpc;
	if (self.tbToBeClose) then	-- ���ڵ���Timer������ֱ�ӹر�
		self.tbToBeClose[nRegisterId]	= 1;
	else
		self.tbTimeTable[tbEvent.uActiveTime][tbEvent.nIdx] = nil;
		self.tbRegister[nRegisterId] = nil;
		if (tbEvent.OnDestroy) then	-- ��Ҫ֪ͨ����
			tbEvent:OnDestroy(nRegisterId);
		end
	end
	
	--�������˵���
	Lib:CallBack({"Timer:_DebugMerchant", nRegisterId});
			
	me = oldme;
	him = oldhim;
end

--�쿴ָ����Timerʣ������崥��
function Timer:GetRestTime(nRegisterId)
	local tbEvent	= self.tbRegister[nRegisterId];
	if (not tbEvent) then
		return -1;
	else
		if (MODULE_GC_SERVER) then
			local nRestTime	= tbEvent.uActiveTime - GCGetCurElapse();
			if (nRestTime < 0) then	-- ����ʱ���п��ܳ��ָ���������һ�£���Ҫ�������
				nRestTime	= 0;
			end
			-- ���ﻹû������Dev�޷�ʹ��Env.GAME_FPS����
			return math.floor(nRestTime * 18 / 1000)
		else
			return tbEvent.uActiveTime - GetFrame();
		end
	end
end

--�쿴ָ����Timer������ʱʱ��
function Timer:GetWaitTime(nRegisterId)
	local tbEvent	= self.tbRegister[nRegisterId];
	if (not tbEvent) then
		return -1;
	else
		return tbEvent.nWaitTime;
	end
end

--�������˵���
function Timer:_DebugMerchant(nRegisterId)
	if Npc._tbDebugFreeAITimer and Npc._tbDebugFreeAITimer[nRegisterId] then
		local nNpcId = Npc._tbDebugFreeAITimer[nRegisterId];
		Npc._tbDebugFreeAITimer[nRegisterId]	= nil;
		Npc._tbDebugFreeAITimer2[nNpcId] 		= nil;
		print(debug.traceback("Timer Error: Merchant Error Close!!!"));
	end	
end

do return end
---------------- �����Ƿ��� ----------------

function SomeEvent:OnTimer()	-- ʱ�䵽������ô˺���
	if (XXX) then
		-- ������������ʾҪ���ִ�Timer���ȴ�123����ٴε���
		return 123;
	elseif (YYY) then
		-- ����0����ʾҪ�رմ�Timer
		return 0;
	else
		-- ����nil����ʾ�ȴ�ʱ�����ϴ���ͬ
		return;
	end
end

function SomeEvent:Begin()
	-- ������ʱ������¼nRegisterId
	self.nRegisterId	= Timer:Register(1, self.OnTimer, self);
end

function SomeEvent:Stop()
	-- �鿴ʣ������
	print(Timer:GetRestTime(self.nRegisterId))
	-- �رռ�ʱ��
	Timer:Close(self.nRegisterId);
end
