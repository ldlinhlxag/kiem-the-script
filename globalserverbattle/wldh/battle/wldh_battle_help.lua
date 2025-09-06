-------------------------------------------------------
-- �ļ�������wldh_battle_help.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-10-14 20:20:05
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle_def.lua");

local tbBattle = Wldh.Battle;

function tbBattle:UpdateFinalHelp(nStep)
	
	local nKey = Wldh.LADDER_ID[5][5];
	local szTitle = Wldh.LADDER_ID[5][1].."����ս��";
	local nAddTime = GetTime();
	local nEndTime = nAddTime + 3600 * 24 * 30;
	
	local szMsg = "";
	if not self.tbFinalList then
		return 0;
	end

	if self.tbFinalList and #self.tbFinalList > 0 then
		szMsg = szMsg .. "<color=yellow>��ǿ�����<color>\n\n";
		for i = 1, 2 do
			local szName  = "<color=gray>�޲�������<color>";
			local szVsName  = "<color=gray>�޲�������<color>";
			
			if self.tbFinalList[1][i] then
				szName = "<color=pink>" .. self.tbFinalList[1][i][1] .. "<color>";
				szVsName ="<color=pink>" .. self.tbFinalList[1][i][2] .. "<color>";
			end
			szMsg = szMsg .. Lib:StrFillR(szName, 37) .. Lib:StrFillC("����", 8) .. szVsName .. "\n";
		end
		
		szMsg = szMsg .. "\n";
		
		if nStep >= 2 then
			szMsg = szMsg .. "<color=yellow>���������<color>\n\n";
			
			local szName  = "<color=gray>�޲�������<color>";
			local szVsName  = "<color=gray>�޲�������<color>";
			
			if self.tbFinalList[2] then
				szName = "<color=pink>" .. self.tbFinalList[2][1] .. "<color>";
				szVsName ="<color=pink>" .. self.tbFinalList[2][2] .. "<color>";
			end
			szMsg = szMsg .. Lib:StrFillR(szName, 37) .. Lib:StrFillC("����", 8) .. szVsName .. "\n";
		end
		
		szMsg = szMsg .. "\n";
		
		if nStep >= 3 then
			szMsg = szMsg .. "<color=yellow>�ھ����飺<color>\n";
			
			local szName  = "<color=gray>�޲�������<color>";
			
			if self.tbFinalList[3] then
				szName = "<color=pink>" .. self.tbFinalList[3][1] .. "<color>";
			end
			szMsg = szMsg .. Lib:StrFillR(szName, 37) .. "\n";
		end
	end
	
	Task.tbHelp:AddDNews(nKey, szTitle, szMsg, nEndTime, nAddTime);
end
