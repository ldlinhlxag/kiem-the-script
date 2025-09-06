-- 文件名　：zongziskill.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-18 11:56:26
-- 描  述  ：

local tbItem = Item:GetClass("dragonboat_zongziskill")
tbItem.tbBook =
{ --物品等级 = {次数上限，任务变量组，任务变量, 增加技能数量};
  2, 2040, 10, 1,
}
function tbItem:OnUse()
	local tbParam = self.tbBook;
	if not tbParam then
		return 0;
	end
	local nUse =  me.GetTask(tbParam[2], tbParam[3]);
	if nUse >= tbParam[1] then
		me.Msg(string.format("<color=yellow>Bạn đã ăn %s cái %s, không thể ăn nữa.", tbParam[1], it.szName));
		Dialog:SendInfoBoardMsg(me, string.format("<color=yellow>Bạn cắn 1 miếng %s, thấy nhạt nhẽo.", it.szName))
		return 0;
	end
	
	me.AddFightSkillPoint(tbParam[4]);
	me.SetTask(tbParam[2], tbParam[3], nUse +1)
	
	PlayerHonor:UpdataMaxWealth(me);		-- 更新财富最大值
	local szMsg = string.format("<color=yellow>Bạn đã ăn %s, dường như ngộ ra gì đó, nhận được %s điểm kỹ năng.", it.szName, tbParam[4]);
	Dialog:SendInfoBoardMsg(me, szMsg)
	szMsg = string.format("%s bạn đã ăn %s cái %s.",szMsg, nUse +1, it.szName);
	me.Msg(szMsg);
	
	return 1;
end

function tbItem:GetTip()
	local szTip = "";
	local tbParam = self.tbBook;
	local nUse =  me.GetTask(tbParam[2], tbParam[3]);
	szTip = szTip .. string.format("<color=green>Đã ăn %s/%s cái<color>", nUse, self.tbBook[1]);
	return szTip;
end
