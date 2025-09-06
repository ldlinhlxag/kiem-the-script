-- �ļ�������tong_vote_gs.lua
-- �����ߡ���zounan
-- ����ʱ�䣺2010-03-30 17:44:50
-- ��  ��  ��

Require("\\script\\event\\specialevent\\tong_vote\\tong_vote_def.lua");
SpecialEvent.Tong_Vote = SpecialEvent.Tong_Vote or {};
local tbTong = SpecialEvent.Tong_Vote;

function tbTong:IsOpen()
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	if nDate < self.TIME_START or nDate > self.TIME_END then
		return 0;
	end
	return 1;
end

function tbTong:GetGblBuf()
	return self.tbGblBuf or {};
end


function tbTong:OnRecConnectMsg(szName, tbInfo)
	if not self.tbGblBuf then
		self.tbGblBuf = {};
	end
--	if not self.tbGblBuf[szName] then
	self.tbGblBuf[szName] = tbInfo;
--	end
end


function tbTong:VoteTickets(szName)

--	if KGblTask.SCGetDbTaskInt(DBTASK_Tong_Vote_MAX) >= 100000 then
--		Dialog:Say("����������������̫����,�Ѵ�����,�����Ϸ����Ա��ϵ.");
--		return 0;
--	end
	if self:IsOpen("") ~= 1 then
		Dialog:Say("ͶƱ�Ѿ�������");
		return 0;
	end
	
	if not KTong.FindTong(szName)  then
		Dialog:Say("����û�������ᰡ");
		return 0;
	end

	local nCount = tonumber(me.GetItemCountInBags(unpack(tbTong.ITEM_VOTE))) or 0;
	if nCount == 0 then
		Dialog:Say("û��ѡƱ�����ܽ���ͶƱ��");
		return 0;
	end
	
	local szInput = "����Ʊ��";	
	Dialog:AskNumber(szInput, nCount, self.VoteTickets2, self, szName);
end

function tbTong:VoteTickets2(szName, nTickets)
	if nTickets <= 0 then
		return 0;
	end

	
	local nCount = me.GetItemCountInBags(unpack(tbTong.ITEM_VOTE));
	if nCount < nTickets then
		Dialog:Say("������û����ô��ѡƱ��");
		return 0;
	end
	local nFreeCount = KItem.GetNeedFreeBag(self.ITEM_AWARD[1], self.ITEM_AWARD[2], self.ITEM_AWARD[3], self.ITEM_AWARD[4], {bForceBind=1}, nTickets)
	if me.CountFreeBagCell() < nFreeCount then
		Dialog:Say(string.format("��Ҫ%s�񱳰��ռ䣬���ܽ���ͶƱ��",nFreeCount));
		return 0;
	end	
	
	--�۳�ѡƱ
	local bRet = me.ConsumeItemInBags(nTickets, unpack(tbTong.ITEM_VOTE));

	if bRet ~= 0 then
		me.Msg("�۳�ѡƱʧ�ܣ�ͶƱʧ��");
		return 0;
	end
	
	local nVoteCount = me.GetTask(self.TSK_GROUP, self.TSK_VOTE_COUNT);
	me.SetTask(self.TSK_GROUP, self.TSK_VOTE_COUNT, nVoteCount + nTickets);
	
	if nVoteCount < self.AWARD_LIMIT then
		local nAddMoneyCount =  math.min(nTickets, self.AWARD_LIMIT - nVoteCount);
		me.AddBindMoney(self.MOENY_AWARD * nAddMoneyCount);
	end 
	local nAddCount = me.AddStackItem(self.ITEM_AWARD[1],self.ITEM_AWARD[2],self.ITEM_AWARD[3],self.ITEM_AWARD[4], {bForceBind=1}, nTickets);
	
	GCExcute({"SpecialEvent.Tong_Vote:BufVoteTicket", szName, nTickets, me.szName});
	Dialog:Say(string.format("��ɹ���%sͶ��%sƱ��", szName, nTickets));
end
