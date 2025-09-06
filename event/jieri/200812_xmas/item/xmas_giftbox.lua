-------------------------------------------------------------------
--File: 	giftbox.lua
--Author: 	furuilei
--Date: 	2008-12-16 10:26:42
--Describe:	ʥ��Ԫ����ף���
--InterFace1: 
-------------------------------------------------------------------
if  MODULE_GC_SERVER then
	return;
end
local tbClass = Item:GetClass("xmas_giftbox");

tbClass.TSK_GROUP = 2027;
tbClass.TSK_ID = 95;
tbClass.DEF_MAX = 10;
tbClass.DEF_DIS = 50;
tbClass.DEF_ITEM = {18, 1, 270, 1};
tbClass.AWARD_FILE = "\\setting\\event\\jieri\\200812_xmas\\giftbox.txt";

function tbClass:InitGenInfo()
	-- �趨��Ч����
	local nSec = GetTime() + 30 * 24 * 3600;
	it.SetTimeOut(0, nSec);
	return	{ };
end

function tbClass:GetTip()
	local szTip = "";
	local szGiveName = it.szCustomString;
	local nType 	 = it.nCustomType;
	local nUse = me.GetTask(self.TSK_GROUP, self.TSK_ID);
	if nType == 2 and szGiveName ~= "" then
		szTip = szTip .. string.format("<color=yellow>%s����<color>\n\n",szGiveName);
	end
	
	szTip = szTip .. string.format("<color=green>��ʹ��%s������Ʒ<color>", nUse);
	return szTip;
end

-- ʹ�����
function tbClass:OnUse()
	local szMsg = "ʥ����У�ֻ�����͸����ܶ�2�����ϵĺ��ѡ�";
	Dialog:Say(szMsg,
		{
			{"ʹ�ø����", self.SureUse, self, it.dwId},
			{"ת�͸�����", self.ShowOnlineMember, self, it.dwId},
			{"�Ժ���˵"},
		});
end

function tbClass:SureUse(nItemId)
	-- 1. ��ȡGenInfo(1)�������0�����Ǳ������͵ģ�����ʹ��
	-- 2. ��ȡ�����������������Ƿ�10�Σ������ˣ��Ͳ���ʹ����
	-- 3. ���ͨ������������������ʹ��
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	local szGiveName = pItem.szCustomString;
	local nType 	 = pItem.nCustomType
	if (szGiveName == "") then
		Dialog:Say("����Ʒ�����Լ�ʹ�ã���������͸���ĺ��ѡ�");
		return 0;
	end
	if (me.GetTask(self.TSK_GROUP, self.TSK_ID) >= self.DEF_MAX) then
		Dialog:Say("���Ѿ�ʹ����10��ʥ����У�������ʹ���ˣ���������԰�������͸���ĺ��ѡ�");
		return 0;
	end
	if self:CheckItemFree(me, 1) == 0 then
		return 0;
	end
	if me.DelItem(pItem, Player.emKLOSEITEM_TYPE_EVENTUSED) ~= 1 then
		return 0;
	end
	me.SetTask(self.TSK_GROUP, self.TSK_ID, me.GetTask(self.TSK_GROUP, self.TSK_ID) + 1);
	local nMaxProbability = self.tbItemList.nMaxProp;
	local nRate = MathRandom(1, nMaxProbability);
	local nRateSum = 0;
	for _, tbItem in pairs(self.tbItemList.tbRandom) do
		nRateSum = nRateSum + tbItem.nProbability;
		if nRate <= nRateSum then
			self:GetItem(me, tbItem, szGiveName)
			return 1;
		end
	end	
end

function tbClass:GetItem(pPlayer, tbitem, szGiveName)
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
		local szMsg = string.format("%s��%s���͵�%s���%s,���Ǻ��˰���", pPlayer.szName, szGiveName, tbitem.szDesc, tbitem.szName);
		KDialog.NewsMsg(1, Env.NEWSMSG_NORMAL, szMsg);
	end
	
	if tbitem.nFriendMsg == 1 then
		pPlayer.SendMsgToFriend("���ĺ���[<color=yellow>"..pPlayer.szName.."<color>]��"..szGiveName.."���͵�"..tbitem.szDesc..
			"�����<color=yellow>"..tbitem.szName.."<color>��");
	end

	return 1;
end

function tbClass:CheckItemFree(pPlayer, nCount)
	if pPlayer.CountFreeBagCell() < nCount then
		local szAnnouce = "���ı����ռ䲻�㣬������"..nCount.."��ռ����ԡ�";
		pPlayer.Msg(szAnnouce);
		return 0;
	end
	return 1;
end

function tbClass:ShowOnlineMember(nItemId)
	
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end

	local szGiveName = pItem.szCustomString;
	local nType 	 = pItem.nCustomType
	if (nType == 2 and me.GetTask(self.TSK_GROUP, self.TSK_ID) < self.DEF_MAX) then
		
		Dialog:Say("��������Ǳ������͵ģ�����ʹ����10��ʥ����У����ܰ����ת�͸���ĺ��ѡ�");
		return 0;
	end
	
	local tbPlayerId = me.GetTeamMemberList();
	if tbPlayerId == nil then
		me.Msg("��û���ڶ���ĵ��У���������ʥ����С�");
		return 0;
	end
	local tbOnlineMember = {};
	local nMapId, nX, nY	= me.GetWorldPos();
	for _, pPlayer in pairs(tbPlayerId) do
		if pPlayer.nId ~= me.nId then
			local nPlayerMapId, nPlayerX, nPlayerY	= pPlayer.GetWorldPos();
			if (nPlayerMapId == nMapId) then
				local nDisSquare = (nX - nPlayerX)^2 + (nY - nPlayerY)^2;
				if (nDisSquare < ((self.DEF_DIS/2) * (self.DEF_DIS/2))) then
					tbOnlineMember[#tbOnlineMember + 1]= {string.format("%s", pPlayer.szName), self.SelectMember, self, pPlayer.nId, me.nId, nItemId};
				end
			end
		end
	end	
	if (#tbOnlineMember <= 0) then
		Dialog:Say("����û�ж��ѣ���������ʥ����С�");
		return 0;
	end
	tbOnlineMember[#tbOnlineMember + 1] = {"ȡ��"};
	Dialog:Say("��Ҫ��ʥ��������͸���λ���ѣ�", tbOnlineMember);
end

function tbClass:SelectMember(nMemberPlayerId, nPlayerId, nItemId)
	local pItem = KItem.GetObjById(nItemId);
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	local pPlayer1 = KPlayer.GetPlayerObjById(nMemberPlayerId);
	if not pItem or not pPlayer or not pPlayer1 then
		return 0;
	end
	
	local nMapId, nX, nY	= pPlayer.GetWorldPos();
	local nPlayerMapId, nPlayerX, nPlayerY	= pPlayer1.GetWorldPos();
	if nPlayerMapId ~= nMapId then
		Dialog:Say("���Ѳ��ڸ�������������ʥ����С�");
		return 0;
	end
	
	local nDisSquare = (nX - nPlayerX)^2 + (nY - nPlayerY)^2;
	if (nDisSquare > ((self.DEF_DIS/2) * (self.DEF_DIS/2))) then
		Dialog:Say("���Ѳ��ڸ�������������ʥ����С�");
		return 0;
	end
	
	if (1 ~= pPlayer.IsFriendRelation(pPlayer1.szName)) then
		Dialog:Say("�ö����������Ǻ��ѹ�ϵ����������ʥ����С�");
		return 0;
	end
	
	if pPlayer.GetFriendFavorLevel(pPlayer1.szName) < 2 then
		Dialog:Say("�ú������������ܶȵȼ�����2������������ʥ����и�����");
		return 0;
	end

	if pPlayer1.CountFreeBagCell() < 1 then
		me.Msg("�Է�û���㹻�Ŀռ䡣");
		return 0;
	end
	
	if me.DelItem(pItem, Player.emKLOSEITEM_TYPE_EVENTUSED) ~= 1 then
		me.Msg("����ʧ�ܡ�");
		return 0;
	end
	
	local pItem = pPlayer1.AddItem(unpack(self.DEF_ITEM));
	if pItem then
		pItem.SetCustom(Item.CUSTOM_TYPE_MAKER, pPlayer.szName);
		pItem.Sync();
	end
	pPlayer.Msg(string.format("��ɹ�����ʥ����и�<color=yellow>%s<color>��", pPlayer1.szName));
	pPlayer1.Msg(string.format("����ܵ���<color=yellow>%s<color>���͵�ʥ����С�", pPlayer.szName));
end

function tbClass:LoadItemList()
	self.tbItemList = self:LoadList(self.AWARD_FILE);
end

function tbClass:LoadList(szFile)
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
	
tbClass:LoadItemList();

end

