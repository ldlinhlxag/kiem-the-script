-- �ļ�������kingeyes.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-09-17 14:59:13
-- ��  ��  ��

SpecialEvent.CompensateGM = SpecialEvent.CompensateGM or {};
SpecialEvent.CompensateGM.KingEyes = SpecialEvent.CompensateGM.KingEyes or {};
local tbEyes = SpecialEvent.CompensateGM.KingEyes;

tbEyes.ExeFunList = {
	--key = {���ͣ�1ִ�У�2��飩,����,��������,�ж�����(1.�����ռ�, 2.����, 3.������)}
	["AddItem"] 		= {1, "AddItem", 		-1, 1},		--��Ʒ
	["AddMoney"] 		= {1, "AddMoney", 		-1, 2},		--����
	["AddBindMoney"] 	= {1, "AddBindMoney", 	-1, 3},		--������
	["AddBindCoin"] 	= {1, "AddBindCoin", 	-1, 0},		--�󶨽��
	["AddTitle"] 		= {1, "AddTitle", 		-1, 0},		--���ƺ�
	["DelTitle"] 		= {1, "DelTitle", 		-1, 0},		--���ƺ�
	["AddTongMoney"] 	= {1, "AddTongMoney", 	-1, 0},		--����ʽ�
	["AddSpeTitle"] 	= {1, "AddSpeTitle", 	-1, 0},		--���Զ���ƺ�
	["DelSpeTitle"]		= {1, "DelSpeTitle", 	-1, 0},		--���Զ���ƺ�
	["AddTaskRepute"] 	= {1, "AddTaskRepute", 	-1, 0},		--������
	["DelBaiJuTime"] 	= {1, "DelBaiJuTime", 	-1, 0},		--���׾�ʱ��
	["AddKinRepute"] 	= {1, "AddKinRepute", 	-1, 0},		--��������
	["DelTaskRepute"] 	= {1, "DelTaskRepute",	-1, 0},		--������
	["SetLuaScript"]	= {1, "SetLuaScript",	-1, 0},		--ָ��
	["AddBaseExp"]		= {1, "AddBaseExp",		-1, 0},		--��׼����
	["AddExp"]			= {1, "AddExp",			-1, 0},		--����
	["AddFactionExSum"]	= {1, "AddFactionExSum",-1, 0},		--���޻���
	["AddSkillBuff"]	= {1, "AddSkillBuff",	-1, 0},		--����buff
	["AddBuyHeShiBiSum"]= {1, "AddBuyHeShiBiSum",-1,0},		--������ϱڻ���
	["AddExOpenFuDai"]	= {1, "AddExOpenFuDai",	-1,	0},		--���Ӷ��⿪��������
	["AddExOpenQiFu"]	= {1, "AddExOpenQiFu",	-1,	0},		--���Ӷ���������
	["MinusKinRepute"]	= {1, "MinusKinRepute",	-1,	0},		--���ٽ�������
	["AddGTask"]		= {1, "AddGTask",		-1,	0},		--��ͨ�����������
	["SetGTask"]		= {1, "SetGTask",		-1,	0},		--��ͨ�����������
	["MinusGTask"]		= {1, "MinusGTask",		-1,	0},		--��ͨ�����������
	["AddXiulianTime"]	= {1, "AddXiulianTime",	-1,	0},		--����������ʱ��
	["GiveBazhuStatuary"]		= {1, "GiveBazhuStatuary",			-1,	0},	--�����������֮ӡ�����ʸ�
	["GiveKuaFuLianSaiStatuary"]= {1, "GiveKuaFuLianSaiStatuary",	-1,	0},	--�������������������ʸ�
	["AddHonor"]		= {1, "AddHonor",		-1,	0},		--��������ֵ
	["ClearMarry"]		= {1, "ClearMarry",		-1,	0},		--���Ԥ�����񣬲��۳����
	["DelItem"]			= {1, "DelItem", 		-1, 0},		--�۳���Ʒ���Լ����Ʒ�Ƿ����
};
--ת��������������������飩
function tbEyes:TransParam(szKey, szParam)
	
	if not szKey or not szParam then
		return "";
	end
	if not self.ExeFunList[szKey] then
		print("��kingeyes��Error,û�����Keyֵ", szKey, szParam);
		return "";
	end
	szParam = Lib:ClearStrQuote(szParam);
	local szString = "";
	szParam = string.gsub(szParam,[[\\]], "<&xiegan>");
	szParam = string.gsub(szParam,[[\|]], "<&shuxian>");
	local tbParam = Lib:SplitStr(szParam, "|");	
	if self.ExeFunList[szKey][3] >= 0 and #tbParam > self.ExeFunList[szKey][3] then
		print("��kingeyes��Error,��������", szKey, szParam);
		return "";
	end
	for i = 1 , #tbParam  do
		local szParam1 = tbParam[i] or "";
		szParam1 = string.gsub(szParam1,"<&xiegan>", [[\]]);
		szParam1 = string.gsub(szParam1,"<&shuxian>", [[|]]);
		szParam1 = string.format([["%s"]],szParam1);
		
		if i ~= #tbParam then	
			szString = szString..szParam1..",";
		else
			szString = szString..szParam1;
		end
	end	
	return szString;
end

--ת���ɻϵͳ��������
function tbEyes:TransManagerFun(szKey, szParam)
	if not szKey or not szParam then
		return "";
	end
	if not self.ExeFunList[szKey] then
		print("��kingeyes��Error,û�����Keyֵ", szKey, szParam);
		return "";
	end	
	local szTransParam = self:TransParam(szKey, szParam)
	local szManagerFun = self.ExeFunList[szKey][2] .. ":" .. szTransParam;
	return szManagerFun;
end

function tbEyes:CheckFun(szFun, szParam)
	if EventManager.tbFun.tbLimitParamFun[szFun] and EventManager.tbFun.tbLimitParamFun[szFun] then
		return EventManager:CheckszFun(szFun, szParam);
	end
end

--ִ�к���
function tbEyes:DoFun(szKey, szParam)
	if not self.ExeFunList[szKey] then
		print("��kingeyes��Error,û�����Keyֵ", szKey, szParam);
		return 0;
	end
	local nType = self.ExeFunList[szKey][1];
	local szFun	= self.ExeFunList[szKey][2];
	if nType == 1 then			
		local nFlag = EventManager:ExeszFun(szFun, szParam);
		return nFlag;
	end		
	if nType == 2 then
		local nFlag, szMsg = EventManager:CheckszFun(szFun, szParam);
		if nFlag == 1 then
			return 0, szMsg;
		end
		return 1;
	end
	return 0;
end
