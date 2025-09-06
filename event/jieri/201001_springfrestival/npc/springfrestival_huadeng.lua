-- �ļ�������huadeng.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2009-12-28 18:00:18
-- ��  ��  �����껨��

local tbNpc= Npc:GetClass("xinnian_huadeng");
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};

function tbNpc:OnDialog()
	--local nData = tonumber(GetLocalDate("%Y%m%d"));
	--if nData < SpringFrestival.HuaDengOpenTime or nData > SpringFrestival.HuaDengCloseTime then	--��ڼ���
	--	Dialog:Say("ʱ���������죡", {"֪����"});
	--	return;
	--end	
	local nDateEx = me.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_TIME) or 0;
	local nTimes = 0;
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	if nDateEx ~= nNowDate then
		me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_TIME, nNowDate);
		me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_GUESSYCOUPLET_NCOUNT_DAILY, 0);
	else
		nTimes = me.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_GUESSYCOUPLET_NCOUNT_DAILY) or 0;
	end
	local nTimesEx = me.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_GUESSCOUPLET_NCOUNT) or 0;
	local szMsg = string.format("������¶ԵĴ�������<color=yellow>%s<color>\n���ܹ��¶ԵĴ�������<color=yellow>%s<color>\n", nTimes,nTimesEx);
	
	local tbNpcTemp = him.GetTempTable("Npc");
	tbNpcTemp.tbPlayerList = tbNpcTemp.tbPlayerList or {};
	local nPart = tbNpcTemp.nPart;
	local nCount = tbNpcTemp.nCount;
	if nPart == 2 then
		szMsg = szMsg..string.format("Hoanh phi��\n<color=yellow>������%s��\n������%s<color>\n���ܶԳ�������ƴ�����ǰ5λ�Գ���������£�", 
										SpringFrestival.tbCoupletList[nCount][nPart + 1], SpringFrestival.tbCoupletList[nCount][1]);
	else
		szMsg = szMsg..string.format("Thuong lien��\n<color=yellow>������%s��\n������%s<color>\n���ܶԳ�������ƴ�����ǰ5λ�Գ���������£�",
										SpringFrestival.tbCoupletList[nCount][nPart + 1], SpringFrestival.tbCoupletList[nCount][1]);		
	end
	--���Ӽ�¼��ǰ�����˵�����
	for i = 1, #tbNpcTemp.tbPlayerList do
		szMsg = szMsg.."\n<color=yellow>  "..tbNpcTemp.tbPlayerList[i].."<color>";		
	end
	Dialog:Say(szMsg,
		{
			{"���ϴ���", self.PasteCouplet, self, nCount, nPart, him.dwId},
			{"��㿴��"}
		});
end

--������
function tbNpc:PasteCouplet(nCount, nPart, nNpcId)	
	local szContent = "�������Ҫ���������ϵĴ���1��";
	Dialog:OpenGift(szContent, nil, {self.OnOpenGiftOk, self, nCount, nPart, nNpcId});
end

function tbNpc:OnOpenGiftOk(nCount, nPart, nNpcId, tbItemObj)
	--�����ж�
	if me.CountFreeBagCell() < 2 then
		Dialog:Say("��Ҫ2�񱳰��ռ䣬������������",{"֪����"});
		return;
	end
	local nTimesEx = me.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_GUESSCOUPLET_NCOUNT) or 0;
	if nTimesEx >= SpringFrestival.nGuessCounple_nCount then
		Dialog:Say("����ڼ��Ѿ�������100�������ˣ����ỹ�����������˰ɣ�", {"֪����"});
		return 0;
	end	
	--��ҵ���Դ�������
	local nDateEx = me.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_TIME) or 0;
	local nTimes = 0;
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	if nDateEx ~= nNowDate then
		me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_TIME, nNowDate);
		me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_GUESSYCOUPLET_NCOUNT_DAILY, 0);
	else
		nTimes = me.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_GUESSYCOUPLET_NCOUNT_DAILY) or 0;
	end
	if nTimes >= SpringFrestival.nGuessCounple_nCount_daily then
		Dialog:Say("������Ĳ¶����Ĵ����Ѿ������ˣ��������������ɣ�", {"֪����"});	
		return 0;		
	end
	--��Ʒ�����ж�
	if #tbItemObj ~= 1 then
		Dialog:Say("ÿ��ֻ�ܷ���1�����ƴ���[�Ѽ���]", {"֪����"});	
		return 0;
	end
	local pItem = tbItemObj[1][1];
	--��Ʒgdpl�ж�
	local szKey = string.format("%s,%s,%s,%s",pItem.nGenre,pItem.nDetail,pItem.nParticular,pItem.nLevel);
	local szCoupletKey = string.format("%s,%s,%s,%s", unpack(SpringFrestival.tbCouplet_identify));   
	if szKey ~= szCoupletKey then
		Dialog:Say("���ŵ���Ʒ���ԣ������1�����ƴ���[�Ѽ���]",{"֪����"});
		return 0;			
	end
	--�����Ƿ��Ӧ
	local nCountEx = pItem.GetGenInfo(1);
	local nPartEz = pItem.GetGenInfo(2);
	if nCountEx < 1 or nPartEz < 1 or nCountEx ~= nCount or nPartEz == nPart then
		Dialog:Say("��������������뻨���ϵĲ���Ӧ����������ɣ�", {"֪����"});
		return 0;			
	end
	
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return 0;
	end	
	
	pItem.Delete(me);	--ɾ������
	me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_GUESSCOUPLET_NCOUNT, nTimesEx + 1);
	me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_GUESSYCOUPLET_NCOUNT_DAILY, nTimes + 1);
	--һ�����ʻ�����ֽ����е�һ��
	local nRant = MathRandom(100);
	for i = 1 ,#SpringFrestival.tbCouplet do
		if nRant > SpringFrestival.tbCouplet[i][2] and nRant <= SpringFrestival.tbCouplet[i][3]  then
			local pItemEx = me.AddItem(unpack(SpringFrestival.tbCouplet[i][1]));
			--me.SetItemTimeout(pItemEx, 60*24*30, 0);
			EventManager:WriteLog(string.format("[�������ɶԴ���]��������Ʒ%s", pItemEx.szName), me);
			me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("[�������ɶԴ���]��������Ʒ%s", pItemEx.szName));	
		end
	end	

	local tbNpcTemp = pNpc.GetTempTable("Npc");
	tbNpcTemp.tbPlayerList = tbNpcTemp.tbPlayerList or {};
	--���ϵ�ǰ����˼�¼���֣�������ƷΪ�����Ʊ��䡤�����Ժ���Ľ����ǣ����Ʊ���
	if #tbNpcTemp.tbPlayerList < SpringFrestival.nGetHuaDengMaxNum then
		table.insert(tbNpcTemp.tbPlayerList, me.szName);		
		me.AddKinReputeEntry(1);	--1�㽭������
		me.AddExp(me.GetBaseAwardExp() * 15);	--15���ӻ�׼����
		--1Сʱ7��ĥ�������ף�����buff
		me.AddSkillState(385, 7, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
		me.AddSkillState(386, 7, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
		me.AddSkillState(387, 7, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
		--����ֵ880, 4��30��,����־���879, 6����70����
		me.AddSkillState(880, 4, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
		me.AddSkillState(879, 6, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);	
		--local pItemEx = me.AddItem(unpack(SpringFrestival.tbHuaDengBox_FU));
		--me.SetItemTimeout(pItemEx, 60*24*30, 0);
		--EventManager:WriteLog("[�������ɶԴ���]��û��Ʊ��䡤��", me);
		--me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[�������ɶԴ���]��û��Ʊ��䡤��");
		if #tbNpcTemp.tbPlayerList == SpringFrestival.nGetHuaDengMaxNum then
			SpringFrestival.AddNewHuaDeng(nNpcId);
		end
	end	
	if TimeFrame:GetState("OpenLevel150") == 1 and SpecialEvent.SpringFrestival.bPartOpen == 1 then
		me.AddItem(unpack(SpringFrestival.tbHuaDengBox)); 
	else
		me.AddItem(unpack(SpringFrestival.tbHuaDengBox_N));
	end
	--me.SetItemTimeout(pItemEx, 60*24*30, 0);
	EventManager:WriteLog("[�������ɶԴ���]��û��Ʊ���", me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[�������ɶԴ���]��û��Ʊ���");	
end
