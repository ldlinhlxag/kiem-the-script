-- �ļ�������taoyuanrukou.lua
-- �����ߡ���xiewen
-- ����ʱ�䣺2008-12-10 19:27:37


-------------- �����ض���ͼ�ص� ---------------
local tbMap = Map:GetClass(1497); -- ��ͼId
local tbDeathEventId = {};
local tbPrisonMap = {1497, 1498, 1499, 1500, 1501, 1502, 1503}
local nCurrentPrisonId = nil;

-- ������ҽ����¼�
function tbMap:OnEnter(szParam)
	me.Msg("��ӭ������Դ��ڡ�");	
	self:RegisterDeathHandler();	
	--BlackSky:SimpleTalk(me, "��ӭ����������������عؿ���ڣ�ֻҪ����������Դ��������Ϳ��Կ���ͨ����Դ����ڣ��������ı��ء�");
end;

-- ��������뿪�¼�
function tbMap:OnLeave(szParam)
	self:UnRegisterDeathHandler();
	if Player:CanLeaveTaoyuan(me) == 0 then
		me.Msg("���뿪����Դ��ڣ�");
	end
	--BlackSky:GiveMeBright(me)
end

function tbMap:RegisterDeathHandler()
	if not tbDeathEventId[me.nId] then
		tbDeathEventId[me.nId] = PlayerEvent:Register("OnDeath", self.OnDeathRevive, self);
	end
end

function tbMap:UnRegisterDeathHandler()
	if tbDeathEventId[me.nId] then
		PlayerEvent:UnRegister("OnDeath", tbDeathEventId[me.nId]);
		tbDeathEventId[me.nId] = nil;
	end
end

function tbMap:OnDeathRevive()
	if me.nMapId == nCurrentPrisonId then
		-- ����ԭ�ظ���
		me.ReviveImmediately(1);
		me.NewWorld(nCurrentPrisonId, 1628, 3200);
	end
end

function tbMap:Init()
	for i, nMapId in pairs(tbPrisonMap) do
		if IsMapLoaded(nMapId) == 1 then
			nCurrentPrisonId = nMapId;
			break;
		end
	end	
end

function tbMap:OnPlayerLogin(bExchangeServer)
	if bExchangeServer == 1 then
		return
	end
	if me.GetArrestTime() == 0 then
		if me.nMapId == nCurrentPrisonId then
			Timer:Register(Env.GAME_FPS * 2, self.OnReleasePlayer, self, me.nId) -- ��֤���ͽ���������
		end
		return
	end
	me.NewWorld(nCurrentPrisonId, 1628, 3200)
	if me.nMapId ~= nCurrentPrisonId then
		print("[taoyuanrukou]	ץ������ʧ�ܣ��߳����["..me.szName.."]��")
		me.KickOut()
		return
	end
	local nJailTerm = me.GetJailTerm()
	if nJailTerm > 0 then
		local nTimeRemain = nJailTerm + me.GetArrestTime() - GetTime()
		if nTimeRemain <= 0 then
			nTimeRemain = 2; -- ��֤���ͽ���������
		end
		Timer:Register(Env.GAME_FPS * nTimeRemain, self.OnReleasePlayer, self, me.nId)
	end
end

-- ��ʱ�ͷ����
function tbMap:OnReleasePlayer(nId)
	local pPlayer = KPlayer.GetPlayerObjById(nId);
	if not pPlayer or pPlayer.nMapId ~= nCurrentPrisonId then
		return 0;
	end
	if Player:CanLeaveTaoyuan(pPlayer) == 1 then
		Player:SetFree(pPlayer);
	else
		pPlayer.Msg("˭��׼������ģ��ԹԻ�ȥ���á�");
		return;
	end
	
	return 0;
end

for _, nMapId in pairs(tbPrisonMap) do
	local tbDestMap = Map:GetClass(nMapId);
	for szFnc in pairs(tbMap) do			-- ���ƺ���
		tbDestMap[szFnc] = tbMap[szFnc];
	end
end

ServerEvent:RegisterServerStartFunc(tbMap.Init, tbMap);
PlayerEvent:RegisterGlobal("OnLogin", tbMap.OnPlayerLogin, tbMap);
