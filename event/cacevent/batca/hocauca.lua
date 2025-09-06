local tbHoCauCa = Npc:GetClass("sltk_hoca");
function tbHoCauCa:OnDialog()
if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải Có 5 Ô Trống Trong Túi Hành Trang");
		return 0;
	end
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
	 local tbOpt = {
				 GeneralProcess:StartProcess("Đang Vớt Cá", 5 * Env.GAME_FPS, {self.OnDialog4, self}, nil, tbEvent);
	 };
end
function tbHoCauCa:OnDialog4()
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	-- random
	nRand = MathRandom(1, 10000);
	-- fill 3 rate	
	local tbRate = {3000,1000,6000};
	local tbAward = {1,2,3}
	 
			for i = 1, 3 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	if (tbAward[nIndex]==1) then
	me.AddItem(18,1,20311,1) -- Cá CHép Đỏ
me.Msg("Vớt được <color=yellow>Cá Chép Đỏ<color>")
	end
	if (tbAward[nIndex]==2) then
	me.AddItem(18,1,20312,1) -- Cá CHép Vàng
me.Msg("Vớt được <color=yellow>Cá Chép Vàng<color>")
	end	
	if (tbAward[nIndex]==3) then
	me.AddItem(18,1,20317,1) -- Lưỡi Kiếm
me.Msg("Vớt được <color=yellow>Lưỡi Kiếm Rỉ Sét<color>")
	end	
	end