--Require("\\script\\npc\\faction\\menpaizhangmenren.lua");

--local tbGaiBangMenPaiZhangMenRen = Npc:NewClass("gaibangzhangmenren", "menpaizhangmenren");

local tbJie = Npc:GetClass("wuxi");

function tbJie:OnDialog()
	-- ������Լ���һЩͨ�õ�Npc�Ի��¼�
	local tbOpt	= {};
	local task_value = me.GetTask(1022,39)
	
	if task_value == 1 then
		tbOpt[#tbOpt+1] = {"������������ս", self.Send2NewWorld};
		tbOpt[#tbOpt+1]	= {"���ڻ�������ս", self.OriginalDialog};
		tbOpt[#tbOpt+1]	= {"K?t th��c ??i tho?i"};
		Dialog:Say(string.format("%s�����������ã�me.szname��", him.szName), tbOpt);
		return;
	end;
	
	self:OriginalDialog();
end


function tbJie:Send2NewWorld()
	me.NewWorld(197,1801,3867);
	me.SetFightState(1);
end

-- ԭ��Npc�Ի���������жԻ�����
function tbJie:OriginalDialog()
	self:OnDialog();
end;
