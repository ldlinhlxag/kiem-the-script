local tbCayToXanhTot = Npc:GetClass("caytoxanhtot");
function tbCayToXanhTot:OnDialog()
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
GeneralProcess:StartProcess("Đang Rung Cây", 2 * Env.GAME_FPS, {self.ThuThap111, self, me.nId, him.dwId}, nil, tbEvent);
	 };
	 end
function tbCayToXanhTot:ThuThap111(nPlayerId, nNpcId)
local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if (not pPlayer) then
		return;
	end	
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return;
	end
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	-- random
	nRand = MathRandom(1, 10000);
	-- fill 3 rate	
	local tbRate = {9950,50};
	local tbAward = {1,2}
	 
			for i = 1, 2 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	if nIndex == 0 then
		me.Msg("Xin lỗi bạn quá đen <pic=0>.");
		return 0;
	end;
	if (tbAward[nIndex]==1) then
	me.AddExp(20000000);
	me.Earn(500000,0)
	me.AddBindCoin(500000);
	end
	if (tbAward[nIndex]==2) then
	me.AddItem(18,1,25210,1).Bind(1)
	me.AddItem(18,1,547,3).Bind(1)
	me.AddItem(18,1,25292,1).Bind(1)
	me.AddItem(18,1,25292,1).Bind(1)
	me.AddItem(18,1,25292,1).Bind(1)
	me.AddItem(18,1,25292,1).Bind(1)
	me.AddItem(18,1,25292,1).Bind(1)
	me.AddExp(25000000);
			local szMsg = string.format("<color=blue>"..me.szName.."<color> rung cây may mắn nhận được <color=pink>Túi Quà Vũ Khí HKMP (1 Ngày)<color> và nhiều phần thưởng khác");
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT, szMsg);
	KDialog.MsgToGlobal(szMsg);	
	end	
	

	return 0;
		end