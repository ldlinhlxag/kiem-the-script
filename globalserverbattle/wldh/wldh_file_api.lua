-- �ļ�������wldh_file_api.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-08-17 11:52:21
-- ��  ��  ��

--������
function Wldh:GetName(nType)
	return self.MACTH_TYPE[nType].szName;
end

--��������
function Wldh:GetDesc(nType)
	return self.MACTH_TYPE[nType].szDesc;
end

--���Ƴ��ط�������
function Wldh:GetMapLinkType(nType)
	return self.MACTH_TYPE[nType].nMapLinkType;
end

--��������
function Wldh:GetCfg(nType)
	return self.MACTH_TYPE[nType].tbMacthCfg;
end

--���Ƴ���:�᳡��ͼtable
function Wldh:GetMapWaitTable(nType)
	return self.MACTH_TYPE[nType].tbWaitMap;
end

--���Ƴ���:׼������ͼtable
function Wldh:GetMapReadyTable(nType)
	return self.MACTH_TYPE[nType].tbReadyMap;
end

--���Ƴ���:��������ͼtable
function Wldh:GetMapMacthTable(nType)
	return self.MACTH_TYPE[nType].tbMacthMap;
end

--���Ƴ���:�油��������ͼtable
function Wldh:GetMapMacthPatchTable(nType)
	return self.MACTH_TYPE[nType].tbMacthMapPatch;
end

--���Ƴ���:���ս������
function Wldh:GetLGType(nType)
	return self.MACTH_TYPE[nType].nLGType;
end

--��ñ�������̨��
function Wldh:GetMapPKPosTable(nType)
	return self.MACTH_TYPE[nType].tbPkPos;
end

--���һ�ű�����ͼ������ɶ��ٶ���(�����油��)
function Wldh:GetOneMapPlayerMax(nType)
	for nId in ipairs(self:GetMapMacthTable(nType)) do
		if not self:GetMapMacthPatchTable(nType)[nId] then
			return 200;
		end
	end
	return 400;
end
