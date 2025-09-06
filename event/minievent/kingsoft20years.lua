-- �ļ�������kingsoft20years.lua
-- �����ߡ�������
-- ����ʱ�䣺2008-11-10 15:24:55

local tbTwentyAnvsy = {};
SpecialEvent.tbTwentyAnniversary = tbTwentyAnvsy;

tbTwentyAnvsy.TASKGROUP 					= 2027;		--������ID
tbTwentyAnvsy.EACH_HOUR_ID					= 20;		--ÿ����ȡ����ʱ���ID
tbTwentyAnvsy.TIME_COUNT_ID					= 21;		--��ȡ����ʱ��Ĵ�����ID
tbTwentyAnvsy.MAX_COUNT						= 3;		--�����ȡ����
tbTwentyAnvsy.TIME_LIMIT					= 12;		--��ȡʱ��������ʣ��ʱ����������ֵ,������ʱ����������ȡ
tbTwentyAnvsy.EACH_TIME_LENGTH				= 2;		--ÿ�ο�����ȡ��ʱ��:2Сʱ
tbTwentyAnvsy.SPECIALMONSTERMAPPROB_TASKID 	= 22;		--���������ֵ�ͼ�ĵ��ߵ��������
tbTwentyAnvsy.TSK_GREED				 		= 23;		--ף����־

tbTwentyAnvsy.tbEventTime = {
		20081118,	--��ʼʱ��
		20081125,	--����ʱ��
		20081128,	--��ҷ��ؽ���ʱ��
	};

function tbTwentyAnvsy:CheckTime()
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	if (nDate >= self.tbEventTime[1] and nDate < self.tbEventTime[2]) then
		return 1;
	end;
	return 0;
end;

function tbTwentyAnvsy:TwentyYearsOnDialog()	--���ִ��ƹ�Ա���������Ի�
	local szMsg = "���ͬ���֣����춼��ϲ��<color=yellow>1988�꣬��ɽ�����ˣ�һ���ۣ�20���ȥ�ˡ�<color>Ϊ�˴�л����û������ǵ�֧�֣����Ǿ���׼���������ף�������صĵ�ͼ������������ȡ��";
	local tbOpt = {
		{"��ȡǿ�����ý��͵�ף��", self.OnTwentyYearsBlessDialog, self},
		{"��ȡ�ؾ���ͼ", self.GiveSpecialMonsterMapProb, self},
		{"��ֻ�����ո����ֵġ�"},
	};
	Dialog:Say(szMsg, tbOpt);
	return 0;
end;

function tbTwentyAnvsy:OnTwentyYearsBlessDialog()
	local szMsg = "  ��λ�������̸���һ�������ף���������ʹ��ף��������ǿ��װ��ʱ��<color=yellow>����20��<color>�ķ��á�\n  ͬʱ��ǰ��������ң�ֻ�н��������ﵽ<color=yellow>50��<color>���߱��³�ֵ�ۼƴﵽ<color=yellow>15Ԫ<color>����ʿ��ף�������Ч������������������\n\n  <color=red>ǿ�����ý���20��Ч������5��ʱ��<color>";
	local tbOpt = {
		{"����Ȼ���Ҿ���������", self.GetTwentyYearsBless, self},
		{"��ֻ�����ո����ֵġ�"},
	};
	Dialog:Say(szMsg, tbOpt);
	return 0;
end;

function tbTwentyAnvsy:GetTwentyYearsBless(nSure)
	if self:CheckTime() ~= 1 then
		Dialog:Say("�Բ��𣬱��λ�Ѿ�������");
		return 0;
	end
	
	if (me.nPrestige < 50) and (me.nMonCharge < 15) then	--��������������50���ߵ��³�ֵ������15Ԫ
		local szMsg = "�����硭��������ף������ʧ���ˣ�����Ȼ���㲻�������ˣ�(������������ﵽ<color=yellow>50��<color>�����ۼƳ�ֵ�ﵽ<color=yellow>15Ԫ<color>��ֻҪ�����ﵽ<color=yellow>����һ��<color>������ȡ��)";
		Dialog:Say(szMsg);
		return 0;
	end
	
	if (me.GetSkillState(892) > 0) then
		local szMsg = "����ô�����ˣ������ǲ�����̰�ĵ�!(<color=yellow>���Ѿ���ȡ����ף��!<color>)";
		Dialog:Say(szMsg);
		return 0;
	end
	
	--ȷ����ȡ
	if (nSure) then
		local nTime = 5 * 24 * 3600;
		local nCurDate = tonumber(GetLocalDate("%y%m%d%H%M"));
		me.SetTask(self.TASKGROUP, self.TSK_GREED, nCurDate);
		me.AddSkillState(892, 1, 2, nTime * Env.GAME_FPS, 1, 0, 1);
		Dialog:Say("���������̫���Ͼ������顭����ͻȻ�Ҹо��������ڳ���������������ϲ�㣬ף����������ˡ�");
		return 0;
	end
	
	local tbOpt = {
			{"ȷ����ȡ", self.GetTwentyYearsBless, self, 1},
			{"���ٿ��ǿ���"},
		};
	local szMsg = "���ȷ����ȡ��<color=red>�Զ����ף��Ч��<color>����ȷ����ȡ�𣿡�";
	Dialog:Say(szMsg, tbOpt);
	return 0;
end;

function tbTwentyAnvsy:XiuLianZhuOnDialog()
	self:GetXiuLianZhuTime();
end;

function tbTwentyAnvsy:GetXiuLianZhuTime()
	local nTaskvalue = me.GetTask(self.TASKGROUP, self.EACH_HOUR_ID);
	local nTaskCount = me.GetTask(self.TASKGROUP, self.TIME_COUNT_ID);
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	
	--��ȷ����ȡ�Ĵ���û�г���3��
	if (nTaskCount >= self.MAX_COUNT) then
		local szMsg = "���Ѿ���ȡ��<color=yellow>6Сʱ<color>������ʱ�䣬��Ϊ���Ͳ�����̰��Ŷ��";
		Dialog:Say(szMsg);
		return 0;
	end;
	
	--û�г����������жϽ����Ƿ��Ѿ���ȡ��
	if (not (nDate > nTaskvalue)) then
		local szMsg = "������Ѿ���ȡ���ý��������ѵ���������";
		Dialog:Say(szMsg);
		return 0;
	end;
	
	--û����ȡ�����ж��Ƿ������ȡ����:�����ȡʱ����ʱ�䳬��12Сʱ����������ȡ��
	local tbItem = Item:GetClass("xiulianzhu");
	local nRemianTime = tbItem:GetRemainTime();
	if (nRemianTime > self.TIME_LIMIT) then
		local szMsg = "�Բ�������ȡ���ۼ�����ʱ�佫����<color=red>14Сʱ<color>�����ԣ������ۼ�����ʱ�䲻����<color=red>12Сʱ<color>��ʱ��������ȡ�ɡ�";
		Dialog:Say(szMsg);
		return 0;
	end;
	
	--������������ȡʱ��
	local szMsg = "��������ʱ��������<color=yellow>2<color>Сʱ����������³�ֵ�ۼƴﵽ48Ԫ��������������������ȡ���¶�������ʱ��Ŷ��";
	local nAddTime = self.EACH_TIME_LENGTH * 60;	--120����
	tbItem:AddRemainTime(nAddTime);

	--�޸����������ֵ
	me.SetTask(self.TASKGROUP, self.EACH_HOUR_ID, nDate);
	me.SetTask(self.TASKGROUP, self.TIME_COUNT_ID, nTaskCount + 1);
	Dialog:Say(szMsg);
	return 0;
end;

function tbTwentyAnvsy:GiveSpecialMonsterMapProb()	
	--�����жϵ��³�ֵ�Ƿ�ﵽ48Ԫ�����Ѿ���ȡ��
	local nMonChr = me.GetExtMonthPay();
	local nTaskValue = me.GetTask(self.TASKGROUP, self.SPECIALMONSTERMAPPROB_TASKID);
	if (nTaskValue > 0) then	--�������ֵ����48Ԫ
		local szMsg = "������ȡ��<color=red>�ؾ���ͼ<color>�ˡ�";
		Dialog:Say(szMsg);
		return 0;
	end;
	
	if (nMonChr < 48) then	--�������ֵ����48Ԫ
		local szMsg = "�������ۼƳ�ֵδ��48Ԫ���޷���ȡ<color=red>�ؾ���ͼ<color>��";
		Dialog:Say(szMsg);
		return 0;
	end;
	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("�������ռ䲻�㡣������1�񱳰��ռ䡣");
		return 0;
	end
	
	--������������ȡ
	--����Ʒ
	local szMsg = "���պã���������<color=red>�ؾ���ͼ<color>����л�������ǵ�֧�֡�";
	local pItem = me.AddItem(18, 1, 251, 1);
	if pItem then
		pItem.Bind(1);
		local nDate = tonumber(GetLocalDate("%Y%m%d"));
		me.SetTask(self.TASKGROUP, self.SPECIALMONSTERMAPPROB_TASKID, nDate);
		me.Msg("������һ�����������ֵ�ͼ�ĵ���!");
	end
	Dialog:Say(szMsg, tbOpt);
	return 0;
end;

--����������Ϣ
--���ص�ͼ

	--{
	--	nKey 		= 0,	--keyֵ��Ĭ��Ϊ0
	--	nStartTime 	= 0,	--����ʱ�� -������ʱ��200810101200��Ĭ��Ϊ0
	--	nEndTime 	= 0,	--����ʱ�� -������ʱ��200810101224��Ĭ��Ϊ0
	--	nGlobalKey 	= 16,	--Ĭ��Ϊ����ʱ���ȫ�ֱ���
	--	nStartDay 	= 0,	--���������������nLastDay����ʹ�ã���Ĭ��Ϊ0
	--	nLastDay 	= 0,	--���������ʱ�䣨��nStartDay����ʹ�ã���Ĭ��Ϊ0
	--	szTitle		= "",	--����
	--	szContent 	= [[	--����
	--	]],
	--},

function tbTwentyAnvsy:SetMysteriousMapNews()
	local tbNews = {};
	tbNews.nKey			= 11;
	tbNews.nStartTime 	= self.tbEventTime[1] * 10000;	--��������
	tbNews.nEndTime		= self.tbEventTime[2] * 10000;
	tbNews.nStartDay	= 0;
	tbNews.nLastDay		= 0;
	tbNews.szTitle		= "��20���ꡪ���ص�ͼ";
	tbNews.szContent	= [[
�ʱ�䣺<color=yellow>2008��11��18�ո��º󡪡�2008��11��25��0ʱ<color>

����ݣ�
    ���ͬ���֣����춼��ϲ��1988�꣬��ɽ�����ˡ�һ���ۣ�20���ȥ�ˡ�
    Ϊ�˴�л����û������ǵ�֧�֣����Ǿ���׼��<color=green>һЩ���ص������ص㡣<color>
    
    ��ڼ䣬��<color=green>�����ۼƳ�ֵ��48Ԫ<color>�����ͣ������Ե�λ�ڸ����ִ��еĻ�ƹ�Ա����������Ҫһ��<color=yellow>ͨ�������ؾ��ĵ�ͼ<color>�����������ͼ������ô���׿����ģ�Ҳ������е�<color=yellow>��������<color>֪����ʲô��

��������ؾ���ͼ

�ر�ע�⣺
    <color=green>���³ɹ���ֵ��15Ԫ��ֵ��������30Ԫ��ֵ��������48Ԫ��ֵ��������50Ԫ��ֵ��������100Ԫ��ֵ��������500Ԫ��ֵ����������������ʵ�����鿨�����п����Ż�����ۼƳ�ֵ��<color>

�ؾ���ͼ��
    �������������ص�ĵ�ͼ����˵�ڸõص���<color=yellow>��ֻ�����ͨ��4���ľ��飬2Сʱ�󣬸õص���Զ��ر�<color>��������ͼ������̫����ˣ����ǿ�������Ҳ��<color=yellow>��������<color>�ܹ��������ǡ�
]];

Task.tbHelp:RegisterDyNews(tbNews);	--ע������Ϣ
end;

--������
function tbTwentyAnvsy:SetXiuLianZhuNews()
	local tbNews = {};
	tbNews.nKey			= 12;
	tbNews.nStartTime 	= self.tbEventTime[1] * 10000;	--��������
	tbNews.nEndTime		= self.tbEventTime[2] * 10000;
	tbNews.nStartDay	= 0;
	tbNews.nLastDay		= 0;
	tbNews.szTitle		= "��20���ꡪ�����Ϊ";
	tbNews.szContent	= [[
�ʱ�䣺<color=yellow>2008��11��18�ո��º󡪡�2008��11��25��0ʱ<color>

����ݣ�
    ���ͬ���֣����춼��ϲ��1988�꣬��ɽ�����ˡ�һ���ۣ�20���ȥ�ˡ�
    Ϊ�˴�л����û������ǵ�֧�֣����Ǿ���׼����<color=green>6Сʱ������ʱ��<color>��������ȡ��
    
    �ڻʱ���ڣ�<color=green>��3����ȡ2Сʱ����ʱ��Ļ���<color>��ֻҪ��ȡʱ<color=red>��ǰʣ������ʱ�䲻����12Сʱ�Ϳ�����ȡ���������12Сʱ��ȡ���ۼ�����ʱ��ᳬ��14Сʱ��<color>������ÿ��ÿ��ֻ����ȡһ��Ŷ��

���������������ʱ��
]];

Task.tbHelp:RegisterDyNews(tbNews);	--ע������Ϣ
end;

--���忾����
function tbTwentyAnvsy:SetKinQiZiNews()
	local tbNews = {};
	tbNews.nKey			= 13;
	tbNews.nStartTime 	= self.tbEventTime[1] * 10000;	--��������
	tbNews.nEndTime		= self.tbEventTime[2] * 10000;
	tbNews.nStartDay	= 0;
	tbNews.nLastDay		= 0;
	tbNews.szTitle		= "��20���ꡪ��������";
	tbNews.szContent	= [[
�ʱ�䣺<color=yellow>2008��11��18�ո��º󡪡�2008��11��25��0ʱ<color>

����ݣ�
    ���ͬ���֣����춼��ϲ��1988�꣬��ɽ�����ˡ�һ���ۣ�20���ȥ�ˡ���ɽ����20�꣬�벻����ҵ�֧�֡�
    
    �ڻ�ڼ䣬<color=green>���м������ʱ����õľ�����Ϊԭ����2����<color>

�����������
]];
Task.tbHelp:RegisterDyNews(tbNews);	--ע������Ϣ
end;

--ǿ�����ý���
function tbTwentyAnvsy:SetEhancePayDownNews()
	local tbNews = {};
	tbNews.nKey			= 17;
	tbNews.nStartTime 	= self.tbEventTime[1] * 10000;	--��������
	tbNews.nEndTime		= self.tbEventTime[2] * 10000;
	tbNews.nStartDay	= 0;
	tbNews.nLastDay		= 0;
	tbNews.szTitle		= "��20���ꡪǿ���Ż�ֱ��20��";
	tbNews.szContent	= [[
�ʱ�䣺<color=yellow>2008��11��18�ո��º󡪡�2008��11��25��0ʱ<color>

����ݣ�
    ���ͬ���֣����춼��ϲ��1988�꣬��ɽ�����ˡ�һ���ۣ�20���ȥ�ˡ�
    Ϊ�˴�л����û������ǵ�֧�֣����Ǿ���׼����<color=yellow>�����ף����������ȡ��<color>
    ��ڼ䣬��<color=green>��������������50����߱����ۼƳ�ֵ��15Ԫ<color>�����ͣ������Ե�λ�ڸ����ִ��еĻ�ƹ�Ա�����������������ף������������ף��������<color=green>ǿ������װ��ʱ��ǿ�����ö��ή��20��Ŷ��<color>

�������ǿ�����ý���

�ر�ע�⣺
    <color=green>���³ɹ���ֵ��15Ԫ��ֵ��������30Ԫ��ֵ��������48Ԫ��ֵ��������50Ԫ��ֵ��������100Ԫ��ֵ��������500Ԫ��ֵ����������������ʵ�����鿨�����п����Ż�����ۼƳ�ֵ��<color>
]];
Task.tbHelp:RegisterDyNews(tbNews);	--ע������Ϣ
end;

--����500��ҷ���100���
function tbTwentyAnvsy:SetJinBiHuanHuanNews()
	local tbNews = {};
	tbNews.nKey			= 18;
	tbNews.nStartTime 	= self.tbEventTime[1] * 10000;	--��������
	tbNews.nEndTime		= self.tbEventTime[3] * 10000;
	tbNews.nStartDay	= 0;
	tbNews.nLastDay		= 0;
	tbNews.szTitle		= "��20���ꡪ��������";
	tbNews.szContent	= [[
�ʱ�䣺<color=yellow>2008��11��21�ո��º�2008��11��28��0ʱ<color>

����ݣ�
    ���ͬ���֣����춼��ϲ��1988�꣬��ɽ�����ˡ�
    һ���ۣ�20���ȥ�ˡ�Ϊ�˴�л����û������ǵ�֧�֣�ֻҪ����<color=yellow>������������˱��³�ֵ���õ�500��ң��ͻ���100�󶨽�ҵķ���<color>���������ѵ�Խ���õİ󶨽�Ҿͻ�Խ�ࡣ��ô�����Ķ��˰ɡ�

��������󶨽��

�ر�ע�⣺
    1.<color=green>���³ɹ���ֵ��15Ԫ��ֵ��������30Ԫ��ֵ��������48Ԫ��ֵ��������50Ԫ��ֵ��������100Ԫ��ֵ��������500Ԫ��ֵ����������������ʵ�����鿨�����п�������ý�ң��Ż������Χ��<color>
    
    2.���ѵĽ��<color=green>ֻ�б��³�ֵ��õĲ���<color>�Żᱻ��Ϊ��Ч�����磺<color=yellow>���³�ֵ���1000��ң���ڼ�������1500��ң���ô��ֻ�ܵõ�200���Ľ���������500����ǲ������ġ�<color>
    
    3.��������ﳵ�·�����Ϣ��ʾ�����ʵʱ��ʾ�������ѵĽ�ң������ע����ʾ��Ϣ��

]];
Task.tbHelp:RegisterDyNews(tbNews);	--ע������Ϣ
end;

--�������Ҿ�̬��Ϣ����ȡ����������
--if MODULE_GC_SERVER then
--SpecialEvent.tbTwentyAnniversary:SetMysteriousMapNews();
--SpecialEvent.tbTwentyAnniversary:SetXiuLianZhuNews();
--SpecialEvent.tbTwentyAnniversary:SetKinQiZiNews();
--SpecialEvent.tbTwentyAnniversary:SetEhancePayDownNews();
--SpecialEvent.tbTwentyAnniversary:SetJinBiHuanHuanNews();
--end
