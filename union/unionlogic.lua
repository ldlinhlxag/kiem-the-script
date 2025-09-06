-------------------------------------------------------------------
--File: unionlogic.lua
--Author: zhangyuhua
--Date: 2009-6-6 15:17
--Describe: ���������߼�
-------------------------------------------------------------------
if not Union then --������Ҫ
	Union = {}
	print(GetLocalDate("%Y\\%m\\%d  %H:%M:%S").." build ok ..")
end

--������ʱ�������������������ڵ�Ψһ��ˮID��
if not Union.nJourNum then
	Union.nJourNum = 0;
end

-- ͨ�����ID�������ID
function Union:GetUnionByTong(nTongId)
	local pTong = KTong.GetTong(nTongId)
	if not pTong then
		return 0;
	end
	return pTong.GetBelongUnion();
end

-- ��鴴�����˵İ���Ƿ����Ҫ��
function Union:CheckTong(tbPlayerInfo)
	if not tbPlayerInfo or type(tbPlayerInfo) ~= "table" or #tbPlayerInfo < 2 or #tbPlayerInfo > self.MAX_TONG_NUM then
		return 0, "�����Ա���������ϴ������˵������� ���˴���ʧ�ܣ�";
	end
	local nTime = GetTime();
	for i, tbInfo in ipairs(tbPlayerInfo) do
		local pTong = KTong.GetTong(tbInfo.dwTongId)
		if not pTong then
			return 0, "���������г�Ա�����а�Ტ���ǰ��������ò����������������Ȼ��������ʵ���֮���ٹ������ҡ�";
		end
		if not tbInfo.dwTongId or not tbInfo.nKinId or not tbInfo.nMemberId then 
			return 0, "���������г�Ա�����а�ᣬ���ò����������������Ȼ��������ʵ���֮���ٹ������ҡ�";
		end
		if Tong:CheckSelfRight(tbInfo.dwTongId,	tbInfo.nKinId, tbInfo.nMemberId, Tong.POW_MASTER)  ~= 1 then
			return 0, "���������г�Ա���붼Ϊ����(����Ȩ�޲�������)�����ò����������������Ȼ��������ʵ���֮���ٹ������ҡ�";
		end
		if pTong.GetBelongUnion() and pTong.GetBelongUnion() ~= 0 then
			return 0, "�Ѽ������˵İ������ܲ��봴�������ò����������������Ȼ��������ʵ���֮���ٹ������ҡ�";
		end
		if pTong.GetDomainCount() > self.MAX_TONG_DOMAIN_NUM then
			return 0, "�������г�Ա����������Ѿ�����"..self.MAX_TONG_DOMAIN_NUM.."�飬���ܴ������ˡ�";
		end
		if nTime - pTong.GetLeaveUnionTime() < Tong.TONG_LEVE_UNION_LAST then
			return 0, "�������г�Ա���˳�����δ��24Сʱ�����ܴ������ˡ�";
		end
	end
	return 1, "";
end

-- ���б��UnionId��������
function Union:CreateUnion(anTongId, szUnionName, nCreateTime)
	_DbgOut("Union:CreateUnion "..szUnionName);
	if not anTongId or type(anTongId) ~= "table" or #anTongId < 1 then
		return 0;
	end
	local pUnion, nUnionId = KUnion.AddUnion(szUnionName);
	if not pUnion then
		_DbgOut("Union:CreateUnion Add Failed");
		return nil;
	end
	--������IDΪ0
	if nUnionId == 0 then
		KUnion.DelUnion(nUnionId);
		return nil;
	end
	
	for i, nTongId in ipairs(anTongId) do
		pUnion.AddTong(nTongId, nCreateTime);
	end

	pUnion.SetCreateTime(nCreateTime);
	--��1����İ�����Ϊ����
	pUnion.SetUnionMaster(anTongId[1]);
	--������������
	pUnion.SetName(szUnionName);
	
	_DbgOut("Union:CreateUnion succeed")
	return pUnion, nUnionId;
end

-- ���������nPlayerId
function Union:GetUnionMasterId(nUnionId)
	local pUnion = KUnion.GetUnion(nUnionId);
	if not pUnion then
		return 0;
	end	
	local nMasterTongId = pUnion.GetUnionMaster()
	return Tong:GetMasterId(nMasterTongId);
end

-- ������˵��������������ѷ����������
function Union:GetUnionDomainCount(nUnionId)
	local pUnion = KUnion.GetUnion(nUnionId);
	if not pUnion then
		return 0;
	end
	
	local nUnionDomainCount = pUnion.GetDomainCount();
	local pTongItor = pUnion.GetTongItor();
	local nTongId = pTongItor.GetCurTongId();
	while nTongId ~= 0 do
		local pTong = KTong.GetTong(nTongId);
		if pTong then
			nUnionDomainCount = nUnionDomainCount + pTong.GetDomainCount();
		end
		nTongId = pTongItor.NextTongId();
	end
	return nUnionDomainCount;
end

-- ������Ტִ��
function Union:ExcutePerTong(nUnionId, fnExcute, ...)
	local pUnion = KUnion.GetUnion(nUnionId);
	if not pUnion then
		return 0;
	end
	local tbRet = {};
	local pTongItor = pUnion.GetTongItor();
	if not pTongItor then
		return 0;
	end
	local nTongId = pTongItor.GetCurTongId()
	while nTongId ~= 0 do
		
		fnExcute(nTongId, ...);
		nTongId = pTongItor.NextTongId();
	end
end

-- �㲥������Ϣ
function Union:Msg2UnionTong(nUnionId, szMsg, bDirect)
	local fnExcute = function (nTongId)
		KTong.Msg2Tong(nTongId, szMsg, bDirect or 1);
	end
	self:ExcutePerTong(nUnionId, fnExcute);
end

function Union:UnionClientExcute(nUnionId, tbArg)
	local fnExcute = function (nTongId, tbArg)
		KTongGs.TongClientExcute(nTongId, tbArg);
	end
	self:ExcutePerTong(nUnionId, fnExcute, tbArg);
end

-- �������˵�������ִ��
function Union:ExcutePerUnionDomain(nUnionId, fnExcute)
	local pUnion = KUnion.GetUnion(nUnionId);
	if not pUnion then
		return 0;
	end
	local tbRet = {};
	local pUDomainItor = pUnion.GetDomainItor()
	local nUDomainId = pUDomainItor.GetCurDomainId();
	while nUDomainId ~= 0 do
		fnExcute(nUDomainId);		-- δ��������
		nUDomainId = pUDomainItor.NextDomainId();
	end
	
	local pTongItor = pUnion.GetTongItor();
	local nTongId = pTongItor.GetCurTongId();
	while nTongId ~= 0 do
		local pTong = KTong.GetTong(nTongId);
		if pTong then
			local pDomainItor = pTong.GetDomainItor()
			local nDomainId = pDomainItor.GetCurDomainId()
			while nDomainId ~= 0 do
				fnExcute(nUDomainId);		-- �ѷ�������ĳ��������
				nDomainId = pDomainItor.NextDomainId()
			end
		end
		nTongId = pTongItor.NextTongId();
	end
	return nUnionDomainCount;
end

-- ͨ��ID��ö�Ӧ��Tong����Union
function Union:GetTongTable(nId)
	if not nId or nId == 0 then
		return 0;
	end
	local tbTong = {}
	local pTong = KTong.GetTong(nId);
	if pTong then
		table.insert(tbTong, pTong);
		return tbTong;
	end
	local pUnion = KUnion.GetUnion(nId);
	if pUnion then
		local pTongItor = pUnion.GetTongItor();
		local nTongId = pTongItor.GetCurTongId();
		while nTongId ~= 0 do
			local pTong = KTong.GetTong(nTongId);
			if pTong then
				table.insert(tbTong, pTong);
			end
			nTongId = pTongItor.NextTongId();
		end
		return tbTong;
	end
	return 0;
end

-- �������˵���ս״̬ -1:�޷���ս 0:ֻ����ս���ִ� 1:����ս����׳� 2:ֻ����ս�ܱ߰׳�
function Union:GetUnionDomainDecleaarState(nUnionId)
	local pUnion = KUnion.GetUnion(nUnionId);
	if pUnion and self:GetUnionDomainCount(nUnionId) > pUnion.GetTongCount() then
		return -1;
	end
	local nState = 0;
	local fnExcute = function (nDomainId)
		if Domain:GetDomainType(nDomainId) == "village" and nState ~= 2 then
			nState = 1;
		else
			nState = 2;
		end
	end
	self:ExcutePerUnionDomain(nUnionId, fnExcute);
	return nState;
end

	
