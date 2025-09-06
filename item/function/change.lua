
-- �һ���ʯ �ű�


--- ������Gift����

Item.ChangeGift = Gift:New();

local tbGift = Item.ChangeGift;

Item.CHANGE_RATE			= 1000;
Item.SPIRITSTONE			= {18,1,205,1,0,0}
Item.SPIRITSTONE_STACK_NUM	= 1000;

function tbGift:OnSwitch(pPickItem, pDropItem, nX, nY)
	if pDropItem then
		if Item:CalcChange({pDropItem}) <= 0 then
			me.Msg("����Ʒ���ܶһ���");
			return 0;
		end
	end	
	return	1;
end

function tbGift:OnUpdate()
	self._szTitle = "�һ���ʯ";
	local pItem = self:First();
	local tbItem = {}
	if not pItem then
		self._szContent = "�����Ҫ�һ�����Ʒ��"
		return 0;
	end
	while pItem do
		table.insert(tbItem, pItem);
		pItem = self:Next();
	end
	local nChangeNum = Item:CalcChange(tbItem);
	self._szContent = "�����Զһ���<color=yellow>"..nChangeNum.."��<color>���л�ʯ����Ҫ"..math.ceil(nChangeNum / Item.SPIRITSTONE_STACK_NUM).."���ռ�����š�";
end

function tbGift:OnOK(tbParam)
	local pItem = self:First();
	local tbItem = {}
	if not pItem then
		me.Msg("�����Ҫ�һ�����Ʒ��")
		return 0;
	end
	while pItem do
		table.insert(tbItem, pItem);
		pItem = self:Next();
	end
	local nChangeNum = Item:CalcChange(tbItem);
	local nFreeCount = math.ceil(nChangeNum / Item.SPIRITSTONE_STACK_NUM);
	if me.CountFreeBagCell() < nFreeCount then
		me.Msg(string.format("���ı����ռ䲻�㣬����Ҫ%s���ռ���ӡ�", nFreeCount));
		return 0;
	end
	Item:Change(tbItem)
end


--- ����Ԥ��
function Item:CalcChange(tbItem)
	local nTotleCost = 0;
	for _, pItem in pairs(tbItem) do
		local tbClass = self.tbClass[pItem.szClass];
		if (not tbClass) then
			tbClass = self.tbClass["default"];
		end
		if tbClass:GetChangeable(pItem) == 1 and pItem.IsBind() ~= 1 then
			nTotleCost = nTotleCost + pItem.nMakeCost;
		end
	end
	return math.floor(nTotleCost / self.CHANGE_RATE);
end

--- �����߼�
function Item:Change(tbItem)
	local nBudget = self:CalcChange(tbItem);
	if nBudget <= 0 then
		return 0;
	end
	if me.CalcFreeItemCountInBags(unpack(self.SPIRITSTONE)) < nBudget then
		me.Msg("��ı����ռ䲻��");
		return 0;
	end
	local nTotleCost = 0;
	local szLog = "ԭ�ϣ�"
	for _, pItem in pairs(tbItem) do
		local szItemName = pItem.szName;
		local tbClass = self.tbClass[pItem.szClass];
		if (not tbClass) then
			tbClass = self.tbClass["default"];
		end
		if tbClass:GetChangeable(pItem) == 1 and pItem.IsBind() ~= 1 then
			local nCurCost = pItem.nMakeCost;
			if nCurCost > 0 then
				local nRet = me.DelItem(pItem, Player.emKLOSEITEM_CHANGE_HUN);		-- �۳���ʯ
				if nRet == 1 then
					nTotleCost = nTotleCost + nCurCost;
					szLog = szLog.." "..szItemName
				else
					Dbg:WriteLog("Change", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "�۳�����ʧ��:", szItemName);
				end
			end
		else
			Dbg:WriteLog("Change", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "���Ի��벻�ɶһ�װ����", szItemName);
		end
	end
	local nItemNum = math.floor(nTotleCost / self.CHANGE_RATE);
	local nGivenNum = me.AddStackItem(self.SPIRITSTONE[1],self.SPIRITSTONE[2],self.SPIRITSTONE[3],self.SPIRITSTONE[4], nil, nItemNum);
	-- KStatLog.ModifyAdd("mixstat", "���л�ʯ\t����", "����", nGivenNum);
	Dbg:WriteLog("Change", "��ɫ��:"..me.szName, "�ʺ�:"..me.szAccount, "�һ���"..nItemNum.."����ʯ,ʵ�ʸ�����"..nGivenNum.."��", szLog);
	return 1
end



