-------------------------------------------------------------------
--File: banghuiLianmengshi.lua
--Author: fenghewen
--Date: 2009-6-17 15:56
--Describe: 帮会联盟使
-------------------------------------------------------------------
--	帮会联盟使;	
local tbBangHuiLianMengShi = Npc:GetClass("banghuilianmengshi");

function tbBangHuiLianMengShi:OnDialog()
	local szSay = "Hoạt động liên minh bang hội。"
	if me.dwUnionId and me.dwUnionId ~= 0 then
		local pUnion = KUnion.GetUnion(me.dwUnionId);
		if pUnion then
			szSay = "Bang hội bạn đã tham gia <color=green>"..pUnion.GetName().."<color>liên minh\nCác thành viên liên minh bao gồm：<color=green>";
			local pTongItor = pUnion.GetTongItor();
			local nTongId = pTongItor.GetCurTongId();
			while nTongId ~= 0 do
				local pTong = KTong.GetTong(nTongId);
				if pTong then
					szSay = szSay ..pTong.GetName().." ";
				end
				nTongId = pTongItor.NextTongId();
			end
		
			local nMasterTongId = pUnion.GetUnionMaster();
			local pMasterTong = KTong.GetTong(nMasterTongId);
			if not pMasterTong then
				local szMsg = string.format("[%s] Bang hội trường liên minh", pUnion.GetName());
				Dbg:WriteLog("Union", "Bang hội trường liên minh", szMsg);
				return 0;
			end
			local nMasterId = Tong:GetMasterId(nMasterTongId)
			local szMasterName = KGCPlayer.GetPlayerName(nMasterId);
	
			szSay = szSay .."<color>\nMinh Chủ：<color=green>"..pMasterTong.GetName().."<color>tên là: <color=green>"..szMasterName.."<color>";
		end
	end
	Dialog:Say(szSay, 
		{
			{"Tạo liên minh.", Union.DlgCreateUnion, Union},
			{"Tham gia liên minh", Union.DlgTongJoin, Union},
			{"Rút khỏi liên minh", Union.DlgTongLeave, Union},
			{"Chuyển giao minh chủ", Union.DlgChangeUnionMaster, Union},
			{"Phân bố lãnh thổ", Union.DlgDispenseDomain, Union},
			{"Kết thúc."}		
		})
end
