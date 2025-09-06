-------------------------------------------------------------------
--File: 	base.lua
--Author: sunduoliang
--Date: 	2008-4-15
--Describe:	�����ϵͳ
--InterFace1:
--InterFace2:
--InterFace3:
-------------------------------------------------------------------

do return end

Require("\\script\\event\\manager\\define.lua");

local EventKind = {};
EventManager.EventKind.Npc.GetAward = EventKind;

function EventKind:OnDialog(nCheck)
	local tbSelect 	 = EventManager.tbFun:GetParam(self.tbEventPart.tbParam,"AddSelect", 1)
	if nCheck == nil and #tbSelect > 0 then
		local tbParam = EventManager.tbFun:SplitStr(tbSelect[1]);
		local tbOpt = {
				{tbParam[2] or "ȷ����ȡ", self.OnDialog, self, 1},
				{EventManager.DIALOG_CLOSE},
			};
		Dialog:Say(tbParam[1] or "���ã���ʲô��Ҫ������", tbOpt);
		return 0;
	end		
	
	local nFlag, szMsg = EventManager.tbFun:CheckParam(self.tbEventPart.tbParam);
	if nFlag == 1 and szMsg then
		if szMsg then
			Dialog:Say(szMsg);
		end
		return 0;
	end		
	local nFlag, szMsg = EventManager.tbFun:ExeParam(self.tbEventPart.tbParam);
	if nFlag == 1 then
		if szMsg then
			me.Msg(szMsg);
		end
		return 0;
	end
	--Dialog:Say("����ȡ�ɹ���");
	return 0;
end
