
local tbItem = Item:GetClass("merchant")

function tbItem:InitGenInfo()
	-- 設定有效期限
	it.SetTimeOut(1, 10 * 60);
	return	{ };
end
