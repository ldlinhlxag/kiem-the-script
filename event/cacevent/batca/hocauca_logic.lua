if not MODULE_GAMESERVER then
	return;
end
function HoCauCa:AddHoCauCa_GS()
		local nMapIndex = SubWorldID2Idx(1);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>Sự Kiện Vớt Cá Mắc Cạn bắt đầu tại <pos=1,1422,3183> . Mau chân tới vớt cá nào các nhân sĩ<color>"});
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=yellow>Sự Kiện Vớt Cá Mắc Cạn bắt đầu tại <pos=1,1422,3183> . Mau chân tới vớt cá nào các nhân sĩ<color>");
	KDialog.MsgToGlobal("<color=yellow><color=yellow>Sự Kiện Vớt Cá Mắc Cạn bắt đầu tại <pos=1,1422,3183> . Mau chân tới vớt cá nào các nhân sĩ<color>");	
KNpc.Add2(20216, 255, 0, 1, 1420, 3185)
end
function HoCauCa:XoaHoCauCa_GS()
		local nMapIndex = SubWorldID2Idx(1);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>Sự Kiện Vớt Cá Mắc Cạn đã kết thúc mai tới tiếp nhé<color>"});
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Sự Kiện Vớt Cá Mắc Cạn đã kết thúc mai tới tiếp nhé<color>");
	KDialog.MsgToGlobal("<color=yellow>Sự Kiện Vớt Cá Mắc Cạn đã kết thúc mai tới tiếp nhé<color>");	
		ClearMapNpcWithName(1, "");
		end