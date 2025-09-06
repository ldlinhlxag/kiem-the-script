
-- װ�����ⲿ�����ļ��ӿ�

------------------------------------------------------------------------------------------
-- initialize

Item.tbExternSetting = {};

local tbExternSetting = Item.tbExternSetting;

tbExternSetting.TABFILE_CLASSLIST	= "classlist.txt"

tbExternSetting.tbClass		= {};
tbExternSetting.tbClassBase	= {};

------------------------------------------------------------------------------------------
-- interface

function tbExternSetting:Load(szPath)

	local szClassList = szPath.."\\"..self.TABFILE_CLASSLIST;
	local pTabFile = KIo.OpenTabFile(szClassList);
	if (not pTabFile) then
		print("�ļ�"..szClassList.."�򲻿���");
		return	0;
	end

	local tbContent = pTabFile.AsTable();
	local bRet = 1;

	for i = 1, #tbContent do
		local szClass = tbContent[i][1];
		if szClass and ("" ~= szClass) then
			local tbClass = self:GetClass(szClass, 1);
			if (not tbClass) then
				print("��Ч���ⲿ�����ࣺ"..szClass);
				bRet = 0;
			elseif (1 ~= tbClass:Load(szPath.."\\"..szClass.."\\")) then
				print("��ȡ������"..szClass.."ʧ��!");	-- added by dengyong  20100201
				bRet = 0;
			end
		end
	end

	KIo.CloseTabFile(pTabFile);
	return	bRet;

end

------------------------------------------------------------------------------------------
-- private

function tbExternSetting.tbClassBase:Load(szDir)
	return	0;
end

function tbExternSetting:GetClass(szClassName, bNotCreate)
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) and (bNotCreate ~= 1) then		-- ���û��bNotCreate�����Ҳ���ָ��ģ��ʱ���Զ�������ģ��
		tbClass	= Lib:NewClass(self.tbClassBase);
		self.tbClass[szClassName] = tbClass;
	end
	return tbClass;
end
