-- 李金财脚本

local LiJinCai	= Npc:GetClass("jbexchange_npc");

if (not MODULE_GAMESERVER) then
	return;
end

LiJinCai.tbInfomation = 
{
	[1] = "Để vào được giao diện giao dịch đồng. Hãy đến 7 thành thị lớn chọn NPC <color=gold>Lý Cẩm Tài<color> Trong đó bạn có thể chọn giao dịch từ đồng qua bạc, hoặc từ bạc qua đồng tùy vào nhu cầu của bạn.";
	[2] = "Trong giao diện giao dịch đồng, chọn bán đồng giá đơn vị là giá bạn muốn bán /1 đồng. số lượng cần bán, Giá tổng là số tiền bán bạn nhận được đã trừ 1% phí";
	[3] = "Trong giao diện giao dịch đồng, chọn mua đồng giá đơn vị là giá bạn muốn mua /1 đồng. số lượng cần mua, Giá tổng là số đồng bạn nhận được, Khi mua đồng không mất phí.";
	[4] = "Với mỗi giao dịch bán đồng lấy bạc, người bán đồng sẽ chịu 1% thuế của tổng giao dịch. Số tiền này sẽ dùng để đầu tư trang thiết bị của ";
	
}
-- 定义对话事件
function LiJinCai:OnDialog()
	if IVER_g_nSdoVersion == 1 then
		return
	end
	
	local szMsg	= "Xin chào, đây là nơi giao dịch đồng.\n Bạn đang lo lắng về số bạc bạn kiếm được ？Yên tâm hãy đến đây để có thể tìm những mối giao dịch tốt, dùng bạc để đổi lấy tiền đồng có thể mua được đồ có giá trị trên Kỳ Trân Các.";
	
	Dialog:Say(szMsg, 
		{
			{"Giao dịch đồng",  LiJinCai.OpenJbExchange, 	self},
			{"Trợ giúp",    LiJinCai.HelpInformation, 	self},
			{"Kết thúc đối thoại"}
		});
end

function LiJinCai:OpenJbExchange()
	JbExchange:ApplyOpenJbExchange();
end

function LiJinCai:HelpInformation()
	Dialog:Say("Trợ giúp",
		{
			{"Một, làm thế nào để vào giao diện ？", 	 LiJinCai.ShowInfomation, self, 1},
			{"Hai, làm thế nào để trao đổi đồng ？",	 LiJinCai.ShowInfomation, self, 2},
			{"Ba, lam thế nào để trao đổi bạc ？",	 LiJinCai.ShowInfomation, self, 3},
			{"Bốn, tỷ giá giao dịch bạc là sao ?", LiJinCai.ShowInfomation, self, 4},
			{"Kết thúc đối thoại"},
		});
end

function LiJinCai:ShowInfomation(nNum)
	local szMsg = self.tbInfomation[nNum];
	assert(szMsg);
	Dialog:Say( szMsg,
		{
			{ "Trở lại" , LiJinCai.HelpInformation, self};
			{ "Kết thúc đối thoại" };
		})
end