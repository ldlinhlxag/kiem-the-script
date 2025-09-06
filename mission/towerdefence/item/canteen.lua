-- 文件名　：canteen.lua
-- 创建者　：jiazhenwei
-- 创建时间：2010-03-15 15:01:53
-- 描  述  ：水壶脚本

local tbCanteen = Item:GetClass("tower_canteen");

function tbCanteen:OnUse(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		me.Msg("Xin lỗi, không thể dùng khi không có mục tiêu!")
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
		 [2]="Cây này không phải của đội ngươi!";
		}
	if nFlag ~= 1 then
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
	if pNpc.nCurLife  < pNpc.nMaxLife then
		self:ChangeTowerLife(pNpc);
		return 1;
	end
	me.Msg("Cây này đã trưởng thành!");
	return ;
end

function tbCanteen:OnClientUse()
	local pNpc = me.GetSelectNpc();
	if not pNpc then
		return 0;
	end
	return pNpc.dwId;
end

function tbCanteen:ChangeTowerLife(pNpc)
	pNpc.CastSkill(1621,1,-1,pNpc.nIndex);
end
