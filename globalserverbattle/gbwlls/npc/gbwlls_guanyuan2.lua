-- 初级跨服联赛官

local tbNpc = Npc:GetClass("gbwlls_guanyuan2");

function tbNpc:OnDialog()
	if (GLOBAL_AGENT) then
		if (Wlls:GetMacthSession() < Wlls.MACTH_PRIM_START_MISSION) then
			Dialog:Say("武林联赛官员：初级跨服武林联赛还未开启，请大侠到高级跨服联赛官员处报名参加高级跨服武林联赛。");
			return 0;
		end
	end	
	local nGameLevel = 1;
	GbWlls.DialogNpc:OnDialog(nGameLevel)	
end
