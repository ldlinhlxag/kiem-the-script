
-- ====================== 文件信息 ======================

-- 大漠古城 BOSS 腳本
-- Edited by peres
-- 2008/05/15 PM 20:27

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

local tbBoss_1			= Npc:GetClass("damogucheng_boss1");	-- 面具武士
local tbBoss_2			= Npc:GetClass("damogucheng_boss2");	-- 尸逐達魯
local tbBoss_3			= Npc:GetClass("damogucheng_boss3");	-- 無名氏


function tbBoss_1:OnDeath(pNpc)
	local nNpcMapId, nNpcPosX, nNpcPosY	= him.GetWorldPos();
	
	-- 加一個袋子
	KNpc.Add2(2727, 1, -1, nNpcMapId, nNpcPosX, nNpcPosY);
	
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_2["Npc_Boss1"], 24, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
	end
	
end;

function tbBoss_2:OnDeath(pNpc)
	local nNpcMapId, nNpcPosX, nNpcPosY	= him.GetWorldPos();
	
	-- 加一個袋子
	KNpc.Add2(2729, 1, -1, nNpcMapId, nNpcPosX, nNpcPosY);
	
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_2["Npc_Boss2"], 24, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
	end
	
end;

function tbBoss_3:OnDeath(pNpc)

	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	tbInstancing.nBoss_3_kill		= 1;

	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_2["Npc_Boss2"], 24, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
		
		-- 副本任務的處理
		local tbTeamMembers, nMemberCount	= pPlayer.GetTeamMemberList();
		
		if (not tbTeamMembers) or (nMemberCount <= 0) then
			TreasureMap:InstancingTask(pPlayer, tbInstancing.nMapTemplateId);
			return;
		else
			for i=1, nMemberCount do
				local pNowPlayer	= tbTeamMembers[i];
				TreasureMap:InstancingTask(pNowPlayer, tbInstancing.nMapTemplateId);
			end
		end
		-- 添加親密度
		TreasureMap:AddFriendFavor(tbTeamMembers, pPlayer.nMapId, 50);
		
		-- 師徒成就：副本大漠古城
		TreasureMap:GetAchievement(tbTeamMembers, Achievement.FUBEN_DAMOGUCHENG, pPlayer.nMapId);
	end	
	
	if tbInstancing.tbStele_1_Idx then
		for i=1, #tbInstancing.tbStele_1_Idx do
			local pNpc	= KNpc.GetById(tbInstancing.tbStele_1_Idx[i]);
			if pNpc then
				pNpc.Delete();
			end;
		end;
	end;
	
end;
