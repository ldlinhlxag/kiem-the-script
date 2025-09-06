--������ȡ���������Ƴ��󣬷��Ͻ���������������ң�����ÿ����ȡ����ֵ500RMB�İ󶨽��

SpecialEvent.Salary = {}
local Salary = SpecialEvent.Salary;

Salary.TASK_GROUP_ID = 2027;
Salary.TASK_LAST_PAID_TIME = 68;

function Salary:CanGetSalary()
	if SpecialEvent:IsWellfareStarted() ~= 1 then
		return 0, "�˹�����δ�����������ڴ���";
	end
	
	local nTime = GetTime();
	local nWeek = Lib:GetLocalWeek(nTime);
	
	local nLastTime = me.GetTask(self.TASK_GROUP_ID, self.TASK_LAST_PAID_TIME);
	local nLastWeek = Lib:GetLocalWeek(nLastTime);
	
	local nTimeOK = 0;
	
	if nLastTime == 0 or nWeek > nLastWeek then
		nTimeOK = 1;
	end
	
	if nTimeOK ~= 1 then
		return 0, "�������Ѿ������������";
	end
	
	if KGblTask.SCGetDbTaskInt(DBTASK_WEIWANG_WEEK) ~= tonumber(GetLocalDate("%W")) then
		return 0, "��һ�ܵĽ�������������û���������Ժ�������";
	end
	
	local nLevel = GetPlayerHonorRankByName(me.szName, PlayerHonor.HONOR_CLASS_WEIWANG, 0);
	
	if nLevel < 1 or nLevel > 1200 then
		return 0, "�ܿ�ϧ�������������û�ﵽ��ȡ���ʵ�Ҫ��";
	end
	
	local nCoin, nDecreaseRepute;
	if 1 <= nLevel and nLevel <=100 then
		nCoin = 12000;
		nDecreaseRepute = 100;
	elseif 101 <= nLevel and nLevel <= 300 then
		nCoin = 6000;
		nDecreaseRepute = 50;
	elseif 301 <= nLevel and nLevel <= 600 then
		nCoin = 3000;
		nDecreaseRepute = 30;
	elseif 601 <= nLevel and nLevel <= 1200 then
		nCoin = 2000;
		nDecreaseRepute = 20;
	end
	
	if me.nPrestige < nDecreaseRepute then
		return 0, string.format("Ҫ��ȡ��������<color=yellow>��%d��<color>�Ĺ��ʣ���������Ҫ<color=yellow>%d��<color>������", nLevel, nDecreaseRepute);
	end
	
	return 1, nLevel, nCoin, nDecreaseRepute;
end


function Salary:GetSalary()
	local nRes, var, nCoin, nDecreaseRepute = Salary:CanGetSalary();
	if nRes == 0 then
		Dialog:Say(var);
		return;
	end
	
	local nLevel = var;
	
	if nCoin then
		local szMsg = string.format("�㱾�ܽ�����������Ϊ<color=yellow>��%d��<color>�������ͨ��ʹ��<color=yellow>%d��<color>������������ȡ���ʣ�����Ϊ<color=yellow>%d��%s<color>\n\nȷ��Ҫ��ȡ��",
			nLevel, nDecreaseRepute, nCoin, IVER_g_szCoinName);
			
		local tbOpt = {
			{"�ǵģ���Ҫ�칤��", self.GetSalary2, self, nCoin, nDecreaseRepute, nLevel},
			{"��ֻ��������"},
			};
		Dialog:Say(szMsg, tbOpt);	
	end
end

function Salary:GetSalary2(nCoin, nDecreaseRepute, nLevel)
	local nRes, var = Salary:CanGetSalary();
	if nRes == 0 then
		Dialog:Say(var);
		return;
	end
	
	me.AddBindCoin(nCoin, Player.emKBINDCOIN_ADD_SALARY);
	local nOldReput = me.nPrestige;
	local nNewPrestige = math.max(nOldReput - nDecreaseRepute, 0);
	KGCPlayer.SetPlayerPrestige(me.nId, nNewPrestige);
	
	me.SetTask(self.TASK_GROUP_ID, self.TASK_LAST_PAID_TIME, GetTime());
	
	local szLog = string.format("%s ��%d�� ��ø�������%d��%s�� ����%d��������������%s��Ϊ%s", me.szName, nLevel, nCoin, IVER_g_szCoinName, nDecreaseRepute, nOldReput, nNewPrestige);
	Dbg:WriteLog("SpecialEvent.Salary", szLog);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szLog);
	--��¼�����ȡ���ʵĴ���
	Stats.Activity:AddCount(me, Stats.TASK_COUNT_SALARY, 1);
	KStatLog.ModifyAdd("bindcoin", "[����]����", "����", nCoin);
end
