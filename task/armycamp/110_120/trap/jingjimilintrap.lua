-------------------------------------------------------
-- 文件名　：jingjimilintrap.lua
-- 文件描述：荊棘密林TRAP點
-- 創建者　：ZhangDeheng
-- 創建時間：2009-03-16 09:32:51
-------------------------------------------------------


local tbMap	= Map:GetClass(493);
local tbTrap_1 = tbMap:GetTrapClass("trapjingji");

tbTrap_1.szText = "不小心被荊棘割破了皮膚! 我感覺越來越昏迷......";

function tbTrap_1:OnPlayer()
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(me.nMapId);
	if (not tbInstancing) then
		return;
	end;
	
	TaskAct:Talk(self.szText, self.Return, self, me.nId);
end

function tbTrap_1:Return(nId)
	local pPlayer = KPlayer.GetPlayerObjById(nId);
	if (not pPlayer) then
		return;
	end;
	
	pPlayer.NewWorld(pPlayer.nMapId, 1586, 3157);
	pPlayer.SetFightState(0);
	return 0;
end;

local tbMap	= Map:GetClass(493);
local tbTrap_2 = tbMap:GetTrapClass("to_ceng1");

tbTrap_2.szDesc		= "to_ceng1";

tbTrap_2.tbSendPos	= {{1720, 3289}, {1841, 3211}};

function tbTrap_2:OnPlayer()
	local nSubWorld, _, _	= me.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nTrap2Pass == 0) then
		me.NewWorld(me.nMapId, self.tbSendPos[1][1],self.tbSendPos[1][2]);
	else
		me.NewWorld(me.nMapId, self.tbSendPos[2	][1],self.tbSendPos[2][2]);
		tbInstancing:OnCoverBegin(me);
		Task.tbArmyCampInstancingManager:ShowTip(me, "依龍五太爺的描述，找到四根擎天柱，按照<color=red>風林火山<color>的順序開啟");
		me.Msg("依龍五太爺的描述，找到四根擎天柱，按照風林火山的順序開啟");
	end;	
end;
