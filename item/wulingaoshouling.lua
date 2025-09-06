
local tbItem = Item:GetClass("wulingaoshouling");

tbItem.tbData = 
{
	[219] = {6, 1, 10},
	[220] = {6, 1, 20},
	[221] = {6, 1, 50},
	
	[222] = {6, 2, 10},
	[223] = {6, 2, 20},
	[224] = {6, 2, 50},
	
	[225] = {6, 3, 10},
	[226] = {6, 3, 20},
	[227] = {6, 3, 50},
	
	[228] = {6, 4, 10},
	[229] = {6, 4, 20},
	[230] = {6, 4, 50},
	
	[231] = {6, 5, 10},
	[232] = {6, 5, 20},
	[233] = {6, 5, 50},
}

function tbItem:OnUse()
	local tbParam = self.tbData[it.nParticular];
	assert(tbParam);

	local nTmpSeriers = math.floor(it.nParticular / 3) - 72
	local nFlag = Player:AddRepute(me, tbParam[1], tbParam[2], tbParam[3]);

	
	if (0 == nFlag) then
		return;
	elseif (1 == nFlag) then
		me.Msg("���Ѿ��ﵽ��ս���ָ���������" .. Env.SERIES_NAME[nTmpSeriers] .. "����ߵȼ������޷�ʹ����ս���ָ���������" .. Env.SERIES_NAME[nTmpSeriers] .. "������");
		return;
	end	

	if me.nSeries ~= nTmpSeriers then
		me.Msg("<color=yellow>��ʹ�õ��������������Ľ�ɫ���в�ͬ����С��ʹ�á�")
	end
	-- TODO:AddLog

	-- ������ʹ�ú��ٻ�boss,Ȼ��õ����ָ�������,Ȼ���㹴�����ƹ�Ա����....
	Spreader:OnGouhunyuRepute(tbParam[3]);
	
	return 1;
end

