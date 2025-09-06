----------------------------------------
-- 可消除百斬吉金鐘罩的道具
-- ZhangDeheng
-- 2008/10/28  10:41
----------------------------------------

local tbFnsItem = Item:GetClass("chickenblood");

tbFnsItem.SKILL_ID  	= 1123;
tbFnsItem.ADVICE_RANGE	= 41; 	-- 用於判斷局部范圍內是否有百斬吉

-- 判斷一個玩家是否在指定的范圍內
function tbFnsItem:IsPlayerInRange(pPlayer, nRange)
	local tbPlayerList = KPlayer.GetAroundPlayerList(me.nId, nRange);
	if not tbPlayerList then
		return false;
	end;
	
	for _, player in ipairs(tbPlayerList) do
		if pPlayer.nId == player.nId then
			return true;
		end;
	end;
	return false;
end;

-- 一個范圍內的隊伍中成員顯示消息
function tbFnsItem:Msg2Team(szMsg)
	if (MODULE_GAMESERVER) then
		local tbTeamMemberList = me.GetTeamMemberList();
		if tbTeamMemberList then
			for _, pPlayer in ipairs(tbTeamMemberList) do
				-- 僅向在100范圍內的隊伍中玩家顯示消息
				if self:IsPlayerInRange(pPlayer, 100) then
					Dialog:SendBlackBoardMsg(pPlayer, szMsg);	
				end;
			end;
		end;
		Dialog:SendBlackBoardMsg(me, szMsg);		
	end;
end

function tbFnsItem:OnUse()
	local bExist = false;
	-- 判斷玩家周圍是否有百斬吉存在
	local tbNpcList = KNpc.GetAroundNpcList(me, self.ADVICE_RANGE);
	if tbNpcList then
		for _, pNpc in ipairs(tbNpcList) do
			if 4111 == pNpc.nTemplateId then
				bExist = true;
			end;
		end;
	end
	
	if bExist then -- 存在
		if me.nFightState == 1 then -- 是否處於戰斗狀態
			me.CastSkill(tbFnsItem.SKILL_ID, 1, -1, me.GetNpc().nIndex);
			local szMsg = "金鐘罩已破！"
			self:Msg2Team(szMsg);
			return 1;
		else  -- 非戰斗狀態
			local szMsg = "非戰斗狀態，不能使用該物品！"
			Dialog:SendInfoBoardMsg(me, szMsg);
			return 0;
		end;
	else -- 不存在
		local szMsg = "此物隻有對百斬吉使用才有效！"
		Dialog:SendInfoBoardMsg(me, szMsg);
		return 0;
	end;	
end
