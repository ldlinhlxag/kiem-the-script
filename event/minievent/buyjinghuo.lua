--�Żݹ��򾫻�
--�����
--2008.09.22

Require("\\script\\player\\jinghuofuli.lua");

local tbBuyJingHuo = {};
SpecialEvent.BuyJingHuo = tbBuyJingHuo;
function tbBuyJingHuo:OnDialog()
	local nFlag, szMsg = Player.tbBuyJingHuo:OpenBuJingHuo(me);
	if (0 == nFlag) then
		Dialog:Say(szMsg);
	end
end

--�ű�������ҩ������Ʒ
local tbItem = Item:GetClass("jingqisan_coin")
function tbItem:OnUse()
	if me.CountFreeBagCell() < 5 then
		me.Msg(string.format("���ı����ռ䲻�㣬��Ҫ5�񱳰��ռ䡣"));
		Dbg:WriteLog("Player.tbBuyJingHuo", "�Żݹ��򾫻�", me.szAccount, me.szName, "�����ռ䲻�㣬�޷���þ���ɢ��");		
		return 0;
	end
	local tbItemInfo = {bTimeOut=1};
	for i=1, 5 do
		local pItem = me.AddItemEx(18, 1, 89, 1, tbItemInfo)
		--������
		if pItem then
			pItem.Bind(1);
			local szDate = os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 3600*24*30);
			me.SetItemTimeout(pItem, szDate);
			local szLog = string.format("�Զ�ʹ�û����1������ɢ");
			Dbg:WriteLog("Player.tbBuyJingHuo", "�Żݹ��򾫻�", me.szAccount, me.szName, szLog);		
		end
	end
	me.SetTask(Player.tbBuyJingHuo.tbItem[1].TASK_GROUPID, Player.tbBuyJingHuo.tbItem[1].TASK_ID2, 5);
	KStatLog.ModifyAdd("mixstat", "[ͳ��]����������ɢ����", "����", 1);
	return 1
end

--�ű��������ҩ������Ʒ
local tbItem = Item:GetClass("huoqisan_coin")
function tbItem:OnUse()
	if me.CountFreeBagCell() < 5 then
		me.Msg(string.format("���ı����ռ䲻�㣬��Ҫ5�񱳰��ռ䡣"));
		Dbg:WriteLog("Player.tbBuyJingHuo", "�Żݹ��򾫻�", me.szAccount, me.szName, "�����ռ䲻�㣬�޷���û���ɢ��");		
		return 0;
	end	
	
	local tbItemInfo = {bTimeOut=1};
	--������
	for i=1, 5 do
		local pItem = me.AddItemEx(18, 1, 90, 1, tbItemInfo)
		if pItem then
			pItem.Bind(1);
			local szDate = os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 3600*24*30);
			me.SetItemTimeout(pItem, szDate);
			local szLog = string.format("�Զ�ʹ�û����1������ɢ");
			Dbg:WriteLog("Player.tbBuyJingHuo", "�Żݹ��򾫻�", me.szAccount, me.szName, szLog);
		end
	end
	me.SetTask(Player.tbBuyJingHuo.tbItem[2].TASK_GROUPID, Player.tbBuyJingHuo.tbItem[2].TASK_ID2, 5);	
	KStatLog.ModifyAdd("mixstat", "[ͳ��]����������ɢ����", "����", 1);
	return 1
end
