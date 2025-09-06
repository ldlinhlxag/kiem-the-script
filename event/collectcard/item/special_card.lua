Require("\\script\\event\\collectcard\\define.lua")

local tbItem = Item:GetClass("chanjuan_card"); -- ǧ�ﹲ濾�
local CollectCard = SpecialEvent.CollectCard;

function tbItem:OnUse()
	self:OpenPage(it.dwId, 0);
	return 0;
end

function tbItem:OpenPage(nItemId, nNowPage)
	local pItem = KItem.GetObjById(nItemId);
	if (not pItem) then
		return;
	end	
	if me.GetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_COLLECT_FINISH) == 1 then
		me.Msg("���Ѽ��������п�Ƭ�������һ�����˿���");
		local nP = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_COLLECTCARD_RANDOM);
		if me.DelItem(pItem, Player.emKLOSEITEM_TYPE_EVENTUSED) ~= 1 then
			CollectCard:WriteLog("ɾ��ǧ�ﹲ濾�ʧ��", me.nId);
			return;
		end
		local pItemAdd = me.AddItem(18, 1, nP, 1);
		if pItemAdd then
			pItemAdd.Bind(1);
			local szDate = GetLocalDate("%Y/%m/%d/24/00/00");
			me.SetItemTimeout(pItemAdd, szDate);
		end
		return 1;
	end
	local szMsg = "��ѡ������Ҫ��ȡ�Ŀ�Ƭ";
	local tbOpt = {};
	local nPage = 5; -- ÿҳ��ʾ5�ſ�Ƭ
	local nCount = nNowPage * nPage;
	local nSum = 0;
	for nP, tbTask in pairs(CollectCard.TASK_CARD_ID) do
		if me.GetTask(CollectCard.TASK_GROUP_ID, tbTask[1]) == 0 then
			--print(nCount, nSum, tbTask[1], tbTask[2])
			nSum = nSum + 1;
			if nSum > nCount then
				nCount = nCount + 1;
				if nCount > (nPage * (nNowPage + 1)) then
					table.insert(tbOpt, {"��һҳ", self.OpenPage, self, nItemId, nNowPage + 1});
					break;
				end
				local tbTemp = {tbTask[2], self.OnUseSure, self, me.nId, nItemId, nP};
				table.insert(tbOpt, tbTemp);
			end
		end
	end
	
	if nSum > 0 then
		table.insert(tbOpt, {"��������"});
		Dialog:Say(szMsg, tbOpt);
	else
		local nLuckyId = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_COLLECTCARD_RANDOM);
		me.AddItem(18,1,nLuckyId,1);
		pItem.Delete(me);
	end
end

function tbItem:OnUseSure(nPlayerId, nItemId, nP)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if (not pPlayer) then
		return;
	end		
	local pItem = KItem.GetObjById(nItemId);
	if (not pItem) then
		return;
	end
	if pPlayer.DelItem(pItem, Player.emKLOSEITEM_TYPE_EVENTUSED) ~= 1 then
		CollectCard:WriteLog("ɾ��ǧ�ﹲ濾�ʧ��", pPlayer.nId);		
		return;
	end
	local pItemAdd = me.AddItem(18, 1, nP, 1);
	if pItemAdd then
		pItemAdd.Bind(1);
		local szDate = GetLocalDate("%Y/%m/%d/24/00/00");
		pPlayer.SetItemTimeout(pItemAdd, szDate);
		CollectCard:WriteLog(string.format("ǧ�ﹲ濾꣬��ȡ��һ��%s", pItemAdd.szName), pPlayer.nId);		
	end
end

function tbItem:InitGenInfo()
	local nTime = tonumber(os.date("%Y%m%d", GetTime()));
	nTime = Lib:GetDate2Time(nTime);
	nTime = nTime + 86400
	it.SetTimeOut(0, nTime);
	return {};
end
