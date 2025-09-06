Require("\\script\\event\\collectcard\\define.lua")
-- δ�����Ŀ�Ƭ
local tbItem = Item:GetClass("guoqing_card_unknown");
local CollectCard = SpecialEvent.CollectCard;
local DELAY_TIME = 3; --����30��
local tbEvent = 
{
	Player.ProcessBreakEvent.emEVENT_MOVE,
	Player.ProcessBreakEvent.emEVENT_ATTACK,
	Player.ProcessBreakEvent.emEVENT_SITE,
	Player.ProcessBreakEvent.emEVENT_USEITEM,
	Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
	Player.ProcessBreakEvent.emEVENT_DROPITEM,
	Player.ProcessBreakEvent.emEVENT_SENDMAIL,
	Player.ProcessBreakEvent.emEVENT_TRADE,
	Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
	Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
	Player.ProcessBreakEvent.emEVENT_LOGOUT,
	Player.ProcessBreakEvent.emEVENT_DEATH,
}

function tbItem:OnUse()
	local szMsg = "�������������Բ������Ҫ����<color=gold>�����300<color>�����Ǽ������Ŀ�Ƭ�����ղز�ʱҲ�ܻ������Ľ�����ȷ��������";
	local tbOpt = {
		{"����", self.OnUseSure, self, it.dwId},
		{"��������"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:OnUseSure(dwId)
	local pItem = KItem.GetObjById(dwId);
	if (not pItem) then
		return;
	end
	
	local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	
	if nDate < CollectCard.TIME_STATE[1] then
		Dialog:Say("�������Բ���ռ���δ��ʼ��");
		return 0;
	end
	
	if nDate >= CollectCard.TIME_STATE[2] then
		Dialog:Say("�������Բ���ռ���Ѿ�������");
		return 0;
	end
	local nCanSkill = 0;
	for nSkillId = 1, 5 do
		if LifeSkill:GetSkillLevel(me, nSkillId) >= 60 then
			nCanSkill = 1;
			break;
		end
	end
	if nCanSkill == 0 then
		Dialog:Say("��һ�ӹ�ϵ����ܴﵽ60��������һ����ϵ���ܴﵽ60������������ͬʱ��������ʸ������Ƭ��");
		return 0;
	end
	nCanSkill= 0;
	for nSkillId = 6, 10 do
		if LifeSkill:GetSkillLevel(me, nSkillId) >= 60 then
			nCanSkill = 1;
			break;
		end
	end	
	if nCanSkill == 0 then
		Dialog:Say("��һ�ӹ�ϵ����ܴﵽ60��������һ����ϵ���ܴﵽ60������������ͬʱ��������ʸ������Ƭ��");
		return 0;
	end
	
	if me.dwCurGTP < 300 or me.dwCurMKP < 300 then
		Dialog:Say("�����������Բ����Ҫ������������300������񲻹�Ŷ��");
		return 0;
	end	
	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("������Ƭ��Ҫ1�񱳰��ռ䣬������������");
		return 0;
	end
	
	local nDate = tonumber(GetLocalDate("%y%m%d"));
	if me.GetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_DATE_ID) < nDate then
		me.SetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_DATE_ID, nDate);
		me.SetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_COUNT_ID, 0);
	end
	
	local nExtra = 0;
	local tbTime = {91001, 91010};
	
	if nDate == tbTime[2] and me.GetTask(2093, 13) >= 120 then
		nExtra = 100;
	elseif nDate >= tbTime[1] and nDate <= tbTime[2] and me.GetTask(2093, 13) >= 60 then
		nExtra = 4;
	end

	if me.GetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_COUNT_ID) >= CollectCard.CARD_DATA_LIMIT_MAX + nExtra then
		me.Msg(string.format("�������Ѽ�����%s���������Բ����̫���ˡ������ٳ��԰ɡ�",CollectCard.CARD_DATA_LIMIT_MAX + nExtra));
		return 0;
	end
	
	if me.GetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_COLLECT_COUNT) >= CollectCard.CARD_LIMIT_MAX then
		me.Msg(string.format("���ܹ��Ѿ�������%s���������Բ���������ټ����ˡ�",CollectCard.CARD_LIMIT_MAX));
		pItem.Delete(me);
		return 1;
	end
	
	GeneralProcess:StartProcess("��Ƭ������...", DELAY_TIME * Env.GAME_FPS, {self.GetCard, self, me.nId, pItem.dwId}, nil, tbEvent);
	return 0;
end

function tbItem:GetCard(nPlayerId, nItemId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if (not pPlayer) then
		return;
	end	
	local pItem = KItem.GetObjById(nItemId);
	if (not pItem) then
		return;
	end
	
	me.ChangeCurMakePoint(-300);
	me.ChangeCurGatherPoint(-300);
	
	local nDate = tonumber(GetLocalDate("%y%m%d"));
	if pPlayer.GetTask(CollectCard.TASK_GROUP_ID,CollectCard.TASK_DATE_ID) < nDate then
		pPlayer.SetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_DATE_ID, nDate);
		pPlayer.SetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_COUNT_ID, 0);
	end
	
	local nExtra = 0;
	local tbTime = {91001, 91010};
	
	if nDate == tbTime[2] and me.GetTask(2093, 13) >= 120 then
		nExtra = 100;
	elseif nDate >= tbTime[1] and nDate <= tbTime[2] and me.GetTask(2093, 13) >= 60 then
		nExtra = 4;
	end
	
	if me.GetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_COUNT_ID) >= CollectCard.CARD_DATA_LIMIT_MAX + nExtra then
		return 0;
	end
	
	if me.GetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_COLLECT_COUNT) >= CollectCard.CARD_LIMIT_MAX then
		return 0;
	end
	
	pPlayer.DelItem(pItem, Player.emKLOSEITEM_TYPE_EVENTUSED);
	pPlayer.SetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_COUNT_ID, pPlayer.GetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_COUNT_ID) + 1);	
	pPlayer.SetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_COLLECT_COUNT, pPlayer.GetTask(CollectCard.TASK_GROUP_ID, CollectCard.TASK_COLLECT_COUNT) + 1);
	
	local nRandomItemId = MathRandom(CollectCard.CARD_START_ID, CollectCard.CARD_END_ID + 1)
	-- 1/30�õ�濾꿨
	if nRandomItemId == CollectCard.CARD_END_ID + 1 then
		local nP = MathRandom(1, 30);
		if nP == 1 then
			nRandomItemId = MathRandom(CollectCard.CARD_START_ID, CollectCard.CARD_END_ID);
		end
	end
	local pItemCard = me.AddItem(18, 1, nRandomItemId, 1);
	if pItemCard then
		pItemCard.Bind(1);
		local szDate = GetLocalDate("%Y/%m/%d/24/00/00");
		pPlayer.SetItemTimeout(pItemCard, szDate);
		me.Msg(string.format("�ɹ�������һ���������Բ���������һ��<color=yellow>%s<color>��",pItemCard.szName));
		CollectCard:WriteLog(string.format("�ɹ�������һ���������Բ���������һ��%s", pItemCard.szName), me.nId);
	end
	
end

function tbItem:InitGenInfo()
	it.SetTimeOut(0, GetTime() + 72*3600);
	return {};
end
