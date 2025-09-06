--���䱬��
--�����
--2008.12.31

local tbItem = Item:GetClass("jinzhoubaozhu");
tbItem.nCDTime = 10 * 60 	--cdʱ��30����
tbItem.nSkillId = 1123;		--ʹ�ü���Id

function tbItem:InitGenInfo()
	-- �趨��Ч����
	it.SetTimeOut(0, (GetTime() + 24 * 3600));
	return	{ };
end

function tbItem:OnUse()
	local nCurTime = GetTime();
	local nYear = it.GetGenInfo(1);
	local nTime = it.GetGenInfo(2);
	if nYear > 0 then
		local nCurDate 	= tonumber(os.date("%Y%m%d%H%M%S", nCurTime));
		local nCanDate = (nYear* 1000000 + nTime)
		local nSec1 = Lib:GetDate2Time(nCurDate);
		local nSec2 = Lib:GetDate2Time(nCanDate) + self.nCDTime;
		if nSec1 < nSec2 then
			me.Msg(string.format("������䱬����ʹ�ù���������Ҫ�ȴ�<color=yellow>%s<color>������ٴ�ʹ�á�", Lib:TimeFullDesc(nSec2 - nSec1)));
			return 0;
		end
	end
	if me.nFightState == 0 then
		me.Msg("������Ұ���ͼ����ʹ�á�");
		return 0;
	end
	me.CastSkill(self.nSkillId, 2, -1, me.GetNpc().nIndex);
	local nYearDate = tonumber(os.date("%Y%m%d", nCurTime));
	local nTimeDate = tonumber(os.date("%H%M%S", nCurTime));
	it.SetGenInfo(1,nYearDate);
	it.SetGenInfo(2,nTimeDate);
	Dialog:SendBlackBoardMsgTeam(me, "����ž��һ�����죬���������޻ᱻ�Ż��ģ� ", 1)
	return 0;
end
