-------------------------------------------------------------------
--File: unionlogic_gs.lua
--Author: zhangyuhua
--Date: 2009-6-6 15:17
--Describe: Gameserver �����߼�
-------------------------------------------------------------------
if not Union then --������Ҫ
	Union = {}
	print(GetLocalDate("%Y\\%m\\%d  %H:%M:%S").." build ok ..")
else
	if not MODULE_GAMESERVER then
		return
	end
end

if not Union.aUnionCreateApply then
	Union.aUnionCreateApply={};
end

-- ������������_GS1
function Union:ApplyCreateUnion_GS1(tbPlayerInfo, szUnionName, nPlayerId)
	local szMsg = "���˴���ʧ�ܣ�"

	--������ֺϷ��Լ��
	if self.aUnionCreateApply[nPlayerId] then
		szMsg = szMsg.."�����������������ύ��"
		Dialog:Say(szMsg);
		return 0;
	end

	local nLen = GetNameShowLen(szUnionName);
	if nLen < 6 or nLen > 12 then
		szMsg = szMsg.."��������Ƴ��Ȳ�����Ҫ��3��6�����֣���"
		Dialog:Say(szMsg);
		return 0;
	end
	--�Ƿ�����ĵ��ʷ�Χ
	if KUnify.IsNameWordPass(szUnionName) ~= 1 then
		szMsg = szMsg.."����ֻ�ܰ������ļ����ּ��� �� �����ţ�"
		Dialog:Say(szMsg);
		return 0;
	end
	--�Ƿ���������ִ�
	if IsNamePass(szUnionName) ~= 1 then
		szMsg = szMsg.."�Բ�����������������ư��������ִʣ��������趨"
		Dialog:Say(szMsg);
		return 0;
	end

	--����������Ƿ���ռ��
	if KUnion.FindUnion(szUnionName) ~= nil then
		szMsg = szMsg.."�Բ��𣬼���������ѱ�ռ�ã��������趨"
		Dialog:Say(szMsg);
		return 0;
	end
	
	_DbgOut("Union:CreateUnion_GS1")
	self.aUnionCreateApply[nPlayerId] = szUnionName;
	return GCExcute{"Union:ApplyCreateUnion_GC", tbPlayerInfo, szUnionName, nPlayerId};
end

-- ������������_GS2
function Union:ApplyCreateUnion_GS2(nPlayerId, nSucess)
	self.aUnionCreateApply[nPlayerId] = nil;
	if nSucess ~= 1 then
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			pPlayer.Msg("��������ʧ��");
		end
	end
	return 1;
end

-- ��������_GS2
function Union:CreateUnion_GS2(tbTongId, szUnionName, nCreateTime)
	local pUnion, nUnionId = self:CreateUnion(tbTongId, szUnionName, nCreateTime)
	if not pUnion then
		return 0;
	end
	for _, nTongId in ipairs(tbTongId) do
		KTong.Msg2Tong(nTongId, string.format("����[%s]������", pUnion.GetName()));
		Tong:JoinUnion_GS2(nTongId, szUnionName, nUnionId);
	end
	return 1;
end

-- ��ɢ����_GS2
function Union:DisbandUnion_GS2(nUnionId, nLeaveTime, bNoMsg)
	local pUnion = KUnion.GetUnion(nUnionId);
	if not pUnion then
		return 0;
	end
	
	local pTongItor = pUnion.GetTongItor();
	local nTongId = pTongItor.GetCurTongId();
	while nTongId ~= 0 do
		Tong:LeaveUnion_GS2(nTongId, pUnion.GetName(), nLeaveTime);
		if bNoMsg ~= 1 then
			KTong.Msg2Tong(nTongId, string.format("����[%s]��ɢ��", pUnion.GetName()));
		end
		nTongId = pTongItor.NextTongId();
	end
	KUnion.DelUnion(nUnionId);
	return 1;
end

-- ���Ӱ���Ա_GS2
function Union:TongAdd_GS2(nUnionId, nTongId, nCreateTime, nDataVer)
	local pUnion = KUnion.GetUnion(nUnionId);
	if not pUnion then
		return 0;
	end
	local pTong = KTong.GetTong(nTongId);
	if not pTong then
		return 0;
	end
	pUnion.AddTong(nTongId, nCreateTime);
	Domain.nDataVer = nDataVer;
	local szMsg = "["..pTong.GetName().."]����������["..pUnion.GetName().."]";
	Union:Msg2UnionTong(nUnionId, szMsg);
	return 1;
end

-- ɾ������Ա_GS2�����뿪�Ϳ���������ʽ
function Union:TongDel_GS2(nUnionId, nTongId, nPlayerId, nMethod) 
	local pUnion = KUnion.GetUnion(nUnionId)
	if not pUnion then
		return 0;
	end

	local pTong = KTong.GetTong(nTongId);
	if pTong then
		local szMsg = "["..pTong.GetName().."]�뿪������["..pUnion.GetName().."]";
		Union:Msg2UnionTong(nUnionId, szMsg);
	end

	local nRet = pUnion.DelTong(nTongId);
	if nRet == nil or nRet == 0 then
		return 0;
	end
	
	return 1;
end

--��������_GS2
function Union:ChangeMaster_GS2(nUnionId, nNewTongId, szNewMasterName)
	local pUnion = KUnion.GetUnion(nUnionId);
	if (not pUnion) then
		return 0;
	end	
	pUnion.SetUnionMaster(nNewTongId);
	local szMsg = string.format("[%s]������Ϊ������", szNewMasterName);
	Union:Msg2UnionTong(nUnionId, szMsg)
end

