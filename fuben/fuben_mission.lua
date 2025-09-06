-- �ļ�������fuben_mission.lua
-- �����ߡ���zounan
-- ����ʱ�䣺2009-12-17 09:43:45
-- ��  ��  ������MISSION
Require("\\script\\mission\\lockmis_base.lua");



CFuben.FubenMission	= CFuben.FubenMission or Lib:NewClass(Mission.LockMis);
local BaseGame = CFuben.FubenMission;

-- Khởi tạo 
function BaseGame:InitGameEx(nMapId, nPlayerId, nFubenId)
	self:InitGame(nMapId);
	self.nPlayerId = nPlayerId;
	self.nFubenId = nFubenId;
	self.tbMisCfg = 
	{
		nDeathPunish   = 1,
		nPkState       = Player.emKPK_STATE_PRACTISE,
--		nOnDeath 	   = 1,        -- Có thể chết
--		nOnKillNpc 	   = 1,        -- NPC chết 		
		nFightState	   = 1,
		nForbidStall   = 1,        -- Vật phẩm cấm
	};		
	self.tbLockMisCfg = CFuben.tbLockMis[nFubenId].tbLockMisCfg;	
	self.tbMisCfg.nOnDeath = self.tbLockMisCfg.nOnDeath or 0;	
end

--Đọc các tập tin cấu hình
--[[
function BaseGame:LoadMisFile(szPath)
--	local tbLockMisCfg = self:LoadMisFile(szPath);
--	self.tbLockMisCfg = tbLockMisCfg;	
--	self.tbLockMisCfg = CFuben.tbLockMisFile:LoadMisFile(szPath);
end
--]]

--Callback
function BaseGame:OnLockMisJoin(nGroupId)
end

function BaseGame:OnLockMisLeave(nGroupId, szReason)
	local nMapId = CFuben.FubenData[self.nPlayerId][3];
	local nPosX = CFuben.FubenData[self.nPlayerId][6];
	local nPosY = CFuben.FubenData[self.nPlayerId][7];
	me.NewWorld(nMapId, nPosX, nPosY);
	CFuben:OnLeave(self.nPlayerId);
--	if self.nPlayerCount <= 0 and self.nIsGameOver ~= 1 then
--		self:GameLose();
--	end
end


--Gọi lại cái chết của nhân vật
function BaseGame:OnDeath(pKillerNpc) 
	if not self.tbLockMisCfg.tbNpcPoint["playerbirth"] then
		print("NO BIRTH");
		return;
	end
	local nRandom = #self.tbLockMisCfg.tbNpcPoint["playerbirth"];
	local nX = self.tbLockMisCfg.tbNpcPoint["playerbirth"][nRandom][1];
	local nY = self.tbLockMisCfg.tbNpcPoint["playerbirth"][nRandom][2];	
	me.SetTmpDeathPos(self.nMapId, nX, nY);
	me.ReviveImmediately(0);
	me.SetFightState(1);
	--self:KickPlayer(me);
end

function BaseGame:OnGameClose()	
	--Đóng một phó bản 
	local nTempMapId = CFuben.FubenData[self.nPlayerId][1];
	CFuben:Close(nTempMapId, self.nMapId, self.nPlayerId);
end


 --pNpc.AddLifePObserver(90)
 --local tbNpc = Npc:GetClass("animal");
-- local tbNpc = Npc:GetClass("dataosha_baoming");
-- function tbNpc:OnLifePercentReduceHere(nPercent)
-- end