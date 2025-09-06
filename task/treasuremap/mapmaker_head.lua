
-- ====================== 文件信息 ======================

-- 劍俠世界隨機任務 - 繪制地圖志頭文件
-- Edited by peres
-- 2007/08/07 PM 06:30

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

MapMaker.tbMapPos = {};

-- 構造地圖冊的坐標表格
function MapMaker:OnInitFile()
	
	self.tbMapPos  = Lib:NewClass(Lib.readTabFile, "\\setting\\task\\mapmaker\\map_pos.txt");
	
	local nRow = self.tbMapPos:GetRow();
	local nMapId, nMapX, nMapY, nPosIndex = 0;
	local szText = "";
	
	self:_Debug("Start load map pos info!");
	
	for i=1, nRow do
		nMapId    = self.tbMapPos:GetCellInt("MapId", i);
		
		nPosIndex = self.tbMapPos:GetCellInt("PosIndex", i);
		nMapX     = self.tbMapPos:GetCellInt("Xpos", i);
		nMapY     = self.tbMapPos:GetCellInt("Ypos", i);
		szText    = self.tbMapPos:GetCell("Text", i);
		
		if (not self.tbMapPos[nMapId]) and (nMapId ~= -1) then
			self.tbMapPos[nMapId] = {}	
		end;
		
		table.insert(self.tbMapPos[nMapId], nPosIndex, {nMapX, nMapY, szText});
		
	end;
	
	self:_Debug("Loaded map pos info finish, got "..#self.tbMapPos.." maps info!");
	
end;

function MapMaker:_Debug(...)
	print ("[MapMaker]: ", unpack(arg));
end;
