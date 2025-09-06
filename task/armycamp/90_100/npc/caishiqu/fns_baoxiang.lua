----------------------------------------
-- 伏牛山庄寶箱
-- ZhangDeheng
-- 2008/10/28  10:41
----------------------------------------

local tbFnsTreasureBox = Npc:GetClass("fnsbaoxiang");

tbFnsTreasureBox.ALL_LOCK_COUNT 	= 5; 	--箱子的總層數
tbFnsTreasureBox.COST_TIME			= 100	--開箱需要的時間
tbFnsTreasureBox.TIRED_DURATION		= 10 * Env.GAME_FPS;	-- 勞累持續時間
tbFnsTreasureBox.TIRED_SKILLID		= 389;	--技能 用於控制時間間隔

-- 在開啟每層寶箱時 掉落的物品及物品的數量
tbFnsTreasureBox.tbDrapItem = 
{
	{szDropItemFilePath = "setting\\npc\\droprate\\renwudiaoluo\\baoxiang_lv1.txt", nDrapItemCount = 8,},
	{szDropItemFilePath = "setting\\npc\\droprate\\renwudiaoluo\\baoxiang_lv2.txt", nDrapItemCount = 8,},
	{szDropItemFilePath = "setting\\npc\\droprate\\renwudiaoluo\\baoxiang_lv3.txt", nDrapItemCount = 8,},
	{szDropItemFilePath = "setting\\npc\\droprate\\renwudiaoluo\\baoxiang_lv4.txt", nDrapItemCount = 8,},
	{szDropItemFilePath = "setting\\npc\\droprate\\renwudiaoluo\\baoxiang_lv5.txt", nDrapItemCount = 8,},
}

-- 打開一層
function tbFnsTreasureBox:DecreaseLockLayer(pPlayer, pNpc)
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
		pNpc.Delete();
	end
end

--開啟寶箱
function tbFnsTreasureBox:OnCheckOpen(nPlayerId, nNpcId)
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
function tbFnsTreasureBox:OnDialog()
	
	local pNpc = KNpc.GetById(him.dwId);
	if (not pNpc or pNpc.nIndex == 0) then
		return;
	end

	local tbNpcData = him.GetTempTable("Task"); 
	--assert(tbNpcData.nOwnerPlayerId); 改為return zounan
	if not tbNpcData.nOwnerPlayerId then
		return;
	end
	
	local pOpener = KPlayer.GetPlayerObjById(tbNpcData.nOwnerPlayerId);
	--不存在
	if not pOpener then
		local szMsg = "你不能開啟別人的寶箱！"
		Dialog:SendInfoBoardMsg(me, szMsg);		
		return;
	end;
	
	local nTeamId = pOpener.nTeamId;
	--是否組隊
	if (me.nTeamId == 0) then
		local szMsg = "隻有組隊才能開啟寶箱！"
		Dialog:SendInfoBoardMsg(me, szMsg);
		return;
	end
	--寶箱是否是所在隊伍的寶箱
	if (me.nTeamId ~= nTeamId) then
		local szMsg = "隻有<color=yellow>"..pOpener.szName.."<color>所在的隊伍才能進開啟此寶箱！"
		Dialog:SendInfoBoardMsg(me, szMsg);
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
	GeneralProcess:StartProcess("開啟寶箱", tbFnsTreasureBox.COST_TIME, {self.OnCheckOpen, self, me.nId, him.dwId}, {me.Msg, "開啟被打斷"}, tbEvent);
end
