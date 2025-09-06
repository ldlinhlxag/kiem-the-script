--����������
--sunduoliang
--2008.12.31

local tbItem = Item:GetClass("yinhunwu");	--������
local tbNpc  = Npc:GetClass("nianshou_callboss");	--����

tbItem.tbMsg = {
	"����˰��죬ѹ����û����ʲôҰ�޵�Ӱ�ӣ�����һ�ο����ɣ�",
	"����˵��Ұ�޽ƻ���Ҫ�����Ĳ��У��Ⱦ����������Կ���",
	"���¹��ڼ�֣��ҾͲ�������ﲻ������",
	"�����ճ�����Ҳ������������ô�ѣ�������ô��ѵ������",
} 
tbItem.nDelay = 5 * Env.GAME_FPS;	--��ʱ
tbItem.nNpcId = 3618;				--����Id
tbItem.nNpcLiveTime = 60 * 60 * Env.GAME_FPS		--��������ʱ��

function tbItem:InitGenInfo()
	-- �趨��Ч����
	local nSecTime = Lib:GetDate2Time(Esport.SNOWFIGHT_STATE[3])
	it.SetTimeOut(0, nSecTime);
	return	{ };
end

-- ����¼�
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
	if me.nFightState == 0 then
		me.Msg("������Ұ���ͼ����ʹ�á�");
		return 0;
	end	
	if me.CountFreeBagCell() < 4 then
		local szAnnouce = "���ı����ռ䲻�㣬������4��ռ����ԡ�";
		me.Msg(szAnnouce);
		return 0;
	end	
	GeneralProcess:StartProcess("����������...", self.nDelay, {self.DoCallBoss, self, me.nId, it.dwId}, nil, tbEvent);
end

function tbItem:DoCallBoss(nPlayerId, nItemId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local pItem   = KItem.GetObjById(nItemId);
	if not pPlayer or not pItem then
		return 0;
	end
	if MathRandom(1,100) > 25 then
		local nCount = pItem.GetGenInfo(1);
		if nCount > 2 then
			nCount = 2;
		else
			pItem.SetGenInfo(1, nCount + 1);
		end
		
		pPlayer.Msg(self.tbMsg[nCount + 1]);
		return 0;
	end
	pPlayer.Msg(self.tbMsg[4]);
	local nMapId, nPosX, nPosY = pPlayer.GetWorldPos();
	if pPlayer.DelItem(pItem) == 1 then
		local pNpc = KNpc.Add2(self.nNpcId, pPlayer.nLevel, -1, nMapId, nPosX, nPosY);
		if pNpc then
			pNpc.SetLiveTime(self.nNpcLiveTime);
			pNpc.GetTempTable("Npc").nTimerId = Timer:Register(self.nNpcLiveTime, self.OnNpcTimeOut, self, pPlayer.nId, pNpc.dwId);
			Dialog:SendBlackBoardMsgTeam(pPlayer, "���ޣ����������黤�壬������ЩС���������Һ�", 1)
			for i=1, 4 do
				self:GetRandomItem(pPlayer);
			end
		end
	end
end

function tbItem:GetRandomItem(pPlayer)
	local nRateSum = 0;
	local nRate = MathRandom(1, 1000000);
	for _,tbItem in pairs(self.tbRandItemList) do
		nRateSum = nRateSum + tbItem.nRandRate;
		if nRate <= nRateSum then
			local pItem = pPlayer.AddItem(tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel);
			if pItem then
				Dbg:WriteLog("������",  pPlayer.szName, string.format("��������Ʒһ��%s", pItem.szName));
			end
			return 0;
		end
	end
end

function tbItem:OnNpcTimeOut(nPlayerId, nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	
	if pNpc then
		pNpc.Delete();
	end
	
	if pPlayer then
		pPlayer.Msg("���ޣ��йŹ֣�С�������ѵ�Ҫ�����ң���������ˣ�ˣ�(���ٻ���������ʧ�ˣ�)");		
	end
	return 0;
end

function tbItem:LoadRandomItem()
	local tbSortItem = Lib:LoadTabFile("\\setting\\event\\manager\\2009_event\\springfestival\\droprate001_nianshou.txt");
	if not tbSortItem then
		return 0;
	end
	self.tbRandItemList = {};
	for nId, tbItem in pairs(tbSortItem) do
		self.tbRandItemList[nId] = {};
		self.tbRandItemList[nId].nGenre = tonumber(tbItem.Genre) or 0;
		self.tbRandItemList[nId].nDetail = tonumber(tbItem.Detail) or 0;
		self.tbRandItemList[nId].nParticular = tonumber(tbItem.Particular) or 0;
		self.tbRandItemList[nId].nLevel = tonumber(tbItem.Level) or 0;
		self.tbRandItemList[nId].nRandRate = tonumber(tbItem.RandRate) or 0;
		self.tbRandItemList[nId].szName = tbItem.Name;
	end
end

tbItem:LoadRandomItem()

function tbNpc:OnDeath(pNpcKiller)
	if him.GetTempTable("Npc").nTimerId then
		Timer:Close(him.GetTempTable("Npc").nTimerId);
	end
	local pPlayer = pNpcKiller.GetPlayer();
	if pPlayer then
		Dialog:SendBlackBoardMsgTeam(pPlayer, "���ޣ���~~~����~~~���Ǹ㰵�㣬�������ӡ�", 1)
	end
end

