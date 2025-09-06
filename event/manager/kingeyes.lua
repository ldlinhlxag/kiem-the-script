-- �ļ�������kingeyes.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-09-01 11:20:39
-- ��  ��  ����Ӫƽ̨֧��
Require("\\script\\event\\manager\\function.lua");

local tbEyes = EventManager.KingEyes;
tbEyes.EVENT_PARAM_MAX = EventManager.EVENT_PARAM_MAX; -- ExParam������Ŀ
tbEyes.EVENT_QUESTPARAM_MAX = 10;		--�����ʾ������Ŀ
tbEyes.EVENT_OPEN  = 20;			--��Ӫƽ̨�������eventId

if (MODULE_GC_SERVER) then
	
function tbEyes:GetGblBuf()
	self.tbGblBuf = self.tbGblBuf or {};
	return self.tbGblBuf;
end

function tbEyes:SetGblBuf(tbBuf)
	self.tbGblBuf = tbBuf;
	SetGblIntBuf(GBLINTBUF_KINGEYES_EVENT, 0, 1, tbBuf);              --set buff 
end

--��õ�ǰ������е��¼�
function tbEyes:GetGblBufCurEffectString()
	local tbBuff = self:GetGblBuf();
	local szReMsg = "\n";
	local nCurDate = tonumber(GetLocalDate("%Y%m%d%H%M"));
	for nEId, tbEvent in pairs(tbBuff) do
		if tbEvent.tbPart then
			for nPId, tbPard in pairs(tbEvent.tbPart) do
				local tbParam = EventManager.tbFun:GetParam(tbPard.tbExParam, "Npc", 1);
				if #tbParam > 0 or nEId == self.EVENT_OPEN then
					local szIsOpen = "�ѿ���";
					if tbPard.nEndDate > 0 and nCurDate > tbPard.nEndDate then
						szIsOpen = "�ѹ���";
					end
					if tbPard.nStartDate > 0 and nCurDate < tbPard.nStartDate then 
						szIsOpen = "δ����";
					end
					szReMsg = szReMsg ..string.format("%s\t%s\t%s\t%s\t%s\t%s\n", nEId, nPId,tbPard.nStartDate,tbPard.nEndDate,szIsOpen,tbPard.szName);
				end
			end
		end	
	end
	return szReMsg;
end

function tbEyes:CloseEvent(nEId, nPId)
	local tbBuff = self:GetGblBuf();
	if not tbBuff[nEId] then
		return 0;
	end
	if not tbBuff[nEId].tbPart or not tbBuff[nEId].tbPart[nPId] then
		return 0;
	end
	local tbEvent = {};
	tbEvent[nEId] = {};
	tbEvent[nEId].tbPart = {};
	tbEvent[nEId].tbPart[nPId] = tbBuff[nEId].tbPart[nPId];
	tbEvent[nEId].tbPart[nPId].nStartDate = 200909010000;
	tbEvent[nEId].tbPart[nPId].nEndDate =   200909020000;
	self:SaveBuf(tbEvent);    
	self:UpdateEvent(tbEvent);
	return 1;
end

function tbEyes:LoadFile(szPath, szQuestPlayerListPath)
	local tbFile = Lib:LoadTabFile(szPath);
	if not tbFile then
		print("EventManager.KingEyes�ļ����ش���~~~", szPath);
		return;
	end
	local nQuestType = 0;
	local nTmpEventId;
	local nTmpPartId;
	if szQuestPlayerListPath then
		nQuestType = 1;
	end
	local tbEvent = {};
	for nId, tbParam in ipairs(tbFile) do	
		local nEventId = tonumber(tbParam.EventId) or 0;
		local nPartId  = tonumber(tbParam.PartId) or 0; 
		nTmpEventId = nTmpEventId or nEventId;
		nTmpPartId  = nTmpPartId or nPartId;
		local nStartDate = EventManager.tbFun:ClearString(tbParam.StartDate);
		local nEndDate = EventManager.tbFun:ClearString(tbParam.EndDate);
	    nStartDate , nEndDate = EventManager.tbFun:DateFormat(nStartDate, nEndDate);		
		if not nEndDate then
			print("EventManager.KingEyes���ϵͳ����ʱ���ʽ����");
			return;
		end	
		tbEvent[nEventId] = tbEvent[nEventId] or {};
		tbEvent[nEventId].tbPart = tbEvent[nEventId].tbPart or {};
		tbEvent[nEventId].tbPart[nPartId] = {};	
		tbEvent[nEventId].tbPart[nPartId].szName = EventManager.tbFun:ClearString(tbParam.Name);
		tbEvent[nEventId].tbPart[nPartId].szSubKind = EventManager.tbFun:ClearString(tbParam.SubKind);
		if tbEvent[nEventId].tbPart[nPartId].szSubKind == "" then
			tbEvent[nEventId].tbPart[nPartId].szSubKind = "default";
		end
		--tbEvent[nEventId].tbPart[nPartId].szExClass; --����Ҫexclass
		tbEvent[nEventId].tbPart[nPartId].nStartDate = nStartDate;
		tbEvent[nEventId].tbPart[nPartId].nEndDate =   nEndDate;
		tbEvent[nEventId].tbPart[nPartId].tbExParam = {};
		for nParam = 1, self.EVENT_PARAM_MAX do
			local szParamName = string.format("ExParam%s", nParam);
			local szParam = EventManager.tbFun:ClearString(tbParam[szParamName]);
			tbEvent[nEventId].tbPart[nPartId].tbExParam [nParam] = szParam;
      	end
      	
      	tbEvent[nEventId].tbPart[nPartId].tbQuestParam = {};	--�����ʾ�������
      	tbEvent[nEventId].tbPart[nPartId].nQuestType = nQuestType; --�����ʾ���������ʽ��0��������1����������;
      	for nParam = 1, self.EVENT_QUESTPARAM_MAX do
      		local szParamName = string.format("QuestParam%s", nParam);
			local szParam = EventManager.tbFun:ClearString(tbParam[szParamName]);
			tbEvent[nEventId].tbPart[nPartId].tbQuestParam [nParam] = szParam;
      	end
		table.insert(tbEvent[nEventId].tbPart[nPartId].tbQuestParam, string.format("__nEventId:%s", nEventId));
		table.insert(tbEvent[nEventId].tbPart[nPartId].tbQuestParam, string.format("__nPartId:%s", nPartId));
   end
   
   if nQuestType == 1 and nTmpEventId and nTmpPartId then
   		SpecialEvent.Questionnaires:KingEyesLoadFile(nTmpEventId, nTmpPartId, szQuestPlayerListPath);
   end
   
   self:SaveBuf(tbEvent);
   return tbEvent;
end  

function tbEyes:SaveBuf(tbEvent)
	local tbBuf = self:GetGblBuf();
	for nEId, tbEventData in pairs(tbEvent) do
		if tbEventData.tbPart then
			for nPId, tbPartData in pairs(tbEventData.tbPart) do
				tbBuf[nEId] = tbBuf[nEId] or {};
				tbBuf[nEId].tbPart = tbBuf[nEId].tbPart or {};
				tbBuf[nEId].tbPart[nPId] = tbPartData;
			end
		end
	end
	self:SetGblBuf(tbBuf);
end
        
function tbEyes:LoadBuf()
	local tbBuf = self:GetGblBuf();
	local tbQuestBuf = SpecialEvent.Questionnaires:GetGblBuf(); --�����ʾ�
	--ȥ�������¼�
	for nEventId , tbTempEvent  in pairs(tbBuf) do
  		for nPartId , tbPart in pairs(tbTempEvent.tbPart) do
        	local nCurDate = tonumber(GetLocalDate("%Y%m%d%H%M"));     
        	if tbPart.nEndDate < nCurDate then
        		tbTempEvent.tbPart[nPartId] = nil;
        		
        		--�����ʾ�
        		if tbQuestBuf and tbQuestBuf[nEventId] and tbQuestBuf[nEventId][nPartId] then
        			tbQuestBuf[nEventId][nPartId] = nil;
        		end
        		
        	end
		end	
	end
	self:SetGblBuf(tbBuf); --�����޸ĺ��table
	SpecialEvent.Questionnaires:SetGblBuf(tbQuestBuf);	--�����ʾ�
	return tbBuf;
end

function tbEyes:UpdateEvent(tbEvent)                               
	for nEventId , tbTempEvent  in pairs(tbEvent) do
		if tbTempEvent.tbPart then
	  		for nPartId , tbPart in pairs(tbTempEvent.tbPart) do
				EventManager:SetEventPartName(nEventId, nPartId, tbPart.szName);
				if tbPart.szSubKind ~= "" and tbPart.szSubKind ~= "default" then
					EventManager:SetEventSubKind(nEventId, nPartId, tbPart.szSubKind);
				end
	           	EventManager:SetPartDate(nEventId, nPartId, tbPart.nStartDate, tbPart.nEndDate)
	           	for nParam , szParam in pairs(tbPart.tbExParam) do
					EventManager:SetPartParam(nEventId, nPartId, nParam, szParam);
				end
				
				if EventManager.tbFun:GetParam(tbPart.tbQuestParam, "LinkQuestUrl", 1)[1] then
					SpecialEvent.Questionnaires:SendDataGC(nEventId, nPartId, tbPart.nStartDate, tbPart.nEndDate, tbPart.nQuestType, tbPart.tbQuestParam);
				end
			end
		    EventManager:UpdateEvent(nEventId);
		end
	end
	return 1;
end

function tbEyes:GCStartEvent()
	if not self.tbGblBuf then
		self.tbGblBuf = self.tbGblBuf or {};
		local tbBuff = GetGblIntBuf(GBLINTBUF_KINGEYES_EVENT, 0, 1);
		if tbBuff and type(tbBuff) == "table" then
			self.tbGblBuf = tbBuff;
		end
	end
end

function tbEyes:GCReloadEventByFile(szPath, szPlayerListPath)
	local tbEvent = self:LoadFile(szPath, szPlayerListPath);
	if tbEvent then
		return self:UpdateEvent(tbEvent);
	end
	return 0;
end

function tbEyes:GSReloadEvent()
	self:GCStartEvent();
	SpecialEvent.Questionnaires:GCStartEvent();
	local tbEvent = self:LoadBuf();
	self:UpdateEvent(tbEvent);
end

end