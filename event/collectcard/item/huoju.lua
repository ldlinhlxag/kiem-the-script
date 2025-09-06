Require("\\script\\event\\collectcard\\define.lua")

local tbItem = Item:GetClass("collect_huoju");
local CollectCard = SpecialEvent.CollectCard;
local tbAward = 
{
	[4] = 200,
	[3] = 40,
	[2] = 20,
	[1] = 15,
}

function tbItem:OnUse()
	self:OnUseSure(it.dwId)
	return 0;
end

function tbItem:OnUseSure(nItemId, nFlag)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 1;
	end
	if nFlag ~= 1 then
		local tbOpt = {
			{"�鿴������ϸ����", self.OpenHelp, self},
			{string.format("ʹ�ò����%s�����ֻ���",tbAward[pItem.nLevel]), self.OnUseSure, self, nItemId, 1},
			{"�˳�"},
		}
		Dialog:Say("ʹ�ú��û���ֻ��֣����ֿɶһ��߶���������ͻ�����<color=yellow>������<color>�ɲ�ѯ", tbOpt);
		return 1;
	end
	
	local nData = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	
	if nData < CollectCard.TIME_STATE[3] then
		Dialog:Say([[<enter>  ��<color=yellow>8��28�յ�8��31��<color>�����������ѡ�ٽ�����Ƚ��У��뱣����棬���ڻ�ڼ�ʹ�á�]]);
		return 1;
	end
	local nPoint = tbAward[pItem.nLevel];
	if me.DelItem(pItem, Player.emKLOSEITEM_TYPE_EVENTUSED) ~= 1 then
		CollectCard:WriteLog("ɾ�����ʧ��", me.nId);
		return 1;
	end	
	me.SetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_HUOJU_POINT, me.GetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_HUOJU_POINT) + nPoint);
	local nMePoint =  me.GetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_HUOJU_POINT);
	
	GCExcute({"SpecialEvent.CollectCard:AddRank_GC", me.szName, nMePoint});
	if nData < CollectCard.TIME_STATE[4] then
		Dialog:Say(string.format("�����<color=yellow>%s��<color>�����֣���ϸ�����鿴<color=yellow>������<color>���ѡ��", nPoint));
	end
	CollectCard:WriteLog(string.format("ʹ��ʢ�Ļ�棬�����%s�����, ������ܷ֣�%s", nPoint, nMePoint), me.nId);
	return 1;
end

function tbItem:OpenHelp()
	--�򿪰�������
	me.CallClientScript({"UiManager:OpenWindow", "UI_HELPSPRITE"});
	return 1;
end
