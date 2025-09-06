-------------------------------------------------------------------
--File: 	base.lua
--Author: sunduoliang
--Date: 	2008-4-15
--Describe:	�����ϵͳ
--InterFace1:Init(...) ��ʼ������
--InterFace2:CreateKind() ����С������.
--InterFace3:
-------------------------------------------------------------------
local EventKind = {};
EventManager.EventKindBase = EventKind;

function EventKind:Init(tbEvent, tbEventPart, bGmCmd)
	--��ʼ������
	self.tbEvent = tbEvent;
	
	self.tbEventPart = tbEventPart;
--	self.tbEventPart.nId 			= tbEventPart.nId;
--	self.tbEventPart.szName 		= tbEventPart.szName;
--	self.tbEventPart.szKind 		= tbEventPart.szKind;
--	self.tbEventPart.szSubKind 		= tbEventPart.szSubKind;
--	self.tbEventPart.szExClass		= tbEventPart.szExClass;	
--	self.tbEventPart.nStartDate 	= tbEventPart.nStartDate;
--	self.tbEventPart.nEndDate 		= tbEventPart.nEndDate;
--	self.tbEventPart.tbParam		= tbEventPart.tbParam;
--	self.tbEventPart.tbParamIndex	= tbEventPart.tbParamIndex;
	--table.insert(self.tbEventPart.tbParam, string.format("CheckGDate:%s,%s",self.tbEvent.nStartDate, self.tbEvent.nEndDate));
	
	if bGmCmd ~= 1 or self.tbEventPart.tbParamIndex[101] == nil then 
		table.insert(self.tbEventPart.tbParam, string.format("CheckGDate:%s,%s",self.tbEventPart.nStartDate, self.tbEventPart.nEndDate));
		self.tbEventPart.tbParamIndex[101] = #self.tbEventPart.tbParam;
		table.insert(self.tbEventPart.tbParam, string.format("__nPartId:%s",self.tbEventPart.nId));
		self.tbEventPart.tbParamIndex[201] = #self.tbEventPart.tbParam;
		table.insert(self.tbEventPart.tbParam, string.format("__nEventId:%s",self.tbEvent.nId));
		self.tbEventPart.tbParamIndex[202] = #self.tbEventPart.tbParam;
		table.insert(self.tbEventPart.tbParam, string.format("SetTaskBatch:%s",self.tbEvent.nTaskPacth));
		self.tbEventPart.tbParamIndex[301] = #self.tbEventPart.tbParam;
		
		--���������Ʒ������Ҫ�ж����ʱ��
		if #EventManager.tbFun:GetParam(self.tbEventPart.tbParam, "Item", 1) <= 0 then
			table.insert(self.tbEventPart.tbParam, string.format("CheckGDate:%s,%s",self.tbEvent.nStartDate, self.tbEvent.nEndDate));
			self.tbEventPart.tbParamIndex[102] = #self.tbEventPart.tbParam;
		end
	end
	
	self.tbDialog = {};
	self.tbTimer = {};
	self.tbNpcDrop ={};
	self.tbTimer.tbStartTime = {};
	self.tbTimer.tbEndTime = {};	
	self:CreateKind();
end

function EventKind:CreateKind()
	--
	--self.SubCreateKind = self.SubKind.CreateKind;
	--if self.SubCreateKind then
	if (MODULE_GAMESERVER) or (MODULE_GC_SERVER) then
		EventManager.tbFunction_Base:SetTimerStart(self);
		EventManager.tbFunction_Base:SetTimerEnd(self);
		EventManager.tbFunction_Base:SetMapPath(self);
		EventManager.tbFunction_Base:SetDropNpc(self);
		EventManager.tbFunction_Base:SetDropNpcType(self);
		EventManager.tbFunction_Base:SetNpc(self);		
	end	

	if (MODULE_GAMESERVER) or (MODULE_GAMECLIENT)then
		EventManager.tbFunction_Base:SetItem(self);
	end
	
		--self.SubCreateKind(self)
	--end
end

function EventKind:OnUse()
	--
	--local nFlag, szMsg = EventManager.tbFun:CheckParam(self.tbEventPart.tbParam);
	--if nFlag == 1 then
	--	if szMsg then
	--		me.Msg(szMsg);
	--	end
	--	return 0;
	--end
	
	local nDelay = 0;	--��
	local nUseDel = 0;
	local tbItemLiveTime = EventManager.tbFun:GetParam(self.tbEventPart.tbParam, "Item", 1)
	for nParam, szParam in ipairs(tbItemLiveTime) do
		local tbItemName = EventManager.tbFun:SplitStr(szParam);
		local szClassName = tbItemName[1];
		if szClassName == it.szClass then
			nDelay = tonumber(tbItemName[3]) or 0;	--Ĭ��û�н�����
			nUseDel = tonumber(tbItemName[4]) or 0;	--Ĭ�ϲ�ɾ
			break;
		end
	end
	EventManager:GetTempTable().nType = 2;
	EventManager:GetTempTable().tbParam = {nItemId=it.dwId};
	if nDelay > 0 then
		local tbEvent = 
		{
			Player.ProcessBreakEvent.emEVENT_MOVE,
			Player.ProcessBreakEvent.emEVENT_ATTACK,
			Player.ProcessBreakEvent.emEVENT_ATTACKED,
			Player.ProcessBreakEvent.emEVENT_SITE,
			Player.ProcessBreakEvent.emEVENT_USEITEM,
			Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
			Player.ProcessBreakEvent.emEVENT_DROPITEM,
			Player.ProcessBreakEvent.emEVENT_SENDMAIL,
			Player.ProcessBreakEvent.emEVENT_TRADE,
			Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
			Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
			Player.ProcessBreakEvent.emEVENT_LOGOUT,
			Player.ProcessBreakEvent.emEVENT_DEATH,
		}
		
		GeneralProcess:StartProcess("ʹ����...", nDelay * Env.GAME_FPS, 
				{self.OnUse_Delay, self, me.nId, it.dwId, nUseDel, 1}, nil, tbEvent);
			return 0;
	end
	return self:OnUse_Delay(me.nId, it.dwId, nUseDel, 0);
end
function EventKind:OnUse_Delay(nPlayerId, nItemId, nUseDel, nType)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return 0;
	end
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	
	local nSureFlag = 0;
	Setting:SetGlobalObj(pPlayer, nil, pItem);
	local nFlag, szMsg = EventManager.tbFun:CheckParam(self.tbEventPart.tbParam);
	if nFlag and nFlag ~= 0 then
		if szMsg then
			me.Msg(szMsg);
		end
		if nFlag == 2 then
			if nType == 1 and nUseDel == 1 then
				if it.nCount > 1 then
					it.SetCount(it.nCount - 1);
				else
					it.Delete(me);
				end
			end
			Setting:RestoreGlobalObj()
			return nUseDel;
		end
		Setting:RestoreGlobalObj()
		return 0;
	end
	
	if self.tbEventPart.szExClass ~= nil and self.tbEventPart.szExClass ~= "" then
		if EventManager.EventKind.ExClass[self.tbEventPart.szExClass] ~= nil then
			if EventManager.EventKind.ExClass[self.tbEventPart.szExClass].OnUse ~= nil then
				EventManager.EventKind.ExClass[self.tbEventPart.szExClass]:OnUse();
				nSureFlag = 1;
			end
		end
	end

	self.SubOnUse = self.SubKind.OnUse;
	if nSureFlag == 0 and self.SubOnUse then
		self.SubOnUse(self)
	end
	
	if nType == 1 and nUseDel == 1 then
		if it.nCount > 1 then
			it.SetCount(it.nCount - 1);
		else
			it.Delete(me);
		end
	end
	Setting:RestoreGlobalObj()
	return nUseDel;
end

function EventKind:PickUp()
	
	if self.tbEventPart.szExClass ~= nil and self.tbEventPart.szExClass ~= "" then
		if EventManager.EventKind.ExClass[self.tbEventPart.szExClass] ~= nil then
			if EventManager.EventKind.ExClass[self.tbEventPart.szExClass].PickUp ~= nil then
				return EventManager.EventKind.ExClass[self.tbEventPart.szExClass]:PickUp();
			end
			
		end
	end
		
	self.SubPickUp = self.SubKind.PickUp;
	if self.SubPickUp then
		if self.SubPickUp(self) == 0 then
			return 0;
		end
	end
	return 1;
end

function EventKind:IsPickable()

	if self.tbEventPart.szExClass ~= nil and self.tbEventPart.szExClass ~= "" then
		if EventManager.EventKind.ExClass[self.tbEventPart.szExClass] ~= nil then
			if EventManager.EventKind.ExClass[self.tbEventPart.szExClass].IsPickable ~= nil then
				return EventManager.EventKind.ExClass[self.tbEventPart.szExClass]:IsPickable();
			end
			
		end
	end
		
	self.SubIsPickable = self.SubKind.IsPickable;
	if self.SubIsPickable then
		if self.SubIsPickable(self) == 0 then
			return 0;
		end
	end
	return 1;	
end

function EventKind:InitGenInfo()
	local tbItemLiveTime = EventManager.tbFun:GetParam(self.tbEventPart.tbParam, "Item", 1)
	for nParam, szParam in ipairs(tbItemLiveTime) do
		local tbItemName = EventManager.tbFun:SplitStr(szParam);
		local szClassName = tbItemName[1];
		if szClassName == it.szClass and tbItemName[2] and tbItemName[2] ~= "" then
			if tonumber(tbItemName[2]) ~= nil then
				if tonumber(tbItemName[2]) > 0 then
					it.SetTimeOut(0, (GetTime() + tonumber(tbItemName[2]) * 60));
				end
			else
				local nStartTime = EventManager.tbFun:DateFormat(tbItemName[2], 0);
				if nStartTime > 0 then
					it.SetTimeOut(0, Lib:GetDate2Time(nStartTime));
				end
			end
			it.Sync();
			break;
		end
	end
	
	if self.tbEventPart.szExClass ~= nil and self.tbEventPart.szExClass ~= "" then
		if EventManager.EventKind.ExClass[self.tbEventPart.szExClass] ~= nil then
			if EventManager.EventKind.ExClass[self.tbEventPart.szExClass].InitGenInfo ~= nil then
				return EventManager.EventKind.ExClass[self.tbEventPart.szExClass]:InitGenInfo();
			end
			
		end
	end
	
	self.SubInitGenInfo = self.SubKind.InitGenInfo;
	if self.SubInitGenInfo then
		return self.SubInitGenInfo(self);
	end
	return {};	
end

function EventKind:GetTip()
	local tbItemLiveTime = EventManager.tbFun:GetParam(self.tbEventPart.tbParam, "Item", 1)
	for nParam, szParam in ipairs(tbItemLiveTime) do
		local tbItemName = EventManager.tbFun:SplitStr(szParam);
		local szClassName = tbItemName[1];
		if szClassName == it.szClass and tbItemName[5] and tbItemName[5] ~= "" then
			local szScript = string.gsub(tbItemName[5], "<enter>", "\n");
			return loadstring(szScript)() or "";
		end
	end
	return "";	
end

function EventKind:OnDialog(nCheck)
	local tbGRoleArgs = Dialog:GetMyDialog().tbGRoleArgs;
	if not tbGRoleArgs then
		return 0;
	end
	local pNpc = KNpc.GetById((tbGRoleArgs.npcId)or 0);
	if not pNpc then
		return 0;
	end
	Setting:SetGlobalObj(nil, pNpc);
	EventManager:GetTempTable().nType = 1;
	EventManager:GetTempTable().tbParam = {};
	--��չ����
	if self.tbEventPart.szExClass ~= nil and self.tbEventPart.szExClass ~= "" then
		if EventManager.EventKind.ExClass[self.tbEventPart.szExClass] ~= nil then
			if EventManager.EventKind.ExClass[self.tbEventPart.szExClass].OnDialog ~= nil then
				local nFlag, szMsg = EventManager.tbFun:CheckParam(self.tbEventPart.tbParam);
				if nFlag and nFlag ~= 0 then
					if szMsg then
						me.Msg(szMsg);
					end
					Setting:RestoreGlobalObj();
					return 0;
				end				
				EventManager.EventKind.ExClass[self.tbEventPart.szExClass]:OnDialog()
				Setting:RestoreGlobalObj();
				return 0;
			end
		end
	end
	self.SubOnDialog = self.SubKind.OnDialog;
	if self.SubOnDialog then
		self.SubOnDialog(self, nCheck)
	end
	Setting:RestoreGlobalObj();
end

function EventKind:ExeStartFun(tbParam)
	
	--������Ч�Ի�
	
	EventManager.Event:ExeDialog(self.tbEvent.nId);	
	local nFlag, szMsg = EventManager.tbFun:CheckParamWithOutPlayer(self.tbEventPart.tbParam);
	if nFlag and nFlag ~= 0 then
		return 0;
	end
	
	if self.tbEventPart.szExClass ~= nil and self.tbEventPart.szExClass ~= "" then
		if EventManager.EventKind.ExClass[self.tbEventPart.szExClass] ~= nil then
			if EventManager.EventKind.ExClass[self.tbEventPart.szExClass].ExeStartFun ~= nil then
				EventManager.EventKind.ExClass[self.tbEventPart.szExClass]:ExeStartFun(tbParam)
				return 0;
			end
		end
	end
		
	self.SubExeStartFun = self.SubKind.ExeStartFun;
	if self.SubExeStartFun then
		self.SubExeStartFun(self, tbParam);
	end
	return 0;
end

function EventKind:ExeEndFun(tbParam)
	
	--���Ի��Ƿ���ʧЧ
	local tbEvent = EventManager.EventManager.tbEvent[self.tbEvent.nId];
	if tbEvent.tbDialog then
		for varNpc, tbNpcDialogParam in pairs(tbEvent.tbDialog) do
			EventManager.Event:CheckEffectDialog(self.tbEvent.nId, varNpc);
		end
	end
	
	if self.tbEventPart.szExClass ~= nil and self.tbEventPart.szExClass ~= "" then
		if EventManager.EventKind.ExClass[self.tbEventPart.szExClass] ~= nil then
			if EventManager.EventKind.ExClass[self.tbEventPart.szExClass].ExeEndFun ~= nil then
				EventManager.EventKind.ExClass[self.tbEventPart.szExClass]:ExeEndFun(tbParam)
				return 0;
			end
		end
	end
		
	self.SubExeEndFun = self.SubKind.ExeEndFun;
	if self.SubExeEndFun then
		self.SubExeEndFun(self, tbParam);
	end
	return 0;
end


function EventKind:ExeNpcStartFun(tbParam)
	local nFlag, szMsg = EventManager.tbFun:CheckParamWithOutPlayer(self.tbEventPart.tbParam);
	if nFlag and nFlag ~= 0 then
		return 0;
	end
	
	if self.tbEventPart.szExClass ~= nil and self.tbEventPart.szExClass ~= "" then
		if EventManager.EventKind.ExClass[self.tbEventPart.szExClass] ~= nil then
			if EventManager.EventKind.ExClass[self.tbEventPart.szExClass].ExeNpcStartFun ~= nil then
				EventManager.EventKind.ExClass[self.tbEventPart.szExClass]:ExeNpcStartFun(tbParam)
				return 0;
			end
		end
	end
		
	self.SubExeNpcStartFun = self.SubKind.ExeNpcStartFun;
	if self.SubExeNpcStartFun then
		self.SubExeNpcStartFun(self, tbParam);
	end
	return 0;
end

function EventKind:ExeNpcEndFun(tbParam)

	if self.tbEventPart.szExClass ~= nil and self.tbEventPart.szExClass ~= "" then
		if EventManager.EventKind.ExClass[self.tbEventPart.szExClass] ~= nil then
			if EventManager.EventKind.ExClass[self.tbEventPart.szExClass].ExeNpcEndFun ~= nil then
				EventManager.EventKind.ExClass[self.tbEventPart.szExClass]:ExeNpcEndFun(tbParam)
				return 0;
			end
		end
	end
		
	self.SubExeNpcEndFun = self.SubKind.ExeNpcEndFun;
	if self.SubExeNpcEndFun then
		self.SubExeNpcEndFun(self, tbParam);
	end
	return 0;
end
