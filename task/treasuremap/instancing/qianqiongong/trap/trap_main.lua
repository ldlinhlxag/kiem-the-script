
-- ====================== 文件信息 ======================

-- 千瓊宮副本 TRAP 點腳本
-- Edited by peres
-- 2008/07/25 AM 11:39

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

local tbMap			= Map:GetClass(287);

local tbTrap_1		= tbMap:GetTrapClass("trap_1");		-- 打敗第一個 BOSS 後開啟
local tbTrap_2		= tbMap:GetTrapClass("trap_2");		-- 打敗第二個 BOSS 後開啟
local tbTrap_3		= tbMap:GetTrapClass("trap_3");		-- 打敗第三個 BOSS 後開啟
local tbTrap_4		= tbMap:GetTrapClass("trap_4");		-- 打敗第四個 BOSS 後開啟

local tbTrap_Start	= tbMap:GetTrapClass("trap_start");	-- 一開始觸發兔子行走的腳本


function tbTrap_Start:OnPlayer()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	local pRabbit		= KNpc.GetById(tbInstancing.tbNpcIndex[1]);
	
	local tbRabbitRun	= {
		{1589, 3211},
		{1603, 3197},
		{1617, 3182},
		{1664, 3138},
		{1668, 3123},
		{1684, 3119},
	}
	
	if pRabbit then
		pRabbit.AI_ClearPath();
		for _,Pos in ipairs(tbRabbitRun) do
			if (Pos[1] and Pos[2]) then
				pRabbit.AI_AddMovePos(tonumber(Pos[1])*32, tonumber(Pos[2])*32)
			end
		end;
		pRabbit.SetNpcAI(9, 0,  1, -1, 25, 25, 25, 0, 0, 0, me.GetNpc().nIndex);
	end;
end;


function tbTrap_1:OnPlayer()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if tbInstancing.tbBossDown[1]~=1 then
		-- 彈回原處
		me.NewWorld(nMapId, 1693, 3140);
		Dialog:SendInfoBoardMsg(me, "<color=red>Một sức mạnh huyền bí không rõ đã đẩy bạn trờ lại !<color>");
	end;
end;

function tbTrap_2:OnPlayer()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if tbInstancing.tbBossDown[2]~=1 then
		-- 彈回原處
		me.NewWorld(nMapId, 1552, 2935);
		Dialog:SendInfoBoardMsg(me, "<color=red>Một sức mạnh huyền bí không rõ đã đẩy bạn trờ lại !<color>");
	end;
end;

function tbTrap_3:OnPlayer()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if tbInstancing.tbBossDown[3]~=1 then
		-- 彈回原處
		me.NewWorld(nMapId, 1605, 2837);
		Dialog:SendInfoBoardMsg(me, "<color=red>Một sức mạnh huyền bí không rõ đã đẩy bạn trờ lại !<color>");
	end;
end;

function tbTrap_4:OnPlayer()
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if tbInstancing.tbBossDown[4]~=1 then
		-- 彈回原處
		me.NewWorld(nMapId, 1776, 2721);
		Dialog:SendInfoBoardMsg(me, "<color=red>Một sức mạnh huyền bí không rõ đã đẩy bạn trờ lại !<color>");
	end;
end;
