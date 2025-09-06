-- 文件名　：toweritem.lua
-- 创建者　：jiazhenwei
-- 创建时间：2010-03-10 16:42:59
-- 描  述  ：

local tbTower = Item:GetClass("xianzuzhihun");

function tbTower:OnUse()
	local nCurDay = tonumber(GetLocalDate("%Y%m%d"));
	local nTaskDay = me.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_NEWYEAR_LIANHUA_DAY);
	if nTaskDay < nCurDay then
		me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_NEWYEAR_LIANHUA_DAY, nCurDay);
		me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_NEWYEAR_LIANHUA_COUNT, 0);
	end 
	
	local nTaskCount = me.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_NEWYEAR_LIANHUA_COUNT);
	if nTaskCount >= 3 then
		me.Msg("Mỗi ngày chỉ được đổi <color=yellow>3 Hồn Tổ Tiên<color> lấy 3 cơ hội, hôm nay đã đổi <color=yellow>3 lần<color>.")
		return 0;
	end
	local nTaskAllCount = me.GetTask(TowerDefence.TSK_GROUP,TowerDefence.TSK_NEWYEAR_LIGUAN_COUNT_ALL)
	if nTaskAllCount >= 10 then
		me.Msg("Trong thời gian hoạt động chỉ được đổi <color=yellow>10 Hồn Tổ Tiên<color> lấy 10 cơ hội, hôm nay đã đổi <color=yellow>10 lần<color>.")
		return 0;
	end
	me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_NEWYEAR_LIANHUA_COUNT, nTaskCount + 1);
	me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_EXCOUNT, me.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_EXCOUNT) + 1);
	me.SetTask(TowerDefence.TSK_GROUP,TowerDefence.TSK_NEWYEAR_LIGUAN_COUNT_ALL, me.GetTask(TowerDefence.TSK_GROUP,TowerDefence.TSK_NEWYEAR_LIGUAN_COUNT_ALL) + 1);
	me.Msg("Bạn có thêm <color=yellow>1 lần<color> thi đấu.");
	return 1;
end

function tbTower:GetTip()
	local nTimes = me.GetTask(2118,13);
	local szColor = "green"
	if nTimes == 10 then
		szColor = "gray"
	end
	local szMsg = "Số lần đã dùng: <color="..szColor..">"..nTimes.."/10<color>";
	return szMsg;
end
