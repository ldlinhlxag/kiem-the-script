Require("\\script\\event\\manager\\define.lua");

local EventKind = {};
EventManager.EventKind.Module.item_useitem = EventKind;

function EventKind:OnUse()
	--��Ʒʹ�ýű�	
	return EventManager.EventKind.Module.default.OnUse(self);
end

function EventKind:PickUp()
	--ʰȡִ�нű�
	return 1;
end

function EventKind:IsPickable()
	--�Ƿ�����ʰȡ�жϽű�
	return 1;
end

function EventKind:InitGenInfo()
	--ʰȡִ�нű�
	return {};
end
