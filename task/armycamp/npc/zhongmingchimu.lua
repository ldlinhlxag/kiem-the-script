local tbZhongMingChiMu = Npc:GetClass("zhongmingchimu");

tbZhongMingChiMu.szText = "   Phụng mệnh Hoàng Đế Đại Lý đến cầu viện nghĩa quân, chiêu mộ một toán quân tinh nhuệ đến Bách Man Sơn dẹp yên Cổ Vương. Ai hưởng ứng mời đến gặp ta nhận nhiệm vụ, rồi tìm các Quan Truyền Tống (phó bản) để đến Bách Man Sơn.";
function tbZhongMingChiMu:OnDialog()
	local tbOpt = {{"Kết thúc đối thoại"}, };
	Dialog:Say(self.szText, tbOpt);
end;
