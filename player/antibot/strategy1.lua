-- �ļ�������strategy1.lua
-- �����ߡ���houxuan
-- ����ʱ�䣺2008-12-22 19:05:44

Require("\\script\\player\\antibot\\antibot.lua");

local tbStrategy1 = Player.tbAntiBot.tbStrategy1 or {};
Player.tbAntiBot.tbStrategy1 = tbStrategy1;

--ִ�в���
function tbStrategy1:OnExecute(pPlayer, nState, nIndex)
	PlayerEvent:Register("OnLevelUp", tbStrategy1.OnLevelUp, tbStrategy1);
	return 1;
end

--����ʱ��Ӧ�ĺ���
function tbStrategy1:OnLevelUp(nLevel)
	local tbAnti = Player.tbAntiBot;
	local nResult = me.GetTask(tbAnti.TSKGID, tbAnti.TSK_MANAGERESULT);		--��ȡ����Ľ��
	if (nResult == tbAnti.tbenum.EXECUTE_SUCCESS) then	--�Ѿ��������
		return 0;
	end
	if (nLevel == Player.tbAntiBot.CRITICAL_LEVEL) then
		Player.tbAntiBot.tbStrategy:Agent(me, 1);
	end
	return 0;
end

--���������ʹ�õ�����
function tbStrategy1:OnClear(pPlayer)
	local szMsg = string.format("���������ȼ�����50���������Ρ�");
	return szMsg;
end

function tbStrategy1:GetLogMsg(pPlayer)
	return "";
end
