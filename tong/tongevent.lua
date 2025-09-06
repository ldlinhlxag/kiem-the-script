-------------------------------------------------------------------
--File: kinevent.lua
--Author: lbh
--Date: 2007-7-9 18:02
--Describe: ��Ϸ�����¼��ļ��������������˳��� �ճ���ȣ�
-------------------------------------------------------------------
if not Kin then --������Ҫ
	Kin = {}
	print(GetLocalDate("%Y\\%m\\%d  %H:%M:%S").." build ok ..")
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
