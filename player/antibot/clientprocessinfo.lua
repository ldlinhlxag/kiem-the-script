-- �ļ�������clientprocessinfo.lua
-- �����ߡ���houxuan
-- ����ʱ�䣺2008-12-22 08:54:02

Require("\\script\\player\\antibot\\antibot.lua");

local tbCProInfo = Player.tbAntiBot.tbCProInfo or {};
Player.tbAntiBot.tbCProInfo = tbCProInfo;

tbCProInfo.tbc2sFun = {};

function tbCProInfo:CollectClientProInfo(szProName, szRoleName)
	local pPlayer = KPlayer.GetPlayerByName(szRoleName);
	if (not pPlayer) then
		return 0;
	end;
	
	if (not szProName) then
		szProName = "";
	end
	
	local szMsg = [[	
		local nRetCode, szRes = GetClientProInfo(_szProName_);
		if nRetCode == 1 then
			szRes = "��ʼ��ʧ�ܡ�";	
		elseif nRetCode == 2 then
			szRes = "��ȡ��ϸ��Ϣʧ�ܡ�";	
		end
		
		local nMaxSendLen = 1024 * 6;	
		local nResLen = string.len(szRes);
		
		if (nResLen >= 100 * 1024) then
			nResLen = 100 * 1024;
		end

		local nStart = 0;
		while (nStart + nMaxSendLen < nResLen) do
			me.CallServerScript({"ClientProInfo", "SaveClientInfo", me.szName, string.sub(szRes, nStart, nStart + nMaxSendLen), 0});
			nStart = nStart + nMaxSendLen;                           
		end                           
		                           
		me.CallServerScript({"ClientProInfo", "SaveClientInfo", me.szName, string.sub(szRes, nStart, nResLen), 1});
	]];                           
	szMsg = string.gsub(szMsg, "_szProName_", "\""..szProName.."\"");                                
	
	--��¼ѯ�ʵ�ʱ��Ϳͻ��˵���Ϣ��д���ļ���
	local szLog = string.format("IP��%s\t��ɫ����%s\t�˺ţ�%s\t�����ȡ�ͻ��˽��̵�ʱ�䣺%s\n", pPlayer.GetPlayerIpAddress(), pPlayer.szName, pPlayer.szAccount, GetLocalDate("%Y\\%m\\%d  %H:%M:%S"));
	local tbData = Player:GetPlayerTempTable(pPlayer);
	tbData.szCP_FileName = "log\\AntiLog"..GetLocalDate("%Y%m%d")..".txt";
	KIo.AppendFile(tbData.szCP_FileName, szLog);
	
	pPlayer.CallClientScript({"GM:DoCommand", szMsg});
	return 0;
end

--���ռ����Ľ�����Ϣ���͵�����˱���
function tbCProInfo:SaveClientInfo(szName, szMsg, nEndFlag)
	if (type(szName) ~= "string" or type(szMsg) ~= "string" or (not nEndFlag)) then
		return 0;
	end
	local pPlayer = KPlayer.GetPlayerByName(szName);
	if (not pPlayer) then
		return 0;
	end;
	local tbData = Player:GetPlayerTempTable(pPlayer);
	
	if (not tbData.tbCP_Msg) then
		tbData.tbCP_Msg = {};
	end
	table.insert(tbData.tbCP_Msg, szMsg);
	local szInfo = table.concat(tbData.tbCP_Msg);
	if (string.len(szInfo) >= 100 * 1024) then	--�ͻ��˽�����Ϣ����ܳ���100K
		local szText = string.format("IP��%s\t��ɫ��%s\t�˺ţ�%s\t�ͻ��˽�����Ϣ�ռ�����ʱ�䣺%s\t�������쳣(���ȳ���100K)�����ݣ�\n%s\n", pPlayer.GetPlayerIpAddress(), pPlayer.szName, pPlayer.szAccount, GetLocalDate("%Y\\%m\\%d  %H:%M:%S"), szInfo);
		KIo.AppendFile(tbData.szCP_FileName, szText);
		tbData.tbCP_Msg = nil;
		local szLogMsg = string.format("[�����]���ͻ��˽�����Ϣ����\t�˺ţ�%s\t��ɫ��%s\tIP��ַ��%s\tʱ�䣺%s", pPlayer.szAccount, pPlayer.szName, pPlayer.GetPlayerIpAddress(), GetLocalDate("%Y\\%m\\%d  %H:%M:%S"));
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_ANTIBOT_PROCESS, szLogMsg);
		pPlayer.KickOut();		--�������쳣��ֱ�ӰѸ����������
		return 0;
	end
	
	if (nEndFlag == 0) then			--����0��ʾ���к�̵���Ϣ
		return 0;
	end
	
	local szText = string.format("IP��%s\t��ɫ����%s\t�˺ţ�%s\t�ͻ��˽�����Ϣ�ռ�����ʱ�䣺%s\n%s\n", pPlayer.GetPlayerIpAddress(), pPlayer.szName, pPlayer.szAccount, GetLocalDate("%Y\\%m\\%d  %H:%M:%S"), szInfo);
	KIo.AppendFile(tbData.szCP_FileName, szText);
	tbData.tbCP_Msg = nil;
	return 1;
end

tbCProInfo.tbc2sFun["SaveClientInfo"] = tbCProInfo.SaveClientInfo;


--�ϴ��ͻ��˵��ļ�

tbCProInfo.tbClientFile = {}

function tbCProInfo:RequestUpload(szName, szClientPath, szLocalName)
	if (self:IsAllowUpload() == 1) then
		self:WriteLog("RequestUpload", "�������˽�ֹ�ϴ��ͻ�����Ϣ��");
		return 0;
	end
	
	local pPlayer = KPlayer.GetPlayerByName(szName);
	if (not pPlayer) then
		self:WriteLog("RequestUpload", "player "..szName.." is not online.");
		return 0;
	end
	if (not szClientPath) then
		return 0;
	end
	if ((not szLocalName) or (szLocalName == "")) then
		szLocalName = GetLocalDate("%Y%m%d");
	end
	if (string.len(szLocalName) <= 4) then
		szLocalName = szLocalName..".pak";
	elseif (string.sub(szLocalName, -4, -1) ~= ".pak") then
		szLocalName = szLocalName..".pak";
	end
	self.tbClientFile[szName] = nil;
	self.tbClientFile[szName] = {};
	
	local tbOne = self.tbClientFile[szName];
	
	tbOne.szFileName = "log\\"..szName..szLocalName;
	tbOne.szFileText = {};
	tbOne.nCount = 0;
	tbOne.szFileText[0] = {};
	tbOne.szFileText[1] = {};
	
	local szMsg = [[
		local nRet = UploadFile(__szClientPath__, __szLocalName__);
		if (nRet ~= 0)	then
			me.CallServerScript({"RecvCData", "RecvData", me.szName, -2, 0, ""});
		end
	]];
	
	szMsg = string.gsub(szMsg, "__szClientPath__", "\""..szClientPath.."\"");
	szMsg = string.gsub(szMsg, "__szLocalName__", "\""..szLocalName.."\"");
	
	pPlayer.CallClientScript({"GM:DoCommand", szMsg});
	return 0;
end

function tbCProInfo:RecvData(szName, nFileIndex, nPackCount, szMsg)
	if (self:IsAllowUpload() == 1) then
		self:WriteLog("RecvData", "�������˽�ֹ�ϴ��ͻ�����Ϣ, ��Ϣ����ʧ��");
		self:ClearPlayerData(szName);
		return 0;
	end
	
	local pPlayer = KPlayer.GetPlayerByName(szName);
	if (not pPlayer) then
		self:WriteLog("RequestUpload", "���"..szName.."��������������Ѿ��Ͽ�.");
		self:ClearPlayerData(szName);
		return 0;
	end
	
	local tbOne = self.tbClientFile[szName];
	if (not tbOne) then
		self:WriteLog("RecvData", "��������δҪ��"..szName.."�ϴ��ͻ����ļ���");
		return 0;
	end
	
	if (nFileIndex == -1) then
		self:SaveClientData(szName);
		self:ClearPlayerData(szName);
	elseif (nFileIndex == -2) then
		self:WriteLog("RecvData", "�����ϴ�"..szName.."�Ŀͻ����ļ�ʧ�ܣ����ʧ�ܻ����Ҳ���Ҫ������ļ�");
		self:ClearPlayerData(szName);
	else
		if (nPackCount == -1) then	--�µ��ļ�
			tbOne.szFileText[nFileIndex][tbOne.nCount + 1] = szMsg;
			tbOne.nCount = 0;
			self:Response(szName);
		elseif (tbOne.nCount + 1 == nPackCount) then
			tbOne.nCount = nPackCount;
			tbOne.szFileText[nFileIndex][tbOne.nCount] = szMsg;
			self:Response(szName);
		else
			self:WriteLog("RecvData", "���"..szName.."�ϴ��ͻ������ݵĹ����У��������ݰ�ȱʧ��");
			self:ClearPlayerData(szName);	--���ݰ����ͳ���
		end
	end
	return 0;
end

tbCProInfo.tbc2sFun["RecvData"] = tbCProInfo.RecvData;

function tbCProInfo:Response(szName)
	if (self:IsAllowUpload() == 1) then
		self:WriteLog("Response", "�������˽�ֹ�ϴ��ͻ�����Ϣ, ֹͣ��ͻ��˷����ϴ����ݵ�����");
		self:ClearPlayerData(szName);
		return 0;
	end
	
	local pPlayer = KPlayer.GetPlayerByName(szName);
	if (not pPlayer) then
		self:WriteLog("Response", "���"..szName.."�Ѿ������ߣ��޷���Ӧ�ͻ��˼����������ݡ�");
		self:ClearPlayerData(szName);
		return 0;
	end
	local nBytes = self:GetPacketSize();
	if (nBytes == 0) then
		self:WriteLog("Response", "��ǰ�����������������ֹ࣬ͣ�ϴ��ͻ������ݡ�");
		self:ClearPlayerData(szName);
		return 0;
	end
	local szMsg = [[
		local nFileIndex, nPackCount, szMsg = SendClientData(__nBytes__);
		me.CallServerScript({"RecvCData", "RecvData", me.szName, nFileIndex, nPackCount, szMsg});
	]];
	szMsg = string.gsub(szMsg, "__nBytes__", nBytes);
	pPlayer.CallClientScript({"GM:DoCommand", szMsg});
	return 0;
end

tbCProInfo.tbSizeCfg = {
		[1]		= 1024 * 3,
		[2]		= 1024 * 3,
		[3]		= 1024 * 3,
		[4]		= 1024 * 3,
		[5]		= 1024 * 2,
		[6]		= 1024,
		[7]		= 512,
		[8]		= 0,
	}

tbCProInfo.nForbidden = 0;	--Ϊ0��ʾ�����ϴ���Ϊ1��ʾ��ֹ�ϴ�

function tbCProInfo:SetForbiddenValue(nValue)
	self.nForbidden = nValue;
	return 0;
end

function tbCProInfo:IsAllowUpload()
	return self.nForbidden;
end

--�ɵ�ǰ�ķ����������������������ϴ������ݰ��Ĵ�С
function tbCProInfo:GetPacketSize()
	local nCurPlayerNumber = KPlayer.GetPlayerCount();
	nCurPlayerNumber = nCurPlayerNumber / 100;
	if (nCurPlayerNumber < 1) then
		nCurPlayerNumber = 1;
	end
	local nNumber = 0;
	for i, nBytes in ipairs(self.tbSizeCfg) do
		if (nCurPlayerNumber >= i) then
			nNumber = nBytes;
		end
	end
	if (self:IsAllowUpload() == 1) then
		nNumber = 0;
	end
	return nNumber;
end

function tbCProInfo:SaveClientData(szName)
	local tbOne = self.tbClientFile[szName];
	if (not tbOne) then
		self:WriteLog("SaveClientData", "��������δҪ�������ϴ��ͻ����ļ�, �޷��������ݡ�");
		return 0;
	end
	local szTemp = "";
	local tbPak = tbOne.szFileText[0];
	for i, msg in ipairs(tbPak) do
		szTemp = szTemp..msg;
		if (string.len(szTemp) >= 20 * 1024) then
			KIo.AppendFile(tbOne.szFileName, szTemp);
			szTemp = "";
		end
	end
	KIo.AppendFile(tbOne.szFileName, szTemp);
	szTemp = "";
	
	local tbTxt = tbOne.szFileText[1];
	for i, msg in ipairs(tbTxt) do
		szTemp = szTemp..msg;
		if (string.len(szTemp) >= 20 * 1024) then
			KIo.AppendFile(tbOne.szFileName..".txt", szTemp);
			szTemp = "";
		end
	end
	KIo.AppendFile(tbOne.szFileName..".txt", szTemp);
	szTemp = "";
end

function tbCProInfo:ClearPlayerData(szName)
	if (self.tbClientFile[szName]) then
		self.tbClientFile[szName] = nil;
		self:WriteLog("ClearPlayerData", "������"..szName.."�ڵ�ǰ���������Ѿ��ϴ����������ݡ�");
	end
end

function tbCProInfo:WriteLog(...)
	Dbg:WriteLogEx(Dbg.LOG_ATTENTION, "Player.tbAntiBot.tbCProInfo", unpack(arg));
end

function tbCProInfo:OnLogout(szReason)
	if (self.tbClientFile[me.szName]) then
		self:WriteLog("OnLogout", "������ߣ��ͷ�����ڷ�������δ�ϴ���ϵ���Դ��");
		self:ClearPlayerData(me.szName);
	end
end

PlayerEvent:RegisterGlobal("OnLogout", Player.tbAntiBot.tbCProInfo.OnLogout, Player.tbAntiBot.tbCProInfo);
