-- �ļ�������strategy2.lua
-- �����ߡ���houxuan
-- ����ʱ�䣺2008-12-22 19:05:57

--���Զ���1
Require("\\script\\player\\antibot\\antibot.lua");

local tbStrategy2 = Player.tbAntiBot.tbStrategy2 or {};
Player.tbAntiBot.tbStrategy2 = tbStrategy2;

tbStrategy2.TSK_USED_TIME		= Player.tbAntiBot.STRATEGY_BEGIN + 10;		--�Ѿ��ù���ʱ��
tbStrategy2.TSK_TOTAL_TIME		= Player.tbAntiBot.STRATEGY_BEGIN + 11;		--��ʱ��

function tbStrategy2:OnExecute(pPlayer, nState, nIndex)	
	local tbAnti = Player.tbAntiBot;
	local nTotalTime = pPlayer.GetTask(tbAnti.TSKGID, self.TSK_TOTAL_TIME);
	if (nTotalTime == 0) then	--���1 - 120���ӣ���������
		nTotalTime = MathRandom(1, 120);		--TODO:��Χ��С 15���ӵ�����Сʱ
		nTotalTime = nTotalTime * 60;  --������ܹ��ж�����
		pPlayer.SetTask(tbAnti.TSKGID, self.TSK_TOTAL_TIME, nTotalTime);
	end
	
	local nLeftTime = nTotalTime - pPlayer.GetTask(tbAnti.TSKGID, self.TSK_USED_TIME); --����Ϊ��λ
	if (nLeftTime < 0 ) then
		nLeftTime = 1;
	end
	Player:RegisterTimer(nLeftTime * Env.GAME_FPS, tbAnti.tbStrategy.Agent, tbAnti.tbStrategy, pPlayer, nIndex);
	
	local tbSelf = Player:GetPlayerTempTable(pPlayer);
	tbSelf.AntiBot_nStartTime = GetTime();
	return 0;
end

function tbStrategy2:OnSave(pPlayer)
	local tbAnti = Player.tbAntiBot;
	local nLastTime = Player:GetPlayerTempTable(pPlayer).AntiBot_nStartTime;
	if (not nLastTime) then
		return 0;
	end
	local nAddTime = GetTime() - nLastTime;
	local nUsedTime = pPlayer.GetTask(tbAnti.TSKGID, self.TSK_USED_TIME);
	local nTotalTime = pPlayer.GetTask(tbAnti.TSKGID, self.TSK_TOTAL_TIME);
	if (nUsedTime <= nTotalTime) then
		pPlayer.SetTask(tbAnti.TSKGID, self.TSK_USED_TIME, nUsedTime + nAddTime);
	end
	return 1;
end

function tbStrategy2:OnClear(pPlayer)
	--����������ֵ
	local tbAnti = Player.tbAntiBot;
	pPlayer.SetTask(tbAnti.TSKGID, self.TSK_USED_TIME, 0);
	pPlayer.SetTask(tbAnti.TSKGID, self.TSK_TOTAL_TIME, 0);
	return 0;
end

function tbStrategy2:GetLogMsg(pPlayer)
	local szMsg = string.format("����������ʱ2-10Сʱ��������\t�ж�Ϊ��Һ��ӳ�%dСʱ���ж����εĴ���", 
		pPlayer.GetTask(Player.tbAntiBot.TSKGID, tbStrategy2.TSK_TOTAL_TIME) / 3600);
	return szMsg;
end
