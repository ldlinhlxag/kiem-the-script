-------------------------------------------------------------------
--File: 	factionshop_gs.lua
--Author: 	sunduoliang
--Date: 	2008-3-14
--Describe:	���������˴��������ɾ���װ��
-------------------------------------------------------------------
local tbFactionShop	= {};	-- 	����ս��Ϣʱ��
FactionBattle.tbFactionShop = tbFactionShop;

tbFactionShop.tbFactionShopID =
{
	[1] = 25, -- ����
	[2] = 26, --��������
	[3] = 27, --��������
	[4] = 29, --�嶾����
	[5] = 31, --��������
	[6] = 32, --��������
	[7] = 34, --ؤ������
	[8] = 33, --��������
	[9] = 35, --�䵱����
	[10] = 36, --��������
	[11] = 28, --��������
	[12] = 30, --�����������
}

function tbFactionShop:OpenShop(nFaction)
	me.OpenShop(self.tbFactionShopID[nFaction], 1) --ʹ����������
end
