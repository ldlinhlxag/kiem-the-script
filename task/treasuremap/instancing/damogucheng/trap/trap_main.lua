
-- ====================== 文件信息 ======================

-- 大漠古城副本 TRAP 點腳本
-- Edited by peres
-- 2008/03/04 PM 08:26

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

local tbMap			= Map:GetClass(272);

local tbTrap_1		= tbMap:GetTrapClass("to_lock");
local tbTrap_2		= tbMap:GetTrapClass("to_finalboss");
local tbTrap_3		= tbMap:GetTrapClass("to_leave");

function tbTrap_1:OnPlayer()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	assert(tbInstancing);
	if tbInstancing.nGateLock ~=1 then
		me.NewWorld(nMapId, 1714, 3297);
		Dialog:SendInfoBoardMsg(me, "<color=red>Bạn phải mở khóa trên đại môn mới có thể đi qua!<color>");
		return;
	end;
end;

function tbTrap_2:OnPlayer()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	assert(tbInstancing);
	if tbInstancing.nBoss_3_call == 1 and tbInstancing.nBoss_3_kill == 0 then
		me.NewWorld(nMapId, 1904, 3322);		
		return;
	end;
end;

function tbTrap_3:OnPlayer()
	local nTreasureId = TreasureMap:GetMyInstancingTreasureId(me);
	if not nTreasureId or nTreasureId <= 0 then
		me.Msg("Đọc thời gian đăng nhập thất bại, xin kiểm tra lại từ đầu!");
		return;
	end;
	local tbInfo				= TreasureMap:GetTreasureInfo(nTreasureId);
	local nMapId, nMapX, nMapY	= tbInfo.MapId, tbInfo.MapX, tbInfo.MapY;
	
	me.NewWorld(nMapId, nMapX, nMapY);
end;
