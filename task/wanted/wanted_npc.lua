--官府通缉任务
--孙多良
--2008.08.06
Require("\\script\\task\\wanted\\wanted_def.lua");

function Wanted:OnDialog()
	local nFlag = self:Check_Task();
	if nFlag == 1 then
		self:OnDialog_Finish()
	elseif nFlag == 2 then
		self:OnDialog_NoFinish()
	elseif nFlag == 3 then
		self:OnDialog_NoAccept()
	else
		self:OnDialog_Accept()
	end
end

function Wanted:OnDialog_Accept()
	local szMsg = string.format("Bổ Đầu Hình Bộ: Gần đây bọn Hải tặc luôn gây hại cho dân, ngươi có đồng ý giúp đỡ Nha Môn bắt giữ chúng để trừ hại cho dân?\n\n<color=yellow>Hôm nay ngươi còn %s lần<color>", self:GetTask(self.TASK_COUNT));
	local tbOpt = {
		{"Ta muốn truy bắt Hải Tặc", self.SingleAcceptTask, self},
		{"Danh Bổ Lệnh Đổi Lấy Vật Phẩm", self.OnGetAward, self},
		{"Để ta suy nghĩ đã"},
	}
	if me.IsCaptain() == 1 then
		table.insert(tbOpt, 1, {"Ta muốn cùng đồng đội truy bắt Hải Tặc", self.CaptainAcceptTask, self})
	end
	Dialog:Say(szMsg, tbOpt);
end

function Wanted:OnDialog_NoAccept()
	local szMsg = string.format("Bổ Đầu Hình Bộ: Gần đây bọn Hải tặc luôn gây hại cho dân, ngươi có đồng ý giúp đỡ Nha Môn bắt giữ chúng để trừ hại cho dân? Nhưng ta thấy ngươi vẫn chưa đủ thực lực, sau khi đạt cấp 50 hãy quay lại tìm ta.");
	local tbOpt = {
		{"Ta biết rồi"},
	}
	Dialog:Say(szMsg, tbOpt);
end

function Wanted:OnDialog_Finish()
	local nTask = Task:GetPlayerTask(me).tbTasks[self.TASK_MAIN_ID].nReferId;
	local szMsg = self:CreateText(nTask)
	local tbOpt = {
		{"Hoàn thành nhiệm vụ, đến nhận thưởng", self.FinishTask, self},
		{"Danh Bổ Lệnh Đổi Lấy Vật Phẩm", self.OnGetAward, self},
		{"Để ta suy nghĩ đã"},		
	}
	Dialog:Say(szMsg, tbOpt);
end

function Wanted:OnDialog_NoFinish()
	local nTask = Task:GetPlayerTask(me).tbTasks[self.TASK_MAIN_ID].nReferId;
	local szMsg = self:CreateText(nTask)
	local tbOpt = {
		{"Ta muốn hủy nhiệm vụ", self.CancelTask, self},
		{"Ta Muốn Đổi Danh Bổ Lệnh", self.OnGetAward, self},
		{"Để ta suy nghĩ đã"},	
	};
	Dialog:Say(szMsg, tbOpt);
end

function Wanted:CreateText(nTask)
	local szMsg = string.format("Tên nhiệm vụ: [<color=green>Truy bắt Hải Tặc %s<color>]\nMiêu tả nhiệm vụ: Nghe nói<color=green> Hải Tặc %s<color> gần đây xuất hiện tại <color=yellow>%s<color>, tọa độ <color=yellow>(%s,%s)<color>, ngươi phải truy bắt hắn về quy án, khôi phục an ninh nơi đó.",self.TaskFile[nTask].szTaskName, self.TaskFile[nTask].szTaskName, self.TaskFile[nTask].szMapName, math.floor(self.TaskFile[nTask].nPosX/8), math.floor(self.TaskFile[nTask].nPosY/16));
	return szMsg;	
end

function Wanted:OnGetAward()


	local szMsg = "Ở đây ta có đổi Lệnh Bài Mở Rộng Rương Và Phúc Duyên Từ Việc Truy Sát Hải Tặc.";
	local tbOpt = {
		{"Ta Muốn Đổi Phúc Duyên", self.OpenGiftAward, self,4},
		{"Để ta suy nghĩ đã"},	
	};

	
	for i=1,3 do
		table.insert(tbOpt, i, {string.format("Đổi %s",self.DATAITEMEVENT[i][3]), self.OpenGiftAward, self,i});
	end
	Dialog:Say(szMsg, tbOpt);
	
end

function Wanted:OpenGiftAward(nId)

	local nPlayerDBL = me.GetItemCountInBags(unpack(self.ITEM_MINGBULING));
	local szMsg = "";
	if nId > 3 then
		szMsg = string.format("Bạn Đang Có <color=gold>%s Danh Bổ Lệnh<color> muốn  đổi bao nhiu thì ta bấy nhiu <color=gold>1 Danh Bổ Lệnh<color> Tương Ứng <color=gold>1 Điểm Phúc Duyên<color>.",nPlayerDBL);	
		Dialog:OpenGift(szMsg, nil, {self.OnChangeBack, self});
	else
		szMsg = string.format("Cần Có %s Danh Bổ Lệnh để đổi %s.",self.DATAITEMEVENT[nId][2],self.DATAITEMEVENT[nId][3]);	
		Dialog:OpenGift(szMsg, nil, {self.OnChangeBackMRR, self,nId});	
	end
end

function Wanted:OnChangeBack(tbItem)
		
	local nExCount = 0;
	for _, tbItem in pairs(tbItem) do
		local pItem = tbItem[1];
		local szKey = string.format("%s,%s,%s,%s", pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel)
		
		if szKey == string.format("%s,%s,%s,%s", unpack(self.ITEM_MINGBULING)) then
			nExCount = nExCount + pItem.nCount;
		end
	end
	
	if nExCount <= 0 then
		Dialog:Say("Không đúng vật phẩm Danh Bổ Lệnh mà ta yêu cầu.");
		return 0;
	end
	
	local nExTempCount = 0;
	for _, tbItem in pairs(tbItem) do
		local pItem = tbItem[1];
		local szKey = string.format("%s,%s,%s,%s", pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel)
		if szKey == string.format("%s,%s,%s,%s", unpack(self.ITEM_MINGBULING)) then
			me.DelItem(pItem);
			nExTempCount = nExTempCount + pItem.nCount;
		end
		if nExTempCount >= nExCount then
			break;
		end
	end
	

		me.SetTask(4002,1,me.GetTask(4002,1) + nExCount); 	-- Phúc Duyên		
		me.Msg(string.format("Đổi Thành Công %s Danh Bổ Lệnh Lấy <color=yellow>%s<color> Điểm Phúc Duyên", nExCount,nExCount));

end

function Wanted:OnChangeBackMRR(nId,tbItem)
		
	local nExCount = 0;
	for _, tbItem in pairs(tbItem) do
		local pItem = tbItem[1];
		local szKey = string.format("%s,%s,%s,%s", pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel)
		
		if szKey == string.format("%s,%s,%s,%s", unpack(self.ITEM_MINGBULING)) then
			nExCount = nExCount + pItem.nCount;
		end
	end
	
	if nExCount < self.DATAITEMEVENT[nId][2] then
		Dialog:Say("Không đúng vật phẩm hoặc số lượng Danh Bổ Lệnh mà ta yêu cầu.");
		return 0;
	end
	
	local nExTempCount = 0;
	for _, tbItem in pairs(tbItem) do
		local pItem = tbItem[1];
		local szKey = string.format("%s,%s,%s,%s", pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel)
		if szKey == string.format("%s,%s,%s,%s", unpack(self.ITEM_MINGBULING)) then
			me.DelItem(pItem);
			nExTempCount = nExTempCount + pItem.nCount;
		end
		if nExTempCount >= nExCount then
			break;
		end
	end
	

		local AddItem = me.AddItem(18,1,216,nId); 	-- Phúc Duyên		
		me.Msg(string.format("Đổi Thành Công %s Danh Bổ Lệnh Lấy %s ", nExCount,AddItem.szName));

end


function Wanted:OnGift(tbItem)
	local tbParam = {
		tbAward = {
			{
				nGenre 		= tbItem[1][1],
				nDetail 	= tbItem[1][2],
				nParticular = tbItem[1][3],
				nLevel 		= tbItem[1][4],
				nCount		= 1,
			}
		},
		tbMareial = {
			{
				nGenre 		= self.ITEM_MINGBULING[1], 
				nDetail 	= self.ITEM_MINGBULING[2], 
				nParticular = self.ITEM_MINGBULING[3], 
				nLevel 		= self.ITEM_MINGBULING[4],
				nCount		= tbItem[2],
			}
		}
		};
	local szContent = string.format("\nĐổi <color=yellow>%s<color> cần <color=yellow>%s<color> <color=yellow>%s<color>", KItem.GetNameById(unpack(tbItem[1])),tbItem[2], KItem.GetNameById(unpack(self.ITEM_MINGBULING)));
	Wanted.Gift:OnOpen(szContent, tbParam)
end
