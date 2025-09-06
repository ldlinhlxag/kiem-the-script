local tbXisuidashi = Npc:GetClass("xisuidashi");

function tbXisuidashi:OnDialog()
	local tbOpt = {};
	
	local nChangeGerneIdx = Faction:GetChangeGenreIndex(me);
	if(nChangeGerneIdx >= 1)then
		local szMsg;
		if(Faction:Genre2Faction(me, nChangeGerneIdx) > 0 )then --该种类已修
			szMsg = "Ta muốn thay đổi phụ tu môn phái";
		else
			szMsg = "Ta muốn chọn hướng phụ tu môn phái";
		end
		table.insert(tbOpt, {szMsg, self.OnChangeGenreFaction, self, me});
	end
	
	table.insert(tbOpt, {"Tẩy tiềm năng điểm", self.OnResetDian, self, me, 1});
	table.insert(tbOpt, {"Tẩy kỹ năng điểm", self.OnResetDian, self, me, 2});
	table.insert(tbOpt, {"Tẩy tiềm năng điểm cùng kỹ năng điểm", self.OnResetDian, self, me, 0});
	table.insert(tbOpt, {"Trở lại"});

	local szMsg = "Ta giúp đỡ ngươi tẩy đi đã phân phối địa tiềm năng điểm cùng kỹ năng điểm, cung ngươi một lần nữa phân phối. Tại phía sau có một người sơn động, có thể ở trong đó tiến hành chiến đấu thể nghiệm thi kiểm tra một lần nữa phân phối sau khi địa hiệu quả. Nếu như không hài lòng, có thể tái tới tìm ta. Làm ngươi hài lòng sau khi, nhưng từ môn phái truyền tống người chỗ trở lại của ngươi môn phái.";
	Dialog:Say(szMsg, tbOpt);
end

function tbXisuidashi:OnResetDian(pPlayer, nType)
	local szMsg = "";
	if (1 == nType) then
		pPlayer.SetTask(2,1,1);
		pPlayer.UnAssignPotential();
		szMsg = "Tẩy tủy thành công! Ngươi trước kia đã phân phối địa tiềm năng điểm có thể một lần nữa phân phối rồi.";
	elseif (2 == nType) then
		pPlayer.ResetFightSkillPoint();
		szMsg = "Tẩy tủy thành công! Ngươi trước kia đã phân phối địa kỹ năng điểm có thể một lần nữa phân phối rồi.";
	elseif (0 == nType) then
		pPlayer.ResetFightSkillPoint();
		pPlayer.SetTask(2,1,1);
		pPlayer.UnAssignPotential();
		szMsg = "Tẩy tủy thành công! Ngươi trước kia đã phân phối địa tiềm năng điểm cùng kỹ năng điểm có thể một lần nữa phân phối rồi.";
	end
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg);
	Setting:RestoreGlobalObj();
end

function tbXisuidashi:OnChangeGenreFaction(pPlayer)
	local tbOpt	= {};
	local nFactionGenre = Faction:GetChangeGenreIndex(pPlayer);
	for nFactionId, tbFaction in ipairs(Player.tbFactions) do
		if (Faction:CheckGenreFaction(pPlayer, nFactionGenre, nFactionId) == 1) then
			table.insert(tbOpt, {tbFaction.szName, self.OnChangeGenreFactionSelected, self, pPlayer, nFactionId});
		end
	end
	table.insert(tbOpt,{"Kết thúc đối thoại"});
	
	local szMsg = "Phù hợp ngươi tự thân điều kiện địa phụ tu môn phái giống như hạ, xin mời lựa chọn gia nhập.";
	
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg, tbOpt);
	Setting:RestoreGlobalObj();
end

function tbXisuidashi:OnChangeGenreFactionSelected(pPlayer, nFactionId)
	
	local nGenreId		 = Faction:GetChangeGenreIndex(pPlayer);
	local nPrevFaction   = Faction:Genre2Faction(pPlayer, nGenreId);
	local nResult, szMsg = Faction:ChangeGenreFaction(pPlayer, nGenreId, nFactionId);
	if(nResult == 1)then
		if (nPrevFaction == 0) then -- 第一次多修
			szMsg = "Ngươi đã chọn trạch gia nhập %s, sử dụng tu luyện châu có thể tiến hành môn phái địa cắt, đồng thời <color=yellow> ngũ hành ấn cùng áo choàng <color> cũng sẽ tự động cắt vi tương ứng môn phái thích hợp địa ngũ hành, <color=yellow> cũng giữ lại vốn có địa cấp bậc cùng thuộc tính <color>. <enter> cắt đến phụ tu môn phái sau khi, có thể tự hành gia tăng điểm, tại <color=yellow> thương nhân <color> chỗ mua sắm thích hợp địa vũ khí, cũng tại tẩy tủy đảo bên trong sơn động thí nghiệm hiệu quả. <enter> nếu như không hài lòng, có thể trở về tìm lão phu thay đổi phụ tu môn phái. Chờ đến hài lòng khi, có thể tìm <color=yellow> môn phái truyền tống người <color> rời đảo. <enter> rời đảo sau khi, liền chính thức xác định rồi phụ tu môn phái, <color=yellow> không thể lại sửa đổi <color>, nhất định phải thận trọng lựa chọn.";
		else
			szMsg = "Của ngươi phụ tu môn phái đã thay đổi vi %s, sử dụng tu luyện châu, có thể tiến hành môn phái địa cắt, đồng thời <color=yellow> ngũ hành ấn cùng áo choàng <color> cũng sẽ tự động cắt vi tương ứng môn phái thích hợp địa ngũ hành, <color=yellow> cũng giữ lại vốn có địa cấp bậc cùng thuộc tính <color>. <enter> cắt đến phụ tu môn phái sau khi, có thể tự hành gia tăng điểm, tại <color=yellow> thương nhân <color> chỗ mua sắm thích hợp địa vũ khí, cũng tại tẩy tủy đảo bên trong sơn động thí nghiệm hiệu quả. <enter> nếu như không hài lòng, có thể trở về tìm lão phu thay đổi phụ tu môn phái. Chờ đến hài lòng khi, có thể tìm <color=yellow> môn phái truyền tống người <color> rời đảo. <enter> rời đảo sau khi, liền chính thức xác định rồi phụ tu môn phái, <color=yellow> không thể lại sửa đổi <color>, nhất định phải thận trọng lựa chọn."
		end
		szMsg = string.format(szMsg, Player.tbFactions[nFactionId].szName);
	end
	
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg);
	Setting:RestoreGlobalObj();
end

local tbXisuimenpai = Npc:GetClass("xisuimenpaichuansongren");

function tbXisuimenpai:OnDialog()
	local nChangeGerne = Faction:GetChangeGenreIndex(me); 
	local szMsg;
	if(nChangeGerne > 0)then -- 我来这儿多修
		szMsg = "Làm ngươi đối với phụ tu môn phái địa lựa chọn đã hài lòng sau khi, có thể tìm ta đem ngươi đuổi về của ngươi môn phái.";
	else
		szMsg = "Làm ngươi tẩy tủy đã hài lòng sau khi, có thể tìm ta đem ngươi đuổi về của ngươi môn phái.";
	end
	
	local tbOpt = {
			{"Rời khỏi tẩy tủy đảo", self.OnCheckLeave, self, me},
			{"Kết thúc đối thoại"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbXisuimenpai:OnCheckLeave(pPlayer)
	local nChangeGerne = Faction:GetChangeGenreIndex(pPlayer); 
	local szMsg, tbOpt;
	if(nChangeGerne > 0)then -- 我来这儿多修
		if(Faction:Genre2Faction(pPlayer, nChangeGerne) <= 0)then
			szMsg = "Ngươi còn không có lựa chọn phụ tu môn phái, không thể rời đi tẩy tủy đảo.";
		elseif(pPlayer.IsAccountLock() == 1)then
			szMsg = "Của ngươi trướng hào bị vây tập trung trạng thái, hơn nữa ngươi đang ở nhiều tu, bởi vậy tạm không thể từ tẩy tủy đảo rời đi.";
		else
			szMsg = "<enter> rời đảo sau khi, liền chính thức xác định rồi phụ tu môn phái, <color=yellow> không thể lại sửa đổi <color>, nhất định phải thận trọng lựa chọn. Ngươi đã xác định rồi phụ tu môn phái, nghĩ muốn phải rời khỏi rồi sao?";
			tbOpt = {
					{"Hãy đưa ta ra ngoài", self.OnLeave, self, pPlayer},
					{"Kết thúc đối thoại"},
				};
		end	
	else
		szMsg = "Ngươi xác định tẩy tủy đã hài lòng, nghĩ muốn phải rời khỏi rồi sao?";
		tbOpt = {
				{"Đúng vậy", self.OnLeave, self, pPlayer},
				{"Kết thúc đối thoại"},
			};
	end
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg, tbOpt);
	Setting:RestoreGlobalObj();
end

function tbXisuimenpai:OnLeave(pPlayer)
	local nChangeFactionIndex = Faction:GetChangeGenreIndex(pPlayer);
	local nChangedFaction;
	if (nChangeFactionIndex > 0) then -- 我来这儿多修
		nChangedFaction = Faction:Genre2Faction(pPlayer, nChangeFactionIndex);
		Faction:WriteLog(Dbg.LOG_INFO, "tbXisuimenpai:OnLeave", pPlayer.szName, nChangeFactionIndex, nChangedFaction);
		Faction:SetChangeGenreIndex(pPlayer, 0);
	end
	
	assert(pPlayer.nFaction);
	Npc.tbMenPaiNpc:Transfer(pPlayer.nFaction);
	
	if (nChangeFactionIndex > 0) then
		pPlayer.Msg("Ngươi đã phụ tu thành công" .. Player.tbFactions[nChangedFaction].szName);
	end
end
