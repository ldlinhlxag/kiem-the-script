
-- ====================== 文件信息 ======================

-- 萬花谷副本 TRAP 點腳本
-- Edited by peres
-- 2008/11/10 PM 03:03

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

local tbMap			= Map:GetClass(344);

local tbTrap_1		= tbMap:GetTrapClass("trap_1");
local tbTrap_2		= tbMap:GetTrapClass("trap_2");

function tbTrap_1:OnPlayer()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if tbInstancing.nDoorOpen ~= 1 then
		me.NewWorld(nMapId, 1666, 3053);
	end;
end;


function tbTrap_2:OnPlayer()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if tbInstancing.nBoss_3 ~= 1 then
		me.NewWorld(nMapId, 1676, 2975);
		Dialog:SendInfoBoardMsg(me, "<color=red>Đây là Tử Sắc Thạch hãy nhanh chóng đem về cho Thứ Sử<color>");
	end;
end;
