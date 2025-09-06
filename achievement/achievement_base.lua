-- �ļ�������achievement_base.lua
-- �����ߡ���furuilei
-- ����ʱ�䣺2009-10-21 18:29:34


--==========================================================
local szAchievementPath = "\\setting\\achievement\\achievement.txt";
Achievement.tbAchievementInfo = {};
--==========================================================

-- �������ļ���ȡ�ɾ���Ϣ���ú����ṩ��gs��clientʹ��
function Achievement:LoadInfo()
	local tbAchievementSetting = Lib:LoadTabFile(szAchievementPath);
	-- ���سɾ�ϵͳ�б�
	for nRow, tbRowData in pairs(tbAchievementSetting) do
		local tbTemp = {};
		tbTemp.nAchievementId = tonumber(tbRowData["AchivementId"]);
		tbTemp.szAchievement = tbRowData["Achivement"];
		tbTemp.szSystem = tbRowData["System"];
		tbTemp.szType = tbRowData["Type"];
		tbTemp.bEffective = tonumber(tbRowData["Effective"]);
		if (not self.tbAchievementInfo[tbTemp.nAchievementId] and tbTemp.bEffective == 1) then
			self.tbAchievementInfo[tbTemp.nAchievementId] = tbTemp;
		end
	end
end

-- �����Ƿ����
function Achievement:SetTaskValue(nTaskId, nValue)
	me.SetTaskBit(self.TASKGROUP, nTaskId * 2, nValue);
end

-- �����Ƿ���ȡ������
function Achievement:SetTaskState(nTaskId, nState)
	me.SetTaskBit(self.TASKGROUP, nTaskId * 2 - 1, nState);
end

-- ��ȡ�Ƿ����
function Achievement:GetTaskValue(nTaskId)
	return me.GetTaskBit(self.TASKGROUP, nTaskId * 2);
end

-- ��ȡ�Ƿ���ȡ������
function Achievement:GetTaskState(nTaskId)
	return me.GetTaskBit(self.TASKGROUP, nTaskId * 2 - 1);
end

-- ע��ͨ�÷����������¼�
if (MODULE_GAMESERVER) then
	ServerEvent:RegisterServerStartFunc(Achievement.LoadInfo, Achievement);
end
