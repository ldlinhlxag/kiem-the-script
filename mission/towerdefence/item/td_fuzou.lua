-- 文件名　：dragonboat.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-04 14:49:00
-- 描  述  ：先祖庇护符

local tbItem = Item:GetClass("td_fuzou");
local GEN_WEAR			= 1;
local GEN_SKILL_ATTACK1 = 2;
local GEN_SKILL_ATTACK2 = 3;
tbItem.ITEM_BOAT_ID = {18,1,638};
tbItem.PRODUCT_SKILL = {
	
	--攻击性
	[1] = {
		--技能Id，名称，描述，改造等级,需要绑定银两
		{1611, "Định ", "Khiến mục tiêu bất động 3 giây, đánh định điểm.",{[1]=1,[2]=1}, 15000},
		{1612, "Lui", "Khiến mục tiêu đẩy lùi cự ly, đánh định điểm.",{[1]=1,[2]=1}, 15000},
		{1613, "Chậm", "Khiến mục tiêu chậm 5 giây, đánh định điểm.",{[1]=1,[2]=1}, 15000},
		{1614, "Loạn", "Làm mục tiêu hỗn loạn 2 giây, đánh định điểm.",{[1]=1,[2]=1}, 15000},
		{1615, "Ngất", "Khiến mục tiêu choáng 2 giây, đánh định điểm.",{[1]=1,[2]=1}, 15000},
	},
};

tbItem.PRODUCT_BOAT = {
	--耐久，攻击改造，防御改造，是否可重造
	[1] = {10,1,0,{1383,1}},	--1级,15耐久，2次攻击性改造，0次防御行改造，变身技能
	[2] = {10,2,0,{1383,2}},	--2级,15耐久，1次攻击性改造，1次防御行改造，变身技能
}

tbItem.GEN_WEAR		  	= 1;
tbItem.GEN_SKILL_ATTACK = {2,3};

function tbItem:GetGenId(nSel, pItem)
	if not pItem then
		return 0;
	end
	local tbProp = self.PRODUCT_BOAT[pItem.nLevel];
	
	local tbSkillAttack = {};
	for _, nGenId in ipairs(Esport.DragonBoat.GEN_SKILL_ATTACK) do
		table.insert(tbSkillAttack, {nGenId, pItem.GetGenInfo(nGenId, 0)})
	end
		
	if nSel == 1 then
		for i=1, tbProp[2] do
			if tbSkillAttack[i] and tbSkillAttack[i][2] <= 0 then
				return tbSkillAttack[i][1];
			end
		end
	end
	return 0;
end


function tbItem:GetTip()
	local szTip  = "";
	local tbProp = self.PRODUCT_BOAT[it.nLevel];
	local nWear  = tbProp[1] - it.GetGenInfo(Esport.DragonBoat.GEN_WEAR, 0);
	local szWear = string.format("Độ bền: %s", nWear);
	if nWear >= 10 then
		szWear = string.format("\n<color=green>%s<color>", szWear);
	elseif nWear >= 5 then
		szWear = string.format("\n%s", szWear);
	else
		szWear = string.format("\n<color=red>%s<color>", szWear);
	end
	
	szTip = szTip .. szWear;
	szTip = szTip .. self:GetSkillTip(it);
	return szTip;
end

function tbItem:GetSkillTip(pItem)
	local tbProp = self.PRODUCT_BOAT[pItem.nLevel];
	local nWear  = tbProp[1] - pItem.GetGenInfo(self.GEN_WEAR, 0);
	
	local tbSkillAttack = {};
	for _, nGenId in ipairs(self.GEN_SKILL_ATTACK) do
		table.insert(tbSkillAttack, pItem.GetGenInfo(nGenId, 0))
	end
	
	local szTip = "";
	for i=1, tbProp[2], 1 do
		if tbSkillAttack[i] > 0 then
			szTip = szTip .. string.format("\n<color=green>Cải tạo tấn công: %s<color>", KFightSkill.GetSkillName(tbSkillAttack[i]));
		else
			szTip = szTip .. string.format("\n<color=gray>Cải tạo tấn công: Chưa cải tạo<color>");
		end
	end
	
	return szTip;
end

function tbItem:CheckSkill(pItem, nSkillId)
	for _, nGenId in pairs(self.GEN_SKILL_ATTACK) do
		if pItem.GetGenInfo(nGenId, 0) == nSkillId then
			return 1;
		end
	end
	return 0;
end

-- 用于竞技平台活动的物品检查函数，不同的活动类型，不同的物品可能需要不同的检查机制
function tbItem:ItemCheckFun(pItem)
	if (not pItem) then
		return 0, "Vật phẩm bảo vệ Hồn Linh Chủ không tồn tại.";
	end
	local nUseBoat = 0;
	local nGenId1 = self:GetGenId(1, pItem);
	local nGenId2 = self:GetGenId(2, pItem);
	if nGenId1 <= 0 and nGenId2 <= 0 then
		nUseBoat = 1;
	end
	if nUseBoat == 0 then
		return 0, "Tổ Tiên Hộ Phù của ngươi vẫn chưa được cải tạo à, như vậy thiệt thòi lắm. Hãy cải tạo rồi mới đến tham gia.";
	end			
	return 1;
end

--改造
function tbItem:OpenProduct(nType)
	Dialog:OpenGift("Đặt Tổ Tiên Hộ Phù cần cải tạo vào", nil, {self.OnProduct, self, nType});
end

function tbItem:OnProduct(nType, tbItem)
	if #tbItem <= 0 or #tbItem >= 2 then
		Dialog:Say("Hãy đặt Tổ Tiên Hộ Phù cần cải tạo vào, chỉ cần đưa ta một Tổ Tiên Hộ Phù.");
		return 0;
	end
	local pItem = tbItem[1][1];
	local szKey = string.format("%s,%s,%s", pItem.nGenre, pItem.nDetail, pItem.nParticular)
	if szKey ~= string.format("%s,%s,%s", unpack(self.ITEM_BOAT_ID)) then
		Dialog:Say("Hãy đặt Tổ Tiên Hộ Phù cần cải tạo vào, đây không phải Tổ Tiên Hộ Phù.");
		return 0;
	end
	local nGenId1 = self:GetGenId(nType, pItem)
	if nGenId1 <= 0 then
		Dialog:Say("Tổ Tiên Hộ Phù của bạn đã cải tạo xong, không thể cải tạo nữa.");
		return 0;
	end
	self:OnProduct1(nType, pItem.dwId);
	return 0;
end

function tbItem:OnProduct1(nSel, nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	local nGenId = self:GetGenId(nSel, pItem)
	if nGenId <= 0 then
		Dialog:Say("Tổ Tiên Hộ Phù của bạn đã hoàn thành cải tạo kỹ năng này, không thể cải tạo nữa.", {{"Quay về", self.OnProductSel, self, nItemId},{"Kết thúc đối thoại"}});
		return 0;
	end
	
	local tbOpt = {};
	for nSelSkill, tbSkill in pairs(self.PRODUCT_SKILL[nSel]) do
		if tbSkill[4][pItem.nLevel] then
			local szSelect = "Cải tạo - "..tbSkill[2];
			if self:CheckSkill(pItem, tbSkill[1]) > 0 then
				szSelect = string.format("<color=green>%s<color>",szSelect);
			end
			table.insert(tbOpt, {szSelect, self.OnProduct2, self, nSel, nSelSkill, nItemId});
		end
	end
	--table.insert(tbOpt, {"返回上层", self.OnProduct1, self, nSel, nItemId});
	table.insert(tbOpt, {"Kết thúc đối thoại"});
	Dialog:Say("Ngươi muốn cải tạo cái gì? Việc cải tạo cần tốn ít bạc, hy vọng ngươi có đủ, ha ha……", tbOpt);
end

function tbItem:OnProduct2(nSel, nSelSkill, nItemId) 
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	local nSkillId 		= self.PRODUCT_SKILL[nSel][nSelSkill][1];
	local szSkillName 	= self.PRODUCT_SKILL[nSel][nSelSkill][2];
	local szSkillDesc 	= self.PRODUCT_SKILL[nSel][nSelSkill][3];
	local nNeedBindMoney = self.PRODUCT_SKILL[nSel][nSelSkill][5];
	
	if self:CheckSkill(pItem, nSkillId) > 0 then
		Dialog:Say("Tổ Tiên Hộ Phù của ngươi đã cải tạo kỹ năng này, không thể cải tạo cùng 1 kỹ năng", {{"Tiếp tục cải tạo Tổ Tiên Hộ Phù này", self.OnProduct1, self, nSel, nItemId},{"Kết thúc đối thoại"}});
		return 0;
	end
	
	local szMsg = string.format("Kỹ năng chọn: <color=yellow>%s<color>\n\nHiệu quả: <color=yellow>%s<color>\n\nPhí cải tạo: <color=yellow>%s bạc khóa<color>", szSkillName, szSkillDesc, nNeedBindMoney);
	local tbOpt = {
		{"Ta muốn cải tạo", self.OnProduct3, self, nSel, nSelSkill, nItemId},
		{"Quay về", self.OnProduct1, self, nSel, nItemId},
		{"Để ta suy nghĩ đã"},
	}
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:OnProduct3(nSel, nSelSkill, nItemId) 
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	local nSkillId = self.PRODUCT_SKILL[nSel][nSelSkill][1];
	local nNeedBindMoney =self.PRODUCT_SKILL[nSel][nSelSkill][5];
	if me.GetBindMoney() < nNeedBindMoney then
		Dialog:Say(string.format("Cải tạo kỹ năng này cần <color=yellow>%s bạc khóa<color>, bạc khóa của ngươi không đủ, không thể cải tạo.", nNeedBindMoney));
		return 0;
	end
	
	me.CostBindMoney(nNeedBindMoney, Player.emKBINDMONEY_COST_EVENT);
	
	local nGenId = self:GetGenId(nSel, pItem)
	if nGenId <= 0 then
		return 0;
	end
	
	pItem.SetGenInfo(nGenId, nSkillId);
	if pItem.IsBind() ~= 1 then
		pItem.Bind(1);
	end
	pItem.Sync();
	Dialog:Say("Bạn đã cải tạo thành công Tổ Tiên Hộ Phù này.");
end
