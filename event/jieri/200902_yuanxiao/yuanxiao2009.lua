--��������Ԫ����
--��־��
--2009.02.03
--DOC��\Sword1Ex-Scheme\��Ŀ����ǰ������ĵ�\h�\yԪ���\yԪ�����2009��
--�����������: group=2027	start=28	end=50


local tbYuanXiao09 = {};
SpecialEvent.YuanXiao2009 = tbYuanXiao09;

tbYuanXiao09.TIME_START = 200902060000;	--���뿪��ʱ��
tbYuanXiao09.TIME_END   = 200902200000;	--�������ʱ��

tbYuanXiao09.DEF_DIS = 50;	--һ����Χ֮��

tbYuanXiao09.TASKGID 	= 2027
tbYuanXiao09.TASK_LIJIAORIQI_ID 	= 28
tbYuanXiao09.TASK_LIJIANGLI_LIHE 	= 29;	--���
tbYuanXiao09.TASK_LIJIANGLI_HONGBAO	= 30;	--���
tbYuanXiao09.TASK_LIJIANGLI_FUDAI	= 31;	--����

tbYuanXiao09.TASK_ZHUFU_TIME		= 38;
tbYuanXiao09.TASK_FRIEND_COUNT 		= 39;   --ף������
tbYuanXiao09.TASK_FRIEND_START 		= 40;
tbYuanXiao09.TASK_FRIEND_END 		= 49;

tbYuanXiao09.MAX_ZHUFU_COUNT		= 10;
function tbYuanXiao09:CheckState()
	local nNowDate = tonumber(GetLocalDate("%Y%m%d%H%M"));
	if nNowDate >= self.TIME_START and nNowDate < self.TIME_END then
		return 1;
	end
	return 0;
end

--��Ԫ����һ����
	--��ȡԪ������
	--�͸�����ף��
	--�˽�Ԫ���
	--��㿴�����뿪��
function tbYuanXiao09:OnDialog(entry)
	if SpecialEvent.YuanXiao2009:CheckState() == 0 then
		return
	end
	
	if (not entry) then
		entry = 1;
	end
	
	local tbOpt = {};
	tbOpt[1] = {
		{"��ȡԪ������", self.OnDialog, self, 2},
		{"��ú��ѵ�ף�� ", self.GetHaoYouZuFu, self},
		{"�˽�Ԫ���", self.ReadMe, self},
		{"��㿴�����뿪��"}
		};
	local nIndex = 1;
	tbOpt[2] = {};
	if (me.GetTask(self.TASKGID, self.TASK_LIJIANGLI_LIHE) == 0) then
		tbOpt[2][nIndex] = {"��ȡ�´����", self.GetYuanXiaoHaoLi, self, 1};
		nIndex = nIndex + 1;
	end
	
	if (me.GetTask(self.TASKGID, self.TASK_LIJIANGLI_HONGBAO) == 0) then
		tbOpt[2][nIndex] = {"��ȡ������", self.GetYuanXiaoHaoLi, self, 2};
		nIndex = nIndex + 1;
	end
	if (me.GetTask(self.TASKGID, self.TASK_LIJIANGLI_FUDAI) == 0) then
		tbOpt[2][nIndex] = {"��ȡ�´��󸣴�", self.GetYuanXiaoHaoLi, self, 3};
		nIndex = nIndex + 1;
	end
	
	tbOpt[2][nIndex] = {"��㿴���������ϲ㣩", self.OnDialog, self, 1};
	local szMsg = nil;
	
	if (entry == 1) then --��һ��Ի�
		szMsg = "���Ԫ�����֣��������ǴǾ�ӭ��֮�ʣ���������Ϊ���׼���˷������Լ������ף����ϣ���������µ�һ�����һ��¥��";
	elseif (entry == 2) then --�ڶ���Ի�
		if (nIndex == 1) then --��ʾû�����������
			szMsg = "����Ԫ�������Ѿ������ˣ�ϣ�����������Ŭ���ܶ���";
		else		
			szMsg = "Ԫ���ѽڣ�ֻҪ���������Ҿ��������͸��㡣<color=yellow>����������㶼������ȡһ��<color>����������һ���أ�";
		end
	end
	Dialog:Say(szMsg, tbOpt[entry]);
end

--��ȡԪ������
--return 1 or 0, {}
function tbYuanXiao09:CheckHaoLi(nIndex)
	--[[
	�߼�������
		�˺ų�ֵ��15Ԫ���ɫ��������200���ϣ�
		��ɫ�ȼ���69��
		�����ռ��㹻��
	--]]
	if (me.nPrestige < 200) and (me.GetExtMonthPay() < 15) then	--��������������200���ߵ��³�ֵ������15Ԫ 
		return 0
		, "���������������������<color=red>��Ҫ���³�ֵ�ﵽ15Ԫ�����߽��������ﵽ200<color>�Ϳ������콱�ˡ�"
		,{ {"��֪���ˣ��뿪��"} }
	end
	
	if me.nLevel < 69 then
		return 0
		, "���ĵȼ�������<color=yellow>69��<color>�Ժ�����������ɡ�"
		,{ {"��֪���ˣ��뿪��"} }
	end

	--nIndex 1, 2, 3 ��� 6����� 0������ 10
	local tbRequireRoom = {6, 0, 10}
	local nRequire = tbRequireRoom[nIndex] or 10	
	if me.CountFreeBagCell() < nRequire then
		return 0
		, "��ȡ������Ҫ<color=red> "..tostring(nRequire).." <color>�񱳰��ռ䣬����һ�°��������ɡ�"
		,{ {"��֪���ˣ��뿪��"} }		
	end
	
	return 1
	,"�������͸���������ǹ�ȥһ��������Ŭ���Ľ�����ͬʱϣ�����������Ŭ���ܶ���"
	,{ {"лл�������뿪��"} }		
end

function tbYuanXiao09:SetItemTimeOut(pItem, nTime)
	if (not pItem or not nTime or nTime < 0) then
		return
	end
	pItem.SetTimeOut(0, nTime);
	local tbTimeOut = me.GetItemAbsTimeout(pItem);		--���þ��Թ���ʱ��
	if (tbTimeOut and pItem) then
		local szTime = string.format("%02d/%02d/%02d/%02d/%02d/10", 			
				tbTimeOut[1],
				tbTimeOut[2],
				tbTimeOut[3],
				tbTimeOut[4],
				tbTimeOut[5]);
		me.SetItemTimeout(pItem, szTime);
		pItem.Sync()
	end
end

function tbYuanXiao09:GiveLiHe()
	local pItem = me.AddItem(18, 1, 251, 1);
	if pItem then
		pItem.Bind(1);
		--DONE:�ؾ���ͼ��ʱ�������޷���ʾ
		self:SetItemTimeOut(pItem, GetTime() + 30 * 24 * 60 * 60);		--���þ��Թ���ʱ��
		me.Msg("�������һ�����������ֵ�ͼ�ĵ���!");
	end
	for i = 1, 5 do
		local pItem = me.AddItem(18,1,114,7);	--����7������
		if (pItem) then
			pItem.Bind(1)
			self:SetItemTimeOut(pItem, GetTime() + 30 * 24 * 60 * 60);	--���þ��Թ���ʱ��
		end
	end
	me.SetTask(tbYuanXiao09.TASKGID, tbYuanXiao09.TASK_LIJIANGLI_LIHE, tonumber(GetLocalDate("%Y%m%d")));
	--��¼log
	local szLog = "2009Ԫ���:���Ԫ�������´����--5��7��������һ���ؾ���ͼ��";
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szLog);
	me.Msg("����ȡ���´���еĽ���������ˣ�������������һ���ؾ���ͼ��");
end

function tbYuanXiao09:GiveHongBao()
	me.AddBindMoney(288000, Player.emKBINDMONEY_ADD_EVENT);
	me.AddBindCoin(2880, Player.emKBINDCOIN_ADD_EVENT);
	me.SetTask(tbYuanXiao09.TASKGID, tbYuanXiao09.TASK_LIJIANGLI_HONGBAO, tonumber(GetLocalDate("%Y%m%d")));
	me.Msg("����������������� 288000 �������� 2880 �󶨽�ң�");
	--��¼log
	local szLog = "2009Ԫ���:���Ԫ�������´����--288000��������2880�󶨽�ң�";
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szLog);
end

function tbYuanXiao09:GiveFuDai()
	for i = 1, 10 do
		local pItem = me.AddItem(18,1,80,1);	--����ƽ𸣴�
		if (pItem) then
			pItem.Bind(1)
		end
	end
	--�����׼����
	local exp = me.GetBaseAwardExp() * 588;
	me.AddExp(exp);
	me.SetTask(tbYuanXiao09.TASKGID, tbYuanXiao09.TASK_LIJIANGLI_FUDAI, tonumber(GetLocalDate("%Y%m%d")));
	me.Msg("�����´��󸣴�������� 10 ���ƽ𸣴��� "..exp.." ����ֵ��");
	--��¼log
	local szLog = "2009Ԫ���:���Ԫ�������´��󸣴�--10���ƽ𸣴���"..exp.."����ֵ��";
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szLog);
end

function tbYuanXiao09:GetYuanXiaoHaoLi(nIndex)
	local ok, msg, tbOpt = self:CheckHaoLi(nIndex)	
	
	Dialog:Say(msg, tbOpt);
	
	if (ok == 1) then --�������㣬������ȡ��������Ϊû�пͻ��˵��ȷ�Ϻ����ȡ�����Ĺ��̣�����Ҫ����ķ�ˢ�ж�
		--����Ϊ�����Ѿ���ȡ��
		--me.SetTask(tbYuanXiao09.TASKGID, tbYuanXiao09.TASK_LIJIAORIQI_ID, tonumber(GetLocalDate("%Y%m%d")))
		if (nIndex == 1) then self:GiveLiHe() end
		if (nIndex == 2) then self:GiveHongBao() end
		if (nIndex == 3) then self:GiveFuDai() end
		--
	end
end

------------------------------------------------------------------------------------------------------------------------------------
--��ҵ�ѡ���˽�Ԫ�������
function tbYuanXiao09:ReadMe(entry)
	if not entry then
		entry = 1
	end

	local tbReadMeOpt = {};
	local tbOpt = tbReadMeOpt;
	tbOpt[1] = 
	{
		msg = "�����˽��ĸ���أ�",
		tb =
		{ 
			{"�˽⡰���Ԫ���ͺ��񡱻", self.ReadMe, self, 101},
			{"�˽⡰�´���ף�����", self.ReadMe, self, 102},
			{"�˽⡰����ѩ������", self.ReadMe, self, 103},
			{"��֪���ˣ��뿪��"},
		}
	};
	tbOpt[101] = 
	{
		msg ="2��6�ո���ά����~~2��20��0�㣬����<color=red>���³�ֵ�ﵽ15Ԫ���߽��������ﵽ200���ҵȼ�69�����ϵĽ�ɫ<color>������ȥ��ٴ���ȡ����ڻ�ڼ䣬ÿ����ɫ������ȥ��ٴ���ȡ��������<color=yellow>�´���У����������´��󸣴�<color>��ÿ�ֿ���1�Ρ�������񲻿ɴ����",
		tb = 
		{
			{"��֪���ˣ������ϲ㣩", self.ReadMe, self, 1},
		}
	};
	tbOpt[102] = 
	{
		msg ="2��6�ո���ά����~~2��20��0�㣬����<color=red>���³�ֵ�ﵽ15Ԫ���߽��������ﵽ200���ҵȼ�69�����ϵĽ�ɫ<color>������ȥ��ٴ��ͺ�����ӣ�������ͳ���ף�������ܻ�ý������ڻ�ڼ䣬<color=yellow>ÿ����ɫ��10�λ�����ܶ�3�����ϵĺ����ͳ���ף���Ļ��ᣬͬһ����ֻ���ͳ�1��ף����ÿ��ֻ�ܻ��1��ף����<color>�����Ҫ���ͳ�ף�����������ȥ����ٶԻ��Դ���ף����",
		tb = 
		{
			{"��֪���ˣ������ϲ㣩", self.ReadMe, self, 1},
		}
	};
	tbOpt[103] = 
	{
		msg ="2��6�ո���ά����~~2��20��0�㣬����������<color=red>�ڻʱ���ڷ������������а�ǰ20���������������ѩ��������ͳ�������콱�����һ�Ρ�<color>��ʱ����ѩ�뿪�Ͳ����õ������ˡ�",
		tb = 
		{
			{"��֪���ˣ������ϲ㣩", self.ReadMe, self, 1},
		}
	};

	Dialog:Say(tbReadMeOpt[entry].msg, tbReadMeOpt[entry].tb);
end

function tbYuanXiao09:CheckHaoYouZhuFu()
	--[[
		�˺ų�ֵ��15Ԫ���ɫ��������200���ϣ�
		��ɫ�ȼ���69��
		�����������Ϊ2�ˣ�
		�����ڶ��鷶Χ�ڣ�
		��������ܶȴ�3����
		δ������ͳ���ף����
		����δף����
		ף���ܴ���δ��10�Σ�
		�����ռ��㹻��
	--]]
	if (me.nPrestige < 200) and (me.GetExtMonthPay() < 15) then	--��������������200���ߵ��³�ֵ������15Ԫ
		return 0
		, "���������ͳ�ף����������<color=red>��Ҫ���³�ֵ�ﵽ15Ԫ�����߽��������ﵽ200<color>�Ϳ������ͳ�ף���ˡ�"
		,{ {"��֪���ˣ��뿪��"} }
	end
	
	if me.nLevel < 69 then
		return 0
		, "���ĵȼ�������<color=red>69��<color>�Ժ�����ף���ɡ�"
		,{ {"��֪���ˣ��뿪��"} }
	end
	
	local tbTeamMemberList = KTeam.GetTeamMemberList(me.nTeamId);                        
	local tbPlayerId = me.GetTeamMemberList();                                           
	if ((not tbPlayerId) or (not tbTeamMemberList) or #tbTeamMemberList ~= 2 or Lib:CountTB(tbPlayerId) ~= 2) then
		return 0
		,"��λ��Ҫף����ĺ����أ�ֻ����<color=red>Ҫ�ͳ�ף����������Ӳ������ڸ���<color>�����ܻ���������ף����"
		,{{"��֪���ˣ��뿪��"}} 
	end
	
	--�ж϶����Ƿ��ڸ���
	local nFlag = 0;
	local pFriend = nil;
	local nMapId, nX, nY	= me.GetWorldPos();
	for _, pPlayer in pairs(tbPlayerId) do
		if pPlayer.nId ~= me.nId then
			local nPlayerMapId, nPlayerX, nPlayerY	= pPlayer.GetWorldPos();
			if (nPlayerMapId == nMapId) then
				local nDisSquare = (nX - nPlayerX)^2 + (nY - nPlayerY)^2;
				if (nDisSquare < ((self.DEF_DIS/2) * (self.DEF_DIS/2))) then
					pFriend = pPlayer;
					nFlag = 1;
				end
			end
		end
	end
	
	if (nFlag ~= 1) then
		return 0
		,"��λ��Ҫף����ĺ����أ�ֻ����<color=red>Ҫ�ͳ�ף����������Ӳ������ڸ���<color>�����ܻ���������ף����"
		,{{"��֪���ˣ��뿪��"}} 
	end
	
	--���ѣ����ܶ�
	if (1 ~= me.IsFriendRelation(pFriend.szName) or me.GetFriendFavorLevel(pFriend.szName) < 3) then --DONE:���ܶ��޸�Ϊ��
		return 0
		,"�������<color=red>���Ǻ��ѻ����ܶ�δ��3��<color> "
		,{{"��֪���ˣ��뿪��"}}
	end
	
	--�����Ƿ��Ѿ��ͳ���ף��
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	if (me.GetTask(self.TASKGID, self.TASK_ZHUFU_TIME) >= nDate) then
		return 0
		,"������<color=red>�Ѿ���ù�ף����<color>�����������ɡ�"
		,{{"��֪���ˣ��뿪��"}}
	end
	
	--ף���Ĵ����Ƿ񳬳�self.MAX_ZHUFU_COUNT(10)��
	local nCount = me.GetTask(self.TASKGID, self.TASK_FRIEND_COUNT);
	if (nCount >= self.MAX_ZHUFU_COUNT) then
		return 0
		,"���Ѿ�<color=red>�ܹ������10��ף��<color>��û�л����ٻ��ף���ˡ�"
		,{{"��֪���ˣ��뿪��"}}
	end
	
	--�Ƿ�Ըú����ͳ�����ף��
	local nFriendHashId = KLib.Number2UInt(tonumber(KLib.String2Id(pFriend.szName)));
	nFlag = 0;
	for nId = self.TASK_FRIEND_START, self.TASK_FRIEND_END do 
		local nHashId = KLib.Number2UInt(me.GetTask(self.TASKGID, nId));
		if (nHashId == nFriendHashId) then
			nFlag = 1;
			break;
		end
	end
	if (nFlag == 1) then
		return 0
		,"���Ѿ�<color=red>��ù���λ���ѵ�ף����<color>���ظ�ף����û������ġ�"
		,{{"��֪���ˣ��뿪��"}}
	end
	
	if me.CountFreeBagCell() < 1 then
		return 0
		, "���ף����Ҫ�����ռ�<color=red>1��<color>�����ռ䣬����һ�°��������ɡ�"
		,{ {"��֪���ˣ��뿪��"} }		
	end
	
	--���е��������㣬�ͳ�ף��
	return 1
	,"������ĺ���<color=red>"..pFriend.szName.."<color>�ͳ����´�ף�������µ�һ�������ף���᳣�������ҡ��������õ�ף������"
	,{{"лл�����뿪��"}}
	,pFriend
end

function tbYuanXiao09:GetHaoYouZuFu()
	local ok, msg, tbOpt, pFriend = self:CheckHaoYouZhuFu();
	if (ok == 1 and pFriend == nil) then
		return
	end
	
	Dialog:Say(msg, tbOpt);
	if (ok == 1) then
		local pItem = me.AddItem(18,1,114,7);	--����7������
		if (pItem) then
			pItem.Bind(1);
			self:SetItemTimeOut(pItem, GetTime() + 30 * 24 * 60 * 60);	--���þ��Թ���ʱ��
			
			--���Ӽ���״̬
			me.AddSkillState(385, 7, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
			me.AddSkillState(386, 7, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
			me.AddSkillState(387, 7, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
			--����ֵ880, 4,����־���879, 5
			me.AddSkillState(880, 4, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
			me.AddSkillState(879, 8, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);

			me.SetTask(tbYuanXiao09.TASKGID, tbYuanXiao09.TASK_ZHUFU_TIME, tonumber(GetLocalDate("%Y%m%d"))) --�����Ѿ�ף����
			local zhufucishu = me.GetTask(tbYuanXiao09.TASKGID, tbYuanXiao09.TASK_FRIEND_COUNT);
			me.SetTask(tbYuanXiao09.TASKGID, tbYuanXiao09.TASK_FRIEND_COUNT, zhufucishu + 1);  --ף��������1

			--�����ѱ��Ϊ��ף����			
			local nFriendHashId = tonumber(KLib.String2Id(pFriend.szName));
			for nId = self.TASK_FRIEND_START, self.TASK_FRIEND_END do 
				local nHashId = KLib.Number2UInt(me.GetTask(self.TASKGID, nId));
				if (nHashId <= 0) then
					me.SetTask(self.TASKGID, nId, nFriendHashId); --4λ���޷�������
					break;
				end
			end
			--�ں��ѣ����弰���Ƶ��������ʾ��Ϣ
			local szMsg = string.format("<color=red>%s<color> �õ���������� <color=red>%s<color> ���´�ף�������µ�һ����һ��������˳������ġ�", me.szName, pFriend.szName);
			me.SendMsgToFriend(szMsg);
			--DONE:�����������߰�ᷢ����Ϣ
			szMsg = string.format("�õ���������� <color=red>%s<color> ���´�ף�������µ�һ����һ��������˳������ġ�", pFriend.szName);
			Player:SendMsgToKinOrTong(me, szMsg, 1);
			--��¼log
			local szLog = "2009Ԫ���:��ú���"..pFriend.szName.."���´�ף����1��7��������7��ĥ��ʯ7������Ƭ7������ʯ��(1��Сʱ)��30���ӵ�30�����˺�1��Сʱ��110%�Ĵ�־��飡";
			me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szLog);
		end
		--
	end
end


