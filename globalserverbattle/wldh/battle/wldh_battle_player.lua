-------------------------------------------------------
-- �ļ�������wldh_battle_player.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-08-26 05:19:37
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle_def.lua");

local tbPlayerBase	= Wldh.Battle.tbPlayerBase or {};
Wldh.Battle.tbPlayerBase	= tbPlayerBase;

-- �ṹ��ʼ��
function tbPlayerBase:init(pPlayer, tbCamp)
	self.nSeriesKillNum		= 0;			-- ��ն�� 
	self.nMaxSeriesKillNum	= 0;			-- �����ն��
	self.nSeriesKill		= 0;			-- ��ǰ��Ч��ն��
	self.nMaxSeriesKill		= 0;			-- �����Ч��ն��
	self.nTriSeriesNum		= 0;			-- ����ն����
	self.nRank				= 1;			-- ����, 1��ʾʿ��
	self.nBouns				= 0;			-- ս�ֻ���
	self.nKillPlayerNum		= 0;			-- ɱ����Ҹ���
	self.nKillPlayerBouns	= 0;			-- ɱ����һ���
	self.nListRank			= 0;			-- ���а�����
	self.nBackTime			= 0;			-- ���һ�λغ�Ӫ��ʱ��
	self.nBeenKilledNum		= 0;			-- ��ɱ��
	self.szFacName			= Player:GetFactionRouteName(pPlayer.nFaction, pPlayer.nRouteId);	-- �����������

	self.pPlayer		= pPlayer;			-- ���
	self.tbMission		= tbCamp.tbMission;	-- ����Mission
	self.tbCamp			= tbCamp;			-- ������Ӫ
end

-- ���ӵ�ǰ���֣�ͬʱ���ӱ���Ӫ��
function tbPlayerBase:AddBounsWithCamp(nBouns)
	local nResult = self:AddBounsWithoutCamp(nBouns);
	self.tbCamp.nBouns = self.tbCamp.nBouns + nBouns;
	return nResult;
end

-- ��������ǰ���� ** ȥ����������
function tbPlayerBase:AddBounsWithoutCamp(nBouns)
	
	local nNewBouns	= self.nBouns + nBouns;
	local nResult = nNewBouns - self.nBouns;
	
	self.nBouns = nNewBouns;
	self:ProcessRank();
	self:ShowRightBattleInfo();
	
	return nResult;
end

-- ������������Ϣ
function tbPlayerBase:ProcessRank()
	
	local nRank = 0;
	
	if self.nRank >= 10 then
		return;
	end
	
	for i = #Wldh.Battle.RANKBOUNS, 1, -1 do
		if self.nBouns >= Wldh.Battle.RANKBOUNS[i] and -1 ~= Wldh.Battle.RANKBOUNS[i] then
			nRank = i;
			break;
		end
	end
	
	if self.nRank == nRank then
		return;
	end

	assert(self.nRank < nRank);
	
	self.pPlayer.AddTitle(2, self.tbCamp.nCampId, nRank, 0);
	self.nRank= nRank;
	
	return nRank;
end

-- �ұ�ս����Ϣ
function tbPlayerBase:SetRightBattleInfo(nRemainFrame)
	local szMsgFormat = "<color=green>ʣ��ʱ�䣺<color> <color=white>%s<color>";
	Dialog:SetBattleTimer(self.pPlayer, szMsgFormat, nRemainFrame);
	self:ShowRightBattleInfo();
end

function tbPlayerBase:ShowRightBattleInfo()
	
	local szMsg	= string.format("<color=green>��ǰ������<color> <color=0xa0ff>%d<color>\n<color=green>���˻��֣�<color> <color=yellow>%d<color>\n<color=green>�˵���ң� <color><color=red>%d<color>", 
		self.nListRank, self.nBouns, self.nKillPlayerNum);

	Dialog:SendBattleMsg(self.pPlayer, szMsg);
	Dialog:ShowBattleMsg(self.pPlayer, 1, 0);
end

function tbPlayerBase:DeleteRightBattleInfo()
	Dialog:ShowBattleMsg(self.pPlayer, 0, 3 * 18);
end
