-- �ļ�������vipreturn_6m.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-07-02 10:24:20
-- ��  ��  ��

SpecialEvent.VipReturn_6M = SpecialEvent.VipReturn_6M or {};
local tbVip = SpecialEvent.VipReturn_6M;

tbVip.nCreateDate = 20091215;
tbVip.nStart 	= 20100201;
tbVip.nEnd 		= 20100303;
tbVip.nTsk_Group= 2083;
tbVip.nTsk_Id1	= 7;	--�������
tbVip.nTsk_Id2	= 8;	--��ȡ�ƺŹ⻷
tbVip.nTsk_Id3	= 9;	--��ȡ���
tbVip.nTsk_Id4	= 10;	--��ȡͬ��
tbVip.nTsk_batch= 11;   --����
tbVip.tbLevel = 
{
	[1] = "����",
	[2] = "��",
	[3] = "��ʯ��",
}

--�ƺ�
tbVip.tbHalo = 
{
	[1] = {6,7,1,8},
	[2] = {6,7,2,9},
	[3] = {6,7,3,10},
}

tbVip.tbMask =
{
	[1] = {1,13,33,1},
	[2] = {1,13,34,1},
}

tbVip.tbPartner = {18,1,547,3};

tbVip.nBatchNum = 1;		--��ǰ����
tbVip.nLevelLimit = 69;


function tbVip:GetTypeLevel()
	return self.tbVip[string.upper(me.szAccount)] or 0;
end

function tbVip:Check()
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	if nCurDate < self.nStart or nCurDate >= self.nEnd then
		return 0;
	end
	if not self.tbVip then
		return 0;
	end
	local nLevel = self:GetTypeLevel();
	if nLevel == 0 then
		return 0;
	end

	if tonumber(me.GetRoleCreateDate()) >= self.nCreateDate and VipPlayer.VipTransfer:CheckQualification(me) == 0 then
		return 0;
	end

	return 1;
end

function tbVip:OnDialog()	
	--������
	if me.GetTask(self.nTsk_Group, self.nTsk_batch) ~= self.nBatchNum then
		me.SetTask(self.nTsk_Group, self.nTsk_batch,self.nBatchNum);
		me.SetTask(self.nTsk_Group, self.nTsk_Id1,0);
		me.SetTask(self.nTsk_Group, self.nTsk_Id2,0);
		me.SetTask(self.nTsk_Group, self.nTsk_Id3,0);
		me.SetTask(self.nTsk_Group, self.nTsk_Id4,0);
	end
	
	local nLevel = self:GetTypeLevel();
	if nLevel == 0 then
		return 0;
	end	
	local szMsg = "���ã���2009��ȳ�ֵ�ﵽ4500Ԫ���ϵ���ҿ�����ȡ����ƺ���⻷���ﵽ10000Ԫ�����пɰ�����߽������ﵽ30000Ԫ���ϸ�������ͬ�齱�����Ͽ켤���콱�ɣ�";
	local tbOpt = {};
	if me.GetTask(self.nTsk_Group, self.nTsk_Id1) == 0 then	
		table.insert(tbOpt,	{"<color=yellow>�����콱�ʸ�<color>", self.Activation, self});
	else
		table.insert(tbOpt,	{"<color=gray>�����콱�ʸ�<color>", self.Activation, self});
	end
		
	if me.GetTask(self.nTsk_Group, self.nTsk_Id2) == 0 then	
		table.insert(tbOpt,	{"<color=yellow>��ȡVIP�ƺż��⻷<color>", self.GetAward1, self, nLevel});
	else
		table.insert(tbOpt,	{"<color=gray>��ȡVIP�ƺż��⻷<color>", self.GetAward1, self, nLevel});
	end
	
	if nLevel > 1 then
		if me.GetTask(self.nTsk_Group, self.nTsk_Id3) == 0 then
			table.insert(tbOpt,{"<color=yellow>��ȡ�������<color>", self.GetAwardMask,self});
		else
			table.insert(tbOpt,{"<color=gray>��ȡ�������<color>", self.GetAwardMask,self});
		end
	end
	
	if nLevel > 2 then
		if me.GetTask(self.nTsk_Group, self.nTsk_Id4) == 0 then
			table.insert(tbOpt,{"<color=yellow>��ȡ����ͬ��<color>", self.GetAwardPartner,self});
		else
			table.insert(tbOpt,{"<color=gray>��ȡ����ͬ��<color>", self.GetAwardPartner,self});
		end
	end	
	table.insert(tbOpt,{"��㿴�����뿪��"});	

	Dialog:Say(szMsg, tbOpt);
end

function tbVip:Activation()
	if me.GetTask(self.nTsk_Group, self.nTsk_Id1) > 0 then
		Dialog:Say("���Ľ�ɫ�Ѿ������ˣ�����ȡVIP�����ɡ�");
		return 0;
	end
	
	local nExtBit = me.GetActiveValue(2);
	if nExtBit ~= 0 then	
		Dialog:Say("�����ʺ���������ɫ�Ѿ���������ȡVIP����������");
		return 0;
	end
	
	if me.nLevel < self.nLevelLimit then
		Dialog:Say(string.format("���ĵȼ�δ��%s�������ܼ����콱�ʸ�",self.nLevelLimit));
		return 0;
	end	
	
	if tonumber(me.GetRoleCreateDate()) >= self.nCreateDate and VipPlayer.VipTransfer:CheckQualification(me) == 0 then
		Dialog:Say("ֻ�н�ɫ����ʱ����2009��12��15��֮ǰ�Ĳſ��Լ����콱��");		
		return 0;
	end
	

	local szMsg = "��ȷ�����ǰ��ɫ�콱�ʸ�ô��������˺���������ɫ�Ͳ��ܼ����ˡ�";
	local tbOpt = {
		{"ȷ������", self.ActivationEx, self},
		{"���ٿ��ǿ���"},
	};
	Dialog:Say(szMsg, tbOpt);
end


function tbVip:ActivationEx()	
	Dialog:SendBlackBoardMsg(me, "��ϲ���ɹ����ǰ��ɫ���콱�ʸ�");
	me.Msg("��ϲ���ɹ����ǰ��ɫ���콱�ʸ�");
	me.SetActiveValue(2,1);
	me.SetTask(self.nTsk_Group, self.nTsk_Id1, 1);
	EventManager:WriteLog(string.format("SetActiveValue%s,%s", 2,1), me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[VIP����]�ɹ�������ȡ��ɫ"));	
	local tbOpt ={
		{"������һ��", self.OnDialog,self},
		{"ȷ��"},
	};
	Dialog:Say("��Ľ�ɫ�ѳɹ������ˡ�",tbOpt);
end

function tbVip:GetAward1(nLevel)
	if me.GetTask(self.nTsk_Group, self.nTsk_Id1) ~= 1 then
		Dialog:Say("��ǰ��ɫδ�����콱�ʸ񣬲����콱��");
		return 0;
	end
	if me.GetTask(self.nTsk_Group, self.nTsk_Id2) > 0 then
		Dialog:Say("���Ѿ���ȡ��������ˣ��������콱��");
		return 0;		
	end
--	me.AddTitle(6,7,nType,0);
--	me.SetCurTitle(6,7,nType,0);

	me.AddTitle(unpack(self.tbHalo[nLevel]));
	me.SetCurTitle(unpack(self.tbHalo[nLevel]));	
		
	me.SetTask(self.nTsk_Group, self.nTsk_Id2, 1);
	Dbg:WriteLog("Vip����", me.szName.."��ȡ�ƺŵȼ���"..tostring(nLevel));
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[VIP����]��ȡ�ƺŵȼ���%s", nLevel));
--	Dialog:Say("�ɹ���ȡ�˳ƺź͹⻷��")
	Dialog:SendBlackBoardMsg(me, "��ϲ���ɹ���ȡ�˳ƺż��⻷������");
	me.Msg("��ϲ���ɹ���ȡ�˳ƺż��⻷������");
end

function tbVip:GetAwardMask()
	if me.GetTask(self.nTsk_Group, self.nTsk_Id1) ~= 1 then
		Dialog:Say("��ǰ��ɫδ�����콱�ʸ񣬲����콱��");
		return 0;
	end
	
	if me.GetTask(self.nTsk_Group, self.nTsk_Id3) > 0 then
		Dialog:Say("���Ѿ���ȡ��������ˣ��������콱��");
		return 0;
	end
	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("�콱��Ҫ1�񱳰��ռ䣬ȥ�����������ɣ�");
		return 0;
	end	
	
	local tbOpt = 
	{
		{"�������", self.OnGetMask, self, 1},
		{"Ů�����", self.OnGetMask, self, 2},
		{"�����루�뿪��"},
	};
	
	Dialog:Say("���������Ů������ۣ�����Ҫ���֣�", tbOpt);
end

function tbVip:OnGetMask(nType)	
	local pItem = me.AddItem(unpack(self.tbMask[nType]));
	if pItem then
		pItem.Bind(1);
		me.SetItemTimeout(pItem, 30*24*60*3, 0);
		me.SetTask(self.nTsk_Group, self.nTsk_Id3, 1);
		Dbg:WriteLog("Vip����", me.szName.."��ȡ�������");
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[VIP����]��ȡ�������");			
		Dialog:SendBlackBoardMsg(me, "��ϲ�������������߽�����");
		me.Msg("��ϲ�������������߽�����");
	end
end



function tbVip:GetAwardPartner()
	if me.GetTask(self.nTsk_Group, self.nTsk_Id1) ~= 1 then
		Dialog:Say("��ǰ��ɫδ�����콱�ʸ񣬲����콱��");
		return 0;
	end
	
	if me.GetTask(self.nTsk_Group, self.nTsk_Id4) > 0 then
		Dialog:Say("���Ѿ���ȡ��������ˣ��������콱��");
		return 0;
	end
	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("�콱��Ҫ1�񱳰��ռ䣬ȥ�����������ɣ�");
		return 0;
	end	
	
	local pItem = me.AddItem(unpack(self.tbPartner));
	if pItem then
		pItem.Bind(1);
		me.SetItemTimeout(pItem, 30*24*60*4, 0);
		me.SetTask(self.nTsk_Group, self.nTsk_Id4, 1);
		Dbg:WriteLog("Vip����", me.szName.."����ͬ��Ҷ��");
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[VIP����]����ͬ��Ҷ��");			
		Dialog:SendBlackBoardMsg(me, "��ϲ�����������ͬ�齱����");
		me.Msg("��ϲ�����������ͬ�齱����");
	end
end


function tbVip:LoadFile()
	self.tbVip = {};
	self.tbJsPlayer = {};
	local tbFile = Lib:LoadTabFile("\\setting\\event\\vipplayerlist\\jsplayerlist.txt");
	if tbFile then
		for _, tbRole in pairs(tbFile) do
			local szAccount = string.upper(tbRole.ACCOUNT);
			local nMoney 	= tonumber(tbRole.MONEY) or 0;
			nMoney = nMoney * 5;
			if nMoney >= 4500 then
				if  nMoney < 10000 then
					self.tbVip[szAccount] = 1;	
				elseif nMoney <= 30000 then
					self.tbVip[szAccount] = 2;
				else
					self.tbVip[szAccount] = 3;
				end
			end
		end
	end
	
	tbFile = Lib:LoadTabFile("\\setting\\event\\vipplayerlist\\vipplayerlist.txt");
	if not tbFile then
		return 0;
	end
	for _, tbRole in pairs(tbFile) do
		local szAccount = string.upper(tbRole.ACCOUNT);
		local nType 	= tonumber(tbRole.Level) or 0;
		if not self.tbVip[szAccount] and nType ~= 0 then 
			self.tbVip[szAccount] = nType;
		end
	end
end

tbVip:LoadFile();
