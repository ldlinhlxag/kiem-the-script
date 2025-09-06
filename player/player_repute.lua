Require("\\script\\player\\player.lua");

-- ������Ӧ�ĳƺ�
Player.tbTitleForRepute		= {};
Player.CHECKREPUTETITLETIME	= 1231257600;  -- 01/07/09 00:00:00

function Player:LoadReputeTitle()
	local tbTitleForRepute = {};
	local tbData = Lib:LoadTabFile("\\setting\\player\\playertitle_repute.txt");
	for _, tbRow in ipairs(tbData) do
		local nCampId	= tonumber(tbRow["CAMPID"]);
		local nClassId	= tonumber(tbRow["CLASSID"]);
		local nLevel	= tonumber(tbRow["LEVEL"]);
		local tbValue	= Lib:SplitStr(tbRow["TITLEPARAM"], ",");
		if (tbValue and #tbValue > 0) then
			local tbParam = {};
			for i=1, #tbValue do
				tbParam[i] = tonumber(tbValue[i]);
			end
			if (not tbTitleForRepute[nCampId]) then
				tbTitleForRepute[nCampId] = {};
			end
			
			if (not tbTitleForRepute[nCampId][nClassId]) then
				tbTitleForRepute[nCampId][nClassId] = {};
			end
			tbTitleForRepute[nCampId][nClassId][nLevel] = tbParam;
		end
	end
	self.tbTitleForRepute = tbTitleForRepute;
end

function Player:AddReputeTitle(nCampId, nClassId, nLevel)
	if (not self.tbTitleForRepute or 
		not self.tbTitleForRepute[nCampId] or
		not self.tbTitleForRepute[nCampId][nClassId] or
		not self.tbTitleForRepute[nCampId][nClassId][nLevel]) then
			return;
	end
	local tbParam = self.tbTitleForRepute[nCampId][nClassId][nLevel];
	if (1 == me.FindTitle(unpack(tbParam))) then
		return;
	end
	me.AddTitle(unpack(tbParam));
end

-- ����ʱ����Ƿ��гƺ�û����
function Player:ProcessAllReputeTitle(pPlayer)
	local nLastOutTime = me.GetLastLogoutTime();
	if (not nLastOutTime) then
		self:WriteReputeLog("ProcessAllReputeTitle", pPlayer.szName .. " have no last logout time!!!");
		return;
	end
	
	-- �ڴ�֮�����ߵĶ������
	if (nLastOutTime >= self.CHECKREPUTETITLETIME) then
		return;
	end
	
	if (not self.tbTitleForRepute) then
		self:WriteReputeLog("ProcessAllReputeTitle", pPlayer.szName .. " is not loading tbTitleForRepute table !!!");
		return;
	end

	for nCampId, tbCamp in pairs(self.tbTitleForRepute) do
		if (tbCamp) then
			for nClassId, tbClass in pairs(tbCamp) do
				if (tbClass) then
					for nLevel, tbParam in pairs(tbClass) do
						if (tbParam) then
							local nNowLevel = pPlayer.GetReputeLevel(nCampId, nClassId);
							if (nNowLevel) then
								if (nLevel == nNowLevel) then
									if (0 == pPlayer.FindTitle(unpack(tbParam))) then
										pPlayer.AddTitle(unpack(tbParam));
									end
								else -- ������ǿ��Լ�鿴���Ƿ��гƺ���Ҫȥ��
									-- pPlayer.RemoveTitle(unpack(tbParam));
								end
							end
						end
					end
				end
			end
		end
	end
	
end

function Player:WriteReputeLog(...)
	Dbg:WriteLogEx(Dbg.LOG_INFO, "Player", "ReputeTitle", unpack(arg));
end

if (MODULE_GAMESERVER) then
	Player:LoadReputeTitle();
	PlayerEvent:RegisterGlobal("OnAddReputeTitle", Player.AddReputeTitle, Player);
end
