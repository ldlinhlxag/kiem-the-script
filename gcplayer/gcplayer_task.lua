-------------------------------------------------------------------
--File: gcplayer_task.lua
--Author: lbh
--Date: 2007-9-17 21:47
--Describe: kgc_player�������������
-------------------------------------------------------------------
if (MODULE_GAMECLIENT) then
	return;
end
local preEnv = _G	--����ɵĻ���
setfenv(1, KGCPlayer)	--���õ�ǰ����ΪKGCPlayer

TSK_LEAVE_KIN_TIME 		= 1;
TSK_ONLINESERVER 		= 2;
TSK_FACTION 			= 3;
TSK_MEMBER_ID			= 4;
TSK_TONGSTOCK			= 5;
TSK_OFFICIAL_LEVEL		= 6;
TSK_MAINTAIN_OFFICIAL_NO = 7;
TSK_CURRENCY_MONEY 		= 8;
TSK_CONNET_ID			= 9;

preEnv.setfenv(1, preEnv)	--�ָ�ȫ�ֻ���
