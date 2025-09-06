-------------------------------------------------------------------
--File: tuiguangyuan.lua
--Author: kenmaster
--Date: 2008-06-04 03:00
--Describe: 活动推广员npc脚本
-------------------------------------------------------------------
local tbTuiGuangYuan = Npc:GetClass("shengxia_tuiguangyuan");

function tbTuiGuangYuan:OnDialog()
	local tbOpt = {}
	local szMsg = "Xin chào, Làm thế nào tôi có thể giúp cho bạn?";
	
	
	if SpecialEvent.tbYanHua:CheckEventTime() == 1 then
		table.insert(tbOpt,{"Những người nhận các hoạt động mùa hè để ăn mừng pháo hoa", SpecialEvent.tbYanHua.DialogLogic, SpecialEvent.tbYanHua})
	end
	
	if SpecialEvent.HundredKin:CheckEventTime2("award") == 1 then
		table.insert(tbOpt,{"Nhận giải thưởng gia tộc", SpecialEvent.HundredKin.DialogLogic, SpecialEvent.HundredKin})
	end
			
	if Npc.IVER_nShengXiaTuiGuanYuan == 1 then
		if SpecialEvent.ZhongQiu2008:CheckTime() == 1 then
			table.insert(tbOpt, 1, {"Sử dụng các đạo cụ để nhận được Lễ hội vật liệu bánh Trung thu", SpecialEvent.ZhongQiu2008.OnAward, SpecialEvent.ZhongQiu2008})
		end	
		
		if SpecialEvent.WangLaoJi:CheckEventTime(4) == 1 then
			table.insert(tbOpt, 1, {"Nhận giải thưởng", SpecialEvent.WangLaoJi.OnDialog, SpecialEvent.WangLaoJi})
		end
		
		if SpecialEvent.WangLaoJi:CheckExAward() == 1 then
			table.insert(tbOpt, 1, {"<color=red>Nhận phán quyết", SpecialEvent.WangLaoJi.GetWeekFinishAward, SpecialEvent.WangLaoJi})		
		end
	end
	table.insert(tbOpt, {"Kết thúc đối thoại"});
	Dialog:Say(szMsg, tbOpt);
end

