--
--

local tbNpc = Npc:GetClass("zhaokan_chuansong");

function tbNpc:OnDialog()
	--�������ҵĿ�Ƭ�������·Ž����а�
	local nTime = tonumber(GetLocalDate("%Y%m"));
	if nTime == 200906 and  me.GetTask(2050,41) == 200906 then --6�������ң¼�Ž���
		local nPrevPoint = GetXoyoPointsByName(me.szName); -- ����µĵ���
		local nCurrPoint = XoyoGame.XoyoChallenge:GetTotalPoint(me);
		if nCurrPoint > nPrevPoint then
			PlayerHonor:SetPlayerXoyoPointsByName(me.szName, nCurrPoint);
		end
	end
	
	XoyoGame:JieYinRen();
end