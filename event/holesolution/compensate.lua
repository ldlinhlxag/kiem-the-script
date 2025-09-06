------------------------------------------------------
-- �ļ�������compensate.lua
-- �����ߡ���dengyong
-- ����ʱ�䣺2009-10-10 17:08:27
-- ��  ��  ��ʵ�����ֲ�����ʽ
------------------------------------------------------

Require("\\script\\lib\\gift.lua");

if not SpecialEvent.HoleSolution then
	SpecialEvent.HoleSolution = {};
end

local HoleSolution = SpecialEvent.HoleSolution;

--�������������������
HoleSolution.TASK_COMPENSATE_GROUPID = 2105;		--�������������
HoleSolution.TASK_SUBID_REASON = 1;		--������¼��ұ��ӵ���Դ��ԭ��
--����������ӱ������飬��λΪһ�飬ÿ��ĵ�һλ������Ƿ�ļ�ֵ�����ڶ�λ�������⳥��ʽ
--��һλ��Ϊ�ж������������ڶ�λ��Ҫ�����á�
HoleSolution.tbSubTaskGroup = 
{
	{2, 3},		
	{4, 5},
}

------------------------------------------------------------------
--�������λ�뺬�壨�ӵ�λ����λ��
--��1λ����װ���ȼ�
--��2-6λ����Ǯ
	--��2λ����ͨ����
	--��3λ��������	--Ŀǰû�е���ʹ�ø�ѡ�����ϵ���5λ��
	--��4λ�����		--Ŀǰû�е���ʹ�ø�ѡ�����ϵ���5λ��
	--��5λ�����������������
	--��6λ�����		--Ŀǰ��δʹ�ø�ѡ��
--��7-9������
	--��7λ��������
	--��8λ������		--Ŀǰû�е���ʹ�ø�ѡ�����ϵ���9λ��
	--��9λ��������
--����������Щ���͹���λ֮�⣬����λ���߱����壬�������ж�
--ע�����������λ��ֻ�����ڽ���ѡ��Ŀ¼�����ܽ������������ -_-
---------------------------------------------------------------------------------------------------------------
--�ý���װ��ǿ�������������ۼ�ֵ���ĸ��贰��
HoleSolution.tbDegradeEquipGiftDialog = Gift:New();
HoleSolution.tbDegradeEquipGiftDialog._szTitle = "����װ��";
HoleSolution.tbDegradeEquipGiftDialog._szContent = "���ڸ����з���ǿ������װ����";

--�������������ۼ�ֵ���ĸ��贰��
HoleSolution.tbXJGiftDialog = Gift:New();
HoleSolution.tbXJGiftDialog._szTitle = "�۳�����";
HoleSolution.tbXJGiftDialog._szContent = "��������ĸ����з��������ɣ�";
HoleSolution.tbXJGiftDialog.ITEM_CALSS = "xuanjing";
------------------------------------------------------------------

if not MODULE_GAMECLIENT then

--�����������,��ѡ����ŵ�self.tbOpt��
--self.tbOpt�Ľṹ��tbTaskBitValueһ�£���ʵ��tbOpt��tbTaskBitValue��һ����
function HoleSolution:__ParseTheTaskVar(nTaskVar)
	local tbTaskVar = {};
	--�ӵ�λ����λ
	for i= 1, 32 do
		tbTaskVar[i] = nTaskVar%2;
		nTaskVar = math.floor(nTaskVar/2);
	end
	
	--δʹ�õ�ѡ���Ȳ����뵽�ñ��У���Ҫ���ĳ�����Ѿ����ڵ���޸ĸñ���
	local tbTaskBitValue =
	{
		[1] = {"����װ��ǿ������", self.__CompensateByDegradeEquip, self},
		[2] = {"��ͨ����", self.OnSelectMoneyType, self, "����������������", 0},	--0��ʾ����
		[5] = {"��������������", self.__SelectMoneyType, self, 5},	--5��ʾѡ�������
		[7] = {"��������", self.__CompensateByXuanJing, self, 1},		--1��ʾֻ���ò�����
		[9] = {"��������", self.__CompensateByXuanJing, self},
	}
	
	local tbOpt = {};
	
	for nIndex, tbValue in pairs(tbTaskBitValue) do
		if tbTaskVar[nIndex] == 1 then
			table.insert(tbOpt, tbValue);
		end
	end
	
	return tbOpt;
end

--�۳����һ���ּ�ֵ��֮�󣬽�ʣ����ۼ�ֵ��ͬ�������������
--��һ����ֵ������������ǵ�ǰ���ڴ��������
function HoleSolution:__SetBalanceValue(nArrearage)
	for nIndex, tbGroup in pairs(self.tbSubTaskGroup) do
		if me.GetTask(self.TASK_COMPENSATE_GROUPID, tbGroup[1]) > 0 then
			me.SetTask(self.TASK_COMPENSATE_GROUPID, tbGroup[1], nArrearage);
			return;
		end
	end
	
	--���ִ�е����˵���д�д��LOG
	Dbg:WriteLog("HoleSolution", "SpecialEvent.HoleSolution:__SetBalanceValue(): Error!");
end

--ͨ����Ǯ��������, nSelectedValue��ʾĿ¼��ѡ�������ֵ
--ֻ�е��"��������������"ѡ��Ż���뵽����
function HoleSolution:__SelectMoneyType(nSelectedValue)
	if nSelectedValue == 5 then 	--5��ʾ"��������������"������ֵ
		local szMsg = "\n��ѡ������۳���Ǯ�����͡�";
		local tbDlgItem = {};
		
		table.insert(tbDlgItem, {"����", self.OnSelectMoneyType, self, "����������������", 0});
		table.insert(tbDlgItem, {"������", self.OnSelectMoneyType, self, "���������������", 1});
		table.insert(tbDlgItem, {"�󶨽��", self.OnSelectMoneyType, self, "�������������", 2});	
		Dialog:Say(szMsg, tbDlgItem);
	end
end

function HoleSolution:OnSelectMoneyType(szTitle, nType)
	local tbMoneyType = 
	{--nType    szType       nNum
		[0] = {"��ͨ����", me.nCashMoney},
		[1] = {"������", me.GetBindMoney()},
		[2]	= {"�󶨽��", me.nBindCoin},
	}
	local nMaxCount = tbMoneyType[nType][2];	--ȡ������
	
	if 0 == nMaxCount then
		Dialog:Say(string.format("���%s����Ϊ0, ��ѡ������������ʽ��",  tbMoneyType[nType][1]));
		return;
	end
	Dialog:AskNumber(szTitle, nMaxCount, self.__CompensateByMoney, self, nType);
end

--nType��ʾǮ������: 0Ϊ������1Ϊ������2Ϊ���.(�����漰��Ǯ�����ͣ��������)
--nCountΪҪ�۳�Ǯ�����͵�����
function HoleSolution:__CompensateByMoney(nType, nCount)
	if not nType and (nType > 2 or nType < 0) then
		return;
	end
	
	if nCount == 0 then
		return;
	end
	
	local nArrearage = self:GetBalanceValue();	
	local nCompensateValue = (nType == 2) and nCount * 100 or nCount;	 --���ļ�ֵ��Ҫ��100
	local szType = (nType == 2) and "�󶨽��" or ((nType == 1) and "������" or "��ͨ����");
	
	local szMsg = "";
	szMsg = szMsg..string.format("��ȷ��Ҫ�۳�<color=yellow>%d%s<color>���㽫������ֵ��<color=yellow>%d<color>,",
			nCount, szType, nCompensateValue);
	if nCompensateValue > nArrearage then
		szMsg = szMsg..string.format("�������Ƿ�ĵļ�ֵ��Ҫ��,��ϵͳֻ��۳������ļ�ֵ��,���ಿ�ֻ᷵�����㣡");
		if nType == 2 then		--����ǰ��
			local nExtraBindCoin = math.floor((nCompensateValue - nArrearage)/100);
			nCount = nCount - nExtraBindCoin;
		else
			nCount = nCount - nCompensateValue + nArrearage;
		end
		nCompensateValue = nArrearage;
	elseif nCompensateValue == nArrearage then
		szMsg = szMsg..string.format("��պõ�������Ƿ�ļ�ֵ����")
	else
		szMsg = szMsg..string.format("�⻹��������ȫ��������Ƿ�ļ�ֵ��,�㽫��Ƿ��<color=red>%d<color>�ļ�ֵ����", nArrearage-nCompensateValue);
	end
	
	Dialog:Say(szMsg,
	{
		{"�ǵ�,��ȷ��", self.__CostPlayerMoney, self, nType, nCount, nCompensateValue, nArrearage},
		{"���ٿ��ǿ���"},
	})
end

function HoleSolution:__CostPlayerMoney(nType, nCount, nCompensateValue, nArrearage)
	local szType;
	if 0 == nType then
		szType = "��ͨ����";
		GM:ClearMoney(nCount, 0, 0);
	elseif 1 == nType then
		szType = "������";
		GM:ClearMoney(0, nCount, 0);
	elseif 2 == nType then
		szType = "�󶨽��";
		GM:ClearMoney(0, 0, nCount);
	end
	
	local szMsg = string.format("�۳�<color=yellow>%d%s<color>", nCount, szType);
	me.Msg(szMsg);
	nArrearage = nArrearage - nCompensateValue;
	self:__SetBalanceValue(nArrearage);	--��ʣ����ۼ�ֵ�����µ����������
end

--ͨ������װ��ǿ����������
function HoleSolution:__CompensateByDegradeEquip()
	HoleSolution.tbDegradeEquipGiftDialog:OnOpen();
	--Dialog:Gift("HoleSolution.tbDegradeEquipGiftDialog");
end

--����װ��ǿ����һ��
function HoleSolution:__DegradeEquip(tbDelEquip, nArrearage)
	--��д��־�ٰ���װ����ǿ���ȼ�
	for _, tbEquip in pairs(tbDelEquip) do
		if tbEquip[1].nEnhTimes >= 0 then
			local nEnhTimes, _, nTotalValue = HoleSolution:CalcEquipEnhanceValue(tbEquip[1], nArrearage);
			
			if tbEquip[1].nStrengthen == 1 then
				Dbg:WriteLog("HoleSolution", "%s��װ��%s�ĸ�������[%d��]������", me.szName, tbEquip[1].szName, nEnhTimes);
			end
			if nEnhTimes > 0 then	--�������˸������ԣ������п��ܲ���Ҫ����װ��ǿ���ȼ���ֻ��Ҫ���������԰���Ϳ�����
				Dbg:WriteLog("HoleSolution", string.format("%s��װ��%sǿ���ȼ��½�Ϊ%d��", me.szName, tbEquip[1].szName, nEnhTimes));
			end
			
			if tbEquip[1].Regenerate(
				tbEquip[1].nGenre,
				tbEquip[1].nDetail,
				tbEquip[1].nParticular,
				tbEquip[1].nLevel,
				tbEquip[1].nSeries,
				nEnhTimes,
				tbEquip[1].nLucky,
				tbEquip[1].GetGenInfo(),
				0,
				tbEquip[1].dwRandSeed,
				0) == 1 then		--����֮ǰ��װ���ǲ��Ǳ��������ֻҪ������ͻ�������Զ��ᱻ����
				nArrearage = nArrearage - nTotalValue;
			end
		end
	end
	
	-- �����~��Ҫ��������
	local tbBuChang = {}; 
	if nArrearage < 0 then
		tbBuChang = Item:ValueToItem(math.abs(nArrearage), 4);  --�����������������ж�ʧ����һ������������ֵ�ȼ�ֵ����������
		nArrearage = 0;
		self:__BuChangXuanJing(tbBuChang);
	end
	
	self:__SetBalanceValue(nArrearage);	--��ʣ����ۼ�ֵ�����µ����������
end

--ͨ����������������
--bNotBind: Ϊ1ʱ��ֻ���÷ǰ��������������������
function HoleSolution:__CompensateByXuanJing(bNotBind)
	bNotBind = bNotBind or 0;
	HoleSolution.tbXJGiftDialog:OnOpen(bNotBind);
	--Dialog:Gift("HoleSolution.tbXJGiftDialog");
end

--�۳�����
function HoleSolution:__DelPlayerXuanJing(tbItem, nArrearage)
	local nSumOfValue = 0;
	for i, pDelItem in pairs(tbItem) do
		local nCurValue = pDelItem.nValue;
		if me.DelItem(pDelItem) ~= 1 then
			Dbg:WriteLog("HoleSolution", "�۳�����ʱ����");
		else
			nSumOfValue = nSumOfValue + nCurValue
		end
	end
	
	nArrearage = nArrearage - nSumOfValue;
	-- �����~��Ҫ��������
	if nArrearage < 0 then	
		local tbBuChang = Item:ValueToItem(math.abs(nArrearage), 4);  --�����������������ж�ʧ����һ������������ֵ�ȼ�ֵ����������
		nArrearage = 0;
		self:__BuChangXuanJing(tbBuChang);
	end
	
	self:__SetBalanceValue(nArrearage);	--��ʣ����ۼ�ֵ�����µ����������
end

--����۵ļ�ֵ�����һ��ɵ������������
--�ȰѲ���������ֱ�Ӹ���ң������ұ�����������ʣ����������ʼ����͸���
function HoleSolution:__BuChangXuanJing(tbBuChang)
	if tbBuChang then
		for nLevel, nNum in pairs(tbBuChang) do
			for i = 1, nNum do
				local pItem = me.AddItem(18,1,114, nLevel);
				if not pItem then --and nLevel >= 5 then
					KPlayer.SendMail(me.szName, "����", "",
						0, 0, 1, 18,1,114,nLevel);
				end
			end
		end
		me.Msg("���������Ѿ����͸���,��ע����գ�");
	end
	
	tbBuChang = {};
end

------------------------------------------------------------------------------------------
-- server callback interface
function HoleSolution.tbDegradeEquipGiftDialog:OnOK()
	local nArrearage = HoleSolution:GetBalanceValue();
	local pItem = self:First();
	if not pItem then
		Dialog:Say("��û�����κ���Ʒ��");
		return 0;
	end
	while pItem do
		if (pItem.szClass ~= "suite" or pItem.szClass ~= "equip") and pItem.nEnhTimes <= 0 then
			Dialog:Say("������ֻ�ܴ��ǿ������װ��!")
			return 0;
		end
		pItem = self:Next();
	end
	
	local nSumOfValue, tbItem = self:CalItemValue(nArrearage);
	local szMsg = string.format("���������ʽ,�㽫������ֵ��<color=yellow>%d<color>,", nSumOfValue);
	if nSumOfValue > nArrearage then
		local tbBuChang, szAddMsg = HoleSolution:GetBuChangInfo(nSumOfValue - nArrearage);
		if tbBuChang then
			szMsg = szMsg..szAddMsg;
		end
	elseif nSumOfValue == nArrearage then
		szMsg = szMsg.."�⽫�պõ�������Ƿ�ļ�ֵ����";
	else
		szMsg = szMsg..string.format("�⻹��������ȫ��������Ƿ�ļ�ֵ�����㻹Ƿ<color=red>%d<color>�ļ�ֵ����", nArrearage-nSumOfValue);
	end
	szMsg = szMsg.."Ϊ�˰�ȫ����������ٴ�ȷ�ϣ�";
	
	Dialog:Say(szMsg,
	{
		{"�ǵ�,��ȷ��", HoleSolution.__DegradeEquip, HoleSolution, tbItem, nArrearage},
		{"���ٿ��ǿ���"},
	});	
end

function HoleSolution.tbDegradeEquipGiftDialog:OnOpen()
	--��֪ͨ�ͻ��˸������ݣ��ٴ򿪴���
	me.CallClientScript({"SpecialEvent.HoleSolution.tbDegradeEquipGiftDialog:OnUpdateParam"});
	Dialog:Gift("SpecialEvent.HoleSolution.tbDegradeEquipGiftDialog");
end

function HoleSolution.tbXJGiftDialog:OnOK()
	local pItem = self:First();
	local tbItem = {};
	if not pItem then
		Dialog:Say("��û�����κ���Ʒ��");
		return 0;
	end
	while pItem do
		if pItem.szClass == HoleSolution.tbXJGiftDialog.ITEM_CALSS then
			table.insert(tbItem, pItem);
		else
			Dialog:Say("������ֻ�ܷ���������");
			tbItem = {};
			return 0;
		end		
		if HoleSolution.tbXJGiftDialog.bNotBind == 1 and pItem.IsBind() == 1 then
			Dialog:Say("��Ҫ�ò�������");
			tbItem = {};
			return 0;
		end		
		pItem = self:Next();
	end
	
	local nArrearage = HoleSolution:GetBalanceValue();
	local nSumOfValue = self:CalItemValue();
	local szMsg = string.format("���ڸ����з����������ܼ�ֵ��Ϊ<color=yellow>%d<color>,", nSumOfValue);
	if nSumOfValue > nArrearage then
		local tbBuChang, szAddMsg = HoleSolution:GetBuChangInfo(nSumOfValue - nArrearage);
		if tbBuChang then
			szMsg = szMsg..szAddMsg;
		end
	elseif nSumOfValue == nArrearage then
		szMsg = "��պõ�������Ƿ�ļ�ֵ����";
	else
		szMsg = szMsg..string.format("�⻹�����ڵ�������Ƿ�ļ�ֵ��,�㻹Ƿ<color=red>%d<color>�ļ�ֵ����", nArrearage-nSumOfValue);
	end
	szMsg = szMsg.."Ϊ�˰�ȫ����������ٴ�ȷ�ϣ�";
		
	Dialog:Say(szMsg,
	{
		{"�ǵ�,��ȷ��", SpecialEvent.HoleSolution.__DelPlayerXuanJing, SpecialEvent.HoleSolution, tbItem, nArrearage},
		{"���ٿ��ǿ���"},
	});	
end

function HoleSolution.tbXJGiftDialog:OnOpen(bNotBind)
	me.CallClientScript({"SpecialEvent.HoleSolution.tbXJGiftDialog:OnUpdateParam", bNotBind});
	Dialog:Gift("SpecialEvent.HoleSolution.tbXJGiftDialog");
end

end		-- if not MODULE_GAMECLIENT then else 
------------------------------------------------------------------------------------------
--�ͻ��˺���
function HoleSolution.tbDegradeEquipGiftDialog:OnUpdate()
	local pFindItem = HoleSolution.tbDegradeEquipGiftDialog:First();
	if not pFindItem then
		self._szContent = "���ڸ����з���ǿ������װ����";
	else
		local nSumOfValue, tbItem = self:CalItemValue(self.nArrearage);
		if tbItem then
			self._szContent = "";
			self._szContent = self._szContent..string.format("�㵱ǰǷ��<color=red>%d<color>�ļ�ֵ����", self.nArrearage);
			self._szContent = self._szContent..string.format("�㽫�������µķ�ʽ������\n<color=green>װ������, �������, ������ֵ��<color>");
			for _, tbSingleItem in pairs(tbItem) do
				local szChanged = "";
				if tbSingleItem[1].nStrengthen == 1 then
					szChanged = string.format("ȥ����%d���ԣ���%d��", tbSingleItem[1].nEnhTimes, tbSingleItem[1].nEnhTimes - tbSingleItem[2]);
				else
					szChanged = string.format("��%d��", tbSingleItem[1].nEnhTimes - tbSingleItem[2]);
				end
				self._szContent = self._szContent..string.format("\n<color=yellow>%s<color>, <color=yellow>%s<color>, <color=yellow>%d<color>;", tbSingleItem[1].szName, szChanged, tbSingleItem[3]);
			end
			self._szContent = self._szContent..string.format("\n��������ֵ��<color=yellow>%d<color>,", nSumOfValue);
		end
		--����۳��ļ�ֵ����Ƿ�ļ�ֵ��Ҫ�࣬���������������Ϣ
		if nSumOfValue > self.nArrearage then
			local tbBuChang, szAddMsg = HoleSolution:GetBuChangInfo(nSumOfValue - self.nArrearage);
			if tbBuChang then
				self._szContent = self._szContent..szAddMsg;
			end
		end
	end
end

--������������붫��
--pPickItemָ�Ӹ��贰�����ó�����Ʒ��pDropItemָ�򴰿��з������Ʒ(��ͬ)
function HoleSolution.tbDegradeEquipGiftDialog:OnSwitch(pPickItem, pDropItem, nX, nY)
	if pDropItem then
		if pDropItem.szClass ~= "suite" and pDropItem.szClass ~= "equip" then		--�������Ʒ����װ��
			me.Msg("�����װ��!");
			return 0;
		end
		if pDropItem.nEnhTimes <= 0 then		--�����װ��û��ǿ����
			me.Msg("��װ��û��ǿ����ֵ���������·���ǿ������װ��!");
			return 0;
		end
	end
	if pPickItem then
		local pFindItem = HoleSolution.tbDegradeEquipGiftDialog:First();
		if not pFindItem then		--������û��װ����
			self._szContent = "���ڸ����з���ǿ������װ����";
			return 1;
		end
	end
		
	return 1;
end

--������֪ͨ�ͻ��˸�������
function HoleSolution.tbDegradeEquipGiftDialog:OnUpdateParam()
	HoleSolution.tbDegradeEquipGiftDialog.nArrearage = HoleSolution:GetBalanceValue();
end

function HoleSolution.tbXJGiftDialog:OnUpdate()
	local nSumOfValue = self:CalItemValue();
	local szTipInfo = (self.bNotBind == 1) and "(������)" or "(������)";
	self._szContent = string.format("���ڸ����з��������ɣ�<color=green>%s<color><enter>�㵱ǰһ��Ƿ��<color=red>", szTipInfo);
	self._szContent = self._szContent..string.format("%d<color>�ļ�ֵ��,",self.nArrearage);
	self._szContent = self._szContent..string.format("�������������ֵ<color=yellow>%d<color>�ļ�ֵ����", nSumOfValue);
	--self._szContent = self._szContent.."\n<color=green>(��ʾ��������ύ�ļ�ֵ����ʵ�ʼ�ֵ���ߣ�����Ĳ��ֽ����Ե͵ȼ���ʽ��������������)<color>";
	--����۳��ļ�ֵ����Ƿ�ļ�ֵ��Ҫ�࣬���������������Ϣ
	if nSumOfValue > self.nArrearage then
		local tbBuChang, szAddMsg = HoleSolution:GetBuChangInfo(nSumOfValue - self.nArrearage);
		if tbBuChang then
			self._szContent = self._szContent..szAddMsg;
		end
	end
end

-- ������������붫��
function HoleSolution.tbXJGiftDialog:OnSwitch(pPickItem, pDropItem, nX, nY)	
	if pDropItem then
		if pDropItem.szClass ~= self.ITEM_CALSS then
			me.Msg("������ֻ�ܷ���������");
			return 0;
		end
		if self.bNotBind == 1 and pDropItem.IsBind() == 1 then
			me.Msg("����벻������");
			return 0;
		end
	end
									
	return 1;
end

function HoleSolution.tbXJGiftDialog:OnUpdateParam(bNotBind)
	print("ִ��OnUpdateParam", bNotBind);
	self.nArrearage = HoleSolution:GetBalanceValue();
	self.bNotBind = bNotBind;
end
------------------------------------------------------------------------------------------
--�������ͻ��˹���
--ȡ����һ��Ƿ�ļ�ֵ���Ͳ�����ʽ��ֵ
function HoleSolution:GetBalanceValue()
	local nArrearage, nTaskVar = 0, 0;
	for nIndex, tbGroup in pairs(self.tbSubTaskGroup) do
		nArrearage = me.GetTask(self.TASK_COMPENSATE_GROUPID, tbGroup[1]);
		nTaskVar = me.GetTask(self.TASK_COMPENSATE_GROUPID, tbGroup[2]);
		if nArrearage > 0 then
			return nArrearage, nTaskVar;
		end
	end
	
	return nArrearage, nTaskVar;
end

--ȡ����һ�ò�����������Ϣ
function HoleSolution:GetBuChangInfo(nValue)
	local tbBuChang = Item:ValueToItem(math.abs(nValue), 4);  --�õ�����������Ϣ��	
	local szMsg = "";	
	if tbBuChang then
		szMsg = szMsg.."�������Ƿ�ļ�ֵ���࣬������ύ,�㽫�õ�����������Ϊ������<color=green> ";
		for nLevel, nNum in pairs(tbBuChang) do
			szMsg = szMsg..string.format("%d������%d��;", nLevel, nNum);
		end
		szMsg = szMsg.."<color>";
	end
	
	return tbBuChang, szMsg;
end

--��������װ�����贰������Ҫ�۳����ܼ�ֵ��
function HoleSolution.tbDegradeEquipGiftDialog:CalItemValue(nArrearage)
	local nValue = nArrearage;
	local nSumOfVlaue = 0;
	local tbItem = {};
	
	local pItem = self:First();
	if not pItem then
		return nSumOfVlaue;
	end
	while pItem do
		if pItem.szClass == "suite" or pItem.szClass == "equip" then
			local nEnhTimes, nNewValue, nTotalValue = HoleSolution:CalcEquipEnhanceValue(pItem, nValue);	
			nValue = nNewValue;
			
			nSumOfVlaue = nSumOfVlaue + nTotalValue;
			table.insert(tbItem, {pItem, nEnhTimes, nTotalValue});
			if nValue <= 0 then
				break;
			end
		end
		
		pItem = self:Next();
	end
		
	return nSumOfVlaue, tbItem;
end

--����۳��������贰���������������ܼ�ֵ��
function HoleSolution.tbXJGiftDialog:CalItemValue()
	local nSumOfVlaue = 0;
	
	local pItem = self:First();
	if not pItem then
		return nSumOfVlaue;
	end
	while pItem do
		if pItem.szClass == self.ITEM_CALSS then
			
			local tbBaseProp = KItem.GetItemBaseProp(Item.SCRIPTITEM, 1, 1, pItem.nLevel);
			nSumOfVlaue = nSumOfVlaue + tbBaseProp.nValue;
		end
		
		pItem = self:Next();
	end
		
	return nSumOfVlaue;
end

-- ����װ����ǿ����ֵ��
--����ֵ��ʣ��ǿ��������ʣ���ֵ�����ܼ�ֵ��
function HoleSolution:CalcEquipEnhanceValue(pItem, nValue)
	local nTotalValue = 0;	--����װ���������������ļ�ֵ��
	local tbSetting = Item:GetExternSetting("value", pItem.nVersion);
	local nEnhTimes = pItem.nEnhTimes;
	if (tbSetting) then
		local nTypeRate = ((tbSetting.m_tbEquipTypeRate[pItem.nDetail] or 100) / 100) or 1;
		--����и���ģ��ȼ������ļ�ֵ��
		if pItem.nStrengthen == 1 then
			local nStrengthenValue = tbSetting.m_tbStrengthenValue[pItem.nEnhTimes] * nTypeRate * 1.1;	-- TODO:������200�ģ����Լ�ֵ��Ҫ*1.1���Ժ������ֵ���ݻ��ʼ������ 
			nValue = nValue - nStrengthenValue;
			nTotalValue = nStrengthenValue + nTotalValue;
			if nValue <= 0 then
				return pItem.nEnhTimes, nValue, nTotalValue;
			end
		end
		
		repeat
			local nEnhValue = math.floor((tbSetting.m_tbEnhanceValue[nEnhTimes] or 0) * nTypeRate * 1.1);  -- TODO:������200�ģ����Լ�ֵ��Ҫ*1.1���Ժ������ֵ���ݻ��ʼ������ 
			nValue = nValue - nEnhValue;
			nTotalValue = nTotalValue + nEnhValue;
			nEnhTimes = nEnhTimes - 1;
		until (nEnhTimes <= 0 or nValue <= 0);
	end
	return nEnhTimes, nValue, nTotalValue;
end


---------------------------------------------------------------------------------------------------------------

