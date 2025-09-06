-----------------------------------------------------
--文件名		：	houyingjunxuguan.lua
--创建者		：	zhouchenfei
--创建时间		：	2007-10-23
--功能描述		：	后营军需官
------------------------------------------------------
local tbJunXu	= Npc:GetClass("houyingjunxuguan");
local tbBaoJunXu = Npc:GetClass("baomingdianjunxuguan");

-- 和NPC对话
function tbJunXu:OnDialog(szCamp)
	local pPlayer = me;
	
	self.nCampId		= Battle.tbNPCNAMETOID[szCamp];
	self.tbDialog		= Battle.tbCampDialog[self.nCampId];
	
	local nBouns		= pPlayer.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_TOTALBOUNS);
	local szMsg			= self.tbDialog[6];
	local tbOpt			= {};
	
	if not GLOBAL_AGENT then
		tbOpt = {
			{"<color=gold>[Bạc Khóa]<color>Dược phẩm", self.OnBuyYaoByBind, self},
			{"Dược phẩm", self.OnBuyYao, self},
			{"<color=gold>[Bạc Khóa]<color>Thực phẩm", self.OnBuyCaiByBind, self},
			{"Thực phẩm", self.OnBuyCai, self},
			{"Nhận Rương Thuốc", tbBaoJunXu.OnGetJunXuMed, tbBaoJunXu},
			{"Ta muốn rời khỏi đây", self.OnLeaveSay, self},
			{"Ta sẽ tiếp tục chiến đấu"},
		};
	else
		tbOpt = {
			{"Tạp hóa Danh vọng", self.OnBuyWldhYao, self},
			{"Ta muốn rời khỏi đây", self.OnLeaveHere, self},
			{"Ta sẽ tiếp tục chiến đấu"},
		};
	end

	Dialog:Say(szMsg, tbOpt);
end

-------------------------------------------------------
-- 武林大会专用
-------------------------------------------------------
function tbJunXu:OnBuyWldhYao()
	--me.OpenShop(164,3);
end

function tbJunXu:OnLeaveHere()
	if not him then
		return;
	end
	
	if me.nFightState == 1 then
		return;
	end
	
	local tbBattleInfo = Battle:GetPlayerData(me);
	if not tbBattleInfo then
		local nGateWay = Transfer:GetTransferGateway();
		local nMapId = Wldh.Battle.tbLeagueName[nGateWay][2];
		if nMapId then
			me.NewWorld(nMapId, 1648, 3377);
			me.SetFightState(0);
		end
		return;
	end

	local tbMapInfo	= Battle:GetMapInfo(him.nMapId);
	tbMapInfo.tbMission:KickPlayer(me);
end
-------------------------------------------------------

-- 买战场道具
function tbJunXu:OnBuy()
	me.OpenShop(23,4);
end

-- 买药
function tbJunXu:OnBuyYao()
	me.OpenShop(14,1);
end

function tbJunXu:OnBuyYaoByBind()
	me.OpenShop(14,7);
end

-- 买菜
function tbJunXu:OnBuyCai()
	me.OpenShop(21,1);
end

function tbJunXu:OnBuyCaiByBind()
	me.OpenShop(21,7);
end

function tbJunXu:OnLeaveSay()
	if not him then
		return;
	end
	local tbOpt = {
				{"Rời khỏi", self.OnLeave, self,him.dwId},
				{"Ta sẽ tiếp tục chiến đấu"},
		};
	Dialog:Say("Ngươi có chắc chắn muốn đi? ", tbOpt);
end

-- 离开
function tbJunXu:OnLeave(nNpcId)
	local pPlayer = me;
	if (1 == pPlayer.nFightState) then
		return;
	end
	local tbBattleInfo	= Battle:GetPlayerData(pPlayer);
	if (not tbBattleInfo) then
		self:ProcessError(pPlayer);-- TODO
		return;
	end
	
	local pNpc = KNpc.GetById(nNpcId);
	if pNpc then
		local nMapId		= pNpc.nMapId;
		local tbMapInfo		= Battle:GetMapInfo(nMapId);
		if tbMapInfo.tbMission then			 		
			tbMapInfo.tbMission:KickPlayer(pPlayer);
		end
	end
end

function tbJunXu:ProcessError(pPlayer)
	local nLevelId	= Battle:GetJoinLevel(pPlayer);
	local nCampId	= pPlayer.GetTask(Battle.TSKGID, Battle.TASKID_BTCAMP);
	if (0 == nCampId) then
		nCampId = 1;
	end
	local nMapId	= Battle.MAPID_LEVEL_CAMP[nLevelId][nCampId];
	
	local nIndex = math.floor( MathRandom(#Battle.POS_SIGNUP));	-- 随机取得self.POS_SIGNUP中某个坐标的下标
	
	if (pPlayer.GetMapId() == nMapId) then							-- 玩家和要被传送去的报名点在同一张地图时,用SetPos
		SetPos(unpack(Battle.POS_SIGNUP[nIndex]));
	else															-- 玩家和要被传送去的报名点不在同一张地图时,用NewWorld
		pPlayer.NewWorld(nMapId, unpack(Battle.POS_SIGNUP[nIndex]));
	end
	pPlayer.SetFightState(0);										-- 玩家到达报名点就会转化成非战斗状态
end
