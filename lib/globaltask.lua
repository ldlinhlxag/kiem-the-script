-------------------------------------------------------------------
--File: globaltask.lua
--Author: lbh
--Date: 2007-7-12 10:30
--Describe: ͨ�ýű�ȫ���������
--�������ID�����뿴misc/globaltaskdef.lua
-------------------------------------------------------------------

Require("\\script\\misc\\globaltaskdef.lua");

if (MODULE_GAMECLIENT) then	------- �ͻ���ģ�ⲿ��
	function KGblTask.SCGetDbTaskInt(key)
		return GblTask.tbSyncClientTaskData[key] or 0;
	end
	function KGblTask.SCGetDbTaskStr(key)
		return GblTask.tbSyncClientTaskData[key] or "";
	end
	
	return;	-- �ͻ���û��������ȫ�ֱ�����غ���
end

--��SCǰ׺���������KGblTask GMָ��
--key����Ϊ���ͺ��ַ����ͣ��ַ�����key����С��120�ַ�

------------------------------�洢��ͬ����ȫ���������----------------------------------
function KGblTask.SCGetDbTaskInt(key)
	if not key then
		print(debug.traceback("KGblTask Error"));
	end
	return KGblTask.GetGblInt(65, key)
end

function KGblTask.SCSetDbTaskInt(key, nValue)	--��Gameserver�˲�����������
	if not key or not nValue then
		print(debug.traceback("KGblTask Error"));
	end
	return KGblTask.SetGblInt(65, key, nValue)
end

function KGblTask.SCAddDbTaskInt(key, nAdd)
	return KGblTask.AddGblInt(65, key, nAdd)
end

function KGblTask.SCGetDbTaskStr(key)
	if not key then
		print(debug.traceback("KGblTask Error"));
	end
	return KGblTask.GetGblStr(65, key)
end

function KGblTask.SCSetDbTaskStr(key, szValue)	--szValueС��120�ַ�
	if not key or not szValue then
		print(debug.traceback("KGblTask Error"));
	end
	return KGblTask.SetGblStr(65, key, szValue)
end

function KGblTask.SCDelDbTaskStr(key)
	return KGblTask.DelGblStr(65, key)
end

------------------------------���洢��ͬ����ȫ���������----------------------------------
function KGblTask.SCGetTmpTaskInt(key)
	return KGblTask.GetGblIntTmp(65, key)
end

function KGblTask.SCSetTmpTaskInt(key, nValue)
	return KGblTask.SetGblIntTmp(65, key, nValue)
end

function KGblTask.SCAddTmpTaskInt(key, nAdd)
	return KGblTask.AddGblIntTmp(65, key, nAdd)
end

function KGblTask.SCGetTmpTaskStr(key)
	return KGblTask.GetGblStrTmp(65, key)
end

function KGblTask.SCSetTmpTaskStr(key, szValue) --szValueС��120�ַ�
	return KGblTask.SetGblStrTmp(65, key, szValue)
end

function KGblTask.SCDelTmpTaskStr(key)
	return KGblTask.DelGblStrTmp(65, key)
end
------------------------------��ͬ��Ҳ���洢���������----------------------------------
function KGblTask.SCGetLocalTaskInt(key)
	return KGblTask.GetLocalInt(65, key)
end

function KGblTask.SCSetLocalTaskInt(key, nValue)
	return KGblTask.SetLocalInt(65, key, nValue)
end

function KGblTask.SCAddLocalTaskInt(key, nAdd)
	return KGblTask.AddLocalInt(65, key, nAdd)
end

function KGblTask.SCGetLocalTaskStr(key)
	return KGblTask.GetLocalStr(65, key)
end

function KGblTask.SCSetLocalTaskStr(key, szValue) --szValueС��120�ַ�
	return KGblTask.SetLocalStr(65, key, szValue)
end

function KGblTask.SCDelLocalTaskStr(key) --szValueС��120�ַ�
	return KGblTask.DelLocalStr(65, key)
end
