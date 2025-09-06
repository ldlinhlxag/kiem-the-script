
-- 藏寶圖
local tbItem = Item:GetClass("treasuremap");
tbItem.IdentifyDuration = Env.GAME_FPS * 10;

tbItem.tbLevelLimit	= {
	[1] = 20,
	[2]	= 50,
	[3]	= 70,	
}

-- 不同等級對應藏寶圖挖出後果不同的概率
tbItem.tbAwardRate	= {
	[1]	= {0, 93, 7},
	[2]	= {0, 95, 5},
	[3]	= {0, 94, 2, 4},
}

function tbItem:InitGenInfo()
	if (MODULE_GAMESERVER) then
		it.SetGenInfo(TreasureMap.ItemGenIdx_IsIdentify, 0);
		local tbTreasure = TreasureMap:GetTreasureTableInfo(it.nLevel);
		local nRandomIdx = MathRandom(#tbTreasure);
		it.SetGenInfo(TreasureMap.ItemGenIdx_nTreaaureId, tbTreasure[nRandomIdx].TreasureId);
		it.Sync();
	end
end



function tbItem:OnUse()
	local nTreasureId 		= it.GetGenInfo(TreasureMap.ItemGenIdx_nTreaaureId); -- 所對應寶藏的編號
	local nIdentify 		= it.GetGenInfo(TreasureMap.ItemGenIdx_IsIdentify);	-- 是否是辨認過的藏寶圖
	local tbTreasureInfo	= TreasureMap:GetTreasureInfo(nTreasureId);
	local nMapId			= tbTreasureInfo.MapId;
	
	local nMapLevel			= tbTreasureInfo.Level;
	
	if me.nLevel < self.tbLevelLimit[nMapLevel] then
		Dialog:SendInfoBoardMsg(me, "<color=red>Hiện tại cấp của bạn chưa đủ để mở Tàng Bảo Đồ này!<color>");
		return;
	end;
	
	if (not nMapId or nMapId <= 0) then
		TreasureMap:_Debug("Không tồn tại bản đồ tàng bảo tương ứng!", nTreasureId, nMapId);
		assert(false);
		return 0;
	end
	local szMapName			= GetMapNameFormId(nMapId)
	if (nIdentify == 0) then
		Dialog:Say("Đây là Tàng Bảo Đồ số <color=yellow>"..szMapName.."<color>, bạn phải phân biệt được Tàng Bảo Đồ mới biết được vị trí của kho báu.\n\n",
			{"Bắt đầu đọc", self.IdentifyTreasureMap, self, me, nTreasureId, it},
			{"Đóng"}
			);
	elseif (nIdentify == 1) then
		local szPosDesc = tbTreasureInfo.Desc;
		local szPic = "<pic:"..tbTreasureInfo.Pic..">";
		Dialog:Say(szPic.."Đây là Tàng Bảo Đồ số <color=yellow>"..szMapName.."<color>, trên đó hiển thị vị trí Tàng Bảo Đồ ở <color=yellow>"..szPosDesc.."<color>, bạn có thể dùng <color=yellow>La bàn bán ở các tiệm tạp hóa<color> để biết vị trí Tàng Bảo Đồ này đánh dấu.\n\n",
		{"Bắt đầu đào", self.BurrowTreasure, self, me, nTreasureId, it},
		{"Đóng"}
		);
	else
		assert(false);
	end
	
	return 0;
end

-- 辨認
function tbItem:IdentifyTreasureMap(pPlayer, nTreasureId, pTreasureMap)
	-- TODO: liuchang 玩家身上有繪制過的地圖冊
	
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
	
	-- TODO: liuchang pTreasureMap 得做保護，不能直接傳對象，要傳Id 
	GeneralProcess:StartProcess("Đọc", self.IdentifyDuration, {self.SuccessIdentify, self, pPlayer.nId, pTreasureMap.dwId}, nil, tbEvent);
end

-- 辨認成功
function tbItem:SuccessIdentify(nPlayerId, nItemId)
	local pTreasureMap = KItem.GetObjById(nItemId);
	if (MODULE_GAMESERVER) then
		pTreasureMap.SetGenInfo(TreasureMap.ItemGenIdx_IsIdentify, 1);
		pTreasureMap.Sync();
	end
end


-- 挖掘
function tbItem:BurrowTreasure(pPlayer, nTreasureId, pTreasureMap)
	-- TODO: liuchang
	if (pPlayer.nTeamId == 0) then
		pPlayer.Msg("Chỉ có tổ đội mới có thể đào kho báu!");
		return;
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
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
	}
	
	local nBurrowTimes = pPlayer.GetTask(TreasureMap.tbBurrowSkill[1], TreasureMap.tbBurrowSkill[2]);
	local nBurrowCostTime = 10 * Env.GAME_FPS;
	for i = 1, #TreasureMap.tbBurrowCostTime do
		if (nBurrowCostTime >= TreasureMap.tbBurrowCostTime[i][1]) then
			nBurrowCostTime = TreasureMap.tbBurrowCostTime[i][2];
		else
			break;
		end
	end

	GeneralProcess:StartProcess("Đào kho báu", nBurrowCostTime, {self.AccomplishBurrow, self, pPlayer.nId, nTreasureId, pTreasureMap.dwId}, {pPlayer.Msg, "挖掘被打斷。"}, tbEvent);
end


-- 完成挖掘
function tbItem:AccomplishBurrow(nPlayerId, nTreasureId, nItemId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	local pTreasureMap = KItem.GetObjById(nItemId);
	if (not pTreasureMap) then
		return;
	end
	if (pPlayer.nTeamId == 0) then
		pPlayer.Msg("Chỉ có tổ đội mới có thể đào!");
		return;
	end
	local nMyMapId, nMyPosX, nMyPosY	= pPlayer.GetWorldPos();
	local tbTreasureInfo	= TreasureMap:GetTreasureInfo(nTreasureId);
	local nDestMapId 		= tbTreasureInfo.MapId;
	local nDestPosX			= tbTreasureInfo.MapX;
	local nDestPosY			= tbTreasureInfo.MapY;
	
	local _, nDistance = TreasureMap:GetDirection({nMyPosX, nMyPosY}, {nDestPosX, nDestPosY})
	if (nDistance > TreasureMap.MAX_POSOFFSET or nMyMapId ~= nDestMapId) then
		self:ErrorTreasurePos(pPlayer, nTreasureId, pTreasureMap);
	else
		self:SuccessBurrowTreasure(pPlayer, nTreasureId, pTreasureMap);
	end
end


-- 挖掘失敗
function tbItem:ErrorTreasurePos(pPlayer, nTreasureId, pTreasureMap)
	pPlayer.Msg("Bạn đào mãi ở đây, không đào được gì……");
end

-- 挖掘成功
function tbItem:SuccessBurrowTreasure(pPlayer, nTreasureId, pTreasureMap)
	assert(pPlayer)
	local tbTreasureInfo	= TreasureMap:GetTreasureInfo(nTreasureId);
	local nMapLevel			= tbTreasureInfo.Level;
	
	local nMapId, nPosX, nPosY	= pPlayer.GetWorldPos();
	local szTypeMsg = "";
	
	local tbBurrowAward		= self.tbAwardRate[nMapLevel];
	local nRandomNum = MathRandom(100);
	local nFlag, nAdd = 0, 0;

	for i=1, #tbBurrowAward do
		nAdd = nAdd + tbBurrowAward[i];
		if nAdd >= nRandomNum then
			nFlag = i;
			break;
		end;
	end;
	
	if nFlag == 0 then
		me.Msg("Tính sai phần thưởng!");
		return;
	end;
	
	--藏寶賊，5,8寫到head中去
	if nFlag == 1 then
		szTypeMsg = string.format("Khi %s, %s, %s sử dụng Tàng bảo đồ, xuất hiện Đoạt Bảo Tặc", nMapId, nPosX, nPosY);
	-- 寶箱
	elseif nFlag == 2 then
		szTypeMsg = string.format("Khi %s, %s, %s sử dụng Tàng bảo đồ, xuất hiện Bảo rương", nMapId, nPosX, nPosY);
	-- 副本
	elseif nFlag == 3 or nFlag == 4 then
		szTypeMsg = string.format("Khi %s, %s, %s sử dụng Tàng bảo đồ, xuất hiện phó bản", nMapId, nPosX, nPosY);
	end
	--玩家行為log記錄
--	pPlayer.ItemLog(pTreasureMap, 0, Log.emKITEMLOG_TYPE_STOREHOUSE, szTypeMsg, 1);
	
	Dbg:WriteLog("TreasureMap", "Cấp Tàng bảo đồ:"..nMapLevel, me.szAccount, me.szName, "Kết quả:"..nFlag);
	
	local nRet = pTreasureMap.Delete(pPlayer);
	if (not nRet or nRet ~= 1) then
		pPlayer.Msg("Bạn chưa có Tàng bảo đồ chỉ định!");
		return;
	end
	
	local nValue = pPlayer.GetTask(TreasureMap.tbBurrowSkill[1], TreasureMap.tbBurrowSkill[2]);
	nValue = nValue + 1;
	if (nValue > TreasureMap.nRecordBurrowMaxTime) then
		nValue = TreasureMap.nRecordBurrowMaxTime;
	end
	pPlayer.SetTask(TreasureMap.tbBurrowSkill[1], TreasureMap.tbBurrowSkill[2], nValue);
	
	
	if (nFlag == 1) then
		 --藏寶賊，5,8寫到head中去
		TreasureMap:AddTreasureMugger(pPlayer, nTreasureId, 5, 8);
		szTypeMsg = "<color=red>Gặp 1 toán Tàng bảo tặc!<color>";
	elseif (nFlag == 2) then
		-- 寶箱
		TreasureMap:AddTreasureBox(pPlayer, nTreasureId);
		
		-- 再給開出箱子的玩家加一個精致的盒子
		if nMapLevel == 1 then
			pPlayer.AddItem(18, 1, 290, 1, 0, 0, 0, nil, nil, 0, 0, Player.emKITEMLOG_TYPE_STOREHOUSE);
		elseif nMapLevel == 2 then
			pPlayer.AddItem(18, 1, 290, 2, 0, 0, 0, nil, nil, 0, 0, Player.emKITEMLOG_TYPE_STOREHOUSE);
		elseif nMapLevel == 3 then
			pPlayer.AddItem(18, 1, 290, 3, 0, 0, 0, nil, nil, 0, 0, Player.emKITEMLOG_TYPE_STOREHOUSE);
		end;
		
		szTypeMsg = " đào được 1 <color=red>Bảo rương cổ<color>!";
	elseif (nFlag == 3) then
		-- 高級藏寶圖，如果挖到副本，給的是千瓊宮令牌碎片
		if nMapLevel == 3 then
			local pItem = me.AddItem(18, 1, 186, 1);
			me.Msg("Bạn nhận được 1 <color=yellow>Lệnh bài Thiên Quỳnh Cung<color>!");
			szTypeMsg = "Được 1 <color=yellow>Lệnh bài Thiên Quỳnh Cung<color>!";
			
			-- 保質期 15 天
			me.SetItemTimeout(pItem, os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 3600 * 24 * 15));
		else
			-- 副本
			TreasureMap:AddInstancing(pPlayer, nTreasureId);
			szTypeMsg = "<color=yellow>Phát hiện lối vào lòng đất, không biết bên dưới ẩn giấu bí mật gì?<color>";	
		end;
	elseif (nFlag == 4) then
		-- 這裡處理挖出萬花谷
		local pItem = me.AddItem(18, 1, 245, 1);
		me.Msg("Bạn được 1 <color=yellow>bản đồ Vạn Hoa Cốc<color>!");
		szTypeMsg = " đào được 1 <color=yellow>bản đồ Vạn Hoa Cốc<color>!";
		
		-- 保質期 15 天
		me.SetItemTimeout(pItem, os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 3600 * 24 * 15));		
	end
	
	local szMapName	= GetMapNameFormId(nMapId);
	local nShowX = math.ceil(nPosX/8);
	local nShowY = math.ceil(nPosY/16);
	local szMsg = pPlayer.szName.." tại <color=yellow>"..szMapName.."<color>"..szTypeMsg;
	
	TreasureMap:AwardWeiWangAndXinde(pPlayer, 0, 5, 1, 100000);
	
	-- 通知附近的玩家
	TreasureMap:NotifyAroundPlayer(pPlayer, szMsg);
	
	-- 記錄挖寶次數
	local nNum = pPlayer.GetTask(StatLog.StatTaskGroupId , 3) + 1;
	pPlayer.SetTask(StatLog.StatTaskGroupId , 3, nNum);
	-- 添加好友親密度
	local tbTeamList = pPlayer.GetTeamMemberList();
	TreasureMap:AddFriendFavor(tbTeamList, nMapId, 4);
	
	-- 師徒成就：挖掘藏寶圖
	self:GetAchievement(tbTeamList, nMapId, nMapLevel);
	
	-- 增加玩家參加挖寶活動的計數
	Stats.Activity:AddCount(pPlayer, Stats.TASK_COUNT_CANGBAOTU, 1, 1);
end

function tbItem:GetAchievement(tbTeamList, nMapId, nMapLevel)
	if (not tbTeamList or not nMapId or nMapId <= 0) then
		return;
	end
	local nAchievementId = 0;
	if (1 == nMapLevel) then
		nAchievementId = Achievement.CANGBAOTU_CHUJI;		-- 成就：初級藏寶圖
	elseif (2 == nMapLevel) then
		nAchievementId = Achievement.CANGBAOTU_ZHONGJI;		-- 成就：中級藏寶圖
	elseif (3 == nMapLevel) then
		nAchievementId = Achievement.CANGBAOTU_GAOJI;		-- 成就：高級藏寶圖
	end
	TreasureMap:GetAchievement(tbTeamList, nAchievementId, nMapId)
end


function tbItem:GetTip()
	local nTreasureId 	= it.GetGenInfo(TreasureMap.ItemGenIdx_nTreaaureId);
	local nIdentify 	= it.GetGenInfo(TreasureMap.ItemGenIdx_IsIdentify);
	local nItemLevel	= it.nLevel;
	
	local tbInfo	= TreasureMap:GetTreasureInfo(nTreasureId);
	
	if not tbInfo then
		-- return "<color=red>錯誤的藏寶圖信息，請檢查你的客戶端是否為最新！<color>";
		return "Tàng Bảo Đồ\n\nTấm bản đồ này được vẽ trên tấm da dê cũ nát";
	end;
	
	local tbLevelString		= {[1] = "Tàng bảo đồ (sơ)", [2] = "Tàng bảo đồ (trung)", [3] = "Tàng bảo đồ (cao)"};
	local nMapId			= tbInfo.MapId;
	local szMapName			= GetMapNameFormId(nMapId);
	local szImage			= tbInfo.Pic;
	local szPosDesc 		= tbInfo.Desc;
	
	local szIdentify 	= "<color=red>(chưa giám định)<color>";
	
	if nIdentify == 1 then
		szIdentify	= "<color=green>(đã giám định)<color>";
	end;
	
	local szMain	= "";
	szMain	= szMain.."1 Tàng Bảo Đồ ở "..szMapName.."."..szIdentify.."\n\n";
	szMain	= szMain.."<color=white>"..tbLevelString[nItemLevel].."<color>\n\n";
	
	if nIdentify == 1 then
		szMain	= szMain.."Đây là Tàng Bảo Đồ số <color=yellow>"..szMapName.."<color>, trên đó hiển thị vị trí Tàng Bảo Đồ ở <color=yellow>"..szPosDesc.."<color>.\n";
	else
		szMain	= szMain.."Đây là Tàng Bảo Đồ số <color=yellow>"..szMapName.."<color>, bạn có thể dùng <color=yellow>La bàn bán ở các tiệm tạp hóa<color> để biết vị trí Tàng Bảo Đồ này đánh dấu.\n";
	end;
	
	return szMain;
end
