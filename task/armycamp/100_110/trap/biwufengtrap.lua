-----------------------------------------------------------
-- 文件名　：biwufengtrap.lua
-- 文件描述：碧蜈峰trap點腳本
-- 創建者　：ZhangDeheng
-- 創建時間：2008-11-26 19:46:12
-----------------------------------------------------------

-- 殺死蠍王 才可通過此點
local tbMap	= Map:GetClass(560);
local tbTrap_1 = tbMap:GetTrapClass("to_shenzhufeng");

tbTrap_1.tbSendPos = {1827, 3047};

function tbTrap_1:OnPlayer()
	local nSubWorld, _, _	= me.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nBiWuFengPass == 0) then
		me.NewWorld(me.nMapId, self.tbSendPos[1],self.tbSendPos[2]);
	end;
end
