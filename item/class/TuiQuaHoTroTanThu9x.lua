
local tbHoTro90 = Item:GetClass("tuiquahotrotanthu9x")
function tbHoTro90:OnUse()
	local szMsg = "Mở ra bạn sẽ nhận được <color=yellow>Set đồ 9x+14<color>";
	local tbOpt = {
		{"<color=orange>Nhận<color>",self.NhanHoTro9x, self},
			};

	Dialog:Say(szMsg, tbOpt);
end

function tbHoTro90:NhanHoTro9x()
if me.CountFreeBagCell() < 10 then
		Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId2 = {18,1,25502,1,0,0} -- Mảnh Ghép Huyền Vũ Ấn
if me.nFaction == 0 then
Dialog:Say("<color=yellow>Chưa gia nhập môn phái không thể mở<color>")
return 
end
if me.nRouteId == 0 then
Dialog:Say("Chưa chọn hệ phái")
return
end
	local tbInfo	= GetPlayerInfoForLadderGC(me.szName);
	if tbInfo.nSex == 0 and (me.nFaction == 2) and (me.nRouteId == 1) then -- Thiên Vương Thương Nam
		local item1 = me.AddItem(2,9,810,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,812,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,410,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,312,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,412,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,316,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,210,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,410,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,211,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,751,10,1,14);
		item10.Bind(1);
			end
	if tbInfo.nSex == 1 and (me.nFaction == 2) and (me.nRouteId == 1) then -- Thiên Vương Thương Nữ
		local item11 = me.AddItem(2,9,820,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,822,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,420,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,322,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,422,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,316,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,210,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,420,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,211,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,751,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 2) and (me.nRouteId == 2) then -- Thiên Vương Chùy Nam
		local item1 = me.AddItem(2,9,810,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,812,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,410,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,312,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,412,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,316,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,210,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,410,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,211,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,761,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 2) and (me.nRouteId == 2) then -- Thiên Vương Chùy Nữ
		local item11 = me.AddItem(2,9,820,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,822,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,420,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,322,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,422,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,316,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,210,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,420,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,211,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,761,10,1,14);
		item20.Bind(1);
		end
		-------------
					if tbInfo.nSex == 0 and (me.nFaction == 1) and (me.nRouteId == 1) then -- Thiếu Lâm Đao
			local item1 = me.AddItem(2,9,830,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,832,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,410,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,312,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,412,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,316,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,210,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,410,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,211,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,731,10,1,14);
		item10.Bind(1);
		end
		if tbInfo.nSex == 0 and (me.nFaction == 1) and (me.nRouteId == 2) then -- Thiếu Lâm Bổng
				local item1 = me.AddItem(2,9,810,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,812,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,410,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,312,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,412,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,316,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,210,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,410,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,211,10,1,14);
		item9.Bind(1)
		local item10 = me.AddItem(2,1,741,10,1,14);
		item10.Bind(1);
		end
		---------------
			if tbInfo.nSex == 0 and (me.nFaction == 3) and (me.nRouteId == 2) then -- ĐMTT Nam
		local item1 = me.AddItem(2,9,850,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,852,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,221,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,2,100,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 3) and (me.nRouteId == 2)then -- ĐMTT Nữ
		local item11 = me.AddItem(2,9,860,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,862,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,221,10,1,14);
		item19.Bind(1);
		local item20 =  me.AddItem(2,2,100,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 3) and (me.nRouteId == 1) then -- ĐMHT Nam
		local item1 = me.AddItem(2,9,850,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,852,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,221,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,2,90,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 3) and (me.nRouteId == 1) then -- ĐMHT Nữ
		local item11 = me.AddItem(2,9,860,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,862,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,221,10,1,14);
		item19.Bind(1);
		local item20 =  me.AddItem(2,2,90,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 4) and (me.nRouteId == 1) then -- 5 Độc Đao Nam
		local item1 = me.AddItem(2,9,850,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,852,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,221,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,771,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1  and (me.nFaction == 4) and (me.nRouteId == 1) then -- 5 Độc Đao Nữ
		local item11 = me.AddItem(2,9,860,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,862,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,221,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,771,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 4) and (me.nRouteId == 2) then -- 5 Độc Chưởng Nam
		local item1 = me.AddItem(2,9,870,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,872,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,221,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,781,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 4) and (me.nRouteId == 2) then -- 5 Độc Chưởng Nữ
		local item11 = me.AddItem(2,9,880,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,882,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,221,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,781,10,1,14);
		item20.Bind(1);
        end
			if tbInfo.nSex == 0 and (me.nFaction == 11) and (me.nRouteId == 2) then -- MGK Nam
		local item1 = me.AddItem(2,9,850,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,852,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,221,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,1001,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 11) and (me.nRouteId == 2) then -- MGK Nữ
		local item11 = me.AddItem(2,9,860,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,862,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,221,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,1001,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 11) and (me.nRouteId == 1) then -- Minh Giáo Chùy Nam
		local item1 = me.AddItem(2,9,850,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,852,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,221,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,991,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 11) and (me.nRouteId == 1) then -- MGC Nữ
		local item11 = me.AddItem(2,9,860,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,862,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,221,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,991,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 12) and (me.nRouteId == 2) then -- ĐTK Nam
		local item1 = me.AddItem(2,9,910,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,912,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,450,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,352,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,452,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,328,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,230,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,450,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,231,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,821,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 12) and (me.nRouteId == 2) then -- ĐTK nữ
		local item11 = me.AddItem(2,9,920,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,922,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,231,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,821,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 12) and (me.nRouteId == 1) then -- ĐTC Nam
		local item1 = me.AddItem(2,9,890,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,892,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,450,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,352,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,452,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,328,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,230,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,450,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,231,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,801,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 12) and (me.nRouteId == 1) then -- ĐTC Nữ
		local item11 = me.AddItem(2,9,900,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,902,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,231,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,801,10,1,14);
		item20.Bind(1);
		end
		if (me.nFaction == 5) and (me.nRouteId == 1) then -- Nga Mi Chưởng
		local item11 = me.AddItem(2,9,920,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,922,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,231,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,811,10,1,14);
		item20.Bind(1);
		end
		if (me.nFaction == 5) and (me.nRouteId == 2) then -- Nga Mi Kiếm
		local item11 = me.AddItem(2,9,920,10,1,14);
		item11.Bind(1)
		local item12 = me.AddItem(2,3,922,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,231,10,1,14);
		item19.Bind(1);
		local item10 = me.AddItem(2,1,821,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 6) and (me.nRouteId == 2) then -- TYD Nam
		local item1 = me.AddItem(2,9,910,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,912,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,450,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,352,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,452,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,328,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,230,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,450,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,231,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,791,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 6) and (me.nRouteId == 2) then -- TYD Nữ
		local item11 = me.AddItem(2,9,920,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,922,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,231,10,1,14);
		item19.Bind(1);
		local item20 =  me.AddItem(2,1,791,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 6) and (me.nRouteId == 1) then --TYK Nam
		local item1 = me.AddItem(2,9,910,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,912,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,450,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,352,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,452,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,328,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,230,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,450,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,231,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,821,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 6) and (me.nRouteId == 1) then --TYK Nữ
		local item11 = me.AddItem(2,9,920,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,922,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,231,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,821,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 7) and (me.nRouteId == 1) then -- Cái Bang Rồng Nam
		local item1 = me.AddItem(2,9,950,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,952,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,470,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,372,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,472,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,334,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,240,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,470,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,241,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,851,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 7) and (me.nRouteId == 1) then -- Cái Bang Rồng Nữ
		local item11 = me.AddItem(2,9,960,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,962,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,480,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,382,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,482,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,334,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,240,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,480,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,241,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,851,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 7) and (me.nRouteId == 2) then -- Cái Bang Bổng Nam
		local item1 = me.AddItem(2,9,950,10,1,00);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,952,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,470,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,372,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,472,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,334,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,240,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,470,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,241,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,831,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 7) and (me.nRouteId == 2) then -- Cái Bang Bổng Nữ
		local item11 = me.AddItem(2,9,960,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,962,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,480,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,382,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,482,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,334,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,240,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,480,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,241,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,831,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and  (me.nFaction == 8) and (me.nRouteId == 2) then -- Ma Nhẫn Nam
		local item1 = me.AddItem(2,9,950,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,952,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,470,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,372,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,472,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,334,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,240,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,470,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,241,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,861,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 8) and (me.nRouteId == 2) then -- Ma Nhẫn Nữ
		local item11 = me.AddItem(2,9,960,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,962,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,480,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,382,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,482,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,334,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,240,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,480,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,241,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,861,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 8) and (me.nRouteId == 1) then -- Thiên Nhẫn Thương Nam
		local item1 = me.AddItem(2,9,930,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,932,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,470,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,372,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,472,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,334,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,240,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,470,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,241,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,841,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 8) and (me.nRouteId == 1) then -- THiên Nhẫn Kích Nữ
		local item11 = me.AddItem(2,9,940,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,942,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,480,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,382,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,482,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,334,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,240,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,480,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,241,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,841,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 9) and (me.nRouteId == 1) then -- Võ Đang Khí Nam
		local item1 = me.AddItem(2,9,990,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,992,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,490,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,392,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,492,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,340,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,250,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,490,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,251,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,891,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 9) and (me.nRouteId == 1) then -- Võ Đang Khí Nữ
		local item11 = me.AddItem(2,9,1000,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,1002,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,500,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,402,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,502,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,340,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,250,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,500,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,251,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,891,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0  and  (me.nFaction == 9) and (me.nRouteId == 2) then -- Võ đang kiếm nam
		local item1 = me.AddItem(2,9,970,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,972,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,490,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,392,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,492,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,340,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,250,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,490,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,251,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,881,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 9) and (me.nRouteId == 2) then
		local item11 = me.AddItem(2,9,980,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,982,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,500,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,402,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,502,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,340,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,250,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,500,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,251,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,881,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 10) and (me.nRouteId == 2) then -- CLK Nam
		local item1 = me.AddItem(2,9,990,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,992,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,490,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,392,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,492,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,340,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,250,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,490,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,251,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,901,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 10) and (me.nRouteId == 2) then -- CLK Nũ
		local item11 = me.AddItem(2,9,1000,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,1002,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,500,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,402,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,502,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,340,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,250,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,500,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,251,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,901,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 10) and (me.nRouteId == 1) then -- CLĐ Nam
		local item1 = me.AddItem(2,9,990,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,992,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,490,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,392,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,492,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,340,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,250,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,490,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,251,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,871,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 10) and (me.nRouteId == 1) then -- CLĐ Nữ
		local item11 = me.AddItem(2,9,1000,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,1002,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,500,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,402,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,502,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,340,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,250,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,500,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,251,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,871,10,1,14);
		item20.Bind(1);
		end
Task:DelItem(me, tbItemId2, 1); -- Xóa Túi Hỗ Trợ Tân Thủ	
 end
