--4倍地圖npc
--sunduoliang
--2008.11.05

Require("\\script\\task\\fourfoldmap\\fourfoldmap_def.lua");

local Fourfold = Task.FourfoldMap;

function Fourfold:OnAbout()
	local szMsg = string.format([[
<color=red>Giới thiệu Bí Cảnh:<color>

1, Người chơi đạt <color=yellow>cấp 90<color>mới có tư cách vào Bí Cảnh.

2, Thời gian mỗi lần Bí Cảnh mở là <color=yellow>2 -> 6 giờ<color> trong Bí Cảnh có phần thưởng kinh nghiệm lớn.

3, Đạt cấp 90 mỗi ngày sẽ <color=yellow>tự động tích lũy %d giờ <color>, tối đa tích lũy <color=yellow>%d giờ<color>.

4, Trước khi Bí Cảnh đóng có thể ra, vào tùy ý.

5, Thời gian tu luyện Bí Cảnh của đội trưởng ít nhất là <color=yellow>2 giờ<color>, nhiều nhất có <color=yellow>6 người <color>cùng lúc vào Bí Cảnh.

6, Nếu <color=yellow>sử dụng bản đồ để vào Bí Cảnh(dù là đội trưởng hay không)<color>, lúc tu luyện có thể nhận <color=red>kinh nghiệm ủy thác rời mạng tương ứng(ủy thác trên mạng)<color>.

7, Để tìm hiểu thêm có thể nhấn <color=yellow>F12<color> trên bàn phím.
]], EventManager.IVER_nFourfoldMapPreTime, EventManager.IVER_nFourfoldMapMaxTime);
	Dialog:Say(szMsg);
end

function Fourfold:OnDialog()
	if me.nLevel < self.LIMIT_LEVEL then
		Dialog:Say(string.format("Đẳng cấp phải đạt %s mới có thể vào Bí Cảnh.", self.LIMIT_LEVEL));
		return 0;
	end
	local nRemainTime = me.GetTask(self.TSK_GROUP, self.TSK_REMAIN_TIME);
	local szMsgTilte = string.format("Luyện công trong Bí Cảnh có 1 thời gian nhất định, nếu vội vàng có thể bị Tẩu Hỏa Nhập Mộ\n\n Thời gian tích lũy mở Bí Cảnh còn:\n    <color=yellow>%s<color>\n\n", Lib:TimeFullDesc(nRemainTime));
	if nRemainTime <= 0 then
		Dialog:Say(string.format("%s hôm nay bạn đã luyện đủ, ngày mai hãy quay lại.", szMsgTilte))
		return 0;
	end
	if me.nTeamId <= 0 then
		Dialog:Say(string.format("%s Ngươi phải là<color=yellow> Đội Trưởng<color> và có <color=yellow>Bản Đồ Bí Cảnh<color>, hãy chuẩn bị đầy đủ rồi đến gặp ta.", szMsgTilte))
		return 0;
	end
	local nTeamList = KTeam.GetTeamMemberList(me.nTeamId);
	local nMapId, nPosX, nPosY = me.GetWorldPos();
	
	local tbOpenMap = {};
	for nId, nPlayerId in ipairs(nTeamList) do
		if self.MapTempletList.tbBelongList[nPlayerId] then
			table.insert(tbOpenMap, {nId, KGCPlayer.GetPlayerName(nPlayerId)})
		end 
	end
	
	if #tbOpenMap >= 2 then
		local szPlayerMsg = "";
		for ni, tbTemp in pairs(tbOpenMap) do
			szPlayerMsg = szPlayerMsg .. string.format("<color=yellow>%s<color>", tbTemp[2]);
			if ni ~= #tbOpenMap then
				szPlayerMsg = szPlayerMsg .. ",";
			end
		end
		Dialog:Say(string.format("%s Nhóm của bạn đã có người mở bí cảnh %s Chỉ có đội trưởng mới có thể mở Bí Cảnh", szMsgTilte, szPlayerMsg))
		return 0;
	end
	if #tbOpenMap > 0 and tbOpenMap[1][1] ~= 1 then
		Dialog:Say(string.format("%s Nhóm của bạn <color=yellow>%s<color> mở bí cảnh, nhưng bạn không phải đội trưởng, hãy theo đội trưởng vào <color=yellow>%s<color>.", szMsgTilte, tbOpenMap[1][2], tbOpenMap[1][2]))		
		return 0;
	end
	
	if self.MapTempletList.tbBelongList[nTeamList[1]] then
		if self:IsMissionOpen() == 1 then
			local szMsg = string.format("%s Ngươi đã mang Bản Đồ Bí Cảnh chưa ?", szMsgTilte);
			local tbOpt = {
				{"Ta có Bản Đồ Bí Cảnh",self.EnterMapForItem, self},
				{"Vào Bí Cảnh với Đội Trưởng",self.EnterMap, self},
				{"Kêt thúc đối thoại"},
			}
			Dialog:Say(szMsg, tbOpt);
			return 0;
		else
			local nTeamList = KTeam.GetTeamMemberList(me.nTeamId);
			local nCityMapId = self.MapTempletList.tbBelongList[nTeamList[1]][1];
			local szWorldName = GetMapNameFormId(nCityMapId);
			local szMsg = string.format("%s Nhóm của bạn <color=yellow>%s<color> mở bí cảnh, tới <color=yellow>%s<color> để luyện nào.", szMsgTilte, szWorldName, szWorldName);
			Dialog:Say(szMsg);
			return;
		end
	end
	local szMsg = string.format("%s Nếu bạn có <color=yellow>Bản đồ bí cảnh<color>, sẽ mở được bí cảnh. Bạn muốn mở ?",szMsgTilte);
	local tbOpt = {
		{"Mở Bí Cảnh", self.ApplyTeamMap, self},
		{"Kết thúc đối thoại"}
	}
	Dialog:Say(szMsg, tbOpt);
end

--返回可能的修煉時間，如果時間不夠則返回空table
--nRemainTime單位為秒
function Fourfold:GetValidPractiseTime(pPlayer, nRemainTime)
	local tbHour = {};
	if nRemainTime >= 6*3600 then
		table.insert(tbHour,6);
	end
	if nRemainTime >= 4*3600 then
		table.insert(tbHour,4);
	end
	if nRemainTime >= 2*3600 then
		table.insert(tbHour,2);
	end
	return tbHour, string.format("Thời gian tích lũy phải lớn hơn <color=yellow>%s giờ<color> mới có thể luyện công trong Bí Cảnh.", Lib:TimeFullDesc(self.DEF_MIN_OPEN_TIME));	
end

function Fourfold:ApplyTeamMap(nFlag, nHour, nMapNumber)
	local nRemainTime = me.GetTask(self.TSK_GROUP, self.TSK_REMAIN_TIME);
	if nRemainTime < self.DEF_MIN_OPEN_TIME then
		Dialog:Say(string.format("Thời gian tích lũy phải lớn hơn <color=yellow>%s giờ<color> mới có thể luyện công trong Bí Cảnh.", Lib:TimeFullDesc(self.DEF_MIN_OPEN_TIME)));
		return 0;
	end
	if me.nTeamId <= 0 or me.IsCaptain() == 0 then
		Dialog:Say(string.format("Bạn phải là đội trưởng hoặc đội trưởng đã mở Bí Cảnh."))
		return 0;
	end
	
	local nTeamList = KTeam.GetTeamMemberList(me.nTeamId);
	if self.MapTempletList.tbBelongList[nTeamList[1]] then
		return 0;
	end
	if self.MapTempletList.nCount >= self.MAP_APPLY_MAX then
		Dialog:Say("Đang trong Bí Cảnh không thể sử dụng đạo cụ chỉ định.");
		return 0;
	end
	
	-- 選擇用多少地圖
	if not nFlag then
		local tbHour, szMsg = self:GetValidPractiseTime(me, nRemainTime);
		if #tbHour == 0 then
			Dialog:Say(szMsg);
			return 0;
		end
		
		local szMsg = string.format("Nếu bạn có <color=yellow>Bản Đồ Bí Cảnh<color>, sẽ mở được bí cảnh. Bạn muốn mở ? \n<color=red>Mở bao nhiêu Bí Cảnh sẽ khấu trừ bấy nhiêu Bản Đồ Bí Cảnh.<color>");
		local tbOpt = {};
		
		for _, nHour in ipairs(tbHour) do
			table.insert(tbOpt, {string.format("Sử dụng %d luyện trong %d giờ",nHour/2, nHour), self.ApplyTeamMap, self, 1, nHour, nHour/2});
		end
		
		table.insert(tbOpt,	{"Kết thúc đối thoại"});
		Dialog:Say(szMsg, tbOpt)
		return 0;
	end
	
	local tbFind = me.FindItemInBags(unpack(self.DEF_ITEM_KEY));
	if #tbFind < nMapNumber then
		Dialog:Say(string.format(
			"Không có <color=yellow>%d<color>, không thể mở Bí Cảnh.",
			nMapNumber));
		return 0;
	end
	
	local nMapId, nPosX, nPosY = me.GetWorldPos();
	if self:ApplyMap(nMapId, me.nId, me.nLevel, nHour) == 1 then
		for i = 1, nMapNumber do
			me.DelItem(tbFind[i].pItem);
		end
		me.Msg("<color=yellow>Mở bí cảnh thành công<color>, Hãy gọi hảo hữu của mình. Thời gian chuẩn bị <color=yellow>3 phút<color> Bí Cảnh sẽ bắt đầu hoạt động.");
		SpecialEvent.ActiveGift:AddCounts(me, 2);
		return 0;
	end
end

-- 玩家隊伍的副本是否已經開啟
function Fourfold:IsMissionOpen()
	local nTeamList = KTeam.GetTeamMemberList(me.nTeamId);
	local nMapId, nPosX, nPosY = me.GetWorldPos();
	if self.MapTempletList.tbBelongList[nTeamList[1]] then
		local nCityMapId = self.MapTempletList.tbBelongList[nTeamList[1]][1];
		local nDyMapId = self.MapTempletList.tbBelongList[nTeamList[1]][3];
		if nCityMapId == nMapId and nDyMapId ~= 0 then
			if not self.MissionList[nTeamList[1]] then
				return 0, "Bản đồ hiện tại chưa mở.";
			else
				return 1, self.MissionList[nTeamList[1]], nDyMapId;
			end
		else
			return 0, "Bản đồ hiện tại chưa mở.";
		end
	else
		return 0, "Bản đồ hiện tại chưa mở.";
	end
end

function Fourfold:CanEnterMap()
	if me.nTeamId <= 0 then
		return 0, "Trong bí cảnh rất nguy hiểm, hãy gọi thêm bạn hữu trước khi vào.";
	end
	
	local nRemainTime = me.GetTask(self.TSK_GROUP, self.TSK_REMAIN_TIME);
	if nRemainTime <= self.DEF_MIN_ENTER_TIME then
		return 0, string.format("Thời gian tích lũy phải lớn hơn <color=yellow>%s<color> mới có thể vào trong.", Lib:TimeFullDesc(self.DEF_MIN_ENTER_TIME));
	end
	
	local nRes, var, nDyMapId= self:IsMissionOpen();
	if nRes ~=1 then
		return 0, var;
	end
		
	local nTeamList = KTeam.GetTeamMemberList(me.nTeamId);
	if var:GetPlayerCount() >= self.DEF_MAX_ENTER then
		return 0, string.format("Bí cảnh đã có <color=yellow>%s người<color> không thể vào nữa, quá nhiều người sẽ gây hỗn loạn và làm quái chạy hết :))", self.DEF_MAX_ENTER);
	end
	
	return 1, var, nDyMapId;
end

function Fourfold:EnterMapForItem(nFlag, nHour, nMapNumber)
	local nRes, var = self:CanEnterMap();
	if nRes ~= 1 then
		Dialog:Say(var);
		return 0;
	end
	local tbMission = var;
	if tbMission:GetFourfold(me.nId) == 1 or tbMission:IsOnceInFourfold(me.nId) == 1 then
		self:EnterMap();
		return 0;
	end
		
	if not nFlag then -- 選擇用幾幅地圖
		local nMissionTime = tbMission:GetHour()*3600;
		local nRemainTime = me.GetTask(self.TSK_GROUP, self.TSK_REMAIN_TIME);
		local tbHour, szMsg = Fourfold:GetValidPractiseTime(pPlayer, math.min(nRemainTime, nMissionTime));
		if #tbHour == 0 then
			Dialog:Say(szMsg);
			return 0;
		end
		local szMsg = string.format("Nếu bạn có <color=yellow>Bản Đồ Bí Cảnh<color>, Có thể cầm <color=yellow>Bản Đồ Bí Cảnh<color> đưa cho Quan Quân Nhu Nghĩa Quân để mở Bí Cảnh và nhận x2 kinh nghiệm so với không có.");
		local tbOpt = {}
		for _, nHour in ipairs(tbHour) do
			table.insert(tbOpt, {string.format("Sử dụng %d Bản đồ bí cảnh.", nHour/2), self.EnterMapForItem, self, 1, nHour, nHour/2});
		end
		table.insert(tbOpt, {"Kết thúc đối thoại"});
		Dialog:Say(szMsg, tbOpt)
		return 0;
	else -- 進入
		local tbFind = me.FindItemInBags(unpack(self.DEF_ITEM_KEY));
		if #tbFind < nMapNumber then
			Dialog:Say(string.format(
				"Bạn không đủ <color=yellow>Bản Đồ Bí Cảnh<color>, Bạn nhận được %d giờ tu luyện Bí Cảnh. Phải mang theo <color=yellow>%d Bản Đồ Bí Cảnh<color> trước khi đến gặp ta.",
				nHour, nMapNumber));
			return 0;
		end
		
		for i = 1, nMapNumber do
			me.DelItem(tbFind[i].pItem);
		end
		SpecialEvent.ActiveGift:AddCounts(me, 2);
		tbMission:JoinFourfold(me.nId, nHour);
		self:EnterMap();
		return 0;
	end
end

function Fourfold:EnterMap()
	local nRes, var, nDyMapId = self:CanEnterMap();
	if nRes ~= 1 then
		Dialog:Say(var);
		return 0;
	end
	
	local nMapId, nPosX, nPosY = me.GetWorldPos();
	self.PlayerTempList[me.nId] = {};
	self.PlayerTempList[me.nId].nMapId = nMapId;
	self.PlayerTempList[me.nId].nPosX = nPosX;
	self.PlayerTempList[me.nId].nPosY = nPosY;
	self.PlayerTempList[me.nId].nCaptain = KTeam.GetTeamMemberList(me.nTeamId)[1];
	self.PlayerTempList[me.nId].nState = 0;
	me.NewWorld(nDyMapId, unpack(self.DEF_MAP_POS[1]));
	return 0;
end
