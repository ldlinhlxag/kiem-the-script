--���ڰ������
--�����
--2009.01.06

local tbNpc = Npc:GetClass("spring_liguan")
tbNpc.tbYanHua = {18, 1, 279, 1};

function tbNpc:OnDialog()
	if Esport:CheckState() == 0 then
		Dialog:Say("��ֻ�ǳ����й��й䡣��");		
		return 0;
	end
	
	local szMsg = "���굽�������˼��ҵ���ȥ���꣬������Ե�˴�ż�����������������ɡ�";
	local tbOpt = {
		{"��������̻�", self.GetYanHua, self, him.dwId},
		{"����������", self.GetGift, self, him.dwId},
		{"��㿴��"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetYanHua(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return 0;
	end
	
	if me.nLevel < 50 then
		Dialog:Say("�����̻�����������֮�����˼���û���κ�Ч�����񲻣��˷ѣ�����50���Ժ��������Ұɡ�");
		return 0;
	end
	
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	local nTaskDate = me.GetTask(Esport.TSK_GROUP, Esport.TSK_NEWYEAR_YANHUA);
	if nCurDate <= nTaskDate then
		Dialog:Say("����첻���Ѿ���ȡ���̻��ˣ�����ƭ���ࡣ");
		return 0;
	end
	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("������������˶���������װ������");
		return 0;
	end	
	
	--�����Ʒ������
	local pItem = me.AddItem(unpack(self.tbYanHua));
	if pItem then
		me.SetTask(Esport.TSK_GROUP, Esport.TSK_NEWYEAR_YANHUA, nCurDate);
		pItem.Bind(1);
	end
	Dialog:Say("������֣��������͸�������ף������������");
end

function tbNpc:GetGift(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return 0;
	end
	if me.nLevel < 50 then
		Dialog:Say("��Щ�������������Ϊ����û�κ��ã��������50���������ɡ�");
		return 0;
	end	
	
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	local nTaskDate = me.GetTask(Esport.TSK_GROUP, Esport.TSK_NEWYEAR_LIGUAN_DAY);
	if nCurDate <= nTaskDate then
		Dialog:Say("���˻����죬���ಢ�����ۻ軨Ŷ���������ʵ����Ҫ�ˣ�ÿ��ֻ������������ȡһ�����");
		return 0;
	end	
	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("������������˶���������װ������");
		return 0;
	end
	
	--�����Ʒ������
	if Item:GetClass("randomitem"):SureOnUse(14, 0, 0, 0) == 1 then
		me.SetTask(Esport.TSK_GROUP, Esport.TSK_NEWYEAR_LIGUAN_DAY, nCurDate);
		Dialog:Say("������֣��������͸�������ף����������");
	end
end
