-- �ļ�������stats_activity.lua
-- �����ߡ���furuilei
-- ����ʱ�䣺2009-07-06 10:24:21
-- ����ͳ�ƽ�ɫ�μӻ�ܴ���

if (MODULE_GAMECLIENT) then
	return;
end

Stats.Activity = {};
local Activity = Stats.Activity;

-- �ر�ͼ
function Activity:ParseCangbaotuCmd(pPlayer, nTaskId, nAddCount, nConfirm)
	local nMapId, nPosX, nPosY	= pPlayer.GetWorldPos();
	local tbTeamList = pPlayer.GetTeamMemberList();
	if (not tbTeamList) then
		return;
	end
	for i, v in pairs(tbTeamList) do
		if (v.nMapId == nMapId) then
			self:SureAdd(v, nTaskId, nAddCount);
		end
	end
end

-- ����������
function Activity:ParseFuli(pPlayer, nTaskId, nAddCount, nConfirm)
	local nLastGetFuliTime = pPlayer.GetTask(Stats.TASK_GROUP, Stats.TASK_ID_LASTGETFULITIME);
	local nLastGetFuliDate = tonumber(os.date("%Y%m%d", nLastGetFuliTime));
	local nCurDate = tonumber(os.date("%Y%m%d", GetTime()));
	if (nLastGetFuliDate ~= nCurDate) then
		self:SureAdd(pPlayer, nTaskId, nAddCount);
	end
end

-- ��Щ��Ƚ����⣬��ͳ��֮ǰ��Ҫ����һЩר�ŵĴ������������Щ������н���
function Activity:ParseCmd(pPlayer, nTaskId, nAddCount)
	if (nTaskId == Stats.TASK_COUNT_CANGBAOTU) then
		self:ParseCangbaotuCmd(pPlayer, nTaskId, nAddCount);
		return;
	end
	if (nTaskId == Stats.TASK_COUNT_FULIJINGHUO) then
		self:ParseFuli(pPlayer, nTaskId, nAddCount);
		return;
	end
end

function Activity:ReSet(pPlayer, nKey)
	for i = Stats.TASK_COUNT_XIULIANZHU, Stats.TASK_COUNT_XIULIANZHU + Stats.TASK_ACTIVITY_COUNT - 1 do
		pPlayer.SetTask(Stats.TASK_GROUP, i, 0);
	end
	pPlayer.SetTask(Stats.TASK_GROUP, Stats.TASK_COUNT_ACTIVITY_KEY, nKey);
end

-- Ϊָ����ͳ�Ʊ�������ָ��������
-- nConfirmȱʡΪ�����ڣ���ʾ�����ر���ķ���ȷ����Ϣ
function Activity:AddCount(pPlayer, nTaskId, nAddCount, nConfirm)
	if (not pPlayer or not nTaskId or not nAddCount) then
		return;
	end
	
	local nKey = KGblTask.SCGetDbTaskInt(DBTASK_STATS_ACTIVITY_KEY);
	if (pPlayer.GetTask(Stats.TASK_GROUP, Stats.TASK_COUNT_ACTIVITY_KEY) ~= nKey) then
		self:ReSet(pPlayer, nKey);
	end
	
	if (nConfirm) then
		self:ParseCmd(pPlayer, nTaskId, nAddCount);
		return;
	end
	
	self:SureAdd(pPlayer, nTaskId, nAddCount);
end

function Activity:SureAdd(pPlayer, nTaskId, nAddCount)
	local nCount = pPlayer.GetTask(Stats.TASK_GROUP, nTaskId) + nAddCount;
	pPlayer.SetTask(Stats.TASK_GROUP, nTaskId, nCount);
end
