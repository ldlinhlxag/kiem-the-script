--��������Ա
--�����
--2008.09.12

local tbNpc = Npc:GetClass("Wldh_guanyuan1");

function tbNpc:OnDialog()
	local nType, nIsFinal = Wldh:GetCurGameType();
	if nType <= 0 then
		Dialog:Say("��ã���ʲô��Ҫ��æ��");
		return 0;
	end
	local szMsg = "";
	if nIsFinal > 0 then
		szMsg = string.format([[
   ���ڵ�������<color=yellow>%s����<color>�׶Ρ�
   ����ʱ������£�<color=yellow>
      20��00  32��16
      20��15  16��8
      20��30  8��4
      20��45  4��2
      21��00  2��1 ��һ��
      21��15  2��1 �ڶ���
      21��30  2��1 ������<color>]], Wldh:GetName(nType));
    else
		szMsg = string.format("������%s�׶Ρ�\n\n%s", Wldh:GetName(nType),Wldh:GetDesc(nType));
	end
	local tbOpt = {
		{"�μӱ����ͱ���", Wldh.DialogNpc.Attend, Wldh.DialogNpc, nType},
		{"ѡ�����ƽ���ս��", Wldh.DialogNpc.ChoseType, Wldh.DialogNpc},
		{"��ѯս����Ϣ", Wldh.DialogNpc.Query, Wldh.DialogNpc},
		{"��ֻ��������"},
	};
	Dialog:Say(szMsg, tbOpt);
end
