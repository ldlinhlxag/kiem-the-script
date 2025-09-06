
if (not SpecialEvent.tbQQShow) then
	SpecialEvent.tbQQShow = {};
end
local tbQQShow = SpecialEvent.tbQQShow;


tbQQShow.QQSHOWNUMBER_PERSERVER = 2500; -- ÿ����������ŵ���Ŀ

--------------------------------------------------------------------
-- GS
if MODULE_GAMESERVER then
	-- ��Ҫ����QQShow������ķ�������
	tbQQShow.tbServerList = 
	{
		["gate0601"]=1,["gate0602"]=1,["gate0603"]=1,["gate0604"]=1,["gate0605"]=1,["gate0606"]=1,["gate0607"]=1,["gate0608"]=1,["gate0609"]=1,["gate0610"]=1,
		["gate0611"]=1,["gate0612"]=1,["gate0613"]=1,["gate0614"]=1,["gate0615"]=1,["gate0616"]=1,["gate0617"]=1,["gate0618"]=1,["gate0619"]=1,["gate0620"]=1,
		["gate0502"]=1,["gate0503"]=1,["gate0504"]=1,["gate0505"]=1,["gate0506"]=1,["gate0507"]=1,["gate0508"]=1,["gate0509"]=1,["gate0510"]=1,
	}
	
	
	-- ����ʱ��
	tbQQShow.TIME_START 	= 200810152400;	 	--��ʼʱ��
	tbQQShow.TIME_END   	= 200811142400;		--����ʱ��

	-- ��Ҫ��ü��������͵ȼ�
	tbQQShow.nLevelMinLimit = 30;
	
	-- ����������������ռ�õ�QQShowId(Num)
	tbQQShow.tbQQShowTaskValue = {2038, 5};
	
	function tbQQShow:GetQQShowSNList()
		-- ֻ��ָ��������ȥ���ļ�
		
		if (not self.tbQQShowSNList) then
			local szGatewayName = GetGatewayName();
			self.szQQShowSNFile = string.format("\\setting\\event\\qqshow\\qqshow_%s.txt", szGatewayName);
			if (self.tbServerList[szGatewayName]) then
				self.tbQQShowSNList = Lib:LoadTabFile(self.szQQShowSNFile);
			else
				self.tbQQShowSNList = {};
			end
		end
				
		return self.tbQQShowSNList;
	end
	
	-- ����������ʱ�Ƿ���QQShow�
	function tbQQShow:CheckOpen()
		local szGatewayName = GetGatewayName();
		local nDate = tonumber(GetLocalDate("%Y%m%d%H%M"));
		if (nDate >= self.TIME_START and nDate < self.TIME_END and self.tbServerList[szGatewayName]) then
			return 1;
		end
	end
	
	
	-- ��GC����һ��QQShowSN
	function tbQQShow:QQShowApplySN(nPlayerId)
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if (not pPlayer) then
			return;
		end
		
		local szGatewayName = GetGatewayName();
		
		-- ���������Ƿ��м����뷢��
		if (not self.tbServerList[szGatewayName]) then
			self:Msg2Player(pPlayer, "ֻ���¿�������������ȡQQ�㼤���롣");
			return;
		end
		
		-- �ȼ��Ƿ�ﵽ
		if (pPlayer.nLevel < self.nLevelMinLimit) then
			self:Msg2Player(pPlayer, "���ĵȼ�����"..self.nLevelMinLimit.."��");
			return;
		end
		
		-- �Ƿ��Ѿ����		
		local nQQShowSNNum = pPlayer.GetTask(unpack(self.tbQQShowTaskValue));
		if (nQQShowSNNum ~= 0) then
			local szQQShowSN = self:GetQQShowSN(nQQShowSNNum);
			assert(szQQShowSN);
			self:Msg2Player(pPlayer, "���Ѿ���ȡ��QQ�㼤���룬����QQ�㼤�����ǣ�\n"..szQQShowSN);
			return;
		end
		
		-- �������Ƿ��Ѿ�������
		local nCurrSNCount = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_QQSHOW);
		if (nCurrSNCount >= self.QQSHOWNUMBER_PERSERVER) then
			self:Msg2Player(pPlayer, "��������QQ�㼤�����Ѿ�������ϣ���л���Ĳ��롣");
			return;
		end
		
		-- ��������ң�Ϊ���ڽ��յ�GC��������Ϣǰ��������
		pPlayer.AddWaitGetItemNum(1);
		
		-- ֪ͨGC����һ��������
		GCExcute({"SpecialEvent.tbQQShow:QQShowAllocateSN", pPlayer.szName});		
	end
	
	
	function tbQQShow:QQShowAllocateResult(szPlayerName, nQQShowSNNum)
		local pPlayer = GetPlayerObjFormRoleName(szPlayerName);
		if (not pPlayer) then
			return;
		end
		
		-- ���������
		pPlayer.AddWaitGetItemNum(-1);
		
		-- ���������QQShow�������Ѿ��������
		if (not nQQShowSNNum) then
			return;	
		end
		
		local szQQShowSN = self:GetQQShowSN(nQQShowSNNum);
		assert(szQQShowSN);
		self:Msg2Player(pPlayer, "���ã���ϲ������˽������繫����QQ����Ʒ������������QQ�㼤���룺\n"..szQQShowSN);
		pPlayer.SetTask(self.tbQQShowTaskValue[1], self.tbQQShowTaskValue[2], nQQShowSNNum);
		
		-- �̻���Ч
		pPlayer.CastSkill(307, 1, -1, pPlayer.GetNpc().nIndex);
	end

	-- ����QQShow������
	function tbQQShow:GetQQShowSN(nQQShowSNNum)
		local szQQShowSN = nil;	
		local tbQQShowSNList = self:GetQQShowSNList();
		if (not tbQQShowSNList or not tbQQShowSNList[nQQShowSNNum]) then
			print(nQQShowSNNum);
			assert(false);
		end
		
		szQQShowSN = tbQQShowSNList[nQQShowSNNum].QQShowSN;
		if (not szQQShowSN) then
			print(nQQShowSNNum);
			assert(false);
		end
		
		return szQQShowSN;
	end
	
	
	function tbQQShow:Msg2Player(pPlayer, szMsg)
		Setting:SetGlobalObj(pPlayer, him, it);
		Dialog:Say(szMsg);
		Setting:RestoreGlobalObj();
	end
	
end



--------------------------------------------------------------------
-- GC
if MODULE_GC_SERVER then
	-- GC����һ��QQShow������
	function tbQQShow:QQShowAllocateSN(szPlayerName)
		local nCurrSNCount = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_QQSHOW);
		if (nCurrSNCount >= self.QQSHOWNUMBER_PERSERVER) then
			-- ֪ͨGS���ܷ�����
			GlobalExcute({"SpecialEvent.tbQQShow:QQShowAllocateResult", szPlayerName});
		else
			KGblTask.SCSetDbTaskInt(DBTASD_EVENT_QQSHOW, nCurrSNCount + 1);
			-- ֪ͨGS������һ��
			GlobalExcute({"SpecialEvent.tbQQShow:QQShowAllocateResult", szPlayerName, nCurrSNCount + 1});
		end
	end
end
