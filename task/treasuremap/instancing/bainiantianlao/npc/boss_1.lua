
-- 百年天牢的第一個 BOSS，殺死他可以獲得進入密室的鑰匙

local tbNpc_1	= Npc:GetClass("bainiantianlao_boss1");

function tbNpc_1:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	tbInstancing.nBoss				= 1;
	
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		pPlayer.DropRateItem(TreasureMap.szBossDropPath_1, 24, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
	end
end;



local tbNpc_2	= Npc:GetClass("bainiantianlao_boss2");

function tbNpc_2:OnDeath(pNpc)
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		pPlayer.DropRateItem(TreasureMap.szBossDropPath_1, 24, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
		-- 添加親密度
		local tbTeamList = pPlayer.GetTeamMemberList();
		TreasureMap:AddFriendFavor(tbTeamList, pPlayer.nMapId, 50);
		
		-- 成就：完成初級副本百年天牢
		TreasureMap:GetAchievement(tbTeamList, Achievement.FUBEN_BAINIANTIANLAO, pPlayer.nMapId);
	end
	
	--掉落篝火
	local nNpcMapId, nNpcPosX, nNpcPosY = him.GetWorldPos();
	KItem.AddItemInPos(nNpcMapId,nNpcPosX,nNpcPosY,18,1,99,1);
end;
