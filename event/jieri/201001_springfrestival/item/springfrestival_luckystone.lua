-- �ļ�������springfrestival_luckystone.lua
-- �����ߡ���zounan
-- ����ʱ�䣺2010-01-22 14:32:49
-- ��  ��  ��

local tbItem 	= Item:GetClass("luckystone");
tbItem.nDate  	= 20120702;

tbItem.nLotteryBegin = 20120702;
tbItem.nLotteryEnd	 = 20121202;
tbItem.tbBox  		 = {18,1,909,1};

function tbItem:InitGenInfo()
	-- �趨��Ч����
	local nSec = Lib:GetDate2Time(self.nDate);
	it.SetTimeOut(0, nSec);
	return	{ };
end

function tbItem:OnUse()
	Dialog:Say("��ű�ʯ����ȥ������ʣ���˵�ܲμ�2��24�յ�3��2�յĴ�齱�����������������Ҳ����ѡ�񱣴浽�ղغ����С�",
			{"�ղص���ʯ����", self.Store, self, it.dwId},
			{"�μӽ���ĳ齱�", self.Lottery, self, it.dwId},
			{"��������"}
			);
end

function tbItem:Store(nId)
	local pItem = KItem.GetObjById(nId);
	if not pItem then
		return;
	end
	
	local tbResult = me.FindItemInAllPosition(unpack(self.tbBox));
	local nRes,szMsg = Item:GetClass("box_luckystone"):AddIntoBox(me,pItem);
	if nRes == 0 then
		Dialog:Say(szMsg);
		return;
	end

	if #tbResult == 0 then
		local pBox = me.AddItem(unpack(self.tbBox));
		if pBox then
			pBox.Bind(1);	
			--Item:GetClass("luckystone_box"):AddIntoBox(me,pItem,pBox);
		end
	end		
	
end

function tbItem:Lottery(nId)
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));	
	if nCurDate < self.nLotteryBegin then
		Dialog:Say("�齱���δ��ʼ�أ���˵2��24��0��ŻῪʼ��3��2��24���ͽ����ˣ�ÿ��22�㿪������ע��ʱ��μӻ��");
		return;
	end
	local pItem = KItem.GetObjById(nId);
	if pItem then
		pItem.Delete(me);
		Lottery:UseTicket(me.szName, me.nId);
		me.Msg("��ϲ���μ������˱�ʯ��齱�");
		Dialog:SendBlackBoardMsg(me, "��ϲ���μ������˱�ʯ��齱�");
	end
end


