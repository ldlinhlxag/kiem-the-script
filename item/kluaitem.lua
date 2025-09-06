-- ��C������Item������з�װ
if MODULE_GC_SERVER then
	return
end

local self;		-- �ṩ���º����õ�UpValue

-------------------------------------------------------------------------------
-- for both server & client

function _KLuaItem.CanUse(pPlayer)
	return KItem.CanPlayerUseItem(pPlayer, self);
end

-- ��ȡ����Ƶ��ַ�����Ϣ
function _KLuaItem.GetEventCustomString()
	local nType = self.nCustomType;
	if nType == KItem.CUSTOM_TYPE_EVENT then
		return self.szCustomString;
	end
	return nil;
end

-------------------------------------------------------------------------------
-- for server

-- ��ָ����ɫ����ɾ���Լ�
function _KLuaItem.Delete(pPlayer, nWay)
	return	KItem.DelPlayerItem(pPlayer, self, (nWay or 100));
end

function _KLuaItem.GetForbidType()
	return KItem.GetOtherForbidType(self.nGenre, self.nDetail, self.nParticular, self.nLevel);
end

function _KLuaItem.Equal(g,d,p,l)
	g = g or 0;
	
	if d and p and l then
		if self.nGenre == g and self.nDetail == d and self.nParticular == p and self.nLevel == l then
			return 1;
		else
			return 0;
		end
	end
	
	if d and p then
		if self.nGenre == g and self.nDetail == d and self.nParticular == p then
			return 1;
		else
			return 0;
		end
	end
	
	if d then
		if self.nGenre == g and self.nDetail == d then
			return 1;
		else
			return 0;
		end
	end
	
	if self.nGenre == g then
		return 1;
	else
		return 0;
	end
end

function _KLuaItem.SzGDPL()
	return string.format("%d,%d,%d,%d", self.nGenre, self.nDetail, self.nParticular, self.nLevel);
end

function _KLuaItem.TbGDPL()
	return {self.nGenre, self.nDetail, self.nParticular, self.nLevel};
end

-------------------------------------------------------------------------------
-- for client

-- ����Լ���Tip��Ϣ
function _KLuaItem.GetTip(nState, szBindType)
	local pIt = it;
	it = self;
	local szTitle, szTip, szView = Item:GetTip(self.szClass, nState, szBindType);
	it = pIt;
	return	szTitle, szTip, szView;
end

-- ����Լ��ĶԱ�Tip��Ϣ��װ����Ч,��װ��������GetTip���죩
function _KLuaItem.GetCompareTip(nState, szBindType)
	local pIt = it;
	it = self;
	local szTitle, szTip, szView, szCmpTitle, szCmpTip, szCmpView = Item:GetCompareTip(self.szClass, nState, szBindType);
	it = pIt;
	return	szTitle, szTip, szView, szCmpTitle, szCmpTip, szCmpView;
end

-- ����Լ����Ա���ȡ
function _KLuaItem.GetSex()
	local tbReq = self.GetReqAttrib();
	for i, tbTmp in ipairs(tbReq) do
		if tbTmp then
			if tbTmp.nReq == 8 then
				return tbTmp.nValue;
			end		
		end
	end
	return nil;
end
