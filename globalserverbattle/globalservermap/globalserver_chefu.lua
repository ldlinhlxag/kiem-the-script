-------------------------------------------------------
-- �ļ�������globalserver_chefu.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-09-02 19:23:30
-- �ļ�������
-------------------------------------------------------

local tbNpc = Npc:GetClass("globalserver_chefu");

function tbNpc:OnDialog()
	if me.GetCamp() == 6 then
		Dialog:Say("���߼ǵ�Ҫ��GM��Ŷ������������")
		return;
	end
	local szMsg = "��ã��ҿ��Դ����뿪Ӣ�۵���"
	local tbOpt = 
	{
		{"�뿪���ִ��Ӣ�۵�", self.TransToLocal, self},
--		{"ǰ������ν�����", self.TransToBattle, self},
		{"��������"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:TransToLocal()
	Transfer:NewWorld2MyServer(me);
end

function tbNpc:TransToBattle()
	me.NewWorld(1651, unpack(Wldh.Battle.POS_SIGNUP[MathRandom(1, 3)]));
end
