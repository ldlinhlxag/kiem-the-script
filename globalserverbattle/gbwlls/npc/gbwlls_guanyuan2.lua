-- �������������

local tbNpc = Npc:GetClass("gbwlls_guanyuan2");

function tbNpc:OnDialog()
	if (GLOBAL_AGENT) then
		if (Wlls:GetMacthSession() < Wlls.MACTH_PRIM_START_MISSION) then
			Dialog:Say("����������Ա�������������������δ��������������߼����������Ա�������μӸ߼��������������");
			return 0;
		end
	end	
	local nGameLevel = 1;
	GbWlls.DialogNpc:OnDialog(nGameLevel)	
end
