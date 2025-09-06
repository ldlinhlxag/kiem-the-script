local tbItem = Item:GetClass("satthu95_bongtim");
tbItem.tbItemInfo = {
bForceBind=1,
};
function tbItem:OnUse()
DoScript("\\script\\event\\cacevent\\tetthieunhi\\bongtim.lua") -- Reload bóng tím
local nCount = me.GetItemCountInBags(18,1,2076,1) -- Gậy Đập Bóng (Đặc Biệt)
if me.CountFreeBagCell() < 10 then -- Check ô trống ở F2 dưới 10
Dialog:SendBlackBoardMsg(me, string.format("Phải có 10 ô trống trong túi hành trang !"));
		return 0;
end
if nCount < 1 then -- Check cần 1 item Gậy Đập Bóng (Đặc Biệt)
Dialog:SendBlackBoardMsg(me, string.format("Để đập <color=pink>Bóng Tím<color> cần <color=yellow> 1 Gậy Đập Bóng (Đặc Biệt)<color> !"));
return
end
self:OnUse1();
end
function tbItem:OnUse1()
local nCount = me.GetItemCountInBags(18,1,2076,1) -- Gậy Đập Bóng (Đặc Biệt)
local tbItemId1	= {18,1,2076,1,0,0}; -- Gậy Đập Bóng (Đặc Biệt)
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	nRand = MathRandom(1, 100);
	local tbRate = {50, 30, 15, 5}; -- Rate Item
	local tbAward = {1 ,2, 3, 4}; -- Rate 4 con số
	for i = 1, 4 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
if (tbAward[nIndex]==1) then -- Xác xuất ra số 1 là 50/100 (50%)
me.AddExp(20000000) -- 20tr Exp
me.AddStackItem(18,1,1,7,self.tbItemInfo,2) -- (18,1,1,7) là Huyền Tinh (Cấp 7) , 2 là số lượng Huyền Tinh (Cấp 7) người chơi nhận được
Dialog:SendBlackBoardMsg(me, string.format("Nhận được 10tr EXP và 2 Huyền Tinh (Cấp 7)!"));
Task:DelItem(me, tbItemId1, 1); -- Xóa 1 Item tbItemId1 được khai báo ở trên là Gậy Đập Bóng (Đặc Biệt)
me.CastSkill(307, 1, -1, me.GetNpc().nIndex);
end
if (tbAward[nIndex]==2) then -- Xác xuất ra số 2 là 30/10000 (30%)
me.AddExp(30000000) -- 30tr Exp
me.AddStackItem(18,1,1,8,self.tbItemInfo,1) -- (18,1,1,8) là Huyền Tinh (Cấp 8) , 2 là số lượng Huyền Tinh (Cấp 8) người chơi nhận được
Dialog:SendBlackBoardMsg(me, string.format("Nhận được 20tr EXP và 1 Huyền Tinh (Cấp 8)!"));
Task:DelItem(me, tbItemId1, 1); -- Xóa 1 Item tbItemId1 được khai báo ở trên là Gậy Đập Bóng (Đặc Biệt)
me.CastSkill(307, 1, -1, me.GetNpc().nIndex);
end
if (tbAward[nIndex]==3) then -- Xác xuất ra số 3 là 15/100 (15%)
me.AddExp(50000000) -- 50tr Exp
me.AddStackItem(18,1,1,8,self.tbItemInfo,2) -- (18,1,1,10) là Huyền Tinh (Cấp 10) , 2 là số lượng Huyền Tinh (Cấp 10) người chơi nhận được
Dialog:SendBlackBoardMsg(me, string.format("Nhận được 10tr EXP và 2 Huyền Tinh (Cấp 8)!"));
Task:DelItem(me, tbItemId1, 1); -- Xóa 1 Item tbItemId1 được khai báo ở trên là Gậy Đập Bóng (Đặc Biệt)
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>Người chơi <color=green>["..me.szName.."]<color> đập <color=pink>Bóng Tím<color> nhận được <color=green>2 Huyền Tinh (Cấp 8)<color> !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Người chơi <color=green>["..me.szName.."]<color> đập <color=pink>Bóng Tím<color> nhận được <color=green>2 Huyền Tinh (Cấp 8)<color> !<color>");
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> đập <color=pink>Bóng Tím<color> nhận được <color=green>2 Huyền Tinh (Cấp 8)<color> !<color>");	
me.CastSkill(307, 1, -1, me.GetNpc().nIndex);
end
if (tbAward[nIndex]==4) then -- Xác xuất ra số 4 là 5/100 (5%)
me.AddExp(100000000) -- 100tr Exp
me.AddStackItem(18,1,1,10,self.tbItemInfo,1) -- (18,1,1,12) là Huyền Tinh (Cấp 12) , 3 là số lượng Huyền Tinh (Cấp 12) người chơi nhận được
Dialog:SendBlackBoardMsg(me, string.format("Nhận được 100tr EXP và 1 Huyền Tinh (Cấp 10)!"));
Task:DelItem(me, tbItemId1, 1); -- Xóa 1 Item tbItemId1 được khai báo ở trên là Gậy Đập Bóng (Đặc Biệt)
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>Người chơi <color=green>["..me.szName.."]<color> đập <color=pink>Bóng Tím<color> nhận được <color=green>1 Huyền Tinh (Cấp 10)<color> !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Người chơi <color=green>["..me.szName.."]<color> đập <color=pink>Bóng Tím<color> nhận được <color=green>1 Huyền Tinh (Cấp 10)<color> !<color>");
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> đập <color=pink>Bóng Tím<color> nhận được <color=green>1 Huyền Tinh (Cấp 10)<color> !<color>");	
me.CastSkill(307, 1, -1, me.GetNpc().nIndex);
end
end