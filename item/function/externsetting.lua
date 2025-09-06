
-- �ⲿ���û���

-- �ص������ӿڣ�װ���ⲿ����
function Item:LoadExternSetting(szPath, nVersion)
	local tbSetting = self.tbExternSetting[nVersion];
	if (not tbSetting) then
		tbSetting = Lib:NewClass(self.tbExternSetting);	-- ��Item.tbExternSettingΪģ��
		self.tbExternSetting[nVersion] = tbSetting;
	end
	return	tbSetting:Load(szPath);
end

-- ���ָ�����ⲿ������
function Item:GetExternSetting(szClassName, nVersion, bAutoVersion)

	if (not nVersion) or (nVersion <= 0) or (nVersion > table.maxn(Item.tbExternSetting)) then
		if (1 ~= bAutoVersion) then						-- ���bAutoVersion == 1����ʹ�����°汾��
			return;										-- �汾�Ų���ȷ
		end
		nVersion = table.maxn(Item.tbExternSetting);	-- Ĭ��ʹ�����°汾����
	end

	local tbSetting = Item.tbExternSetting[nVersion];
	if (not tbSetting) then
		print("[ITEM] �ð汾�������ļ�û�����룡Version:"..nVersion);
		return;
	end

	return	tbSetting:GetClass(szClassName, 1);

end
