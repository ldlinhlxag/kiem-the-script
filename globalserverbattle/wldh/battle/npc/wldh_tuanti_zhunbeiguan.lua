-------------------------------------------------------
-- �ļ�������wldh_tuanti_zhunbeiguan.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-09-02 16:24:35
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle_def.lua");

local tbNpc	= Npc:GetClass("wldh_tuanti_zhunbeiguan");

function tbNpc:Init()

	if self.tbMapNpc then	
		return;
	end

	-- get npc by mapid
	local tbMapNpc	= {};	
	for nBattleIndex, nMapId in pairs(Wldh.Battle.MAPID_SIGNUP) do
		tbMapNpc[nMapId]= Lib:NewClass(Wldh.Battle.tbNpcBase, nMapId, nBattleIndex);
	end
	
	self.tbMapNpc = tbMapNpc;
end

function tbNpc:OnDialog()
	local tbNpc	= self.tbMapNpc[him.nMapId];
	tbNpc:OnDialog();
end

-- base
local tbNpcBase	= Wldh.Battle.tbNpcBase or {};
Wldh.Battle.tbNpcBase = tbNpcBase;

-- init
function tbNpcBase:init(nMapId, nBattleIndex)
	self.nMapId	= nMapId;
	self.nBattleIndex = nBattleIndex;
end

-- ���µ���Ӧ��mission
function tbNpcBase:Refresh()
	
	local tbMission	= Wldh.Battle:GetMission(self.nBattleIndex);
	
	if tbMission then
		self.tbMission = tbMission;
		self.tbCamp = {tbMission.tbCamps[1], tbMission.tbCamps[2]};
	else
		self.tbMission	= nil;
		self.tbCamp = nil;
	end
end

function tbNpcBase:OnDialog()
	
	self:Refresh();
	
	if not self.tbMission then
		Dialog:Say("������δ��ʱ�䣬���һ�����", {{"����Ӣ�۵�", self.OnLeaveHere, self}, {"��֪����"}});
		return;
	end

	local tbOpt = 
	{
		{"��Ҫ���������", self.OnSingleJoin, self},
		{"��Ҫ����Ӣ�۵�", self.OnLeaveHere, self},
		{"���ٿ���һ��"},
	};
	
	Dialog:Say("��ã����������ִ��������׼�������ҿ��԰��������������أ����߷���Ӣ�۵���", tbOpt);
end

function tbNpcBase:OnLeaveHere()
	
	local nGateWay = Transfer:GetTransferGateway();
	local nMapId = Wldh.Battle.tbLeagueName[nGateWay][2];
	
	if nMapId then
		me.NewWorld(nMapId, 1648, 3377);
	end
end

-- �ж�����Ƿ���Ȩ����
function tbNpcBase:CheckPlayer(pPlayer, nCampId)
		
	-- �ж��Ƿ���ս��
	local szLeagueName = League:GetMemberLeague(Wldh.Battle.MATCH_TYPE, pPlayer.szName);
	if not szLeagueName then
		Dialog:Say("�㻹û��ս�ӣ����ܼ��롣");
		return 0;	
	end
	
	-- �ж��Ƿ��ܼ����mission�ĸ���Ӫ
	for i = 1, 2 do
		if szLeagueName == self.tbMission.tbLeagueName[i] then
			if Wldh.Battle.BTPLNUM_HIGHBOUND <= self.tbCamp[i]:GetPlayerCount() then
				Dialog:Say("�÷���ս�����Ѵﵽ���ޣ������ټ����ˡ�");
				return 0;
			end
			return 1, i; 
		end
	end

	Dialog:Say("�����ڵ�ս��û���ʸ�μӸó�������");
	return 0;
end

-- ����ս��
function tbNpcBase:OnSingleJoin()
	
	self:Refresh();
	
	local bOk, nCampId = self:CheckPlayer(me);
	if bOk == 0 then
		return;
	end
		
	self:DoSingleJoin(me, nCampId);
end

-- ִ����������ս������
function tbNpcBase:DoSingleJoin(pPlayer, nCampId)
		
	-- ��δ��뿴�űȽϲ�ˬ���Ȳ�����
	if not self.tbMission then
		Dialog:Say("�������ˣ��Բ����´������ɡ�");
		return;
	
	-- ս�ֿ�ʼ
	elseif self.tbMission.nState == 2 then 
		pPlayer.Msg("�����Ѿ���ʼ�ˣ����ȥ�ɡ�");
	
	-- ս�ֻ�û��ʼ
	else
		Dialog:Say("���ں�Ӫ�Ե�Ƭ�̣��������ϾͿ�ʼ�ˡ�");
	end
	
	-- ս�ֿ�ʼ��ż�¼�����Ӫ,ս��key,�ڼ�������
	if self.tbMission.nState == 2 then 
		pPlayer.SetTask(Wldh.Battle.TASK_GROUP_ID, Wldh.Battle.TASKID_PLAYER_KEY, self.tbMission.nBattleKey);
		pPlayer.SetTask(Wldh.Battle.TASK_GROUP_ID, Wldh.Battle.TASKID_CAMP, nCampId);
		pPlayer.SetTask(Wldh.Battle.TASK_GROUP_ID, Wldh.Battle.TASKID_INDEX, self.nBattleIndex);
	end
	
	self.tbMission:JoinPlayer(pPlayer, nCampId);
end

-- ��ʼ��
tbNpc:Init();
