--�¹𻨣����ӷ�

local tbItem = Item:GetClass("moon2008_merial");

function tbItem:InitGenInfo()
	-- �趨��Ч����
	local nSec = Lib:GetDate2Time(math.floor(SpecialEvent.ZhongQiu2008.TIME_STATE[2]*10000));
	it.SetTimeOut(0, nSec);
	
	return	{ };
end
