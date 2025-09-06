----------------------------------------
-- 伏牛山庄舊址入口
-- ZhangDeheng
-- 2008/10/29  8:41
----------------------------------------

local tbFnsEntryWay = Npc:GetClass("fnsentryway");
tbFnsEntryWay.NEW_WORLD_POSX = 1567;
tbFnsEntryWay.NEW_WORLD_POSY = 3547;

function tbFnsEntryWay:OnDialog()
	local tbNpcData = him.GetTempTable("Task");
	assert(tbNpcData.nEntrancePlayerId);
	local pOpener = KPlayer.GetPlayerObjById(tbNpcData.nEntrancePlayerId);
	if (not pOpener) then
		return;
	end
	
	local nTeamId = pOpener.nTeamId;
	
	if (me.nTeamId == 0) then
		local szMsg = "隻有組隊才能進入！"
		Dialog:SendInfoBoardMsg(me, szMsg);
		return;
	end
	
	if (me.nTeamId ~= nTeamId) then
		local szMsg = "隻有<color=yellow>"..pOpener.szName.."<color>所在的隊伍才能進入！"
		Dialog:SendInfoBoardMsg(me, szMsg);
		return;
	end
	
	local nEntryMapId = tbNpcData.nEntryMapId;

	Dialog:Say("是否現在進入伏牛山庄舊址？", 
		{"好", self.Enter, self, me, him.dwId, nEntryMapId},
		{"暫時不去"})
end

function tbFnsEntryWay:Enter(pPlayer, nNpcId, nEntryMapId)
	pPlayer.NewWorld(nEntryMapId, self.NEW_WORLD_POSX, self.NEW_WORLD_POSY);
	pPlayer.SetFightState(1);
end


