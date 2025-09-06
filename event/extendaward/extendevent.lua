--����ʱ��ͨ�ú���GS,Client
--����� 2008.07.24
--*_Check�ɵ�������..
--DoExecute�����*_Check�ɶԳ���.
--�ӿڣ�SpecialEvent.ExtendEvent:DoExecute("szType");
--�ӿ�:�Ժ�����ע���¼��ӿ�
--ʹ�ýӿ�1ע�᣺SpecialEvent.ExtendEvent:RegExecute(szType, tbExe)
--ʹ�ýӿ�2ע����SpecialEvent.ExtendEvent:UnRegExecute(szType, tbExe)

local ExtendEvent = {};
SpecialEvent.ExtendEvent = ExtendEvent;

--���нӿ�
ExtendEvent.tbInterFaceFun = 
{
	["CallNpc_BaiHuTang"]	= "CallNpc_BaiHuTang",	--�׻��ÿ���ˢnpc�󴥷�
	["Open_Battle"]			= "Open_Battle",		--�ν�ս����������
	["Open_Treasure"]		= "Open_Treasure",		--�ر�ͼ������������
	["Open_ArmyCamp"]		= "Open_ArmyCamp",		--��Ӫ������������
	["Open_KinGame"]		= "Open_KinGame",		--����ؿ���������
	["Open_FourfoldMap"]	= "Open_FourfoldMap",	--4���ؾ���ͼ��������
	["Open_FactionBattle"]	= "Open_FactionBattle",	--���ɾ�����������	
	["Npc_Death"]			= "Npc_Death",			--��������npc��������	
}

ExtendEvent.tbFunExecute = {};
function ExtendEvent:Init()
	self.tbInit = self.tbInit or {};
	for szType, szFun in pairs(self.tbInterFaceFun) do
		self.tbInit[szFun] = {};
	end
end
ExtendEvent:Init();

function ExtendEvent:GetInitTable(szFun)
	return self.tbInit[szFun] or {};
end

--tbExe: {�ص�����, arg1, arg2 ...}
--ִ��ʱ������Ѷ�Ӧcheck�յ��Ĳ����ŵ�tbExe����ִ��
--���� tbExe = {fun, a, b}, ��ӦcheckΪ function fun_check(c,d)
--����fun�ᰴ˳���յ� a,b,c,d�ĸ�����
function ExtendEvent:RegExecute(szType, tbExe)
	self.tbFunExecute[szType] = self.tbFunExecute[szType] or {};

	local nAdd = 1;
	for _, tbFunExe in pairs(self.tbFunExecute[szType]) do
		if tbFunExe[1] == tbExe[1] then
			nAdd = 0;
			break;
		end
	end
	if nAdd == 1 then
		table.insert(self.tbFunExecute[szType], tbExe);
	end
end

function ExtendEvent:UnRegExecute(szType, tbExe)
	if self.tbFunExecute[szType] then
		local tbTempExe = {};
		for i, tbExe in pairs(self.tbFunExecute[szType]) do
			if tbExe[1] ~= tbExe[1] then
				table.insert(tbTempExe, tbExe);
			end
		end
		self.tbFunExecute[szType] = tbTempExe;
	end
end

function ExtendEvent:DoExecute(szType, ...)
	Lib:CallBack({self.DoExecuteBase, self, szType, unpack(arg)});
end

function ExtendEvent:DoExecuteBase(szType, ...)
	local tbExecute = {};
	if not self.tbInterFaceFun[szType] then
		return 0;
	end
	if self[self.tbInterFaceFun[szType]] then
		tbExecute = self[self.tbInterFaceFun[szType]](self, unpack(arg))
	end
	for _, tbfun in ipairs(tbExecute) do
		tbfun.fun(unpack(tbfun.tbParam));
	end
	if ExtendEvent.tbFunExecute[szType] then
		
		for _, tbExe in ipairs(ExtendEvent.tbFunExecute[szType]) do
			local tbTemp = {};
			for _, v in ipairs(tbExe) do
				table.insert(tbTemp, v);
			end
			for _, v in ipairs(arg) do
				table.insert(tbTemp, v);
			end
			tbTemp[1](unpack(tbTemp,2));
		end
	end	
end

function ExtendEvent:RegistrationExecute(tbExecute)
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

--�׻����ٻ�npc��
--nMapId	-�׻��õ�ͼId
--nLevel	-�׻��õȼ�(1.������2�߼���3�ƽ�); 
--nStep		-������1.һ�㣬2.���㣬3.���㣩;
--nBoss		-�Ƿ���ˢbossʱ������1.boss��0.��ͨ�֣�
function ExtendEvent:CallNpc_BaiHuTang(nMapId, nLevel, nStep, nBoss)
	local tbExecute = {};
	
	--2008ʥ���. 2009.01.10���ɾ��
	if SpecialEvent.Xmas2008:Check() == 1 then
		if nStep == 1 and nBoss == 1 then
			SpecialEvent.Xmas2008:CallNpc(1, nMapId);	
		elseif nStep == 2 and nBoss == 1 then
			SpecialEvent.Xmas2008:CallNpc(2, nMapId);
		elseif nStep == 3 and nBoss == 1 then
			SpecialEvent.Xmas2008:CallNpc(3, nMapId);
		end
	end
	
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return tbFunExecute;
end


--�ν���״̬
--nMapId		-�ν��ͼId
--nLevel		-�ν�ȼ�(1.�������ݣ�2.�м����裬3.�߼�����); 
--nRuleType		-�ν�����(1.ɱ¾ģʽ, 2.Ԫ˧����ģʽ 3.����ģʽ)
--nSeqNum		-����ڼ���
--nBattleMapType-ս������(1.����֮ս, 2.����ԭ֮ս 3.�����֮ս)
function ExtendEvent:Open_Battle(nMapId, nLevel, nType, nSeq, nBattleMapType)
	local tbExecute = {};
	
	local tbMapType = {
		[187]=1,[188]=1,[189]=1,[263]=1,[264]=1,[265]=1,[284]=1,[290]=1,[295]=1, --����֮ս
		[190]=2,[191]=2,[192]=2,[266]=2,[267]=2,[268]=2,[285]=2,[291]=2,[296]=2, --����ԭ֮ս
		[193]=3,[194]=3,[195]=3,[269]=3,[270]=3,[271]=3,[286]=3,[292]=3,[297]=3, --�����֮ս
		[1635]=4,[1636]=4,[1637]=4,[1638]=4,[1639]=4,[1640]=4,[1641]=4,[1642]=4,[1643]=4, --������֮ս
	};
	
	--2008ʥ���. 2009.01.10���ɾ��
	if SpecialEvent.Xmas2008:Check() == 1 then
		local nMapType = tbMapType[nMapId];
		if nMapType then
			local nEventType = 5;
			if nMapType == 1 then
				nEventType = 5;
			elseif nMapType == 2 then
				nEventType = 6;
			elseif nMapType == 3 then
				nEventType = 7;
			elseif nMapType ==4 then
				nEventType = 8;
			end
			SpecialEvent.Xmas2008:CallNpc(nEventType, nMapId);
		end
	end
	
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return tbFunExecute;
end

--�ر�ͼ��������״̬
--nLevel			-�����ȼ�(1.������2.�м���3.�߼�); 
--nMapId			-������̬��ͼId
--nMapTemplateId	-����ģ���ͼId
function ExtendEvent:Open_Treasure(nLevel, nMapId, nMapTemplateId)
	local tbExecute = {};
			
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return tbFunExecute;
end

--��Ӫ��������״̬
--nMapId			-������̬��ͼId
--nMapTemplateId	-����ģ���ͼId
function ExtendEvent:Open_ArmyCamp(nMapId, nMapTemplateId)
	local tbExecute = {};
			
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return tbFunExecute;
end

--����ؿ�����״̬
--nLevel			-�ؿ�����ȼ�
--nCount			-�ؿ������Ա����
function ExtendEvent:Open_KinGame(nLevel, nCount)
	local tbExecute = {};
			
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return tbFunExecute;
end

--�ؾ�����״̬
--nLevel			-�ؾ�����ȼ�
--nMapId			-�ؾ���̬��ͼId
function ExtendEvent:Open_FourfoldMap(nLevel, nMapId)
	local tbExecute = {};
			
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return tbFunExecute;
end

--���ɾ�������״̬
--nFaction			-����Id
--nMapId			-���ɾ�����ͼId
function ExtendEvent:Open_FactionBattle(nFaction, nMapId)
	local tbExecute = {};
	
	--2008ʥ���. 2009.01.10���ɾ��
	if SpecialEvent.Xmas2008:Check() == 1 then
		SpecialEvent.Xmas2008:CallNpc(4, nMapId);
	end

	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return tbFunExecute;
end

function ExtendEvent:Npc_Death(pNpc, pKillPlayer)
	local tbExecute = {};
	
	--local nNpcType 	= pNpc.GetNpcType();		--npc����
	--local pPlayer  	= pKillPlayer.GetPlayer();	--ɱ��npc�����
	
	local tbFunExecute = self:RegistrationExecute(tbExecute)
	return tbFunExecute;
end

