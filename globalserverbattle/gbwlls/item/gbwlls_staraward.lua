-- ��

local tbItem = Item:GetClass("gbwlls_staraward");

tbItem.tbAward = {
		[1] = {
				effect = {
					{880,3,2,32400,1,0,1},  -- ����
					{879,8,2,64800,1,0,1}, 	-- ��־���
					{385,7,2,64800,1,0,1}, 	-- 7����
					{386,7,2,64800,1,0,1}, 
					{387,7,2,64800,1,0,1}, 
				},
				binditem = {
					{18,1,80,1},
					{18,1,80,1},
				},
				fourtime = {5},	-- 0.5Сʱ4��ʱ��
			},
		[2] = {
				effect = {
					{880,1,2,32400,1,0,1},  -- ����
					{879,7,2,64800,1,0,1}, 	-- ��־���
					{385,6,2,64800,1,0,1}, 	-- 6����
					{386,6,2,64800,1,0,1}, 
					{387,6,2,64800,1,0,1}, 
				},
				binditem = {
					{18,1,80,1},
				},
				fourtime = {5},	-- 0.5Сʱ4��ʱ��
			},
		[3] = {
				effect = {
					{880,1,2,32400,1,0,1},  -- ����
					{879,7,2,64800,1,0,1}, 	-- ��־���
					{385,6,2,64800,1,0,1}, 	-- 6����
					{386,6,2,64800,1,0,1}, 
					{387,6,2,64800,1,0,1}, 
				},
				binditem = {
					{18,1,80,1},
				},
				fourtime = {5},	-- 0.5Сʱ4��ʱ��	
			},
		[4] = {
				effect = {
					{880,1,2,32400,1,0,1},  -- ����
					{879,7,2,64800,1,0,1}, 	-- ��־���
				},
				binditem = {
					{18,1,80,1},
				},
			},
	};

function tbItem:OnUse()
	local nStarFlag = it.GetGenInfo(1);
	if (nStarFlag <= 0 or nStarFlag > 4) then
		Dialog:Say("����Ʒ�����⣬����ϵ����Ա��");
		return 0;
	end

	local nNeedFree = GbWlls.Fun:GetNeedFree(self.tbAward[nStarFlag]);

	if me.CountFreeBagCell() < nNeedFree then
		Dialog:Say(string.format("���ı����ռ䲻��,������%s�񱳰��ռ�.", nNeedFree));
		return 0;
	end	
	GbWlls.Fun:DoExcute(me, self.tbAward[nStarFlag]);
	me.CastSkill(307, 1, -1, me.GetNpc().nIndex);
	return 1;
end
