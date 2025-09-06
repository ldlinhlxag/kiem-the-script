
-- ====================== 文件信息 ======================

-- 陶朱公疑塚傳送出口腳本
-- Edited by peres
-- 2008/03/11 AM 11:38

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

local tbNpc = Npc:GetClass("tao_tomb_door");

function tbNpc:OnDialog()
	
	local nTreasureId			= TreasureMap:GetMyInstancingTreasureId(me);
		if not nTreasureId or nTreasureId <= 0 then
			me.Msg("Đọc thời gian đăng nhập thất bại, xin kiểm tra lại từ đầu!");
			return;
		end;
	local tbInfo				= TreasureMap:GetTreasureInfo(nTreasureId);
	local nMapId, nMapX, nMapY	= tbInfo.MapId, tbInfo.MapX, tbInfo.MapY;
	
	Dialog:Say(
		"Bạn muốn rời khỏi đây?",
		{"Phải", self.SendOut, self, me, nMapId, nMapX, nMapY},
		{"Tạm thời chưa"}
	);
end

function tbNpc:SendOut(pPlayer, nMapId, nMapX, nMapY)
	pPlayer.NewWorld(nMapId, nMapX, nMapY);
end
