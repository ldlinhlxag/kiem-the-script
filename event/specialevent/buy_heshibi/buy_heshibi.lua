-- �ļ�������buy_heshibi.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-07-17 15:00:48
-- ��  ��  ��

SpecialEvent.BuyHeShiBi = SpecialEvent.BuyHeShiBi or {};
local tbBuyItem = SpecialEvent.BuyHeShiBi;
tbBuyItem.TSK_GROUP 	=2027;
tbBuyItem.TSK_ID 		=70;		--���Թ�����ϱ�����
tbBuyItem.TSK_DATE 		=91;		--���Ӻ��ϱڴ���ʱ��
tbBuyItem.DEF_COIN 		=8000;	--��Ҫ�����
tbBuyItem.DEF_CWAREID 	=380;	--������Id
tbBuyItem.DEF_CLSDATE 	=20;	--�����ۼӼ��20�����

function tbBuyItem:Check()
	self:CheckCls();

	if me.GetTask(self.TSK_GROUP, self.TSK_ID) <= 0 then
		Dialog:Say("���ϱ��������ޣ���û�й�����ϱڵ��ʸ�");
		return 0;
	end
	
	if IVER_g_nSdoVersion == 0 and me.GetJbCoin() < self.DEF_COIN then
		Dialog:Say(string.format("���Ľ�Ҳ��㣬����1��<color=yellow>���ꡤ�����<color>��Ҫ%s��ҡ�", self.DEF_COIN));
		return 0;
	end
	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say(string.format("���ı����ռ䲻�㣬��Ҫ1�񱳰��ռ䡣"));
		return 0;	
	end
	return 1;
end

function tbBuyItem:BuyOnDialog(nSure)
	if self:Check() ~= 1 then
		return 0;
	end
	if not nSure then
		local nSum = me.GetTask(self.TSK_GROUP, self.TSK_ID);
		local szMsg = string.format("�㻹���Թ���<color=yellow>%s�����ꡤ�����<color>������һ��<color=yellow>���ꡤ�����<color>��Ҫ<color=yellow>%s<color>%s����ȷ��Ҫ������", nSum, self.DEF_COIN, IVER_g_szCoinName);
		local tbOpt = {
			{"ȷ�����ڹ���",self.BuyOnDialog, self, 1},
			{"���ٿ��ǿ���"},
		};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	me.ApplyAutoBuyAndUse(self.DEF_CWAREID, 1);
	if IVER_g_nSdoVersion == 0 then
		Dialog:Say(string.format("���ɹ�������1��<color=yellow>���ꡤ�����<color>"));
	end
	return 1;
end

function tbBuyItem:AddCount(nCount)
	self:CheckCls();
	local nSum = me.GetTask(self.TSK_GROUP, self.TSK_ID);
	me.SetTask(self.TSK_GROUP, self.TSK_ID, nSum + nCount);
	return 1;
end

function tbBuyItem:CheckCls()
	local nCurSec = GetTime()
	local nSaveSec = me.GetTask(self.TSK_GROUP, self.TSK_DATE);
	if (nSaveSec + self.DEF_CLSDATE * 24*3600) < nCurSec then
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "���ꡤ����赹��������0");
		me.SetTask(self.TSK_GROUP, self.TSK_ID, 0);
		me.SetTask(self.TSK_GROUP, self.TSK_DATE, nCurSec);
	end	
end

function tbBuyItem:Consume()
	local nSum = me.GetTask(self.TSK_GROUP, self.TSK_ID);
	if nSum <= 0 then
		return 0;
	end
	me.SetTask(self.TSK_GROUP, self.TSK_ID, nSum - 1);
	return 1;
end

local tbCoinItem = Item:GetClass("coin_qinling_arm_item");
	
function tbCoinItem:OnUse()
	if me.CountFreeBagCell() < 1 then
		me.Msg(string.format("���ı����ռ䲻�㣬��Ҫ1�񱳰��ռ䡣"));
		return 0;
	end	
	local tbItemInfo = {bTimeOut=1, bForceBind=1, bMsg = 0};
	local pItem = me.AddItemEx(18, 1, 377, 1, tbItemInfo);
	--������
	if pItem then
		SpecialEvent.BuyHeShiBi:Consume();
		pItem.Bind(1);
		local szDate = os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 3600*24*30);
		me.SetItemTimeout(pItem, szDate);
		local szLog = string.format("�Զ�ʹ�û����1�����ꡤ�����");
		Dbg:WriteLog("Player.tbBuyJingHuo", "�Żݹ��򾫻�", me.szAccount, me.szName, szLog);
	end
	return 1;
end

	