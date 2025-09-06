
-- ====================== 文件信息 ======================

-- 大漠古城物品入腳本
-- Edited by peres
-- 2008/05/15 PM 16:23

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

local tbItem		= Item:GetClass("old_zither");

tbItem.tbCallNpc		= {
		{1908, 3304},
		{1918, 3309},
		{1923, 3321},
		{1919, 3333},
		{1908, 3338},
		{1898, 3333},
		{1893, 3321},
		{1897, 3310},
	};


function tbItem:OnUse()
	local nSubWorld, nX, nY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	
	if tbInstancing.nBoss_3_call ~= 0 or (not tbInstancing) then
		Dialog:SendInfoBoardMsg(me, "<color=red>Hiện tại không thể sử dụng!<color>");
		return;	
	end;
	
	local _, nDistance = TreasureMap:GetDirection({nX, nY}, {1908, 3319})	
	
	if nDistance > 10 then
		Dialog:SendInfoBoardMsg(me, "<color=red>Không thể sử dụng ở đây!<color>");
		return;
	end;

	local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,		
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
	}
	
	GeneralProcess:StartProcess("Đang sử dụng…", Env.GAME_FPS * 10, {self.ItemUsed, self}, nil, tbEvent);

end;


function tbItem:ItemUsed()
	local nSubWorld, nX, nY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nSubWorld);
	--assert(tbInstancing);
	if not tbInstancing then  --改成 return zounan
		return;
	end
	
	-- 在這裡刪除物品
	me.ConsumeItemInBags(1, 18, 1, 96, 1);
	
	local pBoss		= KNpc.Add2(2719, 75, -1, nSubWorld, 1908, 3319);
	pBoss.szName	= "Vô Danh Thị";
	
	for i=1, #self.tbCallNpc do
		local pNpc	= KNpc.Add2(2716, 35, -1, nSubWorld, self.tbCallNpc[i][1], self.tbCallNpc[i][2]);
		pNpc.szName	= "Quỷ Sứ";
	end;
	
	-- 加石塊擋住路口
	tbInstancing.tbStele_1_Idx	= {};
	
	local tbStele_1	= {{1889, 3346}, {1891, 3348}, {1894, 3349}};
	for i=1, #tbStele_1 do
		local pNpc		= KNpc.Add2(2707, 1, -1, nSubWorld, tbStele_1[i][1], tbStele_1[i][2]);
		pNpc.szName		= " ";
		
		-- 將石塊的 IDX 保存起來，擊殺 BOSS 後刪除
		table.insert(tbInstancing.tbStele_1_Idx, pNpc.dwId);
	end;
	
	tbInstancing.nBoss_3_call  = 1;
end;
