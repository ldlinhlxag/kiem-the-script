
-- ��������ʱ�Ļص��ű�

---------------------------------------------------------------------------

-- �����㷨��س���
local LUCKY_DERIVATIVE	= 50;
local LUCKY_MAXVALUE	= 10;

---------------------------------------------------------------------------

function Item:CalcLuckyDecide(nLucky, nVersion)		-- �����㷨�ص�

	local nDecide = 0;

	if (nVersion == 1) then
		local nRand = KMath.GetRandNumber(1000000 - 1);
		if (nLucky <= 50) then
			nDecide = math.floor(nRand * (nLucky + 15) / (10 * nLucky ));
		elseif (nLucky < 150) then
			nDecide = math.floor(nRand * (170 - nLucky) / 1000);
		else
			nDecide = math.floor(nRand * (350 - nLucky) / 10000);
		end
	else
		print("��Ч�İ汾�ţ�"..nVersion);
	end

	return	nDecide;

end

function Item:GetLevelRANum(nLevel, nVersion)		-- ���ݵȼ����������Ը�����ȡֵ��Χ

	local tbNum =		-- ÿ������ħ�����Ը����Ķ�Ӧ��
	{
		{ 1, 2 }, { 1, 3 }, { 2, 4 }, { 3, 5 }, { 3, 5 },
		{ 3, 6 }, { 3, 6 }, { 3, 6 }, { 3, 6 }, { 3, 6 },
	};

	local tbRange = tbNum[nLevel];
	if (tbRange) then
		return	unpack(tbRange);
	end

	return	0, 0;

end

function Item:GetRandMATLevel(nLevel, nVersion)		-- ���ָ��������Լ�����Գ����ڵ�װ������Χ

	local tbNum =		-- ÿ������ħ�����Ը����Ķ�Ӧ��
	{
		{ 1, 5 }, { 1, 9 }, { 1, 10 }, { 2, 10 }, { 3, 10 },
		{ 4, 10 }, { 5, 10 }, { 6, 10 }, { 7, 10 }, { 8, 10 },
		{ 1, 10 }, { 1, 10 }, { 1, 10 }, { 1, 10 }, { 1, 10 },
		{ 1, 10 }, { 1, 10 }, { 1, 10 }, { 1, 10 }, { 1, 10 },
	};

	local tbRange = tbNum[nLevel];
	if (tbRange) then
		return	unpack(tbRange);
	end

	return	self.MIN_LEVEL, math.min(nLevel - 2, self.MAX_EQUIP_LEVEL);

end
