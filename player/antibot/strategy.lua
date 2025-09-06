-- �ļ�������strategy.lua
-- �����ߡ���houxuan
-- ����ʱ�䣺2008-12-22 08:54:20

Require("\\script\\player\\antibot\\antibot.lua");

local tbBase = Player.tbAntiBot.tbStrategy or {};
Player.tbAntiBot.tbStrategy = tbBase;

tbBase.tbStrategyList = {};

--ע���²��Ժ���
function tbBase:RegisterNewStrategy(nIndex, szName, tbStrategyOne, fnExecute, fnClear, fnGetLogMsg, fnSave)
	if ((not tbStrategyOne) or (not fnExecute) or (not fnClear) or (not szName) or (not fnGetLogMsg)) then
		return 0;
	end
	local tbList = tbBase.tbStrategyList;
	local nListCount = #tbList;
	
	--Ҫ��ע��Ĳ��Ե���ű�������
	if (nListCount + 1 ~= nIndex) then
		Dbg:Outptut("Error", "Strategy index is not sequential.");
		return 0;
	end
	if (tbList[nIndex] ~= nil) then
		Dbg:Output("Error", "Strategy "..szName.."is already register.");
		return 0;
	end;
	
	local tbOne = {};
	tbOne.obj = tbStrategyOne;
	tbOne.func = fnExecute;
	tbOne.fnClear = fnClear;
	tbOne.fnGetLogMsg = fnGetLogMsg;
	tbOne.fnSave = fnSave;
	tbOne.szName = szName;
	tbList[nIndex] = tbOne;
	return 1;
end

--ֱ�ӽ��ж����εĴ���Ľӿ�
function tbBase:ImmediateAgent(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return 0;
	end

	if (pPlayer.GetArrestTime() == 0) then
		local szLogMsg = string.format("[�����]��ֱ�Ӷ�����(ʹ���˵�������������)��\t�˺ţ�%s\t��ɫ��%s\t�ȼ���%d\tIP��ַ��%s\t�������ε�ʱ�䣺%s\t����ɹ���", 
			pPlayer.szAccount, pPlayer.szName, pPlayer.nLevel, pPlayer.GetPlayerIpAddress(), GetLocalDate("%Y\\%m\\%d  %H:%M:%S"));		
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_ANTIBOT_PROCESS, szLogMsg);	
		Player:Arrest(pPlayer.szName, 0);    --��������
	end
	return 1;
end

--�������εĴ���
function tbBase:Agent(pPlayer, nIndex)
	if (not pPlayer) then
		return 0;
	end
	
	local tbAnti = Player.tbAntiBot;
	if (tbAnti.DEFAULT_OPERATE == 0) then 		--ֻд��־��¼������������
		if (pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_MANAGERESULT) == tbAnti.tbenum.NOT_PUTIN_PRISON) then
			return 0;							--�Ѿ���¼����־��ֱ�ӷ���
		end
		pPlayer.SetTask(tbAnti.TSKGID, tbAnti.TSK_MANAGERESULT, tbAnti.tbenum.NOT_PUTIN_PRISON);
		local szLogMsg = string.format("[�����]�������δ�������\t�˺ţ�%s\t��ɫ��%s\t�ȼ���%d\tIP��ַ��%s\tʱ�䣺%s\t��������%s\t������Ϣ��%s\t%s\tֻ��д��־��¼����δ���������εĴ���", 
			pPlayer.szAccount, pPlayer.szName, pPlayer.nLevel, pPlayer.GetPlayerIpAddress(), GetLocalDate("%Y\\%m\\%d  %H:%M:%S"), tbBase.tbStrategyList[nIndex].szName, tbBase.tbStrategyList[nIndex].fnGetLogMsg(tbBase.tbStrategyList[nIndex].obj, pPlayer), tbAnti.tbScore:ScoreLog(pPlayer));
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_ANTIBOT_PROCESS, szLogMsg);
		return 0;
	end
	
	--DONE:�ڶ�������֮ǰ����ȡ��ҵ���ʵ�÷֣������ʵ�÷�С���ٽ�ֵ�����������εĴ���
	--��ҵĴ�������������Ƕ����Ӧ�õĲ��Ի������
	if (pPlayer.GetTask(tbAnti.TSKGID, tbAnti.TSK_ACTUAL_SCORE) < tbAnti.CRITICAL_VALUE) then
		--��Ҵ�ʱ�ĵ÷�С���ٽ�ֵ���������Σ����Ӧ����������ϵĲ���
		pPlayer.SetTask(tbAnti.TSKGID, tbAnti.TSK_MANAGEWAY, 0);
		local tbOne = self.tbStrategyList[nIndex];
		if (tbOne) then
			tbOne.fnClear(tbOne.obj, pPlayer);
		end
		pPlayer.SetTask(tbAnti.TSKGID, tbAnti.TSK_CRITICAL_TIME, 0);
		--дlog��־
		local szLogMsg = string.format("[�����]������С���ٽ�ֵ���������εĴ���\t�˺ţ�%s\t��ɫ��%s\t�ȼ���%d\tIP��ַ��%s\tʱ�䣺%s\t��������%s\t������Ϣ��%s\t%s",
			pPlayer.szAccount, pPlayer.szName, pPlayer.nLevel, pPlayer.GetPlayerIpAddress(), GetLocalDate("%Y\\%m\\%d  %H:%M:%S"), tbBase.tbStrategyList[nIndex].szName, tbBase.tbStrategyList[nIndex].fnGetLogMsg(tbBase.tbStrategyList[nIndex].obj, pPlayer), tbAnti.tbScore:ScoreLog(pPlayer));
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_ANTIBOT_PROCESS, szLogMsg);
		--print(szLogMsg);
		return 0;
	end
	
	pPlayer.SetTask(tbAnti.TSKGID, tbAnti.TSK_MANAGERESULT, tbAnti.tbenum.EXECUTE_SUCCESS);
	--�����Ҳ���������
	if (pPlayer.GetArrestTime() == 0) then
		local szLogMsg = string.format("[�����]�������δ�������\t�˺ţ�%s\t��ɫ��%s\t�ȼ���%d\tIP��ַ��%s\t�������ε�ʱ�䣺%s\t��������%s\t������Ϣ��%s\t%s\t����ɹ���", 
			pPlayer.szAccount, pPlayer.szName, pPlayer.nLevel, pPlayer.GetPlayerIpAddress(), GetLocalDate("%Y\\%m\\%d  %H:%M:%S"), tbBase.tbStrategyList[nIndex].szName, tbBase.tbStrategyList[nIndex].fnGetLogMsg(tbBase.tbStrategyList[nIndex].obj, pPlayer), tbAnti.tbScore:ScoreLog(pPlayer));		
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_ANTIBOT_PROCESS, szLogMsg);	
		Player:Arrest(pPlayer.szName, 0);    --��������
	end
	return 0;			--����0����Timer
end

--ע�⣺��Ҫ�޸Ĳ���ע��˳��
---------------����ǰ����ű������ε��������ܸı��Ѿ�ע��Ĳ��Ե����---------------------------
Require("\\script\\player\\antibot\\strategy1.lua");
Require("\\script\\player\\antibot\\strategy2.lua");
Require("\\script\\player\\antibot\\strategy3.lua");

local tbTmp = Player.tbAntiBot.tbStrategy1;
tbBase:RegisterNewStrategy(1, "�ȼ�����50��ֱ�Ӷ�������", tbTmp, tbTmp.OnExecute, tbTmp.OnClear, tbTmp.GetLogMsg);

tbTmp = Player.tbAntiBot.tbStrategy2;
tbBase:RegisterNewStrategy(2, "��ʱ2-10Сʱ��������", tbTmp, tbTmp.OnExecute, tbTmp.OnClear, tbTmp.GetLogMsg, tbTmp.OnSave);

tbTmp = Player.tbAntiBot.tbStrategy3;
tbBase:RegisterNewStrategy(3, "�����½10-16�β�������ʱ�䳬��1��Сʱ", tbTmp, tbTmp.OnExecute, tbTmp.OnClear, tbTmp.GetLogMsg, tbTmp.OnSave);
