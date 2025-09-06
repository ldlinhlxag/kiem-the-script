
local tb	= Task:GetTarget("KillBoss4Item");
tb.szTargetName	= "KillBoss4Item";
tb.REFRESH_FRAME	= 18 * 3;	-- zhengyuhua:降低刷新頻率(原：一秒檢測一次)

function tb:Init(nNpcTempId, nMapId, tbItemId, nPercent, nNeedCount, bDelete, szBeforePop, szLaterPop)
	self.nNpcTempId	= nNpcTempId;
	self.szNpcName	= KNpc.GetNameByTemplateId(nNpcTempId);
	self.nMapId		= nMapId;
	self.szMapName	= Task:GetMapName(nMapId);
	self.tbItemId	= tbItemId;
	self.szItemName	= KItem.GetNameById(unpack(self.tbItemId)) or "";
	self.nPercent	= nPercent;
	self.nNeedCount	= nNeedCount;
	self.bDelete	= bDelete;
	self.szBeforePop	= szBeforePop;
	self.szLaterPop		= szLaterPop;
	self.bShare = 1
end;

function tb:Start()
	self:Register();
end;

function tb:Save(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	
	
	return 1;
end;

function tb:Load(nGroupId, nStartTaskId)
		self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self:Register();
	
	return 1;
end;

function tb:IsDone()
	return self:GetCount() >= self.nNeedCount;
end;

function tb:GetDesc()
	local szMsg	= "Đánh bại ";
	if (self.nMapId ~= 0) then
		szMsg	= szMsg..self.szMapName.." - ";
	end;
	
	local nCurCount = self:GetCount();
	if (nCurCount > self.nNeedCount) then
		nCurCount = self.nNeedCount;
	end
	
	
	szMsg	= szMsg..string.format("%s và nhận được %s: %d/%d", self.szNpcName, self.szItemName, nCurCount, self.nNeedCount);
	return szMsg;
end;

function tb:GetStaticDesc()
	local szMsg	= "Đánh bại ";
	if (self.nMapId ~= 0) then
		szMsg	= szMsg..self.szMapName.." - ";
	end;
	szMsg	= szMsg..string.format("%s và nhận được %s%d", self.szNpcName, self.szItemName, self.nNeedCount);
	return szMsg;
end;



function tb:Close(szReason)
	if (MODULE_GAMESERVER) then	-- 服務端看情況刪除物品
		if (szReason == "finish" and self.bDelete) then
			Task:DelItem(self.me, self.tbItemId, self.nNeedCount);
		end
	end
	
	self:UnRegister();
end;


function tb:Register()
	if (MODULE_GAMESERVER and not self.nRegisterId) then
		self.nRegisterId	= Timer:Register(self.REFRESH_FRAME, self.OnTimer, self);
	end;
end


function tb:UnRegister()
	if (MODULE_GAMESERVER and self.nRegisterId) then
		Timer:Close(self.nRegisterId);
		self.nRegisterId	= nil;
	end;
end

function tb:OnTimer()
	local nCount	= self:GetCount();
	if (not self.nCount or self.nCount ~= nCount) then
		self.nCount	= nCount;
		local tbSaveTask	= self.tbSaveTask;
		if (MODULE_GAMESERVER) then	-- 自行同步到客戶端，要求客戶端刷新
			KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
		end;
		
		if (self:IsDone()) then
			self.tbTask:OnFinishOneTag();
		end
	end;
	
	return self.REFRESH_FRAME;
end


function tb:OnShareBossItem(pPlayer, pNpc)
	if (self:IsDone()) then
		return 0;
	end
	
	if (self.nNpcTempId ~= pNpc.nTemplateId) then
		return 0;
	end;
	
	if (self.nMapId ~= 0 and self.nMapId ~= pPlayer.GetMapId()) then
		return 0;
	end;
	
	local oldme = me;
	me = self.me;
	if (TaskCond:CanAddItemsIntoBag({self.tbItemId}) ~= 1) then
		self.me.Msg("Túi đầy!")
		me = oldme;
		return;
	end
	me = oldme;
	Task:AddItem(self.me, self.tbItemId);
	
	return 1;
end


-- 返回已有物品數量
function tb:GetCount()
	return Task:GetItemCount(self.me, self.tbItemId);
end;
