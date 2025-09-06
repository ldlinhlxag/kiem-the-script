
-- �������
-- 
------------------------------------------------------------------------------------------
Require("\\script\\lib\\gift.lua");
Item.tbGift = Gift:New();
local tbGift = Item.tbGift;
tbGift.ITEM_CLASS = "xuanjing";
tbGift.LAYER = 3;
tbGift.NEEDLEVEL_MIN	= 10;	-- ����Ҫ10�����������ܲ�
tbGift.NEEDLEVEL_MAX	= 12;	-- 12�����ϵ��������ܲ�Ŀǰ�����ȼ����12����


function tbGift:OnOK(tbParam)
	local pItem = self:First();
	local tbLogItem = {}
	if not pItem then
		me.Msg("�����Ҫ���İ󶨵�������")
		return 0;
	end
	
	while pItem do
		if pItem.szClass ~= self.ITEM_CLASS or pItem.nLevel < self.NEEDLEVEL_MIN
			or pItem.nLevel > self.NEEDLEVEL_MAX or pItem.IsBind() ~= 1 then
		   	me.Msg("ֻ�ܷ�10����12���İ�������");
		   	return 0;
		else
			if not tbLogItem[pItem.nLevel] then 
				tbLogItem[pItem.nLevel] = 0;
			end
			tbLogItem[pItem.nLevel] = tbLogItem[pItem.nLevel] + 1;
			pItem = self:Next();
		end
	end
	
	local pFind = self:First();
	local tbBreakUpItem = Item:ValueToItem(pFind.nValue, self.LAYER, 1);	-- ���һ�������Ǳ�־λ����ʾ�ǲ���
	local nNum = 0;
	for nItemLevel, nItemNum in pairs(tbBreakUpItem) do
		nNum = nNum + nItemNum;
	end
	
	if me.CountFreeBagCell() < nNum then
		me.Msg(string.format("���ı����ռ䲻�㣬����Ҫ%s���ռ���ӡ�", nNum));
		return 0;
	end
	
	-- ɾ����Ʒ
	local nTimeType, nTime = pFind.GetTimeOut();
	if nTimeType and nTimeType == 0 and nTime > 0 then
		Dbg:WriteLog("breakupxuanjing",  me.szName, "�۳���Ʒ:", pFind.szName, "ʱ��Ϊ��"..os.date("%Y/%m/%d/%H/%M/00", nTime));
	elseif nTimeType and nTimeType == 1 and nTime > 0 then
		Dbg:WriteLog("breakupxuanjing",  me.szName, "�۳���Ʒ:", pFind.szName, "ʱ�޻��У�"..Lib:TimeDesc(nTime));
	else
		Dbg:WriteLog("breakupxuanjing",  me.szName, "�۳���Ʒ:", pFind.szName);
	end
	
	if me.DelItem(pFind, Player.emKLOSEITEM_BREAKUP) ~= 1 then
		Dbg:WriteLog("breakupxuanjing",  me.szName, "�۳���Ʒʧ��, Ҫ�۳�����ƷΪ:", pFind.szName);
		return 0;
	end
	
	-- �����Ʒ
	local szLogMsg = "["..me.szName.."]����ˣ�"; 
	for nItemLevel, nItemNum in pairs(tbBreakUpItem) do
		for i = 1, nItemNum do
			local pItem = me.AddItem(Item.SCRIPTITEM, 1, 114, nItemLevel);
			if nTimeType and nTime and nTime ~= 0 then
				if nTimeType == 0 then
					me.SetItemTimeout(pItem, os.date("%Y/%m/%d/%H/%M/00", nTime), 1);
				elseif nTimeType == 1 then
					me.SetItemTimeout(pItem, math.ceil(nTime / 60), 0);
				end
				pItem.Sync();
			end
		end
		szLogMsg = szLogMsg..nItemLevel.."������"..nItemNum.."�� ";
	end
	
	if nTimeType and nTimeType == 0 and nTime > 0 then
		szLogMsg = szLogMsg.."ʱ��Ϊ��"..os.date("%Y/%m/%d/%H/%M/00", nTime);
	elseif nTimeType and nTimeType == 1 and nTime > 0 then
		szLogMsg = szLogMsg.."ʱ�޻��У�"..Lib:TimeDesc(nTime);
	end
	Dbg:WriteLog("breakupxuanjing", szLogMsg);
end

function tbGift:OnSwitch(pPickItem, pDropItem, nX, nY)
	if (not pDropItem) then
		return 1;
	end
	
	local pFind = self:First();
	if (pFind) then
		me.Msg("<color=red>һ��ֻ�ܷ�һ��10����12���İ�������<color>");
		return 0;
	end

	if pDropItem.szClass ~= self.ITEM_CLASS or pDropItem.nLevel < self.NEEDLEVEL_MIN 
		or pDropItem.nLevel > self.NEEDLEVEL_MAX or pDropItem.IsBind() ~= 1 then
		me.Msg("<color=red>ֻ�ܷ�10����12���İ�������<color>");
		return 0;
	end
	return	1;
end

function tbGift:OnUpdate()
	self._szTitle = "�������";
	local pItem = self:First();
	if not pItem then
		self._szContent = "�����Ҫ����������ֻ�ܷ�10����12���İ�������";
		return 0;
	end

	local pFind = self:First();
	local tbBreakUpItem = Item:ValueToItem(pFind.nValue, self.LAYER, 1);	-- ���һ�������Ǳ�־λ����ʾ�ǲ���
	local nNum = 0;
	local szMsg = ""; 
	for i = 1, 12 do  
		if tbBreakUpItem[i] and tbBreakUpItem[i] > 0 then
			szMsg = szMsg.."    "..i.."������"..tbBreakUpItem[i].."��\n";
			nNum = nNum + tbBreakUpItem[i];
		end
	end

	self._szContent = "�����Բ��ɣ�\n<color=yellow>"..szMsg.."<color>��Ҫ"..nNum.."���ռ�����š�";
end
