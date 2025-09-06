--武林联赛
--孙多良
--2008.09.12

local tbNpc = {};
Wlls.DialogNpc = tbNpc;

function tbNpc:OnDialog(nGameLevel, nFlag)
	--if Wlls:GetMacthSession() <= 0 then
	--	Dialog:Say("Quan Liên Đấu：武林联赛功能还未开启。");
	--	return 0;
	--end
	
	--if nGameLevel == Wlls.MACTH_ADV and Wlls:GetMacthSession() < Wlls.MACTH_ADV_START_MISSION then
	--	Dialog:Say("Quan Liên Đấu：Võ lâm Liên Đấu chưa mở, hãy ghi danh vào lúc khác.");
	--	return 0;
	--end
	
	local nCheck, nRank = Wlls:OnCheckAward(me, nGameLevel);
	if nCheck == 1 and not nFlag then
		local tbSel = {
			{"Nhận phần thưởng liên đấu", Wlls.OnGetAward, Wlls, nGameLevel},
			{"Trở về",self.OnDialog, self, nGameLevel, 1},
			{"Kết thúc đối thoại"},
		}
		Dialog:Say(string.format("Quan Liên Đấu：Chiến đội của bạn xếp hạng <color=yellow>%s<color>, Sau khi nhận thưởng chiến đội sẽ giải tán, Bạn có muốn nhận không ?", nRank), tbSel);
		return 0;		
	end
	local nMacthType = Wlls:GetMacthType();
	local tbMacthCfg = Wlls:GetMacthTypeCfg(nMacthType);
	local szGameLevelName = Wlls.MACTH_LEVEL_NAME[nGameLevel];
	local szDesc = (tbMacthCfg and tbMacthCfg.szDesc) or "";
	local szMsg = string.format("Quan liên đấu %s：Từ xưa đến nay, đạo võ thuật chỉ nhân thêm và tiếp tục lưu truyền. Loại hình võ lâm liên đấu đợit này là %s\n\n<color=yellow>Võ lâm liên đấu %s<color>\n", szGameLevelName, szDesc, Wlls.DEF_STATE_MSG[Wlls:GetMacthState()]);
	local tbOpt = 
	{
		{string.format("Đến nơi liên đấu %s", szGameLevelName), self.EnterGame, self, nGameLevel},
		{string.format("Chiến đội liên đấu của tôi"), self.MyLeague, self, nGameLevel},
		{"Xem tình hình trận đấu", self.QueryMatch, self},
		{"Mua trang bị danh vọng liên đấu", self.BuyEquire, self},
		{string.format("Giới thiệu Võ Lâm Liên Đấu %s", szGameLevelName), self.About, self, nGameLevel},
		{"Ta chỉ đến xem"},
	};
	if Wlls:GetMacthState() == Wlls.DEF_STATE_REST then
		table.insert(tbOpt, 5, {string.format("Nhận phần thưởng Võ Lâm Liên Đấu %s", szGameLevelName), Wlls.OnGetAward, Wlls, nGameLevel});
	end
	
	if Wlls:GetMacthState() == Wlls.DEF_STATE_ADVMATCH then
		table.insert(tbOpt, 2, {"<color=yellow>Xem trận chung kết<color>", Wlls.OnLookDialog, Wlls});	
	end
	
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:EnterGame(nGameLevel)
	local szGameLevelName = Wlls.MACTH_LEVEL_NAME[nGameLevel];
	if Wlls:GetMacthState() == Wlls.DEF_STATE_CLOSE then
		Dialog:Say("Quan Liên Đấu：Giải đấu này chưa mở, xin vui lòng tham khảo các thông tin có liên quan trên trang chủ và diễn đàn.");
		return 0;		
	end
	if Wlls:GetMacthState() == Wlls.DEF_STATE_REST then
		Dialog:Say(string.format("Quan Liên Đấu: Giờ là thời gian giải lao Võ Lâm Liên Đấu %s, hội trường tạm thời không mở cửa, đến thời gian thi đấu hãy quay lại!", szGameLevelName));
		return 0;		
	end
	
	local szLeagueName = League:GetMemberLeague(Wlls.LGTYPE, me.szName);
	if not szLeagueName then
		Dialog:Say(string.format("Quan Liên Đấu：Hiện tại %s联赛的花名簿上，并没有您所在战队的报名记录啊1b，您可以与<color=yellow>联赛官员<color>对话，选择<color=yellow>我的联赛战队<color>选项，建立或加入战队！", szGameLevelName));
		return 0;
	end
	
	local nLevel = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MLEVEL);
	if nLevel ~= nGameLevel then
		Dialog:Say(string.format("Quan Liên Đấu：本届%s联赛的花名簿上，并没有您所在战队的报名记录啊1c，您可以与<color=yellow>联赛官员<color>对话，选择<color=yellow>我的联赛战队<color>选项，建立或加入战队！", szGameLevelName));
		return 0;		
	end
	
	local nMacthType = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MTYPE);
	if nMacthType ~= Wlls:GetMacthType() then
		Dialog:Say(string.format("Quan Liên Đấu：本届%s联赛的花名簿上，并没有您所在战队的报名记录啊1d，您可以与<color=yellow>联赛官员<color>对话，选择<color=yellow>我的联赛战队<color>选项，建立或加入战队！", szGameLevelName));
		return 0;		
	end

	if Wlls:GetMacthLevelCfgType() == Wlls.MAP_LINK_TYPE_SERIES then
		--未开发
		--判断自己现在的五行和报名时战队记录中的五行是否相符，不符不允许进场；
		local nOrgSereis	= League:GetMemberTask(Wlls.LGTYPE, szLeagueName, me.szName, Wlls.LGMTASK_SERIES);
		if (me.nSeries <= 0) then
			Dialog:Say("Quan Liên Đấu：Bạn chưa gia nhập môn phái, hãy tìm cho mình 1 môn phái thích hợp.");
			return 0;
		end
		if (nOrgSereis > 0 and nOrgSereis ~= me.nSeries) then
			local szOrgSereis = string.format(Wlls.SERIES_COLOR[nOrgSereis], Env.SERIES_NAME[nOrgSereis]);
			local szSereis = string.format(Wlls.SERIES_COLOR[me.nSeries], Env.SERIES_NAME[me.nSeries]);
			Dialog:Say(string.format("Quan Liên Đấu：你现在的五行是%s，和报名时的五行%s，不一致，请更换为报名时的五行！", szSereis, szOrgSereis));
			return 0;			
		end
	end	
	
	if Wlls:GetMacthLevelCfgType() == Wlls.MAP_LINK_TYPE_FACTION then
		--未开发
		--判断自己现在的门派和报名时战队记录中的五行是否相符，不符不允许进场；		
	end
	
	me.SetLogoutRV(1);
	Wlls:KickPlayer(me, "1e你进入了联赛会场，报名开始后，你与队友可以在<color=yellow>会场官员<color>处报名参加比赛。", nGameLevel);
	Dialog:SendBlackBoardMsg(me, "欢迎进入联赛会场，请到会场官员处报名参赛。");
end

function tbNpc:BuyEquire()
	me.OpenShop(134, 10) --使用声望购买
end

function tbNpc:MyLeague(nGameLevel)
	if Wlls:GetMacthState() == Wlls.DEF_STATE_CLOSE then
		Dialog:Say("Quan Liên Đấu：本届联赛暂未开放, 请留意官方公告。");
		return 0;		
	end
	if not Wlls:GetMacthTypeCfg(Wlls:GetMacthType()) then
		Dialog:Say("Quan Liên Đấu：下届联赛还未决定开赛期，请留意官方公告。");
		return 0;
	end
	
	if (GLOBAL_AGENT and GbWlls:GetGblWllsOpenState() == 0) then
		Dialog:Say("Quan Liên Đấu：本届联赛暂未开放, 请留意官方公告。");
		return 0;
	end
	
	local nQuFlag = GbWlls:CheckWllsQualition(me);
	if (nQuFlag == 0) then
		local szMsg = "Quan Liên Đấu：您已经报名参加了跨服联赛，无法参加这里的武林联赛！";
		if (GLOBAL_AGENT) then
			szMsg = "Quan Liên Đấu：您已经报名参加了您所在的服务器的武林联赛，无法参加这里的武林联赛！"; 
		end
		Dialog:Say(szMsg);
		return 0;
	end
	
	local szGameLevelName = Wlls.MACTH_LEVEL_NAME[nGameLevel];
	local szGameTypeName = Wlls:GetMacthTypeCfg(Wlls:GetMacthType()).szName;
	local nGamePlayerMax = Wlls:GetMacthTypeCfg(Wlls:GetMacthType()).tbMacthCfg.nMemberCount;
	local nPlayerMax	 = Wlls:GetMacthTypeCfg(Wlls:GetMacthType()).tbMacthCfg.nPlayerCount;
	local szMsg = "";
	local tbOpt = {};
	local szLeagueName = League:GetMemberLeague(Wlls.LGTYPE, me.szName);
	if not szLeagueName then
		szMsg = string.format("Quan Liên Đấu：Liên đấu <color=yellow>%s<color> lần này là <color=yellow>%s đấu.<color> Ngươi có thể chọn chiến đội mà mình muốn thiết lập, nếu trận đấu nhiều người ngươi có thể gia nhập vào chiến đội của người khác. Đội trưởng và người chơi khác sau khi tạo nhóm, sẽ đến chỗ<color=yellow> Quan Liên Đấu %s,<color> chọn <color=yellow>Chiến đội liên đấu của ta,<color> nhập nhóm của mình vào chiến đội của nhóm là được. Thành viên tối đa của chiến đội liên đấu lần này là <color=yellow>%s người<color>。", szGameLevelName, szGameTypeName, szGameLevelName, nGamePlayerMax);
		if nGamePlayerMax > nPlayerMax then
			szMsg = szMsg .. string.format("\n\n<color=yellow>%s名正式比赛成员1a，%s名为替补成员<color>\n当在准备场中，优先进入场地的为正式比赛成员，当有正式比赛成员离场，场地内的<color=yellow>替补成员将自动转为正式比赛成员<color>。", nPlayerMax, nGamePlayerMax - nPlayerMax);
		end
		tbOpt = {
			{string.format("Thiết lập chiến đội võ lâm liên đấu %s", szGameLevelName), self.CreateLeague, self, nGameLevel},
			{"Ta chỉ đến xem"},
		};
	else
		local szMemberMsg = self:GetLeagueInfoMsg(szLeagueName);
		local nCaptain = League:GetMemberTask(Wlls.LGTYPE, szLeagueName, me.szName, Wlls.LGMTASK_JOB);
		if nCaptain == 1 then
			szMsg = szMemberMsg.."<color=gold> Kiếm thế Private<color>";
			tbOpt = {
				{"Rời khỏi chiến đội", self.LeaveLeague, self, nGameLevel},
				{"Kiểm tra chiến tích chiến đội", self.QueryLeague, self},
				{"Ta chỉ đến xem"},
			};
			
			if #League:GetMemberList(Wlls.LGTYPE, szLeagueName)< nGamePlayerMax and League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MSESSION) == Wlls:GetMacthSession() then
				table.insert(tbOpt, 1 , {"Gia nhập nhóm vào chiến đội", self.JoinLeague, self, nGameLevel});
			end
			
		else
			szMsg = szMemberMsg.."\n2你可以选择退出战队。\n\n退出战队：在间歇期，你可以退出战队，重新加入其他战队或建立新战队。在比赛期，只要战队已参加比赛，则不能退出战队。";
			tbOpt = {			
				{"Rời khỏi chiến đội", self.LeaveLeague, self, nGameLevel},
				{"Kiểm tra chiến tích chiến đội", self.QueryLeague, self},
				{"Ta chỉ đến xem"},
			};
		end
		
		-- 五行相克双人赛
		if (Wlls:GetMacthTypeCfg(Wlls:GetMacthType()).tbMacthCfg.nSeries == Wlls.LEAGUE_TYPE_SERIES_RESTRAINT) then
			table.insert(tbOpt, 3, {"更换参赛五行", self.OnChangeSeries, self, szLeagueName});
		end
	end
	Dialog:Say(szMsg,tbOpt);
end

function tbNpc:CheckChangeSeries(szLeagueName, pMe)
	local nCaptain = League:GetMemberTask(Wlls.LGTYPE, szLeagueName, pMe.szName, Wlls.LGMTASK_JOB);
	if (1 ~= nCaptain) then
		return 0, "您不是联赛战队的队长不能更改五行！";
	end
	
	local tbLeagueList		= Wlls:GetLeagueMemberList(szLeagueName);
	local tbTeamMemberList	= KTeam.GetTeamMemberList(pMe.nTeamId);
	
	if (not tbTeamMemberList) then
		return 0, "请建立队伍后在更改五行。";
	end
	
	if (#tbTeamMemberList ~= #tbLeagueList) then
		return 0, "您的队伍人数与报名时的队伍人数不一致。";
	end

	local nMapId, nPosX, nPosY	= pMe.GetWorldPos();
	
	for _, nPlayerId in ipairs(tbTeamMemberList) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	
		if not pPlayer or pPlayer.nMapId ~= nMapId then
			return 0, "您的所有队友必须在这附近。";
		end

		local nMapId2, nPosX2, nPosY2	= pPlayer.GetWorldPos();
		local nDisSquare = (nPosX - nPosX2)^2 + (nPosY - nPosY2)^2;
		if nMapId2 ~= nMapId or nDisSquare > 400 then
			return 0, "您的所有队友必须在这附近。";
		end
	
		local nFindFlag = 0;
		for nId, szMemberName in ipairs(tbLeagueList) do
			if (pPlayer.szName == szMemberName) then
				nFindFlag = 1;
				break;
			end
		end

		if (0 == nFindFlag) then
			return 0, string.format("%s 不是战队成员，更换五行失败。", pPlayer.szName);
		end
		
		if (pPlayer.szName ~= pMe.szName) then
			if (0 == Wlls:IsSeriesRestraint(pPlayer.nSeries, pMe.nSeries)) then
				return 0, "队伍成员五行不是相克五行，不能更换五行。";
			end
		end
				
	end
	return 1;	
end

function tbNpc:OnChangeSeries(szLeagueName)
	local szMemberMsg	= "战队当前五行为：";
	local szOrgMsg		= "你的战队参赛五行为：";
	local nFlag, szResult = self:CheckChangeSeries(szLeagueName, me);
	if (0 == nFlag) then
		Dialog:Say(szResult);
		return 0;
	end

	local tbLeagueList	= Wlls:GetLeagueMemberList(szLeagueName);
	local tbTeamList	= KTeam.GetTeamMemberList(me.nTeamId);
	for nId, szMemberName in ipairs(tbLeagueList) do
		local pPlayer	= KPlayer.GetPlayerByName(szMemberName);
		local nSeries	= League:GetMemberTask(Wlls.LGTYPE, szLeagueName, pPlayer.szName, Wlls.LGMTASK_SERIES);
		if (not pPlayer) then
			Dialog:Say(string.format("%s成员不在附近。", szMemberName));
			return 0;
		end
		if nId == 1 then
			szMemberMsg = string.format("%s战队队长：<color=yellow>%s<color>，%s系，", szMemberMsg, szMemberName, string.format(Wlls.SERIES_COLOR[pPlayer.nSeries], Env.SERIES_NAME[pPlayer.nSeries]));
			szOrgMsg = string.format("%s战队队长：<color=yellow>%s<color>，%s系，", szOrgMsg, szMemberName, string.format(Wlls.SERIES_COLOR[nSeries], Env.SERIES_NAME[nSeries]));
			if #tbLeagueList > 1 then
				szMemberMsg = string.format("%s战队队员：", szMemberMsg);
				szOrgMsg = string.format("%s战队队员：", szOrgMsg);
			else
				szMemberMsg = string.format("%s<color=gray>无战队队员<color>\n", szMemberMsg);
				szOrgMsg = string.format("%s<color=gray>无战队队员<color>\n", szOrgMsg);
			end
		else
			szMemberMsg = string.format("%s<color=yellow>%s<color>，%s系", szMemberMsg, szMemberName, string.format(Wlls.SERIES_COLOR[pPlayer.nSeries], Env.SERIES_NAME[pPlayer.nSeries]));
			szOrgMsg = string.format("%s<color=yellow>%s<color>，%s系", szOrgMsg, szMemberName, string.format(Wlls.SERIES_COLOR[nSeries], Env.SERIES_NAME[nSeries]));
			if nId < #tbLeagueList then
				szMemberMsg = string.format("%s，", szMemberMsg);
				szOrgMsg = string.format("%s，", szOrgMsg);
			end
		end
	end
	local szMsg = string.format("%s；\n%s；\n是否更改为当前五行？", szOrgMsg, szMemberMsg);
	Dialog:Say(szMsg,
		{
			{"是", self.OnSureChangeSeries, self, szLeagueName},
			{"否"},	
		});
end

function tbNpc:OnSureChangeSeries(szLeagueName)
	local nFlag, szResult = self:CheckChangeSeries(szLeagueName, me);
	if (0 == nFlag) then
		Dialog:Say(szResult);
		return 0;
	end
	
	local szMemberMsg = "";
	local tbTeamList	= KTeam.GetTeamMemberList(me.nTeamId);
	local tbLeagueList	= Wlls:GetLeagueMemberList(szLeagueName);
	for nId, szMemberName in ipairs(tbLeagueList) do
		local pPlayer	= KPlayer.GetPlayerByName(szMemberName);
		if (not pPlayer) then
			Dialog:Say(string.format("%s成员不在附近。", szMemberName));
			return 0;
		end
		League:SetMemberTask(Wlls.LGTYPE, szLeagueName, szMemberName, Wlls.LGMTASK_SERIES, pPlayer.nSeries);
		
		if nId == 1 then
			szMemberMsg = string.format("%s战队队长：<color=yellow>%s<color>，%s系，", szMemberMsg, szMemberName, string.format(Wlls.SERIES_COLOR[pPlayer.nSeries], Env.SERIES_NAME[pPlayer.nSeries]));
			if #tbLeagueList > 1 then
				szMemberMsg = string.format("%s战队队员：", szMemberMsg);
			else
				szMemberMsg = string.format("%s<color=gray>无战队队员<color>\n", szMemberMsg);
			end
		else
			szMemberMsg = string.format("%s<color=yellow>%s<color>，%s系", szMemberMsg, szMemberName, string.format(Wlls.SERIES_COLOR[pPlayer.nSeries], Env.SERIES_NAME[pPlayer.nSeries]));
			if nId < #tbLeagueList then
				szMemberMsg = string.format("%s，", szMemberMsg);
			end
		end		
	end
	
	Dialog:Say(string.format("更换队员五行成功，队员五行更换为为：%s。", szMemberMsg));
end

function tbNpc:GetLeagueInfoMsg(szLeagueName)
	local tbLeagueList = Wlls:GetLeagueMemberList(szLeagueName);
	local szMemberMsg = string.format("Đội trưởng chiến đội Quan Liên Đấu：\nChiến đội：<color=yellow>%s<color>\n", szLeagueName);
	for nId, szMemberName in ipairs(tbLeagueList) do
		if nId == 1 then
			szMemberMsg = string.format("%sNhân vật：<color=yellow>%s<color>\n", szMemberMsg, szMemberName);
			
			if #tbLeagueList > 1 then
				szMemberMsg = string.format("%s战队队员：", szMemberMsg);
			else
				szMemberMsg = string.format("%s<color=gray>không có chiến đội<color>\n", szMemberMsg);
			end 
		else
			szMemberMsg = string.format("%s<color=yellow>%s<color>", szMemberMsg, szMemberName);
			if nId < #tbLeagueList then
				szMemberMsg = string.format("%s，", szMemberMsg);
			end
		end
	end
	return 	szMemberMsg;
end

function tbNpc:QueryLeague(szFindName)
	local szLeagueName = szFindName;
	if not szLeagueName then
		szLeagueName = League:GetMemberLeague(Wlls.LGTYPE, me.szName);
		if not szLeagueName then
			Dialog:Say("Quan Liên Đấu：您还没有战队！");
			return 0;
		end
	end
	local tbLeagueList = Wlls:GetLeagueMemberList(szLeagueName);
	local szMemberMsg = self:GetLeagueInfoMsg(szLeagueName);
	local nMSession = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MSESSION);
	local nMType = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MTYPE);
	local nMLevel = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MLEVEL);
	local nRank = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_RANK);
	local nWin = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_WIN);
	local nTie = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_TIE);
	local nTotal = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_TOTAL);
	local nTime = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_TIME);
	local nRankAdv	= League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_RANK_ADV);
	local nLoss = nTotal-nWin-nTie;
	if not Wlls.MACTH_TYPE[nMType] then
		Dialog:Say("Quan Liên Đấu：战队出现异常！");
		return 
	end
	local szMacthName = Wlls:GetMacthTypeCfg(nMType).szName;
	local szMacthLevel = Wlls.MACTH_LEVEL_NAME[nMLevel];
	local nPoint = nWin * Wlls.MACTH_POINT_WIN + nTie * Wlls.MACTH_POINT_TIE + nLoss * Wlls.MACTH_POINT_LOSS;
	local szRate = 100.00;
	if nTotal > 0 then
		szRate = string.format("%.2f", (nWin/nTotal)*100) .. "％";
	else
		szRate = "Vô";
	end
	local szRank = "";
	if nRank > 0 then
		szRank = string.format("\n战队排名2：<color=white>%s<color>", nRank);
	end
	local tbAdvMsg = {
		[0] = "Không phải 8 đội mạnh nhất",
		[1]	= "冠军4",
		[2]	= "进入决赛5",
		[4] = "进入四强赛6",
		[8] = "进入八强赛7",
	};
	szRank = szRank .. string.format("\n\nTình hình trận 8 đội mạnh nhất：<color=white>%s<color>", tbAdvMsg[nRankAdv]);
	
	szMemberMsg = string.format([[%s<color=green>
--Thành tích--
Số đợt liên đấu：<color=white>Đợt thứ %s<color> 
Tham gia thi đấu：<color=white>%s<color> 
Đẳng cấp：<color=white>%s<color> 
Tổng số trận：<color=white>%s<color> 
Tỷ lệ thắng：<color=white>%s<color>
Tổng tích lũy：<color=white>%s<color>
Thắng：<color=white>%s<color>  Hòa：<color=white>%s<color>  Thua：<color=white>%s <color>
Thời gian thi đấu tích lũy：<color=white>%s<color>
%s

<color=red>Danh sách thi đấu 8 đội mạnh sẽ được cập nhật lúc 0 giờ ngày 28<color>
]],szMemberMsg, Lib:Transfer4LenDigit2CnNum(nMSession), szMacthName, szMacthLevel, nTotal, szRate, nPoint, nWin, nTie, nLoss, Lib:TimeFullDesc(nTime), szRank);
		Dialog:Say(szMemberMsg, {{"Quay về", self.QueryMatch, self}, {"Kết thúc đối thoại2"}});
end

function tbNpc:QueryMatch()
	local szMsg = "<color=gold> Kiếm thế việt<color>";
	local tbOpt = {
		{"Xem tình hình của người khác", self.QueryOtherMatch, self, 1},
		{"Xem tình hình của chiến đội khác", self.QueryOtherMatch, self, 2},
		{"Xem chiến tích của bản thần", self.QueryMyMatch, self},
		{"Kết thúc đối thoại"},
	};
	local szLeagueName = League:GetMemberLeague(Wlls.LGTYPE, me.szName);
	if szLeagueName then
		table.insert(tbOpt, 1 , {"Xem chiến tích của chiến đội", self.QueryLeague, self})
	end	
	Dialog:Say(szMsg, tbOpt)
end

function tbNpc:QueryMyMatch()
	local nTotal = me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_MATCH_TOTLE);
	local nWin = me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_MATCH_WIN);
	local nTie = me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_MATCH_TIE);
	local nFirst = me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_MATCH_FIRST);
	local nSecond = me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_MATCH_SECOND);
	local nThird = me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_MATCH_THIRD);
	local nBest = me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_MATCH_BEST);
	local nLost = nTotal - nWin - nTie;
	local szMsg = string.format([[<color=green>
		--Thành tích--
		
		Tổng số trận：   <color=white>%s<color>
		Số trận thắng：   <color=white>%s<color>
		Số trận hòa：   <color=white>%s<color>
		Số trận thua：   <color=white>%s<color>
		
		Quán quân：   <color=white>%s<color>
		Á quân：   <color=white>%s<color>
		Quý quân：   <color=white>%s<color>
		
		Thứ tự tốt nhất：   <color=white>%s<color>
		
	<color=red>Thư tụ sẽ được cập nhật lại sau khi nhận phần thưởng liên đấu mỗi đợt<color>]], 
	nTotal, nWin, nTie, nLost, 
	nFirst, nSecond, nThird, nBest);
	Dialog:Say(szMsg, {{"Quay về", self.QueryMatch, self}, {"Kết thúc đối thoại4"}});
end

function tbNpc:QueryOtherMatch(nType, nFlag, szText)
	local szType = "战队名";
	if nType == 1 then
		szType = "角色名";
	end
	
	if not nFlag then
		Dialog:AskString(string.format("请输入%s：",szType), 16, self.QueryOtherMatch, self, nType, 1);
		return
	end
	--名字合法性检查
	local nLen = GetNameShowLen(szText);
	if nLen < 4 or nLen > 16 then
		Dialog:Say(string.format("您的%s的字数达不到要求。", szType));
		return 0;
	end
	
	--是否允许的单词范围
	if KUnify.IsNameWordPass(szText) ~= 1 then
		Dialog:Say(string.format("您的%s含有非法字符。", szType));
		return 0;
	end
	
	--是否包含敏感字串
	if IsNamePass(szText) ~= 1 then
		Dialog:Say(string.format("您的%s含有非法的敏感字符。", szType));
		return 0;
	end
	
	if nType == 2 then
		if not League:FindLeague(Wlls.LGTYPE, szText) then
			Dialog:Say("您查询的联赛战队不存在。");
			return 0;
		end
		--显示战队情况
		self:QueryLeague(szText);
	end
	if nType == 1 then
		if not League:GetMemberLeague(Wlls.LGTYPE, szText) then
			Dialog:Say("您查找的玩家不在联赛战队中.");
			return 0;
		end
		self:QueryLeague(League:GetMemberLeague(Wlls.LGTYPE, szText));
	end
end

function tbNpc:CreateLeague(nGameLevel, szCreateLeagueName, nCreateFlag)
	local nMacthType = Wlls:GetMacthType();
	local tbMacthCfg = Wlls:GetMacthTypeCfg(nMacthType);
	local szGameLevelName = Wlls.MACTH_LEVEL_NAME[nGameLevel];
	local szGameLevel1Name = Wlls.MACTH_LEVEL_NAME[Wlls.MACTH_PRIM];
	local szGameLevel2Name = Wlls.MACTH_LEVEL_NAME[Wlls.MACTH_ADV];
	if not tbMacthCfg then
		Dialog:Say("Quan Liên Đấu：联赛还未开启，请留意官方公告！");
		return 0;
	end
	local nMaxLevel = Wlls.PLAYER_ATTEND_LEVEL;
	if (GLOBAL_AGENT) then
		nMaxLevel = GbWlls.DEF_MIN_PLAYERLEVEL;
	end
	if me.nLevel < nMaxLevel then
		Dialog:Say(string.format("Quan Liên Đấu：%s武林联赛虽说是为选拔江湖中的后起之秀而设，但你等级还不到<color=yellow>%s级<color>，武艺未精，只怕刀剑无眼，误伤了你。你还是回去勤加练习好了！", szGameLevelName, Wlls.PLAYER_ATTEND_LEVEL));
		return 0;		
	end
	if me.nTeamId <= 0 then
		Dialog:Say("Quan Liên Đấu：必须组队才能建立战队！");
		return 0;
	end
	if me.IsCaptain() == 0 then
		Dialog:Say("Quan Liên Đấu：必须是队长才能建立战队！");
		return 0;
	end
	local szLeagueName = League:GetMemberLeague(Wlls.LGTYPE, me.szName);
	if szLeagueName then
		Dialog:Say("Quan Liên Đấu：您已经有战队,不能再建立战队！");
		return 0;
	end
	if Wlls:GetGameLevelForRank(me.szName) > nGameLevel then
		Dialog:Say(string.format("Quan Liên Đấu：阁下也是江湖上鼎鼎有名的大侠了，举办%s武林联赛是为选拔江湖中的后起之秀，你又何苦来与这些后辈争这点些许威名呢，你的荣誉点排名已经在<color=yellow>前%s名<color>，你还是去参加%s武林联赛吧！", szGameLevel1Name, Wlls.SEASON_TB[Wlls:GetMacthSession()][3], szGameLevel2Name));
		return 0;
	elseif  Wlls:GetGameLevelForRank(me.szName) < nGameLevel then
		if (GLOBAL_AGENT) then
			Dialog:Say(string.format("Quan Liên Đấu：%s武林联赛乃是天下英雄论剑比武之地，你的财富荣誉没有达到<color=yellow>前%s名<color>，联赛荣誉排名没有达到<color=yellow>前%s名<color>，造诣上怕还欠缺些火候。联赛中，四方英豪纷起，卧虎藏龙，你恐非此辈之对手，还是回去继续研习武艺为好！", szGameLevel2Name, GbWlls.DEF_ADV_MAXGBWLLS_MONEY_RANK, GbWlls.DEF_ADV_MAXGBWLLS_WLLS_RANK));
		else
			Dialog:Say(string.format("Quan Liên Đấu：%s武林联赛乃是天下英雄论剑比武之地，你的联赛荣誉点排名还不到<color=yellow>前%s名<color>，造诣上怕还欠缺些火候。联赛中，四方英豪纷起，卧虎藏龙，你恐非此辈之对手，还是回去继续研习武艺为好！", szGameLevel2Name, Wlls.SEASON_TB[Wlls:GetMacthSession()][3]));
		end
		return 0;		
	end
	
	if (GLOBAL_AGENT) then
		local nEnterFlag = GbWlls:GetGbWllsEnterFlag(me);
		if (nEnterFlag ~= 1) then
			Dialog:Say("Quan Liên Đấu：你没有通过<color=yellow>跨服联赛报名官<color>报名进入，不能建立战队。");
			return 0;
		end
		
		if (GbWlls:CheckSiguUpTime(GetTime()) == 0) then
			Dialog:Say("Quan Liên Đấu：现在不是报名时段，无法建立战队。")
			return 0;
		end
	end
	
	local tbTeamMemberList = KTeam.GetTeamMemberList(me.nTeamId);
	if not tbTeamMemberList then
		Dialog:Say("Quan Liên Đấu：必须组队才能建立战队！");
		return 0;
	end
	local nFlag, szMsg = Wlls:CheckCreateLeague(me, tbTeamMemberList, tbMacthCfg, nGameLevel);
	if nFlag == 1 then
		Dialog:Say(szMsg);
		return 0;
	end
	
	if not szCreateLeagueName then
		Dialog:AskString("1请输入战队名：", 12, self.CreateLeague, self, nGameLevel);
		return 0;
	end
	
	--名字合法性检查
	local nLen = GetNameShowLen(szCreateLeagueName);
	if nLen < 6 or nLen > 12 then
		Dialog:Say("您的战队名字的字数达不到要求,必须要3到6个汉字之间。");
		return 0;
	end
	
	--是否允许的单词范围
	if KUnify.IsNameWordPass(szCreateLeagueName) ~= 1 then
		Dialog:Say("您的战队名字含有非法字符。");
		return 0;
	end
	
	--是否包含敏感字串
	if IsNamePass(szCreateLeagueName) ~= 1 then
		Dialog:Say("您的战队名字含有非法的敏感字符。");
		return 0;
	end

	if League:FindLeague(Wlls.LGTYPE, szCreateLeagueName) then
		Dialog:Say("您取的战队名已存在，请重新建立战队");
		return 0;
	end
	
	if tbMacthCfg.nMapLinkType == Wlls.MAP_LINK_TYPE_SERIES then
		if (not nCreateFlag or nCreateFlag <= 0) then
			local nSeries = -1;
			local szMsg = "";
			local tbOpt	= {};
			for _, nPlayerId in ipairs(tbTeamMemberList) do
				local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
				if (pPlayer.nSeries <= 0) then
					szMsg = "你的战队中有队友未加入门派。";
					break;
				end
				
				if (nSeries <= 0) then
					nSeries = pPlayer.nSeries;
					local szSereis = string.format(Wlls.SERIES_COLOR[nSeries], Env.SERIES_NAME[nSeries]);
					szMsg	= string.format("您确定要以%s系参加%s五行赛吗？", szSereis, szSereis);
					tbOpt	= {
							{"确定", self.CreateLeague, self, nGameLevel, szCreateLeagueName, 1},
							{"再考虑考虑"},
						}; 
				else
					if (nSeries ~= pPlayer.nSeries) then
						szMsg = "你的战队中有队友门派不一致。";
						break;				
					end
				end
			end
			Dialog:Say(szMsg, tbOpt);
			return 0;
		end
	end
		
	if (tbMacthCfg.nMapLinkType == Wlls.MAP_LINK_TYPE_FACTION) then
		if (not nCreateFlag or nCreateFlag <= 0) then
			local nFaction = 0;
			local szMsg = "";
			local tbOpt	= {};
			for _, nPlayerId in ipairs(tbTeamMemberList) do
				local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
				if (pPlayer.nFaction <= 0) then
					szMsg = "你的战队中有队友未加入门派。";
					break;
				end
				
				if (nFaction <= 0) then
					nFaction = pPlayer.nFaction;
					local szFaction = Player:GetFactionRouteName(nFaction);
					szMsg	= string.format("您确定要以%s门派参加%s门派单人赛吗？", szFaction, szFaction);
					tbOpt	= {
							{"确定", self.CreateLeague, self, nGameLevel, szCreateLeagueName, 1},
							{"再考虑考虑"},
						}; 
				else
					if (nFaction ~= pPlayer.nFaction) then
						szMsg = "你的战队中有队友门派不一致。";
						break;				
					end
				end
			end
			Dialog:Say(szMsg, tbOpt);
			return 0;
		end
	end
		
	-- 五行相克赛
	if (tbMacthCfg.tbMacthCfg.nSeries == Wlls.LEAGUE_TYPE_SERIES_RESTRAINT) then
		if (not nCreateFlag or nCreateFlag <= 0) then
			local nSeries	= -1;
			local nNoFlag	= 0;
			local szSeriesMsg = "";		
			for _, nPlayerId in ipairs(tbTeamMemberList) do
				local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
				if (nSeries == -1) then
					nSeries = pPlayer.nSeries;
				else
					if (0 == Wlls:IsSeriesRestraint(nSeries, pPlayer.nSeries)) then
						nNoFlag = 1;
						break;
					end
				end
				szSeriesMsg = string.format("%s%s %s系，", szSeriesMsg, pPlayer.szName, string.format(Wlls.SERIES_COLOR[pPlayer.nSeries], Env.SERIES_NAME[pPlayer.nSeries]));
			end
			if (1 == nNoFlag) then
				Dialog:Say("这届联赛是相克双人赛，你们之间没有相克关系，还是选好五行再来参赛吧。");
				return 0;
			else
				szSeriesMsg = string.format("当前报名五行为：%s确定以当前五行参赛吗？", szSeriesMsg);
				local tbOpt	= {
						{"确定", self.CreateLeague, self, nGameLevel, szCreateLeagueName, 1},
						{"再考虑考虑"},
					}; 
				Dialog:Say(szSeriesMsg, tbOpt);
				return 0;
			end
		end
	end
	
	--记录扩展参数
	local nExParam = 0;
	--if tbMacthCfg.nMapLinkType == Wlls.MAP_LINK_TYPE_SERIES then
	--	nExParam = me.nFaction;
	--end
	
	local tbMemberList = {};
	for _, nPlayerId in ipairs(tbTeamMemberList) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			--pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_MATCH_FINISH, 0);--清除奖励领取选项.
			pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_SESSION, Wlls:GetMacthSession());--设置帮助锦囊显示信息
			pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TOTLE, 0);
			pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_WIN, 0);
			pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TIE, 0);
			local nMyGameLevel	= Wlls:GetGameLevelForRank(pPlayer.szName);
			local nGateway		= 0;
			local nExParam = 0;			
			if (GLOBAL_AGENT) then
				local szGateway = Transfer:GetMyGateway(pPlayer);
				nGateway = tonumber(string.sub(szGateway, 5, 8)) or 0;
				if (tbMacthCfg.nMapLinkType == Wlls.MAP_LINK_TYPE_FACTION) then
					nExParam = pPlayer.nFaction;
				end
			end
			
			table.insert(tbMemberList, {
				nId=nPlayerId,
				szName=pPlayer.szName,
				nFaction=pPlayer.nFaction, 
				nRouteId=pPlayer.nRouteId, 
				nSex=pPlayer.nSex, 
				nCamp=pPlayer.GetCamp(), 
				nSeries=pPlayer.nSeries,
				nMyGameLevel = nMyGameLevel,
				nGateway = nGateway,
				nExParam = nExParam,
				nLevel	= pPlayer.nLevel,
				});
		end
		pPlayer.Msg(string.format("您成为了<color=yellow>%s<color>联赛战队的一员，请在比赛期内，进入联赛会场，在<color=yellow>会场官员处报名参加比赛<color>。您可以到联赛官员处查询和操作本战队相关信息.", szCreateLeagueName));
		Dialog:SendBlackBoardMsg(pPlayer, string.format("您成功成为了%s联赛战队的成员", szCreateLeagueName));
		if (GLOBAL_AGENT) then
			local szGbMsg = string.format(GbWlls.MSG_JOIN_SUCCESS_FOR_MY, Wlls:GetMacthSession(), tbMacthCfg.szName);
			pPlayer.Msg(szGbMsg);
		end
	end
	me.Msg(szMsg);
	Dialog:Say(szMsg);
	GCExcute{"Wlls:CreateLeague", tbMemberList, szCreateLeagueName, nGameLevel, nExParam};
		
end

function tbNpc:JoinLeague()
	local nMacthType = Wlls:GetMacthType();
	local tbMacthCfg = Wlls:GetMacthTypeCfg(nMacthType);
	if not tbMacthCfg then
		Dialog:Say("Quan Liên Đấu：联赛还未开启，请留意官方公告！");
		return 0;
	end 
	if me.nTeamId <= 0 then
		Dialog:Say("Quan Liên Đấu：战队队长必须和要加入的成员组队才能将其组入战队！");
		return 0;
	end
	if me.IsCaptain() == 0 then
		Dialog:Say("Quan Liên Đấu：你必须是队伍的队长才能将队员组入战队！");
		return 0;
	end
	local szLeagueName = League:GetMemberLeague(Wlls.LGTYPE, me.szName);
	if not szLeagueName then
		Dialog:Say("Quan Liên Đấu：您还没创建战队！");
		return 0;
	end
	local nGameLevel = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MLEVEL);
	if League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MSESSION) ~= Wlls:GetMacthSession() then
		Dialog:Say("Quan Liên Đấu：您的战队参加的联赛已结束！");
		return 0;
	end
	local nCaptain = League:GetMemberTask(Wlls.LGTYPE, szLeagueName, me.szName, Wlls.LGMTASK_JOB);
	if not nCaptain or nCaptain == 0 then
		Dialog:Say("Quan Liên Đấu：只有战队队长才有资格邀请其他成员加入战队！");
		return 0;
	end
	
	local tbTeamMemberList = KTeam.GetTeamMemberList(me.nTeamId);
	if not tbTeamMemberList then
		Dialog:Say("Quan Liên Đấu：你必须是队伍的队长才能将队员组入战队！");
		return 0;
	end

	if (GLOBAL_AGENT) then
		if (GbWlls:CheckSiguUpTime(GetTime()) == 0) then
			Dialog:Say("Quan Liên Đấu：现在不是报名时段，无法让队员加入战队。")
			return 0;
		end
	end

	local tbPlayerList = League:GetMemberList(Wlls.LGTYPE, szLeagueName);
	local tbJoinPlayerIdList = {};
	for _, nPlayerId in pairs(tbTeamMemberList) do
		if me.nId ~= nPlayerId then
			local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
			if not pPlayer then
				Dialog:Say("您的所有队友必须在这附近。");
				return 0;
			end
			local nMyGameLevel = Wlls:GetGameLevelForRank(pPlayer.szName)

			local nExParam = 0;
			if (tbMacthCfg.nMapLinkType == Wlls.MAP_LINK_TYPE_FACTION) then
				nExParam = pPlayer.nFaction;
			end
		
			local nGateway		= 0;
			if (GLOBAL_AGENT) then
				local szGateway = Transfer:GetMyGateway(pPlayer);
				nGateway = tonumber(string.sub(szGateway, 5, 8)) or 0;
			end
			
			table.insert(tbJoinPlayerIdList, {
				nId=nPlayerId,
				szName=pPlayer.szName,
				nFaction=pPlayer.nFaction, 
				nRouteId=pPlayer.nRouteId, 
				nSex=pPlayer.nSex, 
				nCamp=pPlayer.GetCamp(), 
				nSeries=pPlayer.nSeries,
				nMyGameLevel = nMyGameLevel,
				nExParam = nExParam,
				nGateway = nGateway,
				nLevel	= pPlayer.nLevel,
				});
		end
	end
	if #tbJoinPlayerIdList <= 0 then
		Dialog:Say("Quan Liên Đấu：Không có thành viên nào trong nhòm của người");
		return 0;
	end
	local nMyGameLevel = Wlls:GetGameLevelForRank(me.szName);
	local nExParam = 0;
	if (tbMacthCfg.nMapLinkType == Wlls.MAP_LINK_TYPE_FACTION) then
		nExParam = me.nFaction;
	end

	local nGateway		= 0;
	if (GLOBAL_AGENT) then
		local szGateway = Transfer:GetMyGateway(me);
		nGateway = tonumber(string.sub(szGateway, 5, 8)) or 0;
	end

	table.insert(tbJoinPlayerIdList, 1, {
		nId=me.nId,
		szName=me.szName,
		nFaction=me.nFaction, 
		nRouteId=me.nRouteId, 
		nSex=me.nSex,
		nCamp=me.GetCamp(), 
		nSeries=me.nSeries,
		nGateway = nGateway,
		nGameLevel = nGameLevel,
		nExParam = nExParam,
		nLevel	= me.nLevel,
		});
	local nFlag, szMsg = Wlls:CheckJoinLeague(me, szLeagueName, tbPlayerList, tbJoinPlayerIdList, tbMacthCfg, nGameLevel);
	if nFlag == 1 then
		Dialog:Say(szMsg);
		return 0;
	end
	Dialog:Say("武林联赛官员：您的战队成功加入了新的战队成员！");
	for _, tbPlayer in pairs(tbJoinPlayerIdList) do
		local pPlayer = KPlayer.GetPlayerObjById(tbPlayer.nId);
		if pPlayer then
			if pPlayer.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_SESSION) ~= Wlls:GetMacthSession() then
				--pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_MATCH_FINISH, 0);--清除奖励领取选项.
				pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_SESSION, Wlls:GetMacthSession());--设置帮助锦囊显示信息
				pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TOTLE, 0);
				pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_WIN, 0);
				pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TIE, 0);
			end
			local szBlackMsg = string.format("您成功成为了%s联赛战队的成员", szLeagueName);
			local szMsg = string.format("您成为了<color=yellow>%s<color>联赛战队的一员，请在比赛期内，进入联赛会场，在会场官员处报名参加比赛。您可以到联赛官员处查询和操作本战队相关信息.", szLeagueName);
			if tbPlayer.nId == me.nId then
				szBlackMsg = "您的战队成功加入了新的战队成员";
				szMsg = "您的战队<color=yellow>成功加入了新的成员<color>，请在比赛期内，进入联赛会场，在会场官员处报名参加比赛。您可以到联赛官员处查询和操作本战队相关信息.";
			end
			pPlayer.Msg(szMsg);
			Dialog:SendBlackBoardMsg(pPlayer, szBlackMsg);	
		end
	end
	GCExcute{"Wlls:JoinLeague", szLeagueName, tbJoinPlayerIdList};
end

function tbNpc:LeaveLeague(nGameLevel, nFlag)
	local szLeagueName = League:GetMemberLeague(Wlls.LGTYPE, me.szName);
	if not szLeagueName then
		Dialog:Say("武林联赛官员：您没有战队！");
		return 0;
	end
	local nSession = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MSESSION);
	if League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_ATTEND) > 0 and nSession == Wlls:GetMacthSession() then
		Dialog:Say("武林联赛官员：您的战队已参加过本届比赛,您不能退出战队。");
		return 0;
	end
	if nFlag == 1 then
		Dialog:Say("武林联赛官员：成功退出战队。");
		-- 只有非全局服务器才能设置
		if (not GLOBAL_AGENT) then
			Wlls:SetPlayerSession(me.szName, 0);
		end
		GCExcute{"Wlls:LeaveLeague", me.szName, nGameLevel};
		return 0;
	end
	local szMsg = "";
	local tbOpt = {
		{"Đồng ý rời khỏi", self.LeaveLeague, self, nGameLevel, 1},
		{"Để ta suy nghĩ đã"},
	}
	--如果高级联赛，退出特殊判断
	if nGameLevel == Wlls.MACTH_ADV and Wlls:GetGameLevelForRank(me.szName) == Wlls.MACTH_ADV then
		local tbLeagueMemberList = Wlls:GetLeagueMemberList(szLeagueName);
		local tbAdv = {};
		for _, szName in pairs(tbLeagueMemberList) do
			if Wlls:GetGameLevelForRank(szName) == Wlls.MACTH_ADV then
				table.insert(tbAdv, szName);
			end
		end
		if #tbAdv <= 1 then
			if (GLOBAL_AGENT) then
				szMsg = string.format("武林联赛官员：你退出战队后，剩余队员联赛资格没有达到高级跨服联赛的要求，本战队将会解散。<color=red>你退出战队后，将无法领取本战队的排名奖励，<color>你确定要退出战队吗？");
			else
				szMsg = string.format("武林联赛官员：你退出战队后，剩余队员不是联赛荣誉排行榜前<color=yellow>%s名<color>，本战队将会解散。<color=red>你退出战队后，将无法领取本战队的排名奖励，<color>你确定要退出战队吗？", Wlls.SEASON_TB[Wlls:GetMacthSession()][3]);
			end
			Dialog:Say(szMsg, tbOpt);
			return 0;
		end
	end
	
	local nCaptain = League:GetMemberTask(Wlls.LGTYPE, szLeagueName, me.szName, Wlls.LGMTASK_JOB);
	if nCaptain == 1 then
		szMsg = "Quan Liên Đấu：Sau khi ngươi rời khỏi chiến đội, tư cách đội trưởng sẽ chuyển cho thành viên khác; nếu không còn thành viên nào khác, thi chiến đội sẽ giải tán. <color=red>Ngươi sẽ không nhận được phần thưởng xếp hạng chiến đội lần này,<color> ngươi thực sự muốn rời khỏi chứ?"
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	szMsg = "武林联赛官员：<color=red>你退出战队后，将无法领取该战队的排名奖励，<color>你确定要退出战队吗？";
	Dialog:Say(szMsg, tbOpt);	
end

function tbNpc:BreakLeague()
	local szLeagueName = League:GetMemberLeague(Wlls.LGTYPE, me.szName);
	if not szLeagueName then
		Dialog:Say("武林联赛官员：您没有战队！");
		return 0;
	end
	if League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_ATTEND) > 0 then
		Dialog:Say("武林联赛官员：您的战队已参加过本届比赛,不能解散战队。");
		return 0;
	end	
	GCExcute{"Wlls:BreakLeague", me.szName};
end

tbNpc.tbAbout = 
{

	[1] = [[
	1. Bạn có thể đăng ký thành lập chiến đội liên đấu ở chỗ Quan Liên Đấu (sơ, cao) các thành thị.
	
	2. Nếu loại hình liên đấu là nhiều người, sau khi lập chiến đội, đội trưởng có thể chọn người phù hợp điều kiện ở chỗ Quan Liên Đấu (sơ, cao) gia nhập chiến đội của mình.
	
	3. Ngày thi đấu, thành viên chiến đội đối thoại với Quan Liên Đấu (sơ, cao) để vào Hội trường liên đấu, đối thoại với Quan Hội Trường, ghi danh tham gia thi đấu ngày hôm đó.
	
	4. Sau khi ghi danh, thành viên chiến đội vào Khu chuản bị liên đấu, hết thời gian chuẩn bị thi vào Đấu trường chính thức thi đấu.]],
	[2] = [[
    1. Trong Võ lâm liên đấu, <color=yellow>mỗi mùa đấu là 1 tháng, ngày 7 - 28<color> là thời gian đấu, trong đó ngày <color=yellow>7 - 28<color> là thời gian thi đấu tuần hoàn, <color=yellow>ngày 28<color> là thời gian thi chung kết liên đấu (cao), liên đấu (sơ) không có đấu chung kết. <color=yellow>8 đợi đứng đầu<color> vòng đấu tuần hoàn có quyền được vào chung kết, xếp hạng của 8 đội ngày căn cứ theo thành tích của vòng chung kết, các đội còn lại căn cứ thành tích vòng đấu tuần hoàn. Trong cả mùa đấu (3 tuần) có tất cả <color=yellow>150 trần đấu<color>, mỗi chiến đội được tham gia nhiều nhất <color=yellow>48 trận<color> thi đấu, các trận đấu ở vòng chung kết không được tính trong số 48 trận này.	
   
    2. Thời gian thi đấu cụ thể
    Thứ hai - Thứ sáu（mỗi ngày 6 trận）：<color=yellow>20：00、20：15、20：30、20：45、21：00、21：15<color>
    周六-周日（每天10场）：<color=yellow>15：00、15：15、15：30、15：45、16：00、16：15、19：00、19：15、19：30、19：45、20：00<color>
    28日（共5场）：<color=yellow>19：00、19：15、19：30、19：45<color>

    3）每场比赛准备时间为<color=yellow>5分钟<color>，比赛时间为<color=yellow>10分钟<color>。

    4）最终决赛共有5场，19：00为8强进4强，19：15为4强进决赛，19：30、19：45、20：00为冠亚军决赛，双方需要打满3场，各队伍没有参加决赛的自动判负。
	]],
	[3] = [[
	1）武林联赛分为初级武林联赛和高级武林联赛。你需要加入战队才能参加联赛。
	
	2）初级武林联赛战队参赛条件：战队成员为100级以上，已加入门派，且不能为联赛荣誉点排行榜前%s名（根据联赛类型不同，所需条件也不同）。<color=yellow>（高级联赛将在第三届联赛开放）<color>
	
	3）高级武林联赛战队参赛条件：战队成员为100级以上，已加入门派，且战队队长为联赛荣誉点排行榜前%s名。<color=yellow>（高级联赛将在第三届联赛开放）<color>
	]],
	[4] = [[
	1）联赛类型为多人赛时，战队队长可以与其他人组队，在各大城市的初级（高级）武林联赛官员处，选择将队伍中的成员，加入本战队。
	
	2）在赛季期内，凡是没有参加过比赛的战队，其战队成员都可以在各大城市的初级（高级）武林联赛官员处选择退出战队。
	
	3）若高级武林联赛的参赛战队由于战队队长退出战队，导致队长不是联赛荣誉点排行榜前%s名，则该战队丧失参赛资格。<color=yellow>（高级联赛将在第三届联赛开放）<color>
	]],
	[5] = [[
	1）比赛过程中本方将对方队员全部重伤时判胜。
	
	2）在比赛过程中如对方队员同时不在比赛场内，则本方直接获胜。
	
	3）在比赛时间结束后，双方仍未分出胜负，则判定剩余人数多的战队获胜；如果双方剩余人数相同，则以双方所有队员有效受伤总量来判断胜负,有效受伤总量小的一方获胜。有效受伤总量相同，则判平。
	
	4）参加比赛，轮空的战队直接判胜。轮空获胜比赛时间按5分钟计算。
	]],
	[6] = [[
	1）	常规比赛奖励：每场比赛打完，无论胜负平，参赛玩家都能获得经验、联赛声望和联赛荣誉点的奖励。
	
	2）	最终排名奖励：根据联赛的最终排名，参赛玩家能获得经验、联赛声望和联赛荣誉点奖励。同时排名前列的玩家可以领取特殊的联赛称号奖励。
	]],
}

function tbNpc:About()
	local tbOpt = 
	{
		{"Các bước thì đấu", self.AboutInfo, self, 1},
		{"Thời gian thi đấu", self.AboutInfo, self, 2},
		{"Điều kiện thi đấu", self.AboutInfo, self, 3},
		{"Thao tác liên quan chiến đội", self.AboutInfo, self, 4},
		{"Phương thức quyết định thằng thua", self.AboutInfo, self, 5},
		{"Phần thưởng liên đấu", self.AboutInfo, self, 6},
		{"Kết thúc đối thoại"},
	}
	
	Dialog:Say("<color=gold> Kiếm thế việt<color>", tbOpt);
end

function tbNpc:AboutInfo(nType)
	if not Wlls.SEASON_TB[Wlls:GetMacthSession()] then
		Dialog:Say("武林联赛官员：下届武林联赛还未确定类型，请留意官方公告。");
		return 0;
	end
	local nRank = Wlls.SEASON_TB[Wlls:GetMacthSession()][3];
	Dialog:Say(string.format(self.tbAbout[nType], nRank, nRank), {{"Quay về", self.About, self},{"Kết thúc đối thoại"}});
end
