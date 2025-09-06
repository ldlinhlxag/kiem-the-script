-----------------------------------------------------------
-- 文件名　：lingxiefengtrap.lua
-- 文件描述：靈蠍峰腳本 
-- 創建者　：ZhangDeheng
-- 創建時間：2008-11-27 08:42:17
-----------------------------------------------------------

-- 殺死蠍王 才可通過此點
local tbMap	= Map:GetClass(560);
local tbTrap_1 = tbMap:GetTrapClass("to_tianjuegong");

tbTrap_1.tbSendPos = {1829, 2678};

function tbTrap_1:OnPlayer()
	local nSubWorld, _, _	= me.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nLingXieFengPass == 0) then
		me.NewWorld(me.nMapId, self.tbSendPos[1],self.tbSendPos[2]);
	end;
end

-- 鐵公雞牢門
local tbMap	= Map:GetClass(560);
local tbTrap_2 = tbMap:GetTrapClass("to_gongji");

tbTrap_2.tbSendPos = {1876, 2694};

function tbTrap_2:OnPlayer()
	local nSubWorld, _, _	= me.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nTieGongJiLaoMen == 0) then
		me.NewWorld(me.nMapId, self.tbSendPos[1], self.tbSendPos[2]);
	end;
end;
