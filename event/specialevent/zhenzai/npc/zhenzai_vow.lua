-- �ļ�������vowtree.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2009-12-28 11:12:16
-- ��  ��  ����Ը��

local tbNpc= Npc:GetClass("zhenzai_vowtree");
SpecialEvent.ZhenZai = SpecialEvent.ZhenZai or {};
local ZhenZai = SpecialEvent.ZhenZai or {};

tbNpc.tbMsg = {[1] = "�����������𿹺�������ͬ���ؽ���԰��",		
			  [2] = "���ǵ�����Զ��������һ��ףԸ��������ƽ����<color>",
			  [3] = "����ף��Զ�ഫ����������������˫������ů����ɢ���ѣ������й���һ���ģ������ѹء�",			
			  [4] = "���Ķ�Ů���������ŽΌ�֣� ������������һ��ƽ���� "
			 };

function tbNpc:OnDialog()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData < ZhenZai.VowTreeOpenTime or nData > ZhenZai.VowTreeCloseTime then	--��ڼ���
		Dialog:Say("�ĳ����飬���ǵ����ڰѴ�Ҷ����������ٿ�ʼ�ɣ�", {"֪����"});
		return;
	end
	--��ҵ�����Ը����
	local nDateEx = me.GetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_TIME) or 0;
	local nTimes = 0;
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	if nDateEx ~= nNowDate then
		me.SetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_TIME, nNowDate);
		me.SetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_COUNT, 0);
	else
		nTimes = me.GetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_COUNT) or 0;
	end	
	local nCount =  KGblTask.SCGetDbTaskInt(DBTASD_EVENT_ZHENZAI_VOWNUM);	
	local szMsg = string.format("    ���ϴ󲿷ݵ������ܰ��겻���ĺ��֣���Ķ������ա��ຣ������������������7.1��ǿ�ҵ��𡣿�Ϊ������������Ը�ɣ���Ҳ����������ջ�\n\n<color=red>    Ŀǰ�ѽ���Ը��������%s��<color>\n<color=red>    ����������Ը��������%s��<color>", nCount, nTimes);
	Dialog:Say(szMsg,
		{
			{"ĬĬ��ף��", self.Vow, self, 1, him.dwId},
			{"Ϊ����������Ը[���ѹ���]", self.Vow, self, 2, him.dwId},
			{"Ϊ����������Ը[�����ṫ��]", self.Vow, self, 3, him.dwId},
			{"Ϊ����������Ը[���Ѽ����ṫ��]", self.Vow, self, 4, him.dwId},			
			{"��ȡƽ����",self.GetPingAn, self},
			{"2010����Ը����ȡ����", self.GetEncouragement, self, him.dwId},		
			{"����㿴��"}
		});
end

function tbNpc:GetPingAn()
	if me.nLevel < ZhenZai.nLevel  then
		Dialog:Say(string.format("���ĵȼ�����%s����������Ը��",ZhenZai.nLevel),{"֪����"});
		return 0;
	end	
	if me.GetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_GETPINGAN) == 1 then
		Dialog:Say("���Ѿ���ȡ���ˣ�",{"֪����"});
		return 0;
	end
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("��Ԥ��1�񱳰��ռ�������Ը��",{"֪����"});
		return 0;
	end
	local pItem = me.AddItem(18,1,934,1);   --ƽ����
	if pItem then
		me.AddTitle(unpack(ZhenZai.tbPingAnYiJia));
		me.SetCurTitle(unpack(ZhenZai.tbPingAnYiJia));
		local nSec = Lib:GetDate2Time(ZhenZai.nOutTime)	
		pItem.SetTimeOut(0, nSec);
		pItem.Sync();		
		me.SetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_GETPINGAN, 1);
	end
end

function tbNpc:Check()
	--�ȼ��ж�
	if me.nLevel < ZhenZai.nLevel  then
		Dialog:Say(string.format("���ĵȼ�����%s����������Ը��",ZhenZai.nLevel),{"֪����"});
		return 0;
	end
	
	--��Ҫ�С�ϣ��֮�֡�
	local tbItem = me.FindItemInBags(unpack(ZhenZai.tbXiWang));
	if #tbItem == 0 then
		Dialog:Say("��Ҫ�С�ϣ��֮ˮ�����ܽ�����Ը��",{"֪����"});
		return 0;
	end
	
	--�����ж�
	if me.CountFreeBagCell() < 2 then
		Dialog:Say("��Ԥ��2�񱳰��ռ�������Ը��",{"֪����"});
		return 0;
	end
end

--��Ը
function tbNpc:Vow(nType, nNpcId)	
	if self:Check() == 0 then
		return 0;
	end
	local tbItem = me.FindItemInBags(unpack(ZhenZai.tbXiWang));
	if nType == 1 then
		self:GetAward(tbItem);
		me.Msg("��ĬĬ��ף������������");
		return;
	end
	local szMsg = string.format("    ���ϴ󲿷ݵ������ܰ��겻���ĺ��֣���Ķ������ա��ຣ������������������7.1��ǿ�ҵ��𡣿�Ϊ������������Ը�ɣ���Ҳ����������ջ�\n");
	local tbObt = {};
	for i =1, #self.tbMsg do
		table.insert(tbObt,{self.tbMsg[i],self.SentInformation, self,  nType, i, nNpcId, tbItem})
	end
	table.insert(tbObt,{"����㿴��"});
	Dialog:Say(szMsg,tbObt);	
	return;
end

function tbNpc:CheckPosition(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return 0;
	end	
	if self:Check() == 0 then
		return 0;
	end
	local nMapId, nPosX, nPosY = me.GetWorldPos();	       		     
	local nMapId2, nPosX2, nPosY2 = unpack(ZhenZai.tbVowTreePosition)
	local nDisSquare = (nPosX - nPosX2)^2 + (nPosY - nPosY2)^2;
	if nMapId2 ~= nMapId or nDisSquare > 400 then
		Dialog:Say("������ƽ���𸽽�������Ը��");
		return 0;
	end
	return 1;
end

--����Ƶ��
function tbNpc:SentInformation(nType, nTextId, nNpcId, tbItem)
	if  self:CheckPosition(nNpcId) == 0 then
		return 0;
	end
	--Ƶ������
	local szMsg = string.format("%s��ƽ����������Ը����",me.szName).."<color=purple>"..self.tbMsg[nTextId].."<color>";	
	me.Msg("����ƽ����������Ը����<color=yellow>"..self.tbMsg[nTextId].."<color>");
	if nType == 2 then		--����Ƶ��
		me.SendMsgToFriend(szMsg);
	elseif nType == 3 then	--��ᡢ����Ƶ��
		if me.dwKinId ~= 0 then
			KKin.Msg2Kin(me.dwKinId, szMsg);
		end
		if me.dwTongId ~= 0  then
			KTong.Msg2Tong(me.dwTongId, szMsg);
		end
	elseif nType == 4 then	--���ѡ���ᡢ����Ƶ��
		me.SendMsgToFriend(szMsg);
		if me.dwKinId ~= 0 then
			KKin.Msg2Kin(me.dwKinId, szMsg);
		end
		if me.dwTongId ~= 0  then
			KTong.Msg2Tong(me.dwTongId, szMsg);
		end
	end
	self:GetAward(tbItem);
end

function tbNpc:GetAward(tbItem)
	tbItem[1].pItem.Delete(me);	--ɾ��ϣ��֮��
	local nCount = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_ZHENZAI_VOWNUM);
	GCExcute({"SpecialEvent.ZhenZai:AddGTask"});
	
	--��ҵ�����Ը����
	local nDate = me.GetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_TIME);
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	if nDate < nNowDate then
		me.SetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_TIME, nNowDate);
		me.SetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_COUNT, 0);
	end
	local	nTimes = me.GetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_COUNT);
	if nTimes < ZhenZai.nGetFudaiMaxNum then		--ǰ��θ�����
		me.AddItem(18,1,80,1);			--����
	end
	me.SetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_COUNT, nTimes + 1);
	
	--����1001��Ը��������1001��Ը������ҽ�����֪ͨȫ��ȥ�콱
	if (nCount + 1) == ZhenZai.nTrapNumber then
		Dialog:GlobalNewsMsg_GS(string.format("%s������ƽ����ĵ�%s��ףԸ����Ϊ���յ�ƽ����ʹ����������һ����ƽ����", me.szName, ZhenZai.nTrapNumber));
		me.AddTitle(unpack(ZhenZai.tbVowTree_Title));
		me.SetCurTitle(unpack(ZhenZai.tbVowTree_Title));
		local pItemEx = me.AddItem(unpack(ZhenZai.tbBaoXiang));
		if pItemEx then
			EventManager:WriteLog(string.format("[����]�����Ʒ:%s",pItemEx.szName), me);
			me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[����]�����Ʒ:%s",pItemEx.szName));
		end
	end
end

--��ý���
function tbNpc:GetEncouragement(nNpcId)	
	if me.nLevel < ZhenZai.nLevel  then
		Dialog:Say(string.format("���ĵȼ�����%s����������Ը��",ZhenZai.nLevel),{"֪����"});
		return 0;
	end
	
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return;
	end	
	
	--��ҵ����Ƿ��������
	local nDate = me.GetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_TIMEEx) or 0;
	local nFlag = 0;
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	if nDate ~= nNowDate then
		me.SetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_TIMEEx, nNowDate);
		me.SetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_ISGETAWARD, 0);
	else
		nFlag = me.GetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_ISGETAWARD) or 0;		
	end
	if nFlag == 1 then
		Dialog:Say("�������Ѿ���ȡ�������ˣ��������콱�ˣ�",{"֪����"});
		return;
	end
	
	--Ը�������Ƿ�����
	local nCount = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_ZHENZAI_VOWNUM);
	if nCount < ZhenZai.nTrapNumber then
		Dialog:Say(string.format("ƽ����û���յ�%s��Ը�����޽�������ȡ��", ZhenZai.nTrapNumber),{"֪����"});
		return;
	end
	
	--������	
	me.AddSkillState(880, 1, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	me.AddSkillState(385, 6, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	me.AddSkillState(386, 6, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	me.AddSkillState(387, 6, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);					
	me.SetTask(ZhenZai.TASKID_GROUP, ZhenZai.TASKID_ISGETAWARD, 1);
end
