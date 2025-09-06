--��������
--�����
--2008.10.13
local Fun = {};
EPlatForm.Fun = Fun;

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
}
function Fun:GetNeedFree(tbParam)
	local nNeedFree = 0;
	for szFun, tbFun in pairs(tbParam) do
		if szFun == "item" or szFun == "binditem" then
			for _, value in pairs(tbFun) do		
				local nCount = 1;
				if (value[6]) then
					nCount = value[6];
					if (type(nCount) == "string") then
						nCount = tonumber(nCount);
					end
					if (nCount <= 0) then
						nCount = 1;
					end
				end
				nNeedFree = nNeedFree + nCount;
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
	
	local nTime = 0;
	local nCount = 1;
	local tbItem = Lib:CopyTB1(value);

	if (tbItem[6] and tbItem[6] > 0) then
		nCount = tbItem[6];
		tbItem[6] = nil;
	end
	
	if (tbItem[5] and tbItem[5] > 0) then
		nTime = tbItem[5];
		tbItem[5] = nil;
	end
	
	if pPlayer.CountFreeBagCell() < nCount then
		pPlayer.Msg(string.format("�������ı����ռ��������޷����<color=yellow>%s<color>", KItem.GetNameById(unpack(tbItem))));
		EPlatForm:WriteLog("Fun:ExeItem", "��ȡ���Ʒ����ʧ�ܣ������ռ䲻��  " .. pPlayer.szName, unpack(value));
		return 0;
	end
	local nNowTime = GetTime();
	for i=1, nCount do
		local pItem = pPlayer.AddItem(unpack(tbItem));
		if (pItem) then
			if (nTime > 0) then
				local szDate = os.date("%Y/%m/%d/%H/%M/%S", nNowTime + nTime * 60);
				pPlayer.SetItemTimeout(pItem, szDate);
				EPlatForm:WriteLog("Fun:ExeItem", "��ȡ���Ʒ�����ɹ�  " .. pPlayer.szName, unpack(value));
			end
		end
	end
end

function Fun:ExeTitle(pPlayer, value)
	--��óƺ�.
	pPlayer.AddTitle(unpack(value));
	pPlayer.SetCurTitle(unpack(value));
end

function Fun:ExeBindItem(pPlayer, value)
	--�����Ʒ
	local nTime = 0;
	local nCount = 1;
	local tbItem = Lib:CopyTB1(value);

	if (tbItem[6] and tbItem[6] > 0) then
		nCount = tbItem[6];
		tbItem[6] = nil;
	end
	
	if (tbItem[5] and tbItem[5] > 0) then
		nTime = tbItem[5];
		tbItem[5] = nil;
	end
	
	if pPlayer.CountFreeBagCell() < nCount then
		pPlayer.Msg(string.format("�������ı����ռ��������޷����<color=yellow>%s<color>", KItem.GetNameById(unpack(tbItem))));
		EPlatForm:WriteLog("Fun:ExeBindItem", "��ȡ���Ʒ����ʧ�ܣ������ռ䲻��  " .. pPlayer.szName, unpack(value));
		return 0;
	end

	local nNowTime = GetTime();
	for i=1, nCount do
		local pItem = pPlayer.AddItem(unpack(tbItem));
		if (pItem) then
			pItem.Bind(1);
			if (nTime > 0) then
				local szDate = os.date("%Y/%m/%d/%H/%M/%S", nNowTime + nTime * 60);
				pPlayer.SetItemTimeout(pItem, szDate);
			end
			EPlatForm:WriteLog("Fun:ExeBindItem", "��ȡ���Ʒ�����ɹ�  " .. pPlayer.szName, unpack(value));
		end
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
