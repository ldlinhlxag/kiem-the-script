-----------------------------------------------------
--文件名		：	mailnew.lua
--创建者		：	ZouYing@kingsoft.net
--创建时间		：	2007-10-25
--功能描述		：	系统信件脚本
------------------------------------------------------

------------------------------------------------------
-- 信件内容格式说明
-- szTitle : 信件标题
-- szContent : <Sender>XXX<Sender> ：表示发件人，在信件内容前必须填写，不填默认为 系统, XXX:就是发件人名字,比如 澄惠，季叔班。。。。。。。。。
------------------------------------------------------

Mail.tbMail = 
{
	[1] = 
	{
		szTitle   = "Võ Học Thiếu Lâm"; --少林
		szContent = "<Sender>Phương Trượng<Sender>Ta thấy nhà ngươi đã trưởng thành rất nhiều,\n\n    Vì vậy nhận lấy phần quà nhỏ của ta.nhớ hành hiệp trượng nghĩa\n\n    <color>";
	},
	[2] = 
	{
		szTitle   = "Võ Học Thiên Vương"; --天王
		szContent = "<Sender>Dương Thiết Tâm<Sender>    Ta thấy nhà ngươi đã trưởng thành rất nhiều,\n\n    Vì vậy nhận lấy phần quà nhỏ của ta.nhớ hành hiệp trượng nghĩa\n\n    <color>";	},
	[3] = 
	{
		szTitle   = "Võ Học Đường Môn"; --(唐门)
		szContent = "<Sender>Đường Ngộ<Sender>     Ta thấy nhà ngươi đã trưởng thành rất nhiều,\n\n    Vì vậy nhận lấy phần quà nhỏ của ta.nhớ hành hiệp trượng nghĩa\n\n    <color>";},
	[4] = 
	{
		szTitle   = "Võ Học Ngũ Độc"; --(五毒)
		szContent = "<Sender>Cổ Yên Nhiên<Sender>Ta thấy nhà ngươi đã trưởng thành rất nhiều,\n\n    Vì vậy nhận lấy phần quà nhỏ của ta.nhớ hành hiệp trượng nghĩa\n\n    <color>";},
	
	[5] = 
	{
		szTitle   = "Võ Học Nga Mi"; -- (峨嵋)  
		szContent = "<Sender>Chưởng Môn<Sender>Ta thấy nhà ngươi đã trưởng thành rất nhiều,\n\n    Vì vậy nhận lấy phần quà nhỏ của ta.nhớ hành hiệp trượng nghĩa\n\n    <color>";},
	
	[6] = 
	{
		szTitle   = "Võ học Thúy Yên"; --(翠烟门)
		szContent = "<Sender>Chưởng Môn<Sender>Ta thấy nhà ngươi đã trưởng thành rất nhiều,\n\n    Vì vậy nhận lấy phần quà nhỏ của ta.nhớ hành hiệp trượng nghĩa\n\n    <color>";	},
	[7] = 
	{
		szTitle   = "Võ học Cái Bang"; --(丐帮)
		szContent = "<Sender>Bang Chủ<Sender>Ta thấy nhà ngươi đã trưởng thành rất nhiều,\n\n    Vì vậy nhận lấy phần quà nhỏ của ta.nhớ hành hiệp trượng nghĩa\n\n    <color>";},
	[8] = 
	{
		szTitle		= "Võ học Thiên nhẫn"; --(天忍)
		szContent   = "<Sender>Hoàn Nhan Tương<Sender>Ta thấy nhà ngươi đã trưởng thành rất nhiều,\n\n    Vì vậy nhận lấy phần quà nhỏ của ta.nhớ hành hiệp trượng nghĩa\n\n    <color>";},
	[9] = 
	{
		szTitle   = "Võ học Võ Đang"; --(武当)
		szContent = "<Sender>Chưởng Môn<Sender>Ta thấy nhà ngươi đã trưởng thành rất nhiều,\n\n    Vì vậy nhận lấy phần quà nhỏ của ta.nhớ hành hiệp trượng nghĩa\n\n    <color>";	},
	[10] = 
	{
		szTitle   = "Võ học Côn Lôn"; --(昆仑)
		szContent = "<Sender>Tống Thu Thạch<Sender>Ta thấy nhà ngươi đã trưởng thành rất nhiều,\n\n    Vì vậy nhận lấy phần quà nhỏ của ta.nhớ hành hiệp trượng nghĩa\n\n    <color>";},
	[11] = 
	{
		szTitle   = "Võ học Minh Giáo"; --(明教)
		szContent = "<Sender>Giáo Chủ<Sender>Ta thấy nhà ngươi đã trưởng thành rất nhiều,\n\n    Vì vậy nhận lấy phần quà nhỏ của ta.nhớ hành hiệp trượng nghĩa\n\n    <color>";},
	[12] = 
	{
		szTitle   = "Võ học Đại Lý Đoàn Thị"; --(大理段氏)
		szContent = "<Sender>Đoàn Trí Hưng<Sender>Ta thấy nhà ngươi đã trưởng thành rất nhiều,\n\n    Vì vậy nhận lấy phần quà nhỏ của ta.nhớ hành hiệp trượng nghĩa\n\n    <color>";},
}

local szSignetMailTitle = "Trưởng môn";
local szSignetMail = [[
Lời trưởng môn:

   Giờ nhà ngươi đã là đệ tử của bản môn, hãy sử dụng Ngũ Hành Ấn này để tăng thêm sức mạnh cho bản thân mình.

   Các môn đệ giữ cho vấn đề này, nên dùng thận trọng, ý thức công lý không được điều ác và làm tổn hại đến bạn đồng môn.

								Trưởng môn
]];

local  szYuanXiao09Mail = [[
<color=red>"Chào mừng Lễ hội đèn lồng, các cầu thủ hoạt động phản hồi" khai trương<color>
<color=yellow>Thời gian:<color>
  Cập nhật ngày 06 Tháng Hai, sau khi bảo trì~Vào 0:00 ngày 20 tháng 2
<color=yellow>Hoạt động của các điều kiện cơ bản:<color>
  Nạp tiền cho 15 tháng hai, vai trò của đấu trường uy tín hoặc 200 nhân dân tệ, vai trò của cấp 69 và ở trên.
<color=yellow>Một cuối: ritualists Lantern gửi Quà tặng<color>
  Trong sự kiện này, vai trò của từng phải đi ritualists Cục nhận được một phần thưởng của ba loại: món quà năm mới, năm mới phong bì màu đỏ, năm mới này mỗi đứa trẻ, mỗi có thể khẳng định một lần. Phần thưởng phong phú, không thể bỏ qua.
<color=yellow>Hoạt động thứ hai: Năm mới chúc lành<color>
  Trong sự kiện, nhân vật từng có 10 người bạn có được cơ hội để ban phước. Người chơi cần phải phụ với nhóm để gửi phước lành và đối thoại ritualists, sau thành công của phước lành chỉ có thể được một phần thưởng.
<color=yellow>Hoạt động ba: Yan Ruoxue quà tặng<color>
  Năm mới sau khi sự kiện này, thời gian sự kiện, Xu Fei Ya tôn vinh Top 20 cầu thủ có thể thu được tại Ruoxue Yan gửi cho cô ấy một món quà.
	
Trên các thành phố lớn ritualists Xinshoucun dài tham khảo ý kiến ​​hoặc lời khuyên giúp truy cập (F12).
]]

local szFuliMail = string.format([[
   Kính gửi người chơi, "Kiếm Thế" Phúc lợi lớn đầu tiên.
     Hiện tại, bạn phải đáp ứng điều kiện nhất định có thể nhận được các lợi ích sau:
     Điểm uy danh giang hồ đạt 60 điểm có thể mua được Tinh Hoạt Lực giảm giá
     Tuần uy danh giang hồ tuần được xếp hạng có thể đổi 12v bạc khóa thành 12v bạc thường
     Thông qua xếp hạng hàng tuần có thể nhận lương = đồng khóa tương ứng
<color=red> Lưu ý: giá trị này dựa trên máy chủ đấu trường uy tín để xác định thứ hạng của tất cả người chơi, vì vậy tôi hy vọng rất nhiều uy tín tham gia hoạt động chơi game cho con sông và hồ. <color>
Thông tin chi tiết có thể được tìm thấy để giúp bộ (F12).
Bạn tìm thấy càng sớm càng tốt để các thành phố lớn trên Xinshoucun ritualists nhận trợ cấp. Chúc các bạn một trò chơi dễ chịu!

]])

local szHighbookMailTitle = "Nâng cao thực hành ";
local szHighbookMail = [[
Sự rèn luyện gian khổ của bản thân có thể chiến thắng tâm ma của chính mình.
Hãy dương cao ngọn cờ chính nghĩa, chống lại các thế lực tàn ác, bảo vệ kẻ yếu là điều 1 kiếm khách nên làm. Đừng nên dở chiêu cắn trộm là không hay.
]];
function Mail:OnLevelUp(nLevel)
	
	if (nLevel == 20) then
		if(me.nFaction < 1 or me.nRouteId < 1) then
			Dbg:WriteLogEx(Dbg.LOG_ERROR, "Mail", "Tuyến đường, võ nghệ thuật là không đúng!");
			return;
		end
		local nMijiId = Npc.tbMenPaiNpc.tbFcts[me.nFaction].tbMiji[me.nRouteId];
		
		if (not nMijiId) then
			Dbg:WriteLogEx(Dbg.LOG_ERROR, "Mail", "Tuyến đường, võ nghệ thuật là không đúng!");	
			return;
		end
	
		local tbMijiItem = { Item.EQUIP_GENERAL, 14, nMijiId, 1, -1 };
		

		local nRet = KPlayer.SendMail(me.szName, Mail.tbMail[me.nFaction].szTitle, Mail.tbMail[me.nFaction].szContent, 
				0, 0, 1, unpack(tbMijiItem));
		if (nRet == 0) then
			Dbg:WriteLogEx(Dbg.LOG_ERROR, "Mail", "Hệ thống không gửi một bức thư!");  
		end		
	end
	
	if (nLevel == 15) then
		self:SendConidionMail();
	end
	if nLevel == 60 then
		-- 发放五行印
		if(me.nFaction < 1) then
			Dbg:WriteLogEx(Dbg.LOG_ERROR, "Mail", "Năm Ấn Độ tóc, võ nghệ thuật là không đúng!");
			return;
		end
		local tbSignet = {Item.EQUIP_GENERAL, 16, me.nFaction, 1, 0 };
		local nRet = KPlayer.SendMail(me.szName, szSignetMailTitle, szSignetMail, 
				0, 0, 1, unpack(tbSignet));
		if (nRet == 0) then
			Dbg:WriteLogEx(Dbg.LOG_ERROR, "Mail", "Hệ thống không gửi một bức thư!");  
		else
			me.SetTask(2023, 5, 1);
		end	
	end
	
	if nLevel == 100 then
		local nRet = KPlayer.SendMail(me.szName, szHighbookMailTitle, szHighbookMail);
	end
end

function Mail:_OnLogin()
	-- TODO 封测使用 临时的
	self:SendSystemMail();
end


function Mail:SendConidionMail()
	local bSend	= me.GetTask(2023, 2) or 0;
	if (bSend == 0) then
		local szMsg = string.format("Kính gửi người chơi：\n    Gần đây trong các trò chơi trực tuyến, có một số nhóm hoặc cá nhân đã lợi dụng những phần mềm bất hợp pháp để can thiệp vào game. Và mọi hành vi gian lận đó sẽ được xử lý thích đáng. \n Hãy chú ý bảo vệ tài sản của chính mình.");
		KPlayer.SendMail(me.szName, "Bảo vệ tài sản", szMsg);
		
		KPlayer.SendMail(me.szName, "Bảo vệ tài sản", 
			"<color=red>Hãy chú ý bảo vệ tài sản của chính mình.<color>");
		me.SetTask(2023,2, 1);
	end
end

function Mail:SendSystemMail()
	
	local bSend	= me.GetTask(2023, 1) or 0;
	local szTime = GetLocalDate("%y%m%d");
	
	if(bSend == 0) then
		KPlayer.SendMail(me.szName, "Chào mừng đến với Kiếm Thế Private",
			string.format("    <color=yellow>Chào mừng bạn đến Kiếm Thế Private!<color>\n    Khi mới bước vào giang hồ bạn sẽ gặp vô vàn khó khăn và thử thách, Hãy trang bị cho mình những hành trang cần thiết trước khi lên đường khám phá một vùng đất mới. Nếu cần trợ giúp hãy liên hệ với <color=red>GM<color>."));
		me.SetTask(2023, 1, 1);
	end

	-- 元宵节活动邮件
	if (szTime >= "090206" and szTime <= "090220" and me.GetTask(2023, 6) == 0) then
		KPlayer.SendMail(me.szName, "Hoạt động", szYuanXiao09Mail);
		me.SetTask(2023, 6, 1);
	end
	-- 福利 每月发送一封
	
	local nMonth = tonumber(GetLocalDate("%m"));
	if (me.GetTask(2023, 7)  ~= nMonth) then
		local nMoney = 12 * CoinExchange.__ExchangeRate_wellfare;
		KPlayer.SendMail(me.szName, "Phúc lợi", string.format(szFuliMail, nMoney));
		me.SetTask(2023, 7, nMonth);
	end
	
	bSend = me.GetTask(2023, 5) or 0;
	if (0 == bSend) and me.nLevel >= 60 then
		-- 发放五行印
		if(me.nFaction < 1) then
			Dbg:WriteLogEx(Dbg.LOG_ERROR, "Mail", "发五行印，门派不正确！");
			return;
		end
		local tbSignet = {Item.EQUIP_GENERAL, 16, me.nFaction, 1, 0 };
		KPlayer.SendMail(me.szName, szSignetMailTitle, szSignetMail,
				0, 0, 1, unpack(tbSignet));
		me.SetTask(2023, 5, 1);
	end
end

if (MODULE_GAMESERVER) then	-- GS专用
	-- 注册事件回调
	PlayerEvent:RegisterGlobal("OnLevelUp", Mail.OnLevelUp, Mail);
	PlayerEvent:RegisterGlobal("OnLogin", Mail._OnLogin, Mail);
end
