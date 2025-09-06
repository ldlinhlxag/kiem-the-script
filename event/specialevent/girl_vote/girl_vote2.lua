-- �ļ�������girl_vote_gc.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-06-04 17:49:23
-- ��  ��  ��

SpecialEvent.Girl_Vote = SpecialEvent.Girl_Vote or {};
local tbGirl = SpecialEvent.Girl_Vote;

function tbGirl:GetGblBuf2()
	if not self.tbGblBuf2 then
		self.tbGblBuf2 = {};
	end
	return self.tbGblBuf2;
end

function tbGirl:SetGblBuf2(tbBuf)
	self.tbGblBuf2 = tbBuf;
end

function tbGirl:IsHaveGirl2(szGateWay, szName)
	local tbBuf = self:GetGblBuf2();
	if tbBuf.tPList and tbBuf.tPList[szGateWay] and tbBuf.tPList[szGateWay][szName] then
		return 1;
	end	
	return 0;
end

local function OnSort(tbA, tbB)
	if tbA[2] == tbB[2] then
		return tbA[2] < tbB[2]
	end 
	return tbA[2] > tbB[2];
end

function tbGirl:BufVoteTicket2(szGateWay, szName, nTickets, tbFans)
	local tbBuf = self:GetGblBuf2();
	if tbBuf and tbBuf.tPList and tbBuf.tPList[szGateWay] and tbBuf.tPList[szGateWay][szName] then
		local tbRole = tbBuf.tPList[szGateWay][szName];
		tbRole[2] = tbRole[2] + nTickets;		--Ʊ��
		local szFansName = tbFans.szFansName;
		if szName ~= szFansName then
			local nInsertRank = 0;
			local nIsEmply	= 0;
			local nFansTicketAll = tbFans.nTotleTickets + nTickets;
			local nOldFans = 0;
			for nRank, tbBufFans in ipairs(tbRole[3]) do
				if tbBufFans[1] == szFansName then
					nOldFans = nRank;
				end
			end
			if nOldFans > 0 then
				tbRole[3][nOldFans] = {szFansName, nFansTicketAll, GetGatewayName()};
			else
				table.insert(tbRole[3], {szFansName, nFansTicketAll, GetGatewayName()});
			end
			
			table.sort(tbRole[3], OnSort);
			local tbRemove = {};
			for nRank, tbBufFans in ipairs(tbRole[3]) do
				if nRank > 5 then
					table.insert(tbRemove, nRank);
				end
			end
			
			for _, nRank in ipairs(tbRemove) do
				tbRole[3][nRank] = nil;
			end
		end
	end
	if (MODULE_GC_SERVER) then 
		GlobalExcute({"SpecialEvent.Girl_Vote:BufVoteTicket2", szGateWay, szName, nTickets, tbFans});
	end
	if (not MODULE_GC_SERVER) and szGateWay == GetGatewayName() then
		local nPlayerId = KGCPlayer.GetPlayerIdByName(szName);
		if nPlayerId then
			local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
			if pPlayer then
				pPlayer.Msg(string.format("<color=yellow>%s<color>����Ͷ��<color=yellow>%s<color>��õ�壬�Ͽ�������л�ɡ�", tbFans.szFansName, nTickets));
			end
		end
	end
	self:SetGblBuf2(tbBuf);
	Dbg:WriteLog("SpecialEvent.Girl_Vote", tbFans.szFansName.."Ͷ��"..nTickets.."Ʊ��"..szName);
end

function tbGirl:SetPassState2Girl(tbTemp)
	local tbBuf2 = self:GetGblBuf2();
	tbBuf2.tZList = tbBuf2.tZList or {};
	tbBuf2.tPList = tbBuf2.tPList or {};
	tbBuf2.tGList = tbBuf2.tGList or {};
	local szGateWay = tbTemp.GatewayId;
	local szZoneName = tbTemp.ZoneName;
	local szServerName = tbTemp.ServerName;
	
	if self.GATEWAY_TRANS[szGateWay] then
		szGateWay = self.GATEWAY_TRANS[szGateWay][1];
	end
	tbBuf2.tPList[szGateWay] = tbBuf2.tPList[szGateWay] or {};
	tbBuf2.tZList[szGateWay] = tbBuf2.tZList[szGateWay] or {};
	tbBuf2.tGList[tbTemp.ZoneName] 	= tbBuf2.tGList[tbTemp.ZoneName] or {};
	tbBuf2.tGList[tbTemp.ZoneName][tbTemp.ServerName] = tbBuf2.tGList[tbTemp.ZoneName][tbTemp.ServerName] or szGateWay;
	
	tbBuf2.tZList[szGateWay][1] = tbBuf2.tZList[szGateWay][1] or tbTemp.ZoneName;
	tbBuf2.tZList[szGateWay][2] = tbBuf2.tZList[szGateWay][2] or tbTemp.ServerName;
	
	if tbBuf2.tPList[szGateWay][tbTemp.RoleName] then
		print("����Ůѡ�١����������ظ�", szGateWay, tbTemp.RoleName);
		Dbg:WriteLog("����Ůѡ�١����������ظ�", szGateWay, tbTemp.RoleName);
	end
	
	tbBuf2.tPList[szGateWay][tbTemp.RoleName] = {};
	local tbPlayer = tbBuf2.tPList[szGateWay][tbTemp.RoleName];
	tbPlayer[1] = tbPlayer[1] or 0;		--����
	tbPlayer[2] = tbPlayer[2] or 0;		--Ʊ��
	tbPlayer[3] = tbPlayer[3] or {};	--��һ��˿����
	tbPlayer[4] = tbPlayer[4] or tbTemp.Account; --�ʺ�
	
	if (MODULE_GC_SERVER) then
		GlobalExcute({"SpecialEvent.Girl_Vote:SetPassState2Girl", tbTemp});
	end
end
