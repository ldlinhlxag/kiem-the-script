-------------------------------------------------------------------

	--File: 	huadeng. lua

	--Author: 	sunduoliang

	--Date: 	2008-3-3 19:00

	--Describe:	Sai mê hoa đăng

	-------------------------------------------------------------------

local tbGuessGame = Npc:GetClass("huadengshizhe");

function tbGuessGame:OnDialog()
self:StartDialog(him.dwId)
end

function tbGuessGame:StartDialog(nHimId)

	--local pHim = KNpc. GetById(nHimId)

	--if pHim == nil then

	--	return 0;

	--end
tbGuessGame._tbBase = GuessGame;
local pPlayer = me;
local szSex = "Hiệp nữ";
if pPlayer.nSex == Env. SEX_MALE then
szSex = "Hiệp sĩ"
end

	if self:CheckLimit(pPlayer) == 0 then

	Dialog:Say( "Chỉ có các nhân vật đẳng cấp trên 30 mới có thể tham gia Đoán Hoa Đăng.")

	return 0;

	end

	local nState = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_STATE_ID);

	local nStopSec = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_ATTEND_GAME_ID);

	self:ClearPlayerData(pPlayer);

	if pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_GET_AWARD_ID) > 0 then

	Dialog:Say( "Ngươi đã lĩnh liễu ngày hôm nay hoạt động thưởng cho, bất năng tái tham gia ngày hôm nay đích hoạt động.");

	return 0;

	end

	if nStopSec > 0 then

	if nStopSec >= GetTime() then

	Dialog:Say( "Bởi vì Ngươi đáp sai rồi đề mục, còn đang đình miểu trung, thỉnh kiểm tra hữu biên nêu lên khuông ");

	return 0;

	else

	self:StartGameAgain(pPlayer.nId)

	end

	end

	if self.nAnnouceCount ~= nState then

	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_STATE_ID, self.nAnnouceCount);

	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_SHARE_ID, 0);

	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_COUNT_ID, 0);

	end

	if pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_ALLCOUNT_ID) == 0 and pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_WRONG_COUNT) == 0 and pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_WRONG_ID) == 0 then

	local szMsg = string. format( ": ta nơi này có mấy người đố đèn, thật sự là đoán không ra liễu, %s giúp ta nhìn có được hay không?",szSex)

	self:ShowMovie(szMsg, self.CreateDialog, nHimId, pPlayer.nId)--to do điện ảnh hiệu quả

	-- ghi lại tham gia số lần

	local nNum = pPlayer.GetTask(StatLog. StatTaskGroupId, 5) + 1;

	pPlayer.SetTask(StatLog. StatTaskGroupId, 5, nNum);

	return 0;

	end

	self:CreateDialog(nHimId, pPlayer.nId)

	end

	function tbGuessGame:CreateDialog(nHimId, nPlayerId)

	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);

	--local pHim = KNpc. GetById(nHimId)

	if pPlayer == nil then

	return 0;

	end

	if pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_ALLCOUNT_ID) >= self.GUESS_ALLCOUNT_MAX then -- nếu như ngày hôm nay dĩ đáp hoàn 30 đề

	Setting:SetGlobalObj(pPlayer);

	Dialog:Say(string. format( "Hỉ Ngươi đã sai được rồi %s một đố đèn, ngày hôm nay đã bất năng kế tục đoán, thỉnh đi trước lễ quan chỗ lĩnh thưởng cho.", self.GUESS_ALLCOUNT_MAX));

	Setting:RestoreGlobalObj();

	return 0;

	end

	if pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_COUNT_ID) >= self.GUESS_COUNT_MAX then -- nếu như bản luân dĩ đáp hoàn 6 đề

	Setting:SetGlobalObj(pPlayer);

	Dialog:Say(string. format( "Ngươi đã sai được rồi %s một đố đèn, để cho một vòng trở lại kế tục sai ba.", self.GUESS_COUNT_MAX));

	Setting:RestoreGlobalObj();

	return 0;

	end

	local tbNowQuestion = {};

	local nQquestionId = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_WRONG_ID);

	if nQquestionId ~= 0 then

	tbNowQuestion = self.tbGuessQuestion[nQquestionId]

	else

	nQquestionId, tbNowQuestion = self:GetQuestion()

	end

	local tbOpt = {

	{tbNowQuestion.szAnswer, self.RightAnswer, self, nQquestionId, nHimId},

	{tbNowQuestion.szSelect1, self.WrongAnswer, self, nQquestionId, nHimId},

	{tbNowQuestion.szSelect2, self.WrongAnswer, self, nQquestionId, nHimId},

	}

	tbOpt = self:GetRandomTable(tbOpt, #tbOpt);

	table. insert(tbOpt, { "Kết thúc đối thoại "});

	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_WRONG_ID, nQquestionId);

	Dialog:Say(tbNowQuestion.szQuestion, tbOpt);

	end

	function tbGuessGame:RightAnswer(nQquestionId, nHimId)

	local pPlayer = me;

	--local pHim = KNpc. GetById(nHimId)

	if pPlayer == nil then

	return 0;

	end

	--KStatLog. ModifyAdd( "RoleWeeklyEvent", me. szName, "Bản chu tham gia đáp đề số lần", 1);

	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_COUNT_ID, pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_COUNT_ID) + 1 );

	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_ALLCOUNT_ID, pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_ALLCOUNT_ID) + 1 );

	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_WRONG_ID, 0 );

	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_WRONG_COUNT, 0);

	self:ShareRightAnswer(pPlayer);

	if pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_ALLCOUNT_ID) >= self.GUESS_ALLCOUNT_MAX then

	local szSex = "Tỷ tỷ";

	if pPlayer.nSex == Env. SEX_MALE then

	szSex = "Ca ca"

	end

	local szMsg = string. format( ": %s, ngày hôm nay đích đố đèn ngươi giúp ta toàn bộ sai xong, nhanh đi lễ quan nơi nào nhìn có thể được đáo cái gì thứ tốt ba.",szSex);

	self:ShowMovie(szMsg, 0, 0, pPlayer.nId)--to do điện ảnh hiệu quả

	self:GetAchiemement(pPlayer);	-- thầy trò thành tựu: trả lời chính xác sở hữu vấn đề

	return 0;

	elseif pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_COUNT_ID) >= self.GUESS_COUNT_MAX then

	Dialog:Say( "Chúc mừng ngươi đã trả lời thành công.");

	else

	local tbOpt =

	{

	{ "Kế tục đáp đề", self.StartDialog, self, nHimId},

	{ "Kết thúc đối thoại "},

	};

	Dialog:Say( "Chúc mừng Ngươi trả lời liễu cai đề, có hay không kế tục đáp tiếp theo đề mạ?",tbOpt);

	end

	end

	function tbGuessGame:ShareRightAnswer(pPlayer)

	if pPlayer == nil then

	return 0;

	end

	local tbTeamMemberList = pPlayer.GetTeamMemberList();

	if tbTeamMemberList == nil then

	pPlayer.SetTask(self.TASK_GROUP_ID,self.TASK_GRADE_ID, pPlayer.GetTask(self.TASK_GROUP_ID,self.TASK_GRADE_ID) + self.GUESS_MY_GRADE);

	pPlayer.Msg(string. format( "Ngươi trả lời liễu đề mục, thu được liễu <color=yellow>%s điểm <color> vi tích phân.", self.GUESS_MY_GRADE))

	else

	for _, pMemPlayer in pairs(tbTeamMemberList) do

	local nGrade = self.GUESS_MY_GRADE;

	if self:CheckLimit(pMemPlayer) ~= 0 then -- có hay không phù hợp phi bạch danh ngoạn gia

	if pPlayer.nMapId == pMemPlayer. nMapId then -- có hay không tại đồng địa đồ

	if pPlayer.nId ~= pMemPlayer. nId then			-- có hay không thị trả lời đề mục đích ngoạn gia

	self:ClearPlayerData(pMemPlayer);

	if self.nAnnouceCount ~= pMemPlayer. GetTask(self.TASK_GROUP_ID, self.TASK_STATE_ID) then

	pMemPlayer. SetTask(self.TASK_GROUP_ID, self.TASK_STATE_ID, self.nAnnouceCount);

	pMemPlayer. SetTask(self.TASK_GROUP_ID, self.TASK_SHARE_ID, 0);

	pMemPlayer. SetTask(self.TASK_GROUP_ID, self.TASK_COUNT_ID, 0);

	end

	if pMemPlayer. GetTask(self.TASK_GROUP_ID, self.TASK_GET_AWARD_ID) <= 0 and pMemPlayer. GetTask(self.TASK_GROUP_ID, self.TASK_SHARE_ID) < self.GUESS_SHARE then

	nGrade = self.GUESS_SHARE_GRADE;

	pMemPlayer. Msg(string. format( "Ngươi đích đội hữu <color=yellow>%s<color> trả lời liễu đề mục, Ngươi thu được liễu <color=yellow>%s<color> chia xẻ vi tích phân.", pPlayer.szName, nGrade))

	pMemPlayer. SetTask(self.TASK_GROUP_ID, self.TASK_SHARE_ID, pMemPlayer. GetTask(self.TASK_GROUP_ID, self.TASK_SHARE_ID) + 1);

	else

	nGrade = 0;

	end

	else

	pMemPlayer. Msg(string. format( "Ngươi trả lời liễu đề mục, thu được liễu <color=yellow>%s<color> vi tích phân.", nGrade))

	end

	if nGrade ~= 0 then

	pMemPlayer. SetTask(self.TASK_GROUP_ID,self.TASK_GRADE_ID, pMemPlayer. GetTask(self.TASK_GROUP_ID,self.TASK_GRADE_ID) + nGrade);

	end

	end

	end

	end

	end

	return 0;

	end

	function tbGuessGame:WrongAnswer(nQquestionId, nHimId)

	local pPlayer = me;

	--local pHim = KNpc. GetById(nHimId)

	if pPlayer == nil then

	return 0;

	end

	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_WRONG_ID, nQquestionId);

	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_WRONG_COUNT, pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_WRONG_COUNT) + 1 );

	local nStopTime = self.GUESS_WRONG_ONE_TIME;

	local szMsg = string. format( "Cái này đáp án sai yêu, cho ... nữa ngươi %s miểu thời gian hảo hảo ngẫm lại.", nStopTime);

	if pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_WRONG_COUNT) >= self.GUESS_WRONG_MANY_COUNT then

	nStopTime = self.GUESS_WRONG_MANY_TIME;

	szMsg = string. format( "Giá nói đề ngươi đã liên tục đáp thác %s lần, xem ra cấp cho ngươi đa điểm thời gian hiểu rõ sở nga! %s miểu sau đó trở lại tìm ta ba.", pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_WRONG_COUNT), nStopTime);

	end

	self:ShowStopTime(pPlayer, nStopTime)

	Dialog:Say(szMsg);

	return 0;

	end

	function tbGuessGame:ShowStopTime(pPlayer,nStopTime)

	if pPlayer == nil then

	return 0;

	end

	local nTimerId = Timer:Register( nStopTime * Env. GAME_FPS, self.StartGameAgain, self, pPlayer.nId);

	local nLastFrameTime = tonumber(Timer:GetRestTime(nTimerId));

	local szMsgFormat = "<color=green> cấm đáp đề thời gian hoàn thặng: <color><color=white>%s<color> ";

	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_ATTEND_GAME_ID, (GetTime() + nStopTime));

	Dialog:SetBattleTimer(pPlayer, szMsgFormat, nLastFrameTime);

	Dialog:SendBattleMsg(pPlayer, "\n thử trong lúc bất năng trả lời đố đèn ");

	Dialog:ShowBattleMsg(pPlayer, 1, 0); -- mở ra mặt biên

	return 0;

	end

	function tbGuessGame:StartGameAgain(nPlayerId)

	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);

	if (not pPlayer) then

	return 0;

	end

	if pPlayer then

	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_ATTEND_GAME_ID, 0);

	Dialog:ShowBattleMsg(pPlayer, 0, 0); -- đóng mặt biên

	end

	return 0;

	end

	function tbGuessGame:ShowMovie(szMsg, szfun, nHimId, nPlayerId)

	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);

	if pPlayer == nil then

	return 0;

	end

	local szMessage = string. format( "<npc=%s>%s", self.NPC_ID, szMsg);

	Setting:SetGlobalObj(pPlayer);

	if szfun == 0 or szfun == nil then

	TaskAct:Talk(szMessage);

	else

	TaskAct:Talk(szMessage, szfun, self, nHimId, nPlayerId);

	end

	Setting:RestoreGlobalObj();

	return 0;

	end

	function tbGuessGame:GetRandomTable(tbitem, nmax)

	for ni = 1, nmax do

	local p = Random(nmax) + 1;

	tbitem[ni], tbitem[p] = tbitem[p], tbitem[ni];

	end

	return tbitem;

	end

	function tbGuessGame:GetQuestion()

	local nQId = Random(#self.tbGuessQuestion) + 1;

	return nQId, self.tbGuessQuestion[nQId];

	end

	-- thầy trò thành tựu: tại một lần sai đố đèn hoạt động trung trả lời chính xác sở hữu đích vấn đề

	function tbGuessGame:GetAchiemement(pPlayer)

	if (not pPlayer) then

	return;

	end

	Achievement:FinishAchievement(pPlayer.nId, Achievement. DENGMI);

	end

