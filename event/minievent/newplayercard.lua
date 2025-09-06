--���ֿ�����,�ڲ�������鷴��
--2008.09.27
--�����

local tbEvent = {};
SpecialEvent.NewPlayerCard = tbEvent;

tbEvent.TASK_GOURP_ID 		= 2027;	--���������
tbEvent.TASK_REGISTER_ID	=	11;	--��¼��ȡ���ֽ�������
tbEvent.TASK_GET_TUIGUANGYUAN_AWARD = 69; --09�°潣�������ƹ�Աϵͳ�콱��־

--���ֿ���ȡ������1����10����20����30����40����50����60����69��
tbEvent.DEF_AWARD_NEWCARD = {
	{nLevel = 1, nTaskId=12, tbItem={{tbItem={18,1,23,1}, nNum=1, nDay=7}}, szSelect = "��ȡ1������"}, 				--���޻سǷ���1�ܣ�,1��
	{nLevel = 10, nTaskId=13, tbItem={{tbItem={18,1,85,1}, nNum=1, nDay=30}}, szSelect = "��ȡ10������"}, 				--Ǭ����1��,10��
	{nLevel = 20, nTaskId=14, tbItem={{tbItem={18,1,71,2}, nNum=20,nDay=30}}, szSelect = "��ȡ20������"}, 				--��׾���20��,20��
	{nLevel = 30, nTaskId=15, tbItem={{tbItem={18,1,113,1}, nNum=1, nDay=30},{tbItem={18,1,2,2}, nNum=1, nDay=30}}, szSelect = "��ȡ30������"}, 	--�������ݣ�10�䣩1������Ϭ��2����1��,30��
	{nLevel = 40, nTaskId=16, tbItem={{tbItem={18,1,1,4}, nNum=20, nDay=30}}, nBindCoin=2000, szSelect = "��ȡ40������"}, 							--4������20����2000�󶨽��,40��
	{nLevel = 50, nTaskId=17, tbItem={{tbItem={18,1,1,5}, nNum=20, nDay=30}}, nBindMoney=100000, szSelect = "��ȡ50������"}, 						--5������20����100000������,50��
	{nLevel = 60, nTaskId=18, tbItem={{tbItem={18,1,1,6}, nNum=10, nDay=30}}, nBindMoney=200000, nPayLimit=15, szSelect = "��ȡ60������"}, 				--6������10����200000������,60��,���³�ֵ48Ԫ
	{nLevel = 69, nTaskId=19, tbItem={{tbItem={18,1,1,7}, nNum=10, nDay=30}}, nBindMoney=300000, nBindCoin=5000, nPayLimit=15, szSelect = "��ȡ69������"}, --7������10����300000��������5000�󶨽��,69��,���³�ֵ48Ԫ
};

--�ƹ�Ա������
tbEvent.DEF_AWARD_TUIGUANGYUAN = {
	{nLevel = 1, nTaskId=12, tbItem={{tbItem={18,1,23,1}, nNum=1, nDay=7}}, szSelect = "��ȡ1������"}, 				--���޻سǷ���1�ܣ�,1��
	{nLevel = 10, nTaskId=13, tbItem={{tbItem={18,1,85,1}, nNum=1, nDay=30}}, szSelect = "��ȡ10������"}, 				--Ǭ����1��,10��
	{nLevel = 30, nTaskId=15, tbItem={{tbItem={18,1,113,1}, nNum=1, nDay=30}, {tbItem={18,1,2,2}, nNum=1, nDay=30}}, szSelect = "��ȡ30������"}, 	--�������ݣ�10�䣩1������Ϭ��2����1��,30��
	{nLevel = 40, nTaskId=16, tbItem={{tbItem={18,1,286,4}, nNum=1, nDay=30}}, nBindCoin=2000, szSelect = "��ȡ40������"}, 							--4������20����2000�󶨽��,40��
	{nLevel = 50, nTaskId=17, tbItem={{tbItem={18,1,286,5}, nNum=1, nDay=30}, {tbItem={18,1,287,2}, nNum=1, nDay=30}}, nBindMoney=100000, szSelect = "��ȡ50������"}, --5������20����100000������,50��, ��׾���20��
	{nLevel = 60, nTaskId=18, tbItem={{tbItem={18,1,286,6}, nNum=1, nDay=30}}, nBindMoney=200000, nPayLimit=48, szSelect = "��ȡ60������"}, 				--6������10����200000������,60��,���³�ֵ48Ԫ
	{nLevel = 69, nTaskId=19, tbItem={{tbItem={18,1,286,7}, nNum=1, nDay=30}}, nBindMoney=300000, nBindCoin=5000, nPayLimit=48, szSelect = "��ȡ69������"}, --7������10����300000��������5000�󶨽��,69��,���³�ֵ48Ԫ
};

--09�°潣�������ƹ�Ա������
tbEvent.DEF_AWARD_TUIGUANGYUAN_09 = {
	{nLevel = nil, nTaskId=12, nBindCoin=1000, szSelect = "��ȡ�״����ѽ���", 
	funCondition = 
		function(pPlayer) 
			if me.GetTask(Spreader.TASK_GROUP, Spreader.TASKID_CONSUME) > 0 then
				return 1;
			else
				return 0, "��ֻҪ�������ʹ�ý�ҹ�����Ʒ��ʹ�ø���Ʒ��֮����ܹ���ȡ�������";
			end
		end,
	 },
	{nLevel = 20, nTaskId=13, nBindCoin=1000, szSelect = "��ȡ20������"},
	{nLevel = 50, nTaskId=14, nBindCoin=2000, szSelect = "��ȡ50������"},
	{nLevel = 70, nTaskId=15, nBindCoin=5000, szSelect = "��ȡ70������"},
};

--��ȡ�������ڲ�����������
tbEvent.DEF_AWARD_FEEDBACK = {
	{nLevel = 69, nTaskId=12, tbItem={{tbItem={18,1,23,1}, nNum=1, nDay=7}}, nPayLimit=48, szSelect = "��ȡ���޻سǷ���1�ܣ�", nPayMax=500, nPrestige=100}, 				--���޻سǷ���1�ܣ�,1��
	{nLevel = 69, nTaskId=13, tbItem={{tbItem={18,1,85,1}, nNum=1, nDay=30}}, nPayLimit=48, szSelect = "��ȡ1��Ǭ����", nPayMax=500, nPrestige=100}, 				--Ǭ����1��,10��
	{nLevel = 69, nTaskId=14, tbItem={{tbItem={18,1,71,2}, nNum=20,nDay=30}}, nPayLimit=48, szSelect = "��ȡ20����׾���", nPayMax=500, nPrestige=100}, 				--��׾���20��,20��
	{nLevel = 69, nTaskId=15, tbItem={{tbItem={18,1,113,1}, nNum=1, nDay=30},{tbItem={18,1,2,2}, nNum=1, nDay=30}}, nPayLimit=48, szSelect = "��ȡ�������ݺͽ�Ϭ", nPayMax=500, nPrestige=100}, 	--�������ݣ�10�䣩1������Ϭ��2����1��,30��
	{nLevel = 69, nTaskId=16, tbItem={{tbItem={18,1,1,4}, nNum=20, nDay=30}}, nBindCoin=2000, nPayLimit=48, szSelect = "��ȡ20��4��������2000�󶨽��", nPayMax=500, nPrestige=100}, 							--4������20����2000�󶨽��,40��
	{nLevel = 69, nTaskId=17, tbItem={{tbItem={18,1,1,5}, nNum=20, nDay=30}}, nBindMoney=100000, nPayLimit=48, szSelect = "��ȡ20��5��������100000������", nPayMax=500, nPrestige=100}, 					--5������20����100000������,50��
	{nLevel = 69, nTaskId=18, tbItem={{tbItem={18,1,1,6}, nNum=10, nDay=30}}, nBindMoney=200000, nPayLimit=48, szSelect = "��ȡ10��6��������200000������", nPayMax=500, nPrestige=100}, 				--6������10����200000������,60��,���³�ֵ48Ԫ
	{nLevel = 69, nTaskId=19, tbItem={{tbItem={18,1,1,7}, nNum=10, nDay=30}}, nBindMoney=300000, nBindCoin=5000, nPayLimit=48, szSelect = "��ȡ10��7��,5000����30�����", nPayMax=500, nPrestige=100}, --7������10����300000��������5000�󶨽��,69��,���³�ֵ48Ԫ
};
tbEvent.DEF_TYPE_NEWCARD	=	1;	--���ֿ����ͣ�1Ϊѡ�����ֿ�������2Ϊѡ����������
tbEvent.DEF_TYPE_FEEDBACK	=	2;	--����������ͣ�1Ϊѡ�����ֿ�������2Ϊѡ����������

tbEvent.DEF_NEWCARD_DATE_END	=	200905312400; --���ֿ�������ȡ����ʱ��
tbEvent.DEF_FEEDBACK_DATE_START	=	200810170000; --�������������ȡ��ʼʱ��
tbEvent.DEF_FEEDBACK_DATE_END	=	200905312400; --�������������ȡ����ʱ��
tbEvent.RESULT_DESC =
{
	[1] = "�ɹ���֤",
	[2] = "��֤ʧ��",
	[3] = "�ʺŲ�����",
	[1009] = "����Ĳ����Ƿ���Ϊ��",
	[1500] = "�˼����벻����",
	[1501] = "�˼������ѱ�����ʹ��",
	[1502] = "�˼������ѹ���",
}

function tbEvent:WriteLog(szLog, nPlayerId)
	if nPlayerId then
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
		if (pPlayer) then
			Dbg:WriteLog("SpecialEvent.NewPlayerCard", "���ֿ�����", pPlayer.szAccount, pPlayer.szName, szLog);
			pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_BINDCOIN, szLog);
			return 1;
		end
	end
	Dbg:WriteLog("SpecialEvent.NewPlayerCard", "���ֿ�����", szLog);
end

function tbEvent:CheckTime(nType)
	local nDate = tonumber(GetLocalDate("%Y%m%d%H%M"))
	if nType == 1 then
		if nDate < self.DEF_NEWCARD_DATE_END then
			return 1;
		end
	end
	if nType == 2 then
		if nDate >= self.DEF_FEEDBACK_DATE_START and nDate < self.DEF_FEEDBACK_DATE_END  then
			return 1;
		end		
	end
	return 0;
end

--���ֿ�������������������������
function tbEvent:OnDialogNewCard(nFlag)
	local nExtPoint = me.GetExtPoint(6);
	--����ý�ɫ�Ѿ����������ֿ�
	if me.GetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID) == self.DEF_TYPE_NEWCARD then
		if math.mod(nExtPoint, 10) == 1 then
			Dialog:Say("���Ѿ���ȡ���ƹ�Ա��������������ȡ���ֿ�����");
			return 1;
		end
		self:OnGetAwardNewCard(1);
		return 0
	end
	
	--����ý�ɫ�Ѿ���ȡ���ڲ⽱��
	if me.GetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID) == self.DEF_TYPE_FEEDBACK then
		Dialog:Say("���Ѿ���ȡ�����������������������ȡ���ֿ�����");
		return 0
	end
	if nExtPoint > 0 then
		Dialog:Say("�����ʺ��Ѿ���֤���ƹ�Ա�򼤻������ֿ���һ���ʺ�ֻ��һ����ɫ��ȡ�ƹ�Ա�����ֿ����������������ɫ��������ȡ���ֿ�������");
		return 0;
	end		
	if nFlag == 1 then
		if me.nLevel > 69 then
			Dialog:Say("���ȼ��Ѿ�������69�����Ѿ��������֣�����ʹ�����ֿ���")
			return 0;
		end
		Dialog:AskString("���������ֿ������룺", 15, self.OnCheckCard, self);
		return 0;
	end
	local szMsg = "��ȷ��Ҫ��ȡ���ֿ�������ֻ�еȼ�������<color=yellow>69��<color>��������Ҳ����ʸ�ʹ�����ֿ����488���������ɹ���֤���ֿ��������ֻ����ȡ���ֿ���������������ȡ�ڲ����������������ȷ��Ҫ��֤���ֿ���������";
	local tbOpt = {
		{"��ȷ��Ҫ��֤������", self.OnDialogNewCard, self, 1},
		{"���ٿ��ǿ���"},
	}
	Dialog:Say(szMsg, tbOpt);
end

function tbEvent:OnCheckCard(szCDKey)
	--��鼤����
	--if not szCDKey or szCDKey == "" or string.len(szCDKey) > 20 or string.len(szCDKey) < 10 then
	--	Dialog:Say("���뼤����ĳ��Ȳ�����Ҫ��");
	--	return 1;
	--end
	if SendPresentKey(szCDKey) == 1 then
		me.AddWaitGetItemNum(1);
		return 1;
	end
	Dialog:Say("����ļ����벻����Ҫ��");
end

--nResult:1����ɹ���2����ʧ�ܣ�3�����ʺŲ����ڣ�1009������Ĳ����Ƿ���Ϊ�գ�1500������Ʒ���кŲ����ڣ�1501��Ʒ�ѱ�ʹ��,1502��Ʒ�ѹ���
function tbEvent:OnCheckCardResult(nResult)	
	if nResult == 1 then
		SpecialEvent.NewPlayerCard:OnGetAwardNewCard(1);
		return 1;
	end
	Dialog:Say(self.RESULT_DESC[nResult] or "�������쳣");
end

function tbEvent:OnGetAwardNewCard(nType)
	local szMsg = "";
	local tbOpt = {};
	local nExtPoint = me.GetExtPoint(6);
	me.SetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID, self.DEF_TYPE_NEWCARD);
	local tbAwardList = self.DEF_AWARD_NEWCARD;
	local tbAbout;
	if nType == 1 then
		szMsg = "��������֤�ɹ���������ȡ������\n��ȡ������Ч����<color=red>2009��5��31��<color>";
		tbAbout = {self.NewCardAbout, self};
		--������չ��
		if math.mod(nExtPoint, 10) ~= 0 and math.mod(nExtPoint, 10) ~= 2 then
			Dialog:Say("��������,����ϵ��Ϸ����Ա��");
			return 0;
		end
		if math.mod(nExtPoint, 10) == 0 then
			me.AddExtPoint(6, 2);
			me.AddExtPoint(6, 10000);
		end
	else
		szMsg = "������ȡ�ƹ�Ա������";
		tbAbout = {self.TuiGuangYuanAbout, self};
		--������չ��
		if math.mod(math.floor(nExtPoint/100),100) == 0 then
			me.AddExtPoint(6, 100);
			me.SetTask(self.TASK_GOURP_ID, self.TASK_GET_TUIGUANGYUAN_AWARD,1);
		elseif me.GetTask(self.TASK_GOURP_ID, self.TASK_GET_TUIGUANGYUAN_AWARD) ~= 1 then
			Dialog:Say("����ƹ�Ա�ʺ��ѹ��ڡ�");
			return;
		end
		
		tbAwardList = self.DEF_AWARD_TUIGUANGYUAN_09;
	end
	
	self:OnGetAwardFeedBack(tbAwardList, tbAbout);
end

function tbEvent:NewCardAbout()
	local szMsg = [[<color=yellow>
1���ɻ����޻سǷ���1�ܣ�
10���ɻ�Ǭ����1�ţ�1�£�
20���ɻ��׾���20����1�£�
30���ɻ������ݣ�10�䣩1����1�£�����Ϭ��2����1����1�£�
40���ɻ�4������20����1�£���2000�󶨽��
50���ɻ�5������20����1�£���100000������
60���ɻ�6������10����1�£���200000������
69���ɻ�7������10����1�£���300000��������5000�󶨽��<color>

<color=yellow>�ȼ�������69����������Ҳ����ʸ�ʹ�����ֿ����488������<color>
60����69��������Ҫ�ʺű����ۼƳ�ֵ����<color=red>15Ԫ<color>�ſ�����ȡ
	]]
	Dialog:Say(szMsg);
end

function tbEvent:TuiGuangYuanAbout()
	local szMsg = [[<color=yellow>
1���ɻ����޻سǷ���1�ܣ�
10���ɻ�Ǭ����1�ţ�1�£�
30���ɻ������ݣ�10�䣩1����1�£�����Ϭ��2����1����1�£�
40���ɻ�4������20����1�£���2000�󶨽��
50���ɻ�5������20����1�£���100000����������׾���20����1�£�
60���ɻ�6������10����1�£���200000������
69���ɻ�7������10����1�£���300000��������5000�󶨽��<color>

60����69��������Ҫ�ʺű����ۼƳ�ֵ����<color=red>48Ԫ<color>�ſ�����ȡ
	]]
	
	szMsg = [[<color=yellow>
�״����ѿɻ�ȡ1000�󶨽��
20���ɻ�ȡ1000�󶨽��
50���ɻ�ȡ2000�󶨽��
70���ɻ�ȡ5000�󶨽��
]]
	Dialog:Say(szMsg);
end

--�������������������������������
function tbEvent:OnDialogFeedBack(nFlag)
	
	--����ý�ɫ�Ѿ����������ֿ�
	if me.GetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID) == self.DEF_TYPE_FEEDBACK then
		self:OnGetAwardFeedBack(self.DEF_AWARD_FEEDBACK, {self.FeedBackAbout, self});
		return 0
	end
	
	--��ɫ�ȼ�δ��80����
	if me.nLevel < 69 then
		Dialog:Say("���ĵȼ�δ��69����������ȡ�ڲ���һ���������")
		return 0
	end
	
	--����ý�ɫ�Ѿ���ȡ���ڲ⽱��
	if me.GetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID) == self.DEF_TYPE_NEWCARD then
		Dialog:Say("���Ѿ���ȡ�����ֿ��������ƹ�Ա��������������ȡ�������������");
		return 0
	end
	
	
	if nFlag == 1 then
		me.SetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID, self.DEF_TYPE_FEEDBACK);
		self:OnGetAwardFeedBack(self.DEF_AWARD_FEEDBACK, {self.FeedBackAbout, self});
		return 0;
	end
	local szMsg = "��ȷ��Ҫ��ȡ�ڲ��������������<color=red>��ȡ��������������󣬽�������ȡ���ֿ�������<color>";
	local tbOpt = {
		{"��ȷ����ȡ(��������ȡ���ֿ�����)", self.OnDialogFeedBack, self, 1},
		{"���ٿ��ǿ���"},
	}
	Dialog:Say(szMsg, tbOpt);
	
end

function tbEvent:OnGetAwardFeedBack(tbData, tbAbout)
	local szMsg = "������ȡ������";
	local tbOpt = {{"�鿴�������ݼ��콱����", unpack(tbAbout)}};
	
	for nId, tbAward in ipairs(tbData) do
		if me.GetTask(self.TASK_GOURP_ID, tbAward.nTaskId) == 0 and 
			((tbAward.nLevel and me.nLevel >= tbAward.nLevel) or  (tbAward.funCondition and tbAward.funCondition(me) == 1))
		then
			table.insert(tbOpt, {tbAward.szSelect, self.GetAward, self, tbData, nId});
		else
			table.insert(tbOpt, {"<color=gray>"..tbAward.szSelect.."<color>", self.GetAward, self, tbData, nId});			
		end
	end
	if #tbOpt <= 0 then
		szMsg = "��û�ﵽ������ȡ����������Ҫ�������ȡ�����н�����";
	end
	table.insert(tbOpt, {"���ٿ��ǿ���"});
	Dialog:Say(szMsg, tbOpt);
end

function tbEvent:FeedBackAbout()
	Dialog:Say(self.HelpNews);
end

function tbEvent:GetAward(tbAward, nId)
	local tbAward = tbAward[nId]
	if me.GetTask(self.TASK_GOURP_ID, tbAward.nTaskId) ~= 0 then
		Dialog:Say("���Ѿ���ȡ�˸������");
		return 0;
	end
	
	local nNeedFree = 0;
	if tbAward.tbItem then
		for _, tbItem in pairs(tbAward.tbItem) do
			nNeedFree = nNeedFree + tbItem.nNum;
		end
	end
	local nCheck = 1;
	if tbAward.nPayMax then
		if me.GetExtMonthPay() >= tbAward.nPayMax then
			nCheck = nil;
		end	
	end
	
	if tbAward.nLevel then
		if me.nLevel < tbAward.nLevel then
			local szMsg =  string.format("����������Ҫ�ȼ��ﵽ%s��������ȡ��", tbAward.nLevel);
			Dialog:Say(szMsg);
			return 0;
		end
	end
	
	if tbAward.funCondition then
		local nRes, szMsg = tbAward.funCondition(me);
		if nRes ~= 1 then
			Dialog:Say(szMsg);
			return 0;
		end
	end
	
	if tbAward.nPrestige and nCheck then
		if me.nPrestige < tbAward.nPrestige then
			local szMsg =  string.format("����������Ҫ���������ﵽ%s�������ȡ", tbAward.nPrestige);
			if tbAward.nPayMax then
				szMsg = szMsg .. "���߱��³�ֵ�ﵽ500Ԫ������ȡ��";
			end
			szMsg = szMsg .."��";
			Dialog:Say(szMsg);
			return 0;			
		end
	end
	if tbAward.nPayLimit and nCheck then
		if me.GetExtMonthPay() < tbAward.nPayLimit then
			Dialog:Say(string.format("���������������ʺű��³�ֵ�ﵽ%sԪ�������ȡ�������µĳ�ֵ���ۼ�%sԪ��", tbAward.nPayLimit, me.GetExtMonthPay()))
			return 0;
		end
	end
	local nNeedBindMoney = tbAward.nBindMoney or 0;
	if nNeedBindMoney + me.GetBindMoney() > me.GetMaxCarryMoney() then
		Dialog:Say(string.format("�Բ�����ȡ�������ϵİ���������ﵽ���ޣ��������������ȡ��"));
		return 0;		
	end
	if me.CountFreeBagCell() < nNeedFree then
		Dialog:Say(string.format("�Բ������ı����ռ䲻����������һ�±���������ȡ������Ҫ%s�񱳰��ռ䡣", nNeedFree));
		return 0;
	end
	me.SetTask(self.TASK_GOURP_ID, tbAward.nTaskId, 1)
	if tbAward.tbItem then
		for _, tbItem in pairs(tbAward.tbItem) do
			for i=1, tbItem.nNum do
				local pItem = me.AddItem(unpack(tbItem.tbItem));
				if pItem then
					pItem.Bind(1);
					me.SetItemTimeout(pItem, os.date("%Y/%m/%d/00/00/00", GetTime() + tbItem.nDay * 24 * 3600));
				end
			end
		end
	end
	
	if tbAward.nBindMoney then
		me.AddBindMoney(tbAward.nBindMoney, Player.emKBINDMONEY_ADD_EVENT);
	end
	
	if tbAward.nBindCoin then
		me.AddBindCoin(tbAward.nBindCoin, Player.emKBINDCOIN_ADD_EVENT);
	end
	Dialog:Say("���ɹ���ȡ�˽�����");
	self:WriteLog(string.format("��ȡ�˵�%s���:%s", nId, tbAward.szSelect), me.nId);
end

tbEvent.HelpNews = [[
  Ϊ��л�����Ҷ����ǵ�֧�֣�Ӧ�����ҵ�����Ҫ�����ǽ��ӳ����ڲ������������������������ҿ��ţ�ͬ���ģ�ֻҪ��������������֮һ��<color=green>
  ����һ���ȼ��ﵽ69�������������ﵽ100�������ۼƳ�ֵ�ﵽ48Ԫ��
  ���������ȼ��ﵽ69���������ۼƳ�ֵ�ﵽ500Ԫ��<color>

�Ϳ�����ȡ�����ֵ���ƵĻƽ�������������ݰ�����<color=yellow>
  ���޻سǷ���1�ܣ��󶨣�
  Ǭ����1�ţ�1�£��󶨣�
  ��׾���20����1�£��󶨣�
  �������ݣ�10�䣩1����1�£��󶨣�
  ��Ϭ��2����1����1�£��󶨣�
  4������20����1�£��󶨣�
  5������20����1�£��󶨣�
  6������10����1�£��󶨣�
  7������10����1�£��󶨣�
  2000�󶨽��
  100000������
  200000������
  300000������
  5000�󶨽��
<color>
��ȡ����ʱ�䣺
  <color=red>2009��5��31��24ʱ<color>
  
ע�⣺�ڲ����������������ֿ�����ֻ����һ��ȡ
  <color=red>���뵱�³�ֵ������ȡ����<color>

��ܰ��ʾ�������ǵ��³ɹ���ֵ��15Ԫ��ֵ��������30Ԫ��ֵ��������48Ԫ��ֵ��������50Ԫ��ֵ��������100Ԫ��ֵ��������500Ԫ��ֵ����������һ��ʵ�����鿨�����п�����Ч��  
]]


--if (not MODULE_GC_SERVER) then
--	return 0;
--end

--function tbEvent:SetNews()
--	local nData = tonumber(GetLocalDate("%Y%m%d%H%M"));
--	if nData < self.DEF_FEEDBACK_DATE_END then
--		local nEndTime	= Lib:GetDate2Time(math.floor(self.DEF_FEEDBACK_DATE_END));
--		Task.tbHelp:SetCollectCardNews(0, nEndTime, "���������Ҵ����", self.HelpNews, 6);	
--	end
--end

--GCEvent:RegisterGCServerStartFunc(SpecialEvent.NewPlayerCard.SetNews, SpecialEvent.NewPlayerCard);
