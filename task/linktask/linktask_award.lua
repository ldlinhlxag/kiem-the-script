
-- ====================== 文件信息 ======================

-- 劍俠世界門派任務獎勵處理文件
-- Edited by peres
-- 2007/05/14 PM 08:33

-- 在人群裡
-- 一對對年輕的情侶，彼此緊緊地糾纏在一起，旁若無人地接吻
-- 愛情如此美麗，似乎可以擁抱取暖到天明
-- 我們原可以就這樣過下去，閉起眼睛，抱住對方，不鬆手亦不需要分辨。

-- ======================================================

-- 初始化獎勵數據
function LinkTask:InitAward()
	
	print ("Start InitAward!");
	
	self.tbFile_AwardGroupRate	= Lib:NewClass(Lib.readTabFile, "\\setting\\task\\linktask\\award_grouprate.txt");
	self.tbFile_AwardItemRate	= Lib:NewClass(Lib.readTabFile, "\\setting\\task\\linktask\\award_itemrate.txt");

	-- 從表格裡讀出物品概率構造的 table
	self.tbAwardItemRate = {};
	
	self:_AssignItemRate(self.tbFile_AwardItemRate);
	
end;


-- 選擇三個類型的獎勵中，返回為一個有三個元素的 table
function LinkTask:SelectAwardType()
	local tbResult = {0,0,0};
	local tbNowRate = {};
	local nSelect = 0;
	
	-- 經驗、金錢、物品、取消機會
	tbNowRate = {[1]=30,[2]=30,[3]=29,[4]=10}
	
	-- 選三個類型的獎勵
	for i=1, 3 do
		nSelect = self:_CountAwardRate(tbNowRate, i);
		tbNowRate[nSelect] = 0;
		tbResult[i] = nSelect;
	end;
	
	return tbResult;
end;


function LinkTask:_CountAwardRate(tbRate, nBit)
	local nRow = #tbRate;
	local nRandom = 0;
	local nAdd = 0;
	local i=0;
	
	for i=1, nRow do
		nAdd = nAdd + tbRate[i];
	end;
	
	nRandom = self:GetRandomSeed(nBit);
	if nRandom <= 0 then
		nRandom = MathRandom(1, nAdd);
		self:SaveRandomSeed(nRandom, nBit);
	end
	
	nAdd = 0;
	
	for i=1, nRow do
		nAdd = nAdd + tbRate[i];
		if nAdd>=nRandom then
			return i;
		end;
	end;
	
	self:_Debug("CountAwardRate: error!");
	return 0;
end;


-- 獲取當前等級的生產率
function LinkTask:_CountLevelProductivity()
	local nPyValue = 0;
	local nLevelGroup = self:SelectLevelGroup();
	local nLevelGroupRow = self.tbfile_TaskLevelGroup:GetDateRow("LevelGroup", nLevelGroup);
	
		nPyValue = self.tbfile_TaskLevelGroup:GetCellInt("LevelPy", nLevelGroupRow);
		if nPyValue==0 or nPyValue==nil then
			self:_Debug("CountLevelProductivity: Get data error!");
			return 0;
		end;
		return nPyValue;
end;


-- 獲取當前等級的基准經驗
function LinkTask:_CountBasicExp()
	local nBasicExp = 0;
	local nLevelGroup = self:SelectLevelGroup();
	local nLevelGroupRow = self.tbfile_TaskLevelGroup:GetDateRow("LevelGroup", nLevelGroup);

		nBasicExp = self.tbfile_TaskLevelGroup:GetCellInt("BasicExp", nLevelGroupRow);
		if nBasicExp==0 or nBasicExp==nil then
			self:_Debug("CountBasicExp: Get data error!");
			return 0;
		end;
		return nBasicExp;		
end;



function LinkTask:_AssignItemRate(tbFile)
	local nRow = tbFile:GetRow();
	local nGroupId = 0;
	
	local nGenre, nDetail, nParticular, nLevel, nFive, nValue, nRate, nBind = 0,0,0,0,0,0,0,0;
	local szName = "";
	
	for i=1, nRow do
		nGroupId = tbFile:GetCellInt("Group", i);
		
		if self.tbAwardItemRate[nGroupId] == nil then
			self.tbAwardItemRate[nGroupId] = {};
		end;
		
		nGenre         = tbFile:GetCellInt("Genre", i);
		nDetail        = tbFile:GetCellInt("Detail", i);
		nParticular    = tbFile:GetCellInt("Particular", i);
		nLevel         = tbFile:GetCellInt("Level", i);
		nValue         = tbFile:GetCellInt("Value", i);
		nRate          = tbFile:GetCellInt("Rate", i);
		szName         = tbFile:GetCell("Name", i);
		nBind			= tbFile:GetCellInt("Bind", i);
					
		table.insert(self.tbAwardItemRate[nGroupId], 
			 {nRate,  nGenre, nDetail, nParticular, nLevel, nValue, szName, nBind});
	end;
end;


-- 計算獎勵的經驗，返回 Int
function LinkTask:CountAwardExp()
	self:_Debug("Start count exp award...");
	local nTaskValue1, nTaskValue2	= unpack(self:GetTaskValue());
	
	local nBasicExp = self:_CountBasicExp() * self:CountDouble();
	
	self:_Debug("Get award exp final: "..(nBasicExp * nTaskValue2 / 15000));
	return math.floor(nBasicExp * nTaskValue2 / 15000);
	
end;


-- 計算獎勵的金錢，返回 Int
function LinkTask:CountAwardMoney()
	self:_Debug("Start count money award...");
	local nTaskValue1, nTaskValue2	= unpack(self:GetTaskValue());
	
	local nPyValue = self:_CountLevelProductivity() * self:CountDouble();
	
	self:_Debug("Get award money final: "..(nTaskValue2 * nPyValue)  + nTaskValue1);
	
	return math.floor(nTaskValue2 * nPyValue) + nTaskValue1;
end;


-- 選取獎勵的物品，返回物品的名稱和物品的Id table
function LinkTask:CountAwardItem(nBit)
	self:_Debug("Start count item award...");
	
	local tbTaskValue = self:GetTaskValue();
	local nValue = tbTaskValue[2];                             -- 隻取第二個價值量
	local nPyValue = self:_CountLevelProductivity();           -- 得到當前等級的生產率
	
	-- 計算出最後的價值量
	nValue = nValue * nPyValue;
	
	self:_Debug("Get the task value: (pyValue / Value)"..nPyValue.." / "..nValue);
	
	-- 首先獲取物品組的行數
	local nGroupRow = self.tbFile_AwardGroupRate:GetDateRow("TaskValue", nValue);
	if nGroupRow == 0 then
		self:_Debug("CountAwardItem: Get GroupRow error!");
		return
	end;
	
	local tbGroupRate = {};
	local nRateNum = 0;
	
	-- 取出該價值量下 10 個組的概率
	for i=1, 10 do
		nRateNum = self.tbFile_AwardGroupRate:GetCellInt("Rate"..i, nGroupRow);
		table.insert(tbGroupRate, nRateNum);
	end;
	
	-- 最後得出屬於哪個組
	local nGroup = self:_CountAwardRate(tbGroupRate, nBit);
	
	local tbGroupItem = self.tbAwardItemRate[nGroup];
	
	local nRow = self:GetRandomSeed(nBit+3);
	if nRow <= 0 then
		nRow = Lib:CountRateTable(tbGroupItem, 1);
		self:SaveRandomSeed(nRow, nBit+3);
	end
	
	self:_Debug("Get award item final: "..tbGroupItem[nRow][7], tbGroupItem[nRow][2], tbGroupItem[nRow][3], tbGroupItem[nRow][4]);
		
		-- 返回：名字, tbItem, 是否綁定
		return tbGroupItem[nRow][7],
			   {tbGroupItem[nRow][2],
			    tbGroupItem[nRow][3],
			    tbGroupItem[nRow][4],
				tbGroupItem[nRow][5],0,0,0,nil,0,0, tbGroupItem[nRow][8]};
end;


-- 計算雙倍或者其它數值加乘
function LinkTask:CountDouble()
	return 1;
end;


-- 根據選取出來的獎勵表構成獎勵面版
function LinkTask:ShowAwardDialog(tbAward)
	local tbGeneralAward = {};  -- 最後傳到獎勵面版腳本的數據結構
	local nRepute = 0;
	local tbSelect = {{}, {}, {}};  -- 三個可選獎勵
	local nValue = 0;
	local tbItem, szItemName = {};
	
	local szAwardTalk	= "Hay lắm! Đây là phần thưởng dành cho ngươi";	-- 獎勵時說的話
		
	-- 每天的前 10 個任務獎勵一個物品
	local nDailyTaskNum		= self:GetTaskNum_PerDay();
	local nDailyAward		= self:GetTask(self.TSK_LINKAWARDDATE);		-- 判斷今天是否已經領過
	
	tbGeneralAward.tbFix	= {};
		
	if nDailyTaskNum == 9 and nDailyAward ~= tonumber(GetLocalDate("%Y%m%d")) then

		local nFixExp		= self:_CountBasicExp() * 0.5;				-- 10 次的Kinh nghiệm
		local nFixMoney		= math.floor(30000 * self:_CountLevelProductivity() / 2) * Task.IVER_nLinkTaskAward;	-- 10 次的額外金錢
		local nMakePoint, nGatherPoint = self:AwardJingHuo();			-- 10 次的額外精力, 10 次的額外活力
		
		table.insert(tbGeneralAward.tbFix,
				{szStatLogName="Nhiệm vụ Bao Vạn Đồng", szType="exp",varValue=nFixExp,nSprIdx=0,szDesc="Kinh nghiệm"}
			);
		
		-- 將老包所有的固定銀兩都改為綁銀 by peres 2009/02/16
		table.insert(tbGeneralAward.tbFix,
				{szStatLogName="Nhiệm vụ Bao Vạn Đồng",szType="bindmoney",varValue=nFixMoney * 1.5,nSprIdx=1,szDesc="額外銀兩"}
			);

		-- 去除額外給的精活 by peres 2009/06/11
--		table.insert(tbGeneralAward.tbFix,
--				{szType="makepoint",varValue=nMakePoint,nSprIdx=0,szDesc="額外精力"}
--			);
--		table.insert(tbGeneralAward.tbFix,
--				{szType="gatherpoint",varValue=nGatherPoint,nSprIdx=0,szDesc="額外活力"}
--			);
			
		local nTreaMapItemLevel		= 1;
		if me.nLevel >= 50 and me.nLevel <= 79 then
			nTreaMapItemLevel = 2;
		elseif me.nLevel >= 80 then
			nTreaMapItemLevel = 3;
		end;
		table.insert(tbGeneralAward.tbFix,
				{szStatLogName="Nhiệm vụ Bao Vạn Đồng", szType="item",varValue={18,1,9,nTreaMapItemLevel,0,0,0,nil,0,0},nSprIdx=0,szDesc="藏寶圖"}
			);			
			
		szAwardTalk = szAwardTalk.."\n\nTrong ngày bạn hoàn thành nhiệm vụ <color=green>10 lần<color> liên tiếp nên được nhận phần thưởng sau:";
		
	elseif nDailyTaskNum > 10 and math.fmod(nDailyTaskNum + 1, 10) == 0 then
		
		if self:GetTask(self.tbExMoneyAward[nDailyTaskNum + 1]) == 0 then
		
			local nFixMoney		= math.floor(5000 * self:_CountLevelProductivity() / 2) * Task.IVER_nLinkTaskAward;	-- 額外金錢	
			
			table.insert(tbGeneralAward.tbFix,
					{szStatLogName="Nhiệm vụ Bao Vạn Đồng", szType ="bindmoney",varValue=nFixMoney * 1.5,nSprIdx=1,szDesc="Bạc"}
				);

		end;
		
	end;
	
	local nTskTotalNum = self:GetTaskTotalNum_PerDay();
	
	-- 固定獎勵，義軍聲望	
	if (9 >= nTskTotalNum) then
		nRepute = 10;
	else
		nRepute = 3;
	end
	
	table.insert(tbGeneralAward.tbFix, {szType="linktask_repute",varValue={1,1,nRepute},nSprIdx=0,szDesc="Danh vọng nghĩa quân"..nRepute.." điểm"});		
	
	for i=1, 3 do
		if tbAward[i]==1 then        -- 經驗
			
			nValue = self:CountAwardExp();
			tbSelect[i] = {szStatLogName="Nhiệm vụ Bao Vạn Đồng", szType="exp",varValue=nValue,nSprIdx=0,szDesc="Kinh nghiệm "..nValue};
			
		elseif tbAward[i]==2 then    -- 銀兩
			
			nValue = self:CountAwardMoney();			
			tbSelect[i] = {szStatLogName="Nhiệm vụ Bao Vạn Đồng", szType="bindmoney",varValue=nValue,nSprIdx=0,szDesc="Bạc khóa "..nValue};
			
		elseif tbAward[i]==3 then    -- 物品
			
			szItemName, tbItem = self:CountAwardItem(i+3);
			tbSelect[i] = {szStatLogName="Nhiệm vụ Bao Vạn Đồng", szType="item",varValue=tbItem,nSprIdx=0,szDesc=szItemName};
			
		elseif tbAward[i]==4 then    -- 取消機會
			
			tbSelect[i] = {szStatLogName="Nhiệm vụ Bao Vạn Đồng", szType="linktask_cancel",varValue=10,nSprIdx=0,szDesc="1 cơ hội hủy"};
			
		end;
	end;
	
	tbGeneralAward.tbOpt = tbSelect;
	
	-- 暫時無隨機獎勵
	tbGeneralAward.tbRandom = {};
	
	GeneralAward:SendAskAward(szAwardTalk, 
							  tbGeneralAward, {"LinkTask:AwardFinish", LinkTask.AwardFinish} );

end;
