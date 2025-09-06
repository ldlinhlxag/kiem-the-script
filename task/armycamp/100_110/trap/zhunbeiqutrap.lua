-----------------------------------------------------------
-- 文件名　：zhunbeiqutrap.lua
-- 文件描述：離開船及回到船的狀態切換
-- 創建者　：ZhangDeheng
-- 創建時間：2008-11-26 19:06:26
-----------------------------------------------------------

-- 離開船
local tbMap	= Map:GetClass(560);
local tbTrap_1 = tbMap:GetTrapClass("to_zhandou");

tbTrap_1.tbSendPos = {1712, 3119};

function tbTrap_1:OnPlayer()
	me.NewWorld(me.nMapId, self.tbSendPos[1], self.tbSendPos[2]);
	me.SetFightState(1);
end

-- 回到船
local tbMap	= Map:GetClass(560);
local tbTrap_2 = tbMap:GetTrapClass("to_feizhandou");

tbTrap_2.tbSendPos = {1722, 3129};

function tbTrap_2:OnPlayer()
	me.NewWorld(me.nMapId, self.tbSendPos[1], self.tbSendPos[2]);
	me.SetFightState(0);
end
