-- �ļ�������antibot.lua
-- �����ߡ���houxuan
-- ����ʱ�䣺2008-12-22 08:53:30

-----------------------------------------����˵��---------------------------
--	1�������Ŀ �洢��tbAntiBot.tbItemList��tbItemList[key] = v, v + tbAntiBot.TSK_ERR_BEGINID��¼�ô�����ж�
--		ĳ����ҳ����쳣���������������v + tbAntiBot.TSK_TOTAL_BEGINID ��¼�ô�����¼��ĳ�����ִ���жϴ������������
--  2��������ʼ�������
--     ��ÿһ�ֲ��ԣ������˴�1-9ʮ���������ֵ����ʼֵ��tbAntiBot.STRATEGY_BEGIN = 300����һ�����Կ���ʹ�õ���300-309��
--	   �ڶ�����310-319����������....
--	   ÿ�ֲ����ж�Ӧ����ţ����������ε����ģ�ǰһ��ע����Ĳ��Ե������4�����±�д�Ĳ��Ե���ű�����5

local tbAntiBot = Player.tbAntiBot or {};
Player.tbAntiBot = tbAntiBot;

local AntiEnum = tbAntiBot.tbenum or {};
tbAntiBot.tbenum = AntiEnum;
AntiEnum.WriteLog = 1;
AntiEnum.NoWriteLog = 0;

tbAntiBot.TSKGID				= 2058;	--���������groupID
tbAntiBot.TSK_MANAGEWAY			= 1;	--������ķ�ʽ
tbAntiBot.TSK_MANAGERESULT		= 2;	

--����Ľ��(0��ʾ��δ������1��ʾ�Ѿ����ɹ��������2��ʾ�������������ʧ��,3��ʾδ�������εĴ���)
AntiEnum.NOT_EXECUTE			= 0;
AntiEnum.EXECUTE_SUCCESS		= 1;
AntiEnum.EXECUTE_FAIL			= 2;
AntiEnum.NOT_PUTIN_PRISON		= 3;

tbAntiBot.TSK_CRITICAL_TIME		= 3;	--��¼��ҵĵ÷ֵ�һ�γ��������ٽ�ֵʱ��ʱ��(������)

tbAntiBot.TSK_ALL_PAY			= 4;	--��Ҵ��׵ǿ�ʼ�����ڣ��˺��ϵĳ�ֵ����
tbAntiBot.TSK_MONTIME			= 5;	--��һ��ͳ�Ƴ�ֵ��ʱ�䣬������Ϊ��λ
tbAntiBot.TSK_MONTHPAY			= 6;	--��һ��ͳ��ʱ�ĳ�ֵ���

tbAntiBot.TSK_LAST_SCORE		= 7;	--��¼�����һ�εĴ�ֵ�ʵ�ʵ÷�ֵ
tbAntiBot.TSK_MONEY_RECORD		= 8;	--��ҵĳ�ֵ����tbAntiBot.MIN_MONEYʱ�Ƿ��¼��������Ѿ���¼���Ͳ��ټ�¼��

--DONE:������һ�������������¼��ȡ��ҵĵ÷�ʱ��ʵ�ʵ÷�ֵ
tbAntiBot.TSK_ACTUAL_SCORE		= 9;	--ÿ�δ��ʱ����ȡ��ҵ�ʵ�ʵ÷�ֵ

--�����Ŀ��
tbAntiBot.TSK_ERR_BEGINID		= 100;	--��¼��ִ���������ʼ�������
tbAntiBot.TSK_TOTAL_BEGINID		= 200;	--��¼�ܵĴ�ִ�������ʼ�������

--������ʼ�������
tbAntiBot.STRATEGY_BEGIN		= 300;	--���еĲ���Ҫʹ�õ������������ʼֵ

------------�������---------------

tbAntiBot.ENABLE_ANTIBOT		= 1;	--1��ʾִ�з����ϵͳ��0��ʾ��ִ��
tbAntiBot.DEFAULT_OPERATE		= 1; 	--0��ʾ���д���ʱ���������Σ�ֻ��д��־��¼; ��0��ʾ�����β�д��־(Ĭ��Ϊ0)

--������ҵ÷�ʱ������д��log�ļ��ַ�ʽ	
tbAntiBot.LOG_NEVER_WRITE		= 1;	--1,��д��
tbAntiBot.LOG_WRTIE_ONCE		= 2;	--2,�����ٽ�ֵʱд��һ�Σ��Ժ���д
tbAntiBot.LOG_INTERVAL_WRITE	= 3;	--3,�����ٽ�ֵ�Լ�ÿ�κ�ǰһ�α���ʱ�������ʱ��Ȳ���5��дһ��(Ĭ��Ϊ���ַ�ʽ)
tbAntiBot.WRITELOG_TYPE			= tbAntiBot.LOG_INTERVAL_WRITE;		--Ĭ��Ϊÿ�仯����дһ��log

tbAntiBot.SCORE_INTERVAL		= 5;	--����ÿ�仯5��(����5��)дһ��log

tbAntiBot.CRITICAL_VALUE		= 60;	--�ж�Ϊ��ҵİٷֱ��ٽ�ֵ(0~100֮��)
tbAntiBot.MIN_TOTAL_COUNT		= 3;	--���ٱ���Ҵ�����ƴ����3��
tbAntiBot.CRITICAL_LEVEL		= 50;	--�ж�Ϊ��Һ󣬽�ɫ�ȼ�����50��ʱ��������
tbAntiBot.MIN_MONEY				= 48;	--ͬһ���˺ų�ֵ�ۼƴﵽ48Ԫ�Ͳ����д������Ծɴ��

--��ҵ�״̬
tbAntiBot.PLAYER_LOGIN				= 0;	--��Ҵ������ڵ�½״̬
tbAntiBot.Player_CHANGESERVER_LOGIN	= 1;	--��Ҵ����л�������ʱ�ĵ�½״̬
tbAntiBot.PLAYER_LOGOUT				= 2;	--������ڵǳ�
tbAntiBot.PLAYER_GAMERUNNING 		= 3;	--���������Ϸ��

--��¼��ȡ���ͻ�����Ϣ�Ľ�ɫ����IPΪ����
tbAntiBot.tbRecord 					= {}
--ÿ������ȡ���ٸ�
tbAntiBot.EACH_DAY_NUMBER			= 20;	--��ȡ20�����Բ�ͬIP�ͻ��˵Ľ�����Ϣ

--tbAntiBot�µ�һЩ�ӱ�
tbAntiBot.tbStrategy = {}


--ͬ�����ô�����,ȷ��ĳ�����ʹ����Һ����ѡ��һ�����Խ��д���
function tbAntiBot:ApplyStrategy (pPlayer, nState, nLogFlag, nStrategyIndex)
	local tbList = self.tbStrategy.tbStrategyList;
	local nIndex = 1;
	local nListCount = #tbList;
	if (nStrategyIndex) then
		nIndex = nStrategyIndex;
	else
		nIndex = MathRandom(2, nListCount);
	end
	local tbOne = tbList[nIndex];
	pPlayer.SetTask(self.TSKGID, self.TSK_MANAGEWAY, nIndex);	--д��Ӧ�õĲ���
	if (nLogFlag == AntiEnum.WriteLog) then
		local szLogMsg = string.format("[�����]������Ӧ��\t�˺ţ�%s\t��ɫ����%s\t�ȼ���%d\tIP��ַ��%s\tӦ�õĲ��ԣ�%s\tӦ�ò��Ե�ʱ�䣺%s\t%s", pPlayer.szAccount, pPlayer.szName, pPlayer.nLevel, pPlayer.GetPlayerIpAddress(), tbOne.szName, GetLocalDate("%Y\\%m\\%d  %H:%M:%S"), tbAntiBot.tbScore:ScoreLog(pPlayer));
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_ANTIBOT_PROCESS, szLogMsg);
	end
	tbOne.func(tbOne.obj, pPlayer, nState, nIndex);
	return 0;	--����0������������Timer
end

--�����ں�������ҵ�¼ʱ������ô˺���
function tbAntiBot:Entrance(szAccountName, szRoleName, nState)
	if (self.ENABLE_ANTIBOT == 0) then	--��������ҵĴ���ֱ�ӷ���
		return 0;
	end
	local pPlayer = KPlayer.GetPlayerByName(szRoleName);
	if (not pPlayer) then
		Dbg:Output("Player", "Cannot get player object by Rolename "..szRoleName);
		return 0;
	end;
	local nScore = self:GetRoleScore(pPlayer);
	if (nScore >= self.CRITICAL_VALUE) then		
		local nFirstTime = pPlayer.GetTask(self.TSKGID, self.TSK_CRITICAL_TIME);
		if (nFirstTime == 0) then					--��һ�ε÷ֳ����ٽ�ֵ����¼ʱ��͵÷�
			local nDay = tonumber(GetLocalDate("%Y%m%d"));
			pPlayer.SetTask(self.TSKGID, self.TSK_CRITICAL_TIME, nDay);
			local szLogMsg = string.format("[�����]����ҵ÷ֵ�һ�γ����ٽ�ֵ\t�˺ţ�%s\t��ɫ����%s\t�ȼ���%d\tIP��ַ��%s\t�÷ֵ�һ�γ����ٽ�ֵ��ʱ��:%s\t�÷֣�%d\t�÷��ٽ�ֵ��%d\t%s", szAccountName, szRoleName, pPlayer.nLevel, pPlayer.GetPlayerIpAddress(), GetLocalDate("%Y\\%m\\%d  %H:%M:%S"), nScore, self.CRITICAL_VALUE, tbAntiBot.tbScore:ScoreLog(pPlayer));
			pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_ANTIBOT_SCORE, szLogMsg);
		end
		self:RecordClientProInfo(pPlayer);		--��ȡ�ͻ��˵Ľ�����Ϣ
	else
		return 0;	 --�÷�С���ٽ�ֵ��������
	end
	local nResult = pPlayer.GetTask(self.TSKGID, self.TSK_MANAGERESULT);
	if (nResult == AntiEnum.EXECUTE_SUCCESS) then			--�Ѿ��ɹ���������Ҫ�ٽ��д���
		return 0;
	end
	local nMoney = self:GetPlayerPay(pPlayer);
	if (nMoney >= self.MIN_MONEY) then
		local nDate = tonumber(GetLocalDate("%Y%m%d"));
		local nTskValue = pPlayer.GetTask(self.TSKGID, self.TSK_MONEY_RECORD);
		
		if (nDate ~= nTskValue) then		--���컹δ��¼��
			local szMsgLog = string.format("[�����]������Ϊ��ҵ���ֵ����%dԪ\t�˺ţ�%s\t��ɫ��%s\t�ȼ���%d\tIP��ַ��%s\t�÷֣�%d\t�ۼƳ�ֵ��%dԪ\t��¼ʱ�䣺%s\t��������\t%s", self.MIN_MONEY, pPlayer.szAccount, pPlayer.szName, pPlayer.nLevel, pPlayer.GetPlayerIpAddress(), nScore, nMoney, GetLocalDate("%Y\\%m\\%d  %H:%M:%S"), tbAntiBot.tbScore:ScoreLog(pPlayer));
			pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_ANTIBOT_PROCESS, szMsgLog);
			pPlayer.SetTask(self.TSKGID, self.TSK_MONEY_RECORD, nDate);
		end
		return 0;
	end
	
	local nWay = pPlayer.GetTask(self.TSKGID, self.TSK_MANAGEWAY);
	if (nWay == 0) then				
		if (pPlayer.nLevel < self.CRITICAL_LEVEL) then	--50�����µ���ң��̶�ʹ�ò���1���д���50�����ϵ���ң��ڳ��˲���1�е��������������ѡ��һ�����д���
			self:ApplyStrategy (pPlayer, nState, AntiEnum.WriteLog, 1);
		else
			self:ApplyStrategy (pPlayer, nState, AntiEnum.WriteLog);
		end
	elseif (nState == self.PLAYER_LOGIN or nState == self.Player_CHANGESERVER_LOGIN) then --ֻ���ڵ�¼ʱ��ִ��һ��δִ����ɵĲ���
		self:ApplyStrategy (pPlayer, nState, AntiEnum.NoWriteLog, nWay);
	end
	--0��ʾӦ�ò���ʱ��Ҫдlog��¼ʹ�õĲ��ԣ�1��ʾ����Ҫ��¼
	return 1;
end

--TODO:�޸�GetPlayerPay(pPlayer)��ʵ�֣����³�ֵ������48Ԫ��Ų��������
--�õ���ҳ�ֵ�ܽ��

function tbAntiBot:GetPlayerPay(pPlayer)
	if (not pPlayer) then
		return 0;
	end
	return pPlayer.GetExtMonthPay();
end

--[[
--function tbAntiBot:GetPlayerPay(pPlayer)
--	local nAll 		= pPlayer.GetTask(self.TSKGID, self.TSK_ALL_PAY);	--�ۼ��ܳ�ֵ���
--	local nLastMonth= pPlayer.GetTask(self.TSKGID, self.TSK_MONTIME);   --���һ�γ�ֵ�·�
--	local nLastPay	= pPlayer.GetTask(self.TSKGID, self.TSK_MONTHPAY);  --���һ�γ�ֵ���
	
--	local nThisMonth= tonumber(GetLocalDate("%Y%m"));
--	local nThisPay	= pPlayer.GetExtMonthPay();
	
--	if (nLastMonth == nThisMonth) then		--ͬһ�����ڵ�½��
--		if (nThisPay == nLastPay) then
--			return nAll;
--		else								--����ͳ�ƹ��ĳ�ֵ�͵��³�ֵ����ȣ�����Ҫ�ۼӵ��ۼ�ֵ		
--			nAll = nAll + (nThisPay - nLastPay);			
--		end
--	elseif (nLastMonth < nThisMonth) then	--�����µ�һ����
--		nAll = nAll + nThisPay;
--		pPlayer.SetTask(self.TSKGID, self.TSK_MONTIME, nThisMonth);	--����ͳ���·�
--	end

--	pPlayer.SetTask(self.TSKGID, self.TSK_ALL_PAY, nAll);		--�����ܵ�ͳ�ƽ��
--	pPlayer.SetTask(self.TSKGID, self.TSK_MONTHPAY, nThisPay); 	--���µ����Ѿ�ͳ�ƹ��ĳ�ֵ���
--	return nAll;
--end
--]]


--����nResult��ֵ���޸���ҵ��������ֵ�����ж�Ϊ��ҵĴ������ܵ��ж�����
function tbAntiBot:OnSaveRoleScore(szAccountName, szRoleName, szItemName, bResult)
	if (self.ENABLE_ANTIBOT == 0) then	--��������ҵĴ���ֱ�ӷ���
		return 0;
	end
	
	local pPlayer = KPlayer.GetPlayerByName(szRoleName);
	if (not pPlayer) then
		Dbg:Output("Player", "Cannot get player object by Rolename "..szRoleName);
		return 0;
	end;	
	local tbItemList = Player.tbAntiBot.tbScore.tbItemList;
	local tbOne = tbItemList[szItemName];
	if (not tbOne) then
		Dbg:Output("Player", szItemName.."is not in tbItemList, please check it.");
		return 0;
	end	
	--���ô����Ŀ�ı��溯���������ֵ
	tbOne.fnAddScore(tbOne.obj, pPlayer, bResult, tbOne.nId);
	pcall(tbAntiBot.Entrance, tbAntiBot, szAccountName, szRoleName, self.PLAYER_GAMERUNNING);
	return 1;
end

--��ȡ��ҵĵ÷�
function tbAntiBot:GetRoleScore(pPlayer)
	local nRetScore = 0;
	--����Ƿ��ж�Ϊ���
	if (pPlayer.GetTask(self.TSKGID, self.TSK_CRITICAL_TIME) > 0 ) then  --��ĳ��ʱ�䱻��¼Ϊ��ң��÷�����Ϊ�ٽ�ֵ
		nRetScore = self.CRITICAL_VALUE;
	end
	
	--���ô����Ŀ�Լ��ĺ���ʵ��
	local tbList = tbAntiBot.tbScore.tbItemList;
	local nScore = 0;
	for key, tbOne in pairs(tbList) do
		nScore = nScore + tbOne.fnGetScore(tbOne.obj, pPlayer, tbOne.nId);
	end
	if (nScore > 100) then
		nScore = 100;
	end
	pPlayer.SetTask(self.TSKGID, self.TSK_ACTUAL_SCORE, nScore);
	local nLastScore = pPlayer.GetTask(self.TSKGID, self.TSK_LAST_SCORE);
	if (nLastScore == 0) then
		pPlayer.SetTask(self.TSKGID, self.TSK_LAST_SCORE, nScore);
		nLastScore = nScore;
	end
	
	--��־��¼����(���ж�Ϊ���֮��ż�¼)
	if (pPlayer.GetTask(self.TSKGID, self.TSK_CRITICAL_TIME) > 0 and  self.WRITELOG_TYPE == self.LOG_INTERVAL_WRITE and math.abs(nLastScore - nScore) >= self.SCORE_INTERVAL) then
		--дlog
		local szLogMsg = string.format("[�����]���÷ֱ仯����%d��\t�˺ţ�%s\t��ɫ����%s\t�ȼ���%d\tIP��ַ:%s\tʱ�䣺%s\t�˴ε÷֣�%d\t��һ�μ�¼ʱ�ĵ÷֣�%d\t%s", self.SCORE_INTERVAL, pPlayer.szAccount, pPlayer.szName, pPlayer.nLevel, pPlayer.GetPlayerIpAddress(), GetLocalDate("%Y\\%m\\%d  %H:%M:%S"), nScore, nLastScore, tbAntiBot.tbScore:ScoreLog(pPlayer));
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_ANTIBOT_SCORE, szLogMsg);
		--������һ�α���ķ���
		pPlayer.SetTask(self.TSKGID, self.TSK_LAST_SCORE, nScore);
	end
	if (nScore > nRetScore) then
		nRetScore = nScore;
	end
	return nRetScore;
end

--�ж��Ƿ��Ǳ������ϵͳ�������ε�
function tbAntiBot:IsKilledByAntiBot(pPlayer)
	if (not pPlayer) then
		return 0;
	end
	if (pPlayer.GetTask(self.TSKGID, self.TSK_MANAGERESULT) == AntiEnum.EXECUTE_SUCCESS) then
		return 1;
	end
	return 0;
end

--�����ҵ�����,���������Ϊ�����,������������кͷ������ص��������ֵ
function tbAntiBot:SetPlayerInnocent(szRoleName)
	local pPlayer = KPlayer.GetPlayerByName(szRoleName);
	if (not pPlayer) then
		Dbg:Output("Player", "Cannot get player object by Rolename "..szRoleName);
		return 0;
	end;
	--local nResult = pPlayer.GetTask(self.TSKGID, self.TSK_MANAGERESULT);
	--if (not (pPlayer.GetArrestTime() ~= 0 and nResult == AntiEnum.EXECUTE_SUCCESS)) then	--ȷ������Ƿ���������
	--	Dbg:Output("Player", "player "..szRoleName.." is not in prison.");
	--	return 0;
	--end
	
	--Player:SetFree(szRoleName);
	
	local nStrategyIndex = pPlayer.GetTask(self.TSKGID, self.TSK_MANAGEWAY);
	local tbOne = self.tbStrategy.tbStrategyList[nStrategyIndex];
	if (not tbOne) then
		Dbg:Output("Player", "Get strategy by index "..nStrategyIndex.." is not exist.");
		return 1;
	end
	local szLogMsg = string.format("[�����]���ͷ����\t�˺ţ�%s\t��ɫ��%s\t���ж�Ϊ��ҵ�ʱ�䣺%s\t�ͷŵ�ʱ�䣺%s\tʹ�õĴ�����ԣ�%d\t", pPlayer.szAccount, pPlayer.szName, tostring(pPlayer.GetTask(self.TSKGID, self.TSK_CRITICAL_TIME)), GetLocalDate("%Y\\%m\\%d  %H:%M:%S"), nStrategyIndex);
	local szMsg1 = tbOne.fnGetLogMsg(tbOne.obj, pPlayer);
	local szMsg2 = tbAntiBot.tbScore:ScoreLog(pPlayer);
	szLogMsg = szLogMsg..szMsg1.."\t"..szMsg2;
	
	tbOne.fnClear(tbOne.obj, pPlayer);
	Player.tbAntiBot.tbScore:ClearAllScore(pPlayer);
	--����ͷ������ص��������ֵ
	pPlayer.SetTask(self.TSKGID, self.TSK_MANAGEWAY, 0);		--����ʽ
	pPlayer.SetTask(self.TSKGID, self.TSK_MANAGERESULT, 0);		--������
	pPlayer.SetTask(self.TSKGID, self.TSK_CRITICAL_TIME, 0);	--�ж�Ϊ��ҵ�ʱ��
	pPlayer.SetTask(self.TSKGID, self.TSK_LAST_SCORE, 0);		--��һ�ε�ʵ�ʵ÷�ֵ
	pPlayer.SetTask(self.TSKGID, self.TSK_ACTUAL_SCORE, 0);		--ʵ�ʵ÷�ֵ
	pPlayer.SetTask(self.TSKGID, self.TSK_MONEY_RECORD, 0);		--
	pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_ANTIBOT_PROCESS, szLogMsg);
	return 2;
end

--��ֱ�Ӷ������ε���ҽ�ȳ����Ľӿ�
function tbAntiBot:SaveFromPrison(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return 0;
	end
	if (pPlayer.GetArrestTime() == 0) then	-- ��Ҳ���������
		return 0;
	end
	Player:SetFree(pPlayer.szName);
	local szMsg = string.format("[�����]���ͷ����(�ͷ�ֱ�Ӷ����εĽ�ɫ)\t�˺ţ�%s\t��ɫ��%s\t�ͷŵ�ʱ�䣺%s", me.szAccount, me.szName, GetLocalDate("%Y\\%m\\%d  %H:%M:%S"));
	pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_ANTIBOT_PROCESS, szMsg);
end

--�ռ��ͻ��˵Ľ�����Ϣ��ÿ���ռ�5������ͬ�Ŀͻ��˽�����Ϣ����IP������
function tbAntiBot:RecordClientProInfo(pPlayer)
	local szDate = tostring(GetLocalDate("%Y%m%d"));
	local tbCurDay = self.tbRecord[szDate];
	if (not tbCurDay) then
		for key, tbOne in pairs(self.tbRecord) do		--�ͷ���ǰ�ı�
			self.tbRecord[key] = nil;
		end
		
		tbCurDay = {};		--�����µ�һ�����Ϣ��¼��
		self.tbRecord[szDate] = tbCurDay;
		tbCurDay.nCount = 0;
	end
	if (tbCurDay.nCount >= self.EACH_DAY_NUMBER) then	--�Ѿ��ﵽ�˼�¼������ֱ�ӷ���
		return 0;
	end
	local szIP = pPlayer.GetPlayerIpAddress();
	if (not szIP) then
		return 0;
	end
	--ȥ��IP��ַ�и����Ķ˿ں�
	szIP = string.sub(szIP, 1, string.find(szIP, ":") - 1);
	if (tbCurDay[szIP]) then  --��IP�ϵĽ�����Ϣ�Ѿ���¼����
		return 0;
	end
	
	tbCurDay[szIP] = 1;
	tbCurDay.nCount = tbCurDay.nCount + 1;
	
	--Ĭ�ϻ�ȡ���н��̵ļ���Ϣ,����ͻ��˷��͹��������ݹ������п��ܰ����������	
	Player.tbAntiBot.tbCProInfo:CollectClientProInfo("", pPlayer.szName);		
	return 1;
end

--��ҵ�½ʱ����
function tbAntiBot:OnLogin(bExchangeServerComing)
	if (self.ENABLE_ANTIBOT == 0) then	--��������ҵĴ���ֱ�ӷ���
		return 0;
	end
	
	local tbAntiBot = Player.tbAntiBot;
	if (tbAntiBot) then
		local nState = tbAntiBot.Player_CHANGESERVER_LOGIN;
		if (bExchangeServerComing ~= 1) then	--����֮��ĵ�½
			nState = tbAntiBot.PLAYER_LOGIN;
		end
		tbAntiBot.tbRecover:RecoverPlayer(me);	--�ָ�����
		pcall(tbAntiBot.Entrance, tbAntiBot, me.szAccount, me.szName, nState);
	end
	return 0;
end

--�������ʱ����
function tbAntiBot:OnLogout(szReason)
	if (self.ENABLE_ANTIBOT == 0) then	--��������ҵĴ���ֱ�ӷ���
		return 0;
	end
	
	local nWay = me.GetTask(self.TSKGID, self.TSK_MANAGEWAY);
	local tbOne = self.tbStrategy.tbStrategyList[nWay];
	if (tbOne and tbOne.fnSave) then
		tbOne.fnSave(tbOne.obj, me);
	end
	return 0;
end

--ע���¼�
PlayerEvent:RegisterGlobal("OnLogin", Player.tbAntiBot.OnLogin, Player.tbAntiBot);

PlayerEvent:RegisterGlobal("OnLogout", Player.tbAntiBot.OnLogout, Player.tbAntiBot);
