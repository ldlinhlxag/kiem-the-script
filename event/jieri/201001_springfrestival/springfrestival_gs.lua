-- �ļ�������springfrestival_gs.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2009-12-29 10:39:32
-- ��  ��  ������gs

if  not MODULE_GAMESERVER then
	return;
end
Require("\\script\\event\\jieri\\201001_springfrestival\\springfrestival_def.lua");
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};

--������������Ը��
function SpringFrestival:AddVowTree()
	if SubWorldID2Idx(SpringFrestival.tbVowTreePosition[1]) >= 0 then	
		 if SpringFrestival.nVowTreenId == 0 then			--û�м��ع���Ը����add��Ը��
	 		local pNpc = KNpc.Add2(SpringFrestival.nVowTreeTemplId, 100, -1, SpringFrestival.tbVowTreePosition[1], SpringFrestival.tbVowTreePosition[2], SpringFrestival.tbVowTreePosition[3]);
	 		SpringFrestival.nVowTreenId = pNpc.dwId;
		end
		Dialog:GlobalNewsMsg_GS("��Ը���Ѿ������֣���Ҵ���<color=yellow>ϣ��֮��<color>��ȥ��Ը��");
	end
end

--ɾ����Ը��
function SpringFrestival.DeleteVowTree()
	if SubWorldID2Idx(SpringFrestival.tbVowTreePosition[1]) >= 0 then
		if SpringFrestival.nVowTreenId and SpringFrestival.nVowTreenId ~= 0 then	--���ع���Ը��
			local pNpc = KNpc.GetById(SpringFrestival.nVowTreenId);
			if pNpc then
				pNpc.Delete();
				SpringFrestival.nVowTreenId = 0;
			end			
		end
	end
end

--��������50յ����
function SpringFrestival:AddNewYearHuaDeng()
	SpringFrestival:DeleteNewYearHuaDeng();
	for nIndex, tbHuaDeng in ipairs(SpringFrestival.HUADENG) do		
		if SubWorldID2Idx(tbHuaDeng.nMapId) >= 0 then
			for i = 1, 50 do	
				local pNpc = KNpc.Add2(SpringFrestival.nHuaDengTemplId, 100, -1, tbHuaDeng.nMapId, SpringFrestival.HUADENG_POS[nIndex][i][1], SpringFrestival.HUADENG_POS[nIndex][i][2]);	
				SpringFrestival.tbHuaDeng[pNpc.dwId] = 1;
				local tbNpcTemp = pNpc.GetTempTable("Npc");
				tbNpcTemp.tbPlayerList = {};
				tbNpcTemp.nPart = MathRandom(2);		--�����������1������2������
				tbNpcTemp.nCount = MathRandom(#SpringFrestival.tbCoupletList);	--36�����������һ��
				pNpc.SetTitle(string.format("<color=yellow>%s<color>",SpringFrestival.tbCoupletList[tbNpcTemp.nCount][1]));
				Dialog:GlobalNewsMsg_GS("�ɶԴ�����Ѿ���ʼ����ҿ�ȥ�������жԴ����ɣ����������벻���Ķ���Ŷ��");
			end
		end
	end
end

--ɾ������
function SpringFrestival:DeleteNewYearHuaDeng()
	for nNpcId, _ in pairs(SpringFrestival.tbHuaDeng) do
		local pNpc = KNpc.GetById(nNpcId);
		if pNpc then
			pNpc.Delete();
		end
	end
	SpringFrestival.tbHuaDeng = {};
end

--���Ʊ�����
function SpringFrestival.AddNewHuaDeng(nNpcId)
	local tbPlayerList = {};	
	local nCount = 0;
	local nPart = 0;
	local nMapId , nX, nY =0, 0, 0;
	local pNpc = KNpc.GetById(nNpcId);
	if pNpc then		
		nMapId , nX, nY = pNpc.GetWorldPos();
		local tbNpcTemp = pNpc.GetTempTable("Npc");
		tbNpcTemp.tbPlayerList = tbNpcTemp.tbPlayerList or {};
		nPart = tbNpcTemp.nPart;		--����������������
		nCount = tbNpcTemp.nCount;		--���ƶ�Ӧ�Ĵ���
		--�Գ����Ƶ���
		for i=1, SpringFrestival.nGetHuaDengMaxNum do
			tbPlayerList[i] = tbNpcTemp.tbPlayerList[i];
		end		
		SpringFrestival.tbHuaDeng[pNpc.dwId] = nil;
		pNpc.Delete();
	end
	--���ɵ�����npc
	local pNpc2 = KNpc.Add2(SpringFrestival.nHuaDengTemplId_D, 100, -1, nMapId, nX, nY);
	SpringFrestival.tbHuaDeng[pNpc2.dwId] = 1;
	local tbNpcTemp2 = pNpc2.GetTempTable("Npc");
	tbNpcTemp2.nPart = nPart;
	tbNpcTemp2.nCount = nCount;
	tbNpcTemp2.tbPlayerList = tbPlayerList;
	pNpc2.SetTitle(string.format("<color=yellow>%s<color>",SpringFrestival.tbCoupletList[nCount][1]));
end

--����̫ү����ȡ����
function SpringFrestival.GetAward()
	local szContent = "�����1�����ռ���ȫ���껭�ռ���\n��ڼ����һ�<color=yellow>10<color>��";
	local szContent = szContent..string.format("\n���Ѿ��һ��Ĵ�����<color=yellow>%s<color>", me.GetTask(SpringFrestival.TASKID_GROUP,SpringFrestival.TASKID_GETAWARD) or 0);
	Dialog:OpenGift(szContent, nil, {SpringFrestival.OnOpenGiftOk, SpringFrestival});
end

function SpringFrestival:OnOpenGiftOk(tbItemObj)
	--ÿ��һ������ (ֻ����һ��)
	if #tbItemObj ~= 1 then
		Dialog:Say("ÿ��ֻ�ܷ���1���ռ��ᡣ������ȡʧ�ܣ�", {"֪����"});
		return 0;	
	end
	--��Ʒ�ж�
	local pItem = tbItemObj[1][1];
	local szKey = string.format("%s,%s,%s,%s",pItem.nGenre,pItem.nDetail,pItem.nParticular,pItem.nLevel);
	local szCoupletKey = string.format("%s,%s,%s,%s", unpack(SpringFrestival.tbNianHua_book));
	if szKey ~= szCoupletKey then
		Dialog:Say("���ŵ���Ʒ���ԣ������1���껭�ռ���", {"֪����"});
		return 0;			
	end
	
	--�Ƿ��ռ��붫��
	local nFlag = 0;
	for i =1 , 12 do
		local nFlagEx = me.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_NIANHUA_BOOK + i -1) or 0;
		if nFlagEx ~= 1 then
			nFlag = 1;
		end
	end
	if nFlag == 1 then
		Dialog:Say("�����ռ��Ტû�ռ���ȫ����Ȼ��ƭ���ࡣ", {"֪����"});
		return 0;
	end
	
	--��ȡ����
	local nCount = me.GetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_GETAWARD) or 0;
	if nCount >= SpringFrestival.nGetAward_longwu then
		Dialog:Say(string.format("���Ѿ���ȡ��%s�ν����������ٻ��ˣ�", SpringFrestival.nGetAward_longwu), {"֪����"});
		return 0;		
	end
	
	--�����ж�
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("��Ҫ1�񱳰��ռ䣬ȥ�����������ɣ�",{"֪����"});
		return 0;
	end
	
	--����ռ���
	for i =1 , 12 do
		me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_NIANHUA_BOOK + i -1,  0);
	end
	pItem.Delete(me);
	--������
	local pItemEx =  nil;
	if TimeFrame:GetState("OpenLevel150") == 1 and self.bPartOpen == 1 then
		me.AddItem(unpack(SpringFrestival.tbNianHua_award));
	else
		me.AddItem(unpack(SpringFrestival.tbNianHua_award_N));
	end
	--me.SetItemTimeout(pItemEx, 60*24*30, 0);
	EventManager:WriteLog("[�������껭�ռ���]���һ���껭�ռ���������", me);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[�������껭�ռ���]���һ���껭�ռ���������");
	--�����콱����
	me.SetTask(SpringFrestival.TASKID_GROUP, SpringFrestival.TASKID_GETAWARD, nCount + 1);	
end

--��ڼ��ڷ�����ά������崻����������¼���npc
function SpringFrestival:ServerStartFunc()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData >= self.VowTreeOpenTime and nData <= self.VowTreeCloseTime then	--��ڼ�������������
		SpringFrestival:AddVowTree();
	end	
	if nData >= self.HuaDengOpenTime and nData <= (self.HuaDengCloseTime + 1) then		--��ڼ�������������
		local nTime = tonumber(GetLocalDate("%H%M"))
		if (nData == self.HuaDengOpenTime	and  nTime < SpringFrestival.HuaDengOpenTime_C) or 
						(nData == (self.HuaDengCloseTime + 1) and  nTime > SpringFrestival.HuaDengOpenTime_C) then	--9��12��ǰ��15��12��󣬷��������������ػ���
			return;
		end
		SpringFrestival:AddNewYearHuaDeng();
	end
end

ServerEvent:RegisterServerStartFunc(SpringFrestival.ServerStartFunc, SpringFrestival);
