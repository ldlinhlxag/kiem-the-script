-- �ļ�������mingyang_identify.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2010-03-31 14:16:07
-- ��  ��  ��

local tbItem 	= Item:GetClass("mingyang_identify");
SpecialEvent.LaborDay = SpecialEvent.LaborDay or {};
local LaborDay = SpecialEvent.LaborDay or {};

function tbItem:OnUse()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData < LaborDay.OpenTime or nData > LaborDay.CloseTime then
		Dialog:Say("û���ڻ�ڼ䣬��������ʹ�ø���Ʒ��", {"֪����"});
		return;
	end
	Dialog:Say("������������Լ����ռ�������ȡ�������к��뷨��",			
			{"�����ռ���", self.Add2Book, self,  it.dwId},
			{"��������"}
			);
end

--�����ռ���
function tbItem:Add2Book(nItemId)
	--�����ж�
	if me.CountFreeBagCell() < 2 then
		Dialog:Say("��Ҫ1�񱳰��ռ䣬������������",{"֪����"});
		return;
	end
	local pItem = KItem.GetObjById(nItemId);
	if pItem then		
		local tbItemEx = me.FindItemInAllPosition(unpack(LaborDay.tbmingyang_book));
		if #tbItemEx == 0 then
			me.AddItem(unpack(LaborDay.tbmingyang_book));			
		end
		local nNum = pItem.nLevel;
		local nFlag = me.GetTask(LaborDay.TASKID_GROUP,LaborDay.TASKID_BOOK+ nNum - 1);
		if nFlag == 1 then
			Dialog:Say("�����ռ������Ѿ������������ӣ������ټ����ˡ�",{"֪����"});
			return;
		end
		me.SetTask(LaborDay.TASKID_GROUP, LaborDay.TASKID_BOOK + nNum - 1, 1);
		pItem.Delete(me);
	end	
end
