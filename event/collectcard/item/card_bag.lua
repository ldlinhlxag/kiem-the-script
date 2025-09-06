Require("\\script\\event\\collectcard\\define.lua")

local tbItem = Item:GetClass("guoqing_shoucang");
local CollectCard = SpecialEvent.CollectCard;

function tbItem:GetTip(nState)
	local nEnter = 0;
	local szTipTemp = "";
	local nCollect = 0;
	for _, tbTask in pairs(CollectCard.TASK_CARD_ID) do
		local n = 10 - string.len(tbTask[2]);
		local szBlank = "";
		for i=1, n do
			szBlank = szBlank .. " ";
		end
		if me.GetTask(CollectCard.TASK_GROUP_ID, tbTask[1]) == 1 then
			szTipTemp = szTipTemp .. string.format("<color=yellow>%s<color>%s",tbTask[2],szBlank);
			nCollect = nCollect + 1;
		else
			szTipTemp = szTipTemp .. string.format("<color=gray>%s<color>%s",tbTask[2],szBlank);
		end
		nEnter = nEnter + 1;
		if math.mod(nEnter, 4) == 0 then
			szTipTemp = szTipTemp .. "";
		end
		
	end
	local nAwarId, szDesc, nCollect, nOpenMaxCard = CollectCard:GetAward_CardBag_InFor();
	local szLuckyCard = "����";
	local nLuckyId = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_COLLECTCARD_RANDOM);
	if CollectCard.TASK_CARD_ID[nLuckyId] then
		szLuckyCard = CollectCard.TASK_CARD_ID[nLuckyId][2];
	end
	
	local szTip = string.format("�������˿���<color=gold>%s<color><enter>�Ѽ�����Ƭ����%s��<enter>���ռ��Ŀ�Ƭ(%s/56)��<enter>%s", 
		szLuckyCard, nOpenMaxCard, nCollect, szTipTemp);

	return szTip;
end

function tbItem:OnUse()
	--local nAwarId, szDesc, nCollect, nOpenMaxCard = CollectCard:GetAward_CardBag_InFor()
	--if nAwarId < 0 then
	--	szDesc = "���޽���";
	--end
	--
	--local szTip = string.format("<enter>�����ڼ䣬���Ѿ���������<color=yellow>%s��<color>������ܹ����Լ���<color=yellow>50��<color>�����ղص���<color=yellow>%s��<color>�����������Ŀǰ�Ĳ�����������Ի�����½�����\n\n<color=yellow>%s<color>\n\n", nOpenMaxCard, nCollect,szDesc);
	--if nCollect < 28 then
	--	szTip = szTip .. "���������";
	--end
	--local tbOpt = {{"ȷ��"}};
	--Dialog:Say(szTip, tbOpt);
	return 0;
end

