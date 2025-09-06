
-- ====================== 文件信息 ======================

-- 千瓊宮初始載入腳本
-- Edited by peres
-- 2008/07/25 AM 11:28

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

Require("\\script\\task\\treasuremap\\treasuremap.lua");

local tbInstancing = TreasureMap:GetInstancingBase(287);
tbInstancing.szName = "Thiên Quỳnh Cung";

local tbBossPos		=	{
	--      X     Y    NPCID  五行
	[1]	= {1682, 3119,  2739, 1},	-- 羽凌兒（kim）
	[2]	= {1565, 2950,  2740, 2},	-- 蕭媛媛（mộc）
	[3]	= {1579, 2819,  2742, 3},	-- 肖良（thủy）
	[4] = {1714, 2775,  2743, 4},	-- 肖玉（hỏa）
	[5]	= {1812, 2670,  2741, 5},	-- 冷霜然（thổ）	
}

local tbNpcPos		= 	{
	[1] = {1575, 3224,  2737, 5},	-- 一開始的兔子
	[2]	= {1671, 2846,	2757, 5},	-- 李香蘭，金錢任務 NPC
}

local tbStatuaryPos	= {
	[1] = {1694, 3142},
	[2] = {1545, 2927},
	[3] = {1607, 2839},
	[4] = {1780, 2717},
}


-- 第一次打開副本時調用，這個時候裡面肯定沒有別的隊伍
function tbInstancing:OnNew()
	assert(self.nMapTemplateId == self.nMapTemplateId);
	
	self.tbBossIndex		= {};
	self.tbBossLifePoint	= {{},{},{},{},{},{}};	-- BOSS 生命的觸發點
	
	-- 加 BOSS
	for i=1, #tbBossPos do
		local pNpc = KNpc.Add2(tbBossPos[i][3], 95, tbBossPos[i][4], self.nTreasureMapId, tbBossPos[i][1], tbBossPos[i][2]);
		self.tbBossIndex[i] = pNpc.dwId;
		
		-- 統一注冊血量觸發事件，50% 和  30%
		pNpc.AddLifePObserver(50);
		pNpc.AddLifePObserver(30);
		
		self.tbBossLifePoint[i][50]	= 0;
		self.tbBossLifePoint[i][30]	= 0;
	end;
	
	
	self.tbNpcIndex		= {};
	-- 加 NPC
	for i=1, #tbNpcPos do
		local pNpc = KNpc.Add2(tbNpcPos[i][3], 20, tbNpcPos[i][4], self.nTreasureMapId, tbNpcPos[i][1], tbNpcPos[i][2]);
		self.tbNpcIndex[i] = pNpc.dwId;	
	end;
	
	
	self.tbStatuaryIndex	= {};
	-- 加障礙物
	for i=1, #tbStatuaryPos do
		local pNpc = KNpc.Add2(2752, 1, 0, self.nTreasureMapId, tbStatuaryPos[i][1], tbStatuaryPos[i][2]);
		pNpc.szName = " ";
		self.tbStatuaryIndex[i] = pNpc.dwId;	
	end;
	
		
	-- BOSS 被擊殺的數據
	self.tbBossDown		= {0,0,0,0,0,0};
	
	-- 如果兔子被殺死，則為 1
	self.nRabbit		= 0;
	
	-- 護送小憐的進程
	self.nGirlProStep	= 0;
	
	-- 護送小憐的 NPC ID
	self.nGirlId		= 0;
	
	-- 如果小憐死了，則為 1
	self.nGirlKilled	= 0;
end;

-- 隊伍開啟一個副本的時候調用，這個時候裡面可能有別的隊伍
function tbInstancing:OnOpen()

end

-- 副本的限制時間到的時候調用
function tbInstancing:OnDelete()

end
