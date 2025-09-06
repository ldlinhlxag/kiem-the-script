--官府通緝任務
--孫多良
--2008.08.05
Require("\\script\\task\\wanted\\wanted_def.lua");

--測試使用,完成任務
function Wanted:_Test_FinishTask()
	if Task:GetPlayerTask(me).tbTasks[Wanted.TASK_MAIN_ID] then
		for _, tbCurTag in ipairs(Task:GetPlayerTask(me).tbTasks[Wanted.TASK_MAIN_ID].tbCurTags) do
			if (tbCurTag.OnKillNpc) then
				if (tbCurTag:IsDone()) then
					--殺死Boss玩家的隊友身上有任務完成時調用	
					if me.GetTask(Wanted.TASK_GROUP, Wanted.TASK_FINISH) == 1 then
						me.SetTask(Wanted.TASK_GROUP, Wanted.TASK_FINISH, 0);
					end
					break;
				end;
				tbCurTag.nCount	= tbCurTag.nCount + 1;		
				local tbSaveTask	= tbCurTag.tbSaveTask;
				if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
					tbCurTag.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, tbCurTag.nCount, 1);
					KTask.SendRefresh(tbCurTag.me, tbCurTag.tbTask.nTaskId, tbCurTag.tbTask.nReferId, tbSaveTask.nGroupId);
				end;
								
				if (tbCurTag:IsDone()) then	-- 本目標是一旦達成後不會失效的
					tbCurTag.me.Msg("Số hải tặc còn: "..tbCurTag:GetStaticDesc());
					tbCurTag.tbTask:OnFinishOneTag();
				end;
				
				--殺死Boss玩家的隊友身上有任務完成時調用				
				if me.GetTask(Wanted.TASK_GROUP, Wanted.TASK_FINISH) == 1 then
					me.SetTask(Wanted.TASK_GROUP, Wanted.TASK_FINISH, 0);
				end
			end
		end;
	end
end

function Wanted:GetLevelGroup(nLevel)
	if nLevel < self.LIMIT_LEVEL then
		return 0;
	end
	local nMax = 0;
	for ni, nLevelSeg in ipairs(self.LevelGroup) do
		if nLevel <= nLevelSeg then
			return ni;
		end
		nMax = ni;
	end
	return nMax;
end

function Wanted:GetTask(nTaskId)
	return me.GetTask(self.TASK_GROUP, nTaskId);
end

function Wanted:SetTask(nTaskId, nValue)
	return me.DirectSetTask(self.TASK_GROUP, nTaskId, nValue);
end

function Wanted:Check_Task()
	if me.nLevel < self.LIMIT_LEVEL then
		return 3;
	end
	if self:GetTask(self.TASK_FIRST) == 0 then
		if self:GetTask(self.TASK_COUNT) == 0 then
			self:SetTask(self.TASK_COUNT, self.Day_COUNT);
		end
		self:SetTask(self.TASK_FIRST, 1);
	end
	--if self:GetTask(self.TASK_ACCEPT_ID) <= 0 then
	--	return 0;
	--end
	local tbTask = Task:GetPlayerTask(me).tbTasks[self.TASK_MAIN_ID];
	if not tbTask then
		--self:SetTask(self.TASK_ACCEPT_ID, 0);
		return 0;	--未接任務
	end
	
	if self:CheckTaskFinish() == 1 then
		return 1;	--已完成
	else
		return 2;	--未完成
	end
	return 0;
end

function Wanted:CheckLimitTask()
	--if me.GetTask(1022,107) ~= 1 then
	--	Dialog:Say("Bổ đầu hình bộ: Hảo hán, bạn phải hoàn thành 50 nhiệm vụ chính tuyến bạn mới có thể chứng minh bạn có khả năng tham gia nhiệm vụ.");
	--	return 0;
	--end
	
	--江湖威望判斷
	if (me.nPrestige < self.LIMIT_REPUTE) then
		local szFailDesc = "Uy danh giang hồ của bạn chưa đủ 20 điểm, không thể nhận nhiệm vụ này.";
		Dialog:Say(szFailDesc);
		return 0;
	end
	
	local nType = self:GetLevelGroup(me.nLevel);
	if nType <= 0 then
		Dialog:Say("Bổ đầu hình bộ : Hảo Hán, hãy tìm hắn ta ở các nơi hắn hay đến. ");
		return 0;
	end
	if self:GetTask(self.TASK_COUNT) <= 0 then
		Dialog:Say("Bổ đầu hình bộ: Đã hết số lần nhiệm vụ trong ngày, vui lòng quay lại vào ngày mai.")
		return 0;
	end
	return 1;	
end

-- 檢測任務除了交物品任務之外還有沒有未完成的目標
function Wanted:CheckTaskFinish()
	local tbTask	 	= Task:GetPlayerTask(me).tbTasks[self.TASK_MAIN_ID];
	
	-- 還有未完成的目標
	for _, tbCurTag in pairs(tbTask.tbCurTags) do
		if (not tbCurTag:IsDone()) then
			return 0;
		end;
	end;
	
	-- 全部目標完成
	return 1;
end;

function Wanted:SingleAcceptTask()
	if self:Check_Task() ~= 0 then
		return 0;
	end
	if self:CheckLimitTask() ~= 1 then
		return 0;
	end
	local nType = self:GetLevelGroup(me.nLevel);
	local tbOpt = {};
	for i=1, nType do 
		table.insert(tbOpt, {string.format("Nhiệm vụ cấp: %s",40+i*10), self.GetRandomTask, self, i});
	end
	table.insert(tbOpt, {"Để ta suy nghĩ lại"});
	Dialog:Say("Lựa chọn nhiệm vụ phù hợp với đẳng cấp của mình có thể nhận được nhiều phần thưởng hơn.", tbOpt);
end

function Wanted:GetRandomTask(nLevelSeg)
	if self:CheckLimitTask() ~= 1 then
		return 0;
	end	
	if self.TaskLevelSeg[nLevelSeg] then
		local nP = Random(#self.TaskLevelSeg[nLevelSeg]) + 1;
		local nTaskId = self.TaskLevelSeg[nLevelSeg][nP];
		self:AcceptTask(nTaskId, nLevelSeg);
		return nTaskId;
	end
end

function Wanted:AcceptTask(nTaskId, nLevelSeg)
	if self:Check_Task() ~= 0 then
		return 0;
	end
	if self:CheckLimitTask() ~= 1 then
		return 0;
	end
	Task:DoAccept(self.TASK_MAIN_ID, nTaskId);
	self:SetTask(self.TASK_ACCEPT_ID, nTaskId);
	self:SetTask(self.TASK_LEVELSEG, nLevelSeg);
	self:SetTask(self.TASK_FINISH, 1);
	self:SetTask(self.TASK_COUNT, self:GetTask(self.TASK_COUNT) -1);
	
	-- 記錄參加次數
	local nNum = me.GetTask(StatLog.StatTaskGroupId , 4) + 1;
	me.SetTask(StatLog.StatTaskGroupId , 4, nNum);
	
	-- 記錄玩家參加官府通緝的次數
	Stats.Activity:AddCount(me, Stats.TASK_COUNT_WANTED, 1);
end

function Wanted:CaptainAcceptTask()
	local tbTeamMembers, nMemberCount	= me.GetTeamMemberList();
	local tbPlayerName	 = {};
	if (not tbTeamMembers) then
		Dialog:Say("Bổ đầu hình bộ: Bạn không ở trong nhóm bất kỳ nào.");
		return;
	end
	if self:Check_Task() ~= 0 then
		return 0;
	end
	if self:CheckLimitTask() ~= 1 then
		return 0;
	end
	local nType = self:GetLevelGroup(me.nLevel);
	local tbOpt = {};
	for i=1, nType do 
		table.insert(tbOpt, {string.format("%s nhiệm vụ thứ ",40+i*10), self.TeamAcceptTask, self, i});
	end
	table.insert(tbOpt, {"Để ta suy nghĩ lại"});
	Dialog:Say("Bạn có thể lựa chọn nhiệm vụ cấp cao và khó khăn hơn.", tbOpt);
		
end

function Wanted:TeamAcceptTask(nLevelSeg, nFlag)
	local tbTeamMembers, nMemberCount	= me.GetTeamMemberList();
	local tbPlayerName	 = {};
	if (not tbTeamMembers) then
		Dialog:Say("Bổ đầu hình bộ: Bạn chưa có tổ đội!");
		return;
	end
	local nTeamTaskId = 0;
	if nFlag == 1 then
		nTeamTaskId = self:GetRandomTask(nLevelSeg);
	end
	local pOldMe = me;
	local nOldIndex	= me.nPlayerIndex
	local nCaptainLevel	= me.nLevel;	-- 隊長的等級
	local szCaptainName =  me.szName;	-- 隊長的名字
	
	for i=1, nMemberCount do
		if (nOldIndex ~= tbTeamMembers[i].nPlayerIndex) then
			
			me = tbTeamMembers[i];
			if self:Check_Task() == 0 and self:CheckLimitTask() == 1 and self:GetLevelGroup(me.nLevel) >= nLevelSeg then
					if nFlag == 1 and nTeamTaskId > 0 then
						local szMsg = string.format("Bổ đầu hình bộ: Bạn đã trở thành đội trưởng<color=yellow>%s<color>Bạn muốn chia sẻ nhiệm vụ cùng người khác: %s Nhiệm vụ thứ - <color=green>theo dõi các tên Hải tặc%s<color>,bạn có chấp nhận làm nhiệm vụ? ", szCaptainName, (40 + nLevelSeg*10),self.TaskFile[nTeamTaskId].szTaskName);
						local tbOpt = 
						{
							{"Đồng ý", self.AcceptTask, self, nTeamTaskId, nLevelSeg},
							{"Không"},
						}
						Dialog:Say(szMsg, tbOpt);
					else
						table.insert(tbPlayerName, {tbTeamMembers[i].nPlayerIndex, tbTeamMembers[i].szName});
					end
			end;
		end;
	end;
	me = pOldMe;
	
	if nFlag == 1 then
		return
	end
	
	if #tbPlayerName <= 0 then
		Dialog:Say("Bổ đầu hình bộ: không có nhóm chia sẽ nhiệm vụ với bạn, đội hình chia sẻ phải đảm bảo những điều kiện sau: <color=yellow>\n\n   nhóm phù hợp với mức độ khó và phụ thuộc nhóm trưởng\n    Nhiệm vụ đã bỏ lỡ, muốn hủy nhiệm vụ\n    Giới hạn nhiệm vụ đã đạt mức tối đa\n    Phạm vi gần đội trưởng\n    Nhóm đã hoàn thành 50 nhiệm vụ chính tuyến\n    Nhóm đủ 20 uy danh giang hồ<color>\n");
		return;
	end;
	
	local szMembersName	= "\n";
	
	for i=1, #tbPlayerName do
		szMembersName = szMembersName.."<color=yellow>"..tbPlayerName[i][2].."<color>\n";
	end;
	local szMsg = string.format("Bổ đầu hình bộ: nhiệm vụ phù hợp có thể chia sẻ với đồng đội của bạn: \n%s\n bạn có đồng ý chia sẻ?", szMembersName);
	local tbOpt = 
	{
		{"Vâng,tôi đồng ý", self.TeamAcceptTask, self, nLevelSeg, 1},
		{"Không,cám ơn"},
	}
	Dialog:Say(szMsg, tbOpt);	
end

function Wanted:CancelTask(nFlag)
	if self:Check_Task() ~= 2 then
		return 0;
	end
	if nFlag == 1 then
		self:SetTask(self.TASK_ACCEPT_ID, 0);
		self:SetTask(self.TASK_FINISH, 0);
		Task:CloseTask(self.TASK_MAIN_ID, "giveup");
		return;
	end
	local szMsg = "Bổ đầu hình bộ: bạn có thể chọn các nhiệm vụ mong muốn? bạn có thể bỏ?";
	local tbOpt = {
		{"Tôi muốn hủy bỏ", self.CancelTask, self, 1},
		{"Để ta suy nghĩ lại"}
	}
	Dialog:Say(szMsg, tbOpt);
	return;
end

function Wanted:FinishTask()
	if self:Check_Task() ~= 1 then
		return 0;
	end	
	self:ShowAwardDialog()	
end

-- 師徒成就：官府通緝
function Wanted:GetAchievement(pPlayer)
	if (not pPlayer) then
		return;
	end
	
	-- nLevle的具體數值對應等級和配置文件"\\setting\\task\\wanted\\level_group.txt"相同
	local nLevel = self:GetTask(self.TASK_LEVELSEG);
	local nAchievementId = 0;
	if (1 == nLevel) then
		nAchievementId = Achievement.TONGJI_55;
	elseif (2 == nLevel) then
		nAchievementId = Achievement.TONGJI_65;
	elseif (3 == nLevel) then
		nAchievementId = Achievement.TONGJI_75;
	elseif (4 == nLevel) then
		nAchievementId = Achievement.TONGJI_85;
	elseif (5 == nLevel) then
		nAchievementId = Achievement.TONGJI_95;
	end
	
	Achievement:FinishAchievement(pPlayer.nId, nAchievementId);
end

function Wanted:AwardFinish()
	if self:Check_Task() ~= 1 then
		return 0;
	end
	self:SetTask(self.TASK_LEVELSEG, 0);
	self:SetTask(self.TASK_ACCEPT_ID, 0);
	self:SetTask(self.TASK_FINISH, 0);
	me.AddOfferEntry(10, WeeklyTask.GETOFFER_TYPE_WANTED);
	
	-- 增加幫會建設資金和相應族長、個人的股份	
	local nStockBaseCount = 6; -- 股份基數			
	Tong:AddStockBaseCount_GS1(me.nId, nStockBaseCount, 0.8, 0.15, 0.05, 0, 0, WeeklyTask.GETOFFER_TYPE_WANTED);
	
	if (me.GetTrainingTeacher()) then	-- 如果玩家的身份是徒弟，那麼師徒任務當中的通緝任務次數加1
		-- local tbItem = Item:GetClass("teacher2student");
		local nNeed_Wanted = me.GetTask(Relation.TASK_GROUP, Relation.TASK_ID_SHITU_WANTED) + 1;
		me.SetTask(Relation.TASK_GROUP, Relation.TASK_ID_SHITU_WANTED, nNeed_Wanted);
	end
	Task:CloseTask(self.TASK_MAIN_ID, "finish");
	
	--額外獎勵
	local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("FinishWanted", me);
	SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
	SpecialEvent.ActiveGift:AddCounts(me, 15);
	-- 師徒成就：官府通緝
	self:GetAchievement(me);
end

-- 根據選取出來的獎勵表構成獎勵面版
function Wanted:ShowAwardDialog()
	local tbGeneralAward = {};  -- 最後傳到獎勵面版腳本的數據結構
	local szAwardTalk	= "Hải tặc đã bị tiêu diệt,đã mang lại nền hòa bình. Nhưng gần đây đã xuất hiện thêm 1 số cường đạo đã xáo động đời sống của bá tánh.Vì vậy, nha môn ban hành bắt những tên đó.Bạn đã hoàn thành tốt và chia sẻ cùng đồng đội.";	-- 獎勵時說的話

	tbGeneralAward.tbFix	= {};
	tbGeneralAward.tbOpt = {};
	tbGeneralAward.tbRandom = {};
	local nNum = self.AWARD_LIST[self:GetTask(self.TASK_LEVELSEG)]
	local nFreeCount = SpecialEvent.ExtendAward:DoCheck("FinishWanted");
	if me.CountFreeBagCell() < (1 + nFreeCount) then
		Dialog:Say(string.format("Khoảng trống của túi không đủ. Kết thúc %s để dọn túi", (1 + nFreeCount)));
		return 1;
	end
	table.insert(tbGeneralAward.tbFix,
				{
					szType="item", 
					varValue={self.ITEM_MINGBULING[1],self.ITEM_MINGBULING[2],self.ITEM_MINGBULING[3],self.ITEM_MINGBULING[4]}, 
					nSprIdx="",
					szDesc="Truy bắt", 
					szAddParam1=nNum
				}
			);
	GeneralAward:SendAskAward(szAwardTalk, 
							  tbGeneralAward, {"Wanted:AwardFinish", Wanted.AwardFinish} );
end;

function Wanted:Day_SetTask(nDay)
	if me.nLevel < self.LIMIT_LEVEL then
		return 0;
	end
	local nCount = self.Day_COUNT * nDay;
	if self:GetTask(self.TASK_COUNT) + nCount > self.LIMIT_COUNT_MAX then
		nCount = self.LIMIT_COUNT_MAX - self:GetTask(self.TASK_COUNT);
	end
	self:SetTask(self.TASK_COUNT, self:GetTask(self.TASK_COUNT) + nCount);
	if self:GetTask(self.TASK_FIRST) == 0 then
		self:SetTask(self.TASK_FIRST, 1);
	end
end

PlayerSchemeEvent:RegisterGlobalDailyEvent({Wanted.Day_SetTask, Wanted});

