--�ص������ű�
--�����
--2008.07.09
--�����ǵ���������󲹳�


local Compensate = {};
SpecialEvent.Compensate = Compensate;

Compensate.EXT_POINT  = 4;	--������չ�㣬��24λ��¼���Σ���8λ��¼��������������255
Compensate.EXT_BATCH  = 5;	--���Σ�ÿ�β���������1
Compensate.EXT_COUNT  = 30;	--ÿ��һ����ȡ������
Compensate.TIME_START = 0;
Compensate.TIME_END   = 200906142400;
Compensate.OPEN		  = 0; --��������
Compensate.FILE_PATH  = "\\setting\\event\\compensate\\compensate.txt";	--��������·��
function Compensate:OnDialog()
	local tbOpt = {
		{"��Ҫ��ȡ",self.GetAward, self},
		{"��û��ʲô��Ʒ��ûʲô�����"},
	}
	local szMsg = string.format("���ã������������������������%s�����򵫶�ʧ����Ʒ������Ʒ��ʧ����Ҵ����Ĳ��㣬�������Ǹ�⡣\nÿ�������ȡ%s����Ʒ�����жཫ�������ȡ��\n<color=red>��ȡ��ֹʱ�䣺%s��%s��%s��%sʱ<color>",IVER_g_szCoinName,self.EXT_COUNT, math.mod(math.floor(self.TIME_END/10^8), 10^4),math.mod(math.floor(self.TIME_END/10^6), 10^2),math.mod(math.floor(self.TIME_END/10^4), 10^2),math.mod(math.floor(self.TIME_END/10^2), 10^2));
	Dialog:Say(szMsg, tbOpt)
end

function Compensate:CheckState()
	if self.OPEN ~= 1 then
		return 0;
	end
	local szServer = string.sub(GetGatewayName(), 5, 6);
	local nDate = tonumber(GetLocalDate("%Y%m%d%H%M"));
	if nDate >= self.TIME_START and nDate < self.TIME_END and self.tbTxt[szServer] ~= nil then
		return 1;
	end
	return 0;
end

function Compensate:GetAward()
	if self:CheckState() == 0 then
		Dialog:Say("��Ѿ�������");
		return 0;
	end
	local szServer = string.sub(GetGatewayName(), 5, 6);
	if self.tbTxt[szServer][string.upper(me.szAccount)] == nil then
		Dialog:Say(string.format("�Բ������������%s���������Ʒû�ж�ʧ�ļ�¼��û�п���ȡ����Ʒ��", IVER_g_szCoinName));
		return 0;
	end
	local tbItem = self.tbTxt[szServer][string.upper(me.szAccount)]
	if self:GetExtPointByte() * self.EXT_COUNT > #tbItem then
		Dialog:Say("�Բ������Ѿ�ȫ����ȡ�����е���Ʒ����������ȡ�ˡ�");
		return 0;
	end
	
	if self:GetExtPointByte() + math.ceil((#tbItem - self:GetExtPointByte() * self.EXT_COUNT) / self.EXT_COUNT) >  255 then
		Dialog:Say("�����ʺų����쳣����ʱ�޷���ȡ��");
		Compensate:WriteLog(me,"��չ�㳬���������ޣ�����255��");
		return 0;
	end
	
	if #tbItem - self:GetExtPointByte() * self.EXT_COUNT > self.EXT_COUNT then
		if me.CountFreeBagCell() < self.EXT_COUNT then
			Dialog:Say(string.format("�Բ������ı����ռ䲻����������һ�±���������ȡ������Ҫ%s�񱳰��ռ䣬������ȡ��", self.EXT_COUNT));
			return 0;
		end
	else
		if me.CountFreeBagCell() < #tbItem - self:GetExtPointByte() * self.EXT_COUNT then
			Dialog:Say(string.format("�Բ������ı����ռ䲻����������һ�±���������ȡ������Ҫ%s�񱳰��ռ䡣", #tbItem - self:GetExtPointByte() * self.EXT_COUNT ));
			return 0;
		end
	end
	
	local nId = self:GetExtPointByte() * self.EXT_COUNT;
	nId = nId + 1;
	local nMaxId = #tbItem;
	if nMaxId > (self:GetExtPointByte() + 1) * self.EXT_COUNT  then
		nMaxId = (self:GetExtPointByte() + 1) * self.EXT_COUNT;
	end
	self:AddExtPointByte(1);
	for ni = nId, nMaxId do
		local pItem = me.AddItem(unpack(tbItem[ni].tbItem));
		if pItem then
			me.SetItemTimeout(pItem,os.date("%Y/%m/%d/00/00/00", GetTime() + 60 * tbItem[ni].nLimit));
			pItem.Sync();
			local szItem = string.format("%s,%s,%s,%s",tbItem[ni].tbItem[1],tbItem[ni].tbItem[2],tbItem[ni].tbItem[3],tbItem[ni].tbItem[4]);
			Compensate:WriteLog(me,"��ȡ��Ʒ�ɹ� ��ƷID��"..szItem);
		else
			local szItem = string.format("%s,%s,%s,%s",tbItem[ni].tbItem[1],tbItem[ni].tbItem[2],tbItem[ni].tbItem[3],tbItem[ni].tbItem[4]);
			Compensate:WriteLog(me,"��ȡ��Ʒʧ�� ��ƷID��"..szItem);
		end
	end
	local szMsg = ""
	if #tbItem - self:GetExtPointByte() * self.EXT_COUNT <= 0 then
		szMsg = "���ɹ���ȡ�����˲�����Ʒ����鿴���ı�����"
	else
		local nCount = math.ceil((#tbItem - self:GetExtPointByte() * self.EXT_COUNT) / self.EXT_COUNT);
		szMsg = string.format("���ɹ���ȡ������Ʒ���㻹��<color=red>%s��<color>��Ʒû��ȡ������պñ�����Ʒ�������ȡ������Ʒ��", nCount);
	end
	Dialog:Say(szMsg);
end

function Compensate:WriteLog(pPlayer, szMsg)
	Dbg:WriteLog("SpecialEvent.Compensate", "����", pPlayer.szAccount, pPlayer.szName, szMsg);
end

function Compensate:LoadFile()
	self.tbTxt = {};
	local tbFile = Lib:LoadTabFile(self.FILE_PATH);
	if not tbFile then
		return
	end
	for nId, tbParam in ipairs(tbFile) do
		local szGateWay = string.sub(tbParam.GATEWAY_NAME, 5, 6);
		if self.tbTxt[szGateWay] == nil then
			self.tbTxt[szGateWay] = {}
		end
		local szAccount = string.upper(tbParam.ACCOUNT);
		if self.tbTxt[szGateWay][szAccount] == nil then
			self.tbTxt[szGateWay][szAccount] = {};
		end
		local nItemType = tonumber(tbParam.ITEM_TYPE) or 0;
		local nGenre, nDetail, nParticular = self:GetItemType2Item(nItemType);
		local nLevel =  tonumber(tbParam.ITEM_LEVEL) or 1;
		local nTimeLimit = tonumber(tbParam.TIME_LIMIT) or 10080;
		if nItemType > 0 and  nGenre ~= 0 and nDetail ~=0 and nParticular ~= 0 then
			local tbTemp = {
				tbItem = {nGenre,nDetail,nParticular,nLevel},
				nLimit = nTimeLimit}
			table.insert(self.tbTxt[szGateWay][szAccount], tbTemp);
		end
	end
	return self.tbTxt;
end

function Compensate:GetItemType2Item(nNum)
	local nGenre, nDetail, nParticular = 0,0,0;
	nParticular = math.mod(nNum, 2^12);
	nDetail = math.floor((math.mod(nNum, 2^24) / 2^12));
	nGenre = math.floor(nNum / (2^24) );
	return nGenre, nDetail, nParticular;
end

function Compensate:GetExtPointByte()
	local nExtTemp = me.GetExtPoint(self.EXT_POINT);
	if nExtTemp > 0 and math.floor(nExtTemp / 2^8) ~= self.EXT_BATCH then
		me.PayExtPoint(self.EXT_POINT, nExtTemp);
		nExtTemp = 0
	end
	return math.mod(nExtTemp, 2^8 * self.EXT_BATCH);
end

function Compensate:AddExtPointByte(nPoint)
	local nExtTemp = me.GetExtPoint(self.EXT_POINT);
	if nExtTemp >= 0 and math.floor(nExtTemp / 2^8) ~= self.EXT_BATCH then
		if nExtTemp > 0 then
			me.PayExtPoint(self.EXT_POINT, nExtTemp);
		end
		me.AddExtPoint(self.EXT_POINT, 2^8 * self.EXT_BATCH);
	end
	me.AddExtPoint(self.EXT_POINT, nPoint);
end

Compensate:LoadFile()