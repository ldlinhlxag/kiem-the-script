	-- �ļ�������zhenzai_gs.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2010-04-15 17:01:37
-- ��  ��  ������gs

if  not MODULE_GAMESERVER then
	return;
end
Require("\\script\\event\\specialevent\\ZhenZai\\ZhenZai_def.lua");
SpecialEvent.ZhenZai = SpecialEvent.ZhenZai or {};
local ZhenZai = SpecialEvent.ZhenZai or {};

--������������Ը��
function ZhenZai:AddVowTree()
	if SubWorldID2Idx(ZhenZai.tbVowTreePosition[1]) >= 0 then	
		 if ZhenZai.nVowTreenId == 0 then			--û�м��ع���Ը����add��Ը��
	 		local pNpc = KNpc.Add2(ZhenZai.nVowTreeTemplId, 100, -1, ZhenZai.tbVowTreePosition[1], ZhenZai.tbVowTreePosition[2], ZhenZai.tbVowTreePosition[3]);
	 		if pNpc then
		 		ZhenZai.nVowTreenId = pNpc.dwId;
		 		pNpc.SetTitle("<color=green>�����˳��̩��<color>");
		 	end
		end
		Dialog:GlobalNewsMsg_GS("��Ը���Ѿ����ţ���Ҵ���<color=yellow>ϣ��֮ˮ<color>��ȥΪ���������Լ���һ������ɣ�");
	end
end

--ɾ����Ը��
function ZhenZai.DeleteVowTree()
	if SubWorldID2Idx(ZhenZai.tbVowTreePosition[1]) >= 0 then
		if ZhenZai.nVowTreenId and ZhenZai.nVowTreenId ~= 0 then	--���ع���Ը��
			local pNpc = KNpc.GetById(ZhenZai.nVowTreenId);
			if pNpc then
				pNpc.Delete();
				ZhenZai.nVowTreenId = 0;
			end			
		end
	end
end

--��ڼ��ڷ�����ά������崻����������¼���npc
function ZhenZai:ServerStartFunc()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData >= self.VowTreeOpenTime and nData <= self.VowTreeCloseTime then	--��ڼ�������������
		ZhenZai:AddVowTree();
	end
end

ServerEvent:RegisterServerStartFunc(ZhenZai.ServerStartFunc, ZhenZai);
