local tbRuongBaoGiap = Npc:GetClass("sltk_ruongbaogiap");
tbRuongBaoGiap.tbItemInfo = {
        bForceBind=1,
};  
function tbRuongBaoGiap:OnDialog()
DoScript("\\script\\event\\cacevent\\renbinhkhigiapvatrangsuc\\ruongbaogiap.lua");
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
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
	}
    GeneralProcess:StartProcess("Đang Lấy Phôi Giáp", 5 * Env.GAME_FPS, {self.GetQuest, self, me.nId, him.dwId}, nil, tbEvent);
end
function tbRuongBaoGiap:GetQuest(nPlayerId, nNpcId)
    local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
    if (not pPlayer) then
        return;
    end    
	me.AddStackItem(18,1,20335,1,nil,2) -- Phôi Bảo Giáp (Chưa Đúc)
	 KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> lấy được <color=pink>Phôi Bảo Giáp (Chưa Đúc) x2<color><color>");	   
    local pNpc = KNpc.GetById(nNpcId);
    if (not pNpc) then
        return;
    end
	 pNpc.Delete();
	return 0;
end  