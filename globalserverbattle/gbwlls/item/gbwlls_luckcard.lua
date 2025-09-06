-- ����������˿�

local tbItem = Item:GetClass("gbwlls_luckycard");

function tbItem:OnUse()
	Dialog:Say("����������˿��Ŀ���ʱ����<color=yellow>����22�������15����ǰ<color>����Ҫ����˿���ʱ��Ӵ����ȷ������", {
			{"ȷ��", self.OnSureOpenCard, self, it.dwId},
			{"���ǿ���"},
		});
	return 0;
end

function tbItem:OnSureOpenCard(nItemId)
	local pItem = KItem.GetObjById(nItemId);	
	if not pItem then
		return 1;
	end
	
	local nGetTime = pItem.GetGenInfo(1);
	if (GbWlls:ServerIsCanJoinGbWlls() == 0) then
		Dialog:Say("���������δ�����޷�������������˿���");
		return 0;
	end
	
	local nGblSession = GbWlls:GetGblWllsOpenState();
	if (nGblSession <= 0) then
		Dialog:Say("���������δ�����޷�������������˿���");
		return 0;
	end
	
	local nTime			= GetTime();
	local tbTime		= os.date("*t", nTime);
	local nNowDay		= Lib:GetLocalDay(nTime);
	local nCardGetDay	= Lib:GetLocalDay(nGetTime);

	if (GbWlls:CheckOpenMonth(nTime) == 0) then
		Dialog:Say("�����ڿ������ʱ��Σ��޷�������������˿���");
		return 0;
	end

	local nState = GbWlls:GetGblWllsState();

	if (nNowDay == nCardGetDay) then
		if (tbTime.hour < GbWlls.DEF_NOT_OPEN_LUCKCARD_TIME_END) then
			Dialog:Say(string.format("���ſ�Ƭ�ǽ�����ģ�ֻ���ڽ���%s�����ܴ򿪣�", GbWlls.DEF_NOT_OPEN_LUCKCARD_TIME_END));
			return 0;
		end
	end
	
	if (tbTime.hour >= GbWlls.DEF_NOT_OPEN_LUCKCARD_TIME_START and tbTime.hour < GbWlls.DEF_NOT_OPEN_LUCKCARD_TIME_END) then
		Dialog:Say(string.format("��ÿ���%s�㵽%s��֮�����޷��������˿��ģ�", GbWlls.DEF_NOT_OPEN_LUCKCARD_TIME_START, GbWlls.DEF_NOT_OPEN_LUCKCARD_TIME_END));
		return 0;
	end

	if me.CountFreeBagCell() < 2 then
		Dialog:Say(string.format("���ı����ռ䲻��,������%s�񱳰��ռ䡣", 2));
		return 0;
	end
	GbWlls:GiveLuckCardAward(me, nGetTime);	

	if (me.DelItem(pItem, Player.emKLOSEITEM_USE) ~= 1) then
		return 0;
	end
	return 1;
end
