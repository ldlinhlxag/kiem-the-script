--���⽱��ͨ�ú���GS,Client
--����� 2008.07.24
--*_Check�ɵ�������..
--DoExecute�����*_Check�ɶԳ���.
--�ӿڣ�local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("szType") 
--�ӿڣ�SpecialEvent.ExtendAward:DoExecute(tbFunExecute);

local ExtendAward = {};
SpecialEvent.ExtendAward = SpecialEvent.ExtendAward or ExtendAward;

--���нӿ�
ExtendAward.tbInterFaceFun = 
{
	["Battle"]			= "Battle_Check",		--ս������
	["FactionBattle"]	= "FactionBattle_Check",--���ɾ���
	["GuessGame"]		= "GuessGame_Check",	--�µ���
	["LinkTask"]		= "LinkTask_Check",		--����ͬ
	["KinGame"]			= "KinGame_Check",		--����ؿ�
	["LifeSkill"]		= "LifeSkill_Check",	--������䷽
	["WantedBoss"]		= "WantedBoss_Check",	--�ٸ�ͨ��boss����
	["FinishWanted"]	= "FinishWanted_Check",	--��ɹٸ�ͨ������(������ʱ)
	["KinQizi"]			= "KinQizi_Check",		--���忾����	--houxuan: 08.11.10
	["EnhanceEquip"]	= "EnhanceEquip_Check",	--װ��ǿ������  --houxuan: 08.11.10
	["MerchantTask"]	= "MerchantTask_Check",	--���һ���̻�����
	["ArmyCampTask"]	= "ArmyCampTask_Check",	--���һ�ξ�Ӫ��������
	["BaiHuTang"]		= "BaiHuTang_Check",	--�׻���ͨ���ڼ���
	["BaiHuTangBoss"]	= "BaiHuTangBoss_Check",--�׻���Boss����ʱ,ɱ��boss����ҺͶ����Ա����
	["XoyoGame"]		= "XoyoGame_Check",		--��ң��ͨ��
	["KinWeekAction"]	= "KinWeekAction_Check",--������Ŀ���콱
	["Wlls"]			= "Wlls_Check",			--������������ʤ���콱
	["JYAndSLDeath"]	= "JYAndSLDeath_Check", --��Ӣ����������ʱ
	["PickGouhuoTeam"]	= "PickGouhuoTeam_Check",
	["ArmyCampBoss"]	= "ArmyCampBoss_Check",	--��ɱ��Ӫ����boss
	["QinlingBoss"]		= "QinlingBoss_Check",	--��ɱ�������boss
	["DomainbattleTask"] = "DomainbattleTask_Check", --��������
}

ExtendAward.tbFunExecute 		= ExtendAward.tbFunExecute or {};
ExtendAward.tbFreeCount 		= ExtendAward.tbFreeCount or {};
ExtendAward.tbFreeCountScript	= ExtendAward.tbFreeCountScript or {};

function ExtendAward:Init()
	self.tbInit = self.tbInit or {};
	for szType, szFun in pairs(self.tbInterFaceFun) do
		self.tbInit[szFun] = {};
	end
end
ExtendAward:Init();

function ExtendAward:GetInitTable(szFun)
	return self.tbInit[szFun] or {};
end

ExtendAward:GetInitTable("KinQizi_Check").nBaseExp = 1;

--tbExe: {�ص�����, arg1, arg2 ...}
--ִ��ʱ������Ѷ�Ӧcheck�յ��Ĳ����ŵ�tbExe����ִ��
--���� tbExe = {fun, a, b}, ��ӦcheckΪ function fun_check(c,d)
--����fun�ᰴ˳���յ� a,b,c,d�ĸ�����
function ExtendAward:RegExecute(szType, tbExe, nNeedFree, tbExeCheckFree)
	self.tbFunExecute[szType] = self.tbFunExecute[szType] or {};
	self.tbFreeCount[szType]  = self.tbFreeCount[szType] or 0;
	self.tbFreeCountScript[szType] = self.tbFreeCountScript[szType] or {};
	local nAdd = 1;
	for _, tbFunExe in pairs(self.tbFunExecute[szType]) do
		if tbFunExe[1] == tbExe[1] then
			nAdd = 0;
			break;
		end
	end
	if nAdd == 1 then
		table.insert(self.tbFreeCountScript[szType], tbExeCheckFree);
		table.insert(self.tbFunExecute[szType], tbExe);
		self.tbFreeCount[szType] = self.tbFreeCount[szType] + (tonumber(nNeedFree) or 0);
	end
end

function ExtendAward:UnRegExecute(szType, tbExe, nNeedFree, tbExeCheckFree)
	if self.tbFunExecute[szType] then
		local tbTempExe = {};
		for i, tbExeP in pairs(self.tbFunExecute[szType]) do
			if tbExeP[1] ~= tbExe[1] or tbExeP[2] ~= tbExe[2] then
				table.insert(tbTempExe, tbExeP);
			else
				self.tbFreeCount[szType] = self.tbFreeCount[szType] - (tonumber(nNeedFree) or 0);
				if self.tbFreeCount[szType] < 0 then
					self.tbFreeCount[szType] = 0;
				end	
			end
		end
		self.tbFunExecute[szType] = tbTempExe;
		
		local tbTempExeCheckFree = {};
		for i, tbExeP in pairs(self.tbFreeCountScript[szType]) do
			if tbExeP[1] ~= tbExeCheckFree[1] or tbExeP[2] ~= tbExeCheckFree[2] then
				table.insert(tbTempExeCheckFree, tbExeP);
			end
		end
		self.tbFreeCountScript[szType] = tbTempExeCheckFree;
	end
end

function ExtendAward:DoCheck(szType, ...)
	if not self.tbInterFaceFun[szType] then
		return 0;
	end
	
	if self[self.tbInterFaceFun[szType]] then
		local nFreeCount, tbFunExecute, szExtendInfo, tbProductSet = self[self.tbInterFaceFun[szType]](self, unpack(arg))
		if self.tbFunExecute[szType] then
			local tbFun = {};
			for _, tbExe in pairs(self.tbFunExecute[szType]) do
				local tbTempExe = {}
				for _, v in ipairs(tbExe) do
					table.insert(tbTempExe, v);
				end
				for _, v in ipairs(arg) do
					table.insert(tbTempExe, v);
				end
				table.insert(tbFun, tbTempExe);
			end
			for _, tbExe in pairs(self:RegistrationExecute(tbFun)) do
				table.insert(tbFunExecute, tbExe);
			end
		end
		
		if self.tbFreeCountScript[szType] then
			for _, tbExe in pairs(self.tbFreeCountScript[szType]) do
				local tbTempExe = {}
				for _, v in ipairs(tbExe) do
					table.insert(tbTempExe, v);
				end
				for _, v in ipairs(arg) do
					table.insert(tbTempExe, v);
				end
				nFreeCount = nFreeCount + tbTempExe[1](unpack(tbTempExe,2))
			end
		end
		nFreeCount = nFreeCount + (self.tbFreeCount[szType] or 0)
		return nFreeCount, tbFunExecute, szExtendInfo, tbProductSet;
	end
	return 0;
end

function ExtendAward:DoExecute(tbExecute)
	Lib:CallBack({self.DoExecuteBase, self, tbExecute});
end

function ExtendAward:DoExecuteBase(tbExecute)
	if not tbExecute then
		return 0; 
	end
	for _, tbfun in ipairs(tbExecute) do
		tbfun.fun(unpack(tbfun.tbParam));
	end
end

function ExtendAward:RegistrationExecute(tbExecute)
	local tbFunExecute = {};
	for _, tbFunParam in ipairs(tbExecute) do
		if tbFunParam[1] then
			local tbTemp = {fun=tbFunParam[1], tbParam={}}
			for nId, param in ipairs(tbFunParam) do
				if nId ~= 1 then
					table.insert(tbTemp.tbParam, param);
				end
			end
			table.insert(tbFunExecute, tbTemp);
		end
	end
	return tbFunExecute;
end

--���ú���,�����Ʒ
function ExtendAward:AddItems(pPlayer, nGenre, nDetail, nParticular, nLevel, nSeries, nCount, nEnhTimes, nLucky, tbGenInfo, nVersion, uRandSeed, nWay)
	nCount = nCount or 1;
	for i=1, nCount do
		pPlayer.AddItem(nGenre, nDetail, nParticular, nLevel, nSeries, nCount, nEnhTimes, nLucky, tbGenInfo, nVersion, uRandSeed, nWay)
	end
	return nCount;
end	


--�ν���⽱�� nPoint=�ν����,nLevelս���ȼ���1������2�м���3�߼�
function ExtendAward:Battle_Check(pPlayer, nPoint, nLevel)
	local tbExecute = {};
	local nFreeCount = 0;
	local szExtendInfo = "";
	--���⺯������
	
	--���⺯������
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute, szExtendInfo;
end


--���ɾ������⽱�� nPoint=����, nRank=����, nTrunk=��������
function ExtendAward:FactionBattle_Check(pPlayer, nPoint, nRank, nTrunk)
	local tbExecute = {};
	local nFreeCount = 0;
	local szExtendInfo = "";
	--���⺯������

	--���ɾ���������2400�����Ͻ���2��������
	if nPoint >= 2400 then
		table.insert(tbExecute, {self.AddItems, self, pPlayer, 18, 1, 80, 1, 0, 2});
		nFreeCount = nFreeCount + 2;
	end
	
	if nTrunk > 0 then
		if SpecialEvent.Girl_Vote:CheckState(2, 6) == 1 then
			nFreeCount = nFreeCount + 2;
			table.insert(tbExecute, {SpecialEvent.Girl_Vote.GetRose, SpecialEvent.Girl_Vote, pPlayer, nTrunk});
		end
	end
	
	--���⺯������
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute, szExtendInfo;
end

--�µ��ն��⽱�� nPoint=����
function ExtendAward:GuessGame_Check(pPlayer, nPoint)
	local tbExecute = {};
	local nFreeCount = 0;
	--���⺯������
	
	--�µ���100�ֽ���һ��������200�ֽ���2��������300�ֽ���3��������
	if nPoint >= 100 then
		local nFuDaiCount = 1;
		if nPoint >= 300 then
			nFuDaiCount = 3;
		elseif nPoint >= 200 then
			nFuDaiCount = 2;
		end
		table.insert(tbExecute, {self.AddItems, self, pPlayer, 18, 1, 80, 1, 0, nFuDaiCount});
		nFreeCount = nFreeCount + nFuDaiCount;
	end
	--���⺯������
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute;
end


--����ͬ���⽱�� nTaskNum=��ɴ���
function ExtendAward:LinkTask_Check(pPlayer, nTaskNum)
	local tbExecute = {};
	local nFreeCount = 0;
	--���⺯������
	
	--���⺯������
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute;
end

--����ؿ����⽱�� nCoinNum=Ǯ����Ǯ������,�ؿ�ÿ�һ�һ�����ӣ�nCoinNum�̶�����100
function ExtendAward:KinGame_Check(pPlayer, nCoinNum)
	local tbExecute = {};
	local nFreeCount = 0;
	--���⺯������

	--����ؿ�,ÿ��һ�����ӣ���һ������
	table.insert(tbExecute, {self.AddItems, self, pPlayer, 18, 1, 80, 1, 0, 1});
	nFreeCount = nFreeCount + 1;
	
	--���⺯������
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute;
end

--������䷽����,nRecipeId=�䷽Id
function ExtendAward:LifeSkill_Check(pPlayer, nRecipeId)
	local tbExecute = {};
	local nCanProduct = 0;
	local szExtendInfo = "";
	local tbProductSet = {};
	--���⺯������
	if nRecipeId == SpecialEvent.ZhongQiu2008.RECIPEID_MOONCAKE then
		nCanProduct = -1;
		szExtendInfo = "<color=yellow>��Ѿ����������䷽��ʧЧ��<color>";
		if SpecialEvent.ZhongQiu2008:CheckTime() == 1 then
			nCanProduct = 1;
			if pPlayer then
				tbProductSet, szExtendInfo = SpecialEvent.ZhongQiu2008:GetProductSet(pPlayer);
			end
		end
	end
	
	--���⺯������
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nCanProduct, tbFunExecute, szExtendInfo, tbProductSet;	
end


--�ٸ�ͨ������
function ExtendAward:WantedBoss_Check(pPlayer)
	local tbExecute = {};
	local nFreeCount = 0;
	local szExtendInfo = "";
	local tbProductSet = {};
	
	--���⺯������
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute, szExtendInfo, tbProductSet;	
end

function ExtendAward:FinishWanted_Check(pPlayer)
	local tbExecute = {};
	local nFreeCount = 0;
	local szExtendInfo = "";
	local tbProductSet = {};
	
	--���⺯������
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute, szExtendInfo;	
end

--װ��ǿ������
function ExtendAward:EnhanceEquip_Check(pPlayer)
	local tbExecute = {};
	local nFreeCount = 0;
	local nExpMultipe  = 1;
	local nFlag1 = pPlayer.GetSkillState(881);	--��������
	local nFlag2 = pPlayer.GetSkillState(892);  --��ɽ20��������ID
	
	if (nFlag1 == 1) then
		nExpMultipe = nExpMultipe * 0.8;
	elseif (nFlag2 == 1) then
		nExpMultipe = nExpMultipe * 0.8;
	end;
	
	--���⺯������
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute, nExpMultipe;
end;

--�������ƣ������Ӿ��飩
function ExtendAward:KinQizi_Check(pPlayer)
	local tbExecute = {};
	local nFreeCount = 0;
	local nBaseExp = 1;
	nBaseExp = nBaseExp * (self:GetInitTable("KinQizi_Check").nBaseExp or 1);
	
	--���⺯������
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute, nBaseExp;
end;

--���һ���̻�����(�޷��жϱ����ռ䣬Check��ֱ��ִ��)
function ExtendAward:MerchantTask_Check(pPlayer)
	local tbExecute = {};
	local nFreeCount = 0;
	--���⺯������
	
	
	if SpecialEvent.Girl_Vote:CheckState(2, 6) == 1 then
		nFreeCount = nFreeCount + 2; 
		table.insert(tbExecute, {SpecialEvent.Girl_Vote.GetRose, SpecialEvent.Girl_Vote, pPlayer, 5});
	end
	
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute;	
end

--���һ�ξ�Ӫ��������
function ExtendAward:ArmyCampTask_Check(pPlayer)
	local tbExecute = {};
	local nFreeCount = 0;
	--���⺯������	
	
	if SpecialEvent.Girl_Vote:CheckState(2, 6) == 1 then
		nFreeCount = nFreeCount + 1;
		table.insert(tbExecute, {SpecialEvent.Girl_Vote.GetRose, SpecialEvent.Girl_Vote, pPlayer, 1});
	end
	
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute;		
end

--ͨ���׻��õڼ���(nLevel:1:����,2�߼�; nFloor����)
function ExtendAward:BaiHuTang_Check(pPlayer, nLevel, nFloor)
	local tbExecute = {};
	local nFreeCount = 0;
	--���⺯������
	if nFloor == 3 then
		local nCanGet = 1;
		if TimeFrame:GetState("OpenLevel99") == 1 and nLevel ==1 then
			nCanGet = 0;
		end
		
		if nCanGet == 1 and SpecialEvent.Girl_Vote:CheckState(2, 6) == 1 then
			nFreeCount = nFreeCount + 1;
			table.insert(tbExecute, {SpecialEvent.Girl_Vote.GetRose, SpecialEvent.Girl_Vote, pPlayer, 1});
		end
		
	end
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute;	
end

--�׻���Boss����ʱ(nLevel:1:����,2�߼�; nFloor����)
function ExtendAward:BaiHuTangBoss_Check(pPlayer, nLevel, nFloor)
	local tbExecute = {};
	local nFreeCount = 0;
	--���⺯������
	
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute;	
end

--��ң��ͨ��(nFloor����)
function ExtendAward:XoyoGame_Check(pPlayer, nFloor)
	local tbExecute = {};
	local nFreeCount = 0;
	--���⺯������	
	if nFloor == 3 then
		if SpecialEvent.Girl_Vote:CheckState(2, 6) == 1 then
			nFreeCount = nFreeCount + 1;
			table.insert(tbExecute, {SpecialEvent.Girl_Vote.GetRose, SpecialEvent.Girl_Vote, pPlayer, 1});
		end
	end
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute;	
end

--������Ŀ���콱(nTrunk������)
function ExtendAward:KinWeekAction_Check(pPlayer, nTrunk)
	local tbExecute = {};
	local nFreeCount = 0;
	--���⺯������	
	
	if nTrunk > 0 then
		if SpecialEvent.Girl_Vote:CheckState(2, 6) == 1 then
			nFreeCount = nFreeCount + 2;
			table.insert(tbExecute, {SpecialEvent.Girl_Vote.GetRose, SpecialEvent.Girl_Vote, pPlayer, nTrunk});
		end	
	end
	
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute;	
end

--����������������
function ExtendAward:Wlls_Check(pPlayer)
	local tbExecute = {};
	local nFreeCount = 0;
	--���⺯������	
	
	if SpecialEvent.Girl_Vote:CheckState(2, 6) == 1 then
		nFreeCount = nFreeCount + 1;
		table.insert(tbExecute, {SpecialEvent.Girl_Vote.GetRose, SpecialEvent.Girl_Vote, pPlayer, 1});
	end
	
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute;	
end

function ExtendAward:JYAndSLDeath_Check(pPlayer)
	local tbExecute = {};
	local nFreeCount = 0;
	--���⺯������	
	
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute;		
end

function ExtendAward:PickGouhuoTeam_Check(pPlayer)
	local tbExecute = {};
	local nFreeCount = 0;
	--���⺯������	
	
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute;	
end

-- ��ɱ��Ӫ����boss
function ExtendAward:ArmyCampBoss_Check(pPlayer)
	local tbExecute = {};
	local nFreeCount = 0;
	-- extra
	
	-- end
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute;	
end

-- ��ɱ��������boss
function ExtendAward:QinlingBoss_Check(pPlayer)
	local tbExecute = {};
	local nFreeCount = 0;
	-- extra
	
	-- end
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute;		
end

--��������
function ExtendAward:DomainbattleTask_Check(pPlayer, nScore)
	local tbExecute = {};
	local nFreeCount = 0;
	-- extra
	
	-- end
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return nFreeCount, tbFunExecute;	
end
