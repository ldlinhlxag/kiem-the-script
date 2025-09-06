
-- ====================== 文件信息 ======================

-- 大漠古城初始載入腳本
-- Edited by peres
-- 2008/05/15 PM 16:23

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

Require("\\script\\task\\treasuremap\\treasuremap.lua");

local tbInstancing = TreasureMap:GetInstancingBase(253);
tbInstancing.szName = "百年天牢";

-- 第一次打開副本時調用，這個時候裡面肯定沒有別的隊伍
function tbInstancing:OnNew()

end


-- 隊伍開啟一個副本的時候調用，這個時候裡面可能有別的隊伍
function tbInstancing:OnOpen()

end

-- 副本的限制時間到的時候調用
function tbInstancing:OnDelete()

end

-- 副本的時間軸
function tbInstancing:GetSteps()
	local tbStep = 
	{

	}
	
	return tbStep;
end
