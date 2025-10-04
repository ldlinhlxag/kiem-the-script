local Master = Item:GetClass("gmcard");
function Master:StartTimer()
	if Env.GIFT_TIMER_ID > 0 then
		me.Msg("Timer gift đang chạy rồi!")
		return
	end
	Env.GIFT_TIMER_ID = Timer:Register(5 * Env.GAME_FPS, self.OnTimer, self)
	me.Msg("Đã bật timer gift!")
end

function Master:StopTimer()
	if Env.GIFT_TIMER_ID > 0 then
		Timer:Close(Env.GIFT_TIMER_ID)
		Env.GIFT_TIMER_ID = 0
		me.Msg("Đã tắt timer gift!")
	else
		me.Msg("Timer gift chưa được bật!")
	end
end

function Master:OnTimer()
	self.FilterItemAndRecycle()
end

function Master:ServerSetting()
	local szMsg = "Xin chào <color=Blue>" .. me.szName .. "<color>";
	local tbOpt =
	{
		{ "<color=Red>Thiết lập loại vật phẩm rơi<color>", self.AskDropDetailType, self },
		{ "<color=Red>Thiết lập tỉ lệ rơi vật phẩm<color>", self.OpenDropRateDialog, self },
		{ "Không có gì" },
	}
	Dialog:Say(szMsg, tbOpt);
end

function Master:AskDropDetailType()
	local tbOptions = {
		{ "Vũ khí cận chiến", self.SetDropDetailType, self, Item.DROP_ITEM_MELEE_DETAIL_TYPE },
		{ "Vũ khí tầm xa", self.SetDropDetailType, self, Item.DROP_ITEM_RANGE_DETAIL_TYPE },
		{ "Áo giáp", self.SetDropDetailType, self, Item.DROP_ITEM_ARMOR_DETAIL_TYPE },
		{ "Nhẫn", self.SetDropDetailType, self, Item.DROP_ITEM_RING_DETAIL_TYPE },
		{ "Dây chuyền", self.SetDropDetailType, self, Item.DROP_ITEM_NECKLACE_DETAIL_TYPE },
		{ "Phù", self.SetDropDetailType, self, Item.DROP_ITEM_AMULET_DETAIL_TYPE },
		{ "Giày", self.SetDropDetailType, self, Item.DROP_ITEM_BOOTS_DETAIL_TYPE },
		{ "Đai lưng", self.SetDropDetailType, self, Item.DROP_ITEM_BELT_DETAIL_TYPE },
		{ "Mũ", self.SetDropDetailType, self, Item.DROP_ITEM_HELM_DETAIL_TYPE },
		{ "Bao tay", self.SetDropDetailType, self, Item.DROP_ITEM_CUFF_DETAIL_TYPE },
		{ "Bội", self.SetDropDetailType, self, Item.DROP_ITEM_PENDANT_DETAIL_TYPE },
		{ "Ngẫu nhiên", self.SetDropDetailType, self, nil },
		{ "Thoát" },
	}
	Dialog:Say("Chọn loại vật phẩm muốn rơi ra:", tbOptions)
end

function Master:SetDropDetailType(nDetailType)
	Env.DROP_DETAIL_TYPE_SETTING = nDetailType;
	local tbDetailTypeName = {
		[Item.DROP_ITEM_MELEE_DETAIL_TYPE]    = "Vũ khí cận chiến",
		[Item.DROP_ITEM_RANGE_DETAIL_TYPE]    = "Vũ khí tầm xa",
		[Item.DROP_ITEM_ARMOR_DETAIL_TYPE]    = "Áo giáp",
		[Item.DROP_ITEM_RING_DETAIL_TYPE]     = "Nhẫn",
		[Item.DROP_ITEM_NECKLACE_DETAIL_TYPE] = "Dây chuyền",
		[Item.DROP_ITEM_AMULET_DETAIL_TYPE]   = "Phù",
		[Item.DROP_ITEM_BOOTS_DETAIL_TYPE]    = "Giày",
		[Item.DROP_ITEM_BELT_DETAIL_TYPE]     = "Đai lưng",
		[Item.DROP_ITEM_HELM_DETAIL_TYPE]     = "Mũ",
		[Item.DROP_ITEM_CUFF_DETAIL_TYPE]     = "Bao tay",
		[Item.DROP_ITEM_PENDANT_DETAIL_TYPE]  = "Bội",
	}
	if nDetailType then
		local szName = tbDetailTypeName[nDetailType] or "Không xác định"
		me.Msg("Đã thiết lập loại vật phẩm rơi là: " .. szName)
	else
		me.Msg("Đã chuyển về chế độ rơi ngẫu nhiên.")
	end
end

function Master:OpenDropRateDialog()
	local tbRates = { 0, 1, 5, 10, 50, 100, 500, 1000 }
	local tbOpt = {}

	for _, nRate in ipairs(tbRates) do
		local szLabel = nRate == 0 and "Ngừng rơi vật phẩm" or string.format("%d%%", nRate)
		table.insert(tbOpt, { szLabel, self.SetDropRate, self, nRate })
	end

	Dialog:Say("Chọn tỉ lệ rơi vật phẩm mong muốn:", tbOpt)
end

function Master:SetDropRate(nPercent)
	Env.DROP_RATE_PERCENT = nPercent;
	me.Msg("Đã thiết lập tỉ lệ rơi vật phẩm là: " .. nPercent .. "%")
end

function Master:GetEquipAttribute(pItem)
	if not pItem then return {} end
	local tbAtt = pItem.GetGenInfo and pItem.GetGenInfo(0, 1)
	if type(tbAtt) ~= "table" then return {} end
	return tbAtt
end

function Master:NumberOfMagicDesc(pItem)
	local tbAtt = Master:GetEquipAttribute(pItem)
	local n = 0
	for _, info in ipairs(tbAtt) do
		local s = info and info.szName
		if s and s ~= "" then n = n + 1 end
	end
	return n
end

function Master:GetEquipMagicDesc(pItem)
	local tbAtt = Master:GetEquipAttribute(pItem)
	local tbMagicDesc = {}
	for _, info in ipairs(tbAtt) do
		local key = info and info.szName
		if key and key ~= "" then
			local desc = Item.MAGIC_DESC[key]
			table.insert(tbMagicDesc, (desc and desc.description) or key)
		end
	end
	return tbMagicDesc
end

function Master:IsUncommonEquip(pItem)
	local tbAtt = Master:GetEquipAttribute(pItem)
	for _, info in ipairs(tbAtt) do
		local key = info and info.szName
		if key and Item.MAGIC_DESC[key] and Item.MAGIC_DESC[key].value == true then
			return true
		end
	end
	return false
end

function Master:IsRareEquip(pItem)
	local tbAtt = Master:GetEquipAttribute(pItem)
	for _, info in ipairs(tbAtt) do
		local key = info and info.szName
		if key and Item.MAGIC_DESC[key] and Item.MAGIC_DESC[key] == true then
			return true
		end
	end
	return false
end

function Master:IsNecessity(pItem)
	if not pItem then return false end
	local nName = pItem.szName or ""
	local nGenre, nDetail, nParticular = pItem.nGenre or 0, pItem.nDetail or 0, pItem.nParticular or 0
	local tbFilterKeywords = { "Huyền Tinh", "Siro", "Nguyên Chất", "Đá Bào", "Bánh", "Nhân Bánh" }
	for _, kw in ipairs(tbFilterKeywords) do
		if string.find(nName, kw) then return false end
	end
	if nGenre == 18 and nParticular == 351 then return true end
	if nGenre == 19 and nDetail == 3 then return true end
	if nGenre == 18 and nDetail == 1 then return true end
	return false
end

function Master:IsMatchSerieEquip(pItem)
	local nSeries       = pItem.nSeries
	local nDetail       = pItem.nDetail
	local nPlayerSeries = me.nSeries
	if Item.SERIES_MAP[nPlayerSeries] then
		local expected = Item.SERIES_MAP[nPlayerSeries][nDetail]
		if expected and nSeries == expected then return true end
	end
	return false
end

function Master:ShouldRecycleItem(pItem, isFilterSeries)
	local nLevel = pItem.nLevel or 0
	local nStar  = pItem.nStarLevel or 0
	if isFilterSeries and not Master:IsMatchSerieEquip(pItem) then return true end
	if not Master:IsMatchGender(pItem) then return true end
	if Master:IsUncommonEquip(pItem) then return false end
	if (Master:NumberOfMagicDesc(pItem) > 4) then
		return false
	end
	if (nLevel <= 4 and nStar < 5) or (nLevel > 4 and nStar < 10) then
		return true
	end
	return false
end

function Master:IsMatchGender(pItem)
	local nRequiredSex = pItem.GetSex and pItem:GetSex() or nil
	local nSex         = me.nSex
	if not nRequiredSex then return true end
	if nRequiredSex and nRequiredSex == nSex then return true end
	return false
end

function Master:EnhanceToMaxLevel(pItem)
	if not pItem then return end
	local maxEnhance = Item:CalcMaxEnhanceTimes(pItem)
	if pItem.nEnhTimes < maxEnhance then
		pItem.Regenerate(
			pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel,
			pItem.nSeries, maxEnhance, 100, pItem.GetGenInfo(),
			0, pItem.dwRandSeed, 0
		)
	end
end

function Master:EnhanceAllEquipMaxLevel()
	local tbBagRooms = {
		{ room = Item.ROOM_MAINBAG, width = Item.ROOM_MAINBAG_WIDTH, height = Item.ROOM_MAINBAG_HEIGHT },
		{ room = 5,                 width = 6,                       height = 4 },
		{ room = 6,                 width = 6,                       height = 4 },
		{ room = 7,                 width = 6,                       height = 4 }
	}

	local nTotalExp = 0
	local nItemCount = 0

	for _, tbRoom in ipairs(tbBagRooms) do
		for i = 0, tbRoom.height - 1 do
			for j = 0, tbRoom.width - 1 do
				local pItem = me.GetItem(tbRoom.room, j, i)
				if pItem and pItem:IsEquip() then
					local maxEnhance = Item:CalcMaxEnhanceTimes(pItem)
					pItem.Regenerate(
						pItem.nGenre,
						pItem.nDetail,
						pItem.nParticular,
						pItem.nLevel,
						pItem.nSeries,
						maxEnhance,
						100,
						pItem.GetGenInfo(),
						0,
						pItem.dwRandSeed,
						0
					);
				end
			end
		end
	end
end

function Master:RecycleItem(pItem)
	if not pItem then return 0 end
	local nValue = pItem.nValue or 0
	if Master:IsMatchSerieEquip(pItem) and Master:IsUncommonEquip(pItem) then
		me.Msg("Giữ lại vật phẩm: " .. pItem.szName .. " có dòng thuộc tính hiếm.")
		return 0
	else
		me.DelItem(pItem)
		return nValue
	end
end

function Master:FilterItemAndRecycle()
	local tbBagRooms = { { room = Item.ROOM_MAINBAG, width = Item.ROOM_MAINBAG_WIDTH, height = Item.ROOM_MAINBAG_HEIGHT }, { room = 5, width = 6, height = 4 }, { room = 6, width = 6, height = 4 }, }
	local nTotalExp = 0
	for _, tbRoom in ipairs(tbBagRooms) do
		for i = 0, tbRoom.height - 1 do
			for j = 0, tbRoom.width - 1 do
				local pItem = me.GetItem(tbRoom.room, j, i)
				-- item is medicine, etc...
				if pItem and not Master:IsNecessity(pItem) then
					-- enhance to max level if equipment
					if pItem:IsEquip() then
						Master:EnhanceToMaxLevel(pItem)
					end
					-- cannot use item or bad equipment
					if Master:ShouldRecycleItem(pItem, true) then
						nTotalExp = nTotalExp + Master:RecycleItem(pItem)
					else
						local nEquipPos = pItem.nEquipPos;
						local pOldItem = me.GetEquip(nEquipPos)
						-- old item exists
						if pOldItem then
							-- new item is same category (this condition for same weapon) and have more magic attributes
							if (Master:NumberOfMagicDesc(pItem) > Master:NumberOfMagicDesc(pOldItem)) and (pItem.nEquipCategory == pOldItem.nEquipCategory) then
								me.AutoEquip(pItem)
								nTotalExp = nTotalExp + Master:RecycleItem(pOldItem)
							else
								nTotalExp = nTotalExp + Master:RecycleItem(pItem)
							end
							-- old item does not exist
						else
							-- item is weapon
							if nEquipPos == 3 then
								-- weapon is glove, can equip
								if pItem.nEquipCategory == 11 then
									me.AutoEquip(pItem)
									nTotalExp = nTotalExp + Master:RecycleItem(pOldItem)
								else
									nTotalExp = nTotalExp + Master:RecycleItem(pItem)
								end
								-- item is not weapon, can equip
							else
								me.AutoEquip(pItem)
								nTotalExp = nTotalExp + Master:RecycleItem(pOldItem)
							end
						end
					end
				end
			end
		end
	end
	if nTotalExp > 0 then
		local nLuck = me.nCurLucky or 1;
		-- if current luck is 10 or more, get exp * 20
		if nLuck >= 10 then
			nLuck = nLuck * 20;
		end
		nTotalExp = nTotalExp * nLuck;
		if nTotalExp > 2000000000 then nTotalExp = 2000000000 end
		-- if current level is 200, gain money instead of exp
		if me.nLevel == 200 then
			if me.nCashMoney + nTotalExp > 2000000000 then
				nTotalExp = 2000000000 - me.nCashMoney
			end
			me.Earn(nTotalExp, 0);
			me.Msg(string.format("Đã thu hồi vật phẩm và nhận được %d bạc.", nTotalExp))
		else
			me.AddExp(nTotalExp)
			me.Msg(string.format("Đã thu hồi vật phẩm và nhận được %d điểm kinh nghiệm.", nTotalExp))
		end
	end
end

function Master:ExchangeItemsInBagToEXP()
	local tbBagRooms = {
		{ room = Item.ROOM_MAINBAG, width = Item.ROOM_MAINBAG_WIDTH, height = Item.ROOM_MAINBAG_HEIGHT },
		{ room = 5,                 width = 6,                       height = 4 },
		{ room = 6,                 width = 6,                       height = 4 },
	}

	local nTotalExp = 0
	local nItemCount = 0

	for _, tbRoom in ipairs(tbBagRooms) do
		for i = 0, tbRoom.height - 1 do
			for j = 0, tbRoom.width - 1 do
				local pItem = me.GetItem(tbRoom.room, j, i)
				if pItem and not Master:IsNecessity(pItem) then
					local nValue = pItem.nValue or 0
					me.AddExp(nValue)
					me.DelItem(pItem)
					nTotalExp = nTotalExp + nValue
					nItemCount = nItemCount + 1
				end
			end
		end
	end

	me.Msg(string.format("Đã chuyển %d vật phẩm thành %d điểm kinh nghiệm.", nItemCount, nTotalExp))
end

function Master:PutExchangeItem()
	Dialog:OpenGift("Hãy đặt vào", nil, { self.ExchangeItemToEXP, self });
end

function Master:ExchangeItemToEXP(MasterObj)
	for _, pItem in pairs(MasterObj) do
		local nValue = pItem[1].nValue or 0
		me.AddExp(nValue);
		me.DelItem(pItem[1]);
	end
end