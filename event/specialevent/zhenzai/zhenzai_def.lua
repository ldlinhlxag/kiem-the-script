-- �ļ�������define.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2009-12-28 11:41:23
-- ��  ��  ��
SpecialEvent.ZhenZai = SpecialEvent.ZhenZai or {};
local ZhenZai = SpecialEvent.ZhenZai or {};

ZhenZai.nLevel 			= 60;    				--��ҵȼ�����
ZhenZai.tbXiWang 		= {18,1,937,1}; 		--ϣ��֮��
ZhenZai.tbBaoXiang 		= {18,1,936,1};			--���䣺��һǧ��һ��Ը��
ZhenZai.tbVowXiang 	= {18,1,935,1};			--Ը������
ZhenZai.nTrapNumber 		= 2010;			--1001��Ը�����ҿ����콱��
ZhenZai.nGetFudaiMaxNum 	= 5; 				--��Ըǰ5�λ�ø������м��ʵĽ���
ZhenZai.VowTreeOpenTime	= 20100420;		--��Ը�����껭�ռ�����ʱ��
ZhenZai.VowTreeCloseTime	= 20100511;		--��Ը�����껭�ռ�����ʱ��
ZhenZai.tbVowTree_Title 		= {6, 26, 1, 9};		--�ƺŽ�������һǧ��һ��Ը��
ZhenZai.tbPingAnYiJia		= {6, 25, 1, 9};		--ƽ��һ�ҳƺ�
ZhenZai.nOutTime			= 201005120000;	--��Ʒ����ʱ��
ZhenZai.bPartOpen 			= EventManager.IVER_nPartOpen;						--���ſ���
ZhenZai.nVowTreeTemplId	= 6814;


ZhenZai.tbVowTreePosition = {29, 47040/32, 120992/32};		--��Ը����λ��(��ͼid��x���꣬y����)
ZhenZai.tbTransferCondition = {["fight"] = 1, ["village"] = 1, ["faction"] = 1, ["city"] = 1};	--ϣ��֮�ִ��͵�����(map��classname)


--taskId
ZhenZai.TASKID_GROUP			= 2121;	--���������
ZhenZai.TASKID_TIME			= 1;				--ʱ��
ZhenZai.TASKID_COUNT			= 2;				--�ڼ�����Ը 
ZhenZai.TASKID_ISGETAWARD		= 3;				--�Ƿ��Ѿ��콱
ZhenZai.TASKID_TIMEEx			= 8;				--�콱��ʱ���¼
ZhenZai.TASKID_GETPINGAN		= 7;				--�Ƿ��Ѿ��콱

--���ݹ���
ZhenZai.nVowTreenId =  ZhenZai.nVowTreenId or 0;		--��Ը��dwId
