-- ����
local tbItem = Item:GetClass("baiyu");

function tbItem:OnUse()
	local nFlag = Player:AddRepute(me, 12, 1, 100);

	if (0 == nFlag) then
		return;
	elseif (1 == nFlag) then
		me.Msg("���Ѿ��ﵽ�����������������ߵȼ������޷�ʹ�ð���");
		return;
	end
	return 1;
end