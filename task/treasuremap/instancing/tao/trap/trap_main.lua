
-- ====================== 文件信息 ======================

-- 陶朱公疑塚副本 TRAP 點腳本
-- Edited by peres
-- 2008/03/04 PM 08:26

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

local tbMap			= Map:GetClass(254);

local tbLevel_1		= tbMap:GetTrapClass("to_level2");
local tbLevel_2		= tbMap:GetTrapClass("to_level3");

-- 從第一層上到第二層的 Trap 點
function tbLevel_1:OnPlayer()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	assert(tbInstancing);
	
	local nNum = 0;
	
	if tbInstancing.tbLightOpen then
		for j, i in pairs(tbInstancing.tbLightOpen) do
			print ("The tomb pillar: ", j, i);
			nNum = nNum + i;
		end;
		-- 四棧燈都開了，可以通過
		if nNum == 4 then
			return;
		end;
	end;
	
	-- 彈回原處
	nNum = 0;
	me.NewWorld(nMapId, 1612, 3129);
	Dialog:SendInfoBoardMsg(me, "<color=red>Bạn phải hóa giải bùa chú hết 4 cột mới được qua!<color>");

end;

-- 從第二層上到第三層的 Trap 點
function tbLevel_2:OnPlayer()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	assert(tbInstancing);
	
	if not tbInstancing.nSmallBoss_1 or not tbInstancing.nSmallBoss_2 then
		me.NewWorld(nMapId, 1659, 3062);
		return;
	end;
	
	print("The tomb boss 1 & 2: ", tbInstancing.nSmallBoss_1, tbInstancing.nSmallBoss_2);
	
	-- 兩個 BOSS 都殺了，可以通過
	if tbInstancing.nSmallBoss_1 == 1 and tbInstancing.nSmallBoss_2 == 1 then
		return;
	else
		-- 彈回原處
		me.NewWorld(nMapId, 1659, 3062);
		Dialog:SendInfoBoardMsg(me, "<color=red>Một sức mạnh vô hình đã đẩy lui bạn trở lại!<color>");
	end;
end;
