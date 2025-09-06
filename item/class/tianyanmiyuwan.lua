------------------------------------------------------
-- �ļ�������tianyanmiyuwan.lua
-- �����ߡ���dengyong
-- ����ʱ�䣺2009-12-07 11:35:10
-- ��  ��  �����������裬����˵��NPC��Ϊ�Լ���ͬ��
------------------------------------------------------

local tbItem = Item:GetClass("tianyanmiyuwan");

tbItem.nProcessTime 			  = 15;		-- ʹ�õ��߹����У���Ҫ����15��
tbItem.nPersuadeSkillId          = 1526;	-- ˵��״̬�����
tbItem.nBePersuadeSkillId 		  = 1527;	-- ��˵��״̬��

-- ����Ӧ��Ϊѡ��NPC��ID
function tbItem:OnUse(nParam)
	if (Partner.bOpenPartner ~= 1) then
		Dialog:Say("����ͬ���Ѿ��رգ��޷�ʹ�ÿ�Ƭ");
		return 0;
	end
	
	local dwId = nParam;
	local pNpc = KNpc.GetById(dwId);
	
	if dwId == 0 or not pNpc then
		me.Msg("��ѡ��һ��NPC����ʹ�øõ��ߣ�");
		return 0;
	end

	-- �Ƿ�����˵��������
	local nRes, varMsg = Partner:TryToPersuade(me, pNpc, it.nLevel);
	if nRes == 0 then
		me.Msg(varMsg);		-- ����˵�������ش�����Ϣ
		Partner:SendClientMsg(varMsg);
		return 0;
	end
	
	-- ����˵���ˣ���������
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
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
	}
	

	-- ����Ҫ����Һ�NPC�������״̬���������ڶ���������
	if not me.GetTempTable("Partner").nPersuadeRefCount then
		me.GetTempTable("Partner").nPersuadeRefCount = 0;
	end
	me.GetTempTable("Partner").nPersuadeRefCount = me.GetTempTable("Partner").nPersuadeRefCount + 1;
	
	me.AddSkillState(self.nPersuadeSkillId, 1, 1, self.nProcessTime * Env.GAME_FPS);
	
	local nCount = pNpc.GetTempTable("Partner").nPersuadeRefCount or 0;
	if nCount <= 0 then
		pNpc.AddTaskState(self.nBePersuadeSkillId);
		nCount = 0;
	end
	
	pNpc.GetTempTable("Partner").nPersuadeRefCount = nCount + 1;	
	
	GeneralProcess:StartProcess("Đang Thu Phục", self.nProcessTime * Env.GAME_FPS, 
		{Partner.CreatePartner, Partner, me.nId, dwId, it.dwId}, 
		{self.OnBreak, self, me.nId, pNpc.dwId}, 
		tbEvent);
	
	return 0;
end 

-- �ӿͻ��˵õ�ѡ���е�NPC���󣬲���ID���ظ�������
-- ���û��ѡ��NPC���󣬷���0
function tbItem:OnClientUse()
	local pSelectNpc = me.GetSelectNpc();
	if not pSelectNpc then
		return 0;
	end

	return pSelectNpc.dwId;
end

-- ����Ϻ�ȥ������״̬
function tbItem:OnBreak(nPlayerId, nNpcId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local pNpc = KNpc.GetById(nNpcId);
	
	if pPlayer and pPlayer.GetTempTable("Partner").nPersuadeRefCount <= 1 then
		pPlayer.RemoveSkillState(self.nPersuadeSkillId);
		pPlayer.GetTempTable("Partner").nPersuadeRefCount = 0;
	else
		pPlayer.GetTempTable("Partner").nPersuadeRefCount = pPlayer.GetTempTable("Partner").nPersuadeRefCount - 1;
	end	
	
	if not pNpc or not pNpc.GetTempTable("Partner").nPersuadeRefCount then
		return;
	end
		
	pNpc.GetTempTable("Partner").nPersuadeRefCount = pNpc.GetTempTable("Partner").nPersuadeRefCount - 1;
	if pNpc.GetTempTable("Partner").nPersuadeRefCount <= 0 then
		pNpc.RemoveTaskState(self.nBePersuadeSkillId);
	end

end