-------------------------------------------------------
-- 文件名　：ercengtrap.lua
-- 文件描述：二層BOSS死亡後開啟的TRAP點
-- 創建者　：ZhangDeheng
-- 創建時間：2009-04-09 16:09:31
-------------------------------------------------------

local tbMap	= Map:GetClass(493);
local tbTrap_6 = tbMap:GetTrapClass("to_ceng3");

tbTrap_6.szDesc		= "傳送到第三層";

tbTrap_6.tbSendPos	= {1820, 3646};

function tbTrap_6:OnPlayer()
	local nSubWorld, _, _	= me.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);

	if (tbInstancing.nTrap6Pass == 1) then
		me.NewWorld(me.nMapId, self.tbSendPos[1],self.tbSendPos[2]);
	end;
end;
