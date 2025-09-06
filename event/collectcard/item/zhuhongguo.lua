-------------------------------------------------------
-- �ļ�������yuanyuezhuhongguo.lua
-- �ļ�������Բ������ ��������
-- �����ߡ���ZouNan1@kingsoft.com
-- ����ʱ�䣺2009-08-31 14:03
-------------------------------------------------------
local tbYueGuo= Item:GetClass("zhuhongguo"); 

tbYueGuo.DELAY_TIME          = 1;     --ʹ�ý�������ʱ�����	1��	
tbYueGuo.USECD_TIME          = 5;     --�¹���ʹ��CD	
tbYueGuo.NEEDED_BAGCELL      = 1;     --������Ҫ�������и��ӵ���Ŀ	
tbYueGuo.AVAIL_AREA          = 20;    --�¹�ʹ�õ���Ч����?����			
tbYueGuo.RABBIT_TEMPLATEID   = 3707;   --���ӵ�CLASS ID	
--������� 
tbYueGuo.TSK_GROUP     		 = 2069;  
tbYueGuo.TSK_COUNT           = 72;
tbYueGuo.TSK_DAY	         = 73;
tbYueGuo.TSK_TOTALCOUNT      = 74;		
		
tbYueGuo.MSG_ERR  = {
	 "ʹ��ʧ�ܣ���������û�����ã�" ,
     "�����ռ䲻��" ,
     "��ƷCD��,���Ժ�����",
	};
tbYueGuo.MSG_SUCC   = {
	"��ɹ�������һֻ���ã���������ף���㣡",
	"������˶�������ã��õ������ף����",	
	};
tbYueGuo.RABBIT_MSG = {
	"�۹��� ���Ա���" ,
	"�ؼң��ؼ�~~~~~" ,
	"��л��������"  ,
	};

tbYueGuo.szName = "Բ������";

function tbYueGuo:OnUse()
    --�ж���ƷCD 
    local nItemCD  = it.GetGenInfo(1);
    local nCurTime = GetTime(); 
    if (nItemCD + self.USECD_TIME) >= nCurTime then
    	me.Msg(self.MSG_ERR[3]);
    	return 0;
    end    
    --�õ���Χ�����ӱ�
	local tbRabbit , nCount = self:GetRabbitAround();
	if nCount == 0 then
		me.Msg(self.MSG_ERR[1]);	
		return 0;		
	end	
    local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE, 
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
	}
	GeneralProcess:StartProcess("ι��������..." , self.DELAY_TIME* Env.GAME_FPS ,  {self.OnHelpRabbit , self , tbRabbit , it.dwId} , nil , tbEvent);	
end

--�������ߵ����ӵ�ID�Ž����ӱ��������ӱ�������Ŀ
function tbYueGuo:GetRabbitAround()
	local tbTempRabbit = {};
	local nCount = 0;
	local tbVar = KNpc.GetAroundNpcList(me , self.AVAIL_AREA);
	for _ , pNpc in pairs(tbVar) do
		if pNpc.nTemplateId == self.RABBIT_TEMPLATEID then
			tbTempRabbit[pNpc.dwId] = 1;
			nCount = nCount + 1;
		end
	end
	return tbTempRabbit , nCount;
end

--������ӱ��е������Ƿ��������ߣ��Դ������µ����ӱ� 
function tbYueGuo:CheckRabbitAround(tbRabbit)
    local tbTempRabbit = self:GetRabbitAround();
    local nCount = 0;
    for nRabbitId , _ in pairs(tbRabbit) do
    	if tbTempRabbit[nRabbitId] then
      		nCount = nCount + 1;
      	else 
      		tbRabbit[nRabbitId] = nil;
    	end
    end
	return tbRabbit , nCount;
end

function tbYueGuo:OnHelpRabbit(tbRabbit , nItemId)
    if me.CountFreeBagCell() < self.NEEDED_BAGCELL then
	  	me.Msg(self.MSG_ERR[2]);
	  	return 0;
	end
	local nCount = 0;
    tbRabbit , nCount = self:CheckRabbitAround(tbRabbit); --������֮�����ж�һ��
    if nCount == 0 then 	
    	me.Msg(self.MSG_ERR[1]);
		return 0;
	end
	for nRabbitId , _ in pairs(tbRabbit) do
	    local pRabbit = KNpc.GetById(nRabbitId);
	    if pRabbit and (not pRabbit.GetTempTable("Npc").tbRabbitAbout or (pRabbit.GetTempTable("Npc").tbRabbitAbout.bIsCatch ~= 1)) then
	    	pRabbit.GetTempTable("Npc").tbRabbitAbout = pRabbit.GetTempTable("Npc").tbRabbitAbout or {};
	    	pRabbit.GetTempTable("Npc").tbRabbitAbout.bIsCatch = 1; --֪ͨrabbit �Ա�������ɾ��
	    	local nPos = math.floor(MathRandom(1, 3));
			pRabbit.SendChat(self.RABBIT_MSG[nPos]); 
	    	self:GetAward(nItemId); -- ���������ӣ��õ�����	
    		return 1;         
 		end
 	end
 	me.Msg(self.MSG_ERR[1]);
 	return 0;
end

-- �������ӣ�?���� 
function tbYueGuo:GetAward(nItemId)
    --������ƷCD
    local pItem = KItem.GetObjById(nItemId);
	if (not pItem) then
		return;
	end
    local nCurTime = GetTime(); 
    pItem.SetGenInfo(1, nCurTime);
    
    --���¾������ӵ���Ŀ
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	if me.GetTask(self.TSK_GROUP, self.TSK_DAY) < nCurDate then
		me.SetTask(self.TSK_GROUP, self.TSK_DAY, nCurDate);
		me.SetTask(self.TSK_GROUP, self.TSK_COUNT, 0);
	end
	
	local nCurCount = me.GetTask(self.TSK_GROUP, self.TSK_COUNT) + 1;
	me.SetTask(self.TSK_GROUP, self.TSK_COUNT, nCurCount);
	local nTotalCount = me.GetTask(self.TSK_GROUP, self.TSK_TOTALCOUNT) + 1;
	me.SetTask(self.TSK_GROUP, self.TSK_TOTALCOUNT, nTotalCount);
	if nTotalCount == 100 then
		me.AddTitle(6,13,1,0);
		me.SetCurTitle(6,13,1,0);
	end
	local nPos = 1;
	if nCurCount <= 5  then   --С�ڻ����5���Ÿ���ȯ
		local pItem =me.AddItem(18,1,466,1);
		if pItem then
			me.SetItemTimeout(pItem, 10080, 0);
		end
	else
		nPos = 2;
	end
	me.Msg(self.MSG_SUCC[nPos]);
	Dialog:SendBlackBoardMsg(me , self.MSG_SUCC[nPos]);	
end

function tbYueGuo:GetTip(nState)
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	local nCurCount = me.GetTask(self.TSK_GROUP, self.TSK_COUNT);
	if me.GetTask(self.TSK_GROUP, self.TSK_DAY) < nCurDate then
		nCurCount = 0;
	end	
	local szTip = string.format("<color=yellow>�����Ѿ�����������:%s\n�ܹ��Ѿ�����������:%s<color>",
		  nCurCount, me.GetTask(self.TSK_GROUP, self.TSK_TOTALCOUNT));	
	return szTip;
end
