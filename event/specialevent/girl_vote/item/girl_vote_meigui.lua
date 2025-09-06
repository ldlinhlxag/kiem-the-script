
local tbItem = Item:GetClass("girl_vote_meigui");

function tbItem:OnUse()
	if SpecialEvent.Girl_Vote:CheckState(5, 6) == 1 then
		local tbNpc = Npc:GetClass("girl_dingding");
		local szMsg = "��������Ů��ѡ�����׶Σ����Լ�ϲ������Ů��ӣ���ѡ��<color=yellow>���ҵ���Ů����ͶƱ<color>��ѡ��ͶƱ���Լ�ϲ������Ů��Ʊ��������20����Ʊ���ӳɡ�\n��ѡ��������еĲ�����";
		local tbOpt = {
			{"<color=yellow>���ҵ���Ů����ͶƱ<color>",self.VoteState2, self},
			{"������������ŮͶƱ",tbNpc.State2VoteTickets, tbNpc},
			{"��ѯ���м�Ʊ����Ϣ",tbNpc.Query2, tbNpc},
			{"��������"},
		};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	
	if SpecialEvent.Girl_Vote:CheckState(2, 4) ~= 1 then
		Dialog:Say("6��23����6��30���ǳ�ѡͶƱ��7��9����7��21��0���Ǿ���ͶƱ�����ڲ���ͶƱ�ڼ䡣");
		return 0;
	end
	self:VoteState1();
	return 0;
end

function tbItem:VoteState1()
	local nCheck, szGirlName = self:CheckIsVote();
	if nCheck == 1 then
		SpecialEvent.Girl_Vote:State1VoteTickets1(szGirlName, 1);
	end
end

function tbItem:VoteState2()
	local nCheck, szGirlName = self:CheckIsVote2();
	if nCheck == 1 then
		SpecialEvent.Girl_Vote:State2VoteTickets1(GetGatewayName(),szGirlName, 1);
	end
end

function tbItem:CheckIsVote()
	local tbAllPlayerId = KTeam.GetTeamMemberList(me.nTeamId);
	local tbPlayerId = me.GetTeamMemberList();
	if not tbPlayerId or not tbAllPlayerId or #tbAllPlayerId ~= 2 or #tbPlayerId ~= 2 then
		me.Msg("��������Ů��ӣ�����Ҫ�ڸ������ܽ���ͶƱŶ��");
		return 0;
	end
	local szGirlName = "";
	for _, pPlayer in pairs(tbPlayerId) do
		if pPlayer.nId ~= me.nId then
			szGirlName = pPlayer.szName;
			if pPlayer.nSex ~= 1 then
				me.Msg("õ�廨ֻ���͸�Ů��ң�");
				return 0;
			end
			if SpecialEvent.Girl_Vote:IsHaveGirl(szGirlName) == 0 then
				Dialog:Say("����Ů��δ��������������ͶƱ������ȥ�ٰ������������ɡ�");
				return 0;
			end
			break;
		end
	end
	return 1, szGirlName;
end

function tbItem:CheckIsVote2()
	local tbAllPlayerId = KTeam.GetTeamMemberList(me.nTeamId);
	local tbPlayerId = me.GetTeamMemberList();
	if not tbPlayerId or not tbAllPlayerId or #tbAllPlayerId ~= 2 or #tbPlayerId ~= 2 then
		me.Msg("��������Ů��ӣ�����Ҫ�ڸ������ܽ���ͶƱŶ��");
		return 0;
	end
	local szGirlName = "";
	for _, pPlayer in pairs(tbPlayerId) do
		if pPlayer.nId ~= me.nId then
			szGirlName = pPlayer.szName;
			if pPlayer.nSex ~= 1 then
				me.Msg("õ�廨ֻ���͸�Ů��ң�");
				return 0;
			end
			if SpecialEvent.Girl_Vote:IsHaveGirl2(GetGatewayName(), szGirlName) == 0 then
				Dialog:Say("����Ů����Ԥ��������ǰʮ����Χ��Ů��ҡ�");
				return 0;
			end
			break;
		end
	end
	return 1, szGirlName;
end
