-- �ļ�������scoreitem1.lua
-- �����ߡ���houxuan
-- ����ʱ�䣺2008-12-22 08:54:14

Require("\\script\\player\\antibot\\antibot.lua");

local tbScoreItem1 = Player.tbAntiBot.tbScoreItem1 or {};
Player.tbAntiBot.tbScoreItem1 = tbScoreItem1;

tbScoreItem1.MIN_ERR_COUNT			= 3;			--�������С��3�Σ��÷�Ϊ0
tbScoreItem1.SLOPE_FACTOR			= 4.0 / 9.0;	--������ҵ÷ֵ�ϵ��(б��)
tbScoreItem1.INTERCEPT				= 500.0 / 9.0;	--������ҵ÷ֵ�ϵ��(�ؾ�)

--�ӷ�
function tbScoreItem1:AddScore(pPlayer, bValue, nId)
	local tbAnti = Player.tbAntiBot;
	local nErr = pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_ERR_BEGINID + nId);
	local nTotal = pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId);
	if (bValue) then
		pPlayer.SetTask(tbAnti.TSKGID, tbAnti.TSK_ERR_BEGINID + nId, nErr + 1);
	end
	pPlayer.SetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId, nTotal + 1);
	return 1;
end

--����÷�
function tbScoreItem1:GetScore(pPlayer, nId)
	local tbAnti = Player.tbAntiBot;

	local nErr = pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_ERR_BEGINID + nId);
	if (nErr < tbScoreItem1.MIN_ERR_COUNT) then
		return 0;
	end
	local nTotal = pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId);
	local nPercent = nErr * 100 / nTotal;
	nPercent = tbScoreItem1.SLOPE_FACTOR * nPercent + tbScoreItem1.INTERCEPT;
	nPercent = math.floor(nPercent);
	
	return nPercent;
end

--����÷�
function tbScoreItem1:Clear(pPlayer, nId)
	local tbAnti = Player.tbAntiBot;
	pPlayer.SetTask(tbAnti.TSKGID, tbAnti.TSK_ERR_BEGINID + nId, 0);
	pPlayer.SetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId, 0);
	return szMsg;
end

function tbScoreItem1:GetLogMsg(pPlayer, nId)
	local tbAnti = Player.tbAntiBot;
	local szMsg = string.format("\t�����Ŀgamecode: \t�������%d\t�ܴ���%d", pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_ERR_BEGINID + nId), pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_TOTAL_BEGINID + nId));
	return szMsg;
end
