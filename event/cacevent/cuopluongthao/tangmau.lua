local tbTangMau = Npc:GetClass("sltk_npctangmau");
tbTangMau.tbItemInfo = {bForceBind=1,};
function tbTangMau:OnDialog()
DoScript("\\script\\event\\cacevent\\cuopluongthao\\tangmau.lua");
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
    GeneralProcess:StartProcess("Đang Lấy", 1 * Env.GAME_FPS, {self.GetQuest, self, me.nId, him.dwId}, nil, tbEvent);
end
function tbTangMau:GetQuest(nPlayerId, nNpcId)
    local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
    if (not pPlayer) then
        return;
    end    
	me.AddSkillState(876, 15, 2, 5*60 * Env.GAME_FPS, 1, 0, 1); -- SL+1k - Tỉ Lệ SL+85%
	KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> Nhận được hiệu ứng <color=pink>Tăng Máu +1k - Tỉ Lệ HP: 85%<color> sức mạnh tăng đáng kể<color>");	
	me.Msg("Nhận được hiệu ứng Tăng Máu +1k - Tỉ Lệ HP: 85%");
    local pNpc = KNpc.GetById(nNpcId);
    if (not pNpc) then
        return;
    end
	 -- pNpc.Delete();
	return 0;
end  