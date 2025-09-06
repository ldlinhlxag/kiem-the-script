Require("\\script\\event\\collectcard\\define.lua")

local tbItem = Item:GetClass("collect_token");
local CollectCard = SpecialEvent.CollectCard;
local tbAward = 
{

	[1] = 1000,
	[2] = 3000,
	[3] = 500,	
}

function tbItem:OnUse()
	me.AddRepute(5, 2, tbAward[it.nLevel]);
	if it.nLevel ~= 3 then
		me.Msg(string.format("�����<color=yellow>%s��<color>ʢ�Ļ�������ɵ��꾩��ң�ȿ��̴�����ȫ����+1������",tbAward[it.nLevel]))
		Dialog:SendBlackBoardMsg(me, "�������ʢ�Ļ�������ɵ���ң�ȿ��̴�����ȫ����+1������")
	else
		me.Msg(string.format("�����<color=yellow>%s��<color>ʢ�Ļ������",tbAward[it.nLevel]))
	end
	CollectCard:WriteLog(string.format("ʹ��ʢ�Ļ���ƣ������%s������", tbAward[it.nLevel]), me.nId);			
	return 1;
end


