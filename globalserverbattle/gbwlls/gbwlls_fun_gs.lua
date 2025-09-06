--��������
--�����
--2008.10.13
local Fun = {};
GbWlls.Fun = Fun;

Fun.tbParamFun = 
{
	["exp"] 	= "ExeExp",			--����,��λ��
	expbase 	= "ExeExpbase",		--��׼����
	repute 		= "ExeRepute",		--����
	item 		= "ExeItem", 		--��Ʒ
	title 		= "ExeTitle", 		--�ƺ�
	binditem 	= "ExeBindItem", 	--����Ʒ
	prestige	= "ExePrestige",	--��������
	stock		= "ExeStock",		--�ɷ�
	honor		= "ExeHonor",		--����
	statuary	= "ExeStatuary",	--��������������ʸ�
	zonespetitle = "ExeZoneSpeTitle", -- �Զ�������������ĳƺ�
	zonetitle	= "ExeZoneTitle",	-- ������������ָ���ƺ�
	effect		= "ExeEffect",		-- Ч��
	fourtime	= "ExeFourTime",	-- 4��ʱ��
	playerskill	= "ExePlayerSkill",	-- ĥ��ʯ����Ƭ����ʯ
	factiontitle= "ExeFactionTile",
	itemex		= "ExeItemEx",		-- ֻ�����ܵ��ӵ���Ʒ
}
function Fun:GetNeedFree(tbParam)
	local nNeedFree = 0;
	for szFun, tbFun in pairs(tbParam) do
		for _, value in pairs(tbFun) do
			if szFun == "item" or szFun == "binditem" then
				nNeedFree = nNeedFree + 1;
			elseif (szFun == "itemex") then  -- TODO: ǰ�������ӵ���Ʒ�ܵ���
				nNeedFree = nNeedFree + 1;
			end
		end
	end
	return nNeedFree;
end

function Fun:DoExcute(pPlayer, tbParam)
	for szFun, tbFun in pairs(tbParam) do
		for _, value in pairs(tbFun) do
			if self.tbParamFun[szFun] and self[self.tbParamFun[szFun]] then
				self[self.tbParamFun[szFun]](self, pPlayer, value);
			end
		end
	end
end

--ʱ����ʾת��
function Fun:Number2Time(nTime)
	local nMin = math.mod(nTime, 100);
	local nHour = math.floor(nTime/ 100);
	local szMin = nMin;
	if nMin < 10 then
		szMin = "0" .. nMin;
	end
	local szTime = nHour .. ":" .. szMin;
	return szTime
end 

function Fun:ExeExp(pPlayer, value)
	pPlayer.AddExp(tonumber(value*10000));
end

function Fun:ExeExpbase(pPlayer, value)
	pPlayer.AddExp(pPlayer.GetBaseAwardExp() * value);
end

function Fun:ExeRepute(pPlayer, value)
	--��������
	pPlayer.AddRepute(7, 1, value);
end

function Fun:ExeItem(pPlayer, value)
	--�����Ʒ
	if pPlayer.CountFreeBagCell() < 1 then
		pPlayer.Msg(string.format("�������ı����ռ��������޷����<color=yellow>%s<color>", KItem.GetNameById(unpack(value))));
		return 0;
	end
	for nId, nNum in ipairs(value) do
		value[nId] = tonumber(nNum);
	end
	pPlayer.AddItem(unpack(value))
end

function Fun:ExeTitle(pPlayer, value)
	--��óƺ�.
	for nId, nNum in ipairs(value) do
		value[nId] = tonumber(nNum);
	end
	pPlayer.AddTitle(unpack(value));
	pPlayer.SetCurTitle(unpack(value));
end

function Fun:ExeBindItem(pPlayer, value)
	--�����Ʒ
	if pPlayer.CountFreeBagCell() < 1 then
		pPlayer.Msg(string.format("�������ı����ռ��������޷����<color=yellow>%s<color>", KItem.GetNameById(unpack(value))));
		return 0;
	end
	for nId, nNum in ipairs(value) do
		value[nId] = tonumber(nNum);
	end
	local pItem = pPlayer.AddItem(unpack(value));
	if pItem then
		pItem.Bind(1);
	end
end

--���ӽ�������
function Fun:ExePrestige(pPlayer, value)
	pPlayer.AddKinReputeEntry(value, "wlls");
end

--���ӽ����ʽ�͸��ˡ��峤�������ɷ�
function Fun:ExeStock(pPlayer, value)
	Tong:AddStockBaseCount_GS1(pPlayer.nId, value, 0.75, 0.15, 0.05, 0, 0.05);
end

--������������
function Fun:ExeHonor(pPlayer, value)
	Wlls:AddHonor(pPlayer.szName, value);
end

function Fun:ExeStatuary(pPlayer, value)
	Domain.tbStatuary:AddStatuaryCompetence(pPlayer.szName, tonumber(value));
	me.SetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_STATUARY_TYPE, tonumber(value));
	GbWlls:WriteLog("ExeStatuary", pPlayer.szName, "Get a Statuary", value);
	pPlayer.Msg("�����������������ʸ��뵽�����������������������");
end

function Fun:ExeZoneSpeTitle(pPlayer, value)
	local tbInfo = GbWlls:GetZoneInfo(GetGatewayName());
	if (not tbInfo) then
		GbWlls:WriteLog("ExeZoneSpeTitle", pPlayer.szName, "There is no ZoneInfo");
		return 0;
	end
	local szTitle = tbInfo[1] .. value[1];
	pPlayer.AddSpeTitle(szTitle, GetTime() + tonumber(value[2]), value[3]);
	GbWlls:WriteLog("ExeZoneSpeTitle", pPlayer.szName, "give zone spetitle", value[2], value[3]);
end

function Fun:ExeZoneTitle(pPlayer, value)
	local tbInfo = GbWlls:GetZoneInfo(GetGatewayName());
	if (not tbInfo) then
		GbWlls:WriteLog("ExeZoneTitle", pPlayer.szName, "There is no ZoneInfo");
		return 0;
	end
	pPlayer.AddTitle(tonumber(value[1]), tonumber(value[2]), tbInfo[2], 0);
	GbWlls:WriteLog("ExeZoneTitle", pPlayer.szName, "give zone title", value[1], value[2], tbInfo[2]);
end

function Fun:ExeEffect(pPlayer, value)
	for nId, nNum in ipairs(value) do
		value[nId] = tonumber(nNum);
	end
	pPlayer.AddSkillState(unpack(value));
end

function Fun:ExeFourTime(pPlayer, value)
	local nTime = tonumber(value);
	local nRemainTime = pPlayer.GetTask(1023, 2);
	nRemainTime = nRemainTime + nTime;
	if (nRemainTime > 140) then
		nRemainTime = 140;
	end
	pPlayer.SetTask(1023,2,nRemainTime);
end

function Fun:ExePlayerSkill(pPlayer, value)
	for nId, nNum in ipairs(value) do
		value[nId] = tonumber(nNum);
	end	
	pPlayer.CastSkill(value[1], value[2], value[3], pPlayer.GetNpc().nIndex);
end

function Fun:ExeFactionTile(pPlayer, value)
	for nId, nNum in ipairs(value) do
		value[nId] = tonumber(nNum);
	end	
	local nFaction = GbWlls:GetPlayerSportTask(pPlayer.szName, GbWlls.GBTASKID_MATCH_TYPE_PAREM);
	if (nFaction > 0) then
		me.AddTitle(value[1], value[2], nFaction, 0);
	end
end

function Fun:ExeItemEx(pPlayer, value)
	for nId, nNum in ipairs(value) do
		value[nId] = tonumber(nNum);
	end
	pPlayer.AddStackItem(value[1], value[2], value[3], value[4], {bForceBind=value[6]}, value[5]);
end
