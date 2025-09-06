
-- ����ܽű���
Require("\\script\\lifeskill\\define.lua");

-------------------------------------------------------------------------
-- [C/S]ϵͳ������ʱ���ʼ��
function LifeSkill:OnInit()
	local nSkillCount	= self:LoadAllSkill();
	local nRecipeCount	= self:LoadAllRecipe();
	self:DbgOut(string.format("LifeSkill System Inited! %d Skill(s) and %d Recipe(s) loaded!", nSkillCount, nRecipeCount));
end


function LifeSkill:_OnLogin()
	local nSkillCount = self:LoadSkill();
	local nRecipeCount = self:LoadRecipe();

	-- ������Щ�����Զ���ӵ��䷽	
	local tbPlayerLifeSkills = self:GetMyLifeSkill(me);
	for _, tbSkill in pairs(tbPlayerLifeSkills.tbLifeSkills) do
		for _, tbBelongRecipe in pairs(self.tbLifeSkillDatas[tbSkill.nSkillId].tbRecipeDatas) do
			if ((self:HasLearnRecipe(me, tbBelongRecipe.ID) ~= 1) and tbBelongRecipe.AutoAppend == 1 and tbBelongRecipe.SkillLevel <= tbSkill.nLevel and tbBelongRecipe.Storage == 0) then
				self:AddRecipe(me, tbBelongRecipe.ID);
			end
		end		
	end

	
	--���ӻ�䷽
	--if me.nLevel >= 20 then
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	for nRecipeId, tbEventRecipe in pairs(self.tbStorageDatas) do
		if (not tbEventRecipe.nAutoAppend or tbEventRecipe.nAutoAppend == 1) then
			if tbEventRecipe.nStartDate == 0 and tbEventRecipe.nEndDate == 0 then
				self:AddRecipe(me, nRecipeId, 0);
			elseif nNowDate >= tbEventRecipe.nStartDate and nNowDate < tbEventRecipe.nEndDate then
				self:AddRecipe(me, nRecipeId, 0)
			end
		end
	end
	--end

	self:DbgOut(string.format(me.szName.." %d Skill (s) and %d Recipe(s) Loaded!", nSkillCount, nRecipeCount));

end

function LifeSkill:_OnLogout()
	if (MODULE_GAMESERVER) then
		local nSkillCount = 0;
		local nRecipeCount = 0;
		
		local tbPlayerLifeSkills = self:GetMyLifeSkill(me);
		for _, tbSkill in pairs(tbPlayerLifeSkills.tbLifeSkills) do
			me.SaveAddLifeSkill(tbSkill.nSkillId, tbSkill.nLevel, tbSkill.nExp);
			nSkillCount = nSkillCount + 1;
			for _, tbRecipe in pairs(tbSkill.tbRecipes) do
				me.SaveAddRecipe(tbRecipe.nRecipeId);
				nRecipeCount = nRecipeCount + 1;
			end
		end
		
		self:DbgOut(string.format(me.szName.." %d Skill (s) and %d Recipe(s) Saveed!", nSkillCount, nRecipeCount));
		
	end
end


-------------------------------------------------------------------------
function LifeSkill:LoadSkill()
	local tbSkillList = me.GetLifeSkillList();
	if (not tbSkillList or #tbSkillList == 0) then
		return 0;
	end
	
	for _, tbSkill in ipairs(tbSkillList) do
		self:NewSkill(me, tbSkill.nSkillId, tbSkill.nLevel, tbSkill.nExp);
	end
	
	return #tbSkillList;
end


-------------------------------------------------------------------------
function LifeSkill:NewSkill(pPlayer, nSkillId, nLevel, nCurExp)
	local tbSkillData = self.tbLifeSkillDatas[nSkillId];
	if (not tbSkillData) then
		pPlayer.Msg("Không biết kỹ năng ".. nSkillId);
		return nil;
	end
	
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	if (tbPlayerLifeSkills.tbLifeSkills[nSkillId]) then
		pPlayer.Msg("Lặp lại các kỹ năng "..tbPlayerLifeSkills.tbLifeSkills[nSkillId].tbSkillData.Name);
		return nil;
	end
	
	local tbLifeSkill = Lib:NewClass(self._tbSkillClassBase);
	
	tbLifeSkill.nSkillId	= nSkillId;
	tbLifeSkill.nLevel		= nLevel;
	tbLifeSkill.nExp		= nCurExp or 0;
	tbLifeSkill.tbSkillData = tbSkillData;
	tbLifeSkill.tbRecipes	= {};
	tbLifeSkill.me			= pPlayer;
	
	tbPlayerLifeSkills.tbLifeSkills[nSkillId]	= tbLifeSkill;
	
	return tbLifeSkill;
end


-------------------------------------------------------------------------
function LifeSkill:LoadRecipe()
	local tbRecipeList = me.GetRecipeList();
	if (not tbRecipeList or #tbRecipeList == 0) then
		return 0;
	end
	
	for _, nRecipeId in ipairs(tbRecipeList) do
		self:NewRecipe(me, nRecipeId);
	end
	
	return #tbRecipeList;
end

-------------------------------------------------------------------------
function LifeSkill:NewRecipe(pPlayer, nRecipeId)
	local tbRecipeData = self.tbRecipeDatas[nRecipeId];
	if (not tbRecipeData) then
		pPlayer.Msg("Không biết công thức "..nRecipeId);
		return nil;
	end
	
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[tbRecipeData.Belong];
	if (not tbSkill) then
		pPlayer.Msg("Không thuộc kỹ năng "..tbRecipeData.Belong..","..tbRecipeData.Name);
		return nil;
	end
	
	if (tbSkill.tbRecipes[nRecipeId]) then
--		pPlayer.Msg("�ظ��䷽ - "..tbRecipeData.Name);
		return nil;
	end
	local tbRecipe = Lib:NewClass(self._tbRecipeClassBase);
	
	tbRecipe.nRecipeId = nRecipeId;
	tbRecipe.tbRecipeData = tbRecipeData;
	tbRecipe.tbSkillData =  self.tbLifeSkillDatas[tbRecipeData.Belong];
	tbSkill.tbRecipes[nRecipeId] = tbRecipe;
	
	return tbRecipe;
end


-------------------------------------------------------------------------
-- Ϊ������һ������
function LifeSkill:AddLifeSkill(pPlayer, nSkillId, nLevel)
	local tbLifeSkill = LifeSkill:NewSkill(pPlayer, nSkillId, nLevel);
	if (not tbLifeSkill) then
		return;
	end
	pPlayer.SaveAddLifeSkill(tbLifeSkill.nSkillId, tbLifeSkill.nLevel, tbLifeSkill.nExp); -- ���ݴ浽������ȥ
	self:AddRecipeForLevelChange(pPlayer, nSkillId, nLevel);
	self:AddTitleForLevelChange(pPlayer, nSkillId, nLevel);
end


-------------------------------------------------------------------------
-- ɾ�����һ������
function LifeSkill:RemoveLifeSkill(pPlayer, nSkillId)
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nSkillId];
	if (not tbSkill) then
		pPlayer.Msg("Nếu không có kỹ năng này: ",nSkillId);
		return;
	end
	
	for _, tbRecipe in pairs(tbSkill.tbRecipes) do
		self:RemoveRecipe(pPlayer, tbRecipe.nRecipeId);
	end
	
	tbPlayerLifeSkills[nSkillId] = nil;
	pPlayer.SaveDelLifeSkill(nSkillId);
	pPlayer.Msg("Hủy bỏ kỹ năng sống thành công.");
end


-------------------------------------------------------------------------
-- Ϊ������һ���䷽
function LifeSkill:AddRecipe(pPlayer, nRecipeId, nMsg)
	local nBelongSkillId = self:GetBelongSkillId(nRecipeId);
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nBelongSkillId];
	local tbRecipeData = self.tbRecipeDatas[nRecipeId];
	local nStorageRecipeId = nil;
	if self.tbStorageDatas[nRecipeId] then
		nStorageRecipeId = 1;
	end
	if (not tbRecipeData) then
		if not nStorageRecipeId then
			pPlayer.Msg("Không có công thức này");
		end
		return;
	end
	
	if (not tbSkill) then
		if not nStorageRecipeId then
			pPlayer.Msg("Kỹ năng này đã có rồi, không thể học tiếp");
		end
		return;
	end
	
	if (tbRecipeData.SkillLevel > tbSkill.nLevel) then
		if not nStorageRecipeId then
			pPlayer.Msg("Kỹ năng trình độ là không đủ, không thể học công thức này");
		end
		return;
	end
	
	local tbRecipe = LifeSkill:NewRecipe(pPlayer, nRecipeId);
	
	if (not tbRecipe) then
		return;
	end
	
	pPlayer.SaveAddRecipe(nRecipeId);
	if nMsg ~= 0 then
		pPlayer.Msg("Kỹ năng sống được nâng cấp, có thể chế tạo thêm vật phẩm mới");
	end
	return 1;
end


-------------------------------------------------------------------------
-- ɾ�����һ���䷽
function LifeSkill:RemoveRecipe(pPlayer, nRecipeId)
	local nBelongSkillId = self:GetBelongSkillId(nRecipeId);
	if (self:HasLearnSkill(pPlayer, nBelongSkillId) ~= 1) then
		pPlayer.Msg("Hủy bỏ các lỗi công thức, công thức này không thuộc về kỹ năng!");
		return;
	end
	
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nBelongSkillId];
	if (not tbSkill.tbRecipes[nRecipeId]) then
		pPlayer.Msg("Hủy bỏ công thức không xác định công thức không tồn tại:", nRecipeId)
	end
	
	tbSkill.tbRecipes[nRecipeId] = nil;
	pPlayer.SaveDelRecipe(nRecipeId);
	pPlayer.Msg("Xóa công thức thành công!");
end


-------------------------------------------------------------------------
-- Ϊָ��������Ӿ���
function LifeSkill:AddSkillExp(pPlayer, nSkillId, nExp)

	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nSkillId];
	if (not tbSkill) then
		return;
	end
	
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	tbSkill.nExp  = tbSkill.nExp + nExp;
	local szName  = self.tbLifeSkillDatas[nSkillId].Name;
	pPlayer.Msg("Bạn nhận được "..nExp.." điểm kinh nghiệm chế tạo");

	
	local nGene = tbSkill.tbSkillData.Gene;
	local nAddExp = 0;
	if (nGene == 0) then --���쾭��
		nAddExp = pPlayer.GetTask(StatLog.StatTaskGroupId , 8) + nExp;
		pPlayer.SetTask(StatLog.StatTaskGroupId , 8, nAddExp);
	else	-- �ӹ�
		nAddExp = pPlayer.GetTask(StatLog.StatTaskGroupId , 7) + nExp;
		pPlayer.SetTask(StatLog.StatTaskGroupId , 7, nAddExp);
	end
	
	-- TODO:liuchang ������ߵȼ�
	local nNextLevel = tbSkill.nLevel + 1;
	
	while (true) do
		if (nNextLevel > tbSkill.tbSkillData.nMaxLevel) then
			nNextLevel = tbSkill.tbSkillData.nMaxLevel;
			break;
		else
			if (self:CanLevelUp(nSkillId, nNextLevel, tbSkill.nExp) == 1) then
				if (self:SetSkillLevel(pPlayer, nSkillId, nNextLevel) == 1) then
					tbSkill.nExp = tbSkill.nExp - self:GetLevelUpExp(nSkillId, nNextLevel);
					nNextLevel = nNextLevel + 1;
				else
					return;
				end
			else
				break;
			end
		end;
	end;		

	if (tbSkill.nExp > self:GetLevelUpExp(nSkillId, nNextLevel)) then
		tbSkill.nExp = self:GetLevelUpExp(nSkillId, nNextLevel);
	end
	
	pPlayer.SaveLifeSkillExp(nSkillId, tbSkill.nExp);

end

-------------------------------------------------------------------------

-- ��ȡʦͽ�ɾ�
function LifeSkill:GetAchievement(pPlayer, nLevel)
	if (not pPlayer or nLevel <= 0) then
		return;
	end
	if (nLevel >= 30) then
		Achievement:FinishAchievement(pPlayer.nId, Achievement.LIFISKILL_30);
	elseif (nLevel >= 20) then
		Achievement:FinishAchievement(pPlayer.nId, Achievement.LIFISKILL_20);
	end
end

-------------------------------------------------------------------------
-- �趨�ȼ�
function LifeSkill:SetSkillLevel(pPlayer, nSkillId, nLevel)
	if (not nLevel or nLevel <= 0) then
		nLevel = 1;
	end
	
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nSkillId];
	if (not tbSkill) then
		return nil;
	end
	
	if (tbSkill.nLevel == tbSkill.tbSkillData.MaxLevel) then
		return 0;
	end
	
	tbSkill.nLevel = nLevel;
	if (tbSkill.nLevel > tbSkill.tbSkillData.MaxLevel) then
		tbSkill.nLevel = tbSkill.tbSkillData.MaxLevel;
	end
	
	pPlayer.SaveLifeSkillLevel(nSkillId, tbSkill.nLevel);

	self:AddRecipeForLevelChange(pPlayer, nSkillId, nLevel);
	
	self:AddTitleForLevelChange(pPlayer, nSkillId, nLevel);
	
	self:GetAchievement(pPlayer, nLevel);
	
	local nGene = tbSkill.tbSkillData.Gene;
	--дLog
	local bMax = 1;
	for iSkillId, vtbSkill in pairs(tbPlayerLifeSkills.tbLifeSkills) do
		if (vtbSkill.nGene == nGene and nLevel < vtbSkill.nLevel) then
			bMax = 0;
			break;
		end
	end	
	if bMax == 1 then
		if (nGene == 0) then
			KStatLog.ModifyField("roleinfo", pPlayer.szName, "��������", tbSkill.tbSkillData.Name);
			KStatLog.ModifyField("roleinfo", pPlayer.szName, "�������ܵȼ�", nLevel);
			--KStatLog.ModifyMax("roleinfo", pPlayer.szName, "����ϵ���ܵȼ�", nLevel)
		else
			--KStatLog.ModifyField("roleinfo", pPlayer.szName, "�ȼ���ߵļӹ�ϵ����", tbSkill.tbSkillData.Name)
			--KStatLog.ModifyMax("roleinfo", pPlayer.szName, "�ӹ�ϵ���ܵȼ�", nLevel)
		end
	end
		
	return 1;
end



-------------------------------------------------------------------------
-- ����ָ���ȼ���Ҫ�ľ���(ֻ���ǵ���)
function LifeSkill:GetLevelUpExp(nSkillId, nLevel)
	return self.tbLifeSkillDatas[nSkillId].tbSkillExpMap[nLevel];
end


-------------------------------------------------------------------------
-- ��������ָ�������Ƿ��������
function LifeSkill:CanLevelUp(nSkillId, nLevel, nExp)
	local nNeedExp = self:GetLevelUpExp(nSkillId, nLevel);
	if (not nExp or not nNeedExp) then
		print("LifeSkillExpError", nSkillId, nLevel, nExp);
		return 0;
	end
	if (nExp >= nNeedExp) then
		return 1;
	end
	
	return 0;
end


-------------------------------------------------------------------------
-- ���ָ�����ܵĵȼ�
function LifeSkill:GetSkillLevel(pPlayer, nSkillId)
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nSkillId];
	if (not tbSkill) then
		return 0;
	end
	
	return tbSkill.nLevel;
end


-------------------------------------------------------------------------
-- ����ָ�����ܵ�ǰ����
function LifeSkill:GetSkillCurExp(pPlayer, nSkillId)
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nSkillId];
	if (not tbSkill) then
		return 0;
	end
	
	return tbSkill.nExp;
end


-------------------------------------------------------------------------
-- �Ƿ�ѧϰ��ĳ�ּ���
function LifeSkill:HasLearnSkill(pPlayer, nSkillId)
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	if (tbPlayerLifeSkills.tbLifeSkills[nSkillId]) then
		return 1;
	else
		return 0;
	end
end


-------------------------------------------------------------------------
-- ���֪���䷽��������
function LifeSkill:GetBelongSkillId(nRecipeId)
	return self.tbRecipeDatas[nRecipeId].Belong;
end


-------------------------------------------------------------------------
-- �����Ƿ�ѧ��ָ���䷽
function LifeSkill:HasLearnRecipe(pPlayer, nRecipeId)
	if not self.tbRecipeDatas[nRecipeId] then   -- �п���Ϊ�� zounan
		Setting:SetGlobalObj(pPlayer);
		Player:ProcessIllegalProtocol("LifeSkill:HasLearnRecipe","nRecipeId", nRecipeId);
		Setting:RestoreGlobalObj();
		return 0;
	end
	local nBelongSkillId = self.tbRecipeDatas[nRecipeId].Belong;
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nBelongSkillId];
	if (not tbSkill) then
		return 0;
	end

	if (tbSkill.tbRecipes[nRecipeId]) then
		return 1;
	else
		return 0;
	end
end


-------------------------------------------------------------------------
-- ������Ʒ
function LifeSkill:MakeProduct(nRecipeId)
	if me.IsAccountLock() ~= 0 then
		me.Msg("Tài khoản của bạn đang khóa, không thể thực hiện thao tác ");
		return;
	end
	if (self:HasLearnRecipe(me, nRecipeId) ~= 1) then
		me.Msg("Không có công thức cụ thể");
		me.SynProduceResult(nRecipeId, 0);
		return;
	end
	
	if (me.nFightState > 0) then
		me.Msg("Không thể sử dụng kỹ năng sống");
		me.SynProduceResult(nRecipeId, 0);
		return 0;
	end
	
	if (me.GetNpc().nDoing ~= Npc.DO_STAND) then
		me.Msg("Gian hàng chỉ được sử dụng trong tình trạng kỹ năng sống.");
		me.SynProduceResult(nRecipeId, 0);
		return 0;
	end
	
	--��䷽
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	if self.tbStorageDatas[nRecipeId] then
		if self.tbStorageDatas[nRecipeId].nStartDate > 0 and self.tbStorageDatas[nRecipeId].nEndDate > 0 then
			if nNowDate < self.tbStorageDatas[nRecipeId].nStartDate or nNowDate >= self.tbStorageDatas[nRecipeId].nEndDate then
				me.Msg("Công thức cho công thức hoạt động hiện nay không hợp lệ.");
				me.SynProduceResult(nRecipeId, 0);
				return 0;
			end
		end
	end
	
	
	local tbRecipeData = self.tbRecipeDatas[nRecipeId];
	for _,stuff in ipairs(tbRecipeData.tbStuffSet) do
		if (stuff.nCount and stuff.nCount > 0) then
			
			local nCount = me.GetItemCountInBags(stuff.tbItem[1], stuff.tbItem[2], stuff.tbItem[3], stuff.tbItem[4], stuff.tbItem[5], LifeSkill:GetBindType(stuff.nBind));
			if (nCount < stuff.nCount) then
				me.Msg("Nguyên liệu không đủ, không thể chế tạo");
				me.SynProduceResult(nRecipeId, 0);
				return 0;
			end
		end
	end
	
	local tbPlayerLifeSkills = self:GetMyLifeSkill(me);
	local nBelongSkillId = self:GetBelongSkillId(nRecipeId);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nBelongSkillId];
	local nGene = tbSkill.tbSkillData.Gene;
	
	if (nGene == 1) then
		if (me.dwCurGTP < tbRecipeData.Cost) then
			me.Msg("Không đủ hoạt lực không thể chế tạo vật phẩm.");
			me.SynProduceResult(nRecipeId, 0);
			return;
		end
	elseif (nGene == 0) then -- ����ϵ
		if (me.dwCurMKP < tbRecipeData.Cost) then
			me.Msg("Không đủ tinh lực không thể chế tạo vật phẩm");
			me.SynProduceResult(nRecipeId, 0);
			return 0;
		end 
	else
		print("��������಻Ӧ����0,1֮�����", nGene);
		assert(false);
	end
	
	local nInterval = tbRecipeData.MakeTime;
	
	local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,		
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_BUYITEM,
		Player.ProcessBreakEvent.emEVENT_SELLITEM,
	}
	local szMsg = "";
	if (nGene == 0) then
		szMsg = "Đang chế tạo..";
	elseif(nGene == 1) then 
		szMsg = "Đang chế tạo..";
	end

	GeneralProcess:StartProcess(szMsg, nInterval, {self.OnMakeProductResult, self, nRecipeId, 0}, {self.OnMakeProductResult, self, nRecipeId, 1}, tbEvent);
	
end

function LifeSkill:OnMakeProductResult(nRecipeId, bBreak)

	if (bBreak == 1) then
		me.Msg("Chế tạo bị gián đoạn.");
		me.SynProduceResult(nRecipeId, 0);
		return;	
	end
	
	if (self:HasLearnRecipe(me, nRecipeId) == 0) then
		me.Msg("Công thức này không học cách làm thành công.");
		me.SynProduceResult(nRecipeId, 0);
		return;
	end
	
	local tbRecipeData = self.tbRecipeDatas[nRecipeId];
	
	local tbSkillData  = self.tbLifeSkillDatas[tbRecipeData.Belong];
	local szLifeSkillType = "";
	
	if (tbSkillData.nGene == 0) then
		szLifeSkillType = "�ϳ�"..tbRecipeData.Name;
	elseif(tbSkillData.nGene == 1) then
		szLifeSkillType = "�ӹ�"..tbRecipeData.Name;
	end
	
	--��䷽
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	if self.tbStorageDatas[nRecipeId] then
		if self.tbStorageDatas[nRecipeId].nStartDate > 0 and self.tbStorageDatas[nRecipeId].nEndDate > 0 then
			if nNowDate < self.tbStorageDatas[nRecipeId].nStartDate or nNowDate >= self.tbStorageDatas[nRecipeId].nEndDate then
				me.Msg("Công thức cho công thức hoạt động hiện nay không hợp lệ.");
				me.SynProduceResult(nRecipeId, 0);
				return 0;
			end
		end
	end
	
	local nCanProduct, tbFunExecute, szExtendInfo, tbTempProductSet = SpecialEvent.ExtendAward:DoCheck("LifeSkill", me, nRecipeId)
	local tbProductSet = tbRecipeData.tbProductSet;
	if nCanProduct == 1 and tbTempProductSet and #tbTempProductSet > 0 then
		tbProductSet = tbTempProductSet;
		if szExtendInfo and szExtendInfo ~= "" then
			me.Msg(szExtendInfo);
		end
	end
	
	local nPercent = MathRandom(100);
	local tbFinalProduct = nil;
	for _, tbProduct in ipairs(tbProductSet) do
		nPercent = nPercent - tbProduct.nRate;
		local tbItem = tbProduct.tbItem;
		local tbBaseProp = KItem.GetItemBaseProp(tbItem[1], tbItem[2], tbItem[3], tbItem[4]);
		if (nPercent <= 0) and tbBaseProp then
			local bBind = LifeSkill:GetBindType(tbProduct.nBind);
			if bBind == -1 then
				bBind = KItem.IsItemBindByBindType(tbBaseProp.nBindType);
			end
			tbFinalProduct =
			{
				nGenre		= tbItem[1],
				nDetail		= tbItem[2],
				nParticular	= tbItem[3],
				nLevel		= tbItem[4],
				nSeries		= (tbBaseProp.nSeries > 0) and tbBaseProp.nSeries or tbItem[6],
				bBind		= bBind,
				nLucky		= tbItem[5],
				nCount		= 1,
			}; 
			break;
		end
	end
	
	if (tbFinalProduct) then
		if (me.CanAddItemIntoBag(tbFinalProduct) ~= 1) then
			me.Msg("Hành trang không đủ chỗ trống");
			me.SynProduceResult(nRecipeId, 0);
			return;
		end
	end	
	
	-- �жϲ����Ƿ��㹻
	for _, stuff in ipairs(tbRecipeData.tbStuffSet) do
		if (stuff.nCount and stuff.nCount > 0) then
			local nCount = me.GetItemCountInBags(stuff.tbItem[1], stuff.tbItem[2], stuff.tbItem[3], stuff.tbItem[4], stuff.tbItem[5], LifeSkill:GetBindType(stuff.nBind));
			if (nCount < stuff.nCount) then
				me.Msg("Nguyên liệu "..szLifeSkillType.." không đủ chế tạo thất bại");
				me.SynProduceResult(nRecipeId, 0);
				return;
			end
		end
	end
	
	local nCost = 0;
	for _, stuff in ipairs(tbRecipeData.tbStuffSet) do
		if (stuff.nCount and stuff.nCount > 0) then
			local bRet;
			if LifeSkill:GetBindType(stuff.nBind) >= 0 then
				bRet = me.ConsumeItemInBags2(stuff.nCount, stuff.tbItem[1], stuff.tbItem[2], stuff.tbItem[3], stuff.tbItem[4], stuff.tbItem[5], LifeSkill:GetBindType(stuff.nBind));
			else
				bRet = me.ConsumeItemInBags(stuff.nCount, stuff.tbItem[1], stuff.tbItem[2], stuff.tbItem[3], stuff.tbItem[4], stuff.tbItem[5]);
			end
			
			if (bRet ~= 0) then
				me.Msg("Chất liệu khấu trừ thất bại.");
				me.SynProduceResult(nRecipeId, 0);
				return;
			end
			-- ��ò�������ľ���
			local nStuffCost = self.tbCost[stuff.tbItem[1]..","..stuff.tbItem[2]..","..stuff.tbItem[3]..","..stuff.tbItem[4]]
			if nStuffCost then
				nCost = nCost + stuff.nCount * nStuffCost / Spreader.ExchangeRate_Gold2JingHuo
			end
		end
	end
	
	local nGene = tbSkillData.Gene;
	if (tbSkillData.Gene == 1) then
		if (me.dwCurGTP < tbRecipeData.Cost) then
			me.Msg("Không đủ hoạt lực");
			me.SynProduceResult(nRecipeId, 0);
			return;
		end
		me.ChangeCurGatherPoint(-tbRecipeData.Cost);
	elseif(tbSkillData.Gene == 0) then
		if (me.dwCurMKP < tbRecipeData.Cost) then
			me.Msg("Không đủ tinh lực");
			me.SynProduceResult(nRecipeId, 0);
			return;
		end
		me.ChangeCurMakePoint(-tbRecipeData.Cost);
		if tbRecipeData.Consume == 1 then
			nCost = nCost + tbRecipeData.Cost / Spreader.ExchangeRate_Gold2JingHuo; -- ��¼ibvalue
		else
			nCost = 0;		-- ����
			-- Spreader:OnMakeBox(nRecipeId)
		end
	end
	
	if (tbFinalProduct) then
		-- ����Ʒ
		local tbItemInfo = {
				nSeries = tbFinalProduct.nSeries,
				nLucky = tbFinalProduct.nLucky,
			};
		if tbFinalProduct.bBind >= 0 then
		 	tbItemInfo.bForceBind = tbFinalProduct.bBind;
		end
		
		local pItem = me.AddItemEx(tbFinalProduct.nGenre, tbFinalProduct.nDetail, tbFinalProduct.nParticular, tbFinalProduct.nLevel, tbItemInfo, Player.emKITEMLOG_TYPE_PRODUCE);

		if pItem then
			
			pItem.nBuyPrice = pItem.nBuyPrice + nCost;
			pItem.SetCustom(Item.CUSTOM_TYPE_MAKER, me.szName);		-- ��¼����������
			pItem.Sync();
		
			local nLevelDec = math.floor(me.nLevel / 10);
			local szLevelRang = (nLevelDec * 10 + 1) .. "��" .. (nLevelDec * 10 + 10);
			-- ��¼��ֵ��
			--KStatLog.ModifyAdd("LifeSkillStat", szLevelRang, "ͨ�����������ĵ��߼�ֵ����", pItem.nValue);
			
			-- �Ӿ���
			self:AddSkillExp(me, self:GetBelongSkillId(nRecipeId), tbRecipeData.ExpGain);
			
			me.Msg(szLifeSkillType.." Chế tạo thành công")
		else

			me.Msg(szLifeSkillType.." Chế tạo thất bại")

		end

	else

		me.Msg(szLifeSkillType.." Chế tạo thất bại")

	end
	
	me.SynProduceResult(nRecipeId, 1);

end


-------------------------------------------------------------------------
function LifeSkill:OnLogout()
	self:SaveAllSkill();
	self:SaveAllRecipe();	
end


-------------------------------------------------------------------------
-- ȡ�õ�ǰ������������
function LifeSkill:GetMyLifeSkill(pPlayer)
	local tbPlayerData		= pPlayer.GetTempTable("LifeSkill");
	local tbPlayerLifeSkill	= tbPlayerData.tbLifeSkill;
	if (not tbPlayerLifeSkill) then
		tbPlayerLifeSkill	= {
			tbLifeSkills	= {},
		};
		tbPlayerData.tbLifeSkill	= tbPlayerLifeSkill;
	end
	
	return tbPlayerLifeSkill;
end


-------------------------------------------------------------------------
-- �������Ϊ����������
function LifeSkill:AddSkillWhenPlayerLevelUp(nLevel)
	if (MODULE_GAMESERVER) then
		if (nLevel == 20) then
			for i=1, 11 do
				self:AddLifeSkill(me, i, 1)
			end
		end
	end
end


function LifeSkill:AddRecipeForLevelChange(pPlayer, nSkillId, nSkillLevel)
	-- ������Щ�����Զ���ӵ��䷽
	for _, tbBelongRecipe in pairs(self.tbLifeSkillDatas[nSkillId].tbRecipeDatas) do
		if (tbBelongRecipe.AutoAppend == 1 and tbBelongRecipe.SkillLevel <= nSkillLevel and tbBelongRecipe.Storage == 0) then
			self:AddRecipe(pPlayer, tbBelongRecipe.ID);
		end
	end
	
	--���ӻ�䷽
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	for nRecipeId, tbEventRecipe in pairs(self.tbStorageDatas) do
		if (not tbEventRecipe.nBelong or tbEventRecipe.nBelong == nSkillId) 
			and (not tbEventRecipe.nAutoAppend or tbEventRecipe.nAutoAppend == 1) then
			if tbEventRecipe.nStartDate == 0 and tbEventRecipe.nEndDate == 0 then
				self:AddRecipe(me, nRecipeId)
			elseif nNowDate >= tbEventRecipe.nStartDate and nNowDate < tbEventRecipe.nEndDate then
				self:AddRecipe(me, nRecipeId)
			end
		end
	end	
	
end


function LifeSkill:AddTitleForLevelChange(pPlayer, nSkillId, nSkillLevel)
	if (LifeSkill.tbLifeSkillLevelForTitle[nSkillId] and LifeSkill.tbLifeSkillLevelForTitle[nSkillId][nSkillLevel]) then
		local tbTitle = LifeSkill.tbLifeSkillLevelForTitle[nSkillId][nSkillLevel];
		pPlayer.AddTitle(tbTitle[1] or 0, tbTitle[2] or 0, tbTitle[3] or 0, tbTitle[4] or 0);
	end

end

-------------------------------------------------------------------------
-- ��������
function LifeSkill:ShowMySkill(pPlayer)
	local tbPlayerLifeSkills = LifeSkill:GetMyLifeSkill(pPlayer);
	if (tbPlayerLifeSkills) then
		for _, tbSkill in pairs(tbPlayerLifeSkills.tbLifeSkills) do
			pPlayer.Msg(tbSkill.tbSkillData.Name.."Sử dụng "..tbSkill.nLevel.." thành công nhận được. Kinh nghiệm: "..tbSkill.nExp);
			if (tbSkill.tbRecipes) then
				for _, tbRecipe in pairs(tbSkill.tbRecipes) do
					pPlayer.Msg("    "..tbRecipe.tbRecipeData.Name)
				end
			end
		end
	end
end

--��ð�����(0Ϊ�󶨺Ͳ��󶨶���, 1-��, 2-����)
function LifeSkill:GetBindType(nBind)
	if nBind == 0 then
		return -1;
	end
	if nBind == 1 then
		return 1;
	end
	if nBind == 2 then
		return 0;
	end
	return -1;
end


-- ע��ͨ�������¼�
PlayerEvent:RegisterGlobal("OnLogin", LifeSkill._OnLogin, LifeSkill);

-- ע�������¼�
PlayerEvent:RegisterGlobal("OnLogout", LifeSkill._OnLogout, LifeSkill)
