
if (not Task.tbArmyCampInstancingManager) then
	Task.tbArmyCampInstancingManager = {};
	Task.tbArmyCampInstancingManager.tbSettings = {};
end
Task.tbArmyCampInstancingManager.szAnnouce = "Phó bản quân doanh bắt đầu nhận báo danh, mời các đại hiệp trên cấp 90 thông qua \"Truyền Tống Quân Doanh\" Tân Thủ Thôn đến \"Phục Ngưu Sơn Quân Doanh\" tham gia báo danh.";
Task.tbArmyCampInstancingManager.nInstancingMaxCount = 30;													-- 同時可以開啟此FB的總數

-- 一個等級段可能會有多個FB
local tbArmyCampInstancingSettings = 
{	
	{
		nInstancingTemplateId		= 1,													-- 副本模板Id
		szName						= "Hậu Sơn Phục Ngưu",										-- 副本名字
		szEnterMsg					= "Phó bản nhận báo danh trong 10 phút, do đội trưởng báo danh, cần ít nhất 4 người chơi chữ trắng trên cấp 90 nhận qua nhiệm vụ quân doanh tổ đội ở khu này. Điều kiện vào:\n<color=yellow>1. Đã báo danh\n2. Cùng thời gian, người chơi chỉ được vào phó bản đội đầu tiên mở\n3. Đã nhận qua nhiệm vụ quân doanh<color>",
		nMinLevel 					= 90, 													-- 等級下限
		nMaxLevel 					= 150,													-- 等級上限
		nInstancingMapTemplateId	= 557,													-- FB模板Id	
		nInstancingEnterLimit_D 	= {nTaskGroup = 2043, nTaskId = 1, nLimitValue = 4},	-- 玩家每天可進入FB的次數的上限
		nJuQingTaskLimit_W			= {nTaskGroup = 1024, nTaskId = 52, nLimitValue = 4},	-- 玩家每周可接劇情副本任務的上限
		nDailyTaskLimit_W			= {nTaskGroup = 1024, nTaskId = 51, nLimitValue = 28},	-- 玩家每周可接日常副本任務上限
		nRegisterMapId				= {nTaskGroup = 2043, nTaskId = 2},						-- 上次注冊FB的報名點地圖Id
		nInstancingExistTime	 	= 90*60,												-- FB重置的時間
		tbRevivePos					= {1643, 3623},											-- 玩家在副本內的零時重生點
		nMinPlayer					= 1,													-- 開啟FB需要的最小玩家數
		nMaxPlayer					= 6,													-- FB能容納的最大玩家數
		tbOpenHour					= {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 
									  12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23},		-- 開啟的小時
		tbOpenDuration				= 10;													-- 持續的分鐘
		tbInstancingTimeId			= {nTaskGroup = 2043, nTaskId = 4},						-- 記錄玩家上次進入此FB的小時數
		tbInstancingMapId			= {nTaskGroup = 2043, nTaskId = 5},						-- 記錄玩家上次進入FB的地圖Id
		tbHaveTask					= {225, 226, 227},										-- 必須有這些任務才能注冊和進入FB
		nNoPlayerDuration			= 10*60,													-- FB中沒有玩家指定時間則重置
		szNoTaskMsg					= " chưa nhận nhiệm vụ phó bản Phục Ngưu Sơn!",								-- 未接任務提示
	},
	{
		nInstancingTemplateId		= 2,													-- 副本模板Id
		szName						= "Bách Man Sơn",										-- 副本名字
		szEnterMsg					= "Phó bản nhận báo danh trong 10 phút, do đội trưởng báo danh, cần ít nhất 4 người chơi chữ trắng trên cấp 90 nhận qua nhiệm vụ quân doanh tổ đội ở khu này. Điều kiện vào:\n<color=yellow>1. Đã báo danh\n2. Cùng thời gian, người chơi chỉ được vào phó bản đội đầu tiên mở\n3. Đã nhận qua nhiệm vụ quân doanh<color>",
		nMinLevel 					= 90, 													-- 等級下限
		nMaxLevel 					= 150,													-- 等級上限
		nInstancingMapTemplateId	= 560,													-- FB模板Id	
		nInstancingEnterLimit_D 	= {nTaskGroup = 2043, nTaskId = 1, nLimitValue = 4},	-- 玩家每天可進入FB的次數的上限
		nJuQingTaskLimit_W			= {nTaskGroup = 1024, nTaskId = 52, nLimitValue = 4},	-- 玩家每周可接劇情副本任務的上限
		nDailyTaskLimit_W			= {nTaskGroup = 1024, nTaskId = 51, nLimitValue = 28},	-- 玩家每周可接日常副本任務上限
		nRegisterMapId				= {nTaskGroup = 2043, nTaskId = 2},						-- 上次注冊FB的報名點地圖Id
		nInstancingExistTime	 	= 90*60,												-- FB重置的時間
		tbRevivePos					= {1724, 3131},											-- 玩家在副本內的零時重生點
		nMinPlayer					= 4,													-- 開啟FB需要的最小玩家數
		nMaxPlayer					= 6,													-- FB能容納的最大玩家數
		tbOpenHour					= {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 
									  12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23},		-- 開啟的小時
		tbOpenDuration				= 10;													-- 持續的分鐘
		tbInstancingTimeId			= {nTaskGroup = 2043, nTaskId = 4},						-- 記錄玩家上次進入此FB的小時數
		tbInstancingMapId			= {nTaskGroup = 2043, nTaskId = 5},						-- 記錄玩家上次進入FB的地圖Id
		tbHaveTask					= {333, 334, 337, 338},									-- 必須有這些任務才能注冊和進入FB
		nNoPlayerDuration			= 10*60,													-- FB中沒有玩家指定時間則重置
		szNoTaskMsg					= " chưa nhận nhiệm vụ phó bản Bách Man Sơn!",								-- 未接任務提示
	},
	{
		nInstancingTemplateId		= 3,													-- 副本模板Id
		szName						= "Hải Lăng Vương Mộ",											-- 副本名字
		szEnterMsg					= "Phó bản nhận báo danh trong 10 phút, do đội trưởng báo danh, cần ít nhất 4 người chơi chữ trắng trên cấp 90 nhận qua nhiệm vụ quân doanh tổ đội ở khu này. Điều kiện vào:\n<color=yellow>1. Đã báo danh\n2. Cùng thời gian, người chơi chỉ được vào phó bản đội đầu tiên mở\n3. Đã nhận qua nhiệm vụ quân doanh<color>",
		nMinLevel 					= 90, 													-- 等級下限
		nMaxLevel 					= 150,													-- 等級上限
		nInstancingMapTemplateId	= 493,													-- FB模板Id	
		nInstancingEnterLimit_D 	= {nTaskGroup = 2043, nTaskId = 1, nLimitValue = 4},	-- 玩家每天可進入FB的次數的上限
		nJuQingTaskLimit_W			= {nTaskGroup = 1024, nTaskId = 52, nLimitValue = 4},	-- 玩家每周可接劇情副本任務的上限
		nDailyTaskLimit_W			= {nTaskGroup = 1024, nTaskId = 51, nLimitValue = 28},	-- 玩家每周可接日常副本任務上限
		nRegisterMapId				= {nTaskGroup = 2043, nTaskId = 2},						-- 上次注冊FB的報名點地圖Id
		nInstancingExistTime	 	= 90*60,												-- FB重置的時間
		tbRevivePos					= {1586, 3157},											-- 玩家在副本內的零時重生點
		nMinPlayer					= 4,													-- 開啟FB需要的最小玩家數
		nMaxPlayer					= 6,													-- FB能容納的最大玩家數
		tbOpenHour					= {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 
									  12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23},		-- 開啟的小時
		tbOpenDuration				= 10;													-- 持續的分鐘
		tbInstancingTimeId			= {nTaskGroup = 2043, nTaskId = 4},						-- 記錄玩家上次進入此FB的小時數
		tbInstancingMapId			= {nTaskGroup = 2043, nTaskId = 5},						-- 記錄玩家上次進入FB的地圖Id
		tbHaveTask					= {363, 364, 365, 366, 367, 368},						-- 必須有這些任務才能注冊和進入FB
		nNoPlayerDuration			= 10*60,													-- FB中沒有玩家指定時間則重置
		szNoTaskMsg					= " chưa nhận nhiệm vụ phó bản Hải Lăng Vương Mộ",								-- 未接任務提示
	},
}


for _, tbInstaingSetting in ipairs(tbArmyCampInstancingSettings) do
	assert(not Task.tbArmyCampInstancingManager.tbSettings[tbInstaingSetting.nInstancingTemplateId]);	-- 確保沒有重復的Id
	Task.tbArmyCampInstancingManager.tbSettings[tbInstaingSetting.nInstancingTemplateId] = tbInstaingSetting;
end

