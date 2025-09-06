-------------------------------------------------------
-- �ļ�������wldh_battle_rulebase.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-08-26 07:38:25
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle.lua");

local tbRuleBase = Wldh.Battle.tbRuleBases[0] or {};	-- ֧������
Wldh.Battle.tbRuleBases[0]	= tbRuleBase;


-- ��ʼ������֮��
function tbRuleBase:OnInit()
	
end

-- ������ʼ��֮��
function tbRuleBase:OnStart()

end

-- ����������֮ǰ��
function tbRuleBase:OnClose()
	
end

function tbRuleBase:OnLeave(pPlayer)
	
end

-- �жϱ���ʤ��������ʤ����һ����ƽ�ַ���0
function tbRuleBase:GetWinCamp()
	
	local tbCampSong = self.tbMission.tbCampSong;
	local tbCampJin	= self.tbMission.tbCampJin;
	
	-- �����ּ���
	if (tbCampSong.nBouns > tbCampJin.nBouns) then
		return Wldh.Battle.CAMPID_SONG;
		
	elseif (tbCampSong.nBouns < tbCampJin.nBouns) then
		return Wldh.Battle.CAMPID_JIN;
		
	else
		return 0;
	end
end

-- �����ʼ��
function tbRuleBase:Init(tbMission)
	
	self.tbMission		= tbMission;
	self.tbCamps		= tbMission.tbCamps;
	
	self.tbMapInfoCamp	= 
	{
		[Wldh.Battle.CAMPID_SONG]	= tbMission.tbCampSong.tbMapInfo;
		[Wldh.Battle.CAMPID_JIN]	= tbMission.tbCampJin.tbMapInfo;
	};
	
	self:OnInit();
end

-- �õ��ض��Ĺ���ģ��
function Wldh.Battle:GetRuleClass(nRuleType, szRuleName)
	
	local tbRuleBase = Wldh.Battle.tbRuleBases[nRuleType];
	
	if (not tbRuleBase) then
		tbRuleBase	= Lib:NewClass(Wldh.Battle.tbRuleBases[0]);
		tbRuleBase.nRuleType	= nRuleType;
		tbRuleBase.szRuleName	= szRuleName;
		Wldh.Battle.tbRuleBases[nRuleType]	= tbRuleBase;
	end
	
	return tbRuleBase;
end

function tbRuleBase:GetTopRankInfo(tbBattleInfo)
	
	local tbPlayerInfo	= 
	{
		[1]	= Wldh.Battle.NAME_CAMP[tbBattleInfo.tbCamp.nCampId];	
		[2]	= tbBattleInfo.szFacName;
		[3]	= tbBattleInfo.pPlayer.szName;
		[4]	= self.tbMission.tbLeagueName[tbBattleInfo.tbCamp.nCampId];
		[5]	= tbBattleInfo.nKillPlayerNum;
		[6]	= tbBattleInfo.nMaxSeriesKillNum;
		[7]	= tbBattleInfo.nBouns;
	};
	return tbPlayerInfo;
end

-- ���������Ϣ
function tbRuleBase:GetSyncInfo_Self(tbBattleInfo, nRemainTime)
	
	local tbMission			= tbBattleInfo.tbMission;
	
	local tbMyInfo			= {
		nBTMode				= self.nRuleType;
		nKillPlayerNum		= tbBattleInfo.nKillPlayerNum;
		nKillBouns			= tbBattleInfo.nBouns - tbBattleInfo.nTriSeriesNum * Wldh.Battle.SERIESKILLBOUNS;
		nTriSeriesNum		= tbBattleInfo.nTriSeriesNum;
		nSeriesBouns		= tbBattleInfo.nTriSeriesNum * Wldh.Battle.SERIESKILLBOUNS;
		nBouns				= tbBattleInfo.nBouns;
		nMaxSeriesKill		= tbBattleInfo.nMaxSeriesKillNum;
		szName				= self.szRuleName;
		nSeriesKill			= tbBattleInfo.nSeriesKillNum;
		szName				= tbMission.szBattleName;
		nCamp				= tbBattleInfo.tbCamp.nCampId;
		nListRank			= tbBattleInfo.nListRank;
		szBTName			= tbMission.szBattleName;
		nTotalSongBouns		= tbMission.tbCampSong.nBouns;
		nTotalJinBouns		= tbMission.tbCampJin.nBouns;
		nRemainBTTime		= nRemainTime;
		nMyCampNum			= tbBattleInfo.tbCamp.nPlayerCount;
		nEnemyCampNum		= tbBattleInfo.tbCamp.tbOppCamp.nPlayerCount;
		nKillPlayerBouns	= tbBattleInfo.nKillPlayerBouns;
	};
	return tbMyInfo;
end

