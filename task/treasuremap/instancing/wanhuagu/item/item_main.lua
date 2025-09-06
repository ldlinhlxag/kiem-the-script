
-- ====================== 文件信息 ======================

-- 萬花谷副本 ITEM 腳本
-- Edited by peres
-- 2008/11/10 PM 01:50

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================


local tbItem_Map 			= Item:GetClass("wanhuagu_map");		-- 萬花谷入口地圖
local tbItem_Key			= Item:GetClass("wanhuagu_key");		-- 鑰匙
local tbItem_BearSkin		= Item:GetClass("wanhuagu_bearskin");	-- 熊皮
local tbItem_Medicament		= Item:GetClass("wanhuagu_medicament");	-- 隱身藥
local tbItem_Drink			= Item:GetClass("wanhuagu_drink");		-- 女兒紅
local tbItem_Flute			= Item:GetClass("wanhuagu_flute");		-- 笛子

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

function tbItem_Map:OnUse()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	
	if nMapId ~= 30 then
		Dialog:SendInfoBoardMsg(me, "<color=red>Ngươi phải đến <color><color=yellow>Chiến Trường Cổ<color><color=red> mới có thể mở cửa vào !<color>");
		return;
	end;

	if (me.nTeamId == 0) then
		me.Msg("Cần phải lập tổ đội mới đi được !");
		return;
	end

	Dialog:Say("Ngươi có chắc muốn mở cửa đến Vạn Hoa Cốc <enter><enter><color=yellow> ta khuyên ngươi nên gom đủ 6 người cấp 95 trở lên mới nên đi.<color>", {
			  {"Mở cửa",		self.OpenInstancing, self, me, it},
			  {"Đóng lại"},
			});
end;

function tbItem_Map:OpenInstancing(pPlayer, pItem)
	
	if not pPlayer or not pItem then
		return;
	end;
	
	-- 臨時寫法
	if (pPlayer.GetTask(2066, 344)>=6) then
		Dialog:SendInfoBoardMsg(me, "Ngươi đã tham gia <color=yellow>6<color> lần rồi !");
		return;
	end;

	if (pPlayer.nTeamId == 0) then
		pPlayer.Msg("Ngươi chưa lập tổ đội !");
		return;
	end

	if pPlayer.GetItemCountInBags(18, 1, 245, 1) < 1 then
		return;
	end;
	
	pItem.Delete(me);
	TreasureMap:AddInstancing(pPlayer, 61);
	TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." đã mở lối vào Vạn Hoa Cốc !<color>");
	
	KStatLog.ModifyAdd("mixstat", "Mở cửa Vạn Hoa Cốc", "Tổng", 1);
end;


function tbItem_Medicament:OnUse()
	if TreasureMap:GetPlayerMapTemplateId(me) ~= 344 then
		Dialog:SendInfoBoardMsg(me, "Vật phẩm chỉ sử dụng tại <color=yellow>Vạn Hoa Cốc<color> !");
		return;
	end;
	GeneralProcess:StartProcess("Đang sử dụng dược...", Env.GAME_FPS * 10, {self.ItemUsed, self, it, me}, nil, tbEvent);	
end;

function tbItem_Medicament:ItemUsed(pItem, pPlayer)
	if not pPlayer then return; end;
	-- 加隱身技能
	pPlayer.GetNpc().CastSkill(122,30,-1,pPlayer.GetNpc().nIndex);
	pItem.Delete(pPlayer);
	TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." đã nuốt Dược Tề, cơ thể trở nên phát quang.<color>");
end;



function tbItem_Drink:OnUse()
	if TreasureMap:GetPlayerMapTemplateId(me) ~= 344 then
		Dialog:SendInfoBoardMsg(me, "Vật phẩm chỉ sử dụng tại <color=yellow>Vạn Hoa Cốc<color> !");
		return;
	end;
	
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	local _, nDistance = TreasureMap:GetDirection({nMapX, nMapY}, {1609, 3042});
	
	if nDistance > 10 then
		Dialog:SendInfoBoardMsg(me, "<color=red>Không thể sử dụng ở đây !<color>");
		return;
	end;
		
	GeneralProcess:StartProcess("Đang mở Nữ Nhi Hồng...", Env.GAME_FPS * 10, {self.ItemUsed, self, it, me, nMapId}, nil, tbEvent);
end;

function tbItem_Drink:ItemUsed(pItem, pPlayer, nMapId)
	if not pPlayer then return; end;
	
	local nMapId, nMapX, nMapY	= pPlayer.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if not tbInstancing.nBoss_6_Ready then tbInstancing.nBoss_6_Ready = 0; end;
	
	if tbInstancing.nBoss_6_Ready == 1 then
		return
	end;
	
	KNpc.Add2(2773, 100, 4, nMapId, 1610, 3042, 0, 0, 1);
	tbInstancing.nBoss_6_Ready = 1;
	pItem.Delete(pPlayer);
end;


function tbItem_Flute:OnUse()
	if TreasureMap:GetPlayerMapTemplateId(me) ~= 344 then
		Dialog:SendInfoBoardMsg(me, "Vật phẩm chỉ sử dụng tại <color=yellow>Vạn Hoa Cốc<color> !");
		return;
	end;

	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local _, nDistance = TreasureMap:GetDirection({nMapX, nMapY}, {1595, 2890});
	
	if nDistance > 36 then
		Dialog:SendInfoBoardMsg(me, "<color=yellow>Từ đây huýt sáo, Báo Hoa có thể không nghe thấy<color>");
		return;
	end;
		
	GeneralProcess:StartProcess("Đang thổi sáo...", Env.GAME_FPS * 10, {self.ItemUsed, self, it, me}, nil, tbEvent);
end;

function tbItem_Flute:ItemUsed(pItem, pPlayer)
	
	if not pPlayer then return; end;
	
	local nMapId, nMapX, nMapY	= pPlayer.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if tbInstancing.nBoss_5_Ready == 1 then
		return
	end;
	
	if tbInstancing then
		local pNpc_1	= KNpc.GetById(tbInstancing.dwIdLeopard_1);
		local pNpc_2	= KNpc.GetById(tbInstancing.dwIdLeopard_2);
		if pNpc_1 and pNpc_2 then
			pNpc_1.Delete();
			pNpc_2.Delete();
			TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.." đã thổi sáo, cẩn thận Báo Hoa đến !<color>");
		end;
		
		KNpc.Add2(2772, 100, 3, nMapId, 1588, 2887, 0, 0, 1);
		tbInstancing.nBoss_5_Ready	= 1;
		pItem.Delete(pPlayer);
		
	end;
	
end;
