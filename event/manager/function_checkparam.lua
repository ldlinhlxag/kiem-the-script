Require("\\script\\event\\manager\\define.lua");
local tbFun = EventManager.tbFun;

--�ѱ�֤��ǰmeΪ���
tbFun.tbLimitParamFun =
{
	CheckTaskDay 		= "CheckTaskDay", 		--Day�����ֻ����ȡMaxCount��:��Ҫ2���������param:dddd
	CheckTask			= "CheckTask", 			--�������>=��ʱ���ز�ͨ��;��Ҫ1���������param:dd
	CheckTaskLt			= "CheckTaskLt", 		--�������<��ʱ���ز�ͨ��;��Ҫ1���������param:dd
	CheckTaskEq			= "CheckTaskEq", 		--�������~=��ʱ���ز�ͨ��;��Ҫ1���������param:dd	
	CheckTaskCurTime	= "CheckTaskCurTime", 	--�����������͵�ǰʱ��Ƚ�
	CheckTaskGotoEvent 	= "CheckTaskGotoEvent", --������ǰ����ĳ��С��¼�������ִ�����溯��

	CheckGTaskDay 		= "CheckGTaskDay", 		--Day�����ֻ����ȡMaxCount��:��Ҫ2���������param:dddd
	CheckGTask			= "CheckGTask", 		--�������>=��ʱ���ز�ͨ��;��Ҫ1���������param:dd
	CheckGTaskLt		= "CheckGTaskLt", 		--�������<��ʱ���ز�ͨ��;��Ҫ1���������param:dd
	CheckGTaskEq		= "CheckGTaskEq", 		--�������==��ʱ���ز�ͨ��;��Ҫ1���������param:dd	
	CheckGTaskCurTime	= "CheckGTaskCurTime", 	--�����������͵�ǰʱ��Ƚ�
	CheckGTaskGotoEvent = "CheckGTaskGotoEvent",--������ǰ����ĳ��С��¼���
	
	CheckExp 		= "CheckExp", 			--���λ�����ֻ�ܻ�þ�������, ��Ҫ1���������param:dd
	CheckExpDay		= "CheckExpDay", 		--Day�����ֻ�ܻ�þ�������ΪExpLimit, ��Ҫ2���������param:dddd
	CheckMonthPay	= "CheckMonthPay", 		--�����ۼƳ�ֵ�ﵽnԪ,param:d
	CheckLevel		= "CheckLevel",			--�ﵽnLevel�ȼ����,param:d
	CheckFaction 	= "CheckFaction",		--���Ƶ��ڸ��������,����ID����,param:d
	CheckCamp 		= "CheckCamp",			--��Ӫ����,param:d
	CheckWeiWang	= "CheckWeiWang",		--���������ﵽn��param:d
	CheckFreeBag	= "CheckFreeBag",		--��鱳���ռ�
	CheckSex		= "CheckSex",			--����Ա�(0,����,1Ů��)
	CheckExt		= "CheckExt",			--���ÿ���ۼƳ�ֵ��չ�����λ�Ƿ����ĳֵ,���ڷ���ʧ��,�Ѽ���
	CheckItemInBag	= "CheckItemInBag",		--��������Ƿ�����Ʒparam:g,d,p,l,n,bool :bool ==0Ϊ����Ҫ����Ʒ����ͨ��
	CheckItemInAll	= "CheckItemInAll",		--�������,�������Ƿ�����Ʒg,d,p,l,n,bool:bool ==0Ϊ����Ҫ����Ʒ����ͨ��
	CheckInMapType	= "CheckInMapType",		--������ڵ�ͼ����
	CheckInMapLevel = "CheckInMapLevel",	--������ڵ�ͼ�ȼ�
	CheckNpcAtNear	= "CheckNpcAtNear",		--���npc�Ƿ��ڸ���
	CheckLuaScript	= "CheckLuaScript",		--�Զ���ű���
	CheckBindMoneyMax= "CheckBindMoneyMax",	--������������
	CheckMoneyMax	= "CheckMoneyMax",		--�����������
	
	CheckMoneyHonor = "CheckMoneyHonor",	--���Ƹ�����
	CheckNpcTaskEq	= "CheckNpcTaskEq",		--���npc��ʱ�������ڣ�npc��ʧ�������
	CheckNpcTaskGt	= "CheckNpcTaskGt",		--���npc��ʱ�������ڣ�npc��ʧ�������
	CheckNpcTaskLt	= "CheckNpcTaskLt",		--���npc��ʱ�������ڣ�npc��ʧ�������
	CheckInKin		= "CheckInKin",			--����Ƿ���ĳ��������
	CheckInTong		= "CheckInTong",		--����Ƿ���ĳ�������
	CheckHaveKin	= "CheckHaveKin",		--����Ƿ��м���
	CheckHaveTong	= "CheckHaveTong",		--����Ƿ��а��
	CheckFuliJingHuoWeiWang="CheckFuliJingHuoWeiWang",--����Ƿ�ﵽ��������Ľ�������
	
	SetAwardId		= "CheckEventAward", 	--������·��,param:string
	SetAwardIdUi	= "CheckEventAwardUi",	--������潱����·��,param:string	
	GoToEvent		= "CheckGoToEvent",		--�¼���ת����ת��ص��������������ִ��
	GoToOtherEvent	= "CheckGoToOtherEvent",--�¼���ת�������¼�����ת��ص��������������ִ��
	--�Զ����
	AddItem 		= "CheckAddItem",			--�����Ʒ
	AddBaseMoney 	= "CheckAddBaseMoney",		--����Ч�ʰ�����
	CoinBuyHeShiBi 	= "CheckCoinBuyHeShiBi",	--����Ƿ��ʸ����ʯ�ڣ�
	DelItem			= "CheckDelItem",			--ɾ����Ʒ
	AddXiulianTime 	= "CheckAddXiulianTime",	--�Լ���������ʱ��
	
	AddBindMoney	= "CheckBindMoneyMax",	  --������������
	AddMoney		= "CheckMoneyMax",		  --�����������		
	
	CheckRandom 		= "CheckRandom",		-- ��鼸��
	CheckAddXiulianTime = "CheckAddXiulianTime",-- �����������ʱ��
	CheckTimeFrame 		= "CheckTimeFrame",     -- ���ʱ����
	AddExBindCoinByPay 	= "CheckExBindCoinByPay",--��ֵ��ȡ��𣨰�һ�����ʷ��أ�
	CheckLoginTimeSpace = "CheckLoginTimeSpace",-- �������һ�ε�½ʱ����NСʱ����
	CheckISCanGetRepute = "CheckISCanGetRepute" -- ����ǲ��Ǽ����˽�����������ȡ
	
};

--������޹صļ�飬���豣֤��ǰmeΪ���
tbFun.tbLimitParamFunWithOutPlayer =
{
	CheckLuaScriptNoMe  = "CheckLuaScript",	--���ýű�
	CheckGDate			= "CheckGDate",		--���ʱ���ж�YYYYmmddHHMM��YYYYmmdd
	CheckWeek			= "CheckWeek",		--����ܼ�
}

--�����ж� START----------------------------

--������(nCheckType -  nil:��ͨ�ļ��,��麯����ִ��;  1:ѡ���麯��,ѡ����ʹ�� 2:��ʾeventId partId�Ҳ���ʱ������) 
function tbFun:CheckParam(tbParam, nCheckType)
	if tbParam== nil then
		tbParam = {};
	end
	
	local nFlagW, szMsgW = self:CheckParamWithOutPlayer(tbParam, nCheckType);
	if nFlagW ~= 0 then
		return nFlagW, szMsgW;
	end
	
	local tbTaskPacth = self:GetParam(tbParam, "SetTaskBatch", 1);
	local nTaskPacth = 0;
	for _, nT in pairs(tbTaskPacth) do
		local nTempId = tonumber(nT) or 0;
		if nTempId > nTaskPacth then
			nTaskPacth = nTempId
		end
	end
	local nFlag = nil;
	if nCheckType == 2 then
		nFlag = 1;
	end
	local nEventId 	= tonumber(self:GetParam(tbParam, "__nEventId",nFlag)[1]);
	local nPartId 	= tonumber(self:GetParam(tbParam, "__nPartId",nFlag)[1]);	
	EventManager:GetTempTable().BASE_nTaskBatch = nTaskPacth;
	EventManager:GetTempTable().CurEventId = nEventId;
	EventManager:GetTempTable().CurPartId  = nPartId;
	local nReFlag = 0;
	local szReMsg = nil;	
	for nParam, szParam in ipairs(tbParam) do
		local nSit = string.find(szParam, ":");
		if nSit and nSit > 0 then
			local szFlag = string.sub(szParam, 1, nSit - 1);
			local szContent = string.sub(szParam, nSit + 1, string.len(szParam));
			if self.tbLimitParamFun[szFlag] ~= nil then
				local fncExcute = self[self.tbLimitParamFun[szFlag]];
				if fncExcute then
					local nFlag, szMsg = fncExcute(self, szContent, tbParam, nCheckType, nTaskPacth);
					if nFlag and nFlag ~= 0 then
						nReFlag = nFlag;
						szReMsg = szMsg;
						break;
						--����������.
					end;
				end
			end
		end
	end
	EventManager:GetTempTable().BASE_nTaskBatch = 0;
	EventManager:GetTempTable().nCurEventId = 0;
	EventManager:GetTempTable().nCurPartId  = 0;
	return nReFlag, szReMsg;
end

function tbFun:CheckParamWithOutPlayer(tbParam, nCheckType)
	if tbParam== nil then
		tbParam = {};
	end
	local tbTaskPacth = self:GetParam(tbParam, "SetTaskBatch", 1);
	local nTaskPacth = 0;
	for nParam, szParam in ipairs(tbParam) do
		local nSit = string.find(szParam, ":");
		if nSit and nSit > 0 then
			local szFlag = string.sub(szParam, 1, nSit - 1);
			local szContent = string.sub(szParam, nSit + 1, string.len(szParam));
			if self.tbLimitParamFunWithOutPlayer[szFlag] ~= nil then
				local fncExcute = self[self.tbLimitParamFunWithOutPlayer[szFlag]];
				if fncExcute then
					local nFlag, szMsg = fncExcute(self, szContent, tbParam, nCheckType, nTaskPacth);
					if nFlag and nFlag ~= 0 then
						return nFlag, szMsg;
						--����������.
					end;
				end
			end
		end
	end
	return 0;
end

--TaskDay:MaxCount, TaskId1, TaskId1	--ÿ�����ֻ����ȡMaxCount��:��Ҫ2���������
function tbFun:CheckTaskDay(szParam, tbGParam, nCheckType, nTaskPacth)
	local tbParam = self:SplitStr(szParam);
	
	local nMaxCount = tonumber(tbParam[1]);
	local nTaskId1 = tonumber(tbParam[2]);
	local nTaskId2 = tonumber(tbParam[3]);
	local szReturnMsg = tbParam[4] or "�����μӵĴ����Ѵ�����";
	local nEventPartId 	= tonumber(tbParam[5]) or 0;
	
	local nTask1 = EventManager:GetTask(nTaskId1, nTaskPacth);
	local nTask2 = EventManager:GetTask(nTaskId2, nTaskPacth);
	local nNowDay = tonumber(GetLocalDate("%Y%m%d"));
	if (nNowDay > nTask2) then
		EventManager:SetTask(nTaskId1, 0);
		EventManager:SetTask(nTaskId2, nNowDay);
	end
	nTask1 = EventManager:GetTask(nTaskId1, nTaskPacth);
	if nTask1 >= nMaxCount and nMaxCount ~= 0 then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

--Task:MaxCount;TaskId									--���λֻ����ȡMaxCount��;��Ҫ1���������
function tbFun:CheckTask(szParam, tbGParam, nCheckType, nTaskPacth)
	local tbParam = self:SplitStr(szParam);

	local nMaxCount = tonumber(tbParam[2]);
	local nTaskId1  = tonumber(tbParam[1]);
	local szReturnMsg = tbParam[3] or "��μӵĴ����Ѵ�����";
	local nEventPartId 	= tonumber(tbParam[4]) or 0;
	local nTask1 = EventManager:GetTask(nTaskId1, nTaskPacth);
	if nTask1 >= nMaxCount then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckTaskLt(szParam, tbGParam, nCheckType, nTaskPacth)
	local tbParam = self:SplitStr(szParam);

	local nMaxCount = tonumber(tbParam[2]);
	local nTaskId1  = tonumber(tbParam[1]);
	local szReturnMsg = tbParam[3] or "��μӵĴ����Ѵ�����";
	local nEventPartId 	= tonumber(tbParam[4]) or 0;
	local nTask1 = EventManager:GetTask(nTaskId1, nTaskPacth);
	if nTask1 < nMaxCount and nMaxCount ~= 0 then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;	
end

function tbFun:CheckTaskEq(szParam, tbGParam, nCheckType, nTaskPacth)
	local tbParam = self:SplitStr(szParam);

	local nMaxCount = tonumber(tbParam[2]);
	local nTaskId1  = tonumber(tbParam[1]);
	local szReturnMsg = tbParam[3] or "��μӵĴ����Ѵ�����";
	local nEventPartId 	= tonumber(tbParam[4]) or 0;
	local nTask1 = EventManager:GetTask(nTaskId1, nTaskPacth);
	if nTask1 ~= nMaxCount then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end


--TaskDay:MaxCount, TaskId1, TaskId1	--ÿ�����ֻ����ȡMaxCount��:��Ҫ2���������
function tbFun:CheckGTaskDay(szParam, tbGParam, nCheckType, nTaskPacth)
	local tbParam = self:SplitStr(szParam);
	
	local nMaxCount = tonumber(tbParam[1]);
	local nGroupId = tonumber(tbParam[2]); 
	local nTaskId1 = tonumber(tbParam[3]);
	local nTaskId2 = tonumber(tbParam[4]);
	local szReturnMsg = tbParam[5] or "�����μӵĴ����Ѵ�����";
	local nEventPartId 	= tonumber(tbParam[6]) or 0;
	
	local nTask1 = me.GetTask(nGroupId, nTaskId1);
	local nTask2 = me.GetTask(nGroupId, nTaskId2);
	local nNowDay = tonumber(GetLocalDate("%Y%m%d"));
	if (nNowDay > nTask2) then
		me.SetTask(nGroupId, nTaskId1, 0);
		me.SetTask(nGroupId, nTaskId2, nNowDay);
	end
	nTask1 = me.GetTask(nGroupId, nTaskId1);
	if nTask1 >= nMaxCount and nMaxCount ~= 0 then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

--Task:MaxCount;TaskId									--���λֻ����ȡMaxCount��;��Ҫ1���������
function tbFun:CheckGTask(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	
	local nGroupId  = tonumber(tbParam[1]);
	local nTaskId1  = tonumber(tbParam[2]);
	local nMaxCount = tonumber(tbParam[3]);
	local szReturnMsg = tbParam[4] or "��μӵĴ����Ѵ�����";
	local nEventPartId 	= tonumber(tbParam[5]) or 0;
	local nTask1 = me.GetTask(nGroupId, nTaskId1);
	if nTask1 >= nMaxCount and nMaxCount ~= 0 then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckGTaskLt(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	
	local nGroupId  = tonumber(tbParam[1]);
	local nTaskId1  = tonumber(tbParam[2]);
	local nMaxCount = tonumber(tbParam[3]);
	local szReturnMsg = tbParam[4] or "��μӵĴ����Ѵ�����";
	local nEventPartId 	= tonumber(tbParam[5]) or 0;
	local nTask1 = me.GetTask(nGroupId, nTaskId1);
	if nTask1 < nMaxCount and nMaxCount ~= 0 then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;	
end

function tbFun:CheckGTaskEq(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	
	local nGroupId  = tonumber(tbParam[1]);
	local nTaskId1  = tonumber(tbParam[2]);
	local nMaxCount = tonumber(tbParam[3]);
	local szReturnMsg = tbParam[4] or "��μӵĴ����Ѵ�����";
	local nEventPartId 	= tonumber(tbParam[5]) or 0;
	local nTask1 = me.GetTask(nGroupId, nTaskId1);
	if nTask1 ~= nMaxCount then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end



--
function tbFun:CheckMonthPay(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local nMonthPayLimit = tonumber(tbParam[1]) or 0;
	local szReturnMsg 	= tbParam[2];
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if not nMonthPayLimit then
		print("���ϵͳ����MonthPay�������ԡ�");
		return 1;
	end
	szReturnMsg = szReturnMsg or string.format("�������ۼ�%sΪ<color=yellow>%s%s<color>�������ۼ�%s�ﵽ<color=yellow>%s%s<color>���ܲμӱ��λ��", IVER_g_szPayName, me.GetExtMonthPay(1), IVER_g_szPayUnit, IVER_g_szPayName, nMonthPayLimit * IVER_g_nPayDouble, IVER_g_szPayUnit);
	if me.GetExtMonthPay() < nMonthPayLimit then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckGDate(szParam)
	local tbParam = Lib:SplitStr(szParam, ",");
	local nStartDate = tonumber(tbParam[1]);
	local nEndDate = tonumber(tbParam[2]);
	local nNowDate = tonumber(GetLocalDate("%Y%m%d%H%M"));
	if nStartDate == -1 then
		return 1, "����Ѿ���ʱ�رա�";
	end
	if nStartDate == 0 and nEndDate == 0 then
		return 0;
	end
	if nStartDate == 0 and nEndDate ~= 0 then
		if nEndDate < nNowDate then
			return 1, "����Ѿ�������";
		end
	end
	if nStartDate ~= 0 and nEndDate == 0 then
		if nStartDate > nNowDate then
			return 1, "�����û��ʼ��";
		end
	end
	if nStartDate ~= 0 and nEndDate ~= 0 then
		if nNowDate < nStartDate or nNowDate > nEndDate then
			return 1, "���ڻ�ڼ䡣";
		end
	end 
	return 0;
end

function tbFun:CheckLevel(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);

	local nLevelParam = tonumber(tbParam[1]);
	local szReturnMsg = tbParam[2];
	if not tbParam[2] or tbParam[2] == "" then
		szReturnMsg = tbParam[2] or string.format("���ĵȼ�û�ﵽҪ����Ҫ�ﵽ%s����", nLevelParam);
	end
	
	
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if me.nLevel < nLevelParam then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckFaction(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szReturnMsg = tbParam[2] or "�������ɲ�����Ҫ��";
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if me.nFaction == tonumber(tbParam[1]) then
		return 0;
	end
	return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
end

function tbFun:CheckCamp(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szReturnMsg = tbParam[2] or "������Ӫ������Ҫ��";
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if me.GetCamp() == tonumber(tbParam[1]) then
		return 0;
	end
	return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);	
end

function tbFun:CheckWeek(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szReturnMsg = tbParam[2] or "���ڲ��ǻ�ڼ䡣";
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if tonumber(GetLocalDate("%w")) == tonumber(tbParam[1]) then
		return 0;
	end
	return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
end

function tbFun:CheckEventAward(nParam)
	nParam = tonumber(nParam);
	if not nParam then
		return 1, "����������";
	end
	if not self.AwardList[nParam] then
		return 1, "����������";
	end

	local nCount = 0;
	local nMoney = 0;
	local nBindMoney = 0;
	for ni, tbItem in ipairs(self.AwardList[nParam].tbAward) do
		if tbItem.nRandRate == 0 and tbItem.nGenre ~= 0 and tbItem.nDetail ~= 0 and tbItem.nParticular ~= 0 then
			if tbItem.nNeedBagFree > 0 then
				nCount = nCount + tbItem.nNeedBagFree;
			else
				nCount = nCount + tbItem.nAmount;
			end
		end
		if tbItem.nRandRate == 0 and tbItem.nJxMoney > 0 then
			nMoney = nMoney + tbItem.nJxMoney;
		end
		if tbItem.nRandRate == 0 and tbItem.nJxBindMoney > 0 then
			nBindMoney = nBindMoney + tbItem.nJxBindMoney;
		end		
	end
	
	if nBindMoney + me.GetBindMoney() > me.GetMaxCarryMoney() then
		return 1, "������ϵİ����������ﵽ���ޣ�������һ�����ϵİ�������";
	end
	
	if nMoney + me.nCashMoney > me.GetMaxCarryMoney() then
		return 1, "������ϵ����������ﵽ���ޣ�������һ�����ϵ�������";
	end	
	
	local nCFlag, szCMsg = self:_CheckItemFree(me, nCount)
	if nCFlag == 1 then
		return 1, szCMsg;
	end	
	
	for ni, tbItem in ipairs(self.AwardList[nParam].tbMareial) do
		local nFlag, szMsg = self:_CheckItem(me, tbItem)
		if nFlag == 1 then
			return 1, szMsg;
		end
	end
	
	return 0;
end

function tbFun:CheckEventAwardUi(szParam)
	local tbParam = self:SplitStr(szParam);
	local nParam = tonumber(tbParam[1]);
	if not nParam then
		return 1, "����������";
	end
	if not self.AwardList[nParam] then
		return 1, "����������";
	end

	local nCount = 0;
	for ni, tbItem in ipairs(self.AwardList[nParam].tbAward) do
		if tbItem.nRandRate == 0 and tbItem.nGenre ~= 0 and tbItem.nDetail ~= 0 and tbItem.nParticular ~= 0 then
			local tbItemInfo = {};
			if self:TimerOutCheck(tbItem.szTimeLimit) == 1 then
				tbItemInfo.bTimeOut = 1;
			end
			
			if tbItem.nBind > 0 then
				tbItemInfo.bForceBind = tbItem.nBind;
			end			
			local nFreeCount = KItem.GetNeedFreeBag(tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel, tbItemInfo, (tbItem.nAmount or 1))
			nCount = nCount + nFreeCount;
		end
	end	
	
	local nCFlag, szCMsg = self:_CheckItemFree(me, nCount)
	if nCFlag == 1 then
		return 1, szCMsg;
	end
	
	return 0;
end

function tbFun:_CheckItem(pPlayer, tbItem)
	if tbItem.nJxMoney ~= 0 then
		if pPlayer.nCashMoney < tbItem.nJxMoney then
			return 1, "�Բ��������ϵ��������㡣";
		end
	end
	
	if tbItem.nJxBindMoney ~= 0 then
		if pPlayer.GetBindMoney() + pPlayer.nCashMoney < tbItem.nJxBindMoney then
			return 1, "�Բ��������ϵ��������㡣";
		end
	end
	
	if tbItem.nJxCoin ~= 0 then
		if pPlayer.nBindingCoinMoney < tbItem.nJxCoin then
			return 1, string.format("�Բ������İ�%s���㡣", IVER_g_szCoinName);
		end
	end
	
	if tbItem.nGenre ~= 0 and tbItem.nDetail ~= 0 and tbItem.nParticular ~= 0 then
		local nCount = pPlayer.GetItemCountInBags(tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel, tbItem.nSeries);
		if nCount < tbItem.nAmount then
			return 1, "�Բ���������Ʒ���㡣";
		end
	end	
	return 0;
end

function tbFun:_CheckItemFree(pPlayer, nCount)
	if nCount > 0 and pPlayer.CountFreeBagCell() < nCount then
		return 1, string.format("�Բ��������ϵı����ռ䲻�㣬��Ҫ%s�񱳰��ռ䡣", nCount);
	end
	return 0;
end

function tbFun:CheckWeiWang(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nWeiWangLimit = tonumber(tbParam[1]) or 0;
	local szReturnMsg = tonumber(tbParam[2]) or string.format("���Ľ�����������%s�㣬���ܲμӱ��λ��", nWeiWangLimit);
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if me.nPrestige < nWeiWangLimit then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckAddItem(szParam)
	local tbParam 	= self:SplitStr(szParam);
	local tbItem 	= self:SplitStr(tbParam[1]);
	local nG	  	= tonumber(tbItem[1]);
	local nD		= tonumber(tbItem[2]);
	local nP		= tonumber(tbItem[3]);
	local nL		= tonumber(tbItem[4]);
	local nCount	= tonumber(tbParam[2]);
	local nBind		= tonumber(tbParam[3]);
	local nTimeOut	= tonumber(tbParam[4]);
	local nNeed = KItem.GetNeedFreeBag(nG, nD, nP, nL, {bTimeOut=nTimeOut}, nCount);
	if me.CountFreeBagCell() < nNeed then
		return 1, string.format("�Բ��������ϵı����ռ䲻�㣬��Ҫ%s�񱳰��ռ䡣", nNeed);
	end
	return 0;
end

function tbFun:CheckFreeBag(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nCount	= tonumber(tbParam[1]);
	local szReturnMsg = tbParam[2] or string.format("�Բ��������ϵı����ռ䲻�㣬��Ҫ%s�񱳰��ռ䡣", nCount);
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if me.CountFreeBagCell() < nCount then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckBindMoneyMax(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nCount	= tonumber(tbParam[1]);
	local szReturnMsg = tbParam[2] or string.format("�Բ��������ϵİ������������ޣ������������ϵİ�������");
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if me.GetBindMoney() + nCount > me.GetMaxCarryMoney() then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckMoneyMax(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nCount	= tonumber(tbParam[1]);
	local szReturnMsg = tbParam[2] or string.format("�Բ��������ϵ������������ޣ������������ϵ�������");
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if me.nCashMoney + nCount > me.GetMaxCarryMoney() then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckMoneyHonor(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nHonor	= tonumber(tbParam[1]);
	local szReturnMsg = tbParam[2] or string.format("�Բ������ĲƸ�����û�ﵽ%s�㡣", nHonor);
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if PlayerHonor:GetPlayerHonorByName(me.szName, 8, 0) < nHonor then
		EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		return 1, szReturnMsg;
	end	
	return 0;
end

function tbFun:CheckSex(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nSex = tonumber(tbParam[1]);
	local szReturnMsg = tbParam[2] or string.format("�Բ���ֻ��%s��Ҳ�����ȡ��", Env.SEX_NAME[nSex]);
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if not Env.SEX_NAME[nSex] then
		print("���ϵͳ��Sex��������");
		return 1;
	end
	if nSex ~= me.nSex then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckExt(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nBit		= tonumber(tbParam[1]);
	local nExt 		= tonumber(tbParam[2]);
	local szReturnMsg = tbParam[3] or "����ʺ��Ѿ�������";
	local nEventPartId 	= tonumber(tbParam[4]) or 0;
	if me.GetActiveValue(nBit) ~= nExt then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckItemInBag(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local szItem 	= tbParam[1];
	local nCount 	= tonumber(tbParam[2]) or 1;
	local bInOrOut 	= tonumber(tbParam[3]) or 0;
	local szReturnMsg 	= tbParam[4] or string.format("��ӵ�е�%s������Ҫ��", KItem.GetNameById(unpack(tbItem)));
	local nEventPartId 	= tonumber(tbParam[5]) or 0;	
	local tbItem 	= self:SplitStr(szItem);
	local nBagCount = me.GetItemCountInBags(unpack(tbItem)) or 0;
	if bInOrOut == 0 then
		if nBagCount < nCount then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	else
		if nBagCount >= nCount then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end
	return 0;
end

function tbFun:CheckItemInAll(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local szItem 	= tbParam[1];
	local nCount 	= tonumber(tbParam[2]);
	local bInOrOut 	= tonumber(tbParam[3]) or 0;
	local szReturnMsg 	= tbParam[4];
	local nEventPartId 	= tonumber(tbParam[5]) or 0;	
	local tbItem 	= self:SplitStr(szItem);
	local tbFind = me.FindItemInBags(unpack(tbItem));
	local tbFind2 = me.FindItemInRepository(unpack(tbItem));
	if bInOrOut == 0 then
		if #tbFind + #tbFind2 <  nCount then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	else
		if #tbFind + #tbFind2 >=  nCount then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end
	return 0;
end

function tbFun:CheckInMapType(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local szType 	= tbParam[1];
	local bInOrOut 	= tonumber(tbParam[2]) or 0;
	local szReturnMsg 	= tbParam[3];
	local nEventPartId 	= tonumber(tbParam[4]) or 0;	
	
	local nMapIndex = SubWorldID2Idx(me.nMapId);
	local nMapTemplateId = SubWorldIdx2MapCopy(nMapIndex);
	local szMapType = GetMapType(nMapTemplateId);
	if bInOrOut == 0 then	--������szType���͵ĵ�ͼ
		if szType ~= szMapType then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	else
		if szType == szMapType then --���벻��szType���͵ĵ�ͼ
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end	
	end

	return 0;
end

function tbFun:CheckInMapLevel(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nLevel 	= tbParam[1];
	local bInOrOut 	= tonumber(tbParam[2]) or 0;
	local szReturnMsg 	= tbParam[3];
	local nEventPartId 	= tonumber(tbParam[4]) or 0;	
	
	local nMapIndex = SubWorldID2Idx(me.nMapId);
	local nMapTemplateId = SubWorldIdx2MapCopy(nMapIndex);
	local nMapLevel = GetMapLevel(nMapTemplateId);
	if bInOrOut == 0 then --������nMapLevel�ȼ����ϵĵ�ͼ������nMapLevel��
		if nMapLevel < nLevel then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	elseif bInOrOut == 1 then --�������nMapLevel�ȼ��ĵ�ͼ
		if nMapLevel ~= nLevel then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end		
	else
		--����С��nMapLevel�ȼ��ĵ�ͼ��������nMapLevel��
		if nMapLevel >= nLevel then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end

	return 0;
end


function tbFun:CheckDialogNpcAtNear(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local szReturnMsg 	= tbParam[1] or string.format("�㸽����%s�ڣ����븽��û�������Ի�npc����", pNpc.szName);
	local nEventPartId 	= tonumber(tbParam[2]) or 0;	
	
	local tbNpcList = KNpc.GetAroundNpcList(me, 10);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc.nKind == 3 then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end
	return 0;
end


function tbFun:CheckNpcAtNear(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nNpcId 	= tonumber(tbParam[1]) or 0;
	local bBeLong 	= tonumber(tbParam[2]) or 0;
	local szReturnMsg 	= tbParam[3] or "�㸽���Ҳ�������Ҫ��npc";
	local nEventPartId 	= tonumber(tbParam[4]) or 0;	
	local nFind = 0;
	local tbNpcList = KNpc.GetAroundNpcList(me, 20);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc.nTemplateId == nNpcId then
			if bBeLong == 1 then
				if pNpc.GetTempTable("Npc").EventManager then
					if pNpc.GetTempTable("Npc").EventManager.nBeLongPlayerId == me.nId then
						nFind = 1;
						break
					end
				end
			else
				nFind = 1;
				break;
			end
		end
	end	
	if nFind == 0 then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckTaskCurTime(szParam, tbGParam, nCheckType, nTaskPacth)
	local tbParam 	= self:SplitStr(szParam);
	local nTaskId 	= tonumber(tbParam[1]) or 0;
	local nSec 		= tonumber(tbParam[2]) or 0;
	local nType 	= tonumber(tbParam[3]) or 0;
	local szReturnMsg 	= tbParam[4] or "";
	local nEventPartId 	= tonumber(tbParam[5]) or 0;	
	if EventManager:GetTask(nTaskId, nTaskPacth) == 0 then
		return 0;
	end
	if nType == 0 then --�����n���ڵ������������
		if EventManager:GetTask(nTaskId, nTaskPacth) + nSec > GetTime() then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end
	if nType == 1 then --�����n����������������
		if EventManager:GetTask(nTaskId, nTaskPacth) + nSec < GetTime() then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end
	return 0;
end

--��ת��������ִ��
function tbFun:CheckTaskGotoEvent(szParam, tbGParam, nCheckType, nTaskPacth)
	local tbParam 	= self:SplitStr(szParam);
	local nTaskId 	= tonumber(tbParam[1]) or 0;
	local nValue 	= tonumber(tbParam[2]) or 0;
	local nType 	= tonumber(tbParam[3]) or 0;
	local nEventPartId 	= tonumber(tbParam[4]) or 0;
	local nEventId 	= tonumber(self:GetParam(tbGParam, "__nEventId")[1]);
	local nPartId 	= tonumber(self:GetParam(tbGParam, "__nPartId")[1]);
	if nEventPartId == nPartId then
		print("���ϵͳ��Error!!!CheckTaskGotoEvent�ظ������Լ�");
		return 0;
	end
	if nType == 0 then--����
		if EventManager:GetTask(nTaskId, nTaskPacth) == nValue then
			return EventManager:GotoEventPartTable(nEventId, nEventPartId, nCheckType, nil, 2);
		end
	end
	if nType == 1 then--С��
		if EventManager:GetTask(nTaskId, nTaskPacth) < nValue then
			return EventManager:GotoEventPartTable(nEventId, nEventPartId, nCheckType, nil, 2);
		end
	end
	if nType == 2 then--����
		if EventManager:GetTask(nTaskId, nTaskPacth) > nValue then
			return EventManager:GotoEventPartTable(nEventId, nEventPartId, nCheckType, nil, 2);
		end		
	end	
	return 0;
end

function tbFun:CheckGTaskCurTime(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nGroupId 	= tonumber(tbParam[1]) or 0;
	local nTaskId 	= tonumber(tbParam[2]) or 0;
	local nSec 		= tonumber(tbParam[3]) or 0;
	local nType 	= tonumber(tbParam[4]) or 0;
	local szReturnMsg 	= tbParam[5] or "";
	local nEventPartId 	= tonumber(tbParam[6]) or 0;	
	if me.GetTask(nGroupId, nTaskId) == 0 then
		return 0;
	end
	if nType == 0 then --�����n���ڵ������������
		if me.GetTask(nGroupId, nTaskId) + nSec > GetTime() then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end
	if nType == 1 then --�����n����������������
		if me.GetTask(nGroupId, nTaskId) + nSec < GetTime() then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end
	return 0;
end

function tbFun:CheckGTaskGotoEvent(szParam, tbGParam, nCheckType)
	local tbParam 	= self:SplitStr(szParam);
	local nGroupId 	= tonumber(tbParam[1]) or 0;
	local nTaskId 	= tonumber(tbParam[2]) or 0;
	local nValue 	= tonumber(tbParam[3]) or 0;
	local nType 	= tonumber(tbParam[4]) or 0;
	local nEventPartId 	= tonumber(tbParam[5]) or 0;
	local nEventId 	= tonumber(self:GetParam(tbGParam, "__nEventId")[1]);
	local nPartId 	= tonumber(self:GetParam(tbGParam, "__nPartId")[1]);
	if nEventPartId == nPartId then
		print("���ϵͳ��Error!!!CheckTaskGotoEvent�ظ������Լ�");
		return 0;
	end
	if nType == 0 then--����
		if me.GetTask(nGroupId, nTaskId) == nValue then
			return EventManager:GotoEventPartTable(nEventId, nEventPartId, nCheckType);
		end
	end
	if nType == 1 then--С��
		if me.GetTask(nGroupId, nTaskId) < nValue then
			return EventManager:GotoEventPartTable(nEventId, nEventPartId, nCheckType);
		end
	end
	if nType == 2 then--����
		if me.GetTask(nGroupId, nTaskId) > nValue then
			return EventManager:GotoEventPartTable(nEventId, nEventPartId, nCheckType);
		end		
	end	
	return 0;
end

function tbFun:CheckLuaScript(szParam, tbGParam, nCheckType)
	local tbParam = self:SplitStr(szParam);
	local szScript = tbParam[1];
	local nEventPartId 	= tonumber(tbParam[2]) or 0;	
	
	szScript = string.gsub(szScript, "<enter>", "\n");
	szScript = string.gsub(szScript, "<tab>", "\t");
	local nReturn, szReturnMsg = loadstring(szScript)();
	if nReturn == 1 then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam, nCheckType);
	end
	return nReturn;
end

function tbFun:CheckAddBaseMoney(szParam, tbGParam, nCheckType)
	local tbParam = self:SplitStr(szParam);
	local nMoney  = tonumber(tbParam[1]) or 0;
	local nType   = tonumber(tbParam[2]) or 0;
	local nLimit  = tonumber(tbParam[3]) or 0 ;
	local nAdd = math.floor(nMoney * me.GetProductivity() / 100);
	if nLimit > 0 and nAdd > nLimit then
		nAdd = nLimit;
	end
	if nType == 1 then
	 	local nMoneyInBag = me.nCashMoney;
	 	local szType = "����";	
	 	if nMoneyInBag + nAdd > me.GetMaxCarryMoney() then
			return 1, string.format("�����ϵ�%s��Ҫ�ﵽ���ޣ��������������ȡ��", szType);
		end
	elseif nType == 7 then
		local nMoneyInBag = me.GetBindMoney();
		local szType = "������";
	 	if nMoneyInBag + nAdd > me.GetMaxCarryMoney() then
			return 1, string.format("�����ϵ�%s��Ҫ�ﵽ���ޣ��������������ȡ��", szType);
		end			
	end
	return 0;
end

function tbFun:CheckCoinBuyHeShiBi(szParam, tbGParam, nCheckType)
	if SpecialEvent.BuyHeShiBi:Check() == 0 then
		return 1;
	end
	return 0;
end

function tbFun:CheckGoToEvent(szParam, tbGParam, nCheckType)
	local tbParam = self:SplitStr(szParam);
	local nEventPartId 	= tonumber(tbParam[1]) or 0;

	if nEventPartId > 0 then
		local nEventId 	= tonumber(self:GetParam(tbGParam, "__nEventId")[1]);
		local nPartId 	= tonumber(self:GetParam(tbGParam, "__nPartId")[1]);
		if nEventPartId == nPartId then
			print("���ϵͳ��Error!!!CheckTaskGotoEvent�ظ������Լ�");
			return 0;
		end
		return EventManager:GotoEventPartTable(nEventId, nEventPartId, 1);
	end
end

function tbFun:CheckGoToOtherEvent(szParam, tbGParam, nCheckType)
	local tbParam = self:SplitStr(szParam);
	local nEventEId 	= tonumber(tbParam[1]) or 0;
	local nEventPartId 	= tonumber(tbParam[2]) or 0;
	if nEventPartId > 0 then
		local nEventId 	= tonumber(self:GetParam(tbGParam, "__nEventId")[1]);
		local nPartId 	= tonumber(self:GetParam(tbGParam, "__nPartId")[1]);
		if nEventEId == nEventId and nEventPartId == nPartId then
			print("���ϵͳ��Error!!!CheckTaskGotoEvent�ظ������Լ�");
			return 0;
		end
		return EventManager:GotoEventPartTable(nEventEId, nEventPartId, 1);
	end	
end

function tbFun:CheckNpcTaskEq(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szKey 		= tbParam[1] or 0;
	local nTskValue 	= tonumber(tbParam[2]) or 0;
	local szReturnMsg 	= tbParam[3] or "������������㡣";
	if not him then
		return 1, szReturnMsg;
	end
	local tbTable = him.GetTempTable("Npc");
	tbTable.EventManager = tbTable.EventManager or {};
	tbTable.EventManager.tbTask = tbTable.EventManager.tbTask or {};
	tbTable.EventManager.tbTask[szKey] = tbTable.EventManager.tbTask[szKey] or {};
	local nValue = tonumber(tbTable.EventManager.tbTask[szKey][me.nId]) or 0;
	if nTskValue ~= nValue then
		return 1, szReturnMsg;
	end
	return 0;
end

function tbFun:CheckNpcTaskGt(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szKey 		= tbParam[1] or 0;
	local nTskValue 	= tonumber(tbParam[2]) or 0;
	local szReturnMsg 	= tbParam[3] or "������������㡣";
	if not him then
		return 1, szReturnMsg;
	end
	local tbTable = him.GetTempTable("Npc");
	tbTable.EventManager = tbTable.EventManager or {};
	tbTable.EventManager.tbTask = tbTable.EventManager.tbTask or {};
	tbTable.EventManager.tbTask[szKey] = tbTable.EventManager.tbTask[szKey] or {};
	local nValue = tonumber(tbTable.EventManager.tbTask[szKey][me.nId]) or 0;
	if nTskValue >= nValue then
		return 1, szReturnMsg;
	end
	return 0;
end

function tbFun:CheckNpcTaskLt(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szKey 		= tbParam[1] or 0;
	local nTskValue 	= tonumber(tbParam[2]) or 0;
	local szReturnMsg 	= tbParam[3] or "������������㡣";
	if not him then
		return 1, szReturnMsg;
	end
	local tbTable = him.GetTempTable("Npc");
	tbTable.EventManager = tbTable.EventManager or {};
	tbTable.EventManager.tbTask = tbTable.EventManager.tbTask or {};
	tbTable.EventManager.tbTask[szKey] = tbTable.EventManager.tbTask[szKey] or {};
	local nValue = tonumber(tbTable.EventManager.tbTask[szKey][me.nId]) or 0;	
	if nTskValue <= nValue then
		return 1, szReturnMsg;
	end
	return 0;
end

-- by zhangjinpin@kingsoft
function tbFun:CheckAddXiulianTime(szParam, tbGParam)	
	
	local tbParam = self:SplitStr(szParam);
	local nTime = tonumber(tbParam[1]) or 0;
	local szReturnMsg = tbParam[2] or "����ȡ�����������ʱ�䳬�������ޣ�";	
	
	local tbXiuLianZhu = Item:GetClass("xiulianzhu");
	if tbXiuLianZhu:GetReTime() + nTime > 14 then
		return 1, szReturnMsg;
	end
	
	return 0;
end

function tbFun:CheckRandom(szParam, tbGParam)
	
	local tbParam = self:SplitStr(szParam);
	local nMin = tonumber(tbParam[1]) or 1;
	local nMax = tonumber(tbParam[2]) or 1;
	local szReturnMsg = tbParam[3] or "������������㡣";	
	
	local nRandom = MathRandom(1, nMax);
	if nRandom > nMin then
		return 1, szReturnMsg;
	end
	
	return 0;
end

function tbFun:CheckFuliJingHuoWeiWang(szParam, tbGParam)
	local nPrestige = Player.tbBuyJingHuo:GetTodayPrestige()
	if (nPrestige <= 0) then
		return 1, "��û����ȫ�������������޷�֪��������Ż�����Ҫ�����������������";
	end
	
	if (me.nPrestige < nPrestige) then
		return 1, "��Ľ�����������<color=red>"..nPrestige.."��<color>��";
	end
	return 0;
end

function tbFun:CheckTimeFrame(szParam, tbGParam)	
	local tbParam = self:SplitStr(szParam);
	local szClass = tbParam[1];
	local nReqState = tonumber(tbParam[2]) or 1;
	local szReturnMsg = tbParam[3] or "������������㡣";	
	local nCurState = TimeFrame:GetState(szClass);
	if nCurState == nReqState then 
		return 0;	
	end
	return 1 , szReturnMsg;
end

function tbFun:CheckExBindCoinByPay(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local nTaskId = tonumber(tbParam[1]) or 0;
	local nMinMoney = tonumber(tbParam[2]) or 0;
	local nMaxMoney = tonumber(tbParam[3]) or 0;
	local nRate = tonumber(tbParam[4]) or 0;
	local nPay = me.GetExtMonthPay();
	if nMaxMoney < nPay and nMaxMoney ~= 0 then
		nPay = nMaxMoney;
	end
	local nCount = math.floor((nPay - nMinMoney)/ 50);
	if nCount == 0 then
		return 1,  string.format("��ֵ����%s�ſ�����ȡ(�����Ĳ���ÿ50����%s��)��", nMinMoney, nRate);
	end
	if EventManager:GetTask(nTaskId) >= nCount then
		return 1,  string.format("���͵�%s�󶨽���Ѿ��ɹ���ȡ��ϣ�������ֵ�ſ����ٴ��콱(�����Ĳ���ÿ50����%s��)��", nCount*50 * nRate, nRate);
	end
	return 0;
end

function tbFun:CheckInKin(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szKins = tbParam[1];
	local tbKins = Lib:SplitStr(szKins, "&");
	local nFigure = tonumber(tbParam[2]) or 0;
	local szReturnMsg = tbParam[3] or "�Բ����������������㡣";
	local nKinId, nKinMemId = me.GetKinMember();
	if nKinId == nil or nKinId <= 0 then
		return 1, "�Բ��������Ǽ����Ա��";
	end
	
	if nFigure > 0 and Kin:HaveFigure(nKinId, nKinMemId, nFigure) ~= 1 then
		return 1, "�Բ������ļ���Ȩ������������";
	end	
	local cKin = KKin.GetKin(nKinId);
	local szKinName = cKin.GetName();	
	for _, szKin in pairs(tbKins) do
		if szKin == szKinName then
			return 0;
		end
	end
	return 1, szReturnMsg;
end

function tbFun:CheckInTong(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szTongs = tbParam[1];
	local tbTongs = Lib:SplitStr(szTongs, "&");
	local nFigure = tonumber(tbParam[2]) or 0;
	local szReturnMsg = tbParam[3] or "�Բ����������������㡣";
	local nTongId = me.dwTongId;
	if nTongId == nil or nTongId <= 0 then
		return 1, "�Բ��������ǰ���Ա��";
	end
	
	local cTong = KTong.GetTong(nTongId)
	if not cTong then
		return 1, "�Բ��������ǰ���Ա��";
	end
	
	local szTongName = cTong.GetName();
	
	local nKinId, nKinMemId = me.GetKinMember();
	if nKinId == nil or nKinId <= 0 then
		return 1, "�Բ��������ǰ���Ա��";
	end
	
	if nFigure > 0 and Kin:HaveFigure(nKinId, nKinMemId, nFigure) ~= 1 then
		return 1, "�Բ������ļ���Ȩ������������";
	end	
	for _, szTongs in pairs(tbTongs) do
		if szTongs == szTongName then
			return 0;
		end
	end
	return 1, szReturnMsg;	
end

function tbFun:CheckHaveKin(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local nFigure = tonumber(tbParam[1]) or 0;
	local szReturnMsg = tbParam[2] or "�Բ��������Ǽ����Ա��";
	local nKinId, nKinMemId = me.GetKinMember();
	if nKinId == nil or nKinId <= 0 then
		return 1, szReturnMsg;
	end
	if nFigure > 0 and Kin:HaveFigure(nKinId, nKinMemId, nFigure) ~= 1 then
		return 1, szReturnMsg;
	end
	return 0;
end

function tbFun:CheckHaveTong(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local nFigure = tonumber(tbParam[1]) or 0;
	local szReturnMsg = tbParam[2] or "�Բ��������ǰ���Ա��";
	local nTongId = me.dwTongId;
	if nTongId == nil or nTongId <= 0 then
		return 1, szReturnMsg;
	end
	
	local cTong = KTong.GetTong(nTongId)
	if not cTong then
		return 1, szReturnMsg;
	end
	
	local nKinId, nKinMemId = me.GetKinMember();
	if nKinId == nil or nKinId <= 0 then
		return 1, szReturnMsg;
	end
	
	if nFigure > 0 and Kin:HaveFigure(nKinId, nKinMemId, nFigure) ~= 1 then
		return 1, szReturnMsg;
	end	

	return 0;		
end

function tbFun:CheckLoginTimeSpace(szParam)
	local tbParam = self:SplitStr(szParam);
	local nNumber = tonumber(tbParam[1]) or 0;
	local szReturnMsg = tbParam[2] or "����½�����Сʱ�����㵱ǰ����Сʱ����";
	local nLastLoginTime = me.GetTask(2063, 16) or 0;
	local nData = me.GetTask(2063, 17) or 0;
	if nData - nLastLoginTime < nNumber*3600 then
		return 1, szReturnMsg;
	end
	if nLastLoginTime == 0 or nData == 0 then
		return 1, szReturnMsg;
	end
	return 0;
end

function tbFun:CheckISCanGetRepute(szParam)
	local tbParam = self:SplitStr(szParam);
	local szReturnMsg = tbParam[1] or "����û�м�����ȡ�������������Ե��������ȥ���";
	if SpecialEvent.ChongZhiRepute:CheckISCanGetRepute() == 0 then
		return 1, szReturnMsg;
	end
	return 0;
end

function tbFun:CheckDelItem(szParam)
	local tbParam 	= self:SplitStr(szParam);
	local szItem	= tbParam[1];
	local nCount	= tonumber(tbParam[2]) or 1;
	local tbItem 	= self:SplitStr(szItem);
	local nBagCount = me.GetItemCountInBags(unpack(tbItem)) or 0;
	if nBagCount < nCount then
		return 1, string.format("�����ϱ����е���Ʒ<color=yellow>%s<color>��������<color=red>%s��<color>��", KItem.GetNameById(unpack(tbItem)), nCount);
	end
	return 0;
end

---�����ж� END ------------
