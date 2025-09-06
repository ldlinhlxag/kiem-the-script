
Require("\\script\\event\\collectcard\\define.lua")
local CollectCard = SpecialEvent.CollectCard;

function CollectCard:GetAward_GS(nPlayerId, nFlag)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if (not pPlayer) then
		return;
	end	
	if nFlag == 1 then
		--��ûƽ�����
		local pItem = pPlayer.AddItem(unpack(self.ITEM_GOLDTOKEN));
		if pItem then
			local szData = os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 43200*60 )
			pPlayer.SetItemTimeout(pItem, szData);
			CollectCard:WriteLog("ȫ��Ψһ�ƽ����ƻ����ң�����˻ƽ�����", pPlayer.nId)
		end
		pItem = pPlayer.AddItem(unpack(self.ITEM_GOLDHUOJU));
		if pItem then
			pPlayer.SetItemTimeout(pItem, self:CreateStrDate(4));
			CollectCard:WriteLog("ȫ��Ψһ�ƽ����ƻ����ң�����˻ƽ���", pPlayer.nId)
		end
		KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, string.format("%s��ʢ�Ļ�ƽ��䣬�����ʢ�Ļ�ƽ����ƣ��ɶһ�����+1������ ", pPlayer.szName));
	elseif nFlag ==  2 then
		--��ð�������
		local pItem = pPlayer.AddItem(unpack(CollectCard.ITEM_WHITETOKEN));
		if pItem then
			local szData = os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 43200*60 )
			pPlayer.SetItemTimeout(pItem, szData);
			CollectCard:WriteLog("ȫ��Ψһ�������ƻ����ң�����˰�������", pPlayer.nId)			
		end
		pItem = pPlayer.AddItem(unpack(CollectCard.ITEM_GOLDHUOJU));
		if pItem then
			pPlayer.SetItemTimeout(pItem, self:CreateStrDate(4));
			CollectCard:WriteLog("ȫ��Ψһ�������ƻ����ң�����˻ƽ���", pPlayer.nId)
		end
	else
		self:GetAward_BaoXiang(pPlayer, 1);
	end
	pPlayer.AddWaitGetItemNum(-1);
	return 0;
end

function CollectCard:XiuLianZhu()
	
	local nData = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	
	if nData < self.TIME_STATE[3] then
		Dialog:Say("�������ѡ������<color=yellow>8��28��<color>��ʼ��<color=yellow>8��31��22��<color>�����������ڴ���");
		return 1;
	end
	
	if nData >= self.TIME_STATE[5] then
		Dialog:Say("�������ѡ�Ѿ��ر�");
		return 1;
	end

	local szMsg = "ʢ�Ļ�������ѡ:\n\n<color=yellow>";
	local nRank = 0;
	for ni = DBTASD_EVENT_COLLECTCARD_RANK01, DBTASD_EVENT_COLLECTCARD_RANK10 do
		local nPoint = KGblTask.SCGetDbTaskInt(ni);
		local szName = KGblTask.SCGetDbTaskStr(ni);
		nRank = nRank + 1;
		if nPoint > 0 and szName ~= "" then
			szMsg = szMsg .. Lib:StrFillL(string.format("��%2s����%s", nRank, szName), 25).. nPoint .."��\n"
		end
	end
	
	szMsg = szMsg .. "<color>\n��ѡ����ʱ�䣺<color=red>8��31��22��00<color>\n";
	szMsg = szMsg .. "\n��Ŀǰ�Ļ��֣�\n".. string.format("<color=yellow>%s��%s��<color>", me.szName, me.GetTask(self.TASK_GROUP_ID, self.TASK_HUOJU_POINT));
	Dialog:Say(szMsg);
end


--��ȡ���ά��
function CollectCard:GetAward_CardBag_InFor()
	local nCollectCount = 0;
	local szItemName = "";
	local szDesc = "";
	for nPId, tbTask in pairs(self.TASK_CARD_ID) do
		if me.GetTask(self.TASK_GROUP_ID, tbTask[1]) == 1 then
			nCollectCount = nCollectCount + 1;
		end
	end
	local nMaxOpenCard = me.GetTask(self.TASK_GROUP_ID, self.TASK_COLLECT_COUNT);
	if nCollectCount < 4 and nMaxOpenCard < 40 then
		szDesc = "���ռ����Ļ������̫�ͣ����ܻ�û����";
		return -1, szDesc, nCollectCount, nMaxOpenCard;
	end	
	
	local nType = 0;
	local nAwardId = 0;
	if nMaxOpenCard == 50 then
		nType = 3;
	elseif nMaxOpenCard >= 40 then
		nType = 2;
	else
		nType = 1;
	end
	for ni, nCount in ipairs(CollectCard.CARD_BAG_AWARD_STEP[nType]) do
		if nCollectCount >= nCount then
			szItemName = KItem.GetNameById(unpack(CollectCard.CARD_BAG_AWARD[ni]))
			nAwardId = ni;
			break;
		end
	end
	szDesc = "1��"..szItemName;
	return nAwardId, szDesc, nCollectCount, nMaxOpenCard;
end

--���佱��
function CollectCard:GetAward_BaoXiang(pPlayer, nTypeId)
	local nMaxRate = self.BaoXiangFile[nTypeId].MaxRate;
	local nRandomRate = Random(nMaxRate) + 1;
	local nSum = 0;
	for _, tbItem in pairs(self.BaoXiangFile[nTypeId].RateItem) do
		nSum = nSum + tbItem.nRate;
		if nSum >= nRandomRate then
			if tbItem.nMoney > 0 then
				local nAddMoney = pPlayer.Earn(tbItem.nMoney, Player.emKEARN_COLLECT_CARD);
				if nAddMoney == 1 then
					CollectCard:WriteLog(string.format("����%s��ʢ�����ӣ��ɹ������%s����",nTypeId, tbItem.nMoney), pPlayer.nId)
				else
					CollectCard:WriteLog(string.format("����%s��ʢ�����ӣ������ﵽ����,�����%s����ʧ��",nTypeId, tbItem.nMoney), pPlayer.nId)
				end
			end
			if tbItem.nGenre > 0 and tbItem.nDetailType > 0 and tbItem.nParticularType > 0 then
				local pItem = pPlayer.AddItem(tbItem.nGenre, tbItem.nDetailType, tbItem.nParticularType, tbItem.nLevel);
				if pItem then
					CollectCard:WriteLog(string.format("����%s��ʢ�����ӣ������%s",nTypeId, pItem.szName), pPlayer.nId)
				end
			end
			break;
		end
	end
	for _, tbItem in pairs(self.BaoXiangFile[nTypeId].FixItem) do
		if tbItem.nGenre > 0 and tbItem.nDetailType > 0 and tbItem.nParticularType > 0 then
			local pItem = pPlayer.AddItem(tbItem.nGenre, tbItem.nDetailType, tbItem.nParticularType, tbItem.nLevel);
			if pItem then
				pPlayer.SetItemTimeout(pItem, self:CreateStrDate(4));
				CollectCard:WriteLog(string.format("����%s��ʢ�����ӣ������%s",nTypeId, pItem.szName), pPlayer.nId)
			end
		end
	end
end

--���ʢ�Ļ����δ������;
function CollectCard:GetAward_EventCard(pPlayer, nNum)
	local nData = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	if nData >= self.TIME_STATE[1] and nData < self.TIME_STATE[2] then
		for i=1, nNum do 
			local pItem = pPlayer.AddItem(unpack(self.ITEM_CARD_ORG));
			if pItem then
				local szDate = GetLocalDate(self:CreateStrDate(2))
				pPlayer.SetItemTimeout(pItem, szDate);
			end
		end
	end
end

function CollectCard:CheckEventTime(szClass)
	local nData = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	
	if not szClass then
		if nData >= self.TIME_STATE[1] and nData < self.TIME_STATE[5] then
			return 1;
		end
		return 0;
	elseif szClass == "OnAward_EventCard" then
		if nData >= self.TIME_STATE[1] and nData < self.TIME_STATE[2] then
			return 1;
		end
		return 0;		
	elseif szClass == "OnAward_Card_Bag" then
		if nData >= self.TIME_STATE[1] and nData < self.TIME_STATE[3] then
			return 1;
		end
		return 0;		
	end
end

function CollectCard:CreateStrDate(nState)
	local nDate = self.TIME_STATE[nState];
	local nSec = Lib:GetDate2Time(math.floor(nDate/100))
	
	local szDate = os.date("%Y/%m/%d/%H/%M/%S", nSec);
	return szDate;
end

function CollectCard:GetPlayerRankByName(szName)
	local nClass = PlayerHonor.HONOR_CLASS_SPRING;
	local nType = Ladder:GetType(0, Ladder.LADDER_CLASS_LADDER, Ladder.LADDER_TYPE_LADDER_ACTION, Ladder.LADDER_TYPE_LADDER_ACTION_SPRING);
	return PlayerHonor:GetPlayerHonorRankByName(szName, nClass, nType);
end


function CollectCard:ChuxiaoOnLogin()
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	if nCurDate >= 20091001 then
		return 0;
	end
	local nReg = EventManager:GetTask(129);
	local nPay = me.GetTask(2093, 13);
	local nCurPay = me.GetExtMonthPay();
	if nReg > 0 then
		if nPay >= 120 then
			return 0;
		end
		if nPay >=60 and nCurPay < 120 then
			return 0;
		end
		if nCurPay < 60 then
			return 0;
		end
		local szPay = 60;
		if nCurPay >= 120 then
			szPay = 120;
		end
		me.SetTask(2093, 13, nCurPay);
		local szMsg = string.format("��ɹ���á��������˵ڶ�����������ۼƳ�ֵ�ﵽ%sԪ���ʸ�", szPay);
		Dialog:SendBlackBoardMsg(me, szMsg);
		me.Msg(string.format("<color=yellow>%s<color>",szMsg));
	end
end
CollectCard.nChuxiaoOnLoginId = PlayerEvent:RegisterOnLoginEvent(CollectCard.ChuxiaoOnLogin, CollectCard);
