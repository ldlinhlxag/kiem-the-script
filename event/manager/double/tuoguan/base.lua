
do return end

Require("\\script\\event\\manager\\define.lua");

local EventKind = {};
EventManager.EventKind.Double.TuoGuan = EventKind;

function EventKind:ExeStartFun()
	--ִ��˫����
	--local szMsg = self.tbEventPart.szName .. "˫������";
	--KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, szMsg);
	return 0;
end

function EventKind:ExeEndFun()
	--����˫��;
	--local szMsg = self.tbEventPart.szName.."˫������";
	--KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, szMsg);
	return 0;
end