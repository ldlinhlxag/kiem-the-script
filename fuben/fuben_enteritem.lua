-- �ļ�������fuben.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2009-12-7
-- ��  ��  ��

-- �������߽ű�

local tbFuBen= Item:GetClass("fuben_enter");

function tbFuBen:OnUse()	
	local tbOpt = {};
	local szMsg = "Sao chép vào các mã thông báo,đưa bạn đến một phó bản của đội trưỡng đã mở";
	tbOpt = {
			{"Thực hiện theo đội trưỡng", Npc:GetClass("dataosha_city").OnEnter, Npc:GetClass("dataosha_city"), me.nId},
			{"Hủy Bỏ"},
		};
	Dialog:Say(szMsg, tbOpt);
	return;
end
	