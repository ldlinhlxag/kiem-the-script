--軍營log2接口

Require("\\script\\task\\armycamp\\define.lua");

local StatLog = {};
Task.tbArmyCampInstancingManager.StatLog = StatLog;

--最多15位，16位－32位記錄周
--15位記錄類型為1的，後面記錄類型為2的
StatLog.LogList = 
{
	--  {描述，類型（1,按人頭算，2,總量）}
	[1] = {"本周有多少玩家進入過副本", 1};
	[2] = {"本周有多少玩家接過劇情副本",1};
	[3] = {"本周有多少玩家接過日常副本",1};
	[4] = {"本周有多少玩家完成了劇情副本",1};
	[5] = {"本周有多少玩家完成了日常副本",1};
	[6] = {"本周有多少玩家讀過機關書",1};
	[7] = {"本周有多少玩家讀過兵書",1};
	[8] = {"本周有多少玩家讀完了機關書",1};
	[9] = {"本周有多少玩家讀完了兵書",1};
	[10] = {"本周有多少玩家接過副本內的隨機任務",1};
	[11] = {"本周產出機關學造詣",2};
	[12] = {"本周產出機關耐久度",2};
	[13] = {""};
	[14] = {""};
	[15] = {""};
	[16] = {"本周產出面具(類型%s)數量", 2};
}
StatLog.nTaskGroupId = 2044;
StatLog.nTaskId = 11;

function StatLog:WriteLog(nLogId, nValue, pPlayer, nArg)
	if not self.LogList[nLogId] then
		return 0;
	end
	if (pPlayer) then
		Setting:SetGlobalObj(pPlayer, him, it);
	end
	local nWeek = tonumber(GetLocalDate("%W"));
	local nYear	= tonumber(GetLocalDate("%Y"));
	local szKey = string.format("%s第%s周", nYear, nWeek);
	local szField = self.LogList[nLogId][1];
	if nArg then
		szField = string.format(szField, nArg);
	end
	if self.LogList[nLogId][2] == 2 then
		KStatLog.ModifyAdd("armycamp", szKey, szField, nValue)
	elseif self.LogList[nLogId][2] == 1 then
		local nTaskValue = me.GetTask(self.nTaskGroupId, self.nTaskId);
		if self:GetWeek(nTaskValue) < nWeek then
			nTaskValue = self:SetWeek(nWeek);
		end
		if KLib.GetBit(nTaskValue, nLogId) == 0 then
			local nSetTask = KLib.SetBit(nTaskValue, nLogId, 1) 
			me.SetTask(self.nTaskGroupId, self.nTaskId, nSetTask);
			KStatLog.ModifyAdd("armycamp", szKey, szField, nValue)
		end
	end
	if (pPlayer) then
		Setting:RestoreGlobalObj();
	end
end

function StatLog:GetWeek(nTaskValue)
	local nWeek = math.floor(nTaskValue/2^15)
	return nWeek;
end

function StatLog:SetWeek(nWeek)
	local nSetTaskValue = (nWeek * 2^15);
	me.SetTask(self.nTaskGroupId, self.nTaskId, nSetTaskValue);
	return nSetTaskValue;
end
