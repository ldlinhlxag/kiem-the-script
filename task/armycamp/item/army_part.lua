--軍營任務.零件
--孫多良
--2008.08.18

local tbItem = Item:GetClass("army_part")

tbItem.nTaskGroupId = 2044;	--隨機獲得零件的任務變量Group
tbItem.nRate =	10; --每讀一頁獲得零件的幾率,百分比
tbItem.tbArmyHandBook = {20,1,483,1};
tbItem.tbTaskId =
{
	--隨機獲得零件的任務變量
	1,2,3,4,5,6,7,8,9,10,
}
tbItem.tbTaskName = {"Tiền trục","Hậu trục","Trung cốt","Cánh tả","Cánh hữu","Tiêu thạch","Lưu huỳnh","Gỗ","Thỏi đồng","Thủy ngân"};

function tbItem:OnUse()
	local tbFind1 = me.FindItemInBags(unpack(self.tbArmyHandBook));
	local tbFind2 = me.FindItemInRepository(unpack(self.tbArmyHandBook));
	if #tbFind1 <= 0 and #tbFind2 <= 0 then
		if me.CountFreeBagCell() >= 1 then
			local pItem = me.AddItem(unpack(self.tbArmyHandBook));
			if pItem then
				pItem.Bind(1);
			end
			--me.Msg("您獲得了機關材料手冊。")
		else
			me.Msg("Hành trang của bạn không đủ chỗ.");
			return 0;
		end
	end
	local nFull = 0;
	for ni, nTaskId in pairs(self.tbTaskId) do
		if me.GetTask(self.nTaskGroupId, nTaskId) == 0 then
			nFull = 1;
			break;
		end
	end
	if nFull == 0 then
		me.Msg("Các bộ phận của máy nghiền đá đã được thu thập. hãy sử dụng để khởi động máy.")
		return 0;
	end
	local nR = Random(10)+1;
	if me.GetTask(self.nTaskGroupId, self.tbTaskId[nR]) == 0 then
		me.SetTask(self.nTaskGroupId, self.tbTaskId[nR], 1);
		me.Msg(string.format("Thu được 1 <color=yellow>%s<color>.",self.tbTaskName[nR]));
	else
		me.Msg(string.format("Thu được 1 <color=yellow>%s<color>.",self.tbTaskName[nR]));
	end
	for ni, nTaskId in pairs(self.tbTaskId) do
		if me.GetTask(self.nTaskGroupId, nTaskId) == 0 then
			return 1;
		end
	end
	me.Msg("Vật liệu cơ quan đã được thu thập đầy đủ, hãy đến khởi động máy.")
	Dialog:SendBlackBoardMsg(me, "Vật liệu cơ quan đã được thu thập đầy đủ, hãy đến khởi động máy.");
	return 1;
end
