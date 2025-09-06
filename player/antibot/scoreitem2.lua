-- �ļ�������scoreitem2.lua
-- ���ܣ������Ϊ���
-- �����ߡ���luobaohang
-- ����ʱ�䣺2009-2-9 16:39:22

-- ����ר��
Require("\\script\\player\\antibot\\antibot.lua");

local tbScoreItem2 = Player.tbAntiBot.tbScoreItem2 or {};
Player.tbAntiBot.tbScoreItem2 = tbScoreItem2;

--�ӷ�
function tbScoreItem2:AddScore(pPlayer, nValue, nId)
	local tbAnti = Player.tbAntiBot;
	local nErr = pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_ERR_BEGINID + nId);
	local nTotal = pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId);
	if (nValue < 0) then
		pPlayer.SetTask(tbAnti.TSKGID, tbAnti.TSK_ERR_BEGINID + nId, math.min(100, nErr - nValue));
	else
		pPlayer.SetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId, math.min(100, nTotal + nValue));
	end
	return 1;
end

--����÷�
function tbScoreItem2:GetScore(pPlayer, nId)
	local tbAnti = Player.tbAntiBot;
	local nErr = pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_ERR_BEGINID + nId);
	local nTotal = pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId);
	return nTotal - nErr;
end

--����÷�
function tbScoreItem2:Clear(pPlayer, nId)
	local tbAnti = Player.tbAntiBot;
	pPlayer.SetTask(tbAnti.TSKGID, tbAnti.TSK_ERR_BEGINID + nId, 0);
	pPlayer.SetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId, 0);
	return szMsg;
end

function tbScoreItem2:GetLogMsg1(pPlayer, nId)
	local tbAnti = Player.tbAntiBot;
	local szMsg = string.format("\t�����ĿRoleAction: \t�������%d\t�ܴ���%d", pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_ERR_BEGINID + nId), pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId));
	return szMsg;
end
function tbScoreItem2:GetLogMsg2(pPlayer, nId)
	local tbAnti = Player.tbAntiBot;
	local szMsg = string.format("\t�����ĿTaskLink: \t�������%d\t�ܴ���%d", pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_ERR_BEGINID + nId), pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId));
	return szMsg;
end
function tbScoreItem2:GetLogMsg3(pPlayer, nId)
	local tbAnti = Player.tbAntiBot;
	local szMsg = string.format("\t�����ĿShangHui: \t�������%d\t�ܴ���%d", pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_ERR_BEGINID + nId), pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId));
	return szMsg;
end

function tbScoreItem2:OnPlayerLevelUp(nLevel)
	if nLevel == 49 then
		local nScore = self:PlayerStateLevel50();
		Player.tbAntiBot:OnSaveRoleScore(me.szAccount, me.szName, "roleaction", nScore)
	end
end

-- ����50��ʱ������ʱ��
tbScoreItem2.tbOnlineTimeStep = {2.5 * 3600, 4 * 3600, 10 * 3600};
tbScoreItem2.tbOnlineTimeScore = {30, 20, 0, -10};
-- 50��ʱ������Ŀ
tbScoreItem2.tbFriendCountStep = {2, 3, 4};
tbScoreItem2.tbFriendCountScore = {10, 5, -20, -20};
-- ��ֵ��
tbScoreItem2.tbMonChargeStep = {1, 50, 100};
tbScoreItem2.tbMonChargeScore = {0, -20, -30, -100};
-- ��ɫ�������Ľ��
tbScoreItem2.tbJbStep = {1, 100, 1000};
tbScoreItem2.tbJbScore = {0, -10, -30, -50};
-- ���ɾ�������
tbScoreItem2.nFactionReputeDecScore = 20;

function tbScoreItem2:calcscore3step(nValue, tbStep, tbScore)
	if nValue < tbStep[1] then
		return tbScore[1];
	elseif nValue < tbStep[2] then
		return tbScore[2];
	elseif nValue < tbStep[3] then
		return tbScore[3];		
	elseif nValue >= tbStep[3] then
		return tbScore[4];
	end
	return 0;
end

function tbScoreItem2:PlayerStateLevel50()
	local nScore = 0;
	local nOnlineTime = me.nOnlineTime
	local nRelationCount =me.GetRelationCount(2);
	local nMonCharge = me.nMonCharge;
	local nFactionReputeLevel = me.GetReputeLevel(3, me.nFaction)
	local nJbConsume = me.GetTask(2034, 1);
	nScore = nScore + self:calcscore3step(nOnlineTime, self.tbOnlineTimeStep, self.tbOnlineTimeScore);
	nScore = nScore + self:calcscore3step(nRelationCount, self.tbFriendCountStep, self.tbFriendCountScore);
	nScore = nScore + self:calcscore3step(nMonCharge, self.tbMonChargeStep, self.tbMonChargeScore);
	nScore = nScore + self:calcscore3step(nJbConsume, self.tbJbStep, self.tbJbScore);
	if nFactionReputeLevel and nFactionReputeLevel > 1 then
		nScore = nScore - self.nFactionReputeDecScore;
	end
	return nScore;
end

--self.tbAntiBot:OnSaveRoleScore(me.szAccount, me.szName, "roleaction", false);	--û�г���
PlayerEvent:RegisterGlobal("OnLevelUp", tbScoreItem2.OnPlayerLevelUp, tbScoreItem2);

local tbScoreItem3 = Player.tbAntiBot.tbScoreItem3 or {};
Player.tbAntiBot.tbScoreItem3 = tbScoreItem3;

function tbScoreItem3:AddScore(pPlayer, nValue, nId)
	local tbAnti = Player.tbAntiBot;
	local nTotal = pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId);
	pPlayer.SetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId, nTotal + nValue);
	return 1;
end

function tbScoreItem3:GetScore(pPlayer, nId)
	local tbAnti = Player.tbAntiBot;
	local nTotal = pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId);
	return nTotal;
end

function tbScoreItem3:Clear(pPlayer, nId)
	local tbAnti = Player.tbAntiBot;
	pPlayer.SetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId, 0);
end

function tbScoreItem3:GetLogMsg(pPlayer, nId)
	local tbAnti = Player.tbAntiBot;
	local szMsg = string.format("\t�����ĿDirectAdd: \t�������%d\t�ܴ���%d", pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_ERR_BEGINID + nId), pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId));
	return szMsg;
end
