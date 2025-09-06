-- �ļ�������nianhua_identify.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2009-12-29 09:12:13
-- ��  ��  ����������껭

local tbItem 	= Item:GetClass("picture_newyear_d");
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};

function tbItem:OnUse()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData < SpringFrestival.VowTreeOpenTime or nData > SpringFrestival.VowTreeCloseTime then	--��ڼ�
		Dialog:Say("û���ڻ�ڼ䣬��������ʹ�ø���Ʒ��", {"֪����"});
		return;
	end
	Dialog:Say("�����껭�����Խ�������ղغб���������Ҳ���Լ����ռ�������ȡ�������к��뷨��",
			{"Bo vao hop thu thap", self.Add2Box, self,  it.dwId},
			{"Bo vao so luu tru", self.Add2Book, self,  it.dwId},
			{"khong muon lam"}
			);
end

--��ŵ��껭�ղغ�
function tbItem:Add2Box(nItemId)
	--�����ж�
	if me.CountFreeBagCell() < 2 then
		Dialog:Say("��Ҫ2�񱳰��ռ䣬������������",{"֪����"});
		return;
	end
	local pItem = KItem.GetObjById(nItemId);
	if pItem then
		local tbItem = me.FindItemInAllPosition(unpack(SpringFrestival.tbNianHua_box));
		if #tbItem == 0 then		
			me.AddItem(unpack(SpringFrestival.tbNianHua_box));
		end
		local tbItemEx = me.FindItemInAllPosition(unpack(SpringFrestival.tbNianHua_book));
		if #tbItemEx == 0 then			
			me.AddItem(unpack(SpringFrestival.tbNianHua_book));
		end		
		local nNum = pItem.nLevel;
		local nCount = me.GetTask(SpringFrestival.TASKID_GROUP,SpringFrestival.TASKID_NIANHUA_BOX + nNum - 1) or 0;
		if nCount >= 20 then
			Dialog:Say("�����ղغ������껭�Ѿ������ˣ������ٱ����ȥ��",{"֪����"});
			return;
		end
		nCount = nCount + 1;
		me.SetTask(SpringFrestival.TASKID_GROUP,SpringFrestival.TASKID_NIANHUA_BOX + nNum - 1, nCount);
		pItem.Delete(me);
	end
end

--�����껭�ռ���
function tbItem:Add2Book(nItemId)
	--�����ж�
	if me.CountFreeBagCell() < 2 then
		Dialog:Say("��Ҫ2�񱳰��ռ䣬������������",{"֪����"});
		return;
	end
	local pItem = KItem.GetObjById(nItemId);
	if pItem then
		local tbItem = me.FindItemInAllPosition(unpack(SpringFrestival.tbNianHua_box));
		if #tbItem == 0 then
			me.AddItem(unpack(SpringFrestival.tbNianHua_box));			
		end
		local tbItemEx = me.FindItemInAllPosition(unpack(SpringFrestival.tbNianHua_book));
		if #tbItemEx == 0 then
			me.AddItem(unpack(SpringFrestival.tbNianHua_book));			
		end
		local nNum = pItem.nLevel;
		local nFlag = me.GetTask(SpringFrestival.TASKID_GROUP,SpringFrestival.TASKID_NIANHUA_BOOK+ nNum - 1) or 0;
		if nFlag == 1 then
			Dialog:Say("�����ռ������Ѿ����������껭�������ټ����ˡ������Խ��䱣�浽�ղغ��л�����������ҡ�",{"֪����"});
			return;
		end
		me.SetTask(SpringFrestival.TASKID_GROUP,SpringFrestival.TASKID_NIANHUA_BOOK + nNum - 1, 1);
		pItem.Delete(me);
	end	
end
