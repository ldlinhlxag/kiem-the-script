-- �ļ�������spreader_gs.lua
-- �����ߡ���xiewen
-- ����ʱ�䣺2008-12-29 16:15:01

Require("\\script\\spreader\\spreader_def.lua")

if not MODULE_GAMESERVER then
	return
end

local szWareListPath = "\\setting\\ibshop\\warelist.txt";
local szNonIbItemCongfig = "\\setting\\spreader\\non_ib_item.txt";

Spreader.tbIbItem = {};						-- IB��Ʒ
Spreader.tbNonIbItem = {};				-- ��IB��Ʒ

Spreader.tbLittleConsumeCache = {};	-- С�����Ļ���

function Spreader:CalBitByGDPL(nG, nD, nP, nL)
	--nLevelռ0-5λ��nParticularռ6-15λ, nDetailTypeռ16-25λ��nGenreռ26-31λ
	local nIndex = nL;
	nIndex = Lib:SetBits(nIndex, nP, 6,  15);
	nIndex = Lib:SetBits(nIndex, nD, 16, 25);
	nIndex = Lib:SetBits(nIndex, nG, 26, 31);
	
	return nIndex;
end

function Spreader:LoadWareListSetting()
	local tbWareListSetting = Lib:LoadTabFile(szWareListPath);
	-- ����IB�б�����
	for nRow, tbRowData in pairs(tbWareListSetting) do
		local nGenre = tonumber(tbRowData["nGenre"]);
		local nDetailType = tonumber(tbRowData["nDetailType"]);
		local nParticular = tonumber(tbRowData["nParticular"]);
		local nLevel = tonumber(tbRowData["nLevel"]);
		local nCurrencyType = tonumber(tbRowData["nCurrencyType"]);
		
		--nLevelռ0-5λ��nParticularռ6-15λ, nDetailTypeռ16-25λ��nGenreռ26-31λ
		local nIndex = self:CalBitByGDPL(nGenre, nDetailType, nParticular, nLevel);
		
		if nIndex and nCurrencyType and nCurrencyType == 0 then
			local nConsumed = tonumber(tbRowData["Consumed"]) or 0;
			self.tbIbItem[nIndex] = nConsumed;
		end
	end
end

function Spreader:LoadNonIbItemConfig()
	local tbNonIbItemCongfig = Lib:LoadTabFile(szNonIbItemCongfig);
	
	-- ���ط�IB��������Ʒ����
	for nRow, tbRowData in pairs(tbNonIbItemCongfig) do
		local nGenre = tonumber(tbRowData["nGenre"]);
		local nDetailType = tonumber(tbRowData["nDetailType"]);
		local nParticular = tonumber(tbRowData["nParticular"]);
		local nLevel = tonumber(tbRowData["nLevel"]);
		
		local nBuyPrice = tonumber(tbRowData["nBuyPrice"]);
		local bCanBind = tonumber(tbRowData["bCanBind"]) or 0;
		
		--nLevelռ0-5λ��nParticularռ6-15λ, nDetailTypeռ16-25λ��nGenreռ26-31λ
		local nIndex = self:CalBitByGDPL(nGenre, nDetailType, nParticular, nLevel);
		
		self.tbNonIbItem[nIndex] = {};
		self.tbNonIbItem[nIndex].nBuyPrice = nBuyPrice;
		self.tbNonIbItem[nIndex].bCanBind = bCanBind;
	end
end

function Spreader:OnItemConsumed(nCount, nCosumeMode)
	if self:IsIntroducee(me) ~= 1 then
		return
	end
	
	-- ����/���ӵ�����;������
	if (nCosumeMode == self.emITEM_CONSUMEMODE_SELL or
		nCosumeMode < self.emITEM_CONSUMEMODE_REALCONSUME_START or
		nCosumeMode > self.emITEM_CONSUMEMODE_REALCONSUME_END)
	then
		return
	end
	
	--nLevelռ0-5λ��nParticularռ6-15λ, nDetailTypeռ16-25λ��nGenreռ26-31λ
	local nIndex = self:CalBitByGDPL(it.nGenre, it.nDetail, it.nParticular, it.nLevel);
	
	if it.IsIbItem() == 1 then
		
		if (nCosumeMode == self.emITEM_CONSUMEMODE_EXPIREDTIMEOUT or	--��ֵ�ڵ�
			nCosumeMode == self.emITEM_CONSUMEMODE_USINGTIMEOUT)		--��Ʒ��ʱ
		then
			-- ����ɾ�����԰�ԭ��
			local nItConsumed =  it.nBuyPrice * nCount;
			Dbg:WriteLog("Spreader:OnItemConsumed",
				"�ƹ�Ա���ļ�¼��",
				self.ZoneGroup or self:ExtractZoneGroup(),
				me.szAccount,
				string.format("[%s]��Ib��Ʒ[%s]%d��,�����ɾ��,������ļ�¼[%s]", 
					me.szName, it.szName, nCount, tostring(nItConsumed))
			);
			self:AddConsume(nItConsumed)
		else
			-- Ib��Ʒ��ͨ���ģ���Ϊ��Щ��Ʒ���ǰ�ԭ�ۼ������ģ����Զ�����һ���ٷֱȣ�
			if self.tbIbItem[nIndex] then
				local nItConsumed = it.nBuyPrice * nCount * self.tbIbItem[nIndex] / 100;
				Dbg:WriteLog("Spreader:OnItemConsumed",
					"�ƹ�Ա���ļ�¼��",
					self.ZoneGroup or self:ExtractZoneGroup(),
					me.szAccount,
					string.format("[%s]��������Ib��Ʒ[%s]%d��,������ļ�¼[%s]", 
						me.szName, it.szName, nCount, tostring(nItConsumed))
				);
						
				self:AddConsume(nItConsumed);
			end
		end

	else
		
		-- ��Ib��Ʒ
		--if it.IsBind() == 0 and self.tbNonIbItem[nIndex] then
		if self.tbNonIbItem[nIndex] and it.IsBind() <= self.tbNonIbItem[nIndex].bCanBind then
			local nItConsumed = self.tbNonIbItem[nIndex].nBuyPrice * nCount;
			Dbg:WriteLog("Spreader:OnItemConsumed",
				"�ƹ�Ա���ļ�¼��",
				self.ZoneGroup or self:ExtractZoneGroup(),
				me.szAccount,
				string.format("[%s]ʹ�÷�Ib��Ʒ[%s]%d����������ļ�¼[%s]",
						 me.szName, it.szName, nCount, tostring(nItConsumed))
			);
			self:AddConsume(nItConsumed);
		end
		
	end
end

-- װ���󶨼�������
function Spreader:OnItemBound(pItem)
	if self:IsIntroducee(me) ~= 1 then
		return
	end

	if pItem and pItem.nBuyPrice > 0 then
			
		Dbg:WriteLog("Spreader:OnItemBound",
			"�ƹ�Ա���ļ�¼��",
			self.ZoneGroup or self:ExtractZoneGroup(),
			me.szAccount,
			string.format("[%s]��װ��[%s],������ļ�¼[%s]",
				 me.szName, pItem.szName, tostring(pItem.nBuyPrice))
		);
			
		self:AddConsume(pItem.nBuyPrice)
		pItem.nBuyPrice = 0	-- ��ֹװ������ɾ��ʱ�ּ�һ������
	end
end

-- ����������⴦��
function Spreader:OnGouhunyuRepute(nReputeAdded)
	if self:IsIntroducee(me) ~= 1 or nReputeAdded <= 0 then
		return
	end
	
	local nConsume = nReputeAdded / 102; -- 102��һ���������ܵõ�������������ֵ
	
	Dbg:WriteLog("Spreader:OnGouhunyuRepute",
		"�ƹ�Ա���ļ�¼��",
		self.ZoneGroup or self:ExtractZoneGroup(),
		me.szAccount,
		string.format("[%s]ʹ�ù����񣬵õ�����[%d], ������ļ�¼[%s]", 
			me.szName, nReputeAdded, tostring(self.GOUHUNYU * nConsume))
	);
			
	self:AddConsume(self.GOUHUNYU * nConsume)
end

-- �Ȼ�������
function Spreader:AddConsume(fConsume)
	if self:IsIntroducee(me) ~= 1 then
		return
	end

	if fConsume and fConsume > 0 then
		local fTempCache = self.tbLittleConsumeCache[me.nId] or 0
		
		fTempCache = fTempCache + fConsume
		
		if fTempCache > 1 then
			local nConsumeCached = me.GetTask(self.TASK_GROUP, self.TASKID_CONSUME)
			me.SetTask(self.TASK_GROUP, self.TASKID_CONSUME, nConsumeCached + fTempCache)
			
			self.tbLittleConsumeCache[me.nId] = fTempCache - math.floor(fTempCache);
		else
			-- С��1��
			self.tbLittleConsumeCache[me.nId] = fTempCache
		end
		
	end
end

-- �Ƿ��� �ƹ�Ա/����� ��������
function Spreader:IsIntroducee(pPlayer)	
	if self:_IsIntroducee_Spreader(pPlayer) == 1 or
	EventManager.ExEvent.tbPlayerCallBack:CheckIsConsumeRelation(pPlayer) == 1  -- 2009-3-9���ӣ�������ٻػ
	then
		return 1
	else
		return 0
	end
end

function Spreader:_IsIntroducee_Spreader(pPlayer)
	local nExt = pPlayer.GetExtPoint(6)
	if KLib.BitOperate(nExt, "&", 1) == 1 then
		return 1
	else
		return 0
	end	
end

-- ��������ķ��͵�GC
function Spreader:Flush(pPlayer)
	local nConsume = pPlayer.GetTask(self.TASK_GROUP, self.TASKID_CONSUME)		-- ȡ��������
	
--	-- ��¼С�����ĵ���ʱ��
--	local fConsumeToAdd = self.tbLittleConsumeCache[pPlayer.nId] or 0
--	nConsume = nConsume + fConsumeToAdd
	self.tbLittleConsumeCache[pPlayer.nId] = nil
	
	local nConsumeToSend = math.floor(nConsume / self.ExchangeRate_Rmb2Gold)	-- ֻȡ��λ���ϵ�
	local nCharge = me.GetExtPoint(2) 																				-- ȡ��չ�����ۼƳ�ֵ��
	local nLaoWanJia = EventManager.ExEvent.tbPlayerCallBack:CheckIsConsumeRelation(pPlayer);  -- 2009-3-9���ӣ�������ٻػ

	if nCharge <= nConsumeToSend then
		nConsumeToSend = nCharge					-- ������ȡС
	end
	if nConsumeToSend > 0 then
		me.PayExtPoint(2, nConsumeToSend) -- �۳��ۼƳ�ֵ��
		
		pPlayer.SetTask(self.TASK_GROUP,
			self.TASKID_CONSUME,
			nConsume - nConsumeToSend * self.ExchangeRate_Rmb2Gold)

		if nLaoWanJia == 1 then
			
			local nRealConsume = nConsumeToSend * self.ExchangeRate_Rmb2Gold;
			local nRate		= EventManager.ExEvent.tbPlayerCallBack:GetConsumeRate(pPlayer);
			nRealConsume	= math.floor(nRealConsume * nRate);	

			SendSpreaderConsume(self.ZoneGroup or self:ExtractZoneGroup(),
				pPlayer.szAccount,
				pPlayer.szName,
				nRealConsume,
				pPlayer.nId,
				self.emKTYPE_REDUX_PLAYER)
				
			Dbg:WriteLog("Spreader:Flush",
				"����һ��",
				self.ZoneGroup or self:ExtractZoneGroup(),
				pPlayer.szAccount,
				pPlayer.szName,
				nRealConsume)
		end

		if self:_IsIntroducee_Spreader(pPlayer) == 1 then
			SendSpreaderConsume(self.ZoneGroup or self:ExtractZoneGroup(),
				pPlayer.szAccount,
				pPlayer.szName,
				nConsumeToSend * self.ExchangeRate_Rmb2Gold,
				pPlayer.nId,
				self.emKTYPE_SPREADER)
				
			Dbg:WriteLog("Spreader:Flush",
				"�ƹ�Ա���ļ�¼��",
				self.ZoneGroup or self:ExtractZoneGroup(),
				pPlayer.szAccount,
				pPlayer.szName,
				nConsumeToSend * self.ExchangeRate_Rmb2Gold)
		end
	end
end

-- ��gateway������ȡ������
function Spreader:ExtractZoneGroup()
	local szGateway = GetGatewayName()
	local nZoneNumber = tonumber(string.sub(szGateway, 5, 6))
	
	if nZoneNumber then
		self.ZoneGroup = string.format("z%02d", nZoneNumber)
	else
		self.ZoneGroup = "zone.x(" .. szGateway .. ")" -- �޷�ƥ��������
	end
	
	return self.ZoneGroup
end

-- ������ߺ����Ѽ�¼���͵�GC
function Spreader:OnPlayerLogout()
	Spreader:Flush(me)
end

if not Spreader.LogoutHandlerId then
	Spreader.LogoutHandlerId = PlayerEvent:RegisterGlobal("OnLogout",
														  Spreader.OnPlayerLogout,
														  Spreader)
end

Spreader:LoadWareListSetting();
Spreader:LoadNonIbItemConfig();