-------------------------------------------------------
-- �ļ�������wldh_battle_trap.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-08-21 15:14:24
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle_camp.lua");

-- �ν�ս���õ�ͼ����
local tbMapBase	= Wldh.Battle.tbMapBase or Lib:NewClass(Map.tbMapBase);	-- ���ڹ��õ�ͼ����
Wldh.Battle.tbMapBase = tbMapBase;

-- Trap�� => ���� ӳ��
tbMapBase.tbTrapNameMap	= 
{	
	["houying%d_daying%d"]		= "BaseToOuter1",
	["houying%d_qianying%d"]	= "BaseToOuter2",
	["houying%d_daying%d_1"]	= "BaseToOuter3",
	["houying%d_daying%d_2"]	= "BaseToOuter4",
	["daying%d_houying%d"]		= "OuterToBase",
	["qianying%d_houying%d"]	= "OuterToBase",
	["daying%d_yewai"]			= "OuterToField1",
	["qianying%d_yewai"]		= "OuterToField2",
};

-- ��ʼ��
function tbMapBase:init(tbCamp)
	
	local tbOnTrapCall	= {};	
	for nIndex, tbCamp in pairs(tbCamp) do
		
		for szFmtName, szFun in pairs(self.tbTrapNameMap) do
			local szTrapName	= string.format(szFmtName, nIndex, nIndex);
			local szFunName		= "OnTrap_"..szFun;
			tbOnTrapCall[szTrapName]	= function ()	-- ��������һ��closures���հ�������
				tbCamp[szFunName](tbCamp, me);
			end
		end
	end
	self.tbOnTrapCall	= tbOnTrapCall;
end

-- ��������ͼ�κ�Trap��
function tbMapBase:OnPlayerTrap(szClassName)
	self.tbOnTrapCall[szClassName]();
end

function tbMapBase:OnPlayerNpc(szClassName)
	--
end

-- Trap���¼�������Camp��
local tbCampBase = Wldh.Battle.tbCampBase;

-- ��Ӫ �� ��Ӫ/ǰӪ
function tbCampBase:OnTrap_BaseToOuter1(pPlayer)
	self:_BaseToOuter(pPlayer, "OuterCamp1");
end
function tbCampBase:OnTrap_BaseToOuter2(pPlayer)
	self:_BaseToOuter(pPlayer, "OuterCamp2");
end
function tbCampBase:OnTrap_BaseToOuter3(pPlayer)
	self:_BaseToOuter(pPlayer, "OuterCamp3");
end
function tbCampBase:OnTrap_BaseToOuter4(pPlayer)
	self:_BaseToOuter(pPlayer, "OuterCamp4");
end

function tbCampBase:_BaseToOuter(pPlayer, szPosName)
	
	local tbBattleInfo	= Wldh.Battle:GetPlayerData(pPlayer);
	local nBackTime		= tbBattleInfo.nBackTime;
	local nRemainTime	= Wldh.Battle.TIME_DEATHWAIT - (GetTime() - nBackTime);
	
	if (nRemainTime > 0) then
		Dialog:Say(string.format("���ں�Ӫ����%d�룬׼����ֺ���ȥɱ�С�", nRemainTime));
		return;
	end
	
	self:TransTo(tbBattleInfo.pPlayer, szPosName);
	tbBattleInfo.pPlayer.SetFightState(1);
end

-- ��Ӫ/ǰӪ �� ��Ӫ
function tbCampBase:OnTrap_OuterToBase(pPlayer)
	
	local tbBattleInfo	= Wldh.Battle:GetPlayerData(pPlayer);
	
	if (tbBattleInfo.tbCamp.nCampId ~= self.nCampId) then
		tbBattleInfo.pPlayer.Msg("ǰ��ǹ����У��䱸ɭ�ϣ����������ر����أ��㻹�ǲ�ҪӲ��Ϊ�");
		return;
	end
	
	tbBattleInfo.nBackTime	= GetTime()
	self:TransTo(tbBattleInfo.pPlayer, "BaseCamp");
	tbBattleInfo.pPlayer.SetFightState(0);
end

-- ��Ӫ/ǰӪ �� Ұ�� ��û���ϰ���
function tbCampBase:OnTrap_OuterToField1(pPlayer)
	self:_OuterToField(pPlayer, "OuterCamp1");
end
function tbCampBase:OnTrap_OuterToField2(pPlayer)
	self:_OuterToField(pPlayer, "OuterCamp2");
end

function tbCampBase:_OuterToField(pPlayer, szPosName)
	local nState = self.tbMission.nState;
	if (2 ~= nState) then
		Dialog:Say("δ��ս֮ǰ������ѡ��һ�Ų�׼�����뿪��Ӫ���㻹�ǵ��ſ�ս֮����ȥ����ɱ�аɣ�");
		self:TransTo(pPlayer, szPosName);
		return;
	end
end

