--4倍地圖
--孫多良
--2008.11.05
Require("\\script\\task\\fourfoldmap\\fourfoldmap_def.lua")

local tbMap = Map:GetClass(Task.FourfoldMap.MAP_TEMPLATE_ID);

-- 定義玩家進入事件
function tbMap:OnEnter()
	me.SetLogoutRV(1);
	me.SetDeathType(1);
	local Fourfold = Task.FourfoldMap;
	local nRemainTime = me.GetTask(Fourfold.TSK_GROUP, Fourfold.TSK_REMAIN_TIME);
	
	local nCaptainId = Fourfold.PlayerTempList[me.nId].nCaptain;
	if nRemainTime <= 0 or (not Fourfold.MissionList[nCaptainId]) or Fourfold.MissionList[nCaptainId]:IsOpen() ~= 1 then
		local nMapId = Fourfold.PlayerTempList[me.nId].nMapId
		local nPosX = Fourfold.PlayerTempList[me.nId].nPosX
		local nPosY = Fourfold.PlayerTempList[me.nId].nPosY
		me.NewWorld(nMapId, nPosX, nPosY);
		return 0;
	end
	Fourfold.PlayerTempList[me.nId].nState = 1;
	
	local mission = Fourfold.MissionList[nCaptainId];
	mission:JoinPlayer(me, 0);
	local nRes, nHour = mission:GetFourfold(me.nId);
	if nRes == 1 then
		me.AddSkillState(890, 1, 1, (nHour*3600 + Fourfold.TIME_GET_READY * 60) * Env.GAME_FPS, 1);
		
		--獲取當天還剩多少離線修煉時間可以用
		local nOffLineTime = Player.tbOffline:GetLeftOfflineTime(me);
		local nLeftTime = 0;
		
		if (mission:GetGameState() == 1) then
			nLeftTime = 2 * 60 * 60;
		elseif (mission:GetGameState() == 2) then
			nLeftTime = mission:GetStateLastTime() / Env.GAME_FPS;
		end
		
		if (nOffLineTime < nLeftTime) then
			if (nOffLineTime < 0) then
				nOffLineTime = 0;
			end
			local szMsg = string.format("Thời gian tích lũy offline của bạn còn: %s, Bí cảnh mở ra sẽ nhận được kinh nghiệm của thời gian offline là: %s", Lib:TimeDesc(nOffLineTime), Lib:TimeDesc(nLeftTime - nOffLineTime));
			me.Msg(szMsg);
		end
		local nBaiJuTime = Player.tbOffline:GetLeftBaiJuTime(me);
		if (nBaiJuTime < nLeftTime and nBaiJuTime < nOffLineTime) then
			me.Msg("Thời gian luyện cấp trong Bí Cảnh chưa hết, hãy cố gắng luyện thêm.");
		end
	end
end

-- 定義玩家離開事件
function tbMap:OnLeave()
	me.RemoveSkillState(890);
	local Fourfold = Task.FourfoldMap;
	local nState = Fourfold.PlayerTempList[me.nId].nState;
	local nCaptainId = Fourfold.PlayerTempList[me.nId].nCaptain;
	if nState > 0 then
		--下線玩家，或者時間沒到通過npc離開的玩家
		if Fourfold.TimerList[me.nId] then
			local nWaitTime = Timer:GetWaitTime(Fourfold.TimerList[me.nId]);
			local nRemainTime = math.floor( (nWaitTime - Timer:GetRestTime(Fourfold.TimerList[me.nId])) / Env.GAME_FPS);
			Timer:Close(Fourfold.TimerList[me.nId]);
			nRemainTime = me.GetTask(Fourfold.TSK_GROUP, Fourfold.TSK_REMAIN_TIME) - nRemainTime;
			if nRemainTime < 0 then
				nRemainTime = 0;
			end
			me.SetTask(Fourfold.TSK_GROUP, Fourfold.TSK_REMAIN_TIME, nRemainTime);
			Fourfold.PlayerTempList[me.nId].nState = 0;
			Task.FourfoldMap.TimerList[me.nId] = nil;
		end
	end
	if Fourfold.MissionList[nCaptainId] then
		Fourfold.MissionList[nCaptainId]:KickPlayer(me);
	end
	--Fourfold.PlayerTempList[me.nId] = nil;
	me.SetLogoutRV(0);
	me.SetDeathType(0);
end

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
	Player.ProcessBreakEvent.emEVENT_LOGOUT,
	Player.ProcessBreakEvent.emEVENT_DEATH,
}

local tbPlayer = tbMap:GetTrapClass("chukou")
function tbPlayer:OnPlayer()
	local Fourfold = Task.FourfoldMap;
	local nMapId = Fourfold.PlayerTempList[me.nId].nMapId
	local nPosX = Fourfold.PlayerTempList[me.nId].nPosX
	local nPosY = Fourfold.PlayerTempList[me.nId].nPosY	
	GeneralProcess:StartProcess("Đang ra ngoài...", 3 * Env.GAME_FPS, {self.OnPlayerLeave, self, me.nId, nMapId, nPosX, nPosY}, nil, tbEvent);
end
function tbPlayer:OnPlayerLeave(nPlayerId, nMapId, nPosX, nPosY)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		pPlayer.NewWorld(nMapId, nPosX, nPosY)
	end
end
