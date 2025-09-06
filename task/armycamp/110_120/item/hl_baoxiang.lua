
local tbHLTreasureBox = Npc:GetClass("hl_baoxiang");

tbHLTreasureBox.ALL_LOCK_COUNT 	= 5; 	--箱子的總層數
tbHLTreasureBox.COST_TIME			= 100	--開箱需要的時間
tbHLTreasureBox.TIRED_DURATION		= 10 * Env.GAME_FPS;	-- 勞累持續時間
tbHLTreasureBox.TIRED_SKILLID		= 389;	--技能 用於控制時間間隔

tbHLTreasureBox.tbProlibity = {
			50,
			30,
			20,
		}

-- 在開啟每層寶箱時 掉落的物品及物品的數量
tbHLTreasureBox.tbDrapItem = 
{
	{szDropItemFilePath = "setting\\npc\\droprate\\renwudiaoluo\\baoxiang_lv1.txt", nDrapItemCount = 6,},
	{szDropItemFilePath = "setting\\npc\\droprate\\renwudiaoluo\\baoxiang_lv2.txt", nDrapItemCount = 6,},
	{szDropItemFilePath = "setting\\npc\\droprate\\renwudiaoluo\\baoxiang_lv3.txt", nDrapItemCount = 6,},
	{szDropItemFilePath = "setting\\npc\\droprate\\renwudiaoluo\\baoxiang_lv4.txt", nDrapItemCount = 6,},
	{szDropItemFilePath = "setting\\npc\\droprate\\renwudiaoluo\\baoxiang_lv5.txt", nDrapItemCount = 6,},
}

-- 打開一層
function tbHLTreasureBox:DecreaseLockLayer(pPlayer, pNpc)
	if not pPlayer or not pNpc then
		return;	
	end
	
	local tbNpcData = pNpc.GetTempTable("Task"); 
	assert(tbNpcData);
	
	if (5 <= tbNpcData.CUR_LOCK_COUNT) then
		return;
	end
	
	tbNpcData.CUR_LOCK_COUNT = tbNpcData.CUR_LOCK_COUNT + 1;
	KTeam.Msg2Team(pPlayer.nTeamId, pPlayer.szName.."打開了寶箱的第<color=yellow>" .. tbNpcData.CUR_LOCK_COUNT .. "<color>層鎖！");
	
	if (tbNpcData.CUR_LOCK_COUNT <= 5) then
		local tbLayerInfo = self.tbDrapItem[tbNpcData.CUR_LOCK_COUNT];
		pPlayer.DropRateItem(tbLayerInfo.szDropItemFilePath, tbLayerInfo.nDrapItemCount, -1, -1, pNpc);
	end
	--最後一層
	if(tbNpcData.CUR_LOCK_COUNT == 5) then 
		KTeam.Msg2Team(pPlayer.nTeamId, "<color=yellow>寶箱已經被打開<color>！");
		tbNpcData.CUR_LOCK_COUNT = 0;
		local nEntryWayRate = MathRandom(100);
		--print(self.tbProlibity[tbNpcData.nHongLianDiYu], nEntryWayRate);
		if (tbNpcData.nHongLianDiYu and tbNpcData.nHongLianDiYu > 0 and tbNpcData.nHongLianDiYu < 4 and self.tbProlibity[tbNpcData.nHongLianDiYu] > nEntryWayRate) then	
			local nMapId, nPosX, nPosY = pNpc.GetWorldPos();
			local pBox = KNpc.Add2(4277, 120, -1, nMapId, nPosX, nPosY);
			local tbData = pBox.GetTempTable("Task");
			tbData.nHongLianDiYu = tbNpcData.nHongLianDiYu;
			local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);
			if (tbInstancing) then
				--Lib:ShowTB(tbInstancing.tbKuoZhanQuOut);
				tbInstancing.tbKuoZhanQuOut[tbData.nHongLianDiYu] = 1;
			end;
			
			local tbPlayList, _ = KPlayer.GetMapPlayer(nMapId);
			for _, teammate in ipairs(tbPlayList) do
				Task.tbArmyCampInstancingManager:ShowTip(teammate, "一道神秘的地道入口出現在眼前");
			end;
		end;
		pNpc.Delete();
	end
end

--開啟寶箱
function tbHLTreasureBox:OnCheckOpen(nPlayerId, nNpcId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc or pNpc.nIndex == 0) then
		return;
	end
	
	local tbNpcData = pNpc.GetTempTable("Task"); 
	assert(tbNpcData);
	
	local nCurLockLayer = tbNpcData.CUR_LOCK_COUNT;
	if (5 <= nCurLockLayer) then
		-- 已經全部打開
		return;
	end
	
	pPlayer.AddSkillState(self.TIRED_SKILLID, 1, 1, self.TIRED_DURATION);
	self:DecreaseLockLayer(pPlayer, pNpc);
end

--點擊寶箱時對話
function tbHLTreasureBox:OnDialog()
	
	local pNpc = KNpc.GetById(him.dwId);
	if (not pNpc or pNpc.nIndex == 0) then
		return;
	end
	--間隔時間是否到	
	local nRet = me.GetSkillState(self.TIRED_SKILLID);
	if (nRet ~=  -1) then
		Dialog:SendInfoBoardMsg(me, "<color=red>你太累了需要休息一會才能繼續開啟寶箱！<color>");
		return;
	end
	--打斷開啟事件
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
	--開啟寶箱
	GeneralProcess:StartProcess("開啟寶箱", tbHLTreasureBox.COST_TIME, {self.OnCheckOpen, self, me.nId, him.dwId}, {me.Msg, "開啟被打斷"}, tbEvent);
end
