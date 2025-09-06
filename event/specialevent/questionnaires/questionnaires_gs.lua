-- �ļ�������questionnaires.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-12-17 09:47:03
-- ������  �������ʾ�
if not MODULE_GAMESERVER then
	return 0;	
end

SpecialEvent.Questionnaires = SpecialEvent.Questionnaires or {};
local tbQuest = SpecialEvent.Questionnaires;
tbQuest.EventId = 23;
tbQuest.tbData  = tbQuest.tbData or {};

function tbQuest:OnLogin()
	local tbInfo = self:GetQuestFirstInfo();
	if tbInfo then
		--�򿪿ͻ��˽���
		me.GetTempTable("SpecialEvent").tbQuestionnaires = tbInfo;
		me.CallClientScript({"SpecialEvent.Questionnaires:OnOpen", tbInfo.szUrl});
	end
end

function tbQuest:GetQuestFirstInfo()
	for nEventId , tbPart  in pairs(self.tbData) do
		if nEventId == self.EventId then
	  		for nPartId , tbInfo in pairs(tbPart) do
	        	local nCurDate = tonumber(GetLocalDate("%Y%m%d%H%M"));    
	        	if tbInfo.nStartDate <= nCurDate and (tbInfo.nEndDate == 0 or tbInfo.nEndDate >= nCurDate) then
        			local nCanNoOpenType = 0;
        			if tbInfo.nQuestType == 1 then
        				--��������
        				if self:IsInPlayerList(nEventId, nPartId, me.szName) == 0 then
        					nCanNoOpenType = 1;
        				end
        			end
        			
        			local nCanNoOpenLimit = EventManager.tbFun:CheckParam(tbInfo.tbQuestParam);
        			if nCanNoOpenType ~= 1 and nCanNoOpenLimit ~= 1 then
        				local szUrl 	= EventManager.tbFun:GetParam(tbInfo.tbQuestParam, "LinkQuestUrl", 1)[1];
        				local szParam   = EventManager.tbFun:GetParam(tbInfo.tbQuestParam, "CheckTaskEq", 1)[1];
        				local nTaskId 	= tonumber(EventManager.tbFun:SplitStr(szParam)[1]);
        				szUrl = EventManager.tbFun:SplitStr(szUrl)[1];
        				if szUrl and nTaskId then
        					return {tbParam=tbInfo.tbQuestParam, nTaskId = nTaskId, szUrl = szUrl};
        				end
        			end
	        	end
			end	
		end
	end
end

function tbQuest:OnAnswer(nStaus)
	local tbQuest = me.GetTempTable("SpecialEvent").tbQuestionnaires;
	if not tbQuest then
		me.Msg("�ܱ�Ǹ������д�ĵ����ʾ��ύʧ�ܡ�");
		return 0;
	end
	
	local nQuestTask = tonumber(tbQuest.nTaskId);
	if nStaus ~= 1 or not nQuestTask then
		me.Msg("�ܱ�Ǹ������д�ĵ����ʾ��ύʧ�ܡ�");
		return 0;
	end
	EventManager.tbFun:ExeParam(tbQuest.tbParam);
	--EventManager:SetTask(nQuestTask, 1);	--������һ�Σ�ȷ�������������ϡ�
	me.GetTempTable("SpecialEvent").tbQuestionnaires = nil;
	me.Msg("<color=yellow>�ǳ���л���Ĳ��룬��������֧�ֺ͹������ǻ����ø��á�<color>");
	Dialog:SendBlackBoardMsg(me, "�ǳ���л���Ĳ��룬��������֧�ֺ͹������ǻ����ø��á�");
end

function tbQuest:GetData(nEventId, nPartId, nStartDate, nEndDate, nQuestType, tbQuestParam)
	self.tbData[nEventId] = self.tbData[nEventId] or {};
	self.tbData[nEventId][nPartId] = self.tbData[nEventId][nPartId] or {};
	self.tbData[nEventId][nPartId].nStartDate 	= nStartDate;
	self.tbData[nEventId][nPartId].nEndDate 	= nEndDate;
	self.tbData[nEventId][nPartId].nQuestType	= nQuestType;
	self.tbData[nEventId][nPartId].tbQuestParam = tbQuestParam;
end

function tbQuest:IsInPlayerList(nEventId, nPartId, szName)
	local tbBuf = self:GetGblBuf();
	if not tbBuf or not tbBuf[nEventId] or not tbBuf[nEventId][nPartId] or not tbBuf[nEventId][nPartId][szName] then
		return 0;
	end
	return 1;
end

function tbQuest:OnRecConnectMsg(nEventId, nPartId, szName)
	local tbBuf = self:GetGblBuf();
	tbBuf[nEventId] = tbBuf[nEventId] or {};
	tbBuf[nEventId][nPartId] = tbBuf[nEventId][nPartId] or {};
	tbBuf[nEventId][nPartId][szName] = 1;
end

PlayerEvent:RegisterOnLoginEvent(SpecialEvent.Questionnaires.OnLogin, SpecialEvent.Questionnaires)