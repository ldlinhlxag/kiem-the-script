-------------------------------------------------------------------
--File: kinevent.lua
--Author: lbh
--Date: 2007-7-9 18:02
--Describe: ��Ϸ�����¼��ļ��������������˳��� �ճ���ȣ�
-------------------------------------------------------------------
if not Kin then --������Ҫ
	Kin = {}
	print(GetLocalDate("%Y/%m/%d/%H/%M/%S").." build ok ..")
end

--�����������ʼ��
function Kin:Init()
	if MODULE_GAMESERVER then
		return self:Init_GS()
	elseif MODULE_GC_SERVER then
		return self:Init_GC()
	end
end

--�˳�������ʼ��
function Kin:UnInit()
	if MODULE_GAMESERVER then
		return self:UnInit_GS()
	elseif MODULE_GC_SERVER then
		return self:UnInit_GC()
	end
end


if MODULE_GC_SERVER then
----------------------------------------------------------------------
function Kin:Init_GC()
	local itor = KKin.GetKinItor()
	if not itor then
		return 0
	end
	local nKinId = itor.GetCurKinId()
end

function Kin:UnInit_GC()

end

-- ��������

-- ������ʼ
function Kin:KinEventsStart()
	self.PerKinEvents_cNextKin, self.PerKinEvents_nNextKin = KKin.GetFirstKin()
	if not self.PerKinEvents_cNextKin then
		return 0;
	end	
	
	-- ÿ��KIN_EVENT_ELAPES֡���һ��һ������Ļʱ���
	Timer:Register(self.KIN_EVENT_ELAPES, self.EventAction_Timer, self)
end

-- ÿ��KIN_EVENT_ELAPES֡��ӦTimer�ļ����ص�����
function Kin:EventAction_Timer()
	self.PerKinEvents_cNextKin, self.PerKinEvents_nNextKin = KKin.GetNextKin(self.PerKinEvents_nNextKin);
	
	if not self.PerKinEvents_cNextKin then
		self.PerKinEvents_cNextKin, self.PerKinEvents_nNextKin = KKin.GetFirstKin();
	end
	
	Kin:EventAction_BuildFlag(self.PerKinEvents_nNextKin);
	-- ���еļ����ڴ˺�����

	return self.KIN_EVENT_ELAPES;	-- KIN_EVENT_ELAPES֡����ִ��
end

-- ����:�������
function Kin:EventAction_BuildFlag(nKinId)
	local cKin = KKin.GetKin(nKinId);
	if not cKin then 
		return 0;
	end
	local nOrderTime = cKin.GetKinBuildFlagOrderTime();
	local nPreDay = cKin.GetTogetherTime();
	local nTime = GetTime();
	local nNowDay = tonumber(os.date("%m%d", nTime));
	local nNowHour = tonumber(os.date("%H", nTime));
	local nNowMin = tonumber(os.date("%M", nTime));
	local nNowTime = nNowHour * 60 + nNowMin;	

	if nOrderTime == 0 then
		return 0;
	end	
	
-- �����Ԥ��ʱ���ǰ���Сʱ,20����,10������ʾ
	local tbKinData = Kin:GetKinData(nKinId);
	if not tbKinData.nBuildFlagNotifyStep then
		tbKinData.nBuildFlagNotifyStep = 1;
	end
	local nStep = tbKinData.nBuildFlagNotifyStep;
	if (nStep <= 3 and nPreDay ~= nNowDay) then
		
		local nNoticeTime = nOrderTime - self.tbLeftTime[nStep];
		if (nNoticeTime <= nNowTime and nOrderTime >= nNowTime) then
			GlobalExcute{"Kin:NoticeKinBuildFlag_GS2", nKinId, nOrderTime - nNowTime};
			tbKinData.nBuildFlagNotifyStep = nStep + 1;
		end	
	else
		nStep = 1;	
	end
	
-- �������Ԥ��ʱ��
	if nOrderTime <= nNowTime and nPreDay ~= nNowDay then
		print("Kin"..nKinId..",BuildFlag����".."nPreDay"..nPreDay..",nNowDay"..nNowDay);
		cKin.SetTogetherTime(nNowDay);
		GlobalExcute{"Kin:KinBuildFlag_GS2", nKinId};
	end
end



-- ����:����ؿ�
--function Kin:EventAction_KinGame(nKinId)
--	print("������ؿ�ʱ��");
--	local cKin = KKin.GetKin(nKinId);
--	local tbOrderTime = {};
--	tbOrderTime[1] = cKin.GetKinGameOrderTime1();
--	tbOrderTime[2] = cKin.GetKinGameOrderTime2();
--	tbOrderTime[3] = cKin.GetKinGameOrderTime3();
	
--	local nPreTime = cKin.GetKinGameTime();
	
--	for n = 1, #tbTime do
--		if os.date("%w", tbOrderTime[n]) == os.date("%w", GetTime()) then
--			if os.date("%X", tbOrderTime[n]) >= os.date("%X", GetTime()) and 
--			   os.date("%W%w", nPreTime) ~= os.date("%W%w", GetTime()) then
--				cKin:SetKinGameTime(tbOrderTime[n]);
--				GlobalExcute{"KinGame:ApplyKinGame", nKinId, cKin.GetKinGameOrderMapId()};
				--GCExcute{"KinGame:ApplyKinGame_GC", nKinId, nMemberId, him.nMapId, me.nId};
--			end
--		end
--	end
--end

-- ��GC��ʼʱ���õĺ���RegisterGCServerStartFunc��ע�������ʼ����
GCEvent:RegisterGCServerStartFunc(Kin.KinEventsStart, Kin);

----------------------------------------------------------------------
end


if MODULE_GAMESERVER then
----------------------------------------------------------------------
function Kin:Init_GS()

end

function Kin:UnInit_GS()
	--ͬ��������ܽ���������ֵ��
	for nKinId, aKinData in pairs(self.aKinData) do
		if aKinData.nTotalReputeValue > self.CONF_VALUE2REPUTE then
			KKin.ApplyAddKinTask(nKinId, 6, math.floor(aKinData.nTotalReputeValue / self.CONF_VALUE2REPUTE))
		end
	end
end

----------------------------------------------------------------------
end
