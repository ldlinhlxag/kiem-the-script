--�����Ļ���

local tbClass = EventManager:GetClass("item_flowers")

function tbClass:ExeStartFun()
	local szTaskMale 		= self:GetParam("task_male")[1];
	local nTaskFeMale		= tonumber(self:GetParam("task_female")[1]) or 0;
	local nDefFeMaleMax 	= tonumber(self:GetParam("def_female_max")[1]) or 0;
	local nDefFeMaleLevel 	= tonumber(self:GetParam("def_female_level")[1]) or 0;
	local nDefFavorLevel 	= tonumber(self:GetParam("def_favorlevel")[1]) or 0;
	local szDefMaleItem		= (self:GetParam("def_male_Item")[1]);
	local szDefFeMaleItem	= (self:GetParam("def_female_Item")[1]);	
	local szDefMaleBuff		= (self:GetParam("def_male_buff")[1]);
	local szDefFeMaleBuff	= (self:GetParam("def_female_buff")[1]);
	local szDefTitle		= (self:GetParam("def_title")[1]);
	
	tbClass.TASK_MALE 			= Lib:SplitStr(szTaskMale); --���Դ�ף����Ů�Թ�ϣ��
	tbClass.TASK_FEMALE			= nTaskFeMale;				--Ů��ף�����ٴ��н���
	tbClass.DEF_FEMALE_MAX		= nDefFeMaleMax;			--Ů������ܵ�ף������
	tbClass.DEF_FEMALE_LEVEL	= nDefFeMaleLevel;			--Ҫ��ﵽ�ȼ�
	tbClass.DEF_FAVORLEVEL		= nDefFavorLevel;			--���ѵȼ�
	tbClass.DEF_MALE_ITEM		= szDefMaleItem;			--�з�������Ʒ
	tbClass.DEF_FEMALE_ITEM		= szDefFeMaleItem;			--Ů��������Ʒ
	tbClass.DEF_MALE_BUFF		= szDefMaleBuff;			--�з�����buff
	tbClass.DEF_FEMALE_BUFF		= szDefFeMaleBuff;			--Ů������buff
	tbClass.DEF_TITLE			= szDefTitle;	--�ƺ�Id
	tbClass.ITEM_RATE = 
	{
		{nRate = 10, tbItem={1,13,15,1}, nBind=1 },	--10���������
		{nRate = 10, tbItem={1,13,19,1}, nBind=1 },	--10���������
	};
end

function tbClass:OnUse()
	local szMsg = "�����ǽ���Ů���Ľ��գ�ѡ��һ��Ů���ͳ������ĵ�ף���ɣ�";
	
	if me.nTeamId <= 0 then
		Dialog:Say("��������Ů��������Ӳ����ڸ��������ͳ�ף����");
		return 0;
	end
	local tbTeamMemberList = me.GetTeamMemberList();
	if not tbTeamMemberList or #tbTeamMemberList <= 1 then
		Dialog:Say("��������Ů��������Ӳ����ڸ��������ͳ�ף����");
		return 0;		
	end
	local tbOpt = {};
	for _, pPlayer in ipairs(tbTeamMemberList) do
		if pPlayer.nId ~= me.nId then
			table.insert(tbOpt, {pPlayer.szName, self.SelectFriend, self, it.dwId, pPlayer.nId});
		end
	end
	table.insert(tbOpt, {"��������"});
	Dialog:Say(szMsg, tbOpt);
	return 0;
end

function tbClass:SelectFriend(nItemId, nPlayerId)
	local pMePlayer = me;
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	if not pPlayer or pPlayer.nMapId ~= pMePlayer.nMapId then
		Dialog:Say("�Է����ڸ��������ͳ�ף��");
		return 0;
	end
	
	if pPlayer.nSex ~= Env.SEX_FEMALE then
		Dialog:Say("��Ů�ڲ���ף������Ŷ");
		return 0;
	end
	
	if pPlayer.nLevel < self.DEF_FEMALE_LEVEL then
		Dialog:Say("�Է�û��60�������ܻ��ף�ء�");
		return 0;		
	end
	
	if pMePlayer.GetFriendFavorLevel(pPlayer.szName) < self.DEF_FAVORLEVEL then
		Dialog:Say(string.format("����Է����Ǻ��ѹ�ϵ�����ܶȲ���%s��", self.DEF_FAVORLEVEL));
		return 0;
	end
	
	local nHashNameId = KLib.Number2UInt(tonumber(KLib.String2Id(pPlayer.szName)));
	local nUseTaskId  	= 0;
	local nRUseTaskCount= 0;
	for nId, nTaskId in ipairs(self.TASK_MALE) do
		if tonumber(nTaskId) > 0 then
			if KLib.Number2UInt(EventManager:GetTask(tonumber(nTaskId))) == nHashNameId then
				Dialog:Say("���Ѿ�ף�ع��Է������ף����û�������");
				return 0;
			end
			
			if nUseTaskId == 0 and KLib.Number2UInt(EventManager:GetTask(tonumber(nTaskId))) == 0 then
				nUseTaskId = tonumber(nTaskId);
				nRUseTaskCount = nId;
			end
			
		end
	end
	
	if nUseTaskId == 0 then
		Dialog:Say(string.format("���Ѿ�ף����%s���ˣ������ٽ���ף����", #self.TASK_MALE));
		return 0;
	end
	
	--�жϱ����ռ�
	local nFreeCount = 1;
	if pMePlayer.CountFreeBagCell() < nFreeCount then
		pMePlayer.Msg(string.format("�Բ��������ϵı����ռ䲻�㣬��Ҫ%s�񱳰��ռ䡣", nFreeCount));
		return 0;
	end
	
	local nFreeCount2 = 2;
	if pPlayer.CountFreeBagCell() < nFreeCount2 then
		pMePlayer.Msg(string.format("�Բ��𣬶Է����ϵı����ռ䲻�㣬�޷�����ף������Ҫ%s�񱳰��ռ䡣", nFreeCount2));
		return 0;
	end	
	
	--˫�����轱��
	if (pMePlayer.DelItem(pItem, Player.emKLOSEITEM_USE) ~= 1) then
		return 0;
	end
	
	--�з����
	Setting:SetGlobalObj(pMePlayer);
	
	if self.DEF_MALE_ITEM then
		EventManager.tbFun:ExeAddItem(self.DEF_MALE_ITEM);
	end
	if self.DEF_MALE_BUFF then
		EventManager.tbFun:ExeAddBuffType(self.DEF_MALE_BUFF);
	end
	if nUseTaskId == tonumber(self.TASK_MALE[#self.TASK_MALE]) then
		pMePlayer.AddTitle(6, 4, 2, 0);
		pMePlayer.SetCurTitle(6, 4, 2, 0);			
	end
	Setting:RestoreGlobalObj();
	
	--Ů�����
	Setting:SetGlobalObj(pPlayer);
	
	
	EventManager:SetTask(self.TASK_FEMALE, EventManager:GetTask(self.TASK_FEMALE) + 1);
	local nFeMaleCanGetAward = EventManager:GetTask(self.TASK_FEMALE);
	if self.DEF_TITLE then
		EventManager.tbFun:ExeAddTitle(self.DEF_TITLE);
	end	
	
	if EventManager:GetTask(self.TASK_FEMALE) <= self.DEF_FEMALE_MAX then
		if self.DEF_FEMALE_ITEM then
			EventManager.tbFun:ExeAddItem(self.DEF_FEMALE_ITEM);
		end
		if self.DEF_FEMALE_BUFF then
			EventManager.tbFun:ExeAddBuffType(self.DEF_FEMALE_BUFF);
		end
	end
	
	if EventManager:GetTask(self.TASK_FEMALE) == self.DEF_FEMALE_MAX then
		local nRate = MathRandom(1,100);
		local nSum  = 0;
		for _, tbItem in pairs(self.ITEM_RATE) do
			nSum = nSum + tbItem.nRate;
			if nRate <= nSum then
				local pItem = me.AddItem(unpack(tbItem.tbItem));
				if pItem then
					if tbItem.nBind then
						pItem.Bind(tbItem.nBind)
					end
				end
				break;
			end
		end
		pPlayer.AddTitle(6, 5, 1, 0);
		pPlayer.SetCurTitle(6, 5, 1, 0);	
	end
	
	Setting:RestoreGlobalObj();

	EventManager:SetTask(nUseTaskId, nHashNameId);
	local szMeMsg = string.format("����Ů�ڶ�<color=yellow>%s<color>�ͳ���ף�أ����Ǹ������ĺ�����ѽ��(��ף��%s��)", pPlayer.szName, nRUseTaskCount);
	pMePlayer.Msg(string.format("<color=yellow>%s<color>%s", pMePlayer.szName, szMeMsg));
	pMePlayer.SendMsgToFriend(string.format("<color=yellow>%s<color>%s", pMePlayer.szName, szMeMsg));
	Player:SendMsgToKinOrTong(pMePlayer, szMeMsg, 1);
	
	local szFeMsg = string.format("����Ů�ڻ��<color=yellow>%s<color>��ף�أ������ѱ�ף��10�ζ��������٣����Ҹ���Ȼ˲�併�ٵ�����ͷ�ϣ�(���ܵ�%s��ף��)", pMePlayer.szName, nFeMaleCanGetAward);
	if nFeMaleCanGetAward <= 10 then
		szFeMsg = string.format("����Ů�ڻ��<color=yellow>%s<color>��ף�أ��Ҹ�˲�併�ٵ�����ͷ��(���ܵ�%s��ף��)", pMePlayer.szName, nFeMaleCanGetAward);
	end
	
	pPlayer.Msg(string.format("<color=yellow>%s<color>%s", pPlayer.szName, szFeMsg));
	pPlayer.SendMsgToFriend(string.format("<color=yellow>%s<color>%s", pPlayer.szName, szFeMsg));
	Player:SendMsgToKinOrTong(pPlayer, szFeMsg, 1);	
end
