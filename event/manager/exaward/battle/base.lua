do return end

Require("\\script\\event\\manager\\define.lua");

local EventKind = {};
EventManager.EventKind.ExAward.Battle = EventKind;

function EventKind:CreateKind()
	--����
	EventManager.tbFunction_Base:SetTimerStart(self);
	EventManager.tbFunction_Base:SetTimerEnd(self);
end

function EventKind:ExeStartFun()
	--����ս����ػ���ؿ���

	return 0;
end

function EventKind:ExeEndFun()
	--����ս����ػ���ؽ���
	return 0;
end
