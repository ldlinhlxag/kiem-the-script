-- ������ֵ�趨

-- ������Ҽ��𣬼��㾭��ֵ
-- �˺�����GameServer����ʱ�Զ����ã����ڽ����һ�������ֵ��
function Setting:GetHangExpValue(nLevel)	
	local nExp = 0;
	-- һСʱ�һ����飺e={3.5w+math.floor[(lv-50)/5]*0.5w}*1.2
	if (nLevel == 50) then 	-- 50
		nExp = 700; -- ÿ���ӻ�õľ���ֵ
	elseif (nLevel < 100) then 	-- 51~99
		nExp = 700 + math.floor((nLevel - 50)/5)*100; -- ÿ���ӻ�õľ���ֵ
	else -- 100����100������
		nExp = 1700; -- ÿ���ӻ�õľ���ֵ[700 + math.floor((100 - 50)/5)*100]
	end
	
	return nExp * 10;	-- 10���ӻ�õľ���ֵ
end;

Setting.tbGolbalObjStack = {};
function Setting:SetGlobalObj(pPlayer, pNpc, pItem)
	self.tbGolbalObjStack[#self.tbGolbalObjStack + 1] = {pPlayer = me, pNpc = him, pItem = it};

	me = pPlayer or me;

	him = pNpc or him;

	it = pItem or it;
end

function Setting:RestoreGlobalObj()
	local tb = self.tbGolbalObjStack[#self.tbGolbalObjStack];
	if (not tb) then
		assert(false);
	end	
	me = tb.pPlayer or me;
	him = tb.pNpc or him;
	it = tb.pItem or it;
	self.tbGolbalObjStack[#self.tbGolbalObjStack] = nil;
end
