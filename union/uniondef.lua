-------------------------------------------------------------------
--File: uniondef.lua
--Author: zhengyuhua
--Date: 2009-6-6 15:17
--Describe: ���˶���
-------------------------------------------------------------------
if not Union then --������Ҫ
	Union = {}
	print(GetLocalDate("%Y\\%m\\%d  %H:%M:%S").." build ok ..")
end

local preEnv = _G	--����ɵĻ���
setfenv(1, Union)	--���õ�ǰ����ΪUnion

MAX_TONG_NUM = 5 -- �����������
MAX_TONG_DOMAIN_NUM  = 1 -- ����������������

preEnv.setfenv(1, preEnv)	--�ָ�ȫ�ֻ���