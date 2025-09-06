
Require("\\script\\baibaoxiang\\baibaoxiang_def.lua");

local tbJinxiangziItem = Item:GetClass("jinxiangzi");

function tbJinxiangziItem:OnUse()
	
	local nWeekOpen	= me.GetTask(Baibaoxiang.TASK_GROUP_ID, Baibaoxiang.TASK_BAIBAOXIANG_WEEKEND);
	
	if nWeekOpen >= 15 then
		me.Msg("Một tuần chỉ có thể mở 15 rương cao quý, vui lòng kiểm tra lại!");
		return 0;		
	end;
	
	if me.CountFreeBagCell() < 1 then
		me.Msg("Túi của bạn đã đầy, cần ít nhất 1 ô trống.");
		return 0;
	end
	
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	
	-- random
	nRand = MathRandom(1, 10000);
	
	-- fill 3 rate	
	local tbRate = {5000, 4800, 150, 45, 5};
	local tbAward = {8 ,9, 10, 11, 12};
	
	-- get index
	for i = 1, 5 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	
	if nIndex == 0 then
		me.Msg("Xin lỗi, bạn không nhận được gì.");
		return 0;
	end;
	
	local pItem = me.AddItem(18,1,1, tbAward[nIndex]);
	pItem.Bind(1);
	
	nWeekOpen = nWeekOpen + 1;
	me.SetTask(Baibaoxiang.TASK_GROUP_ID, Baibaoxiang.TASK_BAIBAOXIANG_WEEKEND, nWeekOpen);
	
	me.Msg("Bạn mở rương cao quý phát hiện <color=yellow>"..pItem.szName.."<color>");
	
	me.SendMsgToFriend("Hảo hữu của bạn [<color=yellow>" .. me.szName 
		.. "<color>] mở rương vừa đẹp vừa cao quý nhận được <color=yellow>"
		.. pItem.szName .."<color>!");
	
	return 1;
end

function tbJinxiangziItem:WeekEvent()
	me.SetTask(Baibaoxiang.TASK_GROUP_ID, Baibaoxiang.TASK_BAIBAOXIANG_WEEKEND, 0);
end;

PlayerSchemeEvent:RegisterGlobalWeekEvent({tbJinxiangziItem.WeekEvent, tbJinxiangziItem});
