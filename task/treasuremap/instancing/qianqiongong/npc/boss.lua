
-- ====================== 文件信息 ======================

-- 千瓊宮副本 BOSS 腳本
-- Edited by peres
-- 2008/07/25 AM 11:39

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

local tbBoss_1	= Npc:GetClass("purepalace_boss_1");	-- 羽凌兒
local tbBoss_2	= Npc:GetClass("purepalace_boss_2");	-- 蕭媛媛
local tbBoss_3	= Npc:GetClass("purepalace_boss_3");	-- 肖良
local tbBoss_4	= Npc:GetClass("purepalace_boss_4");	-- 肖玉
local tbBoss_5	= Npc:GetClass("purepalace_boss_5");	-- 冷霜然
local tbBoss_6	= Npc:GetClass("purepalace_boss_6");	-- 小憐

local tbCaptain	= Npc:GetClass("purepalace_captain");	-- 首領，殺死後可在地上產生箱子

local tbRabbit	= Npc:GetClass("purepalace_rabbit");	-- 小兔子

local tbCallNpcPos = {
	[1]	= {
			[50]	= {{1678, 3115},{1685, 3123}},
			[30]	= {{1674, 3120},{1681, 3127},{1684, 3118}},
		},
	[2]	= {
			[50]	= {{1567, 2956},{1571, 2951}},
			[30]	= {{1563, 2959},{1574, 2948},{1571, 2956}},		
		},
	[3]	= {
			[50]	= {{1567, 2823},{1579, 2835}},
			[30]	= {{1567, 2829},{1572, 2835}},		
		},
	[4]	= {
			[50]	= {{1708, 2783},{1711, 2789}},
			[30]	= {{1703, 2788},{1708, 2794}},	
		},
	[5]	= {
			[50]	= {{1804, 2663},{1820, 2679}},
			[30]	= {{1804, 2678},{1816, 2666}},
		},
}

function tbBoss_1:OnDeath(pNpc)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	tbInstancing.tbBossDown[1] = 1;
	
	-- 刪除障礙物
	local pStatuary = KNpc.GetById(tbInstancing.tbStatuaryIndex[1]);
	if pStatuary then
		pStatuary.Delete();
	end;
	
	-- 如果兔子沒被殺死的話，則產生一個 NPC
	if tbInstancing.nRabbit == 0 then
		KNpc.Add2(2738, 1, 0, nMapId, 1684, 3119);
	end;
	
	-- 加一個袋子
	KNpc.Add2(2751, 1, -1, nMapId, nMapX, nMapY);
	
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_3["Npc_Boss1"], 26, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
	end		
end;

function tbBoss_2:OnDeath(pNpc)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	tbInstancing.tbBossDown[2] = 1; 

	-- 刪除障礙物
	local pStatuary = KNpc.GetById(tbInstancing.tbStatuaryIndex[2]);
	if pStatuary then
		pStatuary.Delete();
	end;
	
	-- 如果這時候小憐沒死的話，則把她變回普通 NPC
	if tbInstancing.nGirlKilled == 0 and tbInstancing.nGirlProStep == 1 then
		local pGirlNpc	= KNpc.GetById(tbInstancing.nGirlId);
		if pGirlNpc then
			pGirlNpc.Delete();
			KNpc.Add2(2744, 1, -1, nMapId, 1571, 2956);
		end;
	end;
	
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_3["Npc_Boss1"], 26, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
	end	
end;

function tbBoss_3:OnDeath(pNpc)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	tbInstancing.tbBossDown[3] = 1;
	
	-- 刪除障礙物
	local pStatuary = KNpc.GetById(tbInstancing.tbStatuaryIndex[3]);
	if pStatuary then
		pStatuary.Delete();
	end;
	
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_3["Npc_Boss1"], 26, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
	end		
end;

function tbBoss_4:OnDeath(pNpc)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	tbInstancing.tbBossDown[4] = 1;
	
	-- 刪除障礙物
	local pStatuary = KNpc.GetById(tbInstancing.tbStatuaryIndex[4]);
	if pStatuary then
		pStatuary.Delete();
	end;

	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_3["Npc_Boss1"], 26, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
	end		
end;

function tbBoss_5:OnDeath(pNpc)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	tbInstancing.tbBossDown[5] = 1;

	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_3["Npc_Boss2"], 28, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
		-- 添加親密度
		local tbTeamMembers = pPlayer.GetTeamMemberList();
		TreasureMap:AddFriendFavor(tbTeamMembers, pPlayer.nMapId, 50);
		
		-- 副本任務的處理
		local tbTeamMembers, nMemberCount	= pPlayer.GetTeamMemberList();
		
		if (not tbTeamMembers) or (nMemberCount <= 0) then
			TreasureMap:InstancingTask(pPlayer, tbInstancing.nMapTemplateId);
			return;
		else
			for i=1, nMemberCount do
				local pNowPlayer	= tbTeamMembers[i];
				TreasureMap:InstancingTask(pNowPlayer, tbInstancing.nMapTemplateId);
			end
		end
		
		-- 用於老玩家召回任務完成任務記錄
		local tbMemberList = pPlayer.GetTeamMemberList();	
		for _, player in ipairs(tbMemberList) do 
			Task.OldPlayerTask:AddPlayerTaskValue(player.nId, 2082, 5);
		end;
	end;

	
	-- 必須已經開始護送小憐而且小憐沒死
	if tbInstancing.nGirlProStep == 1 and tbInstancing.nGirlKilled == 0 then
		-- 加一個袋子
		KNpc.Add2(2751, 1, -1, nMapId, nMapX, nMapY);
	end;
	
	-- 加一個傳送點
	local pSendPos	= KNpc.Add2(2749, 1, -1, nMapId, 1812, 2628);
	pSendPos.szName	= "Thiên Quỳnh Cung mở cửa thông lên mặt đất";
	
end;

function tbBoss_6:OnDeath(pNpc)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	tbInstancing.tbBossDown[6] = 1;
	
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_3["Npc_Boss2"], 26, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
		-- 添加親密度
		local tbTeamMembers = pPlayer.GetTeamMemberList();
		TreasureMap:AddFriendFavor(tbTeamMembers, pPlayer.nMapId, 50);
		
		-- 師徒成就：副本千瓊宮
		TreasureMap:GetAchievement(tbTeamMembers, Achievement.FUBEN_QIANQIONG, pPlayer.nMapId);
	end	
	
	-- 加一個傳送點
	local pSendPos	= KNpc.Add2(2749, 1, -1, nMapId, 1822, 2907);
	pSendPos.szName	= "Thiên Quỳnh Cung mở cửa thông lên mặt đất";

end;

function tbCaptain:OnDeath(pNpc)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	
	-- 在地上加個箱子
	KNpc.Add2(2750, 1, -1, nMapId, nMapX, nMapY);
end;

-- 血量觸發
function tbBoss_1:OnLifePercentReduceHere(nLifePercent)
	local nBossId	= 1;
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbNpcPos	= tbCallNpcPos[nBossId];
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if nLifePercent == 50 and tbInstancing.tbBossLifePoint[nBossId][50] == 0 then
		for i=1, #tbNpcPos[50] do
			KNpc.Add2(2732, 80, -1, nMapId, tbNpcPos[50][i][1], tbNpcPos[50][i][2]);
		end;
		tbInstancing.tbBossLifePoint[nBossId][50] = 1;
		him.SendChat("Hãy nhanh chóng giúp ta !");
	end;
	if nLifePercent == 30 and tbInstancing.tbBossLifePoint[nBossId][30] == 0 then
		for i=1, #tbNpcPos[30] do
			KNpc.Add2(2732, 80, -1, nMapId, tbNpcPos[30][i][1], tbNpcPos[30][i][2]);
		end;
		tbInstancing.tbBossLifePoint[nBossId][30] = 1;
		him.SendChat("Tiểu Đích Môn, Hãy nhanh chóng giúp ta !");
	end;	
end;

function tbBoss_2:OnLifePercentReduceHere(nLifePercent)
	local nBossId	= 2;
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbNpcPos	= tbCallNpcPos[nBossId];
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if nLifePercent == 50 and tbInstancing.tbBossLifePoint[nBossId][50] == 0 then
		for i=1, #tbNpcPos[50] do
			KNpc.Add2(2732, 80, -1, nMapId, tbNpcPos[50][i][1], tbNpcPos[50][i][2]);
		end;
		tbInstancing.tbBossLifePoint[nBossId][50] = 1;
		him.SendChat("Ngươi còn chờ đợi gì nữa ?");
	end;
	if nLifePercent == 30 and tbInstancing.tbBossLifePoint[nBossId][30] == 0 then
		for i=1, #tbNpcPos[30] do
			KNpc.Add2(2732, 80, -1, nMapId, tbNpcPos[30][i][1], tbNpcPos[30][i][2]);
		end;
		tbInstancing.tbBossLifePoint[nBossId][30] = 1;
		him.SendChat("Hãy ra đây, bảo vệ ta !");
	end;	
end;

function tbBoss_3:OnLifePercentReduceHere(nLifePercent)
	local nBossId	= 3;
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbNpcPos	= tbCallNpcPos[nBossId];
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if nLifePercent == 50 and tbInstancing.tbBossLifePoint[nBossId][50] == 0 then
		for i=1, #tbNpcPos[50] do
			KNpc.Add2(2732, 80, -1, nMapId, tbNpcPos[50][i][1], tbNpcPos[50][i][2]);
		end;
		tbInstancing.tbBossLifePoint[nBossId][50] = 1;
		him.SendChat("Đến đây, đúng là phụ nữ !");
	end;
	if nLifePercent == 30 and tbInstancing.tbBossLifePoint[nBossId][30] == 0 then
		for i=1, #tbNpcPos[30] do
			KNpc.Add2(2732, 80, -1, nMapId, tbNpcPos[30][i][1], tbNpcPos[30][i][2]);
		end;
		tbInstancing.tbBossLifePoint[nBossId][30] = 1;
		him.SendChat("Đến đây, đúng là phụ nữ !");
	end;	
end;

function tbBoss_4:OnLifePercentReduceHere(nLifePercent)
	local nBossId	= 4;
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbNpcPos	= tbCallNpcPos[nBossId];
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if nLifePercent == 50 and tbInstancing.tbBossLifePoint[nBossId][50] == 0 then
		for i=1, #tbNpcPos[50] do
			KNpc.Add2(2732, 82, -1, nMapId, tbNpcPos[50][i][1], tbNpcPos[50][i][2]);
		end;
		tbInstancing.tbBossLifePoint[nBossId][50] = 1;
		him.SendChat("Hãy tới đây những kẻ xâm nhập kia !");
	end;
	if nLifePercent == 30 and tbInstancing.tbBossLifePoint[nBossId][30] == 0 then
		for i=1, #tbNpcPos[30] do
			KNpc.Add2(2732, 82, -1, nMapId, tbNpcPos[30][i][1], tbNpcPos[30][i][2]);
		end;
		tbInstancing.tbBossLifePoint[nBossId][30] = 1;
		him.SendChat("Hãy tới đây những kẻ xâm nhập kia !");
	end;	
end;


function tbBoss_5:OnLifePercentReduceHere(nLifePercent)
	local nBossId	= 5;
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbNpcPos	= tbCallNpcPos[nBossId];
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	if nLifePercent == 50 and tbInstancing.tbBossLifePoint[nBossId][50] == 0 then
		for i=1, #tbNpcPos[50] do
			KNpc.Add2(2736, 30, -1, nMapId, tbNpcPos[50][i][1], tbNpcPos[50][i][2]);
		end;
		tbInstancing.tbBossLifePoint[nBossId][50] = 1;
		him.SendChat("Chữa trị cho ta, đúng là một đóa hoa đẹp !");
	end;
	if nLifePercent == 30 and tbInstancing.tbBossLifePoint[nBossId][30] == 0 then
		for i=1, #tbNpcPos[30] do
			KNpc.Add2(2736, 30, -1, nMapId, tbNpcPos[30][i][1], tbNpcPos[30][i][2]);
		end;
		tbInstancing.tbBossLifePoint[nBossId][30] = 1;
		him.SendChat("Đã nở rồi ! Bông hoa của ta !");
	end;	
end;


-- 小兔子被殺死
function tbRabbit:OnDeath(pNpc)
	local nMapId, nMapX, nMapY	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nMapId);
	
	tbInstancing.nRabbit	= 1;
end;
