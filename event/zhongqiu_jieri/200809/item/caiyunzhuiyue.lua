--����׷��
--2008.09.03
--�����


local tbItem = Item:GetClass("caiyunzhuiyue");

tbItem.tbBook =
{ --��Ʒ�ȼ� = {�������ޣ���������飬�������, ����Ǳ�ܵ�����};
  2, 2040, 20, 10,
}
function tbItem:OnUse()
	local tbParam = self.tbBook;
	if not tbParam then
		return 0;
	end
	local nUse =  me.GetTask(tbParam[2], tbParam[3]);
	if nUse >= tbParam[1] then
		me.Msg(string.format("<color=yellow>��ʳ����%s��%s���Ѳ��ܳԵ����ˡ�", tbParam[1], it.szName));
		Dialog:SendInfoBoardMsg(me, string.format("<color=yellow>��ҧ��һ��%s��������ζ��", it.szName))
		return 0;
	end
	
	me.AddPotential(tbParam[4])
	me.SetTask(tbParam[2], tbParam[3], nUse +1)
	
	PlayerHonor:UpdataMaxWealth(me);		-- ���²Ƹ����ֵ
	local szMsg = string.format("<color=yellow>��ʳ����%s���������򣬻����%sǱ�ܵ㡣", it.szName, tbParam[4]);
	Dialog:SendInfoBoardMsg(me, szMsg)
	szMsg = string.format("%s����ʳ����%s��%s��",szMsg, nUse +1, it.szName);
	me.Msg(szMsg);
	
	return 1;
end

function tbItem:GetTip()
	local szTip = "";
	local tbParam = self.tbBook;
	local nUse =  me.GetTask(tbParam[2], tbParam[3]);
	szTip = szTip .. string.format("<color=green>��ʳ��%s/%s��<color>", nUse, self.tbBook[1]);
	return szTip;
end