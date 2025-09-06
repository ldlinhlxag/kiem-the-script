-- Item�ű���

Require("\\script\\item\\define.lua");

------------------------------------------------------------------------------------------
-- initialize

-- Item����ģ�壬��ϸ����default.lua�ж���
if not Item.tbClassBase then
	Item.tbClassBase = {};
end

-- ��ֹ���ؽű���ʱ��ģ��ⶪʧ
if not Item.tbClass then
	-- Itemģ���
	Item.tbClass =
	{
		-- Ĭ��ģ�壬�����ṩֱ��ʹ��
		["default"]	= Item.tbClassBase,
		[""]		= Item.tbClassBase,
	};
end


Item.TASK_OWNER_TONGID = 1; -- General Info��ĵ�һ���¼�󶨵İ��ID

--���ҵ�λ��ʾ
Item.tbTipPriceUnit = 
{
	[1] = "����",		--����
	[2] = "",			--��Ե
	[3] = "��%s",		-- ��������Ʒ����ʯ����Ӱ֮ʯ���黨�ȣ�
	[4] = "�����",		--����
	[5] = "",			--���׶�
	[6] = "",			--������������
	[7] = "������",			--������
	[8] = "������;ö�",		--�����;öȻ�������
	[9] = "��Ὠ���ʽ�",		-- ��Ὠ���ʽ�
	[10]= "%s",					-- ��ֵ����
}
------------------------------------------------------------------------------------------
-- interface

-- ϵͳ���ã�Ĭ�ϵĵ���������Ϣ��ʼ���������&�ͻ��ˣ�
function Item:InitGenInfo(szClassName)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:InitGenInfo();
end

-- ϵͳ���ã�����Ƿ�����ʹ�õ��ߣ������&�ͻ��ˣ�
function Item:CheckUsable(szClassName)
	local nMapId = -1;
	if (MODULE_GAMESERVER) then
		nMapId = me.nMapId;
	else
		nMapId = me.nTemplateMapId;
	end
	
  	local nCanUse, szMsg = self:CheckIsUseAtMap(nMapId, it.dwId);
	if nCanUse ~= 1 then
		me.Msg(szMsg);
		return 0;
	end

	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:CheckUsable();
end

-- ���Ҽ�����κ�һ����Ʒʱ���������������޷���ˣ�
function Item:OnUse(szClassName, nParam)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:OnUse(nParam);
end

function Item:OnClientUse(szClassName)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:OnClientUse();
end

-- ������ƶ����κ�һ����Ʒͼ����ʱ�������������ȡTip���ͻ��ˣ�
function Item:GetTip(szClassName, nState, szBindType)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	
	local szTip = "";
	local nTipState = nState;
	local nShopId = me.GetShopId();
	if (nState == Item.TIPS_SHOP) and Shop:GetGoods(nShopId, it.nIndex) then
		nTipState = Item.TIPS_GOODS;
	end
	
	local tbEnhRandMASS, tbEnhEnhMASS, nEnhStarLevel, nEnhNameColor;
	if tbClass.CalcEnhanceAttrib then		-- TODO: zyh: �����ķ���������ʱ��������
		tbEnhRandMASS, tbEnhEnhMASS, nEnhStarLevel, nEnhNameColor = tbClass:CalcEnhanceAttrib(nTipState);
		local szTitel = tbClass:GetTitle(nTipState, nEnhNameColor);
		szTip = szTip..tbClass:GetTip(nTipState, tbEnhRandMASS, tbEnhEnhMASS);
		if szTip and szTip ~= "" then
			szTip = "\n\n"..szTip;
		end
		szTip = self:Tip_Prefix(nTipState, 0, szBindType)..szTip..self:Tip_Suffix(nState);
		return szTitel, szTip, it.szViewImage;
	else
		local szTitel = tbClass:GetTitle(nTipState); --��Ʒ����
		local szTip = "";
		szTip = szTip..tbClass:GetTip(nTipState);
		if szTip and szTip ~= "" then
			szTip = "\n\n"..szTip;
		end
		szTip = self:Tip_Prefix(nTipState, 0, szBindType)..szTip..self:Tip_Suffix(nState);
		return szTitel, szTip, it.szViewImage;
	end
end

function Item:GetCompareTip(szClassName, nState, szBindType)
	local szTitle, szTip, szPic = self:GetTip(szClassName, nState, szBindType);
	local szCmpTitle = "";
	local szCmpTip = "";
	local szCmpPic = "";
	if it.IsEquip() == 1 then
		local nEquipPos = it.nEquipPos;
		local pItem = me.GetItem(Item.ROOM_EQUIP, nEquipPos, 0);
		if pItem and pItem.dwId ~= it.dwId then
			szCmpTitle, szCmpTip, szCmpPic = pItem.GetTip(Item.TIPS_NORMAL);
			szCmpTip = szCmpTip.."\n<color=yellow><��ǰװ��><color>";
		end
	end
	return szTitle, szTip, szPic, szCmpTitle, szCmpTip, szCmpPic;
end

-- �ж�һ����Ʒ�Ƿ���Ա����𣨷���ˣ�
function Item:IsPickable(szClassName, nObjId)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:IsPickable(nObjId);
end

-- ��һ����Ʒ������ʱ�ᴦ�����ͬ�����Ƿ�ɾ������Ʒ������ˣ�
function Item:PickUp(szClassName, nX, nY)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:PickUp(nX, nY);
end

-- ������߼�ֵ�������Ϣ�����ڵ�������ʱִ��һ��
-- ����ֵ����ֵ������ֵ���Ǽ���������ɫ��͸��ͼ��·��
function Item:CalcValueInfo(szClassName)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return tbClass:CalcValueInfo();
end

-----------------------------------------------------------------------------------------
-- public

-- ȡ���ض�������Itemģ��
function Item:GetClass(szClassName, bNotCreate)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) and (bNotCreate ~= 1) then		-- ���û��bNotCreate�����Ҳ���ָ��ģ����ʱ���Զ�������ģ����
		tbClass	= Lib:NewClass(self.tbClassBase);	-- ��ģ��Ӹ�ģ��������
		self.tbClass[szClassName] = tbClass;		-- ���뵽ģ�������
	end
	return	tbClass;
end

-- �̳��ض�������Itemģ��
function Item:NewClass(szClassName, szParent)
	if (self.tbClass[szClassName]) then				-- ָ��ģ������뻹������
		print("[ITEM] ��"..tostring(szClassName).."�Ѵ��ڣ�����ű���");
		return;
	end
	local tbParent = self.tbClass[szParent];
	if (not tbParent) then							-- ��ģ��������Ѿ�����
		print("[ITEM] ����"..tostring(szParent).."�����ڣ�����ű���");
		return;
	end
	local tbClass = Lib:NewClass(tbParent);			-- �Ӹ�ģ��������
	self.tbClass[szClassName] = tbClass;			-- ���뵽ģ�������
	return	tbClass;
end

-- ת��װ��λ��Ϊ��Ӧ���л�װ��λ��
function Item:EqPos2EqExPos(nEquipPos)
	if (nEquipPos < 0) or (nEquipPos > self.EQUIPEXPOS_NUM) then
		return	-1;
	end
	return	nEquipPos;
end

-- ת���л�װ��λ��Ϊ��Ӧ��װ��λ��
function Item:EqExPos2EqPos(nEquipExPos)
	if (nEquipExPos < 0) or (nEquipPos > self.EQUIPEXPOS_NUM) then
		return	-1;
	end
	return	nEquipExPos;
end

function Item:IsTry(nEquipPos)
	if (nEquipPos >= Item.EQUIPPOS_HEAD and nEquipPos <= Item.EQUIPPOS_MASK) then
		return 1;
	else
		return 0;
	end
end

-- �ѽ�������ֵ��ʽ��Ϊ�ַ�������ʾ���򡱡����ڡ����֣�
function Item:FormatMoney(nMoney)
	local szMoney = "";
	if (not nMoney) or (nMoney < 0) then
		return	"��Ч";								-- ��ǮС��0������
	end
	if (nMoney >= 100000000) then
		szMoney = szMoney..tostring(math.floor(nMoney / 100000000)).."��";
		nMoney = nMoney % 100000000;
	end
	if (nMoney >= 10000) then
		szMoney = szMoney..tostring(math.floor(nMoney / 10000)).."��";
		nMoney = nMoney % 10000;
	end
	if (nMoney > 0) then
		szMoney = szMoney..tostring(nMoney);
	end
	if (szMoney == "") then
		szMoney = "0";
	end
	return	szMoney;
end

function Item:Tip_FixSeries()
	local szTip = "\n�Ƽ�"
	if Item.tbSeriesFix[it.nEquipPos] and it.nSeries > 0 then
		return szTip..Item.TIP_SERISE[Item.tbSeriesFix[it.nEquipPos][it.nSeries]].."ʹ��";
	end
	return "";
end

function Item:FindFreeCellInRoom(nRoom, nWidth, nHeight)
	for nY = 0, nHeight - 1 do
		for nX = 0, nWidth - 1 do
			if me.GetItem(nRoom, nX, nY) == nil then
				return nX, nY;
			end
		end
	end
end
function Item:FormatMoney2Style(nMoney)
	
	if (not nMoney) or nMoney < 0 then
		return "��Ч";
	end
	local k = 0;
  	local nFormatted = nMoney
  	while true do  
  	  nFormatted, k = string.gsub(nFormatted, "^(-?%d+)(%d%d%d)", '%1,%2')
   	 if (k==0) then
    	  break
    	end
  	end
  return nFormatted;
end

function Item:Tip_Prefix(nState, nEnhStarLevel, szBindType)
	local szPreTip = "";
	if it.IsEquip() == 1 then
		szPreTip = szPreTip..self:Tip_StarLevel(nState, nEnhStarLevel);
		szPreTip = szPreTip..self:Tip_BindInfo(nState, szBindType);	-- ��״̬
		szPreTip = szPreTip..self:Tip_Changeable(nState)..self:Tip_CanBreakUp(nState);  -- �ɷ�һ�
		szPreTip = szPreTip..self:Tip_GetRefineLevel();
		szPreTip = szPreTip..self:Tip_FixSeries(nState);
	else
		szPreTip = szPreTip..self:Tip_BindInfo(nState, szBindType);
		szPreTip = szPreTip..self:Tip_Changeable(nState);  -- �ɷ�һ�
	end
	return szPreTip;
end

function Item:Tip_GetRefineLevel(nState)
	local szTip = " ";
	if it.nRefineLevel == 0 then
		return szTip.."δ����";
	elseif it.nRefineLevel > 0 then
		return szTip.."����<color=gold>"..it.nRefineLevel.."<color>��"
	else
		return szTip.."��������";
	end
end

function Item:Tip_Changeable(nState)
	local szTip = "\n";
	if (nState == Item.TIPS_PREVIEW) then
		return szTip;
	elseif (nState == Item.TIPS_BINDGOLD_SECTION) then
		return szTip.."���ɶһ�";
	end
	
	if Item:CalcChange({it}) > 0 then
		return szTip.."�ɶһ�";
	else
		return szTip.."���ɶһ�";
	end
end

function Item:Tip_Suffix(nState)
	local szTip = "";
	szTip = szTip..self:Tip_Intro();
	szTip = szTip..self:Tip_UseTime();
	szTip = szTip..self:Tip_Help();
	szTip = szTip..self:Tip_ReqLevel();
	szTip = szTip..self:Tip_Price(nState);
	szTip = szTip..self:Tip_Timeout();
	return	szTip;
end

function Item:Tip_StarLevel(nState, nEnhStarLevel)	-- ���Tip�ַ�����װ����ֵ���Ǽ�
	local tbSetting = Item.tbExternSetting:GetClass("value");
	--if (nState == Item.TIPS_PREVIEW) then
	--	return	"";			-- ����Ԥ��״̬ʱ����ʾ��ֵ���Ǽ�
	--end

	local szTip = "\n  ";
	local nStarLevel = it.nStarLevel;
	local szFillStar = "";
	local szEmptyStar = "";
	if tbSetting and tbSetting.m_tbStarLevelInfo and tbSetting.m_tbStarLevelInfo[nStarLevel] then
		szFillStar = string.format("<pic=%s>", tbSetting.m_tbStarLevelInfo[nStarLevel].nFillStar - 1);
		szEmptyStar = string.format("<pic=%s>", tbSetting.m_tbStarLevelInfo[nStarLevel].nEmptyStar - 1);
	else
		szFillStar = "��";
		szEmptyStar = "��";
	end

	for i = 1, math.floor(nStarLevel / 2) do
		szTip = szTip..szFillStar;
		if i % 3 == 0 then
			szTip = szTip.." ";
		end
	end
	if (it.nStarLevel % 2 ~= 0) then
		szTip = szTip..szEmptyStar;
	end
	return	szTip;

end

function Item:Tip_BindInfo(nState, szBindType)
	local szTip = "";
	if it.IsEquip() == 1 then
		local nPos = KItem.EquipType2EquipPos(it.nDetail)
		szTip = Item.EQUIPPOS_NAME[nPos];
		if nPos == self.EQUIPPOS_WEAPON and self.WEAPON_NAME[it.nEquipCategory] then
			szTip = szTip.."��"..self.WEAPON_NAME[it.nEquipCategory].."�� ";
		else
			szTip = szTip.." ";
		end
	end
	local nShopId = me.GetShopId();
	local nGoodsId = Shop:GetGoods(nShopId, it.nIndex);
	local nCurrencyType	= 0;
	if (nGoodsId) then		-- ֻ������ʱ�в�ͬ�Ļ��ҵ�λ
		nCurrencyType	= me.nCurrencyType;
	end
	
	if (szBindType) then
		szTip = szTip..szBindType;
	elseif (nState == Item.TIPS_GOODS and nGoodsId and (KItem.IsGetBindType(nGoodsId) == 1 or nCurrencyType == 7)) then
		szTip	= szTip.."��ȡ��";
	else
		local nBindType = it.nBindType;
		if (nState == Item.TIPS_BINDGOLD_SECTION) then
			szTip = szTip.."��ȡ��";
	
		elseif (nState ~= Item.TIPS_PREVIEW) and (1 == it.IsBind()) then	-- ����Ԥ��״̬ʱֻ����nBindType��ʾ
			szTip = szTip.."�Ѱ�";
		elseif	(Item.BIND_NONE  == nBindType or Item.BIND_NONE_OWN == nBindType) then
			szTip = szTip.."����";
		elseif	(Item.BIND_GET   == nBindType) then
			szTip = szTip.."��ȡ��";
		elseif	(Item.BIND_EQUIP == nBindType) then
			szTip = szTip.."װ����";
		elseif  (Item.BIND_OWN == nBindType) then
			szTip = szTip.."��ȡ��";
		end
	end
	if szTip ~= "" then
		szTip = "\n"..szTip;
	end
	return	szTip;
end

function Item:Tip_CanBreakUp(nState)
	local szTip = "";
	local nGTPCost, tbStuff, tbExp = Item:CalcBreakUpStuff(it);
	if (nGTPCost <= 0) or (#tbStuff <= 0) then
		szTip = szTip.." ���ɲ��";
	else
		szTip = szTip.." �ɲ��"
	end
	if szTip ~= "" then
		szTip = ""..szTip;
	end
	return	szTip;
end

function Item:Tip_Intro()
	local szIntro = it.szIntro;	
	if szIntro and szIntro ~= "" then
		return "\n\n"..szIntro;
	end
	return "";
end

function Item:Tip_Help()			-- ���Tip�ַ�������������
	if it.szHelp and it.szHelp ~= ""then
		return	"\n\n"..it.szHelp;
	end
	return "";
end

function Item:Tip_UseTime()		-- ���Tip�ַ�����ʹ��ʱ��
	local szTip = "";
	local nTime = GetCdTime(it.nCdType) / Env.GAME_FPS;

	if (nTime ~= 0) then

		local nHour = math.floor(nTime / 3600);
		nTime = nTime % 3600;
		local nMin  = math.floor(nTime / 60);
		nTime = nTime % 60;
		local nSec  = math.floor(nTime * 10) / 10;		-- ��ȷ��С�����һλ

		local szTime = "";
		if (nHour ~= 0) then
			szTime = szTime..nHour.."Сʱ";
		end
		if (nMin ~= 0) then
			szTime = szTime..nMin.."��";
		end
		if (nSec ~= 0) then
			szTime = szTime..nSec.."��";
		end

		szTip = "\n\n"..szTip.."ʹ��ʱ������"..szTime;

	end

	return	szTip;
end

function Item:Tip_ReqLevel()

	if (it.nReqLevel <= 0) then
		return	"";
	end

	local szTip = "";
	local nRed = 0;

	if (me.nLevel < it.nReqLevel) then
		nRed = 1;
	end

	if (nRed == 1) then
		szTip = szTip.."<color=red>";
	end

	szTip = "\n"..szTip.."ʹ�õȼ�����"..it.nReqLevel.."��";

	if (nRed == 1) then
		szTip = szTip.."<color>";
	end

	return	szTip;

end

--��ʱ����ʹ��, 2008.11.18�󽫱�ɾ�� dzh
function Item:SendDisableTrade(szMsg)
	--me.Msg("����������ڹ��أ����͹�����ʮ��С�ģ�������һ������Ҫ�ȵ����һ��ά��������͵���");
end

function Item:Tip_Price(nState)
	
	local szTip = "";
 	local szUnit = "";
	
	if (nState == Item.TIPS_SHOP) then	-- NPC����״̬��ʾ��Ʒ�۸�
		local nShopId = me.GetShopId();
		local pGoodsId = Shop:GetGoods(nShopId, it.nIndex);
		
		local nCurrencyType	= 1;	-- ������Զ�ǽ�����
		if pGoodsId then		-- ֻ������ʱ�в�ͬ�Ļ��ҵ�λ
			nCurrencyType = me.nCurrencyType;
		end

		szUnit = self.tbTipPriceUnit[nCurrencyType] or "";
		szTip = szTip.."<color=yellow>";

		if pGoodsId then
			local tbGoods = me.GetShopBuyItemInfo(pGoodsId);
			local nPrice = tbGoods.nPrice;
			local nCamp = tbGoods.nReputeCamp;
			local nClass = tbGoods.nReputeClass; 
			local nLevel = tbGoods.nReputeLevel;
			local nRequireHonor = tbGoods.nHonour;
			local nOfficialLevel = tbGoods.nOfficialLevel;
			local nEnergy = tbGoods.nEnergy;

			-- ʵ����ҵ�λ
			if (nCurrencyType == 3) then
				local nItemCoinIndex = tbGoods.ItemCoinIndex;
				if (szUnit ~= "") then
					szUnit = string.format(szUnit, Shop:GetItemCoinUnit(nItemCoinIndex));
				end
			end
			
			-- ��ֵ���ҵ�λ
			if (nCurrencyType == 10) then
				local nValueCoinIndex = tbGoods.ValueCoinIndex;
				if (szUnit ~= "") then
					szUnit = string.format(szUnit, Shop:GetValueCoinUnit(nValueCoinIndex));
				end
			end
			
			szTip = "\n\n"..szTip.."<color=yellow>����۸�"..self:FormatMoney(nPrice)..szUnit.."<color>";
			if nCurrencyType == 9 and nEnergy > 0 then
				szTip = szTip..string.format("\n���� %d�����ж���", nEnergy);
			end
			-- ��������
			local bConditionLevel = false;
			if nLevel > 0 then
				bConditionLevel = true;
				local tbInfo = KPlayer.GetReputeInfo();
				if me.GetReputeLevel(nCamp, nClass) >= nLevel then
					szTip = szTip.."\n\n<color=white>����������";
				else
					szTip = szTip.."\n\n<color=red>����������";
				end
				if tbInfo then
					szTip = szTip..tbInfo[nCamp][nClass].szName.."�����ﵽ"..tbInfo[nCamp][nClass][nLevel].szName.."["..nLevel.."��]";
				else
					szTip = szTip.."��������δ֪";
				end
				szTip = szTip.."<color>";
			end
			
			--��������֧��
			--local nRequireHonor = 0 --debug
			if nRequireHonor > 0 then
				if me.GetHonorLevel() >= nRequireHonor then
					szTip = szTip.."\n<color=white>";
				else
					szTip = szTip.."\n<color=red>";
				end
				if bConditionLevel == false then
					szTip = szTip.."\n����������";
				end
				
				local strcondfmt = "\n��������һ������\n���������ﵽ%d��\n�Ƹ������ﵽ%d��\n���������ﵽ%d��";
				local strcond = string.format(strcondfmt, nRequireHonor, nRequireHonor, nRequireHonor); 
				szTip = szTip..strcond;
				
				szTip = szTip.."<color>";
			end
			if nOfficialLevel > 0 then
				local nLevel = me.GetOfficialLevel()
				local szColor = "white";
				if nOfficialLevel > nLevel then
					szColor = "red";
				end
				szTip = szTip..string.format("\n<color=%s>���εȼ�����%d��<color>", szColor, nOfficialLevel);
			end
		else
			local nPrice = me.GetRecycleItemPrice(it)
			if nPrice then
				szTip = "\n"..szTip.."<color=yellow>�ع��۸�"..nPrice..szUnit.."<color>";
			else
				nPrice = GetSalePrice(it);
				if it.IsForbitSell() == 1 then
					szTip = "\n<color=red>���ɳ���<color>";
				else
          --��������Ҫ�жϵ��ߵİ�����
					if 1 == it.IsBind() then
					  szUnit = "������";
					else
					  szUnit = "����";
					end
					szTip = "\n"..szTip.."<color=yellow>�����۸�"..self:FormatMoney(nPrice)..szUnit.."<color>";
					if it.nEnhTimes > 0 then -- ǿ������װ�������۵�
						szTip = szTip.."<color=red>�������۵꣩<color>";
					end
				end
			end
		end
		
	elseif (nState == Item.TIPS_STALL) then			-- ��̯״̬��ʾ��̯��Ϣ

		local nPrice = me.GetStallPrice(it);		-- �ȿ��ǲ����Լ���̯�Ķ���

		if not nPrice then							-- ������ǣ������ǲ��Ǳ��˰�̯�Ķ���
			local _, _, tbInfo = me.GetOtherStallInfo();
			if tbInfo then
				for i = 1, #tbInfo do
					if (tbInfo[i].uId == it.nIndex) and (tbInfo[i].nPrice >= 0) then
						nPrice = tbInfo[i].nPrice;
						break;
					end
				end
			end
		end

		if nPrice then								-- ��������ǣ��Ͳ���ʾ��̯��Ϣ
			szUnit = self.tbTipPriceUnit[1];---��̯���׶���������λ
			szTip = "\n"..szTip.."<color=yellow>�������ۣ�"..self:FormatMoney2Style(nPrice)..szUnit.."("..self:FormatMoney(nPrice)..szUnit..")<color>";
			local nTotal = nPrice * it.nCount;
			szTip =  szTip .. "\n<color=yellow>�����ܼۣ�"..self:FormatMoney2Style(nTotal)..szUnit.."("..self:FormatMoney(nTotal)..szUnit..")<color>";
		end

	elseif (nState == Item.TIPS_OFFER) then			-- �չ�״̬��ʾ�չ���Ϣ

		local nPrice, nCount = me.GetOfferReq(it);	-- �ȿ��ǲ����Լ��չ��Ķ���

		if (not nPrice) or (not nCount) then		-- ������ǣ��ٿ��ǲ��Ǳ����չ��Ķ���
			local _, _, tbInfo = me.GetOtherOfferInfo();
			if tbInfo then
				for i = 1, #tbInfo do
					if (tbInfo[i].uId == it.nIndex) and (tbInfo[i].nPrice >= 0) then
						nPrice = tbInfo[i].nPrice;
						nCount = tbInfo[i].nNum;
						break;
					end
				end
			end
		end

		if nPrice and nCount then					-- ��������ǣ�����ʾ�չ���Ϣ
			szUnit = self.tbTipPriceUnit[1];---��̯���׶���������λ
			szTip = "\n"..szTip.."<color=yellow>�չ�������"..nCount.."��\n�չ����ۣ�"..self:FormatMoney2Style(nPrice)..szUnit.."("..self:FormatMoney(nPrice)..szUnit..") <color>";
			local nTotal = nPrice * nCount;
			szTip =  szTip .. "\n<color=yellow>�չ��ܼۣ�"..self:FormatMoney2Style(nTotal)..szUnit.."("..self:FormatMoney(nTotal)..szUnit..")<color>";
		end

	elseif (nState == Item.TIPS_NOBIND_SECTION or nState == Item.TIPS_BINDGOLD_SECTION) then
		local tbWareInfo = me.GetIbShopItemInfo(it.nIndex);
		if (tbWareInfo and tbWareInfo.nDiscount > 0) then
			local szTemp = "";
			if (tbWareInfo.nDiscountType == 0) then
				szTemp = tbWareInfo.nDiscount.."%";
			else
				if (tbWareInfo.nCurrencyType == 0) then
					szTemp = tbWareInfo.nDiscount .. IVER_g_szCoinName;
				elseif (tbWareInfo.nCurrencyType == 1) then
					szTemp = tbWareInfo.nDiscount .. "����";
				elseif (tbWareInfo.nCurrencyType == 2) then
					szTemp = tbWareInfo.nDiscount .. "��"..IVER_g_szCoinName;
				else
					assert(false);
				end
			end
			if (tbWareInfo.nDiscStart ~= tbWareInfo.nDiscEnd and GetTime() <= tbWareInfo.nDiscEnd) then
				local szStartDate = os.date("%Y��%m��%d�� %H:%M:%S", tbWareInfo.nDiscStart);
				local szEndDate  = os.date("%Y��%m��%d�� %H:%M:%S", tbWareInfo.nDiscEnd);
				szTip = szTip..string.format("\n\n<color=yellow>�Ż�%s\n�Żݿ�ʼʱ�䣺%s\n�Żݽ���ʱ�䣺%s<color>",szTemp,szStartDate,szEndDate);
			end
		end
	end
		
	return	szTip;

end

function Item:Tip_Timeout()			-- ��ʱʱ��
	
	local szTip = "";
	local tbAbsTime = me.GetItemAbsTimeout(it);

	if tbAbsTime then
		local strTimeout = string.format("<color=yellow>����Ʒ��ʹ��ʱ������%d��%d��%d��%dʱ%d�֡�<color>",
			tbAbsTime[1],
			tbAbsTime[2],
			tbAbsTime[3],
			tbAbsTime[4],
			tbAbsTime[5]);
		szTip = "\n\n"..szTip..strTimeout;
	else
		local tbRelTime = me.GetItemRelTimeout(it);
		if tbRelTime then
			local strTimeout = string.format("<color=yellow>����Ʒʣ���ʹ��ʱ��Ϊ��%d��%dʱ%d�֡�<color>",
				tbRelTime[1],
				tbRelTime[2],
				tbRelTime[3]);
			szTip = "\n\n"..szTip..strTimeout;
		end
	end

	return	szTip;

end

--��ͼ,��Ʒ����,��ֹ�ڵ�ǰ��ͼʹ��
function Item:CheckIsUseAtMap(nMapId, ...)
	local nCheck, szMsg, szMapClass, szItemClass = self:CheckForBidItemAtMap(nMapId, unpack(arg));
	if not nCheck or nCheck == 0 then
		return nCheck, szMsg;
	end
	if nCheck == 2 then
		return 1;
	end
	
	if Map.tbMapItemState[szMapClass].tbForbiddenUse[szItemClass] ~= nil then
		return 0, "�õ��߽�ֹ�ڱ���ͼʹ��";
	end
	
	return 1;
end

--�ٻ������,�Ƿ������Լ��������ٻ�����ͼ,[��ֹ���ٻ���ȥ]
--(Ϊ�������ٳ�������ֿ�2������������ѡ��ͨ�������������жϵ�������)
function Item:IsCallOutAtMap(nMapId, ...)
	local nCheck, szMsg, szMapClass, szItemClass = self:CheckForBidItemAtMap(nMapId, unpack(arg));
	if not nCheck or nCheck == 0 then
		return nCheck, szMsg;
	end
	if nCheck == 2 then
		return 1;
	end
	
	if Map.tbMapItemState[szMapClass].tbForbiddenUse[szItemClass] ~= nil then
		return 0, "�õ��߽�ֹ�ڱ���ͼʹ��";
	end
	return 1;
end

--�ٻ������,�Ƿ������ٻ����˽����ͼ�� �� ������ʹ����Ʒ�����ͼ
function Item:IsCallInAtMap(nMapId, ...)
	local nCheck, szMsg, szMapClass, szItemClass = self:CheckForBidItemAtMap(nMapId, unpack(arg));
	if not nCheck or nCheck == 0 then
		return nCheck, szMsg;
	end
	if nCheck == 2 then
		return 1;
	end

	if Map.tbMapItemState[szMapClass].tbForbiddenCallIn[szItemClass] ~= nil then
		return 0, "�õ��߽�ֹ�ڱ���ͼʹ��";
	end
	return 1;
end

Item.ForBidUseAtMap = {
	["mask"]= "MASK";
}

function Item:CheckForBidItemAtMap(nMapId, ...)
	local szItemClass = "";
	if #arg == 4 then
		szItemClass = KItem.GetOtherForbidType(unpack(arg)) or "";
	elseif #arg == 1 then
		if type(arg[1]) == "string" then
			szItemClass = arg[1] or "";
		elseif type(arg[1]) == "number" then
			local pItem = KItem.GetObjById(arg[1]);
			if pItem == nil then
				return 0, "�õ��߽�ֹ�ڱ���ͼʹ��";
			end
			if self.ForBidUseAtMap[pItem.szClass] then
				szItemClass = self.ForBidUseAtMap[pItem.szClass];
			else
				szItemClass = pItem.GetForbidType() or "";
			end
		else
			return 0, "�õ��߽�ֹ�ڱ���ͼʹ��";
		end		
	else
		return 0, "�õ��߽�ֹ�ڱ���ͼʹ��";
	end
	
	if (self:CheckDynamicForbiden(nMapId, szItemClass) == 1) then
		return 0, "�õ��߽�ֹ�ڱ���ͼʹ��";
	end

	local szMapClass = GetMapType(nMapId) or "";

	if Map.tbMapItemState[szMapClass] == nil then
		return 2, "", szMapClass, szItemClass;	
	end
	if Map.tbMapProperItem[szItemClass] then 
		 if Map.tbMapProperItem[szItemClass] ~= szMapClass then
			--����ƷΪ������.
			local szInfo = Map.tbMapItemState[Map.tbMapProperItem[szItemClass]].szInfo;
			local szMsg = "�õ��߽�ֹ�ڱ���ͼʹ��";
			if szInfo ~= "" then
				szMsg = "�õ��߽�������" .. szInfo .."ʹ��";
			end
			return 0, szMsg;
		else
			return 1,"", szMapClass, szItemClass;
		end
	end
	
	if Map.tbMapItemState[szMapClass].tbForbiddenUse["ALL_ITEM"]  then
		return 0, "�õ��߽�ֹ�ڱ���ͼʹ��";
	end
	
	return 1, "", szMapClass, szItemClass;	
end


function Item:IsEquipRoom(nRoom)
	if nRoom == Item.ROOM_EQUIP or nRoom == Item.ROOM_EQUIPEX then
		return 1;
	end
	return 0;
end


-- UNDONE: Fanghao_Wu	��ʱ���룬��ҩ����ҩƷ����*1.5��2008-9-1��ɾ��������
function Item:OnLoaded(szClassName)
	local tbClass = self.tbClass[szClassName];
	if (szClassName == "xiang" and tbClass) then
		tbClass:OnLoaded();
	end
end

function Item:ChangeEquipToFac(varEquip, nFaction)
	local pEquip
	if type(varEquip) == "userdata" then
		pEquip = varEquip;
	elseif type(varEquip) == "number" then
		pEquip = KItem.GetObjById(varEquip);
	else
		return 0;
	end
	if not pEquip then
		return 0;
	end
	local tbFacEquip = self:CheckCanChangable(pEquip);
	if not tbFacEquip then
		return 0;
	end
	local tbGDPL = tbFacEquip[nFaction];
	if (not tbGDPL) then
		return 0;
	end
	if (pEquip.nGenre == tbGDPL[1] and 
		pEquip.nDetail == tbGDPL[2] and  
		pEquip.nParticular == tbGDPL[3] and  
		pEquip.nLevel == tbGDPL[4]) then
		return 1;
	end
	return pEquip.Regenerate(
		tbGDPL[1],
		tbGDPL[2],
		tbGDPL[3],
		tbGDPL[4],
		pEquip.nSeries,
		pEquip.nEnhTimes,
		pEquip.nLucky,
		pEquip.GetGenInfo(),
		0,
		pEquip.dwRandSeed,
		pEquip.nStrengthen
	);
end

function Item:CheckCanChangable(pEquip)
	local tbSetting = Item:GetExternSetting("change", pEquip.nVersion, 1);
	local szGDPL = string.format("%d,%d,%d,%d", pEquip.nGenre, pEquip.nDetail, pEquip.nParticular, pEquip.nLevel);
	if not tbSetting.tbItemToChangeId or not tbSetting.tbItemToChangeId[szGDPL] then
		return;
	end
	local nId = tbSetting.tbItemToChangeId[szGDPL];
	if (not tbSetting.tbChange or 
		not tbSetting.tbChange[nId])then
		return;
	end
	return tbSetting.tbChange[nId];
end

-- �����������
function Item:BindWithTong(pItem, nTongId)
	if pItem then
		pItem.SetGenInfo(Item.TASK_OWNER_TONGID, nTongId);
		pItem.Sync();
		return 1;
	end
end

-- ���õ����Ƿ���Ա�ĳ����Աʹ��
function Item:IsBindItemUsable(pItem, nTongId)
	if pItem then
		local nOwnerTongId = KLib.Number2UInt(pItem.GetGenInfo(Item.TASK_OWNER_TONGID, 0));
		if nOwnerTongId == 0 or nOwnerTongId == nTongId then
			return 1;
		end
		local pTong = KTong.GetTong(nOwnerTongId);
		if pTong then
			me.Msg("�õ����Ѿ��Ͱ��["..pTong.GetName().."]�󶨣�");
		else
			me.Msg("�õ����Ѿ����������󶨣�");
		end
		return 0;
	end
	return 0;
end


--��⶯̬ע��ĵ�ͼ���ã�0�����ã�1��������
function Item:CheckDynamicForbiden(nMapId, szClassName)
	local tbDynamicForbiden = Map.tbDynamicForbiden;
	if tbDynamicForbiden == nil or (tbDynamicForbiden[nMapId] == nil) then
		return 0;
	end
	if (tbDynamicForbiden[nMapId][szClassName] == nil) then
		return 0;
	end
	return 1;
end


--������Ʒ������Ϣ�����Ż�ȯ��
--����ֵ��������Ʒ������������
function Item:CalDiscount(szClassName, tbWareList)
	
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:CalDiscount(tbWareList);
end

--����ʹ�ô���
function Item:DecreaseCouponTimes(szClassName, tbCouponWare)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return	tbClass:DecreaseCouponTimes(tbCouponWare);
end

function Item:CanCouponUse(szClassName, dwId)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		tbClass = self.tbClass["default"];
	end
	return tbClass:CanCouponUse(dwId);
end

