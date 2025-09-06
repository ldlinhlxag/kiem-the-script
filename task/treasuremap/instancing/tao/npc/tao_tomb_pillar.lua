
-- ====================== 文件信息 ======================

-- 陶朱公疑塚符文柱腳本
-- Edited by peres
-- 2008/03/04 PM 08:26

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

local tbNpc = Npc:GetClass("tao_tomb_pillar");

tbNpc.tbLightName	= {
	["Cột tây"]	= 1,	
	["Cột nam"]	= 2,
	["Cột đông"]	= 3,
	["Cột bắc"]	= 4,
}

function tbNpc:OnDialog()

	local nSubWorld, _, _	= him.GetWorldPos();
	
	local tbInstancing = TreasureMap:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	local nOpen = 0;
	
	if not tbInstancing.tbLightOpen or tbInstancing.tbLightOpen[self.tbLightName[him.szName]] == 0 then
		
		local tbEvent = 
		{
			Player.ProcessBreakEvent.emEVENT_MOVE,
			Player.ProcessBreakEvent.emEVENT_ATTACK,
			Player.ProcessBreakEvent.emEVENT_SITE,
			Player.ProcessBreakEvent.emEVENT_USEITEM,
			Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
			Player.ProcessBreakEvent.emEVENT_DROPITEM,
			Player.ProcessBreakEvent.emEVENT_SENDMAIL,		
			Player.ProcessBreakEvent.emEVENT_TRADE,
			Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
			Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
			Player.ProcessBreakEvent.emEVENT_ATTACKED,
			Player.ProcessBreakEvent.emEVENT_DEATH,
			Player.ProcessBreakEvent.emEVENT_LOGOUT,
		}
		
		GeneralProcess:StartProcess("Đang hóa giải bùa chú trên cột…", 15 * 18, {self.OnOpen, self, me.nId, him.dwId}, {me.Msg, "開啟被打斷！"}, tbEvent);
		return;
	
	elseif tbInstancing.tbLightOpen[self.tbLightName[him.szName]] == 1 then
		Dialog:SendInfoBoardMsg(me, "<color=red>Bùa chú trên cột đã bị hóa giải!<color>");
		return;
	end;
	
end;


function tbNpc:OnOpen(nPlayerId, nNpcId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return;
	end
	
	local nSubWorld, _, _	= pNpc.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if self.tbLightName[pNpc.szName] then
		if not tbInstancing.tbLightOpen then
			
			tbInstancing.tbLightOpen = {};
			
			-- 第一次點柱子時初始化
			for name, i in pairs(self.tbLightName) do
				tbInstancing.tbLightOpen[i] = 0;
			end;
			
		end;
		
		tbInstancing.tbLightOpen[self.tbLightName[pNpc.szName]] = 1;
		
		Dialog:SendInfoBoardMsg(me, "<color=green>Bạn đã hóa giải bùa chú trên "..pNpc.szName.." !<color>");
		
		-- 把這個符文柱刪了
		pNpc.Delete();
		
		local nNum = 0;
		for j, i in pairs(tbInstancing.tbLightOpen) do
			nNum = nNum + i;
		end;
		-- 四棧燈都開了，把石碑刪了
		if nNum == 4 then
			if tbInstancing.tbStele_1_Idx then
				for i=1, #tbInstancing.tbStele_1_Idx do
					local nTempNpcId	= tbInstancing.tbStele_1_Idx[i];
					local pTempNpc		= KNpc.GetById(nTempNpcId);
					if pTempNpc then
						pTempNpc.Delete();
					end;
				end;
			end;
			return;
		end;
	end;
	
end;
