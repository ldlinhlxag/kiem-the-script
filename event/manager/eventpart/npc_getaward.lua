-------------------------------------------------------------------
--File: 	base.lua
--Author: sunduoliang
--Date: 	2008-4-15
--Describe:	�����ϵͳ
--InterFace1:
--InterFace2:
--InterFace3:
-------------------------------------------------------------------
Require("\\script\\event\\manager\\define.lua");

local EventKind = {};
EventManager.EventKind.Module.npc_getaward = EventKind;

function EventKind:OnDialog(nCheck)
	return EventManager.EventKind.Module.default.OnDialog(self, nCheck);
end
