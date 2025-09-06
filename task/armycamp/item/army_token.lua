--軍營令牌
--孫多良
--2008.08.19

local tbItem = Item:GetClass("army_token")
tbItem.tbItemId = 
{
	[606] = 0,	--單次
	[607] = 1,	--無限軍營令牌
	[195] = 1,	--無限傳送符
	[235] = 1,
}
-- （此表會被其它模塊引用）
tbItem.tbTransMap = {
	{"Phục Ngưu Sơn Quân Doanh [Thanh Long]",556,1631,3142},
	{"Phục Ngưu Sơn Quân Doanh [Chu Tước]",558,1631,3142},
	{"Phục Ngưu Sơn Quân Doanh [Huyền Vũ]",559,1631,3142}
}
tbItem.nTime = 5;

-- （此函數會被其它模塊調用）
function tbItem:OnUse()
	local szMsg = "Mời chọn Quân doanh bạn muốn đến";
	local tbOpt = {}
	for i, tbItem in ipairs(self.tbTransMap) do
		table.insert(tbOpt, {tbItem[1], self.OnTrans, self, it.dwId, i})
	end
	
	Lib:SmashTable(tbOpt);
	table.insert(tbOpt, {"Kết thúc đối thoại"});
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:OnTrans(nItemId, nTransId)
	local pPlayer = me;
	if pPlayer.nLevel < 60 then
		pPlayer.Msg("Người chơi <cấp 60 không được vào Quân doanh");
		return;
	end
	local tbEvent	= {						-- 會中斷延時的事件
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
	};
	if (0 == pPlayer.nFightState) then				-- 玩家在非戰斗狀態下傳送無延時正常傳送
		self:TransSure(nItemId, nTransId, pPlayer.nId);
		return 0;
	end

	GeneralProcess:StartProcess("Đang chuyển đến Quân doanh...", self.nTime * Env.GAME_FPS, {self.TransSure, self, nItemId, nTransId, pPlayer.nId}, nil, tbEvent);	-- 在戰斗狀態下需要nTime秒的延時
end

function tbItem:TransSure(nItemId, nTransId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local pItem = KItem.GetObjById(nItemId);
	if not pItem or not pPlayer then
		return 0;
	end
	if self.tbItemId[pItem.nParticular] ~= 1 then
		local nCount = pItem.nCount;
		if nCount <= 1 then
			if (pPlayer.DelItem(pItem, Player.emKLOSEITEM_USE) ~= 1) then
				pPlayer.Msg("Xóa Chiêu Thư Tống Kim thất bại!");
				return 0;
			end
		else
			pItem.SetCount(nCount - 1);
			pItem.Sync();
		end
	end
	pPlayer.NewWorld(self.tbTransMap[nTransId][2], self.tbTransMap[nTransId][3], self.tbTransMap[nTransId][4]);
end
