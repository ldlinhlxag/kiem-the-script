Require("\\script\\event\\manager\\define.lua");

local EventKind = {};
EventManager.EventKind.Module.action_callnpc = EventKind;

function EventKind:ExeNpcStartFun(tbParam)
	return EventManager.EventKind.Module.default.ExeNpcStartFun(self, tbParam);
end

function EventKind:ExeNpcEndFun(tbNpc)
	--ִ���ٻ��������;
	return EventManager.EventKind.Module.default.ExeNpcEndFun(self, tbNpc);
end

