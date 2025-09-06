-------------------------------------------------------
-- �ļ�������wldh_songjin.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-10-15 09:49:03
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle_def.lua");

local tbNpc = Npc:GetClass("wldh_songjin");

function tbNpc:OnDialog()
	
	local tbOpt	= 	
	{
		{"Tham Gia<color=orange> Phe<color> Tống", self.OnJoin, self, 1},
		{"Tham Gia<color=pink> Phe<color> Kim", self.OnJoin, self, 2},
		--{"׵ܘӢћպ", self.OnLeaveHere, self},
		{"Kết Thúc Đối Thoại"},
	};

	Dialog:Say("Ta Sẻ Đưa Ngươi Đến Nơi Cần Đến ...!", tbOpt);
end

function tbNpc:OnJoin(nCamp)
	
	local tbMapId = 
	{
		[1] = 182,
		[2] = 185,
	};
	
	local tbNpc	= Npc:GetClass("mubingxiaowei");
	local tbNpcBase = tbNpc.tbMapNpc[tbMapId[nCamp]];
	
	tbNpcBase:OnDialog();
end

function tbNpc:OnLeaveHere()
	
	local nGateWay = Transfer:GetTransferGateway();
	if not Wldh.Battle.tbLeagueName[nGateWay] then
		me.NewWorld(1609, 1648, 3377);
		return;
	end
	
	local nMapId = Wldh.Battle.tbLeagueName[nGateWay][2];
	if nMapId then
		me.NewWorld(nMapId, 1648, 3377);
	end
end