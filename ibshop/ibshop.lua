

local TASK_PROMOTION_TASKID = 2034;
local BACKCOIN = 500;
local GIVEBACKBINDCOIN = 100;
IbShop.EventOpen = 0;
IbShop.WaraItemSaleStatus = {}

-- �����ҵ�ǰ״̬�Ƿ��ܴ������
function IbShop:CheckCanUse(nCheckFlag)
	if (nCheckFlag and 1 == nCheckFlag) then -- ���ǽű�ʹ�����ָ��Ļ���������Щ�ж�
		return 1;
	end
	
	if me.IsAccountLock() ~= 0 then
		return 0;
	end
	-- �������в��ܴ������
	if (me.IsInPrison() == 1) then
		return 0;
	end
	
	if (GLOBAL_AGENT) then
		return 0;
	end;
	
	return 1;
end

function   IbShop:IsSaleStatus(strWareIndex)
	if not self.WaraItemSaleStatus or not strWareIndex then
		return 1
	end
	if self.WaraItemSaleStatus[strWareIndex] then
		return 0
	end
	return 1
end

function IbShop:CheckIsOnSale(nWareId, nLevel, nCurrencyType, nStartSaleDay, nEndSaleDay)
	local strIndex = tostring(nWareId) .. ',' ..tostring(nLevel) .. ','..tostring(nCurrencyType)
	if 0 == self:IsSaleStatus(strIndex) then
		return 0
	end
	
	if nStartSaleDay == 0 and nEndSaleDay == 0 then
		return 1
	end
	
	local nDate_ServerStart = KGblTask.SCGetDbTaskInt(DBTASD_SERVER_STARTTIME);
	local nDate_NowTime 	= GetTime();
	if nDate_ServerStart == nil then
		return 0;
	end
	
	local nStartTime = nDate_ServerStart + ((nStartSaleDay - 1) * 86400);
	local nEndTime = 0;
	if nEndSaleDay or nEndSaleDay > 0 then
		nEndTime = nDate_ServerStart + ((nEndSaleDay - 1) * 86400);
	end
	if nDate_NowTime >= nStartTime and (nEndTime == 0 or nDate_NowTime < nEndTime) then
		return 1;
	end
	return 0;
end

function IbShop:_ClearIbShopData(pPlayer)
	local szMonth = GetLocalDate("%Y%m");
	local szPrvMonth = os.date("%Y%m", pPlayer.GetTask(2034, 7));
	if ( szMonth > szPrvMonth) then
		pPlayer.SetTask(2034, 5, 0);
		pPlayer.SetTask(2034, 6, 0);
		pPlayer.SetTask(2034, 7, GetTime());
	end
end

function IbShop:CanPromtion(pPlayer)
	self:_ClearIbShopData(pPlayer);
	
	local nNowTime = tonumber(GetLocalDate("%Y%m%d"));
	-- ����ʱ���
	
	if (nNowTime >= 20090223 and nNowTime < 20090301) then 
		return 1;	
	end
	
	--��������buff
	if pPlayer.GetSkillState(1336) > 0 then
		return 1;
	end
	
	--�ϵͳ����
	if self.EventOpen > 0 then
		return 1;
	end
	
	return 0;
end

function IbShop:Promotion(pPlayer, nTotalCoin)
	if (not pPlayer) then
		return 0;
	end
	
	self:VipReturn(pPlayer, nTotalCoin);
	
	if  self:CanPromtion(pPlayer) ~= 1 then
		return 0;
	end
	local nMonCharge = 100 * pPlayer.nMonCharge;
	local nHaveCoin = pPlayer.GetTask(TASK_PROMOTION_TASKID,  5);
	if (nHaveCoin >= nMonCharge) then
		pPlayer.Msg(string.format("�����ۼ�%s������޷�������Ѱ�%s������", IVER_g_szPayName, IVER_g_szCoinName));
		return 0;
	end
	local nCoin = nTotalCoin + nHaveCoin;
	if (nMonCharge < nCoin) then
	 	nCoin = nMonCharge;
	end
	pPlayer.SetTask(TASK_PROMOTION_TASKID, 5, nCoin);
	
	local nGiveNum = pPlayer.GetTask(TASK_PROMOTION_TASKID, 6);
	 
	nCoin = math.floor(nCoin - nGiveNum * BACKCOIN);
	local nCount = math.floor(nCoin / BACKCOIN);
	if (nCount > 0) then
	 	local nBindCoin = self:GetEventExCoin(pPlayer, nCount);
	 	pPlayer.AddBindCoin(nBindCoin, Player.emKBINDCOIN_ADD_EVENT);
	 	pPlayer.SetTask(TASK_PROMOTION_TASKID, 6, nCount + nGiveNum);
	 	pPlayer.Msg(string.format("���μ�%s���ѽ���%s������%s��%s������", IVER_g_szCoinName, IVER_g_szCoinName, nBindCoin, IVER_g_szCoinName));
	 	pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_PROMOTION, string.format("���������%s�����%s��%s", IVER_g_szCoinName, nBindCoin, IVER_g_szCoinName));
	end
	return 1;
end


function IbShop:GetEventExCoin(pPlayer, nCount)
	local nCurExCount = 0;
	
	--ǰ30��ÿ��500��Ҷ෵��300�󶨽�ң�����ǰ�淵����ǰ15000��ҷ���15000���;���淵��20%
	if self.EventOpen == 2 then
		local nExCount = pPlayer.GetTask(TASK_PROMOTION_TASKID, 6);
		nCurExCount = nCount;
		if nExCount + nCount > 30 then
			nCurExCount = (30 - nExCount);
		end
		if nCurExCount < 0 then
			nCurExCount = 0;
		end
	end
	
	return nCurExCount * 500 + (nCount - nCurExCount)*GIVEBACKBINDCOIN;
end

function IbShop:VipReturn(pPlayer, nTotalCoin)
	if (not pPlayer or nTotalCoin <= 0) then
		return 0;
	end
	VipPlayer:VipReturnBindCoin(pPlayer, nTotalCoin);
end

--- ����gc����
function IbShop:OnRecConnectMsg(strWareIndex, bAddOrDel)
	if not self.WaraItemSaleStatus then
		self.WaraItemSaleStatus = {}
	end
	if not bAddOrDel or bAddOrDel == 1 then
		self.WaraItemSaleStatus[strWareIndex] = 1
	else
		self.WaraItemSaleStatus[strWareIndex] = nil
	end
end
