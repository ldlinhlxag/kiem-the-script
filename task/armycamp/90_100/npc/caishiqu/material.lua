-- 任何玩家均可採集此物品

-- 材料，任何玩家點擊會採得此物品
--[[
local tbNpc = Npc:GetClass(""); 

function tbNpc:OnDialog()
	local tbEvent = 
	{
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
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
	}
	
	GeneralProcess:StartProcess("正在採集", 15 * 18, {self.OnCollect, self, him.dwId, me.nId}, {me.Msg, "採集失敗"}, tbEvent);		
end;


function tbNpc:OnCollect(nNpcId, nPlayerId)
	-- 刪除此Npc
	
	-- 添加材料
end
--]]
