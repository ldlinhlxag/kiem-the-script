-------------------------------------------------------
-- �ļ�������wldh_tuanti_chefu.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-09-02 16:22:19
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle_def.lua");

local tbNpc = Npc:GetClass("wldh_tuanti_chefu");

function tbNpc:OnDialog()
	
	local tbOpt	= 	
	{
		{"�����뿪����", self.OnLeaveSay, self},
		{"���ٿ��ǿ���"},
	};

	local szMsg	= "��ã��ҿ��Դ����뿪���";
	Dialog:Say(szMsg, tbOpt);
end

-- �뿪
function tbNpc:OnLeaveSay()
	
	local tbOpt = 
	{
		{"ȷ��", self.OnLeave, self},
		{"���ٿ��ǿ���"},
	};
	
	Dialog:Say("��ȷ��Ҫ���ر������� ", tbOpt);
end

function tbNpc:OnLeave()
	
	local pPlayer = me;
	if 1 == pPlayer.nFightState then
		return;
	end
	
	local tbMission	= Wldh.Battle:GetMissionByMapId(him.nMapId);
	
	if tbMission then
		tbMission:KickPlayer(pPlayer);
	else
		self:ProcessError(pPlayer);
	end
end

function tbNpc:ProcessError(pPlayer)
	
	local nBattleIndex = pPlayer.GetTask(Wldh.Battle.TASK_GROUP_ID, Wldh.Battle.TASKID_INDEX);
	
	if 0 == nBattleIndex then
		nBattleIndex = 1;
	end
	
	local nMapId = Wldh.Battle.MAPID_SIGNUP[nBattleIndex];
	local nIndex = math.floor(MathRandom(#Wldh.Battle.POS_SIGNUP));

	pPlayer.NewWorld(nMapId, unpack(Wldh.Battle.POS_SIGNUP[nIndex]));
	pPlayer.SetFightState(0);
end
