-- �ļ�������vowtree.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2009-12-28 11:12:16
-- ��  ��  ����Ը��

local tbNpc= Npc:GetClass("xinnian_vowtree");
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};

function tbNpc:OnDialog()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData < SpringFrestival.VowTreeOpenTime or nData > SpringFrestival.VowTreeCloseTime then	--��ڼ���
		Dialog:Say("ʱ���������죡", {"֪����"});
		return;
	end
	--��ҵ�����Ը����
	local nDateEx = me.GetTask(SpringFrestival.TASKID_GROUP_EX, SpringFrestival.TASKID_VOWTREE_TIME) or 0;
	local nTimes = 0;
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	if nDateEx ~= nNowDate then
		me.SetTask(SpringFrestival.TASKID_GROUP_EX, SpringFrestival.TASKID_VOWTREE_TIME, nNowDate);
		me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_COUNT, 0);
	else
		nTimes = me.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_COUNT) or 0;
	end	
	local nCount =  KGblTask.SCGetDbTaskInt(DBTASD_EVENT_SPRINGFRESTIVAL_VOWNUM);	
	local szMsg = string.format("�������ʲôԸ���أ��������������˵�����Ϳ���ʵ��Ŷ��ע�⣬����Խ����Ը����������ͬ������Ƶ��������ϸѡ��\n<color=red>Ŀǰ�ѽ���Ը��������%s��<color>\n<color=red>����������Ը��������%s��<color>", nCount, nTimes);
	Dialog:Say(szMsg,
		{
			{"������Ը��", self.Vow, self, 1, him.dwId},
			{"�ϵ���Ը[���ѹ���]", self.Vow, self, 2, him.dwId},
			{"�ϵ���Ը[�����ṫ��]", self.Vow, self, 3, him.dwId},
			{"�ϵ���Ը[���Ѽ����ṫ��]", self.Vow, self, 4, him.dwId},
			--{"��ȡ����", self.GetEncouragement, self, him.dwId},
			{"����㿴��"}
		});
end

function tbNpc:Check()
	--�ȼ��ж�
	if me.nLevel < SpringFrestival.nLevel  then
		Dialog:Say(string.format("���ĵȼ�����%s����������Ը��",SpringFrestival.nLevel),{"֪����"});
		return 0;
	end
	
	--��Ҫ�С�ϣ��֮�֡�
	local tbItem = me.FindItemInBags(unpack(SpringFrestival.tbXiWang));
	if #tbItem == 0 then
		Dialog:Say("��Ҫ�С�ϣ��֮�֡����ܽ�����Ը��",{"֪����"});
		return 0;
	end
	
	--�����ж�
	if me.CountFreeBagCell() < 4 then
		Dialog:Say("��Ԥ��4�񱳰��ռ�������Ը��",{"֪����"});
		return 0;
	end
end

--��Ը
function tbNpc:Vow(nType, nNpcId)
	if self:Check() == 0 then
		return 0;
	end
	local tbItem = me.FindItemInBags(unpack(SpringFrestival.tbXiWang));
	Dialog:AskString("����Ը��(10����) ", 20, self.InputInformation, self, nType, tbItem, nNpcId);
	return;
end	

--����Ը��
function tbNpc:InputInformation(nType, tbItem, nNpcId, szText)
	--�Ƿ���������ִ�
	if IsNamePass(szText) ~= 1 then
		Dialog:Say("������Ը���зǷ��������ַ���",{"֪����"});
		return 0;
	end

	if GetNameShowLen(szText) > 20 then
		Dialog:Say("����Ը���ַ����������Ǽ���á�",{"֪����"});
		return 0;
	end
	local szMsg = string.format("ȷ��������Ը����<color=yellow>%s<color>���͵�",szText);
	if nType == 1 then		
		self:SentInformation(nType, szText, nNpcId, tbItem);
		return;
	elseif nType == 2 then
		szMsg = szMsg.."(<color=yellow>����<color>)��";
	elseif nType == 3 then
		szMsg = szMsg.."(<color=yellow>������<color>)��";
	else
		szMsg = szMsg.."(<color=yellow>���Ѽ�����<color>)��";
	end
	Dialog:Say(szMsg,
		{
			{"ȷ��", self.SentInformation, self, nType, szText, nNpcId, tbItem},		
			{"ȡ��"}
		})
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
	local nMapId2, nPosX2, nPosY2 = unpack(SpringFrestival.tbVowTreePosition)
	local nDisSquare = (nPosX - nPosX2)^2 + (nPosY - nPosY2)^2;
	if nMapId2 ~= nMapId or nDisSquare > 400 then
		Dialog:Say("��������Ը������������Ը��");
		return 0;
	end
	return 1;
end

--����Ƶ��
function tbNpc:SentInformation(nType, szText, nNpcId, tbItem)
	if  self:CheckPosition(nNpcId) == 0 then
		return 0;
	end
	--Ƶ������
	local szMsg = string.format("%s����������Ը����������Ը����",me.szName).."<color=purple>"..szText.."<color>";	
	me.Msg("������������Ը����������Ը����<color=yellow>"..szText.."<color>");
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
	self:GetAward(tbItem)
end

function tbNpc:GetAward(tbItem)
	tbItem[1].pItem.Delete(me);	--ɾ��ϣ��֮��
	local nCount = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_SPRINGFRESTIVAL_VOWNUM);
	GCExcute({"SpecialEvent.SpringFrestival:AddGTask"});
	
	--��ҵ�����Ը����
	local nDate = me.GetTask(SpringFrestival.TASKID_GROUP_EX, SpringFrestival.TASKID_VOWTREE_TIME);
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	if nDate < nNowDate then
		me.SetTask(SpringFrestival.TASKID_GROUP_EX, SpringFrestival.TASKID_VOWTREE_TIME, nNowDate);
		me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_COUNT, 0);
	end
	local	nTimes = me.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_COUNT);
	if nTimes < SpringFrestival.nGetFudaiMaxNum then		--ǰ��θ����������һ���м��ʵĽ���
		me.AddItem(18,1,80,1); 				--����
		self:AddLuckyStone();
		local nRant = MathRandom(100);
		for i = 1 ,#SpringFrestival.tbXiWangAward do
			if nRant > SpringFrestival.tbXiWangAward[i][2] and nRant <= SpringFrestival.tbXiWangAward[i][3]  then
				local pItemEx = me.AddItem(unpack(SpringFrestival.tbXiWangAward[i][1]));
				EventManager:WriteLog(string.format("[��������Ը����Ը]��������Ʒ:%s",pItemEx.szName), me);
				me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[��������Ը����Ը]��������Ʒ:%s",pItemEx.szName));
			end
		end
	end
	me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_COUNT, nTimes + 1);
	
	--����1001��Ը��������1001��Ը������ҽ�����֪ͨȫ��ȥ�콱
	if (nCount + 1) == SpringFrestival.nTrapNumber then
		Dialog:GlobalNewsMsg_GS(string.format("%s��������Ը���ĵ�%s��Ը�������õ�Ը��һ����ʵ�֣�", me.szName, SpringFrestival.nTrapNumber));
		me.AddTitle(unpack(SpringFrestival.tbVowTree_Title));
		me.SetCurTitle(unpack(SpringFrestival.tbVowTree_Title));
	end
end

--��ý���
function tbNpc:GetEncouragement(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return;
	end	
	
	if me.nLevel < SpringFrestival.nLevel  then
		Dialog:Say(string.format("���ĵȼ�����%s���������콱��", SpringFrestival.nLevel),{"֪����"});
		return;
	end
	
	--��ҵ����Ƿ��������
	local nDate = me.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_TIME) or 0;
	local nFlag = 0;
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	if nDate ~= nNowDate then
		me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_TIME, nNowDate);
		me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_ISGETAWARD, 0);
	else
		nFlag = me.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_ISGETAWARD) or 0;
	end
	if nFlag == 1 then
		Dialog:Say("�������Ѿ���ȡ�������ˣ��������콱�ˣ�",{"֪����"});
		return;
	end
	
	--Ը�������Ƿ�����
	local nCount = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_SPRINGFRESTIVAL_VOWNUM);
	if nCount < SpringFrestival.nTrapNumber then
		Dialog:Say(string.format("��Ը����û���յ�%s��Ը�����޽�������ȡ��", SpringFrestival.nTrapNumber),{"֪����"});
		return;
	end
	
	--�����ж�
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("�콱��Ҫ1�񱳰��ռ䣬������������",{"֪����"});
		return;
	end
	
	--������
	local pItem = me.AddItem(unpack(SpringFrestival.tbVowXiang));
	me.SetItemTimeout(pItem, 60*24*30, 0);	
	me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_ISGETAWARD, 1);
	EventManager:WriteLog("[��������Ը��1001��Ը��]����Ը���ϻ��Ը������", me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[��������Ը��1001��Ը��]����Ը���ϻ��Ը������");
end

function tbNpc:AddLuckyStone()
	local nStoneCount = me.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_STONE_COUNT_MAX);
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	local nCurSec  = Lib:GetDate2Time(nCurDate);
	local nCurWeek = Lib:GetLocalWeek(nCurSec);
	local nWeek = me.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_STONE_WEEK);
	if nWeek ~= nCurWeek then
		me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_STONE_WEEK,nCurWeek);
		me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_STONE_COUNT_MAX,0);
		nStoneCount = 0;
	end
		
	if nStoneCount < SpringFrestival.STONE_COUNT_MAX then
		me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_STONE_COUNT_MAX,nStoneCount+1);
		local pLucky = 	me.AddItem(unpack(SpringFrestival.tbLuckyStone));  --��ʯ
		if pLucky then
			pLucky.Bind(1);
		end
	end
end