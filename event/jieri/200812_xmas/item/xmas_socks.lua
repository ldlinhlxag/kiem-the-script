--ʥ������
--�����
--2008.12.16
if  MODULE_GC_SERVER then
	return;
end
local tbItem = Item:GetClass("xmas_socks");

tbItem.TSK_GROUP = 2027;
tbItem.TSK_ID = 94;
tbItem.DEF_MAX = 100;
tbItem.DEF_ITEM = {18, 1, 270, 1};
tbItem.AWARD_FILE = "\\setting\\event\\jieri\\200812_xmas\\socks.txt";

function tbItem:GetTip()
	local szTip = "";
	local nUse = me.GetTask(self.TSK_GROUP, self.TSK_ID);
	szTip = szTip .. string.format("<color=green>��ʹ��%s������Ʒ<color>", nUse);
	return szTip;
end

function tbItem:InitGenInfo()
	-- �趨��Ч����
	local nSec = GetTime() + 30 * 24 * 3600;
	it.SetTimeOut(0, nSec);
	return	{ };
end

function tbItem:OnUse()
	if me.GetTask(self.TSK_GROUP, self.TSK_ID) >= self.DEF_MAX then
		me.AddBindMoney(100, Player.emKBINDMONEY_ADD_EVENT);
		me.Msg("����ʹ����100�����ӣ��Ѵ����ޣ�ֻ�ܻ��100��������");
		return 1;
	end
	if self:CheckItemFree(me, 2) == 0 then
		return 0;
	end
	me.SetTask(self.TSK_GROUP, self.TSK_ID, me.GetTask(self.TSK_GROUP, self.TSK_ID) + 1);
	if MathRandom(1, 100) <= 10 then
		local pItem = me.AddItem(unpack(self.DEF_ITEM));
		if pItem then
			pItem.Bind(1);
		end
	end
	local nMaxProbability = self.tbItemList.nMaxProp;
	local nRate = MathRandom(1, nMaxProbability);
	local nRateSum = 0;
	me.AddExp(me.GetBaseAwardExp() * 10);
	for _, tbItem in pairs(self.tbItemList.tbRandom) do
		nRateSum = nRateSum + tbItem.nProbability;
		if nRate <= nRateSum then
			self:GetItem(me, tbItem)
			return 1;
		end
	end	
	return 1;
end

function tbItem:GetItem(pPlayer, tbitem)
	if tbitem.nMoney ~= 0 then
		local nAddMoney = pPlayer.Earn(tbitem.nMoney, Player.emKEARN_RANDOM_ITEM);
		local szAnnouce = string.format("��ϲ�������<color=yellow>%s<color>��", tbitem.nMoney);
		pPlayer.Msg(szAnnouce);
		if nAddMoney == 1 then
			Dbg:WriteLog("��������Ʒ",  pPlayer.szName,  string.format("��������%s����", tbitem.nMoney));
		else
			Dbg:WriteLog("��������Ʒ",  pPlayer.szName,  string.format("�����ﵽ����,��������%s����ʧ��", tbitem.nMoney));
		end
	end
	
	if tbitem.nBindMoney ~= 0 then
		pPlayer.AddBindMoney(tbitem.nBindMoney, Player.emKBINDMONEY_ADD_EVENT);
	end	
	
	if tbitem.nGenre ~= 0 and tbitem.nDetailType ~= 0 and tbitem.nParticularType ~= 0 then
		local pItem = pPlayer.AddItem(tbitem.nGenre, tbitem.nDetailType, tbitem.nParticularType, tbitem.nLevel, tbitem.nSeries, tbitem.nEnhTimes);
		if pItem == nil then
			local szMsg = string.format("��������Ʒʧ�ܣ���ƷID��%s,%s,%s",tbitem.nGenre, tbitem.nDetailType, tbitem.nParticularType);
			Dbg:WriteLog("��������Ʒ",  pPlayer.szName, szMsg);
			return 0;
		else
			if tbitem.nBind ~= 0 then
				pItem.Bind(1);
			end
		end
		pPlayer.SetItemTimeout(pItem, 30*24*60, 0);
		local szAnnouce = string.format("��ϲ�������һ��<color=yellow>%s<color>", pItem.szName);
		pPlayer.Msg(szAnnouce);
		Dbg:WriteLog("��������Ʒ",  pPlayer.szName, string.format("��������Ʒһ��%s", pItem.szName));
	end
	
	if tbitem.nAnnounce == 1 then
		local szMsg = string.format("%s��%s���һ��%s,���Ǻ��˵�ͷѽ��", pPlayer.szName, tbitem.szDesc, tbitem.szName);
		KDialog.NewsMsg(1, Env.NEWSMSG_NORMAL, szMsg);
	end
	
	if tbitem.nFriendMsg == 1 then
		pPlayer.SendMsgToFriend("���ĺ���[<color=yellow>"..pPlayer.szName.."<color>]��"..tbitem.szDesc.."�����<color=yellow>"..tbitem.szName.."<color>��");
	end

	return 1;
end

function tbItem:CheckItemFree(pPlayer, nCount)
	if pPlayer.CountFreeBagCell() < nCount then
		local szAnnouce = "���ı����ռ䲻�㣬������"..nCount.."��ռ����ԡ�";
		pPlayer.Msg(szAnnouce);
		return 0;
	end
	return 1;
end


function tbItem:LoadItemList()
	self.tbItemList = self:LoadList(self.AWARD_FILE);
end

function tbItem:LoadList(szFile)
	local tbsortpos = Lib:LoadTabFile(szFile);
	local nLineCount = #tbsortpos;
	local tbClassItemList = {nMaxProp = 0, tbRandom = {}};
	for nLine=2, nLineCount do
		local nProbability = tonumber(tbsortpos[nLine].Probability) or 0;
		local szName = tbsortpos[nLine].Name;
		local szDesc = tbsortpos[nLine].Desc;
		local nMoney = tonumber(tbsortpos[nLine].Money) or 0;
		local nBindMoney = tonumber(tbsortpos[nLine].BindMoney) or 0;
		local nGenre = tonumber(tbsortpos[nLine].Genre) or 0;
		local nDetailType = tonumber(tbsortpos[nLine].DetailType)or 0;
		local nParticularType = tonumber(tbsortpos[nLine].ParticularType) or 0;
		local nLevel = tonumber(tbsortpos[nLine].Level)or 0;
		local nSeries = tonumber(tbsortpos[nLine].Series) or 0;
		local nEnhTimes = tonumber(tbsortpos[nLine].EnhTimes) or 0;
		local nBind = tonumber(tbsortpos[nLine].Bind) or 0;
		local nAnnounce = tonumber(tbsortpos[nLine].Announce) or 0;
		local nFriendMsg = tonumber(tbsortpos[nLine].FriendMsg) or 0;
		
		local tbRandom = {};
		tbRandom.nProbability = nProbability;
		tbRandom.szName = szName;
		tbRandom.nMoney = nMoney;
		tbRandom.nBindMoney = nBindMoney;
		tbRandom.nGenre = nGenre;
		tbRandom.nDetailType = nDetailType;
		tbRandom.nParticularType = nParticularType;
		tbRandom.nLevel = nLevel;
		tbRandom.nSeries = nSeries;
		tbRandom.nEnhTimes = nEnhTimes;
		tbRandom.nBind = nBind;
		tbRandom.nAnnounce = nAnnounce;
		tbRandom.nFriendMsg = nFriendMsg;
		tbRandom.szDesc = szDesc;
		table.insert(tbClassItemList.tbRandom, tbRandom);
		if nProbability >= 0 then
			tbClassItemList.nMaxProp = tbClassItemList.nMaxProp + nProbability;
		end
	end
	return tbClassItemList;
end

if MODULE_GAMESERVER then
	
tbItem:LoadItemList();

end


