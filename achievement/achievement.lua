-- �ļ�������achivement.lua
-- �����ߡ���furuilei
-- ����ʱ�䣺2009-10-19 10:29:41
-- �����������ɾ�ϵͳ

if (MODULE_GAMECLIENT) then
	return;
end

Achievement.tbc2sFun = {};

-- ����Ƿ�ﵽ��ɳɾ͵�����
function Achievement:CheckCondition(nAchievementId)	
	if (nAchievementId <= 0 or nAchievementId >= self.COUNT) then
		return 0;
	end
	
	if (not self.tbAchievementInfo[nAchievementId]) then
		return 0;
	end
	
	if (self.tbAchievementInfo[nAchievementId].bEffective and
		self.tbAchievementInfo[nAchievementId].bEffective == 0) then
		return 0
	end
	
	-- ֻ�е�ǰ��ʦ���ĵ��Ӳ��ܼӳɾ�
	if (not me.GetTrainingTeacher()) then
		return 0;
	end
	
	if (self:GetTaskValue(nAchievementId) == 1) then
		return 0;
	end
	
	return 1;
end

-- Ϊgs�ṩ�ģ����óɾ͵Ľӿ�
function Achievement:FinishAchievement(nPlayerId, nAchievementId)
	if (nPlayerId and nPlayerId <= 0) then
		return;
	end
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	Setting:SetGlobalObj(pPlayer);
	if (0 == self:CheckCondition(nAchievementId)) then
		Setting:RestoreGlobalObj();
		return;
	end
	
	-- ��ÿ�λ�ȡ�ɾ͵�ʱ�򣬶������ĳɾͣ�Ŀǰ��Ҫ�ǹ̶��ɾͣ����м��
	self:CheckPreviousAchievement();
	
	self:SetTaskValue(nAchievementId, 1);
	local szMsg = string.format("Nhận được: %s", self.tbAchievementInfo[nAchievementId].szAchievement);
	me.Msg(szMsg);
	
	Setting:RestoreGlobalObj();
end

function Achievement:__GetAchievementInfo(nAchievementId)
	if (nAchievementId <= 0 or nAchievementId >= self.COUNT) then
		return;
	end
	local tbInfo = {};
	tbInfo.nAchievementId = self.tbAchievementInfo[nAchievementId].nAchievementId;
	tbInfo.bAchieve = self:GetTaskValue(nAchievementId);	-- �Ƿ���ɳɾ�
	tbInfo.bAward = self:GetTaskState(nAchievementId);		-- �Ƿ���ȡ��Ӧ�ɾ͵Ľ���
	return tbInfo;
end

function Achievement:GetAchievementInfo()
	local tbInfo = {};
	-- for i, nAchievementId in pairs() do
	for i, v in pairs(self.tbAchievementInfo) do
		local tbTempInfo = self:__GetAchievementInfo(v.nAchievementId);
		table.insert(tbInfo, tbTempInfo);
	end
	return tbInfo;
end

-- ��ָ����ĳ��ɾͱ��Ϊ�Ѿ���ȡ��������
function Achievement:SetGetAwardFlag(nAchievementId)
	if (nAchievementId <= 0 or nAchievementId >= self.COUNT) then
		return;
	end
	
	self:SetTaskState(nAchievementId, 1);
end

-- Ϊ�ͻ����ṩ��������ȡ�ɾ���Ϣ�Ľӿ�
function Achievement:GetAchievementInfo_C2S(nPlayerId)
	if (not nPlayerId or nPlayerId <= 0) then
		return;
	end
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	Setting:SetGlobalObj(pPlayer);
	local tbInfo = self:GetAchievementInfo();
	me.CallClientScript({"Achievement:SyncAchievementInfo", tbInfo});
	Setting:RestoreGlobalObj();
end
Achievement.tbc2sFun["GetAchievementInfo_C2S"] = Achievement.GetAchievementInfo_C2S;

-- ��ȡָ�����͵����гɾ͵��б�
-- ����ֵ��{{nAchievementId, bAchieve}, {nAchievementId, bAchieve}, ...}
function Achievement:GetSpeTypeAchievementInfo(nPlayerId, szType)
	if (not nPlayerId or nPlayerId <= 0 or not szType or szType == "") then
		return;
	end
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	Setting:SetGlobalObj(pPlayer);
	local tbSpeType = {};
	for _, tbInfo in pairs(self.tbAchievementInfo) do
		if (tbInfo.szType == szType) then
			local tbTemp = {};
			tbTemp.nAchievementId = tbInfo.nAchievementId;
			tbTemp.bAchieve = self:GetTaskValue(tbInfo.nAchievementId);
			table.insert(tbSpeType, tbTemp);
		end
	end
	Setting:RestoreGlobalObj();
	
	return tbSpeType;
end

-- ����ȥ�ĳɾͣ���Ҫ�ǹ̶��ɾͣ����������κ�һ��ɾ͵�ʱ�򴥷���
function Achievement:CheckPreviousAchievement(bByHand)
	-- ֻ�е�ǰ��ʦ���ĵ��ӲŻ��޸���ȥ�Ĺ̶��ɾ�
	if (not me.GetTrainingTeacher()) then
		return;
	end
	
	-- �ֹ��޸���ʱ�򣬲������
	if (not bByHand or bByHand ~= 1) then
		-- �κ�һ��ɾͲ�Ϊ0���ͱ�ʾ�Ѿ����ù��ɾͣ�����Ҫ�ٴμ����
		for _, tbInfo in pairs(self.tbAchievementInfo) do
			if (self:GetTaskValue(tbInfo.nAchievementId) == 1) then
				return;
			end
		end
	end
	
	-- ����������͵ĳɾ�
	for nAchievementId, tbTaskIdInfo in pairs(self.tbMainTaskId) do
		for _, tbTaskId in pairs(tbTaskIdInfo) do
			local nMainTaskId = tbTaskId[1];
			local nSubTaskId = tbTaskId[2];
			if (me.GetTask(1000, nMainTaskId) >= nSubTaskId) then
				self:SetTaskValue(nAchievementId, 1);
			end
		end
	end
	
	-- ����Ƿ�������
	if (me.dwKinId > 0) then
		self:SetTaskValue(self.ENTER_KIN, 1);
	end
	
	-- �Ƿ���й���
	local nRepute = me.GetReputeValue(5, 4);
	if (0 ~= nRepute) then
		self:SetTaskValue(self.QIFU, 1);
	end
	
	-- �����
	for i = 1, 10 do
		local nLifeSkillLevel = LifeSkill:GetSkillLevel(me, i);
		if (nLifeSkillLevel >= 20) then
			self:SetTaskValue(self.LIFISKILL_20, 1);
		end
		if (nLifeSkillLevel >= 30) then
			self:SetTaskValue(self.LIFISKILL_30, 1);
		end
	end
	
	-- �����ʵ�
	-- HelpQuestion:LoadQuestion();
	local nGroupNum = Lib:CountTB(HelpQuestion.tbGroup);
	for i = 1, nGroupNum do
		if (me.GetTaskBit(HelpQuestion.TASK_GROUP_ID, i) == 1) then
			self:SetTaskValue(self.JXCIDIAN, 1);
		end
	end
end
