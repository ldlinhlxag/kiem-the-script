-- �ļ�������recover.lua
-- �����ߡ���houxuan
-- ����ʱ�䣺2008-12-22 08:54:07

Require("\\script\\player\\antibot\\antibot.lua");

local tbRecover = Player.tbAntiBot.tbRecover or {};
Player.tbAntiBot.tbRecover = tbRecover;

tbRecover.tbTimeList = {
	};

--������ұ��ж�Ϊ��ҵ����ڣ�����Ҵ��������ͷų���
function tbRecover:RecoverPlayer(pPlayer)
	local tbAnti = Player.tbAntiBot;
	local nDay = pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_CRITICAL_TIME);
	if (self.tbTimeList[nDay]) then
		Player:SetFree(pPlayer.szName);
	end
	return 0;
end
