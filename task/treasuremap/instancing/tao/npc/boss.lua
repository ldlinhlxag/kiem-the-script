
-- ====================== 文件信息 ======================

-- 陶朱公疑塚 BOSS 腳本
-- Edited by peres
-- 2008/03/04 PM 08:26

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

-- 第二層左邊的 BOSS
local tbNpc_1	= Npc:GetClass("taozhugongyizhong_boss1");

function tbNpc_1:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	tbInstancing.nSmallBoss_1		= 1;
	
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_2["Npc_Boss1"], 24, -1, -1, him);
	end
	
	if tbInstancing.nSmallBoss_1 == 1 and tbInstancing.nSmallBoss_2 == 1 then	
		if tbInstancing.tbStele_2_Idx then
			for i=1, #tbInstancing.tbStele_2_Idx do
				local nNpcId	= tbInstancing.tbStele_2_Idx[i];
				local pNpc		= KNpc.GetById(nNpcId);
		         if pNpc then
			       pNpc.Delete();
		         end;
			end;
		end;
	end;
	
	TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);

end;


-- 第二層右邊的 BOSS
local tbNpc_2	= Npc:GetClass("taozhugongyizhong_boss2");

function tbNpc_2:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	tbInstancing.nSmallBoss_2		= 1;
	
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_2["Npc_Boss1"], 24, -1, -1, him);
	end
	
	if tbInstancing.nSmallBoss_1 == 1 and tbInstancing.nSmallBoss_2 == 1 then	
		if tbInstancing.tbStele_2_Idx then
			for i=1, #tbInstancing.tbStele_2_Idx do
				local nNpcId	= tbInstancing.tbStele_2_Idx[i];
				local pNpc		= KNpc.GetById(nNpcId);
		         if pNpc then
			       pNpc.Delete();
		         end;
			end;
		end;
	end;
	
	TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
	
end;



-- 最終 BOSS
local tbNpc_3	= Npc:GetClass("taozhugongyizhong_boss3");

function tbNpc_3:OnDeath(pNpc)
	local nNpcMapId, nNpcPosX, nNpcPosY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nNpcMapId);
	assert(tbInstancing);
	
	KNpc.Add2(2705, 1, -1, nNpcMapId, 1639, 3085);	-- 無名女子
	
	local pOutNpc = KNpc.Add2(2708, 1, -1, nNpcMapId, 1684, 3028);	-- 出口點
		pOutNpc.szName = "Ra khỏi điểm truyền tống";
	
	local pPlayer = pNpc.GetPlayer();
	
	if (pPlayer) then
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_2["Npc_Boss2"], 24, -1, -1, him);
		
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
	end
	
	TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
	-- 添加親密度
	local tbTeamMembers = pPlayer.GetTeamMemberList();
	TreasureMap:AddFriendFavor(tbTeamMembers, pPlayer.nMapId, 50);
	
	-- 師徒成就：副本陶朱公
	TreasureMap:GetAchievement(tbTeamMembers, Achievement.FUBEN_TAOZHUGONG, pPlayer.nMapId);
	
	--掉落篝火
	KItem.AddItemInPos(nNpcMapId,nNpcPosX,nNpcPosY,18,1,99,1);
	

end;


local tbTaskNpc			= Npc:GetClass("taozhugong_task_stele");


-- 接任務的 NPC
function tbTaskNpc:OnDialog()
	return;
end;
