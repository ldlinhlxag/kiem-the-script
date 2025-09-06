-----------------------------------------------------------
-- 文件名　：shenzhufengtrap.lua
-- 文件描述：神蛛峰腳本
-- 創建者　：ZhangDeheng
-- 創建時間：2008-11-27 08:42:29
-----------------------------------------------------------

-- 殺死蠍王 才可通過此點
local tbMap	= Map:GetClass(560);
local tbTrap_1 = tbMap:GetTrapClass("to_lingxiefeng");
-- 1655 3209 
tbTrap_1.tbSendPos = {1952, 2851};

function tbTrap_1:OnPlayer()
	local nSubWorld, _, _	= me.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	if (tbInstancing.nShenZhuFengPass == 0) then
		me.NewWorld(me.nMapId, self.tbSendPos[1],self.tbSendPos[2]);
	end;
end
