-------------------------------------------------------
-- �ļ�������wldh_shiliangu1.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-09-02 15:49:49
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle_def.lua");

-- �����Ƚ����ˣ�Ӣ�۵� to ������
local tbNpc = Npc:GetClass("wldh_shiliangu1");

function tbNpc:OnDialog()

	local tbOpt = {};
	for i, nMapId in ipairs(Wldh.Battle.tbShiliangu) do
		table.insert(tbOpt, {string.format("����ǰ�������ȣ�%s��", Lib:Transfer4LenDigit2CnNum(i)), self.TransToShiLian, self, nMapId});
	end
	table.insert(tbOpt, {"���ٿ��ǿ���"});
	
	local szMsg = "��ã��ҿ��Դ���ǰ�������ȡ����������Լ������Բ�ͬ�ط�����������ѡ�֡����������ڣ�����Ժ�����һЩ�д����ա�";
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:TransToShiLian(nMapId)
	me.NewWorld(nMapId, 1597, 3190);
end
