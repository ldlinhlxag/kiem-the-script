-- 文件名　：hoe.lua
-- 创建者　：jiazhenwei
-- 创建时间：2010-03-15 15:01:45
-- 描  述  ：锄头
local tbHoe = Item:GetClass("tower_hoe");

function tbHoe:OnUse(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		me.Msg("Xin lỗi, không thể sử dụng khi không có mục tiêu!")
		return 0;
	end
	local tbPlayerTempTable = me.GetPlayerTempTable();	
	local tbMission = tbPlayerTempTable.tbMission;	
	
	if tbMission:IsOpen() ~= 1 then
		me.Msg("Thời cơ chưa đến, không thể sử dụng!")
		return 0;
	end	
	
	local nFlag  =  tbMission:CheckTower(nNpcId, me.nId) ;
	local tbMsg ={
		 [0]="Chỉ có thể dùng cho thực vật!";
		 [1]="Cây này của đội ngươi, không thể nhổ!";
		}
	if nFlag ~= 2 then
		me.Msg(tbMsg[nFlag]);
		return 0;
	end	
	local nMapId, nX, nY = pNpc.GetWorldPos();
	local _, nX2, nY2 = me.GetWorldPos();
	local nDistance = (nX2 - nX) * (nX2 - nX) + (nY2 - nY) * (nY2 - nY);
	if nDistance > 30 then
		me.Msg("Phải đến gần cây mới có thể dùng!");
		return;
	end
	if pNpc.nCurLife <= 30 then
		tbMission:DelTower(pNpc.dwId);
		me.Msg("Bạn đã phá hỏng một cây của đối phương!");
		return 1;
	end
	self:ChangeTowerLife(pNpc);
	return 1;
end

function tbHoe:OnClientUse()
	local pNpc = me.GetSelectNpc();
	if not pNpc then
		return 0;
	end
	return pNpc.dwId;
end

function tbHoe:ChangeTowerLife(pNpc)
	pNpc.CastSkill(1622, 2,-1,pNpc.nIndex);
end
