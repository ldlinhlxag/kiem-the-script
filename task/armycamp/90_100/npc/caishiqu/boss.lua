
-- 第二層左邊的 BOSS
local tbNpc_1	= Npc:GetClass("caishiquboss");

tbNpc_1.ENTRYWAY_RATE =  50; --打死BOSS後出現秘徑的概率

function tbNpc_1:OnDeath(pNpc)
	local nSubWorld, nNpcPosX, nNpcPosY	= him.GetWorldPos();

	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	tbInstancing.nCaiShiQuPass = 1;
	local pPlayer  	= pNpc.GetPlayer();
	
	local nEntryWayRate = MathRandom(100);
	if (self.ENTRYWAY_RATE > nEntryWayRate) then	
		-- 開出秘徑
		
		local pEntryway = KNpc.Add2(4114, 1, -1, nSubWorld, nNpcPosX, nNpcPosY);
		local tbNpcData = pEntryway.GetTempTable("Task");
		tbNpcData.nEntrancePlayerId = pPlayer.nId;
		tbNpcData.nEntryMapId	= nSubWorld;
		KTeam.Msg2Team(pPlayer.nTeamId, pPlayer.szName.."發現了通往伏牛山庄的秘徑！");
	end;
	
	KNpc.Add2(2793, 1, -1, nSubWorld, 1694, 3862);
	local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId)
	
	-- 用於老玩家召回任務完成任務記錄
--	local tbMemberList = pPlayer.GetTeamMemberList();	
	for _, player in ipairs(tbPlayList) do 
		Task.OldPlayerTask:AddPlayerTaskValue(player.nId, 2082, 4);
	end;
	
	-- 增加隊長的領袖榮譽
	local tbHonor = {[3] = 24, [4] = 36, [5] = 48, [6] = 60}; -- 3、4、5、6人隊長的領袖榮譽表
	local tbTeamPlayer, _ = KTeam.GetTeamMemberList(pPlayer.nTeamId);	
	if tbHonor[nCount] and tbTeamPlayer then
		PlayerHonor:AddPlayerHonorById_GS(tbTeamPlayer[1], PlayerHonor.HONOR_CLASS_LINGXIU, 0, tbHonor[nCount]);
	end
	
	-- 四次任務
	for _, player in ipairs(tbPlayList) do 
		local tbPlayerTasks	= Task:GetPlayerTask(player).tbTasks;
		local tbTask1 = tbPlayerTasks[381];
		local tbTask2 = tbPlayerTasks[429]
		if ((tbTask1 and tbTask1.nReferId == 565) or (tbTask2 and tbTask2.nReferId == 622)) then
			player.SetTask(1022, 200, player.GetTask(1022, 200) + 1);
		end;
		
		-- 額外獎勵回調
		local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("ArmyCampBoss", player);
		SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
		SpecialEvent.ActiveGift:AddCounts(player, 7);
	end;
end

