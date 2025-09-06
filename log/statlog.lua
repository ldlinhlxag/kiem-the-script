-------------------------------------------------------------------
--File: statlog.lua
--Author: lbh
--Date: 2008-3-18 15:31:26
--Describe: ͳ��Log
-------------------------------------------------------------------
--KStatLog.ModifyField(szTable, szKey, szField, value)
--KStatLog.ModifyMax(szTable, szKey, szField, nValue)
--KStatLog.ModifyMin(szTable, szKey, szField, nValue)
--KStatLog.ModifyAdd(szTable, szKey, szField, nValue)
-- ���ͣ�0��ͨ��1Daily��2Weekly, 3DailyBackup

if (MODULE_GAMECLIENT) then
	return;	-- ��ֹȫ����ͻ��˱���
end

StatLog.StatTaskGroupId = 2048;

-- [��������ȫ��Сд]
local aTableDefine = {
	["roleinfo"] 	= {"T��n", 3},
	["jxb"] 		= {";��", 1},
	["ibshop"] 		= {"��������", 1},
	["ibitem"] 		= {"��������", 3},
	["mixstat"]	 	= {"��Ŀ", 1},
--	["tifu"] = {"��Ŀ", 1}, --90���������Log
	["armycamp"] 	= {"��Ӫ", 3},
	--["zhongqiu"] 	= {"��������", 1},	--����log
	--["ui"] 		= {"�������ͳ��", 3},
	["xoyogame"] 	= {"��ң��", 1},
	["wlls"] 		= {"��������", 1}, --��������
	["kinweeklytask"] 	= {"�ܻ��Ŀ", 2},	-- �������ܻ���ݷ��������壩
	["personweeklytask"]= {"�ܻ��Ŀ", 2}, -- �������ܻ���ݷ�������Ա��
	["playercount"] = {"ʱ���͵�ͼ", 3},	-- �ƽ�ʱ�������Ϊͳ��
	["bindcoin"] 	= {";��", 1},	--�󶨽��
	["bindjxb"] 	= {";��", 1},	--������
	["coin"] 	= {";��", 1},	--���
};

local function AddTable()
	for szTable, aTableInfo in pairs(aTableDefine) do
		
		KStatLog.AddTable(szTable, aTableInfo[1], aTableInfo[2]);
	end
end

AddTable();
