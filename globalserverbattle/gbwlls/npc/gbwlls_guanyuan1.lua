-- 跨服联赛报名官

local tbNpc = Npc:GetClass("gbwlls_guanyuan1");

function tbNpc:OnDialog()
	local nGblSession = GbWlls:GetGblWllsOpenState();
	if (nGblSession <= 0) then
		Dialog:Say("跨服联赛还未开启！");
		return 0;
	end
	
	local tbMacthCfg = GbWlls:GetMacthTypeCfg(GbWlls:GetMacthType(nGblSession));
	if (not tbMacthCfg) then
		Dialog:Say("跨服联赛还未开启！");
		return 0;
	end

	local szDesc = (tbMacthCfg and tbMacthCfg.szDesc) or "";
	
	local szMsg = string.format("亘古至今，武术之道，唯承上而继下也。为了追求武术的更高境界，特开放跨服联赛，供各位切磋比试。本届跨服联赛为<color=yellow>%s<color>7日-27日为循环赛，%s日为8强决赛。", szDesc, GbWlls.DEF_ADV_PK_STARTDAY);
	
	local tbOpt = {};
	
	tbOpt[#tbOpt + 1] = {"进入跨服联赛会场", self.OnEnterGblServer, self};
	tbOpt[#tbOpt + 1] = {"领取跨服联赛单场奖励", self.OnGetAwardSingle, GbWlls};
	tbOpt[#tbOpt + 1] = {"领取最终奖励", GbWlls.OnGetAward, GbWlls};
	tbOpt[#tbOpt + 1] = {"查询跨服活动专用绑银", self.AskForCurrencyMoney, self};
	tbOpt[#tbOpt + 1] = {"雕像相关", self.OnAboutStatuary, self};
	tbOpt[#tbOpt + 1] = {"跨服联赛声望装备相关", self.OnAboutGbWllsRepute, self};
	tbOpt[#tbOpt + 1] = {"跨服武林联赛的相关介绍", self.About, self};
	tbOpt[#tbOpt + 1] = {"我还有点事情，先不过去了"};

	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:OnGetAwardSingle()
	local szMsg = "你目前没有奖励可以领取。";
	local tbOpt	= {};
	local nFlag = 0;
	GbWlls:UpdateMatchAwardCount(me);

	local nTotalGetedAward = me.GetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_MATCH_WIN_AWARD) + me.GetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_MATCH_TIE_AWARD) + me.GetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_MATCH_LOSE_AWARD);

	if (nTotalGetedAward >= Wlls.MACTH_ATTEND_MAX) then
		Dialog:Say(string.format("你已经领完所有%d场单场奖励了。", Wlls.MACTH_ATTEND_MAX));
		return 0;
	end
	
	if (GbWlls:OnCheckAwardSingle(me, GbWlls.GBTASKID_MATCH_WIN_AWARD, GbWlls.TASKID_MATCH_WIN_AWARD) > 0) then
		nFlag = 1;
		tbOpt[#tbOpt + 1] = {"领取单场胜奖励", GbWlls.OnGetAwardSingle, GbWlls, GbWlls.GBTASKID_MATCH_WIN_AWARD, GbWlls.TASKID_MATCH_WIN_AWARD};
	end

	if (GbWlls:OnCheckAwardSingle(me, GbWlls.GBTASKID_MATCH_TIE_AWARD, GbWlls.TASKID_MATCH_TIE_AWARD) > 0) then
		nFlag = 1;
		tbOpt[#tbOpt + 1] = {"领取单场平奖励", GbWlls.OnGetAwardSingle, GbWlls, GbWlls.GBTASKID_MATCH_TIE_AWARD, GbWlls.TASKID_MATCH_TIE_AWARD};
	end

	if (GbWlls:OnCheckAwardSingle(me, GbWlls.GBTASKID_MATCH_LOSE_AWARD, GbWlls.TASKID_MATCH_LOSE_AWARD) > 0) then
		nFlag = 1;
		tbOpt[#tbOpt + 1] = {"领取单场负奖励", GbWlls.OnGetAwardSingle, GbWlls, GbWlls.GBTASKID_MATCH_LOSE_AWARD, GbWlls.TASKID_MATCH_LOSE_AWARD};
	end

	if (nFlag == 0) then
		Dialog:Say(szMsg);
		return 0;
	end
	
	tbOpt[#tbOpt + 1] = {"我考虑考虑"};
	Dialog:Say("你有奖励可以领取。", tbOpt);
	return 0;
end

function tbNpc:OnEnterGblServer()
	local nFlag, szMsg = GbWlls:CheckIsCanTransferGblWlls(me);
	if (nFlag <= 0) then
		Dialog:Say(szMsg);
		return 0;
	end
	Transfer:NewWorld2GlobalMap(me);
	GbWlls:SetGbWllsEnterFlag(me, 1);
end

function tbNpc:OnAboutStatuary()
	local szMsg = "跨服武林联赛前4名的战队成员，有树立雕像的资格，树立的雕像可供玩家膜拜或者受到玩家的唾弃，受到膜拜后会长崇敬度，崇敬度达到一定可以获得意外惊喜！";
	local tbOpt	= {
		{"树立雕像", self.OnBuildStatuary, self},
		{"我要领取120级马", self.OnBuy120House, self},
		{"了解雕像相关情况", self.OnAboutStatInfo, self},	
	};
	
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:OnBuildStatuary()
	local nFlag, szMsg = self:CheckStatuary(me);
	if (0 == nFlag or 2 == nFlag) then
		Dialog:Say(szMsg);
		return 0;
	end
	Dialog:Say("树立雕像要花费1万个魂石，请大侠带好足够的魂石，兄弟们才好动手修建！",
		{
			{"我要树立雕像", self.OnSureBuild, self},
			{"等会再说"},	
		}
	);
end

function tbNpc:CheckStatuary(pPlayer)
	local nType	= pPlayer.GetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_STATUARY_TYPE);
	if (nType <= 0) then
		return 0, "您没有树立雕像的资格！";
	end	
	local nFlag = Domain.tbStatuary:CheckStatuaryState(pPlayer.szName, nType);
	if (nFlag <= 0) then
		return 0, "您没有树立雕像的资格！";
	elseif (nFlag == 2) then
		return 2, "你已经树立雕像，不能再树立了。";
	end
	return 1;
end

function tbNpc:OnSureBuild()
	local nFlag, szMsg = self:CheckStatuary(me);
	if (0 == nFlag or 2 == nFlag) then
		Dialog:Say(szMsg);
		return 0;
	end

	local nFaction = Faction:GetGerneFactionInfo(me)[1];
	if (not nFaction) then
		nFaction = me.nFaction;
	end
	
	if (Player.FACTION_NONE == nFaction) then
		Dialog:Say("你还没有加入门派，不能树立雕像。");
		return;
	end
	if (Player.FACTION_NUM < nFaction) then
		return;
	end
	local nStoneCount = me.GetItemCountInBags(18,1,205,1);
	if (nStoneCount < 10000) then
		Dialog:Say("树立雕像所需的五行魂石不足！");
		return;
	end
	GbWlls:WriteLog("BuildStatuary", string.format("%s use series stone %d success!", me.szName, 10000));
	local nType	= me.GetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_STATUARY_TYPE);
	local nResult = Domain.tbStatuary:AddStatuary(me.szName, nType, nFaction, me.nSex, "");
	if (0 == nResult) then
		GbWlls:WriteLog("OnSureBuild", string.format("%s BuildStatuary Failed!", me.szName));
		return;
	end
	if (1 == me.ConsumeItemInBags2(10000, 18,1,205,1)) then
		GbWlls:WriteLog("OnSureBuild", string.format("%s use series stone %d failed!", me.szName, 10000));
		return;
	end
	local tbInfo = Domain.tbStatuary:GetStatuaryInfoByName(me.szName, nType);
	if (not tbInfo) then
		GbWlls:WriteLog("OnSureBuild", string.format("%s is not found, realy!", me.szName));
		return 0;
	end
	local szMsg = string.format("不朽雕像已经在临安府<color=green>(%d,%d)<color>树立了！", math.floor(tbInfo.tbNpcInfo.nX/8), math.floor(tbInfo.tbNpcInfo.nY/16));
	me.Msg("您的" .. szMsg);
	KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, string.format("玩家%s的%s", me.szName, szMsg));
end

function tbNpc:OnBuy120House(nSureFlag)
	local nType = me.GetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_STATUARY_TYPE);
--	local nFlag = Domain.tbStatuary:CheckStatuaryState(me.szName, nType);
--	if (nFlag ~= 2) then
--		Dialog:Say("你当前还没有树立雕像，无法领取奖励。");
--		return;
--	end
	
	local nRevere = Domain.tbStatuary:GetRevere(me.szName, 2000);
	if (nRevere < 1500) then
		Dialog:Say(string.format("你当前雕像累计的崇敬度为<color=yellow>%d<color>，不够<color=yellow>1500<color>点，不能领取到奖励。", nRevere));
		return;
	end
	
	if (me.CountFreeBagCell() < 1) then
		Dialog:Say("您的背包空间不够，需要1格背包空间。");
		return;
	end
	
	if (not nSureFlag or nSureFlag ~= 1) then
		Dialog:Say(string.format("在江湖上获得足够崇敬的英雄才可以拥有120级灵驹，领取120级马需要花费1500崇敬度，你现在崇敬度是<color=yellow>%d<color>，你确定需要领取吗？", nRevere), 
			{
				{"我确定", self.OnBuy120House, self, 1},
				{"我在考虑考虑"},	
			}
		);
		return 0;
	end
	
	Dbg:WriteLogEx(Dbg.LOG_INFO, "GbWlls", "gbwlls_guanyuan1", string.format("Award %s a horse", me.szName));
	
	Domain.tbStatuary:DecreaseRevere(me.szName, 2000, 1500);
	local pItem = me.AddItem(1,12,12,4);
	if (not pItem) then
		Dbg:WriteLogEx(Dbg.LOG_INFO, "GbWlls", "gbwlls_guanyuan1", string.format("Add %s a horse item failed", me.szName));
	end
	local a,b = pItem.GetTimeOut();
	pItem.Bind(1);		-- 强制绑定
	if b == 0 then
		me.SetItemTimeout(pItem, os.date("%Y/%m/%d/%H/%M/00", GetTime() + 3600 * 24 * 30));
		pItem.Sync();
	end
	local szMsg = "在雕像树立的这段时间内，你的成就得到了广大民众的认可，累计突破了1500点崇敬度。" ..
					"特此，授予你120级的特殊坐骑，并扣除你1500点崇敬度。" ..
					"之后，只要你的崇敬度继续累积到1500点，仍然可以来我处领取120级的特殊坐骑。"
	Dialog:Say(szMsg);
end

tbNpc.tbAboutStatuary = 
{
	[1] = [[
	跨服联赛结束后，获得树立雕像资格的玩家，可以在“跨服联赛报名官”处，花费1万个魂石（绑定或者不绑定都可以），树立雕像。树立雕像后，可以被其他角色（90级以上）“膜拜”和“唾弃”。
]],
	[2] = [[
	每个角色每天可以对雕像膜拜/唾弃一次。膜拜后，当前雕像增加1点崇敬度，膜拜者可以获得3个黄金福袋。同时雕像损失1点耐久。
]],
	[3] = [[
	每个角色每天可以对雕像膜拜/唾弃一次。唾弃后，当前雕像损失1点耐久。
]],
	[4] = [[
	雕像最长期限为90天。不论雕像是哪天树立，在下一届跨服联赛决赛开始前都会消失。例如，第一届跨服联赛结束树立的雕像，在4月48日0点，不论雕像是否到达90天的期限，都会消失。
]],
}

function tbNpc:OnAboutStatInfo()
	local szMsg = "跨服武林联赛前4名的战队成员，有树立雕像的资格。获得树立雕像资格的玩家，要在临安府的跨服联赛报名官处缴纳1万个魂石，才可以树立雕像。雕像被膜拜一次增加1点崇敬度，雕像达到1500崇敬度可以领取120级马（30天）。玩家领取120级马后，扣除雕像1500崇敬度。";
	local tbOpt = 
	{
		{"树立雕像", self.AboutStatInfo, self, 1},
		{"膜拜", self.AboutStatInfo, self, 2},
		{"唾弃", self.AboutStatInfo, self, 3},
		{"雕像的期限", self.AboutStatInfo, self, 4},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:AboutStatInfo(nType)
	Dialog:Say(self.tbAboutStatuary[nType], {{"返回上层", self.OnAboutStatInfo, self},{"Kết thúc đối thoại"}});
end

-- 查询武林大会专用绑银
function tbNpc:AskForCurrencyMoney()
	local nCurrentMoney = KGCPlayer.OptGetTask(me.nId, KGCPlayer.TSK_CURRENCY_MONEY);
	if nCurrentMoney >= 0 then
		Dialog:Say("你当前的跨服活动专用银两为<color=gold>"..nCurrentMoney.."<color>。");
	else
		Dialog:Say("获取不了你当前的武林大会专用银两。");
	end
	return 0;
end

tbNpc.tbAbout = 
{

	[1] = [[
	1）本届跨服联赛为<color=yellow>混合双人赛<color>，具体报名规则与联赛双人赛规则相同。你可以通过<color=yellow>临安府的跨服武林联赛官员<color>处报名参加跨服武林联赛。
	
	2）联赛类型为多人赛时，战队建立后，战队队长可以在英雄岛的高级（初级）武林联赛官员处将其他符合条件的人加入自己的战队。
	
	3）比赛日，战队成员与洗髓岛的跨服武林联赛官员对话进入联赛会场，与会场官员对话，报名参加当日比赛。
	
	4）报名后，战队成员进入联赛准备场，待准备时间结束，则进入比赛场正式开始比赛。]],
	[2] = [[
    1）跨服武林联赛每个<color=yellow>赛季为1个月<color>，当月<color=yellow>7-28号<color>为比赛期，其中<color=yellow>7-27<color>号为循环赛时间，<color=yellow>28号<color>为高级联赛决赛时间，初级联赛没有决赛。循环赛<color=yellow>前8名的队伍<color>有资格参加最后的决赛，联赛前8名排名以决赛名次为准，其他名次以循环赛为准。联赛全赛季（3个星期）共<color=yellow>150场比赛<color>，每个战队最多可参加<color=yellow>48场<color>比赛，决赛的场次不计算在48场之内。	
   
    2）具体比赛时间为
    周一-周五（每天6场）：<color=yellow>20：00、20：15、20：30、20：45、21：00、21：15<color>
    周六-周日（每天10场）：<color=yellow>15：00、15：15、15：30、15：45、16：00、16：15、19：00、19：15、19：30、19：45、20：00<color>
    28日（共5场）：<color=yellow>19：00、19：15、19：30、19：45<color>

    3）每场比赛准备时间为<color=yellow>4分半<color>，比赛时间为<color=yellow>10分钟<color>。

    4）最终决赛共有5场，19：00为8强进4强，19：15为4强进决赛，19：30、19：45、20：00为冠亚军决赛，双方需要打满3场，各队伍没有参加决赛的自动判负。
	]],
	[3] = [[
	1）第一届跨服武林联赛只有高级联赛。你需要加入战队才能参加联赛。
	
	2）高级武林联赛战队参赛条件：战队成员为100级以上，已加入门派，且必须为本服务器联赛荣誉排名前150名，或者财富荣誉排名前200名（根据联赛类型不同，所需条件也不同）。
	
	]],
	[4] = [[
	1）联赛类型为多人赛时，战队队长可以与其他人组队，在英雄岛的初级（高级）武林联赛官员处，选择将队伍中的成员，加入本战队。
	
	2）在赛季期内，凡是没有参加过比赛的战队，其战队成员都可以在英雄岛的初级（高级）武林联赛官员处选择退出战队。

	]],
	[5] = [[
	1）比赛中任意一方将对方两人全部击败时判胜。
	
	2）在比赛过程中如其中一队参赛选手同时不在比赛场内，则另一队直接获胜。
	
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
		{"参赛流程", self.AboutInfo, self, 1},
		{"赛程时间", self.AboutInfo, self, 2},
		{"参赛条件", self.AboutInfo, self, 3},
		{"战队的相关操作", self.AboutInfo, self, 4},
		{"如何判定胜负", self.AboutInfo, self, 5},
		{"联赛奖励", self.AboutInfo, self, 6},
		{"Kết thúc đối thoại"},
	}
	
	Dialog:Say("武林联赛官员：武林联赛为每三个月举行一届的竞技活动。你可以参加联赛，与众多武林高手一起争夺武林至高荣誉。想查询武林联赛相关信息吗?选择你想要查询的信息。", tbOpt);
end

function tbNpc:AboutInfo(nType)
	local nGbSession = GbWlls:GetGblWllsOpenState();
	if not GbWlls.SEASON_TB[nGbSession] then
		Dialog:Say("武林联赛官员：下届武林联赛还未确定类型，请留意官方公告。");
		return 0;
	end
	local nRank = GbWlls.SEASON_TB[nGbSession][3];
	Dialog:Say(string.format(self.tbAbout[nType], nRank, nRank), {{"返回上层", self.About, self},{"Kết thúc đối thoại"}});
end

function tbNpc:OnAboutGbWllsRepute()
	local szMsg = "换取声望道具";
	local tbOpt = {
		{"材料换取跨服联赛声望道具", self.OnChangeItem, self},
		{"购买声望装备", self.OnOpenShop, self},
		{"我来看看"},
	};
	Dialog:Say(szMsg, tbOpt);
	return 1;
end

function tbNpc:OnOpenShop()
	me.OpenShop(168, 10);
end

function tbNpc:OnChangeItem()
	local varParam = {
		tbAward = {
				{nGenre=18, nDetail=1,nParticular=916,nLevel=1,nCount=1,nBind=0},
			},
		tbMareial = {
				{nGenre=18, nDetail=1,nParticular=476,nLevel=1,nCount=50},
				{nGenre=18, nDetail=1,nParticular=915,nLevel=1,nCount=1},
			},
		};
	if (me.CountFreeBagCell() < 1) then
		Dialog:Say("Hành Trang không đủ chỗ trống1格！");
		return 0;
	end
	Dialog:OpenGift("50个月影之石和1个五色石换取1个白玉", varParam, nil);
end
