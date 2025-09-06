if not MODULE_GAMESERVER then
	return;
end
function GoiBeBanhBao:ThongBaoBeBanhBao_GS()
		local nMapIndex = SubWorldID2Idx(130);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=green>Bạch Yêu<color> trên đường áp giải <color=green>Bé Bánh Bao<color> đang dừng chân tại <pos=130,1702,3481> <color=green>[213/217: Mộng Cổ Vương Đinh]<color>. Các nhân sĩ mau tới giải cứu !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=green>Bạch Yêu<color> trên đường áp giải <color=green>Bé Bánh Bao<color> đang dừng chân tại <pos=130,1702,3481> <color=green>[213/217: Mộng Cổ Vương Đinh]<color>. Các nhân sĩ mau tới giải cứu !<color>");
KDialog.MsgToGlobal("<color=yellow><color=green>Bạch Yêu<color> trên đường áp giải <color=green>Bé Bánh Bao<color> đang dừng chân tại <pos=130,1702,3481> <color=green>[213/217: Mộng Cổ Vương Đinh]<color>. Các nhân sĩ mau tới giải cứu !<color>");	
end
function GoiBeBanhBao:GoiNPCBeBanhBao_GS()
		local nMapIndex = SubWorldID2Idx(130);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=green>Bạch Yêu<color> trên đường áp giải <color=green>Bé Bánh Bao<color> đang dừng chân tại <pos=130,1702,3481> <color=green>[213/217: Mộng Cổ Vương Đinh]<color>. Các nhân sĩ mau tới giải cứu !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=green>Bạch Yêu<color> trên đường áp giải <color=green>Bé Bánh Bao<color> đang dừng chân tại <pos=130,1702,3481> <color=green>[213/217: Mộng Cổ Vương Đinh]<color>. Các nhân sĩ mau tới giải cứu !<color>");
KDialog.MsgToGlobal("<color=yellow><color=green>Bạch Yêu<color> trên đường áp giải <color=green>Bé Bánh Bao<color> đang dừng chân tại <pos=130,1702,3481> <color=green>[213/217: Mộng Cổ Vương Đinh]<color>. Các nhân sĩ mau tới giải cứu !<color>");	

KNpc.Add2(9651, 1, 0, 130, 1710, 3457)
KNpc.Add2(9652, 1, 0, 130, 1712, 3459)
KNpc.Add2(9651, 1, 0, 130, 1714, 3461)
KNpc.Add2(9652, 1, 0, 130, 1716, 3463)
KNpc.Add2(9651, 1, 0, 130, 1718, 3465)
KNpc.Add2(9652, 1, 0, 130, 1720, 3467)
KNpc.Add2(9651, 1, 0, 130, 1722, 3469)

KNpc.Add2(9652, 1, 0, 130, 1712, 3455)
KNpc.Add2(9651, 1, 0, 130, 1714, 3457)
KNpc.Add2(9652, 1, 0, 130, 1716, 3459)
KNpc.Add2(9651, 1, 0, 130, 1718, 3461)
KNpc.Add2(9652, 1, 0, 130, 1720, 3463)
KNpc.Add2(9651, 1, 0, 130, 1722, 3465)
KNpc.Add2(9652, 1, 0, 130, 1724, 3467)

KNpc.Add2(9651, 1, 0, 130, 1714, 3453)
KNpc.Add2(9652, 1, 0, 130, 1716, 3455)
KNpc.Add2(9651, 1, 0, 130, 1718, 3457)
KNpc.Add2(9652, 1, 0, 130, 1720, 3459)
KNpc.Add2(9651, 1, 0, 130, 1722, 3461)
KNpc.Add2(9652, 1, 0, 130, 1724, 3463)
KNpc.Add2(9651, 1, 0, 130, 1726, 3465)

KNpc.Add2(9652, 1, 0, 130, 1716, 3451)
KNpc.Add2(9651, 1, 0, 130, 1718, 3453)
KNpc.Add2(9652, 1, 0, 130, 1720, 3455)
KNpc.Add2(9651, 1, 0, 130, 1722, 3457)
KNpc.Add2(9652, 1, 0, 130, 1724, 3459)
KNpc.Add2(9651, 1, 0, 130, 1726, 3461)
KNpc.Add2(9652, 1, 0, 130, 1728, 3463)

KNpc.Add2(9651, 1, 0, 130, 1718, 3449)
KNpc.Add2(9652, 1, 0, 130, 1720, 3451)
KNpc.Add2(9651, 1, 0, 130, 1722, 3453)
KNpc.Add2(9652, 1, 0, 130, 1724, 3455)
KNpc.Add2(9651, 1, 0, 130, 1726, 3457)
KNpc.Add2(9652, 1, 0, 130, 1728, 3459)
KNpc.Add2(9651, 1, 0, 130, 1730, 3461)

KNpc.Add2(9652, 1, 0, 130, 1720, 3447)
KNpc.Add2(9651, 1, 0, 130, 1722, 3449)
KNpc.Add2(9652, 1, 0, 130, 1724, 3451)
KNpc.Add2(9651, 1, 0, 130, 1726, 3453)
KNpc.Add2(9652, 1, 0, 130, 1728, 3455)
KNpc.Add2(9651, 1, 0, 130, 1730, 3457)
KNpc.Add2(9652, 1, 0, 130, 1732, 3459)
	
---------- Bach Yeu -------------
KNpc.Add2(9653, 1, 0, 130, 1709, 3465)
KNpc.Add2(9653, 1, 0, 130, 1711, 3467)	
KNpc.Add2(9653, 1, 0, 130, 1713, 3469)
KNpc.Add2(9653, 1, 0, 130, 1715, 3471)
KNpc.Add2(9653, 1, 0, 130, 1717, 3473)
	
KNpc.Add2(9653, 1, 0, 130, 1726, 3472)
KNpc.Add2(9653, 1, 0, 130, 1728, 3470)	
KNpc.Add2(9653, 1, 0, 130, 1730, 3468)
KNpc.Add2(9653, 1, 0, 130, 1732, 3466)
KNpc.Add2(9653, 1, 0, 130, 1734, 3464)	

KNpc.Add2(9653, 1, 0, 130, 1708, 3452)
KNpc.Add2(9653, 1, 0, 130, 1710, 3450)	
KNpc.Add2(9653, 1, 0, 130, 1712, 3448)
KNpc.Add2(9653, 1, 0, 130, 1714, 3446)
KNpc.Add2(9653, 1, 0, 130, 1716, 3444)

KNpc.Add2(9653, 1, 0, 130, 1726, 3446)
KNpc.Add2(9653, 1, 0, 130, 1728, 3448)	
KNpc.Add2(9653, 1, 0, 130, 1730, 3450)
KNpc.Add2(9653, 1, 0, 130, 1732, 3452)
KNpc.Add2(9653, 1, 0, 130, 1734, 3454)

KNpc.Add2(9653, 1, 0, 130, 1727, 3460)
KNpc.Add2(9653, 1, 0, 130, 1719, 3454)
KNpc.Add2(9653, 1, 0, 130, 1721, 3460)
KNpc.Add2(9653, 1, 0, 130, 1716, 3457)

end
