-- �Ϸ�����ͨ�ýű�

local CompensateCozone = {};
SpecialEvent.CompensateCozone = CompensateCozone;

CompensateCozone.FUDAI_COUNT_PERTIME	= 20; 	-- ÿ��20��
CompensateCozone.FUDAI_COUNT_GIVE		= 15;	-- ������ȡ����
CompensateCozone.FUDAI_COZONE_DISTIME	= 150;	-- �Ϸ�ʱ������150��
CompensateCozone.FUDAI_OPENTIME			= 30;	-- �Ϸ�������������ʱ��
CompensateCozone.FUDAI_GIVE_LEVEL		= 50;	-- �Ϸ�������ȡ��͵ȼ�

CompensateCozone.TSKGRP = 2110;
CompensateCozone.TSKID_FUDAI_COUNT = 1; -- ������ȡ����

function CompensateCozone:CheckFudaiCompenstateState(pPlayer)
	if (not pPlayer) then
		return 0;
	end
	
	local nNowTime = GetTime()
	local nGbCoZoneTime = KGblTask.SCGetDbTaskInt(DBTASK_COZONE_TIME); 
	local nZoneStartTime = KGblTask.SCGetDbTaskInt(DBTASD_SERVER_STARTTIME);
	local nDisTime = KGblTask.SCGetDbTaskInt(DBTASK_SERVER_STARTTIME_DISTANCE);
	
	-- ���Ǵӷ����
	if (pPlayer.IsSubPlayer() == 0) then
		return 0;
	end

	-- �Ϸ�ʱ����С��150��,������
	if (nDisTime < 3600 * 24 * self.FUDAI_COZONE_DISTIME) then
		return 0;
	end
	
	-- ����30��Ͳ�������
	if (nNowTime < nGbCoZoneTime or nNowTime > nGbCoZoneTime + self.FUDAI_OPENTIME * 24 * 60 * 60) then
		return 0;
	end
	return 1;	
end

-- �жϸ�����ȡ�ʸ�
function CompensateCozone:CheckFudaiQualification(pPlayer)
	if (not pPlayer) then
		return 0, "��Ҳ�����";
	end

	local nNowTime = GetTime()
	local nGbCoZoneTime = KGblTask.SCGetDbTaskInt(DBTASK_COZONE_TIME); 
	local nZoneStartTime = KGblTask.SCGetDbTaskInt(DBTASD_SERVER_STARTTIME);
	local nDisTime = KGblTask.SCGetDbTaskInt(DBTASK_SERVER_STARTTIME_DISTANCE);
	
	-- ���Ǵӷ����
	if (pPlayer.IsSubPlayer() == 0) then
		return 0, "�����ǺϷ�ʱ�ӷ���ң�������ȡ�Ϸ���������";
	end

	-- �Ϸ�ʱ����С��150��,������
	if (nDisTime < 3600 * 24 * self.FUDAI_COZONE_DISTIME) then
		return 0, string.format("�����ںϷ���������������Ŀ���ʱ����û�д���%d�죬������ȡ��������", self.FUDAI_COZONE_DISTIME);
	end
	
	-- ����30��Ͳ�������
	if (nNowTime < nGbCoZoneTime or nNowTime > nGbCoZoneTime + self.FUDAI_OPENTIME * 24 * 60 * 60) then
		return 0, string.format("������ȡ�����ڲ�����ȡ�Ϸ���������");
	end

	-- �ȼ�Ҫ�󲻹�
	if (pPlayer.nLevel < self.FUDAI_GIVE_LEVEL) then
		return 0, string.format("����ǰ�ȼ�û�дﵽ%d����������ȡ�Ϸ���������", self.FUDAI_GIVE_LEVEL);
	end
	
	local nFudaiGetCount = pPlayer.GetTask(self.TSKGRP, self.TSKID_FUDAI_COUNT);
	
	-- ������ȡ�����Ͳ�������
	if (nFudaiGetCount >= self.FUDAI_COUNT_GIVE) then
		return 0, string.format("���Ѿ����������и�������");
	end
	
	-- �����ռ䲻��
	if (pPlayer.CountFreeBagCell() < self.FUDAI_COUNT_PERTIME) then
		return 0, string.format("���ı����ռ䲻��%d����������ȡ�Ϸ�����", self.FUDAI_COUNT_PERTIME);
	end
		
	return 1;	
end

function CompensateCozone:OnFudaiDialog()
	local nFlag, szMsg = self:CheckFudaiQualification(me);
	if (nFlag == 0) then
		Dialog:Say(szMsg);
		return 0;
	end
	
	local nGbCoZoneTime = KGblTask.SCGetDbTaskInt(DBTASK_COZONE_TIME);
	local nFudaiGetCount = me.GetTask(self.TSKGRP, self.TSKID_FUDAI_COUNT);
	local szTime = os.date("%Y��%m��%d��", nGbCoZoneTime + self.FUDAI_OPENTIME * 24 * 60 *60);
	local nLastCount = self.FUDAI_COUNT_GIVE - nFudaiGetCount;
	if (nLastCount <= 0) then
		nLastCount = 0;
		return 0;
	end
	
	Dialog:Say(string.format("��<color=yellow>%s<color>֮ǰ���㻹��<color=yellow>%d<color>�θ���������ȡ��ÿ�ο��Եõ�<color=yellow>%d<color>����������ȷ����������", szTime, nLastCount, self.FUDAI_COUNT_PERTIME),
			{
				{"ȷ��", self.OnSureGetFudai, self},
				{"�ٿ��ǿ���"},
			}
		);
	return 1;
end

function CompensateCozone:OnSureGetFudai()
	local nFlag, szMsg = self:CheckFudaiQualification(me);
	if (nFlag == 0) then
		Dialog:Say(szMsg);
		return 0;
	end
	
	for i=1, self.FUDAI_COUNT_PERTIME do
		me.AddItem(18,1,80,1);
	end
	local nCount = me.GetTask(self.TSKGRP, self.TSKID_FUDAI_COUNT);
	nCount = nCount + 1;
	me.SetTask(self.TSKGRP, self.TSKID_FUDAI_COUNT, nCount);
	self:WriteLog(me.szName, "OnSureGetFudai", nCount);
	return 1;
end

function CompensateCozone:WriteLog(...)
	if (MODULE_GAMESERVER) then
		Dbg:WriteLogEx(Dbg.LOG_INFO, "SpecialEvent", "CompensateCozone", unpack(arg));
	end
	if (MODULE_GAMECLIENT) then
		Dbg:Output("SpecialEvent", "CompensateCozone", unpack(arg));
	end
	return 1;
end

