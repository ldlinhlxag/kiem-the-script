Require("\\script\\event\\collectcard\\define.lua")

local tbItem = Item:GetClass("collect_baoxiang");
local CollectCard = SpecialEvent.CollectCard;
local tbAward = 
{
	[4] = 1,	--�ƽ���
	[3] = 2,	--��������
	[2] = 3,	--��ͭ����
	[1] = 4,	--��������
}

function tbItem:OnUse()
	local nData = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	
	if nData < CollectCard.TIME_STATE[2] then
		Dialog:Say("���δ������");
		return 0;
	end		
	if me.CountFreeBagCell() < 2 then
		me.Msg("�������ռ䲻�㡣������2�񱳰��ռ䡣");
		return 0;
	end
	
	if it.nLevel == 4 then
		me.AddWaitGetItemNum(1);
		GCExcute({"SpecialEvent.CollectCard:GetAward_GC", me.nId});
		return 1;
	end
	if tbAward[it.nLevel] then
		CollectCard:GetAward_BaoXiang(me, tbAward[it.nLevel])
	end
	return 1;
end
