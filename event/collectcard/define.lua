
if not SpecialEvent.CollectCard then
	SpecialEvent.CollectCard = {};
end
local CollectCard = SpecialEvent.CollectCard;
CollectCard.TIME_STATE	=
{
	20090921000000,	--��Ƭ�ռ�����
	20091011000000,	--��Ƭ�ռ�����������һ�������ʼ,
	20091018000000,	--����һ����������������ѡ��ʼ,
--	20080831220000,	--�����ѡ����,��ȡ��潱����ʼ
--	20080914240000,	--��ȡ��潱������
}

CollectCard.CARD_BAG = {18,1,461,1}; --����
CollectCard.ITEM_CARD_ORG = {18,1,402,1}; --ʢ�Ļ����δ������
CollectCard.TASK_GROUP_ID = 2069;

CollectCard.TASK_COUNT_ID	= 1;	--�������Բ����δ������ÿ��ʹ������
CollectCard.TASK_DATE_ID	= 2;	--�������Բ����δ��������
CollectCard.TASK_COLLECT_COUNT	= 3;	--�������Բ����δ�������ѿ�����
CollectCard.TASK_COLLECT_FINISH	= 4;	--�ռ���56�ű�־
CollectCard.TASK_CARD_BAG_AWARD_FINISH = 70;				--���ỻȡ��������־��ȫ���


CollectCard.AWARD_WEIWANG 	   = {{30,1}};	--������Ӧ�������{�ﵽ�������������}
CollectCard.CARD_DATA_LIMIT_MAX = 8;--�������Բ����δ������ÿ�����ʹ������
CollectCard.CARD_LIMIT_MAX = 100;	--�������Բ����δ���������ʹ������
--CollectCard.ITEM_GOLDTOKEN = {18,1,179,2};	--�ƽ�����
--CollectCard.ITEM_WHITETOKEN = {18,1,179,1};	--��������
--CollectCard.ITEM_GOLDHUOJU = {18,1,182,4};	--�ƽ���

CollectCard.AWARD_CARD_BASEEXP = 60;		--��ͨ����
CollectCard.AWARD_CARD_BINDMONEY = 5000;	--��ͨ����
CollectCard.AWARD_CARD_COIN = 50;			--��ͨ����

CollectCard.AWARD_LUCKCARD_BASEEXP = 60;		--���˽���
CollectCard.AWARD_LUCKCARD_BINDMONEY = 50000;	--���˽���
CollectCard.AWARD_LUCKCARD_COIN = 500;			--���˽���

CollectCard.FILE_BAOXIANG = "\\setting\\event\\collectcard\\baoxiang.txt"

CollectCard.TASK_CARD_ID =
{
	--��ƷId = {����������};
	[403] = {6 ,"�ɹ���    "},
	[404] = {7 ,"����      "},
	[405] = {8 ,"����      "},
	[406] = {9 ,"ά�����  "},
	[407] = {10,"����      "},
	[408] = {11,"����      "},
	[409] = {12,"׳��      "},
	[410] = {13,"������    "},
	[411] = {14,"������    "},
	[412] = {15,"����      "},
	[413] = {16,"����      "},
	[414] = {17,"����      "},
	[415] = {18,"����      "},
	[416] = {19,"������    "},
	[417] = {20,"������    "},
	[418] = {21,"��������  "},
	[419] = {22,"����      "},
	[420] = {23,"����      "},
	[421] = {24,"������    "},
	[422] = {25,"����      "},
	[423] = {26,"���      "},
	[424] = {27,"��ɽ��    "},
	[425] = {28,"������    "},
	[426] = {29,"ˮ��      "},
	[427] = {30,"������    "},
	[428] = {31,"������    "},
	[429] = {32,"������    "},
	[430] = {33,"�¶�������"},
	[431] = {34,"����      "},
	[432] = {35,"���Ӷ���  "},
	[433] = {36,"������    "},
	[434] = {37,"Ǽ��      "},
	[435] = {38,"������    "},
	[436] = {39,"������    "},
	[437] = {40,"ë����    "},
	[438] = {41,"������    "},
	[439] = {42,"������    "},
	[440] = {43,"������    "},
	[441] = {44,"������    "},
	[442] = {45,"��������  "},
	[443] = {46,"ŭ��      "},
	[444] = {47,"���α����"},
	[445] = {48,"����˹��  "},
	[446] = {49,"���¿���  "},
	[447] = {50,"�°���    "},
	[448] = {51,"������    "},
	[449] = {52,"ԣ����    "},
	[450] = {53,"����      "},
	[451] = {54,"��������  "},
	[452] = {55,"������    "},
	[453] = {56,"���״���  "},
	[454] = {57,"������    "},
	[455] = {58,"�Ű���    "},
	[456] = {59,"�����    "},
	[457] = {60,"��ŵ��    "},
	[458] = {61,"����      "},
}
--  [459] = "ǧ�ﹲ濾�"

CollectCard.CARD_START_ID = 403;	--��������ʼID
CollectCard.CARD_END_ID	  = 458;	--����������ID

function CollectCard:__debug_clear_my_card_record()
	for _, tbData in pairs(self.TASK_CARD_ID) do
		local nTaskId = tbData[1];
		me.SetTask(self.TASK_GROUP_ID, nTaskId, 0);
	end
	
	me.SetTask(self.TASK_GROUP_ID, self.TASK_COUNT_ID, 0 );
	me.SetTask(self.TASK_GROUP_ID, CollectCard.TASK_DATE_ID, 0);
	me.SetTask(self.TASK_GROUP_ID, CollectCard.TASK_COLLECT_COUNT, 0);
	me.SetTask(self.TASK_GROUP_ID, CollectCard.TASK_COLLECT_FINISH, 0);
	me.Msg("������")
end

function CollectCard:__debug_pritnt_luckycard()
	local nLuckyCardId = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_COLLECTCARD_RANDOM);
	if nLuckyCardId == 0 then
		me.Msg("�����˿�");
	else
		if self.TASK_CARD_ID[nLuckyCardId] then
			me.Msg(self.TASK_CARD_ID[nLuckyCardId][2]);
		else
			me.Msg("��bug: ", nLuckyCardId);
		end
	end
end


--  [�����ȼ�] --> {[CARD_BAG_AWARD������] --> ��Ӧ�Ľ�Ʒ����Ŀ�Ƭ����, ...}
-- 
CollectCard.CARD_BAG_AWARD_STEP = 
{
	--  [1] [2] [3] [4] [5] [6] [7]
	[1]={28, 26, 23, 20, 16, 12, 4},	--�ռ���������40�Ž�����
	[2]={28, 26, 23, 0, 0, 0, 0},		--�ռ�����40-49�Ž�����
	[3]={28, 26, 0, 0, 0, 0, 0},		--�ռ�����50�Ž�����
}

CollectCard.CARD_BAG_AWARD =
{
	[1] = {18,1,178,4}, --ʢ�Ļ�ƽ���
	[2] = {18,1,178,3}, --ʢ�Ļ��������
	[3] = {18,1,178,2}, --ʢ�Ļ��ͭ����
	[4] = {18,1,178,1}, --ʢ�Ļ��������
	[5] = {18,1,114,6}, --�󶨵�6������
	[6] = {18,1,114,5}, --�󶨵�5������
	[7] = {18,1,114,4}, --�󶨵�4������
}

--CollectCard.HUOJU_AWARD_STEP = {10000, 3500, 1000, 300, 80, 20}
--CollectCard.HUOJU_AWARD =
--{
--	[1] = {tbItem={18,1,179,2}, nBind=1, nTimeLimit = 43200}, --�ƽ�����
--	[2] = {tbItem={18,1,179,1}, nBind=1, nTimeLimit = 43200}, --��������
--	[3] = {tbItem={18,1,1,10}, nBind=1}, --10������
--	[4] = {tbItem={18,1,1,9}, nBind=1}, --9������
--	[5] = {tbItem={18,1,1,8}, nBind=1}, --8������
--	[6] = {tbItem={18,1,1,7}, nBind=1}, --7������
--}

function CollectCard:WriteLog(szLog, nPlayerId)
	if nPlayerId then
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
		if (pPlayer) then
			Dbg:WriteLog("SpecialEvent.CollectCard", "ʢ�Ļ���ռ�", pPlayer.szAccount, pPlayer.szName, szLog);
			return 1;
		end
	end
	Dbg:WriteLog("SpecialEvent.CollectCard", "ʢ�Ļ���ռ�", szLog);

end

local __get_boots_1 = function(pPlayer)
	pPlayer.AddRepute(10,1,1500);
	return {};
end

local __get_boots_2 = function(pPlayer)
	pPlayer.AddRepute(10,1,500);
	return {};
end

CollectCard.tbFinalAwardNationalDay09 = 
{-- ����   gdpl       ����
	{1,   {repute={10,1,1500}},0},	--����
	{10,  {repute={10,1,500}},0},	--����
	{100, {item={18,1,462,1}},5},
	{500, {item={18,1,462,1}},3},
	{1000,{item={18,1,355,1}},2},
	{2000,{item={18,1,355,1}},1},
	{3000,{item={18,1,114,8}},1},
};

-- 09����쿨Ƭ�ռ����������
-- �н�return {g,d,p,l}, nNum 
-- û��return nil
function CollectCard:GetFinalAwardNationalDay09(nRank, nCardNum, pPlayer)
	if (nRank <= 0 or nRank > 3000) then
		if nCardNum >= 60 then
			return 2, {18,1,114,8}, 1;
		else
			return 0;
		end
	end
	
	for _, tbData in ipairs(self.tbFinalAwardNationalDay09) do
		if nRank <= tbData[1] then
			if tbData[2].repute then
				return 1, tbData[2].repute, tbData[3];
			end
			if tbData[2].item then
				return 2, tbData[2].item, tbData[3];
			end
		end
	end
	return 0;
end

