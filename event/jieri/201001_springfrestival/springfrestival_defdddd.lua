-- �ļ�������define.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2009-12-28 11:41:23
-- ��  ��  ��
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};

SpringFrestival.nLevel 		= 60;    			--��ҵȼ�����
SpringFrestival.nGTPMkPMin_NianHua 	= 500;		--�껭������Ҫ�ľ���
SpringFrestival.nGTPMkPMin_Couplet 	= 1000;		--����������Ҫ�ľ���
SpringFrestival.tbXiWang 		= {18,1,552,1}; --ϣ��֮��
SpringFrestival.tbBaoXiang 	= {18,1,553,1};	--���䣺��һǧ��һ��Ը��
SpringFrestival.tbVowXiang 	= {18,1,554,1};	--Ը������
SpringFrestival.tbCouplet_Unidentify = {18,1,555,1};--δ������Ķ���
SpringFrestival.tbCouplet_identify 	= {18,1,555,2};	--������Ķ���
SpringFrestival.nTrapNumber 		= 1001;				--1001��Ը�����ҿ����콱��
SpringFrestival.nGetFudaiMaxNum 	= 5; 				--��Ըǰ5�λ�ø������м��ʵĽ���
SpringFrestival.nGetHuaDengMaxNum	= 5;			--ÿ������ǰ5�θ����Ʊ��䡤���Ժ�����Ʊ���
SpringFrestival.tbHuaDengBox_N 		= {18,1,568,1};		--���Ʊ���_δ����ͬ��
SpringFrestival.tbHuaDengBox 			= {18,1,568,2}		--���Ʊ���_�ѿ���ͬ��
SpringFrestival.tbNianHua_Unidentify 	= {18,1,557,1};		--δ�������껭
SpringFrestival.tbNianHua_identify 	= {18,1,558};		--��������껭
SpringFrestival.tbNianHua_box		= {18,1,559,1};		--�껭�ղغ�
SpringFrestival.tbNianHua_book	= {18,1,560,1};		--�껭�ռ���
SpringFrestival.tbNianHua_award	= {18,1,561,1};		--�껭�ռ���������_����ͬ��
SpringFrestival.tbNianHua_award_N	= {18,1,561,2};		--�껭�ռ���������_δ����ͬ��
SpringFrestival.tbBaiNianAward	= {18,1,551,2}		--��������[����]
SpringFrestival.VowTreeOpenTime	= 20120202;		--��Ը�����껭�ռ�����ʱ��
SpringFrestival.VowTreeCloseTime	= 20121223;		--��Ը�����껭�ռ�����ʱ��
SpringFrestival.HuaDengOpenTime	= 20100202;		--���ƿ���ʱ��
SpringFrestival.HuaDengCloseTime	= 20121223;		--���ƽ���ʱ��
SpringFrestival.HuaDengOpenTime_C	= 1200;		--���ƿ����ľ���ʱ��12����
SpringFrestival.nBaiNianCount		= 15;				--��ҿ��Ա�����Ĵ���
SpringFrestival.nGuessCounple_nCount	= 100		--��ڼ���ҿ��ԶԴ�������Ŀ
SpringFrestival.nGuessCounple_nCount_daily	= 10		--��ڼ����ÿ����ԶԴ�������Ŀ
SpringFrestival.tbVowTree_Title = {6, 20, 1, 9};		----�ƺŽ�������һǧ��һ��Ը��
SpringFrestival.nGetAward_longwu	= 10;				--����̫ү���һ��껭�ռ���Ĵ���
SpringFrestival.nOutTime	= 201212240000			--��Ʒ����ʱ��
SpringFrestival.bPartOpen = EventManager.IVER_nPartOpen;						--ͬ�鿪�ſ���

SpringFrestival.tbBaiAward = {		--���������������м��ʻ��һ�¶�����gdpl���������䣩
	[1] = {{18,1,552,1}, 0, 40},			--ϣ��֮��
	[2] = {{18,1,555,1}, 40, 60},			--���ƴ���
	[3] = {{18,1,557,1}, 60, 100},			--ʮ����Ф�껭[δ����]
	};

SpringFrestival.tbXiWangAward = {		--��Ը5��֮���м��ʻ��һ�¶�����gdpl���������䣩
	[1] = {{18,1,551,1}, 0, 10},			--��������
	[2] = {{18,1,555,1}, 10, 20},			--���ƴ���
	[3] = {{18,1,557,1}, 20, 40},			--ʮ����Ф�껭[δ����]
	};

SpringFrestival.tbCouplet = {			--��Ҷ��ϴ������м��ʻ��һ�¶�����gdpl���������䣩
	[1] = {{18,1,551,1}, 0, 15},			--��������
	[2] = {{18,1,552,1}, 15, 30},			--ϣ��֮��
	[3] = {{18,1,557,1}, 30, 50},			--ʮ����Ф�껭[δ����]
	};	
	
SpringFrestival.tbNianHua = {			--�ɹ�����һ���껭���м��ʻ��һ�¶�����gdpl���������䣩
	[1] = {{18,1,551,1}, 0, 20},			--��������
	[2] = {{18,1,552,1}, 20, 35},			--ϣ��֮��
	[3] = {{18,1,555,1}, 35, 50},			--���ƴ���
	};	
	
SpringFrestival.tbShengXiao = {"��", "ţ", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��"};  --12��Ф
SpringFrestival.nVowTreeTemplId	= 3723;			--��Ը��ģ��id	
SpringFrestival.nHuaDengTemplId	= 3721;			--����ģ��idδ����
SpringFrestival.nHuaDengTemplId_D	= 3722;		--����ģ��id����
SpringFrestival.tbVowTreePosition = {3,1631,3209};		--��Ը����λ��(��ͼid��x���꣬y����)
SpringFrestival.tbTransferCondition = {["fight"] = 1, ["village"] = 1, ["faction"] = 1, ["city"] = 1};	--ϣ��֮�ִ��͵�����(map��classname)

--taskId
SpringFrestival.TASKID_GROUP			= 2113;	--���������
SpringFrestival.TASKID_TIME			= 1;				--ʱ��
SpringFrestival.TASKID_COUNT			= 2;				--�ڼ�����Ը 
SpringFrestival.TASKID_ISGETAWARD		= 3;				--�Ƿ��Ѿ��콱
SpringFrestival.TASKID_NIANHUA_BOX 	= 4;    			--4��15������¼�ղغ�������껭��
SpringFrestival.TASKID_NIANHUA_BOOK 	= 16; 			--16��27������¼�ռ���������껭����
SpringFrestival.TASKID_GETAWARD		= 28;				--�һ��ռ���Ĵ���
SpringFrestival.TASKID_BAINIANNUMBER	= 29;				--������Ĵ���
SpringFrestival.TASKID_IDENTIFYCOUPLET_NCOUNT		=30;		--��Ҽ����Ķ�����
SpringFrestival.TASKID_GUESSCOUPLET_NCOUNT			=31;		--��һ�ڼ�¶�������Ŀ
SpringFrestival.TASKID_GUESSYCOUPLET_NCOUNT_DAILY  	=32;		--���ÿ��Ŷ�������Ŀ
SpringFrestival.TASKID_STONE_COUNT_MAX			  	=33;		--��ʯ��
SpringFrestival.TASKID_STONE_WEEK			  		=34;		--ÿ�����7����ʯ

SpringFrestival.TASKID_GROUP_EX		= 2093	--�޸�������
SpringFrestival.TASKID_VOWTREE_TIME	= 18		--��Ը������

SpringFrestival.tbLuckyStone  	={18,1,908,1};	       --���˱�ʯ	
SpringFrestival.STONE_COUNT_MAX			  	= 7;		--��ʯ��

--���ݹ���
SpringFrestival.HUADENG = SpringFrestival.HUADENG or {};			--7�����е�mapId�Ͷ�Ӧ��ˢ����ļ���
SpringFrestival.HUADENG_POS = SpringFrestival.HUADENG_POS or {};	--7�����л��Ƶ�ˢ���㣨����ȡǰ50����
SpringFrestival.tbCoupletList = SpringFrestival.tbCoupletList or {};			--����
SpringFrestival.nVowTreenId =  SpringFrestival.nVowTreenId or 0;		--��Ը��dwId
SpringFrestival.tbHuaDeng = SpringFrestival.tbHuaDeng or {};			--������
