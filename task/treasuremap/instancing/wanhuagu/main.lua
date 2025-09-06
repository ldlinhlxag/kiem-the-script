
-- ====================== 文件信息 ======================

-- 萬花谷初始載入腳本
-- Edited by peres
-- 2008/10/29 PM 04:18

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

Require("\\script\\task\\treasuremap\\treasuremap.lua");

local tbInstancing = TreasureMap:GetInstancingBase(344);
tbInstancing.szName = "萬花谷";

-- 百人戰 NPC 及坐標
tbInstancing.tbSoldierPos_1		= {
		--    ID    等級 五行    X     Y       CAMP
		[1] = {2775, 80,  1,	1654, 3067,		5},
		[2] = {2775, 80,  1,	1657, 3070,		5},
		[3] = {2775, 80,  1,	1660, 3073,		5},
		[4] = {2775, 80,  1,	1652, 3074,		5},
		[5] = {2775, 80,  1,	1656, 3078,		5},
};

tbInstancing.tbSoldierPos_2		= {
		--    ID    等級 五行    X     Y       CAMP
		[1] = {2775, 80,  1,	1654, 3067,		5},
		[2] = {2775, 80,  1,	1657, 3070,		5},
		[3] = {2775, 80,  1,	1660, 3073,		5},
};

tbInstancing.tbDoctorPos		= {
		[1] = {2782, 80,  1,	1652, 3074,		5},
		[2] = {2782, 80,  1,	1656, 3078,		5},
}

-- 陶子的尋路
tbInstancing.tbTaoZiSeekPos		= {
	{1609,	3161},
	{1616,	3140},
	{1618,	3129},
	{1631,	3118},
	{1644,	3100},
	{1648,	3091},	
	{1660,	3064},
	{1666,	3052},
	{1663,	3056},	
};

-- 陶子尋路2
tbInstancing.tbTaoZiSeekPos_2		= {
	{1655,	3073},
	{1651,	3092},
	{1664,	3109},
	{1674,	3128},
	{1680,	3136},
};


-- 第一次打開副本時調用，這個時候裡面肯定沒有別的隊伍
function tbInstancing:OnNew()
	
	-- 定義 BOSS 出現的坐標與 ID
	self.tbBossPos	= {
			--    ID    等級 五行    X     Y       CAMP
			[1] = {2760, 100, 1,	1683, 3141,		5},	-- 鐵浮屠 BOSS1
			[2]	= {2766, 100, 1,	1715, 3085,		5},	-- 百羽 BOSS2
			[3]	= {2767, 100, 2,	1734, 2944,		5},	-- 黃散一 BOSS3
			[4]	= {2768, 100, 2,	1691, 2891,		5},	-- 柳生 BOSS4
			[5]	= {2769, 100, 2,	1678, 2903,		5},	-- 賈茹 BOSS4
			[6]	= {2772, 100, 2,	1588, 2887,		5},	-- 谷仙仙
			[7]	= {2773, 100, 2,	1610, 3042,		5},	-- 醉僧
		}
		
	self.tbNpcPos	= {
			--    ID    等級 五行    X     Y       CAMP
			[1] = {2761, 80,  1,	1598, 3177,		0},	-- 陶子戰斗1
			[2] = {2762, 50,  1,	1598, 3177,		0},	-- 陶子對話1
			[3] = {2763, 100, 1,	1598, 3177,		0},	-- 陶子戰斗2
			[4] = {2759, 50,  1,	1593, 3180,		5},	-- 鐵莫西
			[5] = {2764, 100, 1,	1688, 3136,		0},	-- 青青戰斗
			[6] = {2765, 100, 1,	1688, 3136,		0},	-- 青青對話
			[7] = {2792, 100, 1,	1686, 3135,		0},	-- 陶子對話2
			[8]	= {2778, 100, 1,	1605, 2895,		5}, -- 花豹1
			[9]	= {2778, 100, 1,	1601, 2898,		5}, -- 花豹2
			[10]	= {2787, 10, 1,	1629, 2930,		0}, -- 牧童
			[11]	= {2788, 10, 1,	1631, 2933,		0}, -- 綿羊
			[12]	= {2789, 10, 1,	1564, 3205,		0}, -- 阮小六
			[13]	= {2790, 10, 1,	1734, 2944,		0}, -- 黃散一對話
			
			[14]	= {2776, 90, 1,	1710, 3070,		5}, -- 黑熊
			[15]	= {2776, 90, 1,	1715, 3066,		5}, -- 黑熊
			[16]	= {2776, 90, 1,	1721, 3069,		5}, -- 黑熊
			
		}
	
	-- 各種物件的坐標
	self.tbObjPos	= {
			[1] = {2783, 80,  1,	1669, 3047,		0},	-- 大門鐵欄
			
			-- 紫花障礙
			[2] = {2784, 80,  1,	1671, 2972,		0},
			[3] = {2784, 80,  1,	1673, 2970,		0},
			[4] = {2784, 80,  1,	1672, 2971,		0},
			[5] = {2784, 80,  1,	1674, 2969,		0},
			
			-- 拿鑰匙的布袋子
			[6] = {2785, 80,  1,	1683, 3141,		0},
			-- 拿酒的布袋子
			[7] = {2785, 80,  1,	1683, 2889,		0},
			-- 拿笛子的布袋子
			[8] = {2786, 80,  1,	1595, 2890,		0},
			
			[9]		= {2791, 60,  1,	1715, 3085,		0},		-- BOSS 2 箱子
			[10]	= {2791, 60,  1,	1588, 2887,		0},		-- BOSS 5 箱子
			[11]	= {2791, 60,  1,	1603, 3043,		0},		-- BOSS 6 箱子
			[12]	= {2791, 60,  1,	1610, 3043,		0},		-- BOSS 6 箱子
			[13]	= {2791, 60,  1,	1617, 3043,		0},		-- BOSS 6 箱子
	}
	
	-- 初始化變量
	self.nCaptainFight		= 0;	-- 與剛開始的鐵莫西戰斗完，變 1
	self.nTaoZiEscort		= 0;	-- 開始陶子護送：1;   護送到達：2
	self.nSoldierFight		= 0;	-- 百人戰殺死士兵數，5 人為一批，3 批後結束
	
	self.nTaoZi_Death		= 0;	-- 如果陶子死亡，為 1;
	self.nQingQing_Death	= 0;	-- 如果青青死亡，為 1;
	
	self.nDoorOpen			= 0;	-- 大門可以通過，為 1;
	self.nSoldierEnd		= 0;	-- 完成百人戰後，BOSS 1 出現
	self.nBoss_1			= 0;	-- BOSS 1 鐵浮屠死亡後，為 1
	self.nBoss_2			= 0;	-- BOSS 2 死亡後，為 1
	self.nBoss_3			= 0;	-- BOSS 3 死亡後，為 1
	self.nBoss_4			= 0;	-- BOSS 4 死亡後，為 1
	self.nBoss_5_Ready		= 0;	-- 吹響笛子後，BOSS 5 可以出來了
	
	-- BOSS 生命點的觸發
	self.tbBossLifePoint	= {
		[1]	= 0,
		[2]	= 0,
		[3]	= 0,
		[4]	= 0,
		[5]	= 0,
		[6]	= 0,
	}
	
	-- 鐵莫西與陶子在戰斗
	self.pTaoZi_Fight_1		= self:AddNpc(self.tbNpcPos[1], self.nTreasureMapId);
	self.dwIdTaoZi_Fight_1	= self.pTaoZi_Fight_1.dwId;
	
	self.pCaptain_Fight		= self:AddNpc(self.tbNpcPos[4], self.nTreasureMapId);
	
	-- 大門的鐵欄
	local pDoor				= self:AddNpc(self.tbObjPos[1], self.nTreasureMapId);
	self.dwIdDoor			= pDoor.dwId;
	pDoor.szName			= "   ";
	
	-- 障礙紫花
	self.tb_dwIdAster		= {};
	for i=2, 5 do
		local pAster			= self:AddNpc(self.tbObjPos[i], self.nTreasureMapId);
		self.tb_dwIdAster[i-1]	= pAster.dwId;
		pAster.szName			= "   ";
	end;
	
	-- 加 BOSS
	local pBoss_2			= self:AddNpc(self.tbBossPos[2], self.nTreasureMapId);
	self.dwIdBoss_2			= pBoss_2.dwId;
	pBoss_2.AddLifePObserver(50);
	
	local pBoss_3			= self:AddNpc(self.tbBossPos[3], self.nTreasureMapId);
	self.dwIdBoss_3			= pBoss_3.dwId;
	pBoss_3.AddLifePObserver(60);
	pBoss_3.AddLifePObserver(30);
	
	local pBoss_4_male		= self:AddNpc(self.tbBossPos[4], self.nTreasureMapId);
	self.dwIdBoss_4_male	= pBoss_4_male.dwId;
	pBoss_4_male.AddLifePObserver(60);
	
--	local pBoss_5			= self:AddNpc(self.tbBossPos[6], self.nTreasureMapId);
--	self.dwIdBoss_5			= pBoss_5.dwId;
	
	-- 加花豹
	local pLeopard_1		= self:AddNpc(self.tbNpcPos[8], self.nTreasureMapId);
	self.dwIdLeopard_1		= pLeopard_1.dwId;
	
	local pLeopard_2		= self:AddNpc(self.tbNpcPos[9], self.nTreasureMapId);
	self.dwIdLeopard_2		= pLeopard_2.dwId;
	
	-- 加裝笛子的袋子
	local pBag_2			= self:AddNpc(self.tbObjPos[8], self.nTreasureMapId);
	
	-- 加綿羊
	local pTalkNpc_1		= self:AddNpc(self.tbNpcPos[10], self.nTreasureMapId);
	local pTalkNpc_2		= self:AddNpc(self.tbNpcPos[11], self.nTreasureMapId);
end;

-- 內部函數，CALL 出一個NPC，傳入參數是內部固定的格式
-- 返回值：pNpc
function tbInstancing:AddNpc(tbPos, nMapId)
	local pNpc = KNpc.Add2(tbPos[1], tbPos[2], tbPos[3], nMapId, tbPos[4], tbPos[5]);
	pNpc.SetCurCamp(tbPos[6]);
	
	return pNpc;
end;

-- 內部函數，根據 NPC ID CALL 出一個 NPC，並指定一個尋路路徑，可以有完成後的回調
function tbInstancing:AddSeekNpc(nNpcId, nLevel, nX, nY, tbSeekPos, nCamp, pPlayer, nCallBack, tbNpc)
	local pFightNpc		= KNpc.Add2(nNpcId, nLevel, -1, self.nTreasureMapId, nX, nY, 0, 0, 1);
	pFightNpc.SetCurCamp(nCamp);
	
	pFightNpc.RestoreLife();
	
	if nCallBack == 1 and tbNpc then
		pFightNpc.GetTempTable("Npc").tbOnArrive = {tbNpc.OnArrive, tbNpc, pFightNpc, pPlayer};
	end;
	
	pFightNpc.AI_ClearPath();
	
	for _,Pos in ipairs(tbSeekPos) do
		if (Pos[1] and Pos[2]) then
			pFightNpc.AI_AddMovePos(tonumber(Pos[1])*32, tonumber(Pos[2])*32)
		end
	end;
	
	if pPlayer then
		pFightNpc.SetNpcAI(9, 50, 1, -1, 25, 25, 25, 0, 0, 0, pPlayer.GetNpc().nIndex);
	else
		pFightNpc.SetNpcAI(9, 50, 1, -1, 25, 25, 25, 0, 0, 0, 0);
	end;

	return pFightNpc;
end;


-- 副本的時間軸
function tbInstancing:GetSteps()
	local tbStep = 
	{
		-- 第一步：與鐵莫西戰斗完，將陶子變成對話 NPC
		{
			tbActions = {{self.tbActions_1, self}}, 
			tbConditions = {{self.tbConditions_1, self}},
			nTime = 1,
		},

		-- 第二步：護送陶子到門口，開始百人戰
		{
			tbActions = {{self.tbActions_2, self}}, 
			tbConditions = {{self.tbConditions_2, self}},
			nTime = 3,
		},
		
		-- 第三步：百人戰二開始
		{
			tbActions = {{self.tbActions_3, self}}, 
			tbConditions = {{self.tbConditions_3, self}},
			nTime = 8,
		},
		
		-- 百人戰三開始
		{
			tbActions = {{self.tbActions_4, self}}, 
			tbConditions = {{self.tbConditions_4, self}},
			nTime = 8,
		},
		
		-- BOSS1 出現，去和陶子救青青
		{
			tbActions = {{self.tbActions_5, self}}, 
			tbConditions = {{self.tbConditions_5, self}},
			nTime = 5,
		},		
	}
	return tbStep;
end


function tbInstancing:tbConditions_1()
	if self.nCaptainFight == 1 and self.nTaoZi_Death ==0 then
		return 1;
	end;
	return 0;
end;

function tbInstancing:tbActions_1()
	local pNpc	= KNpc.GetById(self.dwIdTaoZi_Fight_1);
	if pNpc then
		pNpc.Delete();
		self:AddNpc(self.tbNpcPos[2], self.nTreasureMapId);
	end;
end;

function tbInstancing:tbConditions_2()
	if self.nTaoZiEscort == 2 then
		return 1;
	end;
	return 0;
end;

function tbInstancing:tbActions_2()
	local tbPos	 = self.tbSoldierPos_1;
	for i=1, #tbPos do
		self:AddSeekNpc(tbPos[i][1],
						tbPos[i][2],
						tbPos[i][4],
						tbPos[i][5],
						{{1661, 3058},{1663, 3056}},
						5,
						nil,
						0,
						nil);
	end;
end;

function tbInstancing:tbConditions_3()
	if self.nSoldierFight == 5 and self.nTaoZi_Death == 0 then
		return 1;
	end;
end;

function tbInstancing:tbActions_3()
	local tbPos	 = self.tbSoldierPos_2;
	for i=1, #tbPos do
		self:AddSeekNpc(tbPos[i][1],
						tbPos[i][2],
						tbPos[i][4],
						tbPos[i][5],
						{{1661, 3058},{1663, 3056}},
						5,
						nil,
						0,
						nil);
	end;
	tbPos	= self.tbDoctorPos;
	for i=1, #tbPos do
		self:AddNpc(tbPos[i], self.nTreasureMapId);
	end;
end;

function tbInstancing:tbConditions_4()
	if self.nSoldierFight == 10 and self.nTaoZi_Death == 0 then
		return 1;
	end;
end;

function tbInstancing:tbActions_4()
	local tbPos	 = self.tbSoldierPos_2;
	for i=1, #tbPos do
		self:AddSeekNpc(tbPos[i][1],
						tbPos[i][2],
						tbPos[i][4],
						tbPos[i][5],
						{{1661, 3058},{1663, 3056}},
						5,
						nil,
						0,
						nil);
	end;
	tbPos	= self.tbDoctorPos;
	for i=1, #tbPos do
		self:AddNpc(tbPos[i], self.nTreasureMapId);
	end;	
end;

function tbInstancing:tbConditions_5()
	if self.nSoldierFight == 15 and self.nTaoZi_Death == 0 then
		return 1;
	end;
end;

function tbInstancing:tbActions_5()
	print ("tbInstancing:tbActions_5()");
	if self.pTaoZi_Fight_2 then
		self.pTaoZi_Fight_2.SendChat("Ta thấy thanh thanh rồi ! ta sẽ đi cưu cô ấy !");
		self.pTaoZi_Fight_2.RestoreLife();
		self.pTaoZi_Fight_2.AI_ClearPath();
		for _,Pos in ipairs(self.tbTaoZiSeekPos_2) do
			if (Pos[1] and Pos[2]) then
				self.pTaoZi_Fight_2.AI_AddMovePos(tonumber(Pos[1])*32, tonumber(Pos[2])*32)
			end
		end;		
		self.pTaoZi_Fight_2.SetNpcAI(9, 50, 1, -1, 25, 25, 25, 0, 0, 0, 0);
	end;
	
	-- 出現 BOSS1 和青青
	local pQingQing_Fight_1	= self:AddNpc(self.tbNpcPos[5], self.nTreasureMapId);
	if pQingQing_Fight_1 then
		self.dwQingQing_F_1 = pQingQing_Fight_1.dwId;
	end;
	self.pBoss_1			= self:AddNpc(self.tbBossPos[1], self.nTreasureMapId);
	
	-- 給 BOSS 1 設置生命觸發點
	self.pBoss_1.AddLifePObserver(50);
	self.pBoss_1.AddLifePObserver(30);
end;


-- 隊伍開啟一個副本的時候調用，這個時候裡面可能有別的隊伍
function tbInstancing:OnOpen()

end;

-- 副本的限制時間到的時候調用
function tbInstancing:OnDelete()

end;
