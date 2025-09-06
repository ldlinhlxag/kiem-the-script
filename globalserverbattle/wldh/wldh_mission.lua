--���ִ��
--�����
--2008.09.11
if (MODULE_GC_SERVER) then
	return 0;
end

Require("\\script\\globalserverbattle\\Wldh\\Wldh_def.lua")

-- ����һ��Mission��
local MissionBase = Mission:New();
Wldh.GameMission = MissionBase;

-- ����Ҽ���Mission���󡱱�����
function MissionBase:OnJoin(nGroupId)
	Wldh:SetStateJoinIn(1);
	me.SetCurCamp(nGroupId);
	local szLeagueName = League:GetMemberLeague(self.nLgType, me.szName);
	if not szLeagueName then
		return 0;
	end
	local szMacthName = self.tbLeagueList[szLeagueName].szMacthName;
	local szMsg = string.format(Wldh.MIS_UI[self:GetGameState()][1], szLeagueName, szMacthName);
	local szMsg2 = string.format(Wldh.MIS_UI[self:GetGameState()][3], 0, 0);
	Wldh:OpenSingleUi(me, szMsg..Wldh.MIS_UI[self:GetGameState()][2], self:GetStateLastTime());
	Wldh:UpdateMsgUi(me, szMsg2);
	Dialog:SendBlackBoardMsg(me, "���������,����������ʼ")
	Wldh:WriteLog(string.format("��ҽ��������:%s", me.nMapId), me.nId)
end;

-- ����Ҽ���Mission���󡱱�����
function MissionBase:OnDeath()
	local szLeagueName = League:GetMemberLeague(self.nLgType, me.szName);
	self.tbLeagueList[szLeagueName].tbDamage[me.nId] = me.GetDamageCounter();
	self:KickPlayer(me, 0);
end;

-- ������뿪Mission���󡱱�����
function MissionBase:OnLeave(nGroupId, nState)
	local szLeagueName = League:GetMemberLeague(self.nLgType, me.szName);
	local szMacthName = self.tbLeagueList[szLeagueName].szMacthName;
	if self.nGameState == 1 or self.nGameState == 2 then
		if nState ~= 1 and self.tbLeagueList[szLeagueName] and self.tbLeagueList[szMacthName] then
			--�����׶��뿪�᳡,�����������ܴ���
			--local szLeagueName = League:GetMemberLeague(self.nLgType, me.szName);
			self.tbLeagueList[szLeagueName].tbAtGameList[me.nId] = nil;
			if Wldh:CountTableLeng(self.tbLeagueList[szLeagueName].tbAtGameList) == 0 then
				--�������
				--local szMacthName = self.tbLeagueList[szLeagueName].szMacthName;
				local nMatchTime = 0;
				if self.nGameState == 1 then
					nMatchTime = math.floor((Wldh.MIS_LIST[1][2] - self:GetStateLastTime()) / Env.GAME_FPS);
				else
					nMatchTime = math.floor( (Wldh.MIS_LIST[1][2] + Wldh.MIS_LIST[2][2] - self:GetStateLastTime()) / Env.GAME_FPS);
				end
				Wldh:MacthAward(self.nGameType, self.nIsFinal, szLeagueName, szMacthName, self.tbLeagueList[szLeagueName].tbPlayerList, 3, nMatchTime, self.nReadyId);
				Wldh:MacthAward(self.nGameType, self.nIsFinal, szMacthName, szLeagueName, self.tbLeagueList[szMacthName].tbPlayerList, 1, nMatchTime, self.nReadyId);
				local nReadyId	= League:GetLeagueTask(self.nLgType, szLeagueName, Wldh.LGTASK_ATTEND);
				if self.nIsFinal == 7 then
					Wldh:SetAdvMacthResult(self.nGameType, nReadyId);
				end
				for nId in pairs(self.tbLeagueList[szMacthName].tbAtGameList) do
					local pPlayer = KPlayer.GetPlayerObjById(nId);
					if pPlayer then
						self:KickPlayer(pPlayer, 1);
					end
				end
				--self:LookerResult(szLeagueName, 3);
				--self:LookerResult(szMacthName, 1);
				--Wldh:RemoveLookerLeague(szLeagueName);
				--Wldh:RemoveLookerLeague(szMacthName);
				self.tbLeagueList[szMacthName].tbAtGameList = {};
			else
				Dialog:SendBlackBoardMsg(me, "��ȴ����ս�ӱ�����������ȡ��Ӧ�ľ��顢��Ʒ������");
				me.Msg("��ȴ����ս�ӱ�����������ȡ��Ӧ�ľ��顢��Ʒ�������ڸù����У��벻Ҫ���ߺ��뿪���᳡���������ܻᵼ���޷���ȡ������");
			end
		end
	end
	local nMaxDamageA = self.tbLeagueList[szLeagueName] and self.tbLeagueList[szLeagueName].nMaxDamage or 0;
	local nMaxDamageB = self.tbLeagueList[szLeagueName] and self.tbLeagueList[szMacthName].nMaxDamage or 0;
	me.Msg(string.format("\n<color=green>�Է�����������<color=red>%s\n<color=green>��������������<color=blue>%s", nMaxDamageB, nMaxDamageA));
	
	-- add log
	Dbg:WriteLog("Wldh", "�˺����", szLeagueName, nMaxDamageA, szMacthName, nMaxDamageB);

	Wldh:LeaveGame()
	Wldh:CloseSingleUi(me)
end;

-- �����
-- ����Id, ����, �Ƿ��Ǿ���,������ѭ����
function MissionBase:StartGame(nReadyId, nGameType, nIsFinal)
	-- �趨��ѡ������
	--����᳡
	local tbLeaveMap =  Wldh:GetLeaveMapPos(nGameType, nReadyId);
	
	self.tbMisCfg	= {
		tbEnterPos		= {},					-- ��������
		tbLeavePos		= {[1]= tbLeaveMap, [2] = tbLeaveMap},	-- �뿪����
		tbCamp			= {[1] = 1, [2] = 2},	-- �ֱ��趨��Ӫ
		nForbidTeam		= 1,
		nPkState		= Player.emKPK_STATE_PRACTISE,--ս��ģʽ
		nDeathPunish	= 1,
		nOnDeath 		= 1, 	-- �����ű�����
		nInLeagueState	= 1,	-- ���ģʽ
	}
	self.nMacthMap  = Wldh:GetMapMacthTable(nGameType)[nReadyId];
	self.nMacthMapPatch	= Wldh:GetMapMacthPatchTable(nGameType)[nReadyId];	--�󱸵�ͼ
	self.nIsFinal = nIsFinal or 0;
	self.nGameType = nGameType;
	self.nReadyId = nReadyId;
	self.nLgType = Wldh:GetLGType(nGameType);
	self.nGameState = 1;		--��ʼ׼��pk�׶�
	self.tbLeagueList = {};		--ս�ӳ�Ա��
	self.tbMisEventList	= Wldh.MIS_LIST;
	self.tbGroups	= {};
	self.tbPlayers	= {};
	self.tbTimers	= {};
	--self.tbLooker	= {};
	self.nStateJour = 0;
	self.tbNowStateTimer = nil;
	self:GoNextState()	-- ��ʼ����
end

function MissionBase:OnGamePk()
	self.nGameState = 2;
	--self:BroadcastMsg("������ʽ����", "test");	-- �㲥��Ϣ
	for _, pPlayer in pairs(self:GetPlayerList()) do
		pPlayer.SetFightState(1);
		pPlayer.SetBroadHitState(1);
		pPlayer.nPkModel = Player.emKPK_STATE_BUTCHER;
		Dialog:SendBlackBoardMsg(pPlayer, "������ʽ��ʼ");
		local szLeagueName = League:GetMemberLeague(self.nLgType, pPlayer.szName);
		if not szLeagueName then
			return 0;
		end
		self:OnGamePkUi(pPlayer, szLeagueName);
	end
	
--	for szLookLeagueName, tbLooker in pairs(self.tbLooker) do
--		for nLookId in pairs(tbLooker) do
--			local pPlayer = KPlayer.GetPlayerObjById(nLookId);
--			if pPlayer then
--				self:OnGamePkUi(pPlayer, szLookLeagueName);
--			end
--		end
--	end
	
	
	self.tbTimer = self:CreateTimer(Wldh.MACTH_TIME_PK_DAMAGE, self.OnSyncDamage, self);
end

function MissionBase:OnGamePkUi(pPlayer, szLeagueName)
	local szMacthName = self.tbLeagueList[szLeagueName].szMacthName;
	local szMsg = string.format(Wldh.MIS_UI[self:GetGameState()+1][1], szLeagueName, szMacthName);
	local szMsg2 = string.format(Wldh.MIS_UI[self:GetGameState()+1][3], 0, 0);
	Wldh:UpdateTimeUi(pPlayer, szMsg..Wldh.MIS_UI[self:GetGameState()+1][2], self.tbMisEventList[self:GetGameState()+1][2]);
	Wldh:UpdateMsgUi(pPlayer, szMsg2);
end

function MissionBase:OnGameOver()
	if self.nGameState ~= 2 then
		return 0;
	end
	self:OnSyncDamage();
	self.tbTimer:Close();
	self.nGameState = 3;
	self:EndGame();
	return 0;
end

--ͬ����Ѫ��
function MissionBase:OnSyncDamage()
	if self:GetGameState() <= 0 or self.nGameState ~= 2 then
		return 0;
	end
	for _, pPlayer in pairs(self:GetPlayerList()) do
		local szLeagueName = League:GetMemberLeague(self.nLgType, pPlayer.szName);
		self.tbLeagueList[szLeagueName].tbDamage[pPlayer.nId] = pPlayer.GetDamageCounter();
	end
	for szLeagueName, tbParam in pairs(self.tbLeagueList) do
		tbParam.nMaxDamage = 0;
		for _, nDamage in pairs(tbParam.tbDamage) do
			tbParam.nMaxDamage = tbParam.nMaxDamage + nDamage;
		end
	end
	
	for _, pPlayer in pairs(self:GetPlayerList()) do
		local szLeagueName = League:GetMemberLeague(self.nLgType, pPlayer.szName);
		self:OnSyncDamageUi(pPlayer, szLeagueName, 0);
	end
	
--	for szLookLeagueName, tbLooker in pairs(self.tbLooker) do
--		for nLookId, nIsOn in pairs(tbLooker) do
--			local pPlayer = KPlayer.GetPlayerObjById(nLookId);
--			if pPlayer and nIsOn == 1 then
--				self:OnSyncDamageUi(pPlayer, szLookLeagueName, 1);
--			end
--		end
--	end	
	
end

function MissionBase:OnSyncDamageUi(pPlayer, szLeagueName, nIsLooker)
	local szMacthName = self.tbLeagueList[szLeagueName].szMacthName;
	if Wldh.MIS_UI[self:GetGameState()] and self.tbLeagueList[szMacthName] and self.tbLeagueList[szLeagueName] then
		if Wldh.MIS_UI[self:GetGameState()][3] and self.tbLeagueList[szMacthName].nMaxDamage and self.tbLeagueList[szLeagueName].nMaxDamage then
			local szMsg2 = string.format(Wldh.MIS_UI[self:GetGameState()][3], self.tbLeagueList[szMacthName].nMaxDamage, self.tbLeagueList[szLeagueName].nMaxDamage);
			--if nIsLooker == 1 then
			---	szMsg2 = string.format(Wldh.MIS_UI_LOOKER, szMacthName, self.tbLeagueList[szMacthName].nMaxDamage, szLeagueName, self.tbLeagueList[szLeagueName].nMaxDamage);
			--end
			Wldh:UpdateMsgUi(pPlayer, szMsg2);
		end
	end	
end

-- ����
function MissionBase:JoinGame(pPlayer, nCamp)
	self:JoinPlayer(pPlayer, nCamp);
end

-- �����
function MissionBase:EndGame()
	for szLeagueName, tbLeague in pairs(self.tbLeagueList) do
		local szMacthName = self.tbLeagueList[szLeagueName].szMacthName;
		if Wldh:CountTableLeng(tbLeague.tbAtGameList) > 0 then
			local szWin = szLeagueName;
			local szLoss = szMacthName;
			local nTie = 0;
			local tbMacth = self.tbLeagueList[szMacthName];
			if Wldh:CountTableLeng(tbLeague.tbAtGameList) < Wldh:CountTableLeng(self.tbLeagueList[szMacthName].tbAtGameList) then
				szWin = szMacthName;
				szLoss = szLeagueName;
			elseif Wldh:CountTableLeng(tbLeague.tbAtGameList) == Wldh:CountTableLeng(self.tbLeagueList[szMacthName].tbAtGameList) then
				if tbLeague.nMaxDamage == self.tbLeagueList[szMacthName].nMaxDamage then
					--��Ѫ��һ��,���ƽ
					nTie = 1;
				end
			
				--����Ѫ���ٵĻ�ʤ
				if tbLeague.nMaxDamage > self.tbLeagueList[szMacthName].nMaxDamage then
					szWin = szMacthName;
					szLoss = szLeagueName;
				end
			end
			local nMatchTime = math.floor((Wldh.MIS_LIST[1][2] + Wldh.MIS_LIST[2][2])/Env.GAME_FPS);
			if nTie == 1 then
				Wldh:MacthAward(self.nGameType, self.nIsFinal, szWin, szLoss, self.tbLeagueList[szWin].tbPlayerList, 2, nMatchTime, self.nReadyId);
				Wldh:MacthAward(self.nGameType, self.nIsFinal, szLoss, szWin, self.tbLeagueList[szLoss].tbPlayerList, 2, nMatchTime, self.nReadyId);
				--self:KickLooker(szWin, string.format("����������<color=yellow>%s<color> �� <color=yellow>%s<color> ��Ϊƽ�֡�", szWin, szLoss));
				--self:KickLooker(szLoss, string.format("����������<color=yellow>%s<color> �� <color=yellow>%s<color> ��Ϊƽ�֡�", szWin, szLoss));
			else
				Wldh:MacthAward(self.nGameType, self.nIsFinal, szWin, szLoss, self.tbLeagueList[szWin].tbPlayerList, 1, nMatchTime, self.nReadyId);
				Wldh:MacthAward(self.nGameType, self.nIsFinal, szLoss, szWin, self.tbLeagueList[szLoss].tbPlayerList, 3, nMatchTime, self.nReadyId);
				--self:KickLooker(szWin, string.format("����������<color=yellow>%s<color> սʤ�� <color=yellow>%s<color>��", szWin, szLoss));
				--self:KickLooker(szLoss, string.format("����������<color=yellow>%s<color> �ܸ��� <color=yellow>%s<color>��", szLoss, szWin));
			end
			local nReadyId	= League:GetLeagueTask(self.nLgType, szLeagueName, Wldh.LGTASK_ATTEND);
			if self.nIsFinal == 7 then
				Wldh:SetAdvMacthResult(self.nGameType, nReadyId);
			end
			self.tbLeagueList[szLoss].tbAtGameList = {};
			self.tbLeagueList[szWin].tbAtGameList = {};
			--Wldh:RemoveLookerLeague(szWin);
			--Wldh:RemoveLookerLeague(szLoss);
			
			-- add log
			Dbg:WriteLog("Wldh", "�˺����", szLeagueName, tbLeague.nMaxDamage, szMacthName, self.tbLeagueList[szMacthName].nMaxDamage);
		end
	end
	
--	for szLookLeagueName, tbLooker in pairs(self.tbLooker) do
--		self:KickLooker(szLookLeagueName);
--	end	
	self:Close();
end

function MissionBase:GetGameState()
	return self.nStateJour;
end

function MissionBase:AddLeague(pPlayer, szName, szLeagueName, szMacthName)
	if not self.tbLeagueList[szLeagueName] then
		self.tbLeagueList[szLeagueName] = {};
		self.tbLeagueList[szLeagueName].szMacthName = szMacthName;
		self.tbLeagueList[szLeagueName].tbDamage = {};
		self.tbLeagueList[szLeagueName].nMaxDamage = 0;
		self.tbLeagueList[szLeagueName].tbAtGameList = {};
		self.tbLeagueList[szLeagueName].tbPlayerList = {};
	end
	if not self.tbLeagueList[szMacthName] then
		self.tbLeagueList[szMacthName] = {};
		self.tbLeagueList[szMacthName].szMacthName = szLeagueName;
		self.tbLeagueList[szMacthName].tbDamage = {};
		self.tbLeagueList[szMacthName].nMaxDamage = 0;
		self.tbLeagueList[szMacthName].tbAtGameList = {};
		self.tbLeagueList[szMacthName].tbPlayerList = {};
	end
	self.tbLeagueList[szLeagueName].tbDamage[pPlayer.nId] = 0;
	self.tbLeagueList[szLeagueName].tbAtGameList[pPlayer.nId] = szName;
	self.tbLeagueList[szLeagueName].tbPlayerList[pPlayer.nId] = szName;
	return 0;
end

--function MissionBase:KickLooker(szLeagueName, szResult)
--	if self.tbLooker[szLeagueName] then
--		for nLookId in pairs(self.tbLooker[szLeagueName]) do
--			local pPlayer = KPlayer.GetPlayerObjById(nLookId);
--			if pPlayer then
--				Looker:Leave(pPlayer);
--				if szResult then
--					pPlayer.Msg(szResult);
--				end
--			end
--		end
--		self.tbLooker[szLeagueName] = nil;
--	end		
--end
--
--function MissionBase:LookerResult(szLeagueName, nResult)
--	if self.tbLooker[szLeagueName] then
--		local szMacthName = self.tbLeagueList[szLeagueName].szMacthName;
--		local szMsg2 = nil; 
--		if self.tbLeagueList[szMacthName] and self.tbLeagueList[szLeagueName] then
--			if self.tbLeagueList[szMacthName].nMaxDamage and self.tbLeagueList[szLeagueName].nMaxDamage then
--				szMsg2 = string.format(Wldh.MIS_UI_LOOKER, szMacthName, self.tbLeagueList[szMacthName].nMaxDamage, szLeagueName, self.tbLeagueList[szLeagueName].nMaxDamage);
--			end
--		end	
--		if szMsg2 then
--			if nResult == 1 then
--				szMsg2 = szMsg2 .. string.format("\n<color=green>ʤ������<color><color=gold>%s<color>", szLeagueName);
--			else
--				szMsg2 = szMsg2 .. string.format("\n<color=green>ʤ����: <color><color=gold>%s<color>", szMacthName);
--			end
--			for nLookId in pairs(self.tbLooker[szLeagueName]) do
--				local pPlayer = KPlayer.GetPlayerObjById(nLookId);
--				if pPlayer then	
--					self.tbLooker[szLeagueName][nLookId] = 2;
--					Wldh:UpdateMsgUi(pPlayer, szMsg2);
--				end
--			end
--		end
--	end
--end
