-- 文件名　：taoyuanxiangdao.lua
-- 创建者　：xiewen
-- 创建时间：2008-12-10 16:32:42

local tbNpc = Npc:GetClass("taoyuanxiangdao");
tbNpc.TASK_GROUP_ID1 = 3027;
tbNpc.TaskId_Count = 1;
--离开桃源,将玩家送到上次存档点
function tbNpc:GetOutOfTaoYuan()
	me.Msg("Rời khỏi Đào Nguyên");
	Player:SetFree(me.szName);
	--判断是否是通过非法收据道具的原因进入的桃源
	local nIsIllegalItem = me.GetTask(SpecialEvent.HoleSolution.TASK_COMPENSATE_GROUPID, SpecialEvent.HoleSolution.TASK_SUBID_REASON);
	if nIsIllegalItem == 1 then
		me.SetTask(SpecialEvent.HoleSolution.TASK_COMPENSATE_GROUPID, SpecialEvent.HoleSolution.TASK_SUBID_REASON, 0);	--将存放原因的任务变量清除
	end
end

function tbNpc:OnDialog()
DoScript("\\script\\npc\\taoyuanxiangdao.lua");
	--判断是否是通过非法收据道具的原因进入的桃源
	local nIsIllegalItem = me.GetTask(SpecialEvent.HoleSolution.TASK_COMPENSATE_GROUPID, SpecialEvent.HoleSolution.TASK_SUBID_REASON);
	
	if nIsIllegalItem == 1 then	--是因为非法刷道具的原因进入的桃源
		self:OnDialog_Compensate();
	else
		self:OnDialog_Original();
	end
	
end

--是因为非法刷取道具的原因进入桃源时进入这个对话
function tbNpc:OnDialog_Compensate()
	local nArrearage, nTaskVar = SpecialEvent.HoleSolution:GetBalanceValue();
	if nArrearage <= 0 then
		--如果两组任务变量的值都为0了，先将所有任务变量清零
		SpecialEvent.HoleSolution:SetTaskValue(0,0,1);
		SpecialEvent.HoleSolution:SetTaskValue(0,0,2);
		--再看看数据中还有没有其它的赔偿信息，有则设置到任务变量中并取出
		SpecialEvent.HoleSolution:IsPlayerInList();
		nArrearage, nTaskVar = SpecialEvent.HoleSolution:GetBalanceValue();
	end
	
	local szMsg = "";
	local tbOpt = {};
		
	local tbOpt = {};
	if 0 == nArrearage then
		szMsg = string.format("Hướng dẫn Đào Nguyên: Ngươi đã bồi thường tất cả giá trị lượng, giờ có thể rời khỏi Đào Nguyên.");
		tbOpt = 
		{
		 {"Ta muốn rời khỏi đây", self.GetOutOfTaoYuan, self},
		 {"Để ta suy nghĩ lại"},
		}
	else
		szMsg = string.format("Hướng dẫn Đào Nguyên: Có người thông báo, ngươi dùng thủ đoạn phi pháp xóa Tài Phú cá nhân. Hiện còn <color=red>%d<color> ghi chép, trước khi xử lý ngươi không thể rời khỏi Đào Nguyên!", SpecialEvent.HoleSolution:GetPlayerDebetCount());
		szMsg = szMsg..string.format("\n    Trong ghi chép hiện tại, còn thiếu <color=red>%s<color> Tài Phú.", nArrearage);
		tbOpt = SpecialEvent.HoleSolution:__ParseTheTaskVar(nTaskVar, nArrearage);
		table.insert(tbOpt, {"Để ta suy nghĩ đã"});
	end
	
	Dialog:Say(szMsg, tbOpt);
end

--因为其它原因进入桃源的进入这个对话
function tbNpc:OnDialog_Original()
local nCount = me.GetItemCountInBags(18,10,11,2) -- Tiền Xu
local msg = "Ngươi đã lên đảo <color=green><color> Lần\n"..
"Muốn rời đảo nhà ngươi phải chi cho ta 1 ít <color=yellow>Tiền Xu<color> ta sẽ giúp ngươi rời khỏi <color=green>Đào Hoa Nguyên<color>\n"..
"Lần 1 : <color=green>20<color> <color=yellow>Tiền Xu<color><color>\n"..
"Lần 2 : <color=green>40<color> <color=yellow>Tiền Xu<color><color>\n"..
"Lần 3 : <color=green>60<color> <color=yellow>Tiền Xu<color><color>\n"..
"Lần 4 : Ở trên này chơi với <color=green>Khỉ<color> luôn nhé\n"..
"Số <color=yellow>Tiền Xu<color> hiện có : <color=green>"..nCount.."<color>"
	local tbDlg = {
		{"Liên hệ GM", self.ContactGM, self},
		{"Đóng"}
		}
	Dialog:Say(msg,tbDlg);
end

function tbNpc:ContactGM()
	me.CallClientScript({"UiManager:OpenWindow", "UI_MSG_BOARD"});
end
