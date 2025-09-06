-------------------------------------------------------
-- �ļ�������qiandaizi.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-03-20 17:21:44
-- �ļ�����������ת�������--����Ǯ����
-------------------------------------------------------

Require("\\script\\event\\manager\\define.lua");

-- �����ʾ���֣�"\\setting\\item\\001\\other\scriptitem.txt"
local tbQianDaiziItem = Item:GetClass("qiandaizi");

-- ���影������
tbQianDaiziItem.AWARD_COIN_G	= 1;	-- �󶨽��
tbQianDaiziItem.AWARD_MONEY_G	= 2;	-- ������
tbQianDaiziItem.AWARD_MONEY_S	= 3;	-- ��������

function tbQianDaiziItem:OnUse()
	
	-- �������ˣ���ɵ�Ǯ�������
	if me.GetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_COIN_G) <= 0
	and me.GetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_MONEY_G) <= 0
	and me.GetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_MONEY_S) <= 0 then
		me.Msg("���Ǯ����ʹ������Ѿ���ʧ��");
		return 1;
	end
	
	-- ����ѡ�
	-- 1. ��ȡ�󶨽�ң�2. ��ȡ��������3. ��ȡ������4. ���ֲ�������
	-- *�������ID��it.dwId�����ݸ����������������self
	local tbOpt = {
		{"��ȡ�󶨽��", self.OnUseTakeOut, self, self.AWARD_COIN_G, it.dwId},
		{"��ȡ������", self.OnUseTakeOut, self, self.AWARD_MONEY_G, it.dwId},
		{"��ȡ����", self.OnUseTakeOut, self, self.AWARD_MONEY_S, it.dwId},
		{"���ֲ�������"},
	}
	
	-- ���������������
	local szMsg = string.format("Ǯ���ǲ����á���������Ǯ���ӣ�Ŀǰ����ЩǮ��\n\n" 
		.."<color=yellow>\t�󶨽�ң�\t%d\n<color>" 
		.."<color=yellow>\t��������\t%d\n<color>" 
		.."<color=yellow>\t������\t%d\n<color>",
		me.GetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_COIN_G),
		me.GetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_MONEY_G),
		me.GetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_MONEY_S)
		);
		
	Dialog:Say(szMsg, tbOpt);
	
	-- ���Զ�ɾ��
	return 0;
end

-- ȡ��������������ѡ��
function tbQianDaiziItem:OnUseTakeOut(nType, nItemId)
	
	-- ���ֶԻ����������
	local nMaxTakeOutCount = 0;
	local szMsg = "���Ǯ�������Ѿ�û��";
	
	-- �ж�ȡ���������ͣ��ֱ�����
	if nType == self.AWARD_COIN_G then
		nMaxTakeOutCount = me.GetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_COIN_G);
		szMsg = string.format(szMsg.."�󶨽�ҡ�");
		
	elseif nType == self.AWARD_MONEY_G then
		nMaxTakeOutCount = me.GetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_MONEY_G);
		szMsg = string.format(szMsg.."��������");
	
	elseif nType == self.AWARD_MONEY_S then
		nMaxTakeOutCount = me.GetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_MONEY_S);
		szMsg = string.format(szMsg.."������");
		
	else
		return 0;
	end
	
	if nMaxTakeOutCount <= 0 then
		Dialog:Say(szMsg, {"��֪����"});
		return 0;
	end
	
	-- �᲻����ɶ����������أ�
	Dialog:AskNumber("������ȡ����������", nMaxTakeOutCount, self.OnUseTakeOutSure, self, nType, nItemId);
end

-- ���ͽ���
function tbQianDaiziItem:OnUseTakeOutSure(nType, nItemId, nTakeOutCount)
		
	-- ��ǿ���һ��
	if nTakeOutCount <= 0 then
		return 0;
	end
	
	-- ͨ����ƷID�ҵ��������
	local pItem = KItem.GetObjById(nItemId);
	
	-- �Ҳ�������
	if not pItem then
		return 0;
	end
	
	-- �󶨽��
	if nType == self.AWARD_COIN_G then
		
		-- ȡ��ǰ��¼
		local nCount = me.GetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_COIN_G)
	
		-- ��ǿ�ж�
		if nTakeOutCount > nCount then
			return 0;
		end
		
		-- �������
		me.SetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_COIN_G, nCount - nTakeOutCount);	
	
		-- ���Ӱ��
		me.AddBindCoin(nTakeOutCount, Player.emKBINDCOIN_ADD_CHANGELIFE);
		
		Dbg:WriteLog("SpecialEvent.ChangeLive", "����ת����", me.szAccount, me.szName, "��ð󶨽�ң�"..nTakeOutCount);
				
	-- ������
	elseif nType == self.AWARD_MONEY_G then
	
		-- ȡ��ǰ��¼
		local nCount = me.GetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_MONEY_G)
	
		-- ��ǿ�ж�
		if nTakeOutCount > nCount then
			return 0;
		end
		
		-- �ж��Ƿ�ᳬ��������Я������
		if nTakeOutCount + me.GetBindMoney() > me.GetMaxCarryMoney() then
			Dialog:Say(string.format("�Բ�����ȡ�������ϵİ���������ﵽ���ޣ��������������ȡ��")); 	
			return 0;
		end
		
		-- �������
		me.SetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_MONEY_G, nCount - nTakeOutCount);	
	
		-- ���Ӱ���
		me.AddBindMoney(nTakeOutCount, Player.emKBINDMONEY_ADD_CHANGELIVE);
		
		Dbg:WriteLog("SpecialEvent.ChangeLive", "����ת����", me.szAccount, me.szName, "��ð�������"..nTakeOutCount);
			
	-- �ǰ�����
	elseif nType == self.AWARD_MONEY_S then
	
		-- ȡ��ǰ��¼
		local nCount = me.GetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_MONEY_S)

		-- ��ǿ�ж�
		if nTakeOutCount > nCount then
			return 0;
		end
		
		-- �ж��Ƿ����������Я������	
		if nTakeOutCount + me.nCashMoney > me.GetMaxCarryMoney() then
			Dialog:Say(string.format("�Բ�����ȡ�������ϵ���������ﵽ���ޣ��������������ȡ��"));
			return 0;
		end
		
		-- �������
		me.SetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_MONEY_S, nCount - nTakeOutCount);	
	
		-- ��������: �ڶ���������ʽΪ��Player.emXXX��������"\\script\\player\\define.lua"
		me.Earn(nTakeOutCount, Player.emKEARN_CHANGELIVE_MONEY);
		
		Dbg:WriteLog("SpecialEvent.ChangeLive", "����ת����", me.szAccount, me.szName, "���������"..nTakeOutCount);
	end
	
	-- �ù��������ٵ�
	if me.GetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_COIN_G) <= 0
	and me.GetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_MONEY_G) <= 0
	and me.GetTask(SpecialEvent.ChangeLive.TASKGID, SpecialEvent.ChangeLive.TASK_CHANGELIVE_MONEY_S) <= 0 then
		pItem.Delete(me);
		me.Msg("���Ǯ����ʹ������Ѿ���ʧ��");
	end
end