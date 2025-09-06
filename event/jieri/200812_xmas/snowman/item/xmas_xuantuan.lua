-- �ļ�������xmas_xuantuan.lua
-- �����ߡ���zounan
-- ����ʱ�䣺2009-11-25 11:47:48
-- ��  ��  ��
if  MODULE_GC_SERVER then
	return;
end

local tbItem = Item:GetClass("xiaoxuetuan");

SpecialEvent.Xmas2008 = SpecialEvent.Xmas2008 or {};
SpecialEvent.Xmas2008.XmasSnowman = SpecialEvent.Xmas2008.XmasSnowman or {};
local XmasSnowman = SpecialEvent.Xmas2008.XmasSnowman;

function tbItem:OnUse(nNpcId)
	local i = 1;
	if i == 1 then
		return;
	end
	local pPlayer = self:Check(nNpcId);
	print(pPlayer);
	if pPlayer == 0 then
		return;
	end
	
	local nMapId, nX, nY = pNpc.GetWorldPos();
	local _, nX2, nY2 = me.GetWorldPos();
	local nDistance = (nX2 - nX) * (nX2 - nX) + (nY2 - nY) * (nY2 - nY);
	if nDistance > XmasSnowman.XUETUAN_DISTANCE then
		me.Msg("Ҫ������Ҳ���ʹ��Ŷ");
		return;
	end			
	
	return 1;
end	

function tbItem:OnClientUse()
	local pNpc = me.GetSelectNpc();
	if not pNpc then
		return 0;
	end
	return pNpc.dwId;
end

function tbItem:Check(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);	
	if not pNpc then
		return 0;
	end	 	

	if pNpc.nKind == 1 then
		local pPlayer = pNpc.GetPlayer();
		if pPlayer then
			return pPlayer;
		end
	end
	return 0;
end
