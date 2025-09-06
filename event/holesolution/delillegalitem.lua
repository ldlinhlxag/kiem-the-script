------------------------------------------------------
-- �ļ�������delillegalitem.lua
-- �����ߡ���dengyong
-- ����ʱ�䣺2009-10-10 17:09:11
-- ��  ��  �����غ������ļ��������ļ����ݶ��������صĴ���
------------------------------------------------------

--��������tbBlackList�ṹ
--{
--	[filename]= {..},
--	[filename]= {..},
--}
--tbBlackList��ÿ���ӱ�Ϊ���ļ��ж������Ĵ���ͬ���Եı�(tbFileList)�����ӱ�ĽṹΪ
--{
--	[1] 		  = {tbItem1, ..., tbItemN, nTaskVar, ["Ext"]={{groupId1, supId1}, ..., {groupIdN, subIdN}}},
--  [��ҽ�ɫ��]  = {num1,    ...,   numN,  nOthers, ["Ext"] = {n,..., m}},
--	[��ҽ�ɫ��]  = {num1,    ...,   num3,  nOthers, ["Ext"] = {n,..., m}},
-- 	....,
--}(ÿһ���Ǳ��������������洢)
--����tbItem1--tbItem5���Ǳ��������ǵĽṹ��ͬ��Ϊ{g,d,p,l,nValue};nValueָ�������ߵļ�ֵ��
if not SpecialEvent.HoleSolution then
	SpecialEvent.HoleSolution = {};
end

local HoleSolution = SpecialEvent.HoleSolution;
-- HoleSolution.nListItemCount = 5;  --�������ļ���������Ʒ�ĸ���
HoleSolution.nOthersIndex = 0;  --��[others]ѡ���������Ϊ0

--------------------------------------------------------------------------------------------
if MODULE_GC_SERVER then

--���ļ��ж�ȡ���������ݣ���������д�뵽���ݿ���
--���ڶ�Ӧ��BUFF�����Ҫ��źü��Ų�ͬ���͵ı�ÿ�ű��Ӧһ���ļ����������д���ʱ��ע�ⲻҪ��BUFF�Ѿ����ڵ����ݸ��ǵ���
--TODO:��һ�����ص����⣺��һ������ļ����������Σ��ñ������ݿ���Ҳ������ݡ���Ҫ�����������ͬһ���ļ�����ȡ��Ρ�
function HoleSolution:LoadBlackListToDataBase(szPath, szIndex)
	--��Ҫʹ��һ���Ѿ����ڵ�����ʱ���˳�����
	if self.tbBlackList and self.tbBlackList[szIndex] then
		return string.format("load error! Index [%s] already exist!", szIndex);
	end
	
	local tbFile = Lib:LoadTabFile(szPath);
	if not tbFile then
		return "�ļ����ش���";
	end
	
	local szCurSeverGateWayName = _G.GetGatewayName();	--��ȡ��������������
	local tbFileList = {};
	
	local nPlayerCount = 0;    --��¼�ôζ�ȡ�����Ϣ�ĸ���
	local szLogMsg = {};	--��¼�����ļ������г��ֵ���־��Ϣ
	local nItemCountInList = 0;	-- ��¼�б���һ���漰�����ֲ�ͬ�ĵ���
	local nTaskCountInList = 0;	-- ��¼�б���һ���漰�����ֲ�ͬ����������Ĳ���
	for nId, tbParam in pairs(tbFile) do
		--����������������������assert�˳�
		if nId == 1 then
			tbFileList[1] = {};
			
			local nItemCount = 1;
			while nItemCount do		
				-- ��Ҫ�����ñ��е��ߵ����кű����1��ʼ��һ���������ģ���
				local szIndex = "Item"..nItemCount;
				if not tbParam[szIndex] then
					break;
				else
					tbFileList[1][szIndex] = self:TurnStrToNumTb(tbParam[szIndex] or ""); --itemi����
				end
				nItemCount = nItemCount + 1;
			end
		
			nItemCountInList = nItemCount - 1;	-- �����һ��1
			
			--others��ʾ��ҿ��⳥�ķ�ʽ��Ϊ��������û�и���˳�����
			if not tbParam.others then
				return  "load error! [others] not exist!";
			else
				tbFileList[1][self.nOthersIndex] = self:TurnStrToNum(tbParam.others);
				if tbFileList[1][self.nOthersIndex] == 0 then 
					return "load error! first [others] value must be more than 0";
				end
			end
			
			-- �������������������ȵĲ�����Ϣ
			local nTaskCount = 1;
			local tbReputeList = {}; 
			while nTaskCount do
				-- ��Ҫ�����ñ������������кű����1��ʼ��һ���������ģ���
				local szIndex = "Ext"..nTaskCount;
				if not tbParam[szIndex] then
					break;
				else
					tbReputeList[nTaskCount] = self:TurnStrToNumTb(tbParam[szIndex]); --Exti����
				end
				nTaskCount = nTaskCount + 1;
			end
			nTaskCountInList = nTaskCount - 1;
			tbFileList[1]["Ext"] = tbReputeList;			
		else	
			--GateWayName��ʾ������ڷ���������������Ϊ��������û�и���˳�����
			if not tbParam.GateWayName then
				return "load error! [GateWayName] not exist!";
			end
			
			--�������ļ��е�ǰ��ɫ������ҵķ������������뵱ǰ�Ĳ�ͬ, ������¼;��ͬ������¼
			if szCurSeverGateWayName == tbParam.GateWayName then						
				--�������ļ��е�ǰ��ɫ������ҵķ������������뵱ǰ����ͬ, ���ڵ�ǰ�����������Ҳ���ָ����ɫ�������ʱ������¼��ҪдLOG
				if not KGCPlayer.GetPlayerIdByName(tbParam.RoleName) then
					table.insert(szLogMsg, string.format("��¼���\"%s\"����Ϣ��������Ҳ������ڣ�", tbParam.RoleName));
				end
				
				if not tbFileList[tbParam.RoleName] then
					tbFileList[tbParam.RoleName] = {};
					
					-- ��������
					for i = 1, nItemCountInList do
						tbFileList[tbParam.RoleName][i] = (tbFileList[tbParam.RoleName][i] or 0) + self:TurnStrToNum(tbParam["Item"..i] or ""); --itemi����
					end
					
					-- others			
					tbFileList[tbParam.RoleName][self.nOthersIndex] = (tbFileList[tbParam.RoleName][self.nOthersIndex] or 0) + self:TurnStrToNum(tbParam.others); --�����Ƿ��������ֵ������
					
					-- ��������
					for i = 1, nTaskCountInList do
						if not tbFileList[tbParam.RoleName]["Ext"] then
							tbFileList[tbParam.RoleName]["Ext"] = {};
						end
						tbFileList[tbParam.RoleName]["Ext"][i] = (tbFileList[tbParam.RoleName]["Ext"][i] or 0) + self:TurnStrToNum(tbParam["Ext"..i] or "");
					end

					nPlayerCount = nPlayerCount + 1;   --����һ����¼���޸ļ���
				else
					--�����ͬһ���ļ���ͬһ����ɫ���д���1���ļ�¼�����ر���
					return "load error! rolename repetition!";
				end				
			end
		end
	end
 	
 	if nPlayerCount > 0 then
		-- self.tbBlackList = GetGblIntBuf(GBLINTBUF_BLACKLIST, 0, 1);
		if not self.tbBlackList then
			self.tbBlackList = {};
		end
		self.tbBlackList[szIndex] = tbFileList;
		--д��־��Ϣ
		for _, szLog in pairs(szLogMsg) do
			Dbg:WriteLog("HoleSolution", szLog);
		end
	
		SetGblIntBuf(GBLINTBUF_BLACKLIST, 0, 1, self.tbBlackList); 
		self:LoadDataFromDataBase_GC(1);	  --Ҫ������GSͬ������
	end
	
	return  string.format("load success! Load %d record!", nPlayerCount);
end

--GC�����ݿ��ж�ȡ����
--bUpdateData Ϊ1ʱ��������Ҫ�����ݿ������,������GC��GSͬ�����ݶ���
function HoleSolution:LoadDataFromDataBase_GC(bUpdateData)
	bUpdateData = bUpdateData or 0;
	if bUpdateData ~= 1 then
		--GBLINTBUF_BLACKLISTȫ��GblIntBuf��������ʾBUF�������ݿ�����ֵ
		self.tbBlackList = GetGblIntBuf(GBLINTBUF_BLACKLIST, 0, 1);
		if not self.tbBlackList then
			print("���ݿ�����Ϊ�գ�ֱ�ӷ���");
			return;
		end
	end

	if not self.tbBlackList then
		print("������û�г�ʼ����ֱ�ӷ���");
		return;
	end
		
	for szIndex, tbFileList in pairs(self.tbBlackList) do
		for szRecordKey, tbData in pairs(tbFileList) do 
			Dbg:WriteLog("HoleSolution", string.format("GC�������ݸ�GS��%s, %s", szIndex, tostring(szRecordKey)));
			GlobalExcute{"SpecialEvent.HoleSolution:UpdateDataFromGC", szIndex, szRecordKey, tbData};
		end
	end
end

--�޸�GC�ڴ��еĺ��������ݡ�
--bSetBufΪ1ʱ������Ҫ������д�����ݿ��У����򿴼������Ƿ�ﵽ����Ҫ��
function HoleSolution:ModifyData_GC(bSetBuf, szIndex, szRoleName)
	if not szIndex then
		return;
	end
	
	bSetBuf = bSetBuf or 0;
	
	--�޸�self.tbBlackList�е�����
	if szIndex and szRoleName then
		if not self.nCount then
			self.nCount = 0;   --���������Ѿ������˶��ٸ���ҵ�����
		end
		self.nCount = self.nCount + 1;
		Dbg:WriteLog("HoleSolution", string.format("GCɾ����������Ŀ������Ҷ���Ϊ:%s", szRoleName));
		self.tbBlackList[szIndex][szRoleName] = nil;
		if self:IsTableNull(self.tbBlackList[szIndex]) == 1 then
			self.tbBlackList[szIndex] = nil;
			GlobalExcute{"SpecialEvent.HoleSolution:DelDataFromGC", szIndex};	--GCҪ������GSͬ����ɾ���������µ�����(ɾ��һ���ļ�����Ϣ)
		else
			GlobalExcute{"SpecialEvent.HoleSolution:DelDataFromGC", szIndex, szRoleName};	--GCҪ������GSͬ����ɾ���������µ����ݣ�ֻɾ��һ����¼��
		end
	end
	
	--д���ݿ�
	if bSetBuf == 1 or self.nCount%10 == 0 then
		self:SetBufToDataBase();
	end
end

--���ڴ��еĺ���������д�����ݿ���
function HoleSolution:SetBufToDataBase()
	--GBLINTBUF_BLACKLISTȫ��GblIntBuf��������ʾBUF�����ݿ��е�����ֵ
	if not self.tbBlackList then
		Dbg:WriteLog("HoleSolution", "����������δ��ʼ��������д�����ݿ⣡");
	else
		SetGblIntBuf(GBLINTBUF_BLACKLIST, 0, 1, self.tbBlackList);
	end
end

--0��ʾ���ȣ�1��ʾ��
function HoleSolution:CompareTab(tb1, tb2)
	--���������NILֵ
	if not tb1 or not tb2 then
		return 0;
	end
	
	--ֻ�ܱȽϱ�
	if type(tb1) ~= "table" or type(tb2) ~= "table" then
		return 0;
	end
	
	--�ȶ����ű�ĳ��Ƚ����ж�
	--Lib:CountTB()�Ѿ����ǵ������������������
	if Lib:CountTB(tb1)~= Lib:CountTB(tb2) then	
		return 0;
	end
	
	for i, v in pairs(tb1) do
		if not tb2[i] then
			return 0;
		end
		
		if type(v) ~= type(tb2[i]) then		--����Ҫ��ͬ
			return 0;
		elseif type(v) == "table" then		--����������Ͷ��Ǳ��ݹ�һ��
			local nRet = self:CompareTab(v, tb2[i]);
			if nRet == 0 then
				return 0;
			end
		elseif v ~= tb2[i] then		--���Ǳ�ֱ�ӱȽ�����ֵ�Ƿ����
			return 0;			
		end
	end
	
	return 1;
end

-- �Ϸ�����
function HoleSolution:CoZoneUpdateBlackListBuf(tbCoZoneBlackListBuf)
	print("[CoZoneUpdateBlackListBuf] started!!!");
	self:LoadDataFromDataBase_GC();	
	if not self.tbBlackList then
		self.tbBlackList = {};
	end
	
	for szIndex, tbFileList in pairs(tbCoZoneBlackListBuf) do
		if self.tbBlackList[szIndex] then
			local tbTag_Buf = self.tbBlackList[szIndex][1];
			local tbTag_CoZone	= tbFileList[1];
			--�����ļ�������(szIndex)��ͬ��TAG{tbItem1, tbItem2, tbItem3, tbItem4, tbItem5, nTaskVar}��Ϣ��ͬʱ��������BUF��
			--�¼�һ������������ӷ������ݣ�����ʵ������£���������ǲ�Ӧ�ó��ֵģ����д����־
			if self:CompareTab(tbTag_CoZone, tbTag_Buf) ~= 1 then
				local szNewIndex = string.format("%s_c%s", szIndex, GetTime());
				self.tbBlackList[szNewIndex] = tbFileList;
				Dbg:WriteLog("[CoZoneUpdateBlackListBuf] Combine same index", string.format("the orginal index is [%s], the new index is [%s]", szIndex, szNewIndex));
			else			
				--�����ļ����Ժϲ�����CoZone������ݼӵ�tbBuf��
				for varIndex, tbData in pairs(tbFileList) do
					--ֻ��Ҫ����ҵ���Ϣ�ӹ�ȥ�Ϳ����ˣ������Ϣ����������string����
					if type(varIndex) == "string" then
						if self.tbBlackList[szIndex][varIndex] then
							for i = 1, #tbData do
								--��ҵ���Ϣ�ӱ����Ķ�����ֵ��ֱ���ۼ�
								self.tbBlackList[szIndex][varIndex][i] = self.tbBlackList[szIndex][varIndex][i] + tbData[i] ;
							end
						else
							self.tbBlackList[szIndex][varIndex] = tbData;
						end
					end
				end
			end
		else
			self.tbBlackList[szIndex] = tbFileList;
		end
	end
	self:SetBufToDataBase();
end

function HoleSolution:_print(tbBuf)
	for p, v in pairs(tbBuf) do
		print("=========", p, v);
		if (type(v) == "table") then
			for p1, v1 in pairs(v) do
				print("--------", p1, v1);
				if (type(v1) == "table") then
					Lib:ShowTB(v1);
				end
			end
		end
	end
end

--ע����GC������ִ�д����ݿ��ȡ���������ݵ��¼�
GCEvent:RegisterGCServerStartFunc(SpecialEvent.HoleSolution.LoadDataFromDataBase_GC, SpecialEvent.HoleSolution);
--ע����GC�����ر�ʱ������������д�뵽���ݿ��е��¼�
GCEvent:RegisterGCServerShutDownFunc(SpecialEvent.HoleSolution.SetBufToDataBase, SpecialEvent.HoleSolution);

end		--if MODULE_GC_SERVER then
--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
if MODULE_GAMESERVER then
	
--������GC��ȡ����
function HoleSolution:AskDataForGC()
	GCExcute{"SpecialEvent.HoleSolution:LoadDataFromDataBase_GC", 1};
end

--���ݲ�����ָ�����������ݸ�ֵ
function HoleSolution:UpdateDataFromGC(szIndex, szRecordKey, tbData)
	if not self.tbBlackList then
		self.tbBlackList = {};
	end

	if not HoleSolution.tbBlackList[szIndex] then
		HoleSolution.tbBlackList[szIndex] = {};
	end
	
	HoleSolution.tbBlackList[szIndex][szRecordKey] = tbData;
end

--ɾ��ָ��������һ����¼��һ���ļ�
--szRecordKeyΪnilʱ��ʾɾ������ΪszIndex�����ݣ����������������Ϊnil��ɾ����һ������ΪszIndex�ڶ�������ΪszRecordKey�����ݣ�
function HoleSolution:DelDataFromGC(szIndex, szRecordKey)
	--��һ����������Ϊ��
	if not szIndex then
		return;
	end
	
	--szRecordKeyΪnilʱ��ʾɾ������ΪszIndex������
	if not szRecordKey then
		HoleSolution.tbBlackList[szIndex] = nil;
		return;
	end
	
	--ɾ����һ������ΪszIndex�ڶ�������ΪszRecordKey������
	HoleSolution.tbBlackList[szIndex][szRecordKey] = nil;
end

--�ж�����Ƿ��ں�������
function HoleSolution:IsPlayerInList()
	if not self.tbBlackList then
		return;
	end
	
	for szIndex, tbFileList in pairs(self.tbBlackList) do
		local tbItemTag = tbFileList[1];	--������Ϣ��
		--����и���ҵļ�¼
		if tbFileList[me.szName] then
			--����������������п�ֵ���߸ò�����ѡ��ֵ��tbItemTag[self.nOthersIndex]����ĳ����������е�ֵ��ͬʱ�Ž��в���
			--���������洢��ǰ�������������������0��1��2��������ֵ����0ʱ��ʾ���Խ��в���
			local nTaskIndex = self:CanSetValue(tbItemTag[self.nOthersIndex]); 
			if nTaskIndex > 0 then
				local nBalanceValue = self:DeductIlleageItem(tbItemTag, tbFileList[me.szName]);
				GCExcute{"SpecialEvent.HoleSolution:ModifyData_GC", 0, szIndex, me.szName};	--֪ͨGC�޸�����
				if nBalanceValue > 0 then		
					self:SetTaskValue(nBalanceValue, tbItemTag[self.nOthersIndex], nTaskIndex);
				end
			end
		end
	end
	
	--������Ѿ�����Դ�У�����������������������Ƿ��ֵ��������������Դ
	local tbTaoYuanMapId = 
	{
		[1497] = 1, 
		[1498] = 1,
		[1499] = 1,
		[1500] = 1,
		[1501] = 1,
		[1502] = 1,
		[1503] = 1,
	}
	local nMapId = me.GetWorldPos();
	if self:GetBalanceValue() > 0 then
		if not tbTaoYuanMapId[nMapId] then
	 		Player:Arrest(me.szName);
	 		me.SetTask(self.TASK_COMPENSATE_GROUPID, self.TASK_SUBID_REASON, 1);	--�ڽ�����ӵ���Դʱ����ԭ�����õ����������
	   		KPlayer.SendMail(me.szName, "�۳��Ƿ���Ʒ", "������ͨ�����Ϸ����ֶ�ˢȡ���˲Ƹ���ϵͳ�Ѿ��Զ�ɾ����ǰ���Գ��е���Щ��Ʒ��");
	   		Dbg:WriteLog("HoleSolution", string.format("��ɫ��Ϊ%s�������Ϊ�Ƿ������Ϸ�Ƹ���������Դ��", me.szName));
	 	end
	end
end

-- ���������ֱ�֣�tbFile[1], tbFile[RoleName]
function HoleSolution:DeductIlleageItem(tbItemTag, tbSingleRecord)
	local nBalanceValue = 0;
	local nItemCount = 1;
	local nTaskCount = 1;
	
	-- �ȿ۳����ñ���ָ���ĵ���
	-- ��Ҫ�����ñ��е��ߵ����кű����1��ʼ��һ���������ģ���
	while tbItemTag["Item"..nItemCount] do
		local tbItemInfo = tbItemTag["Item"..nItemCount];
		local nValue = tbItemInfo[5];	--������Ʒ�ļ�ֵ��
		if tbSingleRecord[nItemCount] and tbSingleRecord[nItemCount] > 0 then			
			--���ҳ����ӵ�еĸ�������Ʒ��������һһ�۳�
			local tbFind = GM:GMFindAllRoom({tbItemInfo[1], tbItemInfo[2], tbItemInfo[3], tbItemInfo[4]});
			for _, tbDelItem in pairs(tbFind) do
				tbSingleRecord[nItemCount] = GM:_ClearOneItem(tbDelItem.pItem, tbDelItem.pItem.IsBind(), tbSingleRecord[nItemCount]);
				if tbSingleRecord[nItemCount] == 0 then break end
			end
			--�����Ʒ������
			if tbSingleRecord[nItemCount] > 0 then
				nBalanceValue = nBalanceValue + nValue * tbSingleRecord[nItemCount];
			end
		end
		
		nItemCount = nItemCount + 1;
	end
	
	-- �ٿ۳����ñ���ָ��������������
	if tbItemTag["Ext"] then
		while tbItemTag["Ext"][nTaskCount] do
			local nGoupId, nSubId = tbItemTag["Ext"][nTaskCount][1], tbItemTag["Ext"][nTaskCount][2];
			if nGoupId == 0 and nSubId == 0 then   -- �����������Ǵ�����������еģ���Ҫ���⴦��
				local nOrgPrestige = KGCPlayer.GetPlayerPrestige(me.nId);
				local nNewPrestige = nOrgPrestige - tbSingleRecord["Ext"][nTaskCount];
				-- ��������˲����۵�����������ǽ�������0����������а���ת�ɼ�ֵ�����뷨����������
				nNewPrestige = nNewPrestige > 0 and nNewPrestige or 0;
				KGCPlayer.SetPlayerPrestige(me.nId, nNewPrestige);
			else	-- �Ǹ������͵����������Ǵ�������������
				local nOrgValue = me.GetTask(nGoupId, nSubId);
				local nNewValue = nOrgValue - tbSingleRecord["Ext"][nTaskCount];
				-- ��������˲����۵�����������ǽ�������0����������а���ת�ɼ�ֵ�����뷨����������
				nNewPrestige = nNewPrestige > 0 and nNewPrestige or 0;
				me.SetTask(nGoupId, nSubId, nNewValue);
			end
				
			nTaskCount = nTaskCount + 1;
		end
	end	
	
	-- others
	nBalanceValue = nBalanceValue + tbSingleRecord[self.nOthersIndex];
	return nBalanceValue;	
end

--��һ��������ʾǷ�ļ�ֵ�����ڶ�����ʾ���⳥��ʽ����������ʾ�ṩ��ʹ�õ�������������
function HoleSolution:SetTaskValue(nValue, nTaskVar, nIndex)
	--��ȡ��ԭ����ֵ���Ƚ�ֵ�����ȥ
	local nPreValue = me.GetTask(self.TASK_COMPENSATE_GROUPID, self.tbSubTaskGroup[nIndex][1]);
	me.SetTask(self.TASK_COMPENSATE_GROUPID, self.tbSubTaskGroup[nIndex][1], nPreValue + nValue);
	me.SetTask(self.TASK_COMPENSATE_GROUPID, self.tbSubTaskGroup[nIndex][2], nTaskVar);
end

--�ж���ǰ���͵��⳥��ʽ�Ƿ����,��tbSubTaskGroup�����в�����û�п���ʹ�õĿռ䣨���򷵻ؿռ�����������򷵻�0��
--���жϸ������Ƿ���Ե��ӵ�ĳ���Ѿ�ʹ�õĿռ��ϣ�����ͬ��ֵ�������ж���û�п��еĿռ䣨ֵΪ0����������ʹ��
function HoleSolution:CanSetValue(nTaskVar)
	local nZeroIndex = 0;  --��¼�����е�һ��û���趨ֵ���������ڲ��ܵ��ӵ�����·��ظ������Թ�ʹ�á�
	for nIndex, tbGroup in pairs(self.tbSubTaskGroup) do
		local nPreValue = me.GetTask(self.TASK_COMPENSATE_GROUPID, tbGroup[2]);
		if nPreValue == nTaskVar then
			return nIndex;
		end
		--ȡ�������е�һ��û��ʹ�ÿռ������
		nZeroIndex = (nZeroIndex == 0 and nPreValue == 0) and nIndex or nZeroIndex;
	end
	
	return nZeroIndex;  --���û�п���ʹ�õĿռ䣬�򷵻�0��
end

PlayerEvent:RegisterOnLoginEvent(SpecialEvent.HoleSolution.IsPlayerInList, SpecialEvent.HoleSolution);
ServerEvent:RegisterServerStartFunc(SpecialEvent.HoleSolution.AskDataForGC, SpecialEvent.HoleSolution);

end  	--if MODULE_GAMESERVER then
--------------------------------------------------------------------------------------------
--��һ���ַ�ת��������, ��һЩ��֤����
function HoleSolution:TurnStrToNum(str)
	--�����ļ���û�ж�ĳ��������ֵʱ����Ĭ��Ϊ0
	if str == "" then
		return 0;
	end
	
	local nNum = assert(tonumber(str));
	return nNum;
end

--�����ļ��ж������ı�ʾ������Ϣ���ַ���������һ���������顣
function HoleSolution:TurnStrToNumTb(str)
	--�����ļ���û�ж�ĳITEM����ֵʱ�����������ַ���Ϊ�գ���ʱ����һ�ſձ�
	if str == "" then
		return nil;
	end
	
	local tbStr = Lib:SplitStr(str, "|");
		
	--���ݱ���ȷ����ʱ�����鳤��Ӧ��Ϊ5{g,d,p,l,nValue}��
	assert(tbStr);
	
	--���ַ�����ת�������ͱ�
	for index, szNum in pairs(tbStr) do
		tbStr[index] = tonumber(szNum);
		--�������ת�������ͣ��������������������
		assert(tbStr[index]);
	end
	
	return tbStr;
end

--ͳ����ҵ�ǰǷ�ļ�ֵ����������
function HoleSolution:GetPlayerDebetCount()
	local tbAllTaskVar, nCount = {}, 0;
	local tbBlackList = self.tbBlackList or {};
	for szIndex, tbFileList in pairs(tbBlackList) do
		if tbFileList[me.szName] and tbFileList[1][self.nOthersIndex] ~= 0 and not tbAllTaskVar[tbFileList[1][self.nOthersIndex]] then
			tbAllTaskVar[tbFileList[1][self.nOthersIndex]] = tbFileList[1][self.nOthersIndex];
			nCount = nCount + 1;
		end
	end
	
	for nIndex, tbGroup in pairs(self.tbSubTaskGroup) do
		local nArrearage = me.GetTask(self.TASK_COMPENSATE_GROUPID, tbGroup[1]);
		local nTaskVar = me.GetTask(self.TASK_COMPENSATE_GROUPID, tbGroup[2]);
		if nArrearage ~=0 and nTaskVar ~= 0 and not tbAllTaskVar[nTaskVar] then
			tbAllTaskVar[nTaskVar] = nTaskVar;
			nCount = nCount + 1;
		end
	end
	
	return nCount;
end

--����ָ��������ָ�����������ݣ�Ϊһ�ű�
--bDataBaseΪ1ʱ����ȡ���ݿ��еĺ�����������ȡ�ڴ��еĺ�������Ĭ��ֵ��
function HoleSolution:GetData(szIndex, bDataBase)
	local tbBlackList = {};
	bDataBase = bDataBase or 0;
	if bDataBase ~= 0 then
		tbBlackList = GetGblIntBuf(GBLINTBUF_BLACKLIST, 0, 1);
	else
		tbBlackList = self.tbBlackList;
	end
		
	if not tbBlackList then
		return;
	end
	
	if szIndex then
		return tbBlackList[szIndex];
	end
end

--�ж�ĳ��������������ҵ������Ƿ�Ϊ���ˡ�
--����ֵ�� 1Ϊ�棨�գ���0Ϊ�٣����գ�
function HoleSolution:IsTableNull(tbFileList)
	for key, tbData in pairs(tbFileList) do
		if key ~= 1 then
			return 0;
		end
	end
	
	return 1;
end
