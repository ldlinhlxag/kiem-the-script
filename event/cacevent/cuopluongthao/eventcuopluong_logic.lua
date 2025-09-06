if not MODULE_GAMESERVER then
	return;
end
function CuopLuong:TrieuTapGiacNgoaiXam_GS()
		local nMapIndex = SubWorldID2Idx(28);
	if nMapIndex < 0 then
		return;
	end
	GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Giặc Ngoại Xâm<color> đang chuẩn bị tiến công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Giặc Ngoại Xâm<color> đang chuẩn bị tiến công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Giặc Ngoại Xâm<color> đang chuẩn bị tiến công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>");	
end
function CuopLuong:GiacNgoaiXam1_GS()
		local nMapIndex = SubWorldID2Idx(28);
	if nMapIndex < 0 then
		return;
	end
KNpc.Add2(20214, 255, 0, 28, 1459, 3317)
KNpc.Add2(20214, 255, 0, 28, 1446, 3301)
KNpc.Add2(20214, 255, 0, 28, 1433, 3278)
KNpc.Add2(20214, 255, 0, 28, 1426, 3261)
KNpc.Add2(20214, 255, 0, 28, 1419, 3245)
KNpc.Add2(20214, 255, 0, 28, 1470, 3284)
KNpc.Add2(20214, 255, 0, 28, 1486, 3279)
KNpc.Add2(20214, 255, 0, 28, 1498, 3287)
KNpc.Add2(20214, 255, 0, 28, 1506, 3273)
KNpc.Add2(20214, 255, 0, 28, 1522, 3279)
KNpc.Add2(20214, 255, 0, 28, 1525, 3261)
KNpc.Add2(20214, 255, 0, 28, 1519, 3267)
KNpc.Add2(20214, 255, 0, 28, 1539, 3270)
KNpc.Add2(20214, 255, 0, 28, 1548, 3267)
KNpc.Add2(20214, 255, 0, 28, 1540, 3290)
---
KNpc.Add2(20214, 255, 0, 28, 1550, 3265)
KNpc.Add2(20214, 255, 0, 28, 1551, 3247)
KNpc.Add2(20214, 255, 0, 28, 1565, 3250)
KNpc.Add2(20214, 255, 0, 28, 1576, 3242)
KNpc.Add2(20214, 255, 0, 28, 1539, 3270)
KNpc.Add2(20214, 255, 0, 28, 1588, 3249)
KNpc.Add2(20214, 255, 0, 28, 1592, 3226)
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>");	
end
function CuopLuong:GiacNgoaiXam2_GS()
		local nMapIndex = SubWorldID2Idx(28);
	if nMapIndex < 0 then
		return;
	end
KNpc.Add2(20214, 255, 0, 28, 1493, 3269)
KNpc.Add2(20214, 255, 0, 28, 1493, 3264)
KNpc.Add2(20214, 255, 0, 28, 1487, 3272)
KNpc.Add2(20214, 255, 0, 28, 1493, 3276)
KNpc.Add2(20214, 255, 0, 28, 1499, 3269)
KNpc.Add2(20214, 255, 0, 28, 1498, 3261)
KNpc.Add2(20214, 255, 0, 28, 1503, 3262)
KNpc.Add2(20214, 255, 0, 28, 1508, 3266)
KNpc.Add2(20214, 255, 0, 28, 1508, 3284)
KNpc.Add2(20214, 255, 0, 28, 1512, 3284)
KNpc.Add2(20214, 255, 0, 28, 1519, 3279)
KNpc.Add2(20214, 255, 0, 28, 1519, 3267)
KNpc.Add2(20214, 255, 0, 28, 1531, 3267)
KNpc.Add2(20214, 255, 0, 28, 1533, 3279)
KNpc.Add2(20214, 255, 0, 28, 1520, 3284)
KNpc.Add2(20214, 255, 0, 28, 1550, 3265)
KNpc.Add2(20214, 255, 0, 28, 1551, 3247)
KNpc.Add2(20214, 255, 0, 28, 1565, 3250)
KNpc.Add2(20214, 255, 0, 28, 1576, 3242)
KNpc.Add2(20214, 255, 0, 28, 1539, 3270)
KNpc.Add2(20214, 255, 0, 28, 1588, 3249)
KNpc.Add2(20214, 255, 0, 28, 1592, 3226)
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>");	
end
function CuopLuong:GiacNgoaiXam3_GS()
		local nMapIndex = SubWorldID2Idx(28);
	if nMapIndex < 0 then
		return;
	end
KNpc.Add2(20214, 255, 0, 28, 1459, 3317)
KNpc.Add2(20214, 255, 0, 28, 1446, 3301)
KNpc.Add2(20214, 255, 0, 28, 1433, 3278)
KNpc.Add2(20214, 255, 0, 28, 1426, 3261)
KNpc.Add2(20214, 255, 0, 28, 1419, 3245)
KNpc.Add2(20214, 255, 0, 28, 1470, 3284)
KNpc.Add2(20214, 255, 0, 28, 1486, 3279)
KNpc.Add2(20214, 255, 0, 28, 1498, 3287)
KNpc.Add2(20214, 255, 0, 28, 1506, 3273)
KNpc.Add2(20214, 255, 0, 28, 1522, 3279)
KNpc.Add2(20214, 255, 0, 28, 1525, 3261)
KNpc.Add2(20214, 255, 0, 28, 1519, 3267)
KNpc.Add2(20214, 255, 0, 28, 1539, 3270)
KNpc.Add2(20214, 255, 0, 28, 1548, 3267)
KNpc.Add2(20214, 255, 0, 28, 1540, 3290)
---
KNpc.Add2(20214, 255, 0, 28, 1550, 3265)
KNpc.Add2(20214, 255, 0, 28, 1551, 3247)
KNpc.Add2(20214, 255, 0, 28, 1565, 3250)
KNpc.Add2(20214, 255, 0, 28, 1576, 3242)
KNpc.Add2(20214, 255, 0, 28, 1539, 3270)
KNpc.Add2(20214, 255, 0, 28, 1588, 3249)
KNpc.Add2(20214, 255, 0, 28, 1592, 3226)
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>");	
end
function CuopLuong:GiacNgoaiXam4_GS()
		local nMapIndex = SubWorldID2Idx(28);
	if nMapIndex < 0 then
		return;
	end
KNpc.Add2(20214, 255, 0, 28, 1493, 3269)
KNpc.Add2(20214, 255, 0, 28, 1493, 3264)
KNpc.Add2(20214, 255, 0, 28, 1487, 3272)
KNpc.Add2(20214, 255, 0, 28, 1493, 3276)
KNpc.Add2(20214, 255, 0, 28, 1499, 3269)
KNpc.Add2(20214, 255, 0, 28, 1498, 3261)
KNpc.Add2(20214, 255, 0, 28, 1503, 3262)
KNpc.Add2(20214, 255, 0, 28, 1508, 3266)
KNpc.Add2(20214, 255, 0, 28, 1508, 3284)
KNpc.Add2(20214, 255, 0, 28, 1512, 3284)
KNpc.Add2(20214, 255, 0, 28, 1519, 3279)
KNpc.Add2(20214, 255, 0, 28, 1519, 3267)
KNpc.Add2(20214, 255, 0, 28, 1531, 3267)
KNpc.Add2(20214, 255, 0, 28, 1533, 3279)
KNpc.Add2(20214, 255, 0, 28, 1520, 3284)
KNpc.Add2(20214, 255, 0, 28, 1550, 3265)
KNpc.Add2(20214, 255, 0, 28, 1551, 3247)
KNpc.Add2(20214, 255, 0, 28, 1565, 3250)
KNpc.Add2(20214, 255, 0, 28, 1576, 3242)
KNpc.Add2(20214, 255, 0, 28, 1539, 3270)
KNpc.Add2(20214, 255, 0, 28, 1588, 3249)
KNpc.Add2(20214, 255, 0, 28, 1592, 3226)
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>");	
end
function CuopLuong:AddLak_GS()
		local nMapIndex = SubWorldID2Idx(30);
	if nMapIndex < 0 then
		return;
	end
KNpc.Add2(20224, 255, 0, 30, 1648, 3989)
KNpc.Add2(20225, 255, 0, 30, 1454, 3989)
KNpc.Add2(20226, 255, 0, 30, 1655, 3982)
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>");	
end
function CuopLuong:AddTruVaLuongThao_GS()
		local nMapIndex = SubWorldID2Idx(30);
	if nMapIndex < 0 then
		return;
	end
	KNpc.Add2(20223, 1, 1, 30, 1940, 3867) -- 242/241 Chiến Trường Cổ
KNpc.Add2(20223, 1, 1, 30, 1955, 3877) -- 244/242 Chiến Trường Cổ
KNpc.Add2(20223, 1, 1, 30, 1968, 3865) -- 246/241 Chiến Trường Cổ
KNpc.Add2(20223, 1, 1, 30, 1954, 3854) -- 244/240 Chiến Trường Cổ
--- Hang Ngang 1 ----
KNpc.Add2(20220, 1, 1, 30, 1944, 3862)
KNpc.Add2(20220, 1, 1, 30, 1946, 3862)
KNpc.Add2(20220, 1, 1, 30, 1948, 3862)
KNpc.Add2(20220, 1, 1, 30, 1950, 3862)
KNpc.Add2(20220, 1, 1, 30, 1952, 3862)
KNpc.Add2(20220, 1, 1, 30, 1954, 3862)
KNpc.Add2(20220, 1, 1, 30, 1956, 3862)
KNpc.Add2(20220, 1, 1, 30, 1958, 3862)
KNpc.Add2(20220, 1, 1, 30, 1960, 3862)
KNpc.Add2(20220, 1, 1, 30, 1962, 3862)
KNpc.Add2(20220, 1, 1, 30, 1964, 3862)
-- Hang Ngang 2 ----
KNpc.Add2(20220, 1, 1, 30, 1944, 3866)
KNpc.Add2(20220, 1, 1, 30, 1946, 3866)
KNpc.Add2(20220, 1, 1, 30, 1948, 3866)
KNpc.Add2(20220, 1, 1, 30, 1950, 3866)
KNpc.Add2(20220, 1, 1, 30, 1952, 3866)
KNpc.Add2(20220, 1, 1, 30, 1954, 3866)
KNpc.Add2(20220, 1, 1, 30, 1956, 3866)
KNpc.Add2(20220, 1, 1, 30, 1958, 3866)
KNpc.Add2(20220, 1, 1, 30, 1960, 3866)
KNpc.Add2(20220, 1, 1, 30, 1962, 3866)
KNpc.Add2(20220, 1, 1, 30, 1964, 3866)
--- Hang Ngang 3 ----
KNpc.Add2(20220, 1, 1, 30, 1944, 3870)
KNpc.Add2(20220, 1, 1, 30, 1946, 3870)
KNpc.Add2(20220, 1, 1, 30, 1948, 3870)
KNpc.Add2(20220, 1, 1, 30, 1950, 3870)
KNpc.Add2(20220, 1, 1, 30, 1952, 3870)
KNpc.Add2(20220, 1, 1, 30, 1954, 3870)
KNpc.Add2(20220, 1, 1, 30, 1956, 3870)
KNpc.Add2(20220, 1, 1, 30, 1958, 3870)
KNpc.Add2(20220, 1, 1, 30, 1960, 3870)
KNpc.Add2(20220, 1, 1, 30, 1962, 3870)
KNpc.Add2(20220, 1, 1, 30, 1964, 3870)
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>");	
end
function CuopLuong:AddLuongThao2_GS()
		local nMapIndex = SubWorldID2Idx(30);
	if nMapIndex < 0 then
		return;
	end
KNpc.Add2(20220, 1, 1, 30, 1944, 3862)
KNpc.Add2(20220, 1, 1, 30, 1946, 3862)
KNpc.Add2(20220, 1, 1, 30, 1948, 3862)
KNpc.Add2(20220, 1, 1, 30, 1950, 3862)
KNpc.Add2(20220, 1, 1, 30, 1952, 3862)
KNpc.Add2(20220, 1, 1, 30, 1954, 3862)
KNpc.Add2(20220, 1, 1, 30, 1956, 3862)
KNpc.Add2(20220, 1, 1, 30, 1958, 3862)
KNpc.Add2(20220, 1, 1, 30, 1960, 3862)
KNpc.Add2(20220, 1, 1, 30, 1962, 3862)
KNpc.Add2(20220, 1, 1, 30, 1964, 3862)
-- Hang Ngang 2 ----
KNpc.Add2(20220, 1, 1, 30, 1944, 3866)
KNpc.Add2(20220, 1, 1, 30, 1946, 3866)
KNpc.Add2(20220, 1, 1, 30, 1948, 3866)
KNpc.Add2(20220, 1, 1, 30, 1950, 3866)
KNpc.Add2(20220, 1, 1, 30, 1952, 3866)
KNpc.Add2(20220, 1, 1, 30, 1954, 3866)
KNpc.Add2(20220, 1, 1, 30, 1956, 3866)
KNpc.Add2(20220, 1, 1, 30, 1958, 3866)
KNpc.Add2(20220, 1, 1, 30, 1960, 3866)
KNpc.Add2(20220, 1, 1, 30, 1962, 3866)
KNpc.Add2(20220, 1, 1, 30, 1964, 3866)
--- Hang Ngang 3 ----
KNpc.Add2(20220, 1, 1, 30, 1944, 3870)
KNpc.Add2(20220, 1, 1, 30, 1946, 3870)
KNpc.Add2(20220, 1, 1, 30, 1948, 3870)
KNpc.Add2(20220, 1, 1, 30, 1950, 3870)
KNpc.Add2(20220, 1, 1, 30, 1952, 3870)
KNpc.Add2(20220, 1, 1, 30, 1954, 3870)
KNpc.Add2(20220, 1, 1, 30, 1956, 3870)
KNpc.Add2(20220, 1, 1, 30, 1958, 3870)
KNpc.Add2(20220, 1, 1, 30, 1960, 3870)
KNpc.Add2(20220, 1, 1, 30, 1962, 3870)
KNpc.Add2(20220, 1, 1, 30, 1964, 3870)
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Đại Lý Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>");	
	end
function CuopLuong:XoaLak_GS()
		local nMapIndex = SubWorldID2Idx(30);
	if nMapIndex < 0 then
		return;
	end
	ClearMapNpcWithName(30, "");
	end