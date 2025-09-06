-------------------------------------------------------------------
--File: 	eventmanager.lua
--Author: sunduoliang
--Date: 	2008-4-15
--Describe:	�����ϵͳ
--InterFace1:EventManager.EventManager: Init() 	��������ϵͳ,�����������л.
--InterFace2:EventManager.EventManager: UnInit() �رչ���ϵͳ.
--InterFace3:EventManager.EventManager: MaintainGC()	ά������ϵͳ,��GCͳһ��ʱ����ά��,24Сʱά��һ��.
--InterFace3:EventManager.EventManager: CloseSingleEvent(nId) �����رյ����¼�
--InterFace3:EventManager.EventManager: DoScript()	����ʹ��gs,�ض��ļ�
-------------------------------------------------------------------

Require("\\script\\event\\manager\\define.lua");

local Manager = {};
EventManager.EventManager = Manager;

function Manager:Init()
	--��ʼ������
	--�����л��txt���ֶ�ȡ��tbParam
	self.tbParam = {};
	self.tbEvent = {};
	self:LoadAllEvent();
	self:CreateAllEvent();
	
	if MODULE_GAMECLIENT then
		EventManager.News:Init();
	end

	return 0;
end

function Manager:CreateAllEvent()
	--��ȡtbParam��, ������Eventʵ����
	for nId, tbEvent in pairs(self.tbParam) do
		self.tbEvent[nId] = Lib:NewClass(EventManager.Event);
		self.tbEvent[nId]:Init(tbEvent);
		self.tbEvent[nId]:CreateEvent();	
	end
	return 0;
end

function Manager:LoadAllEvent()
	self.szAllEventTable = EventManager.EVENT_TABLE;
	local nNowDate = tonumber(GetLocalDate("%Y%m%d%H%M"));
	local tbAllEvent = Lib:LoadTabFile(self.szAllEventTable);
	for nEventId, tbEvent in ipairs(tbAllEvent) do
		if nEventId >= 2 then
			local nStartDate = EventManager.tbFun:ClearString(tbEvent.EventStartDate);
			local nEndDate = EventManager.tbFun:ClearString(tbEvent.EventEndDate);
			nStartDate, nEndDate = EventManager.tbFun:DateFormat(nStartDate, nEndDate);
			if nEndDate == nil then
				print("���ϵͳ��ʱ���ʽ����", nEventId);
				return 1;
			end
			
			if (nEndDate >= 0 and nStartDate >= 0) then
				local nId = tonumber(tbEvent.EventId) or 0;
				self.tbParam[nId] = {};
				self.tbParam[nId].nId			= tonumber(nId) or 0;
				self.tbParam[nId].szName 		= EventManager.tbFun:ClearString(tbEvent.EventName);
				self.tbParam[nId].szDescript 	= EventManager.tbFun:ClearString(tbEvent.EventDescript);
				self.tbParam[nId].nStartDate 	= nStartDate;
				self.tbParam[nId].nEndDate 		= nEndDate;
				self.tbParam[nId].nTaskPacth 	= tonumber(tbEvent.TaskPacth) or 0;
				self.tbParam[nId].szTable 		= EventManager.EVENT_BASE_PATH .. EventManager.tbFun:ClearString(tbEvent.EventTable);
				if tbEvent.TimeFrame == "" then
					self.tbParam[nId].szTimeFrame = "0:0/0:0";
				else
					self.tbParam[nId].szTimeFrame = tbEvent.TimeFrame;
				end
			end
		end
	end	
end

--nEventId:�¼�Id
--szName:����
function Manager:ChangeEventName(nEventId, szName)
	if not self.tbEvent[nEventId] then
		print("���ϵͳ��ChangeEventTimeû�и��¼�", nEventId);
		return 0;
	end
	local tbEvent = self.tbEvent[nEventId];
	tbEvent.tbEvent.szName = szName;
	if (MODULE_GC_SERVER) then
	GlobalExcute({"EventManager.EventManager:ChangeEventName", nEventId, szName});
	end
	return 1;
end

--nEventId:�¼�Id
--szDesc:��ʼ���ڣ�YYYYmmddHHMM
function Manager:ChangeEventDesc(nEventId, szDesc)
	if not self.tbEvent[nEventId] then
		print("���ϵͳ��ChangeEventTimeû�и��¼�", nEventId);
		return 0;
	end
	local tbEvent = self.tbEvent[nEventId];
	tbEvent.tbEvent.szDescript = szDesc;
	if (MODULE_GC_SERVER) then
	GlobalExcute({"EventManager.EventManager:ChangeEventDesc", nEventId, szDesc});
	end
	return 1;
end

--nEventId:�¼�Id
--szName:����
function Manager:ChangeEventPartName(nEventId, nPartId, szName)
	if not self.tbEvent[nEventId] then
		print("���ϵͳ��ChangeEventPartNameû�и��¼�", nEventId);
		return 0;
	end
	if not self.tbEvent[nEventId].tbEventPart[nPartId] then
		self.tbEvent[nEventId].tbParam[nPartId] = {};
		self.tbEvent[nEventId].tbParam[nPartId].nId 		= tonumber(nPartId);
		self.tbEvent[nEventId].tbParam[nPartId].szName 		= szName;
		self.tbEvent[nEventId].tbParam[nPartId].szSubKind	= "default";
		self.tbEvent[nEventId].tbParam[nPartId].szExClass	= "";
		self.tbEvent[nEventId].tbParam[nPartId].nStartDate 	= 0;
		self.tbEvent[nEventId].tbParam[nPartId].nEndDate 	= 0;
		self.tbEvent[nEventId].tbParam[nPartId].tbParam 	= {};
		self.tbEvent[nEventId].tbParam[nPartId].tbParamIndex= {};
	else
		local tbEvent = self.tbEvent[nEventId];
		local tbPart  = tbEvent.tbEventPart[nPartId];	
		tbPart.tbEventPart.szName = szName;
	end
	if (MODULE_GC_SERVER) then
	GlobalExcute({"EventManager.EventManager:ChangeEventPartName", nEventId, nPartId, szName});
	end
	return 1;
end

--nEventId:�¼�Id
--szSubKind:����
function Manager:ChangeEventPartSubKind(nEventId, nPartId, szSubKind)
	if not self.tbEvent[nEventId] or not self.tbEvent[nEventId].tbParam[nPartId] then
		print("���ϵͳ��ChangeEventPartSubKindû�и��¼�", nEventId, nPartId);
		return 0;
	end
	local tbEvent = self.tbEvent[nEventId];
	tbEvent.tbParam[nPartId].szSubKind = szSubKind;
	if (MODULE_GC_SERVER) then
	GlobalExcute({"EventManager.EventManager:ChangeEventPartSubKind", nEventId, nPartId, szSubKind});
	end
	return 1;
end

--nEventId:�¼�Id
--nStartDate:��ʼ���ڣ�YYYYmmddHHMM
--nEndDate:�������ڣ�YYYYmmddHHMM
function Manager:ChangeEventTime(nEventId, nStartDate, nEndDate)
	if not self.tbEvent[nEventId] then
		print("���ϵͳ��ChangeEventTimeû�и��¼�", nEventId);
		return 0;
	end
	local tbEvent = self.tbEvent[nEventId];
	tbEvent.tbEvent.nStartDate = nStartDate;
	tbEvent.tbEvent.nEndDate   = nEndDate;
	for _, tbPart in pairs(tbEvent.tbParam) do
		if tbPart.tbParamIndex[102] then
			tbPart.tbParam[tbPart.tbParamIndex[102]] = string.format("CheckGDate:%s,%s", nStartDate, nEndDate);
		end
	end
	
	if (MODULE_GC_SERVER) then
	GlobalExcute({"EventManager.EventManager:ChangeEventTime", nEventId, nStartDate, nEndDate});
	end
	return 1;
end

--nEventId:�¼�Id
--nStartDate:��ʼ���ڣ�YYYYmmddHHMM
--nEndDate:�������ڣ�YYYYmmddHHMM
function Manager:ChangeEventTaskBatch(nEventId, nPatch)
	if not self.tbEvent[nEventId] then
		print("���ϵͳ��ChangeEventTimeû�и��¼�", nEventId);
		return 0;
	end
	nPatch = tonumber(nPatch) or 0;
	local tbEvent = self.tbEvent[nEventId];
	tbEvent.tbEvent.nTaskPacth = nPatch;
	for _, tbPart in pairs(tbEvent.tbParam) do
		if tbPart.tbParamIndex[301] then
			tbPart.tbParam[tbPart.tbParamIndex[301]] = string.format("SetTaskBatch:%s", nPatch);
		end
	end
	
	if (MODULE_GC_SERVER) then
	GlobalExcute({"EventManager.EventManager:ChangeEventTaskBatch", nEventId, nPatch});
	end
	return 1;
end

--nEventId:�¼�Id
--nPartId: ���¼�Id
--nStartDate:��ʼ���ڣ�YYYYmmddHHMM
--nEndDate:�������ڣ�YYYYmmddHHMM
function Manager:ChangeEventPartTime(nEventId, nPartId, nStartDate, nEndDate)
	if not self.tbEvent[nEventId] then
		print("���ϵͳ��ChangeEventPartTimeû�и��¼�", nEventId);
		return 0;
	end
	if not self.tbEvent[nEventId].tbEventPart[nPartId] then
		if not self.tbEvent[nEventId].tbParam[nPartId] then
			print("���ϵͳ��ChangeEventPartTimeû�и��¼�", nEventId, nPartId);
			return 0;
		end
		self.tbEvent[nEventId].tbParam[nPartId].nStartDate 	= nStartDate;
		self.tbEvent[nEventId].tbParam[nPartId].nEndDate 	= nEndDate;
		if (MODULE_GC_SERVER) then
		GlobalExcute({"EventManager.EventManager:ChangeEventPartTime", nEventId, nPartId, nStartDate, nEndDate});
		end
		return 1;
	end
	nStartDate = tonumber(nStartDate) or 0;
	nEndDate   = tonumber(nEndDate) or 0;
	local tbEvent = self.tbEvent[nEventId];
	local tbPart  = tbEvent.tbEventPart[nPartId];
	tbPart.tbEventPart.nStartDate = nStartDate;
	tbPart.tbEventPart.nEndDate	  = nEndDate;
	
	if tbPart.tbEventPart.tbParamIndex[101] then
		tbPart.tbEventPart.tbParam[tbPart.tbEventPart.tbParamIndex[101]] = string.format("CheckGDate:%s,%s", nStartDate, nEndDate);
	end
	
	if (MODULE_GC_SERVER) then
	GlobalExcute({"EventManager.EventManager:ChangeEventPartTime", nEventId, nPartId, nStartDate, nEndDate});
	end
	return 1;
end

--nEventId:�¼�Id
--nPartId: ���¼�Id
--nParam:  ������
--szParam: �޸Ĳ���

function Manager:ChangeEventPartParam(nEventId, nPartId, nParam, szParam)
	if not self.tbEvent[nEventId] then
		print("���ϵͳ��ChangeEventPartParamû�и��¼�", nEventId, nPartId);
		return 0;
	end
	local tbEvent = self.tbEvent[nEventId];
	local tbPart  = tbEvent.tbEventPart[nPartId];
	if not tbPart or not tbPart.tbEventPart.tbParamIndex[nParam] then
		if not tbEvent.tbParam[nPartId] then
			print("���ϵͳ��ChangeEventPartParamû�иò�����", nEventId, nPartId, nParam);
			return 0;
		end
		table.insert(tbEvent.tbParam[nPartId].tbParam, szParam);
		tbEvent.tbParam[nPartId].tbParamIndex[nParam] = #tbEvent.tbParam[nPartId].tbParam;
		if (MODULE_GC_SERVER) then
		GlobalExcute({"EventManager.EventManager:ChangeEventPartParam", nEventId, nPartId, nParam, szParam});
		end	
		return 1;
	end
	local nParamIndex = tbPart.tbEventPart.tbParamIndex[nParam];
	if not tbPart.tbEventPart.tbParam[nParamIndex] then
		print("���ϵͳ��ChangeEventPartParamû�иò�����", nEventId, nPartId, nParam);
		return 0;	
	end
	tbPart.tbEventPart.tbParam[nParamIndex] = szParam;
	if (MODULE_GC_SERVER) then
	GlobalExcute({"EventManager.EventManager:ChangeEventPartParam", nEventId, nPartId, nParam, szParam});
	end
	return 1;
end

--���µ����¼�
function Manager:UpdateSingleEvent(nEventId)
	if not self.tbEvent[nEventId] then
		print("���ϵͳ�������¼�ʧ�ܣ�û���¼����¼�Id", nEventId);
		return 0;
	end
	if (MODULE_GC_SERVER) then
		self.tbEvent[nEventId]:CloseTimerGC();
		self.tbEvent[nEventId]:OnTimeEndGC(0);
		GlobalExcute({"EventManager.EventManager:UpdateSingleEvent", nEventId});
	end
	self.tbEvent[nEventId].tbDialog 	= {};	--��ʼ��
	self.tbEvent[nEventId].tbTimer 		= {};	--��ʼ��
	self.tbEvent[nEventId].tbNpcDrop	= {};	--��ʼ��
	self.tbEvent[nEventId].tbTimerId 	= {};	--��ʼ��
	self.tbEvent[nEventId]:CreateEvent(1);
	return 0;
end

-----------GAMESERVER ����START-----
if (MODULE_GAMESERVER) then

function Manager:UnInit()
	for nId, tbEvent in pairs(self.tbEvent) do
		self:CloseSingleEvent(nId)
	end
	return 0;
end

function  Manager:CloseSingleEvent(nId)
	if self.tbEvent[nId] ~= nil then
		GCExcute({"EventManager.EventManager:CloseSingleEventGC", nId});
	end
end

function Manager:Maintain()
	GCExcute({"EventManager.EventManager:MaintainGC"});
end

function Manager:DoScript()
	GCExcute({"EventManager.EventManager:DoScript"});
end

end
-----------GAMESERVER ����END-----

-----------GAMEGCSERVER ����START-----
if (MODULE_GC_SERVER) then
	
function Manager:DoScript()
	for nId, tbEvent in pairs(self.tbEvent) do
		tbEvent:DestroyGC();
	end
	Timer:Register(1*18, self.DoScript_Delay, self);
end

function Manager:DoScript_Delay()
	--self:Init();
	GlobalExcute({"EventManager.EventManager:Init"});
	return 0;
end

--ά���ϵͳ
function Manager:MaintainGC()
	for nId, tbEvent in pairs(self.tbEvent) do
		tbEvent:MaintainGC();
	end
	return 0;
end

function Manager:CloseSingleEventGC(nId)
	if self.tbEvent[nId] ~= nil then
		self.tbEvent[nId]:DestroyGC();
	end	
end

end

-----------GAMEGCSERVER ����END-----
if (MODULE_GAMECLIENT) then
	ClientEvent:RegisterClientStartFunc(EventManager.EventManager.Init, EventManager.EventManager);
end
