-------------------------------------------------------------------
--File: kluaunion.lua
--Author: zhengyuhua
--Date: 2009-6-6 15:17
--Describe: KLuaUnion��չ�ű�ָ��
-------------------------------------------------------------------
if MODULE_GAMECLIENT then
	return
end

if not _KLuaUnion then --������Ҫ
	_KLuaUnion = {}
	print(GetLocalDate("%Y\\%m\\%d  %H:%M:%S").." build ok ..")
end

local self	--��Ϊ��һ��Up Value

Union.aUnionTaskDesc2Id = {}
Union.aUnionTmpTaskDesc2Id = {}
Union.aUnionBufTaskDesc2Id = {}

--�������ɰ�����������Ӧ��ָ��
local function _GEN_TASK_FUN(szDesc, nTaskId)
	local funGet = 
		function ()
			return self.GetTask(nTaskId)
		end
	local funSet = 
		function (nValue)
			return self.SetTask(nTaskId, nValue)
		end
	local funAdd = 
		function (nValue)
			return self.AddTask(nTaskId, nValue)
		end
	rawset(_KLuaUnion, "Get"..szDesc, funGet)
	rawset(_KLuaUnion, "Set"..szDesc, funSet)
	rawset(_KLuaUnion, "Add"..szDesc, funAdd)
	Union.aUnionTaskDesc2Id[szDesc] = nTaskId
end

--�޷��������������
local function _GEN_TASK_FUN_U(szDesc, nTaskId)
	local funGet = 
		function ()
			return self.GetTaskU(nTaskId)
		end
	local funSet = 
		function (nValue)
			return self.SetTask(nTaskId, nValue)
		end
	local funAdd = 
		function (nValue)
			return self.AddTask(nTaskId, nValue)
		end
	rawset(_KLuaUnion, "Get"..szDesc, funGet)
	rawset(_KLuaUnion, "Set"..szDesc, funSet)
	rawset(_KLuaUnion, "Add"..szDesc, funAdd)
	Union.aUnionTaskDesc2Id[szDesc] = nTaskId
end

local function _GEN_BUF_TASK_FUN(szDesc, nTaskId)
	local funGet = 
		function ()
			return self.GetBufTask(nTaskId)
		end
	local funSet = 
		function (szValue)
			return self.SetBufTask(nTaskId, szValue)
		end
	rawset(_KLuaUnion, "Get"..szDesc, funGet)
	rawset(_KLuaUnion, "Set"..szDesc, funSet)
	Union.aUnionBufTaskDesc2Id[szDesc] = nTaskId
end

local function _GEN_TMP_TASK_FUN(szDesc, nTaskId)
	local funGet = 
		function ()
			return self.GetTmpTask(nTaskId)
		end
	local funSet = 
		function (nValue)
			return self.SetTmpTask(nTaskId, nValue)
		end
	local funAdd = 
		function (nValue)
			return self.AddTmpTask(nTaskId, nValue)
		end
	rawset(_KLuaKin, "Get"..szDesc, funGet)
	rawset(_KLuaKin, "Set"..szDesc, funSet)
	rawset(_KLuaKin, "Add"..szDesc, funAdd)
end



--��Ҫ�ı���������ı�ţ�
_GEN_TASK_FUN("CreateTime", 1)				--����ʱ��
_GEN_TASK_FUN_U("UnionMaster", 2)			--�������ID
_GEN_TASK_FUN("DomainColor", 3)				-- ������ɫ
_GEN_BUF_TASK_FUN("Name", 1)				-- ��������

if not MODULE_GAMECLIENT then
	_GEN_TMP_TASK_FUN("UnionDataVer", 1)	-- ��ǰ���ݰ汾�ţ�������ͻ��˵����ݶԱ�
end



