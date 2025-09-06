-------------------------------------------------------------------
--File: 	factionbattle_npc.lua
--Author: 	zhengyuhua
--Date: 	2008-1-8 17:38
--Describe:	门派战npc对话逻辑
-------------------------------------------------------------------

-- 门派竞技功能选项对话
function FactionBattle:ChoiceFunc(nFaction)
	Dialog:Say("Thi đấu môn phái vào tối thứ 3 và thứ 6 hàng tuần sẽ bắt đầu báo danh - 20:00 Sẽ bắt đầu\n<color=red>Điểm của mỗi lần thi đấu sẽ được thay đổi ở những lần thi tiếp theo<color>",
		{
			{"Tôi muốn tham gia thi đấu môn phái", self.EnterMap, self, nFaction},
			{"Điểm đổi giải thưởng", self.ExchangeExp, self, me.nId},
		});
end

-- 报名参加门派战
function FactionBattle:SignUp(nFaction)
	local tbData = self:GetFactionData(nFaction);
	if not tbData then
		Dialog:Say("Hiện tại không có trận thi đấu môn phái nào！");
		return 0;
	elseif tbData.nState > self.SIGN_UP then
		Dialog:Say("Thi đấu môn phái đã bắt đầu lúc 20:00h，hiện tại không thể tiếp nhận đăng ký，mời bạn tham gia những hoạt động khác tại đây");
		return 0;
	end
	if me.nFaction ~= nFaction then
		Dialog:Say("Bạn không phải là đệ tử của môn phái này，không thể tham gia thi đấu!");
		return 0;
	end
	if me.nLevel < self.MIN_LEVEL then
		Dialog:Say("Cấp độ của bạn không đủ"..self.MIN_LEVEL.."Không thể tham gia thi đấu môn phái，nhưng có thể tham gia các hoạt động nhóm khác tại đây");
		return 0;
	end
--	if (Wlls:CheckFactionLimit() == 1 and me.nLevel >= self.MAX_LEVEL) then
--		Dialog:Say("Cấp độ của bạn đã vượt quá，không thể tham gia thi đấu môn phái!");
--		return 0;
--	end
	if tbData:GetAttendPlayuerCount() >= self.MAX_ATTEND_PLAYER then
		Dialog:Say("Số người đăng ký đã đến mức giới hạn 400 người，không thể tiếp nhận đăng ký，mời bạn tham gia các hoạt động khác tại đây");
	else
		local nRet = tbData:AddAttendPlayer(me.nId);
		if nRet == 0 then
			Dialog:Say("Bạn đã đăng ký rồi！");
		else
			Dialog:Say("Đăng ký thành công，hãy đợi để tham gia tại đây，nếu thoát sẽ mất tư cách tham gia thi đấu！<color=yellow>trận đấu sẽ chính thức bắt đầu lúc 19:30");
		end
	end
end

-- 进入门派竞技场地图
function FactionBattle:EnterMap(nFaction)
	local nFlag = self:GetBattleFlag(nFaction);
	if nFlag ~= 1 then
		Dialog:Say("Trận thi đấu môn phái vào tối thứ 3 và 6 lúc 19:30 hàng tuần sẽ bắt đầu nhận đăng ký，20：00 sẽ bắt đầu\nHiện tại vẫn chưa mở");
		return 0;
	end
	 if me.nFaction ~= nFaction then
		Dialog:Say("Bạn không phải là đệ tử môn phái này，không thể tham gia thi đấu!");
		return 0;
	end
--	if (Wlls:CheckFactionLimit() == 1 and me.nLevel >= self.MAX_LEVEL) then
--		Dialog:Say("Cấp độ của bạn đã vượt quá ，không thể tham gia thi đấu!");
--		return 0;
--	end
	if me.nLevel < self.MIN_LEVEL then
		Dialog:Say("Cấp độ của bạn không đủ"..self.MIN_LEVEL.."không thể tham gia thi đấu。");
		return 0;
	end
	
	self:TrapIn(me);
	-- 记录参加次数
	local nNum = me.GetTask(StatLog.StatTaskGroupId , 2) + 1;
	me.SetTask(StatLog.StatTaskGroupId , 2, nNum);
	SpecialEvent.ActiveGift:AddCounts(me, 5);
end

-- 离开门派竞技场对话
function FactionBattle:LeaveMap(nFaction, bConfirm)
	if bConfirm == 1 then
		Npc.tbMenPaiNpc:Transfer(nFaction);
		return 0;
	end
	Dialog:Say("Bạn có chắc muốn thoát không？nếu không có mặt lúc trận đấu bắt đầu，bạn sẽ mất quyền tham gia",
		{
			{"Ta đồng ý", FactionBattle.LeaveMap, FactionBattle, nFaction, 1},
			{"Để ta suy nghĩ lại."}
		}
	);
end

function FactionBattle:CancelSignUp(nFaction, bConfirm)
	if bConfirm == 1 then
		local tbData = self:GetFactionData(nFaction);
		if tbData ~= nil then
			if tbData.nState ~= self.SIGN_UP then
				Dialog:Say("Trận thi đấu đã bắt đầu,không thể hủy tư cách tham gia。");
				return 0;
			end
			tbData:DelAttendPlayer(me.nId)
			Dialog:Say("Bạn đã hủy tư cách tham gia thi đấu。");
		end
		return 0;
	end
	Dialog:Say("Bạn có chắc chắn muốn hủy bỏ đăng ký?",
		{
			{"Đồng ý", FactionBattle.CancelSignUp, FactionBattle, nFaction, 1},
			{"Để ta suy nghĩ lại"}
		}
	);	
end

function FactionBattle:ChampionFlagNpc(pPlayer, pNpc)
	self:ExcuteAwardChampion(pPlayer, pNpc);
end

