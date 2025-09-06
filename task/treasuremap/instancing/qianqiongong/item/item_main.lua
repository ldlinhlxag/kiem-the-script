
-- ====================== 文件信息 ======================

-- 千瓊宮副本 ITEM 腳本
-- Edited by peres
-- 2008/08/07 PM 02:30

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

local tbItem_Chip 	= Item:GetClass("purepalace_chip");		-- 碎片
local tbItem_Plate	= Item:GetClass("purepalace_plate");	-- 令牌

local CHIP_NUM		= 5;	-- 合成一張令牌需要的碎片

function tbItem_Chip:OnUse()
	local nChips		= me.GetItemCountInBags(18, 1, 185, 1);
	
	if nChips < CHIP_NUM then
		Dialog:SendInfoBoardMsg(me, "<color=red>Cần có <color><color=yellow>"..CHIP_NUM.."Khối Toái Phiến<color><color=red>mới có thể hợp thành lệnh bài !<color>");
		return;
	else
		me.ConsumeItemInBags(CHIP_NUM, 18, 1, 185, 1);
		me.AddItem(18, 1, 186, 1);
		me.Msg("Ngươi nhận được 1 <color=yellow>Lệnh bài Thiên Quỳnh Cung<color> !");
	end;
end;


function tbItem_Plate:OnUse()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	
	if nMapId ~= 39 then
		Dialog:SendInfoBoardMsg(me, "<color=red>Ngươi phải đến <color><color=yellow>Kỳ Liên Sơn<color><color=red> mới có thể sử dụng được lệnh bài !<color>");
		return;
	end;

	if (me.nTeamId == 0) then
		me.Msg("Ngươi chưa có tổ đội !");
		return;
	end

	Dialog:Say("Giờ ngươi muốn tiến vào ?<enter><enter><color=yellow>Ta khuyên ngươi nêu có đủ 6 chiến hữu cùng tham gia cấp 85 trở lên<color>.", {
			  {"Vâng",		self.OpenInstancing, self, me, it},
			  {"Khoan đã"},
			});

end;


function tbItem_Plate:OpenInstancing(pPlayer, pItem)
	
	if not pPlayer or not pItem then
		return;
	end;
	
	-- 臨時寫法
	if (pPlayer.GetTask(2066, 287)>=6) then
		Dialog:SendInfoBoardMsg(me, "Có thành viên đã đi đủ <color=yellow>6<color> lần !");
		return;
	end;
	
	if (pPlayer.nTeamId == 0) then
		pPlayer.Msg("Chỉ có tổ đội mới có thể tiến vào Thiên Quỳnh Cung");
		return;
	end

	if pPlayer.GetItemCountInBags(18, 1, 186, 1) < 1 then
		return;
	end;
	
--	pPlayer.ConsumeItemInBags(1, 18, 1, 186, 1);
	pItem.Delete(me);
	TreasureMap:AddInstancing(pPlayer, 43);
	TreasureMap:NotifyAroundPlayer(pPlayer, "<color=yellow>"..pPlayer.szName.."Cửa vào Thiên Quỳnh Cung bắt đầu mở ra, mau chóng tiến vào<color>");
end;
