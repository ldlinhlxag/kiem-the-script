if not MODULE_GAMESERVER then
	return;
end
function DaiChienQuanMongCo:ThongBaoLan1_GS()
		local nMapIndex = SubWorldID2Idx(132);
	if nMapIndex < 0 then
		return;
	end
local msg = "<color=Green>Quân Lính Mông Cổ<color> chuẩn bị tấn công <pos=132,1785,3558> Tàn Tích Cung A Phòng. Các nhân sĩ mau mau tới đó ! Lệnh triệu tập lúc 18h00";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end
function DaiChienQuanMongCo:ThongBaoLan2_GS()
		local nMapIndex = SubWorldID2Idx(132);
	if nMapIndex < 0 then
		return;
	end
local msg = "<color=Green>Quân Lính Mông Cổ<color> chuẩn bị tấn công <pos=132,1785,3558> Tàn Tích Cung A Phòng. Các nhân sĩ mau mau tới đó ! Lệnh triệu tập lúc 18h00";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end
function DaiChienQuanMongCo:ThongBaoLan3_GS()
		local nMapIndex = SubWorldID2Idx(132);
	if nMapIndex < 0 then
		return;
	end
local msg = "<color=Green>Quân Lính Mông Cổ<color> chuẩn bị tấn công <pos=132,1785,3558> Tàn Tích Cung A Phòng. Các nhân sĩ mau mau tới đó ! Lệnh triệu tập lúc 18h00";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end
function DaiChienQuanMongCo:ThongBaoLan4_GS()
		local nMapIndex = SubWorldID2Idx(132);
	if nMapIndex < 0 then
		return;
	end
local msg = "<color=Green>Quân Lính Mông Cổ<color> chuẩn bị tấn công <pos=132,1785,3558> Tàn Tích Cung A Phòng. Các nhân sĩ mau mau tới đó ! Lệnh triệu tập lúc 18h00";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end
function DaiChienQuanMongCo:TrieuTapMember_GS()
		local nMapIndex = SubWorldID2Idx(132);
	if nMapIndex < 0 then
		return;
	end
	local msg = "<color=Green>Quân Lính Mông Cổ<color> chuẩn bị tấn công <pos=132,1785,3558> Tàn Tích Cung A Phòng. Lệnh triệu tập !";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	local nMapId, nMapX, nMapY = me.GetWorldPos();
	me.Msg("Thiết lập tất cả!");
	self:RemoteCall_ApplyAll("me.NewWorld", 132, 1778, 3547);
	end
function DaiChienQuanMongCo:AddQuanLinhMC_GS()
		local nMapIndex = SubWorldID2Idx(132);
	if nMapIndex < 0 then
		return;
	end
local msg = "<color=Green>Quân Lính Mông Cổ<color> đang tấn công tại <pos=132,1785,3558> Tàn Tích Cung A Phòng";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
KNpc.Add2(20207, 255, 0, 132, 1783, 3559)
KNpc.Add2(20207, 255, 0, 132, 1783, 3559)
KNpc.Add2(20207, 255, 0, 132, 1783, 3559)
KNpc.Add2(20207, 255, 0, 132, 1783, 3559)
KNpc.Add2(20207, 255, 0, 132, 1783, 3559)
KNpc.Add2(20207, 255, 0, 132, 1783, 3559)
KNpc.Add2(20207, 255, 0, 132, 1783, 3559)
KNpc.Add2(20207, 255, 0, 132, 1783, 3559)
KNpc.Add2(20207, 255, 0, 132, 1783, 3559)
KNpc.Add2(20207, 255, 0, 132, 1783, 3559)
KNpc.Add2(20207, 255, 0, 132, 1776, 3557)
KNpc.Add2(20207, 255, 0, 132, 1776, 3557)
KNpc.Add2(20207, 255, 0, 132, 1776, 3557)
KNpc.Add2(20207, 255, 0, 132, 1776, 3557)
KNpc.Add2(20207, 255, 0, 132, 1776, 3557)
KNpc.Add2(20207, 255, 0, 132, 1776, 3557)
KNpc.Add2(20207, 255, 0, 132, 1776, 3557)
KNpc.Add2(20207, 255, 0, 132, 1776, 3557)
KNpc.Add2(20207, 255, 0, 132, 1776, 3557)
KNpc.Add2(20207, 255, 0, 132, 1776, 3557)
KNpc.Add2(20207, 255, 0, 132, 1770, 3550)
KNpc.Add2(20207, 255, 0, 132, 1770, 3550)
KNpc.Add2(20207, 255, 0, 132, 1770, 3550)
KNpc.Add2(20207, 255, 0, 132, 1770, 3550)
KNpc.Add2(20207, 255, 0, 132, 1770, 3550)
KNpc.Add2(20207, 255, 0, 132, 1770, 3550)
KNpc.Add2(20207, 255, 0, 132, 1770, 3550)
KNpc.Add2(20207, 255, 0, 132, 1770, 3550)
KNpc.Add2(20207, 255, 0, 132, 1770, 3550)
KNpc.Add2(20207, 255, 0, 132, 1770, 3550)
KNpc.Add2(20207, 255, 0, 132, 1769, 3523)
KNpc.Add2(20207, 255, 0, 132, 1769, 3523)
KNpc.Add2(20207, 255, 0, 132, 1769, 3523)
KNpc.Add2(20207, 255, 0, 132, 1796, 3536)
KNpc.Add2(20207, 255, 0, 132, 1796, 3536)
KNpc.Add2(20207, 255, 0, 132, 1796, 3536)
KNpc.Add2(20207, 255, 0, 132, 1805, 3574)
KNpc.Add2(20207, 255, 0, 132, 1805, 3574)
KNpc.Add2(20207, 255, 0, 132, 1805, 3574)
KNpc.Add2(20207, 255, 0, 132, 1805, 3574)
KNpc.Add2(20207, 255, 0, 132, 1805, 3574)
end
------------
function DaiChienQuanMongCo:AddMCSNhat_GS()
		local nMapIndex = SubWorldID2Idx(132);
	if nMapIndex < 0 then
		return;
	end
local msg = "<color=Green>Mông Cổ Sứ (Nhật)<color> đang ở <pos=132,1777,3568> Tàn Tích Cung A Phòng";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
KNpc.Add2(20208, 255, 0, 132, 1777, 3548)
end
function DaiChienQuanMongCo:AddMCSNguyet_GS()
		local nMapIndex = SubWorldID2Idx(132);
	if nMapIndex < 0 then
		return;
	end
local msg = "<color=Green>Mông Cổ Sứ (Nguyệt)<color> đang ở <pos=132,1777,3568> Tàn Tích Cung A Phòng";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
KNpc.Add2(20209, 255, 0, 132, 1777, 3548)
end
function DaiChienQuanMongCo:AddMCSPhong_GS()
		local nMapIndex = SubWorldID2Idx(132);
	if nMapIndex < 0 then
		return;
	end
local msg = "<color=Green>Mông Cổ Sứ (Phong)<color> đang ở <pos=132,1777,3568> Tàn Tích Cung A Phòng";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
KNpc.Add2(20210, 255, 0, 132, 1777, 3548)
end
function DaiChienQuanMongCo:AddMCSVan_GS()
		local nMapIndex = SubWorldID2Idx(132);
	if nMapIndex < 0 then
		return;
	end
local msg = "<color=Green>Mông Cổ Sứ (Vân)<color> đang ở <pos=132,1777,3568> Tàn Tích Cung A Phòng";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
KNpc.Add2(20211, 255, 0, 132, 1777, 3548)
end
function DaiChienQuanMongCo:AddMCSLoi_GS()
		local nMapIndex = SubWorldID2Idx(132);
	if nMapIndex < 0 then
		return;
	end
local msg = "<color=Green>Mông Cổ Sứ (Lôi)<color> đang ở <pos=132,1777,3568> Tàn Tích Cung A Phòng";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
KNpc.Add2(20212, 255, 0, 132, 1777, 3548)
end
function DaiChienQuanMongCo:AddMCSDien_GS()
		local nMapIndex = SubWorldID2Idx(132);
	if nMapIndex < 0 then
		return;
	end
local msg = "<color=Green>Mông Cổ Sứ (Điện)<color> đang ở <pos=132,1777,3568> Tàn Tích Cung A Phòng";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
KNpc.Add2(20213, 255, 0, 132, 1777, 3548)
end