-------------------------------------------------------
-- �ļ�������wldh_shiliangu2.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-09-02 15:59:00
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle_def.lua");

-- Ӣ�۵������ˣ������� to Ӣ�۵�
local tbNpc = Npc:GetClass("wldh_shiliangu2");

function tbNpc:OnDialog()

	local tbOpt = 
	{
		{"�����뿪������", self.TransToYingxiong, self},	
		{"���ٿ��ǿ���"},
	};
		
	local szMsg = "��ã��ҿ��Դ����뿪�����ȣ��ص�Ӣ�۵���";
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:TransToYingxiong()
	Transfer:NewWorld2GlobalMap(me);	
--	local nGateWay = Transfer:GetTransferGateway();
--	
--	if not Wldh.Battle.tbLeagueName[nGateWay] then
--		me.NewWorld(1609, 1680, 3269);
--		return 0;
--	end
--	
--	local nMapId = Wldh.Battle.tbLeagueName[nGateWay][2];
--	
--	if nMapId then
--		me.NewWorld(nMapId, 1680, 3269);
--	end
end
