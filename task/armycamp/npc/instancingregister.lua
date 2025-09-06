-- 軍營傳送官
local tbNpc1 = Npc:GetClass("junyingchuansong");
function tbNpc1:OnDialog()
	local szMainMsg = "Ta có thể đưa ngươi đến Phục Ngưu Sơn Quân Doanh";
	local tbOpt = {
		{"Phục Ngưu Sơn [Thanh Long]", self.ChoseCamp, self, me.nId, 556,1631,3142},
		{"Phục Ngưu Sơn [Chu Tước]", self.ChoseCamp, self, me.nId, 558,1631,3142},
		{"Phục Ngưu Sơn [Huyền Vũ]", self.ChoseCamp, self, me.nId, 559,1631,3142},
	}
	Lib:SmashTable(tbOpt);
	table.insert(tbOpt, {"Kết thúc đối thoại"});
	
	Dialog:Say(szMainMsg, tbOpt);
end


function tbNpc1:ChoseCamp(nPlayerId, nMapId, nPosX, nPosY)
	local pPlayer  = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	if (pPlayer.nLevel < 60) then
		Task.tbArmyCampInstancingManager:Warring(pPlayer, "Cấp <60, không thể vào Quân doanh.");
		return;
	end
	
	pPlayer.NewWorld(nMapId, nPosX, nPosY);
	pPlayer.SetFightState(0);
end


local tbNpc2 = Npc:GetClass("instcingoutsender");
function tbNpc2:OnDialog()
	local pPlayer = me;
	local nMapId = pPlayer.GetTask(2043, 2);
	if (nMapId ~= 556 and nMapId ~= 558 and nMapId ~= 559) then
		return;
	end
	
	local szMainMsg = "Ta có thể đưa ngươi đến Phục Ngưu Sơn Quân Doanh";
	local tbOpt = {
		{"Trở lại Quân doanh", self.EnterRegisterCamp, self, me.nId, nMapId, 1631, 3142},		
		{"Kết thúc đối thoại"}
	}
	
	Dialog:Say(szMainMsg, tbOpt);
end


function tbNpc2:EnterRegisterCamp(nPlayerId, nMapId, nPosX, nPosY)
	local pPlayer  = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	pPlayer.NewWorld(nMapId, nPosX, nPosY);
	pPlayer.SetFightState(0);
end


-- 副本接引人
local tbRegister = Npc:GetClass("fbchuansong");
function tbRegister:OnDialog()
	local szMainMsg = "Tôi có thể đưa bạn đến chỗ Phó bản, mời chọn Phó bản muốn đến";
	local tbOpt = {};
		
	local tbInstancingMgr = Task.tbArmyCampInstancingManager;
	for i = 1, #tbInstancingMgr.tbSettings do
		local tbInstacing = tbInstancingMgr:GetInstancingSetting(i);
		tbOpt[#tbOpt + 1] = {tbInstacing.szName, self.ChoseInstcing, self, i, me.nId};
	end;
	if (me.GetTask(2060, 1) == 1) then
		tbOpt[#tbOpt+1] = {"Bồi thường Nhiệm vụ Quân doanh", self.AmendeForCampTask, self, me.nId};
	end
	
	tbOpt[#tbOpt + 1] = {"Kết thúc đối thoại"};
	Dialog:Say(szMainMsg, tbOpt);
end

function tbRegister:AmendeForCampTask(nPlayerId)
	Dialog:Say("Phần thưởng bồi thường là 8000000 kinh nghiệm, 40000 bạc, 1800 Hoạt lực Tinh lực", 
		{"Muốn nhận ngay?", Task.AmendeForCampTask, Task, nPlayerId}, 
		{"Ta sẽ nhận sau"})
end


function tbRegister:ChoseInstcing(nInstancingTemplateId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	local tbInstancingMgr = Task.tbArmyCampInstancingManager;
--	local nRet, szError = tbInstancingMgr:CheckEnterCondition(nInstancingTemplateId, nPlayerId);
--	if (nRet ~= 1) then
--		tbInstancingMgr:Warring(pPlayer, szError);
--		return;
--	end
	
	local tbInstancingSetting = tbInstancingMgr:GetInstancingSetting(nInstancingTemplateId);
	
	local tbOpt = 
	{
		{"Ta muốn báo danh", tbInstancingMgr.AskRegisterInstancing, tbInstancingMgr, nInstancingTemplateId, pPlayer.nId},
		{"Vào Phó bản", tbInstancingMgr.AskEnterInstancing, tbInstancingMgr, nInstancingTemplateId, pPlayer.nId},
		{"Kết thúc đối thoại"}
	}
	
	Dialog:Say(tbInstancingSetting.szEnterMsg, tbOpt);
end
