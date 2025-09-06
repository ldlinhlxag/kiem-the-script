-- �ļ�������presendcard_def.lua
-- �����ߡ���zounan
-- ����ʱ�䣺2010-05-03 14:52:58
-- ��  ��  ��


PresendCard.VERSION_TSK = 2120; --���������2120
PresendCard.VERSION_TYPE = 2000;-- nTypeIdΪ2000����


PresendCard.ITEM_TIMEOUT = 30 *24 * 3600; -- ��Ʒ��Ч��һ���� ��������
PresendCard.ITEM_ID		 = {18,1,931,1};  -- ���ID

	
PresendCard.INDEX_NAME			= 1;	-- �����
PresendCard.INDEX_CALLBACKFUNC	= 2;	-- ��������֤�ص�����
PresendCard.INDEX_CDKEYFLAG		= 3;	-- ������ؼ���
PresendCard.INDEX_ITEMTABLE		= 4;	-- ���id
PresendCard.INDEX_COUNT			= 5;	-- ����ĸ���
PresendCard.INDEX_TASKGROUP		= 6;	-- ��¼�����ǵ��������id
PresendCard.INDEX_TASKID		= 7;	
PresendCard.INDEX_STARTTIME		= 8;	-- �����ʱ��
PresendCard.INDEX_ENDTIME		= 9;	-- �����ʱ��
PresendCard.INDEX_KEYINDEX		= 10;	-- �ؼ�������Ӧ��λ��
PresendCard.INDEX_PARAM			= 11;	-- ����
PresendCard.INDEX_GATEWAYLIMIT	= 12;	-- ��������
PresendCard.INDEX_OTHER			= 13;	-- ����


PresendCard.RESULT_DESC =
{
	[1] = "�ɹ���֤",
	[2] = "��֤ʧ��",
	[3] = "�ʺŲ�����",
	[1009] = "����Ĳ����Ƿ���Ϊ��",
	[1500] = "�˼����벻����",
	[1501] = "�˼������ѱ�����ʹ��",
	[1502] = "�˼������ѹ���",
}

PresendCard._FLAG_TEST = { [2] = 0, [3] = 0 , [4] = 0,[6] = 0, [2000] = 0};
	
	

PresendCard.PRESEND_TYPE = 
{
	[0] = {"Ĭ��", "PresendCard:ErrorCard"};		--��֤���ɹ�
	[1] = {"���ֿ�", "SpecialEvent.NewPlayerCard:OnCheckCardResult"};	--���ֿ�
	[2] = {"����������", "PresendCard:OnCheckResult_LX", "LX", {18,1,387,1}, 1, 2027, 73, 20090807, 20101231, {1,6}};		--����
	[3] = {"���º������", "PresendCard:OnCheckResult_JN", "JN", {18,1,401,1}, 1, 2027, 76, 20090901, 20100331, {1,2}};		--���»
	[4] = {"�����������", "PresendCard:OnCheckResult_DL", "DL", {18,1,533,1}, 1, 2027, 92, 20091201, 20100630, {1,6}};		--�����
	[6] = {"YY����", "PresendCard:OnCheckResult_YY", "YY", {18,1,931,1}, 1, 0, 0, 20100405, 20100630, {1,2},nil,"gate1107,gate1011","PresendCard:OnCheckBefore_YY"};		--YY�
	[2000] = {"�������ֻ", "PresendCard:OnCheckResult_MLXS", "MLXS", {18,1,910,1}, 1, 2091, 1, 0, 0, {1,2,3,4}};		--�������ֻ	
}


--YY�Ĳ�����
PresendCard.PRESEND_TYPE[6][PresendCard.INDEX_PARAM] =
{
 	[1] = {[[AddItem:"18,1,489,2","1","1","0"]],[[AddItem:"18,1,71,3","10","1","0"]],},
 	[2] = {[[AddBindCoin:"7000"]],},
 	[3] = {[[AddItem:"18,1,244,2","1","1","0"]],}, --��ʯ 	
 	[4] = {[[AddItem:"18,1,932,1","1","1","0"]],}, --���
 	[5] = {[[AddItem:"18,1,71,3","10","1","0"]],}, --ǿЧ
 	[6] = {[[AddBindMoney:"800000"]],},			 --����
 	[7] = {[[AddItem:"18,1,1,7","2","1","0"]],},   --7��	
 	[8] = {[[AddItem:"18,1,212,1","2","1","0"]],}, --�����Ƴ���
 	[9] = {[[AddItem:"18,1,933,1","6","1","0"]],}, --ʥ���ǹ� TODO
 	[10] = {[[AddItem:"18,1,113,3","1","1","0"]],}, --��������	
	[11] = {[[AddItem:"18,1,932,1","1","1","0"]],}, --���
	[12] = {[[AddItem:"18,1,212,1","2","1","0"]],}, --������
	[13] = {[[AddBindCoin:"3500"]],}, 				--���3500
	[14] = {[[AddItem:"18,1,251,1","2","1","0"]],}, --�ؾ���ͼ 	 	 	
	[15] = {[[AddItem:"18,1,933,1","5","1","0"]],}, --ʥ���ǹ� TODO
	[16] = {[[AddItem:"18,1,1,7","1","1","0"]],}, 	--7��
	[17] = {[[AddBindMoney:"400000"]],}, 			--����40W
	[18] = {[[AddItem:"18,1,113,2","3","1","0"]],}, --�������� ��
	[19] = {[[AddItem:"20,1,465,1","10","1","0"]],}, --�հ׵��ĵ���
	[20] = {[[AddItem:"18,1,195,1","1","1","43200"]],}, --���޵Ĵ��ͷ�
	[21] = {[[AddItem:"18,1,1,7","1","1","0"]],}, 	--7��
	[22] = {[[AddItem:"18,1,933,1","4","1","0"]],}, --ʥ���ǹ� TODO
	[23] = {[[AddItem:"18,1,71,2","12","1","0"]],}, --���
	[24] = {[[AddItem:"18,1,251,1","1","1","0"]],[[AddItem:"18,1,189,2","2","1","0"]],}, --�ؾ�
	[25] = {[[AddItem:"18,1,212,1","2","1","0"]],}, --������
	[26] = {[[AddBindCoin:"2000"]],},				--���2000
	[27] = {[[AddBindMoney:"500000"]],},	    	--����50W
	[28] = {[[AddItem:"1,12,27,4","1","1","57600"]],}, --���黢 	
};

PresendCard.PresendCardParamYY = 
{
	["C1"] = 1;
	["C2"] = 2;	 
	["C3"] = 3;	
	["C4"] = 4;	
	["C5"] = 5;	
	["C6"] = 6;	
	["C7"] = 7;	
	["C8"] = 8;	
	["C9"] = 9;	
	["C0"] = 10;	
	["D1"] = 11;	
	["D2"] = 12;	
	["D3"] = 13;	
	["D4"] = 14;	
	["D5"] = 15;	
	["D6"] = 16;	
	["D7"] = 17;	
	["D8"] = 18;	
	["D9"] = 19;	
	["D0"] = 20;	
	["E1"] = 21;	
	["E2"] = 22;	
	["E3"] = 23;
	["E4"] = 24;
	["E5"] = 25;
	["E6"] = 26;
	["E7"] = 27;
	["E8"] = 28;	
};



PresendCard.KEYNAME = 
{
	["AddItem"] 		= {1, "��ȡ����", 	},		--��Ʒ
	["AddMoney"] 		= {2, "��������", 	},		--����
	["AddBindMoney"] 	= {3, "���Ӱ���",   },		--������
	["AddBindCoin"] 	= {4, "���Ӱ��", 	},		--�󶨽��
	["AddKinRepute"] 	= {5, "���ӽ�������", },		--��������	
	["AddExp"]			= {6, "���Ӿ���",	},		--����	
	["AddTitle"] 		= {7, "���ӳƺ�",   },		--���ƺ�	
};
