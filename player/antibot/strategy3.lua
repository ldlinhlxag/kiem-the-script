-- �ļ�������strategy3.lua
-- �����ߡ���houxuan
-- ����ʱ�䣺2008-12-22 08:54:28

Require("\\script\\player\\antibot\\antibot.lua");

--��ҵ�½2-5��֮�󣬶�������
local tbStrategy3 = Player.tbAntiBot.tbStrategy3 or {};
Player.tbAntiBot.tbStrategy3 = tbStrategy3;

--��¼����ڱ�����Ϊ���֮��ĵ�½�������������
tbStrategy3.TSK_LOGINCOUNT		=	Player.tbAntiBot.STRATEGY_BEGIN + 20;

--����ڱ�����Ϊ���֮�󣬵����½�����ﵽĳһ��ֵʱ����������
tbStrategy3.TSK_DEFINEPOINT		=	Player.tbAntiBot.STRATEGY_BEGIN + 21;

--����ʱ������Ϊ1��Сʱ������һ��СʱҲ��
tbStrategy3.ONLINE_TIME			= 1 * 60 * 60;

--��¼���ж�Ϊ��Һ������ʱ����������
tbStrategy3.TSK_ONLINE_TIME		= Player.tbAntiBot.STRATEGY_BEGIN + 22;

function tbStrategy3:OnExecute(pPlayer, nState, nIndex)
	local tbAnti = Player.tbAntiBot;
	local nDefinePnt = pPlayer.GetTask(tbAnti.TSKGID, self.TSK_DEFINEPOINT);
	local nLoginCnt = pPlayer.GetTask(tbAnti.TSKGID, self.TSK_LOGINCOUNT);
	
	--����ʱ��
	local tbSelf = Player:GetPlayerTempTable(pPlayer);
	tbSelf.AntiBot_nStrategy3Start = GetTime();
	
	if (nDefinePnt == 0) then
		--��һ�ε�½��������������
		nDefinePnt = MathRandom(10, 16);
		pPlayer.SetTask(tbAnti.TSKGID, self.TSK_DEFINEPOINT, nDefinePnt);
		return 0;
	end
	if (nState ~= tbAnti.PLAYER_LOGIN) then		--������ҵ�½���̣�ֱ�ӷ���
		return 0;
	end
	if (nLoginCnt < nDefinePnt) then
		nLoginCnt = nLoginCnt + 1;
		pPlayer.SetTask(tbAnti.TSKGID, self.TSK_LOGINCOUNT, nLoginCnt);
		if (nLoginCnt < nDefinePnt) then
			return 0;
		end
	end
	--��½�����Ѵﵽ���ж�����ʱ���Ƿ�ﵽ1Сʱ
	local nOnLineTime = pPlayer.GetTask(tbAnti.TSKGID, self.TSK_ONLINE_TIME);
	if (nOnLineTime >= self.ONLINE_TIME) then
		Player.tbAntiBot.tbStrategy:Agent(pPlayer, nIndex);
	end
	return 1;
end

function tbStrategy3:OnClear(pPlayer)
	local tbAnti = Player.tbAntiBot;
	--����ò������õ��������ֵ
	pPlayer.SetTask(tbAnti.TSKGID, self.TSK_DEFINEPOINT, 0);
	pPlayer.SetTask(tbAnti.TSKGID, self.TSK_LOGINCOUNT, 0);
	pPlayer.SetTask(tbAnti.TSKGID, self.TSK_ONLINE_TIME, 0);
	return 0;
end

function tbStrategy3:OnSave(pPlayer)
	local tbAnti = Player.tbAntiBot;
	local nLastTime = Player:GetPlayerTempTable(pPlayer).AntiBot_nStrategy3Start;
	if (not nLastTime) then
		return 0;
	end
	local nAddTime = GetTime() - nLastTime;
	local nUsedTime = pPlayer.GetTask(tbAnti.TSKGID, self.TSK_ONLINE_TIME);
	pPlayer.SetTask(tbAnti.TSKGID, self.TSK_ONLINE_TIME, nUsedTime + nAddTime);
	return 1;
end

function tbStrategy3:GetLogMsg(pPlayer)
	local szMsg = string.format("�������������½10-16�β�������ʱ�䳬��1��Сʱ��������\t���ж�Ϊ��Һ󣬵�½%d�ζ�������\t�ж�Ϊ��Һ������ʱ��%.1fСʱ", 
		pPlayer.GetTask(Player.tbAntiBot.TSKGID, self.TSK_DEFINEPOINT), pPlayer.GetTask(Player.tbAntiBot.TSKGID, self.TSK_ONLINE_TIME) / 3600);
	return szMsg;
end
