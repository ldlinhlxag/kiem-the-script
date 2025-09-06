--Lottery.tbAwardBindCoin ={
--	[1] = 500000, -- Giải Nhất
--	[2] = 50000,  -- Giải Nhì
--	[3] = 5000,   -- 铜奖
--	[4] = 100000, -- 鼓励奖 以下都是银两
--	[5] = 10000,  -- 纪念奖
--};

Lottery.BASE_BIND_COIN = 0; -- 基础奖励
Lottery.FIRST_LOTTERY_DATE = 20120224; -- Bắt đầu event
Lottery.LAST_LOTTERY_DATE = 20121220; -- ngày cuối cùng sổ xố
Lottery.LAST_AWARD_DATE = 20121221; -- ngày cuối cùng nhận giải
Lottery.AWARD_KEEP_DAY = 3; -- 数据保留3天

Lottery.tbAwardName = {[1] = "Giải Nhất", [2] = "Giải Nhì"};
Lottery.tbGoldAward = { -- Phần Thưởng Du Long Lệnh Vé
	[1] ={18,1,529,4},  -- yên đái lệnh
	[2] ={18,1,529,1},  -- hộ thân phù
	[3] ={18,1,529,3},  -- áo danh vọng
	[4] ={18,1,529,2},  -- Nón danh vọng
	[5] ={18,1,529,5},  -- Giầy
	[6] ={18,1,529,4},  -- Yên đái
	[7] ={18,1,529,1},  -- hộ thân phù
	};
	
Lottery.tbSilverAward = {18,1,553,1}; -- Tiền Du Long
Lottery.nSilverCount  = 500;

--Lottery.PERCENT_FOURTH = 0.1; -- 四等奖百分比
Lottery.RANK_MIN = 51;
Lottery.RANK_MAX = 5000;

--Lottery.RANK_MIN = 2;

Lottery.szNo1Name = "";

Lottery.MSG_NOTIFY = "Rút thăm trúng thưởng ngày hôm nay %s phút sau sẽ mở，giải thưởng quý may mắn đang chờ bạn !!";

function Lottery:CheckCanUseRank()
	local nSec = KGblTask.SCGetDbTaskInt(DBTASD_SERVER_STARTTIME)
	if GetTime() - nSec < 7*24*3600 then
		return 0;
	end
	return 1;
end

-- 玩家使用奖券
function Lottery:UseTicket(szName, nId)
	if not MODULE_GC_SERVER then
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			pPlayer.AddWaitGetItemNum(1);
			GCExcute({"Lottery:UseTicket", szName, nId});
		end
	else
		if not self.tbLottery[szName] then
			self.tbLottery[szName] = 1;
		else
			self.tbLottery[szName] = self.tbLottery[szName] + 1;
		end
		
		local nLastPorcessDate = KGblTask.SCGetDbTaskInt(DBTASK_LOTTERY_DATE);
		local nTime = GetTime();
		local nToday = tonumber(os.date("%Y%m%d", nTime));
		if nLastPorcessDate == nToday then -- Sổ xố đã đưa ra ngày hôm nay
			nTime = nTime + 24*60*60; -- Tính tới một ngày 
		end
		local nTimeOut = 1;
		if nLastPorcessDate < self.LAST_LOTTERY_DATE then
			nTimeOut =0;
			Dbg:WriteLog(string.format("Lottery:UseTicket, %s %s", szName, os.date("%Y%m%d", nTime)));
		end
		
		GlobalExcute({"Lottery:UseTicketNotify", nId, nTime, nTimeOut});	
	end
end

function Lottery:UseTicketNotify(nId, nTime, nTimeOut)
	local pPlayer = KPlayer.GetPlayerObjById(nId);
	if pPlayer then
		pPlayer.AddWaitGetItemNum(-1);
		if nTimeOut == 1 then
			pPlayer.Msg(string.format("Rút thăm trúng thưởng đã kết thúc cảm ơn bạn tham gia."));
			return 0;
		end
		local szDate = os.date("ngày %d tháng %m năm %Y", nTime);
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Rút thăm trúng thưởng: người chơi sử dụng vé sổ xố vào " .. szDate .. ".");
		pPlayer.Msg(string.format("Bạn sử dụng vé thưởng vào %s đã được ghi vào danh sách，bạn đợi hệ thống kết thúc và công bố giải thưởng", szDate));
	end
end

-- 每天更新数据
function Lottery:UpdateData()
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	if nDate < self.FIRST_LOTTERY_DATE or nDate > self.LAST_LOTTERY_DATE then
		return;
	end
	
	self:RemoveOldAwardTable();
	self:GenerateNewAwardTable();
	KGblTask.SCSetDbTaskInt(DBTASK_LOTTERY_DATE, nDate);
	self.tbGoldPlayerName[nDate] = self.szNo1Name;
	self:SaveTable();
	
	self:SendMail(nDate);
	self:UpdateHelpSprite(nDate);
	if self.szNo1Name ~= "" then
		local szMsg = string.format("%s rút thăm trúng thưởng may mắn nhận được Giải Nhất", self.szNo1Name);
		GlobalExcute({"Lottery:AnnouceNo1", szMsg});
	end
end

-- 开奖前发公告
function Lottery:LotteryNotify()
	local nDate = tonumber(os.date("%Y%m%d",GetTime()));
	if nDate < self.FIRST_LOTTERY_DATE or nDate > self.LAST_LOTTERY_DATE then
		return 0;
	end
	GlobalExcute({"Lottery:AnnouceNo1", string.format(self.MSG_NOTIFY, 60 - tonumber(GetLocalDate("%M")))});
end

function Lottery:AnnouceNo1(szMsg)
	KDialog.NewsMsg(1, Env.NEWSMSG_NORMAL, szMsg);
end

-- 删除过期的结果
function Lottery:RemoveOldAwardTable()
	local nDate = GetTime() - self.AWARD_KEEP_DAY*24*60*60;
	nDate = tonumber(os.date("%Y%m%d", nDate));
	self:__RemoveOldAwardTable(nDate);
	GlobalExcute({"Lottery:__RemoveOldAwardTable", nDate});
end

function Lottery:__RemoveOldAwardTable(nCurDate)
	if self.tbAward then
		for nDate in pairs(self.tbAward) do
			if nDate <= nCurDate then
				self.tbAward[nDate] = nil;
			end
		end
	end
end

-- 抽奖
function Lottery:GenerateNewAwardTable()
	local tbFlat = {}; -- ipairs 确保遍历顺序不会改变
	local tbName = {};		
	local tbFilterName = {}; -- 不能抽金Giải Nhì的玩家
	local tbAwardGold = {};	--能抽奖金的玩家
	local tbAwardGoldEx = {}; --Giải Nhất对应到tbFlag中的
	local nFilter = 0;       -- 不能抽金Giải Nhì的卡片数
	for szName, nNum in pairs(Lottery.tbLottery) do
		local nRank = PlayerHonor:GetPlayerHonorRankByName(szName, PlayerHonor.HONOR_CLASS_MONEY, 0);
		if (self:CheckCanUseRank() == 0) or (nRank >= Lottery.RANK_MIN and nRank<= Lottery.RANK_MAX) then	
			table.insert(tbName, szName);
			for i = 1, nNum do
				table.insert(tbFlat, #tbName); -- szName索引
				if self:CheckGlodAward(szName) == 0 then		--检测是不是活动期间中过Giải Nhất
					table.insert(tbAwardGold, #tbName);		
					table.insert(tbAwardGoldEx,#tbFlat);			
				end
			end					
		else
			tbFilterName[szName] = nNum;
			nFilter = nFilter + nNum;
		end
	end	
	local nCandidateLenth = #tbFlat;
	local nLotteryNum = nCandidateLenth + nFilter;
	local tbAwardNum = {
		[1] = 1  ,
		[2] = 2 ,
--		[3] = 100,
--      [4] = math.max(1, math.ceil((nLotteryNum - 111) * self.PERCENT_FOURTH)),        
	};
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	self.tbAward[nDate] = {};
	self.szNo1Name = "";
	local nSafe = 0;	--安全线,超过10000后不WriteLog,防止宕机
	for nAward, nAwardNum in ipairs(tbAwardNum) do
		 nCandidateLenth = #tbFlat;
		for i = 1, nAwardNum do  
			if nAward == 1 then
				nCandidateLenth = #tbAwardGold;
			end
			if nCandidateLenth > 0 then
				local nRand = MathRandom(1,nCandidateLenth);
				local szName = "";
				if nAward ~= 1 then
					local nNameIdx = tbFlat[nRand];
					szName = tbName[nNameIdx];
					self:__AddAwardEntry(szName, nAward, 1, nDate);
					GlobalExcute({"Lottery:__AddAwardEntry", szName, nAward, 1, nDate});
					tbFlat[nRand] = tbFlat[nCandidateLenth];
					table.remove(tbFlat); 
					nCandidateLenth = nCandidateLenth - 1;
				else
					local nNameIdx = tbAwardGold[nRand];
					szName = tbName[nNameIdx];
					self:__AddAwardEntry(szName, nAward, 1, nDate);
					GlobalExcute({"Lottery:__AddAwardEntry", szName, nAward, 1, nDate});
					tbFlat[tbAwardGoldEx[nRand]] = tbFlat[#tbFlat];
					table.remove(tbFlat); 
					self.szNo1Name = szName;
				end	
				nSafe = nSafe + 1;
				if nSafe < 10000 then
					Dbg:WriteLog(string.format("Lottery:Result, %s\t%s\t%s", szName, nAward, nDate));
				end
				if nSafe == 10000 then
					Dbg:WriteLog(string.format("Lottery:ResultIsOver, %s\t%s\t%s", szName, nAward, nDate));					
				end			
			end
		end
	end		
	self.tbLottery = {};
end

-- 把玩家加入获奖列表
-- nAward: 拿到什么奖
function Lottery:__AddAwardEntry(szName, nAward, nAwardNum, nDate)
	if not self.tbAward[nDate] then
		self.tbAward[nDate] = {};
	end
	if not self.tbAward[nDate][szName] then
		self.tbAward[nDate][szName] = {};
	end
	if not self.tbAward[nDate][szName][nAward] then
		self.tbAward[nDate][szName][nAward] = nAwardNum;
	else
		self.tbAward[nDate][szName][nAward] = self.tbAward[nDate][szName][nAward] + nAwardNum;
	end
end

-- 获取玩家奖励列表
-- nRes, var
--                  Giải Nhất几个  Giải Nhì几个  铜奖几个
--     [nDate] --> {[1] = xx, [2] = xx, [3] = xx} 
function Lottery:GetPlayerAwardList(pPlayer)
	local tbRes = {};
	local nLastProcessDate = KGblTask.SCGetDbTaskInt(DBTASK_LOTTERY_DATE);
	
	if not MODULE_GC_SERVER then
		if self:GSDataIsValid() == 0 then
			return 0, "Đang xử lý dữ liệu vui lòng chờ...";
		end
	end
	
	for nDate, tbAwardInDate in pairs(self.tbAward) do
		if nDate <= nLastProcessDate then -- 只取完整的数据
			tbRes[nDate] = {};
			if tbAwardInDate[pPlayer.szName] then
				local tb = {};
				for nAward, nAwardNum in pairs(tbAwardInDate[pPlayer.szName]) do
					tb[nAward] = nAwardNum;
				end
				tbRes[nDate] = tb;
			end
		end
	end
	
	local nRes = self:__HasAward(tbRes);
	if nRes == 0 then
		return 0, "Rút thăm trúng thưởng không có danh sách trúng thưởng."
	elseif nRes == 1 then
		return 0, "Bạn đã chiến thắng tất cả phần thưởng."
	end
	
	return 1, tbRes;
end


-- 0 无奖励
-- 1 领完了
-- 2 还可以领
function Lottery:__HasAward(tbRes)
	local hasAward = 0; -- 有奖励
	local hasBeenAward = 0; -- 有奖励，可能已经领过
	
	for nDate, tbAwardInDate in pairs(tbRes) do
		for nAward, nAwardNum in pairs(tbAwardInDate) do
			hasBeenAward = 1;
			if nAwardNum > 0 then
				hasAward = 1;
			end
		end
	end
	
	if hasAward == 1 then
		return 2;
	else
		if hasBeenAward == 1 then
			return 1;
		else
			return 0;
		end
	end
end

-- 领奖
-- nDate: 开奖日期
-- nAward: 获得那种奖励
-- nAwardNum: 领几个奖，例如一人一次领两个Giải Nhì
function Lottery:GetAward(pPlayer, nDate, nAward, nAwardNum)
	--print("GetAward")
	if MODULE_GC_SERVER then
		return;
	end
	
	nDate = tonumber(nDate);
	nAward = tonumber(nAward);
	nAwardNum = tonumber(nAwardNum);
	if self.tbAward[nDate][pPlayer.szName][nAward] >= nAwardNum then
		if pPlayer.CountFreeBagCell() < 1 then
			Dialog:Say(string.format("Không gian túi của bạn không đủ cần %s ô trống trong hành trang", nAwardNum));
			return 0;
		end
		
		pPlayer.AddWaitGetItemNum(1);
		local pItem = nil;
		if nAward == 1 then   -- Giải Nhất
			local nGoldItem = nil;
			if nDate >= 20100301 then
				nGoldItem = nDate - 20100301 + 6;
			else
				nGoldItem = nDate - self.FIRST_LOTTERY_DATE + 1;
			end
			pItem = pPlayer.AddItem(unpack(self.tbGoldAward[nGoldItem]));
			if pItem then
				pItem.Bind(1);
				local nSec = GetTime() + 30 * 24 * 3600;
				pItem.SetTimeOut(0,nSec);
				pItem.Sync();
			end
		else
			pPlayer.AddStackItem(self.tbSilverAward[1],self.tbSilverAward[2],self.tbSilverAward[3],self.tbSilverAward[4],nil,nAwardNum * self.nSilverCount);	
		end
			
		self:__GetAward(pPlayer.nId, pPlayer.szName, nDate, nAward);
		GlobalExcute({"Lottery:__GetAward", pPlayer.nId, pPlayer.szName, nDate, nAward});
		GCExcute({"Lottery:__GetAward", pPlayer.nId, pPlayer.szName, nDate, nAward});
		
		local szLog = string.format("Người chơi: %s, %d nhận được %d các giải thưởng khác %d", pPlayer.szName, nDate, nAward, nAwardNum);
		Dbg:WriteLog("Lottery:GetAward", szLog);
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Rút thăm may mắn:" .. szLog);
		
		local szMsg = string.format("Rút thăm may mắn nhận được %d %s", nAwardNum, self.tbAwardName[nAward]);
		Player:SendMsgToKinOrTong(pPlayer, szMsg, 1);
		Player:SendMsgToKinOrTong(pPlayer, szMsg, 1);
		pPlayer.SendMsgToFriend("Hảo hữu của bạn " .. pPlayer.szName .. szMsg);
	end
end

function Lottery:__GetAward(nId, szName, nDate, nAward)
	if self.tbAward[nDate][szName][nAward] == 0 then
		return;
	end
	
	if not MODULE_GC_SERVER then
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			pPlayer.AddWaitGetItemNum(-1);
		end
	end
	
	self.tbAward[nDate][szName][nAward] = 0;
end

function Lottery:__date_2_zh(nDate)
	local nTime = Lib:GetDate2Time(nDate);
	return string.format("ngày %d ngày %d", tonumber(os.date("%m", nTime)), tonumber(os.date("%d", nTime)));
end


function Lottery:SendMail(nDate)
	local tbName = {};
	if self.tbAward[nDate] then
		for szName, _ in pairs(self.tbAward[nDate]) do
			table.insert(tbName, szName);
		end
	end
	local szTitle = "Xin Chúc Mừng !!";
	local szContent  = string.format("Rút tham ngày %s bạn đã trúng thưởng vì vậy nhanh chóng nhận thưởng nếu không phần thưởng của bạn sẽ biến mất.", 
		self:__date_2_zh(nDate));
	Mail.tbParticularMail:SendMail(tbName, {szTitle = szTitle, szContent = szContent});
	return;
end

-- 用于是否显示领奖选项
function Lottery:CheckLotteryOpen()
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	local nSec = Lib:GetDate2Time(self.LAST_LOTTERY_DATE) + self.AWARD_KEEP_DAY*24*3600;
	local nEndDate = tonumber(os.date("%Y%m%d", nSec));
	if nDate >= self.FIRST_LOTTERY_DATE and nDate <= nEndDate then
		return 1;
	else
		return 0;
	end
end

local function OnSort(tbA, tbB)
	return tbA[2] > tbB[2];
end

function Lottery:__gen_help_sprite(nDate)
	local szMsg	= [[
<color=red>Giải Nhất：<color>
       Hôm Nay Giải Nhất Người Chơi ：<color=gold>%s<color>
       Lịch Sử Giải Nhất Người Chơi：
%s

<color=green>Giải Nhì：<color>
       Hôm Nay Giải Nhì Người Chơi:<color=yellow>
       %s
      <color>
	]];
	
	local nLastProcessDate = KGblTask.SCGetDbTaskInt(DBTASK_LOTTERY_DATE);
	local tbNo2Player = {};
	
	for szName, tbPlayerAward in pairs(self.tbAward[nLastProcessDate]) do
		for nAward, nAwardNum in pairs(tbPlayerAward) do
			if nAward == 2 and nAwardNum > 0 then
				table.insert(tbNo2Player, szName);
			end
		end
	end
	local szGoldPlayerName = self.tbGoldPlayerName[nDate] or "<color=gary>Giải Nhất Kết Thúc<color>";
	if szGoldPlayerName == "" then
		szGoldPlayerName = "<color=gray>Giải Nhất Kết Thúc<color>";
	end
	local szGoldPlayer = string.format("%s（%s）", szGoldPlayerName, self:__date_2_zh(nDate) or "");
	local tbGoldPlayerHistory = {};
	for nDate, szName in pairs(self.tbGoldPlayerName) do
		local szGName = szName or "";
		if szGName == "" then
			szGName = "<color=gray>Giải Nhất Kết Thúc<color>";
		end
		table.insert(tbGoldPlayerHistory, {szGName, nDate});
	end
	local szGoldPlayerHistory = "";
	table.sort(tbGoldPlayerHistory, OnSort);
	for _, tbInfo in ipairs(tbGoldPlayerHistory) do
		szGoldPlayerHistory = szGoldPlayerHistory .. string.format("       %s：%s\n", self:__date_2_zh(tbInfo[2]), tbInfo[1])
	end

	if szGoldPlayerHistory == "" then
		szGoldPlayerHistory = "       không";
	end
	
	local i = 0;
	local tbSilverPlayer = {};
	local szSilverPlayer = "";
	for _, szPlayerName in ipairs(tbNo2Player) do
		table.insert(tbSilverPlayer, szPlayerName);
		i = i + 1;
		if i == 3 then
			i = 0;
			szSilverPlayer = szSilverPlayer .. table.concat(tbSilverPlayer, "    ") .. "\n       ";
			tbSilverPlayer = {};
		end
	end
	
	szSilverPlayer = szSilverPlayer .. table.concat(tbSilverPlayer, "    ");
	szMsg = string.format(szMsg, szGoldPlayer, szGoldPlayerHistory, szSilverPlayer);
	return szMsg;
end

function Lottery:UpdateHelpSprite(nDate)
	local szTitle = "Rút thăm may mắn không tìm ra được người lãnh giải thưởng của danh sách.";
	local szMsg = self:__gen_help_sprite(nDate);
	local nAddTime	= GetTime();
	local nEndTime	= nAddTime + 3600 * 24 * 3;
	Task.tbHelp:SetDynamicNews(Task.tbHelp.NEWSKEYID.NEWS_LOTTERY_0908, szTitle, szMsg, nEndTime, nAddTime);
end

-- 显示获奖情况
function Lottery:__debug_show_award()
	local szMsg = "";
	for nDate, tbAwardInDate in pairs(self.tbAward) do
		szMsg = szMsg .. nDate .. "\n"
		for szName, tbPlayerAward in pairs(tbAwardInDate) do
			local n1 =  tbPlayerAward[1] or 0;
			local n2 =  tbPlayerAward[2] or 0;
			local n3 =  tbPlayerAward[3] or 0;
			szMsg = szMsg .. szName .. " 1:" .. n1 .. " 2:" .. n2 .. " 3:" .. n3 .. "\n";
		end
	end
	if string.len(szMsg) == 0 then
		szMsg = "Không có danh sách."
	end
	me.Msg(szMsg);
end

-- 显示奖券使用情况
function Lottery:__debug_show_ticket(var1, var2)
	if not MODULE_GC_SERVER then
		if not var1 then
			GCExcute({"Lottery:__debug_show_ticket", me.nId});
		else
			local pPlayer = KPlayer.GetPlayerObjById(var1);
			if pPlayer then
				pPlayer.Msg(var2);
			end
		end
	else
		local szMsg = "";
		for szName, nNum in pairs(self.tbLottery) do
			szMsg = szMsg .. szName .. ":" .. nNum .. "\n";
		end
		if string.len(szMsg) == 0 then
			szMsg = "Không có ai để nhận phần thưởng."
		end
		GlobalExcute({"Lottery:__debug_show_ticket", var1, szMsg});
	end
end

function Lottery:__debug_clear_record()
	if not MODULE_GC_SERVER then
		self.tbAward = {};
		GCExcute({"Lottery:__debug_clear_record"});
	else
		for nBufId, szTblName in pairs(self.tbBufId2TblName) do
			self[szTblName] = {};
		end
		self:SaveTable();
	end
end

function Lottery:__debug_load_lottery_record(szPath)
	self.tbLottery = {};
	local tbData = Lib:LoadTabFile(szPath);
	for i = 2, #tbData do
		local szName = assert(tbData[i]["name"]);
		local nNum = assert(tbData[i]["num"]);
		nNum = tonumber(nNum);
		self.tbLottery[szName] = nNum;
	end
end

function Lottery:CheckGlodAward(szName)
	local nCount = self.LAST_LOTTERY_DATE - self.FIRST_LOTTERY_DATE;
	for  i = 1,  nCount do
		if self.tbGoldPlayerName[self.FIRST_LOTTERY_DATE + i -1] and self.tbGoldPlayerName[self.FIRST_LOTTERY_DATE + i -1] == szName then		
			return 1;
		end
	end
	return 0;
end
