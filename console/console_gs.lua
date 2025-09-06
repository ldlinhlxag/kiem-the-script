-- �ļ�������console_gs.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-04-23 10:04:41
-- ��  ��  ��--����̨

if (MODULE_GC_SERVER) then
	return 0;
end

--��������
function Console:ApplySignUp(nDegree, tbPlayerIdList)
	GCExcute{"Console:ApplySignUp", nDegree, tbPlayerIdList};
end

function Console:StartSignUp(nDegree)
	self:GetBase(nDegree):StartSignUp();
end

function Console:OnStartMission(nDegree)
	self:GetBase(nDegree):OnStartMission();
end

function Console:SignUpFail(tbPlayerList)
	for _, nPlayerId in pairs(tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			pPlayer.Msg("Đăng ký để tham gia chiến đấu quả cầu tuyết.");
			Dialog:SendBlackBoardMsg(pPlayer, "Đăng ký tham gia chiến đấu")
			return 0;
		end
	end
end

function Console:SignUpSucess(nDegree, nReadyMapId, tbPlayerList)
	local tbBase = self:GetBase(nDegree);
	for _, nPlayerId in pairs(tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			if tbBase:IsOpen() == 0 then
				pPlayer.Msg("Bạn đã bị trọng thương, kết thúc lượt đấu này.");
			else
				pPlayer.NewWorld(nReadyMapId, unpack(tbBase.tbCfg.tbMap[nReadyMapId].tbInPos));
			end
		end
	end
end

function Console:OnDyJoin(nDegree, me, nDyId, tbPos, GroupId)
	local tbBase = self:GetBase(nDegree);
	tbBase:OnDyJoin(me, nDyId, tbPos, GroupId);
end

--��������
function Console:ApplyDyMap(nDegree, nMapId)
	local tbBase   = self:GetBase(nDegree);
	local nDyCount = tbBase.tbCfg.nMaxDynamic;
	local nDynamicMap = tbBase.tbCfg.nDynamicMap;
	local nCurCount = #self.tbDynMapLists[nMapId];
	if nCurCount < nDyCount then
		for i=1, (nDyCount - nCurCount) do
			if (LoadDynMap(Map.DYNMAP_CONSOLE, nDynamicMap, nMapId) ~= 1) then
				print("������������ͼ������ѩ�̣�����ʧ�ܡ���");
			end
		end
	end
	return 0;
end

--������ͼ��̬���سɹ�
function Console:OnLoadMapFinish(nDyMapId, nMapId)
	self.tbDynMapLists[nMapId] = self.tbDynMapLists[nMapId] or {};
	table.insert(self.tbDynMapLists[nMapId], nDyMapId);
end
