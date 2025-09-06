-------------------------------------------------------
-- �ļ�������wldh_battle_bouns.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-08-21 09:05:08
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle_def.lua");

local tbBattle = Wldh.Battle;

-- ������ն���ֽ���
function tbBattle:ProcessSeriesBouns(tbKillerBattleInfo, tbDeathBattleInfo)
	
	local nMeRank	= tbDeathBattleInfo.nRank;
	local nPLRank	= tbKillerBattleInfo.nRank;
	
	-- ������ն���� ������Ч��ն
	if 5 >= (nPLRank - nMeRank) then
		local nSeriesKill = tbKillerBattleInfo.nSeriesKill + 1;
		tbKillerBattleInfo.nSeriesKill = nSeriesKill;

		if math.fmod(nSeriesKill, 3) == 0 then	
			tbKillerBattleInfo.nTriSeriesNum = tbKillerBattleInfo.nTriSeriesNum + 1;
			self:AddShareBouns(tbKillerBattleInfo, self.SERIESKILLBOUNS)
			tbKillerBattleInfo.pPlayer.Msg(string.format("%s��%s %s�������˵���%d�������%d���ֵ���ն������", 
				Wldh.Battle.NAME_CAMP[tbKillerBattleInfo.tbCamp.nCampId], Wldh.Battle.NAME_RANK[tbKillerBattleInfo.nRank], tbKillerBattleInfo.pPlayer.szName, tbKillerBattleInfo.nSeriesKill, self.SERIESKILLBOUNS));
		end

		if tbKillerBattleInfo.nMaxSeriesKill < nSeriesKill then
			tbKillerBattleInfo.nMaxSeriesKill = nSeriesKill;
		end
	end
	
	-- ������ն	
	local nSeriesKillNum = tbKillerBattleInfo.nSeriesKillNum + 1;
	tbKillerBattleInfo.nSeriesKillNum = nSeriesKillNum;

	if tbKillerBattleInfo.nMaxSeriesKillNum < nSeriesKillNum then
		tbKillerBattleInfo.nMaxSeriesKillNum = nSeriesKillNum;
	end
end

-- ���ɱ����һ��ֽ���
function tbBattle:GiveKillerBouns(tbKillerBattleInfo, tbDeathBattleInfo)
	
	tbKillerBattleInfo.nKillPlayerNum = tbKillerBattleInfo.nKillPlayerNum + 1;
	
	local nMeRank		= tbDeathBattleInfo.nRank;
	local nPLRank		= tbKillerBattleInfo.nRank;
	
	local nRadioRank	= 1;
	nRadioRank			= (10 - (nPLRank - nMeRank)) / 10;
	local nPoints		= math.floor(Wldh.Battle.tbBounsBase.KILLPLAYER * nRadioRank);
	local nBounsDif		= self:AddShareBouns(tbKillerBattleInfo, nPoints)
	
	if nBounsDif > 0 then
		tbKillerBattleInfo.nKillPlayerBouns = tbKillerBattleInfo.nKillPlayerBouns + nPoints;
	end
end

function tbBattle:AddShareBouns(tbBattleInfo, nBouns)
	
	local tbShareTeamMember = tbBattleInfo.pPlayer.GetTeamMemberList(1);
	
	if (not tbShareTeamMember) then
		return tbBattleInfo:AddBounsWithCamp(nBouns);
	end
	
	local nResult	= 0;	
	local nCount	= #tbShareTeamMember;
	
	if 0 < nCount then
		local nTimes	= self.tbPOINT_TIMES_SHARETEAM[nCount];
		local nPoints	= nBouns * nTimes;
		nResult			= tbBattleInfo:AddBounsWithCamp(nPoints);
	end

	return nResult;
end

