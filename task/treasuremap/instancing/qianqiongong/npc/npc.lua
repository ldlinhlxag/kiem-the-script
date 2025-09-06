
-- ====================== 文件信息 ======================

-- 千瓊宮副本 NPC 腳本
-- Edited by peres
-- 2008/07/25 AM 11:39

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

local tbNpc_Bag		= Npc:GetClass("purepalace_bag");				-- 裝有鑰匙的袋子
local tbNpc_1		= Npc:GetClass("purepalace_xiaolian_npc");		-- 第一個對話類型 NPC
local tbNpc_2		= Npc:GetClass("purepalace_xiaolian_fight");	-- 護送 NPC

local tbNpc_Hiding	= Npc:GetClass("purepalace_hiding");	-- 隱匿之處傳送點
local tbNpc_Outside	= Npc:GetClass("purepalace_outside");	-- 副本出口

local tbNpc_Task	= Npc:GetClass("purepalace_lixianglan");

local tbNpc_Box		= Npc:GetClass("purepalace_box_inside");	-- 箱子


tbNpc_1.tbTrack	= {
	{1629, 3044},
	{1640, 3030},
	{1618, 3008},
	{1596, 2981},
	{1571, 2956},
}

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

function tbNpc_1:OnDialog()
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if tbInstancing.tbBossDown[1] == 1 and tbInstancing.tbBossDown[2] == 0 and tbInstancing.nGirlProStep == 0 then
		local nKeys		= me.GetItemCountInBags(18,1,183,1);
		if nKeys > 0 then
			Dialog:Say("Ngươi đã nhận được thuốc giải ?", {
					  {"Đây, hãy thử liều thuốc này", tbNpc_1.Release, tbNpc_1, him},
					  {"Đợi một chút", tbNpc_1.OnExit, tbNpc_1},
					});
		else
			Dialog:Say("Ta đã mắc kẹt ở đây một thời gian dài, Bất Đổng Tha Môn có một liều độc dược, bị trúng độc sẽ tê liệt không thể di chuyển. Ngươi có thể giúp ta không ? Ta thật sự không hiểu, Dữ Tha Môn vô oan vô cừu lại không có ai dám đối đầu.");
			return;
		end;
	end;
	
	if tbInstancing.tbBossDown[2] == 1 and tbInstancing.nGirlProStep == 1 then
		local nKeys		= me.GetItemCountInBags(18,1,184,1);
		if nKeys > 0 and tbInstancing.tbBossDown[5] == 1 then
			Dialog:Say("Ngươi đã giúp ta tìm thấy Khỏa Bảo Châu ?", {
					  {"Đây, hãy thử khỏa bảo châu này", tbNpc_1.Finish, tbNpc_1, him, me},
					  {"Đợi một chút", tbNpc_1.OnExit, tbNpc_1},
					});
		else
			Dialog:Say("Ta mắt đã mờ thân cạn kiệt sức lực, chỉ có 1 liêu thuốc giải không thể cứu được độc thấm sâu trong người, ta nghe nói trong Thiên Quỳnh Cung có báo vật <color=yellow>Thiên Niên Bảo Châu<color>, có thể trị dứt căn bệnh của ta, ngươi có thiện chí, Có thể giúp ta tìm và mang về không ?");
			return;
		end;
	end;
end;


function tbNpc_1:Release(pNpc)
	
	if not him then
		return;
	end;
	
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
		
	local nKeys		= me.GetItemCountInBags(18,1,183,1);
	
	if nKeys <=0 then
		Dialog:Say("Trên người của ngươi không có thuốc giải ?");
		return;
	end;
	
	me.ConsumeItemInBags(1, 18, 1, 183, 1);

	local nCurMapId, nCurPosX, nCurPosY = him.GetWorldPos();
	him.Delete();
	
	local pFightNpc		= KNpc.Add2(2745, 20, -1, nCurMapId, nCurPosX, nCurPosY, 0, 0, 1);
	
	-- 在這裡記錄Tiểu Liên的 ID
	tbInstancing.nGirlId	= pFightNpc.dwId;
	
	pFightNpc.szName	= "Tiểu Liên";
	pFightNpc.SetTitle("Do đội <color=yellow>"..me.szName.."<color> bảo vệ");
	pFightNpc.SetCurCamp(0);
	
	pFightNpc.RestoreLife();
	
--	pFightNpc.GetTempTable("Npc").tbOnArrive = {tbNpc.OnArrive, tbNpc, pFightNpc, me};

	pFightNpc.AI_ClearPath();
	
	for _,Pos in ipairs(self.tbTrack) do
		if (Pos[1] and Pos[2]) then
			pFightNpc.AI_AddMovePos(tonumber(Pos[1])*32, tonumber(Pos[2])*32)
		end
	end;
	
	pFightNpc.SetNpcAI(9, 50, 1,-1, 25, 25, 25, 0, 0, 0, me.GetNpc().nIndex);
	
	tbInstancing.nGirlProStep = 1;
end;


function tbNpc_1:Finish(pNpc, pPlayer)
	
	if not him then
		return;
	end;
	
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
		
	local nKeys		= me.GetItemCountInBags(18,1,184,1);
	
	if nKeys <=0 then
		Dialog:Say("Ngươi không có Khỏa Bảo Châu ư ?");
		return;
	end;
	
	me.ConsumeItemInBags(1, 18, 1, 184, 1);

	local nCurMapId, nCurPosX, nCurPosY = him.GetWorldPos();
	him.Delete();
	
	TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>Tiểu Liên đã nuốt Tiểu Bảo Châu, một tiếng cười lớn, đột nhiên biến mất !<color>");
	
	-- 加隱藏 BOSS
	KNpc.Add2(2746, 98, 3, nMapId, 1822, 2907);
	
	-- 加一個傳送點
	local pSendPos	= KNpc.Add2(2748, 1, -1, nMapId, nMapX, nMapY);
	pSendPos.szName	= "Cửa vào thần bí";
	
	tbInstancing.nGirlProStep = 2;
end;


function tbNpc_1:OnExit()
	
end;


-- 護送 NPC Tiểu Liên被殺死
function tbNpc_2:OnDeath(pNpc)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	tbInstancing.nGirlKilled	= 1;
end;


-- 打開袋子拿到解藥
function tbNpc_Bag:OnDialog()
	
	local nFreeCell = me.CountFreeBagCell();
	if nFreeCell < 2 then
		Dialog:SendInfoBoardMsg(me, "Hành trang cần trống <color=yellow> 2 ô mới có thể tiếp tục<color>！");
		return;
	end;
	
	-- TODO:liucahng 10寫到head中去
	GeneralProcess:StartProcess("Đang mở...", 10 * 18, {self.OnOpen, self, me.nId, him.dwId}, {me.Msg, "Mở bị gián đoạn"}, tbEvent);

end;

function tbNpc_Bag:OnOpen(nPlayerId, dwNpcId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;
	
	local nFreeCell = pPlayer.CountFreeBagCell();
	if nFreeCell < 2 then
		Dialog:SendInfoBoardMsg(pPlayer, "Hành trang cần trống <color=yellow> 2 ô mới có thể tiếp tục<color>！");
		return;
	end;
	
	local pNpc = KNpc.GetById(dwNpcId);
	
	if (pNpc and pNpc.nIndex > 0) then
		
		local nMapId, nMapX, nMapY	= pNpc.GetWorldPos();
		local tbInstancing = TreasureMap:GetInstancing(nMapId);
		
		if tbInstancing.tbBossDown[1] == 1 and tbInstancing.tbBossDown[5] == 0 then
			
			pPlayer.AddItem(18, 1, 183, 1);
			pPlayer.Msg("<color=yellow>Ngươi có được 1 bình thuốc giải độc !<color>");
			-- 通知附近的玩家
			TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." nhận được 1 bình thuốc giải độc !<color>");
					
		elseif tbInstancing.tbBossDown[5] == 1 then
			
			pPlayer.AddItem(18, 1, 184, 1);
			pPlayer.Msg("<color=yellow>Ngươi có được 1 Khỏa bảo châu !<color>");
			-- 通知附近的玩家
			TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." nhận được 1 khỏa bảo châu !<color>");

		end;
		pNpc.Delete();
	end
end;


function tbNpc_Task:OnDialog()
	
end;


function tbNpc_Hiding:OnDialog()
	
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	
	Dialog:Say("Ngươi có muốn tiến vào đối đầu với thử thách ?", {
			  {"Vâng", tbNpc_Hiding.Inside, tbNpc_Hiding, me, nMapId},
			  {"Không", tbNpc_Hiding.OnExit, tbNpc_Hiding},
			});
end;

function tbNpc_Hiding:Inside(pPlayer, nMapId)
	pPlayer.NewWorld(nMapId, 1732, 2913);
end;

function tbNpc_Hiding:OnExit()
	
end;




function tbNpc_Outside:OnDialog()
	
	local nTreasureId			= TreasureMap:GetMyInstancingTreasureId(me);
		if not nTreasureId or nTreasureId <= 0 then
			me.Msg("Có lỗi đọc dữ liệu tọa độ đến, vui lòng trở ra và thử lại");
			return;
		end;
	local tbInfo				= TreasureMap:GetTreasureInfo(nTreasureId);
	local nMapId, nMapX, nMapY	= tbInfo.MapId, tbInfo.MapX, tbInfo.MapY;
	
	Dialog:Say(
		"Ngươi muốn ra khỏi đây ?",
		{"Vâng", self.SendOut, self, me, nMapId, nMapX, nMapY},
		{"Không"}
	);
end;

function tbNpc_Outside:SendOut(pPlayer, nMapId, nMapX, nMapY)
	pPlayer.NewWorld(nMapId, nMapX, nMapY);
end



function tbNpc_Box:OnDialog()
	GeneralProcess:StartProcess("Mở bảo rương...", 10 * 18, {self.OpenTreasureBox, self, me.nId, him.dwId}, {me.Msg, "Mở bị gián đoạn"}, tbEvent);
end

function tbNpc_Box:OpenTreasureBox(nPlayerId, dwNpcId)
	-- 爆物品
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	local pNpc = KNpc.GetById(dwNpcId);
	if (pNpc and pNpc.nIndex > 0) then
		pPlayer.DropRateItem(TreasureMap.szInstancingBox_Level3, TreasureMap.nTreasureBoxDropCount, -1, -1, pNpc)
		pPlayer.Msg("<color=yellow>Mở hoàn tất<color>")
		pNpc.Delete();
	end
end
