-------------------------------------------------------
-- �ļ�������wldh_shanren.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-09-02 20:14:02
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\battle\\wldh_battle_def.lua");

local tbNpc	= Npc:GetClass("wldh_shanren");

-- ��NPC�Ի�
function tbNpc:OnDialog(szCamp)

	local tbOpt	= 	
	{
		{"�������", self.OnBuyYao, self},
		{"���ٿ��ǿ���"},
	};

	Dialog:Say("���ã��������ʹ�����ִ��ר������������ҩƷ��", tbOpt);
end

-- ��ҩ
function tbNpc:OnBuyYao()
	me.OpenShop(164,10);
end

function tbNpc:OnBuyYaoByBind()
	me.OpenShop(14,7);
end

-- ���
function tbNpc:OnBuyCai()
	me.OpenShop(21,1);
end

function tbNpc:OnBuyCaiByBind()
	me.OpenShop(21,7);
end
