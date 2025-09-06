
-- ====================== 文件信息 ======================

-- 大漠古城護送者尉呂腳本
-- Edited by peres
-- 2008/05/15 PM 16:23

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

local tbNpc			= Npc:GetClass("damogucheng_savenpc_talk");
local tbNpcFight	= Npc:GetClass("damogucheng_savenpc_fight");

tbNpc.tbTrack		= {
	{1659, 3273},
	{1669, 3280},
	{1678, 3288},
	{1688, 3300},
	{1698, 3310},
	{1707, 3300},	
	{1716, 3302},
}


tbNpc.tbTrack_2		= {
	{1719, 3306},
	{1725, 3311},
	{1731, 3317},
	{1738, 3322},
	{1748, 3315},
	{1752, 3311},
	{1756, 3306},
	{1765, 3300},
	{1775, 3309},
	{1781, 3314},
	{1789, 3301},
	{1799, 3291},
}

function tbNpc:OnDialog()
	local nKeys		= me.GetItemCountInBags(18,1,95,1);
	
	if nKeys > 0 then
		Dialog:Say("Hiệp sĩ, không tìm được chiếc chìa khóa đó sao?", {
				  {"Nào, để ta giúp ngươi mở chiếc khóa này!", tbNpc.Release, tbNpc, him.dwId},
				  {"Hãy đợi", tbNpc.OnExit, tbNpc},
				});
	else
		Dialog:Say("Cái bọn khốn khiếp đó…chỉ cần ngươi mở giúp ta cái khóa chết tiệt này, ta sẽ giúp ngươi mở đại môn đó, tiêu diệt sạch lũ cướp kia!");
		return;
	end;
end;


function tbNpc:Release(nNpcId)
	local nKeys		= me.GetItemCountInBags(18,1,95,1);
	
	if nKeys <=0 then
		Dialog:Say("Hầy!...Cứ đi trong thành, ráng tìm cho được chiếc chìa khóa đó đi!");
		return;
	end;
	
	local pNpc	= KNpc.GetById(nNpcId);
	
	if not pNpc then return; end;
	
	me.ConsumeItemInBags(1, 18, 1, 95, 1);
	
--	local pDialogNpc = KNpc.GetById(pNpc.dwId);
	
	local nCurMapId, nCurPosX, nCurPosY = pNpc.GetWorldPos();
	pNpc.Delete();
	
	local pFightNpc		= KNpc.Add2(2722, 120, -1, nCurMapId, nCurPosX, nCurPosY, 0, 0, 1);
	
	pFightNpc.szName	= "Úy Lữ";
	pFightNpc.SetTitle(" Do đội <color=yellow>"..me.szName.."<color> bảo vệ");
	pFightNpc.SetCurCamp(0);
	
	pFightNpc.RestoreLife();
	
	pFightNpc.GetTempTable("Npc").tbOnArrive = {tbNpc.OnArrive, tbNpc, pFightNpc, me};

	
	pFightNpc.AI_ClearPath();
	
	for _,Pos in ipairs(self.tbTrack) do
		if (Pos[1] and Pos[2]) then
			pFightNpc.AI_AddMovePos(tonumber(Pos[1])*32, tonumber(Pos[2])*32)
		end
	end;
	
--	pFightNpc.AI_AddMovePos(1716*32, 3302*32); -- 終點為目標
	pFightNpc.SetNpcAI(9, 50, 1, -1, 25, 25, 25, 0, 0, 0, me.GetNpc().nIndex);
	
	pFightNpc.SendChat("Tốt lắm!...Tốt lắm!...");
	
end;

function tbNpc:OnArrive(pFightNpc, pPlayer)
	
	print ("tbNpc:OnArrive", pFightNpc.szName);
	local nCurMapId, nCurPosX, nCurPosY = pFightNpc.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nCurMapId);
	assert(tbInstancing);
	tbInstancing.nGateLock			= 1;
	
	if pFightNpc then
		pFightNpc.SendChat("Bọn bây….rồi sẽ biết mùi vị đau đớn như thế nào...");
		
		pFightNpc.AI_ClearPath();
		pFightNpc.GetTempTable("Npc").tbOnArrive = {tbNpc.OnArrive_2, tbNpc, pFightNpc}
		
		for _,Pos in ipairs(self.tbTrack_2) do
			if (Pos[1] and Pos[2]) then
				pFightNpc.AI_AddMovePos(tonumber(Pos[1])*32, tonumber(Pos[2])*32)
			end
		end;
		pFightNpc.SetNpcAI(9, 50, 1, -1, 25, 25, 25, 0, 0, 0, pPlayer.GetNpc().nIndex);
	end;
	
end;


function tbNpc:OnArrive_2(pFightNpc)
	if pFightNpc then
		pFightNpc.SendChat("Nơi đây vốn không phải là địa bàn của các ngươi!");
	end;
end;

function tbNpc:OnExit()
	
end;
