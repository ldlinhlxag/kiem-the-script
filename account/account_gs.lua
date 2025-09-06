-------------------------------------------------------------------
--File: account_gs.lua
--Author: lbh
--Date: 2008-6-27 10:04
--Describe: �˺����GS��
-------------------------------------------------------------------
Require("\\script\\account\\account_head.lua");
Require("\\script\\player\\playerevent.lua");

Account.tbUnlockFailCount = {} -- �˺Ž���ʧ�ܴ���
Account.tbBanUnlockTime = {} -- �˺Ž�ֹʱ��
Account.UNLOCK_FAIL_LIMIT = 5;
Account.UNLOCK_BAN_TIME = 30;	-- ������ʧ�ܴ���������ٷ���
Account.TIME_UNLOCKPASSPOD = 60 * 5;	-- ��½��8���Ӳ��ý���
Account.c2sCmd = {};

function Account:ProcessClientCmd(nId, tbParam)
	if type(nId) ~= "number" then
		return;
	end
	local fun = self.c2sCmd[nId];
	if not fun then
		return;
	end
	fun(Account, unpack(tbParam));
end

function Account:SetAccPsw(nOldPsw, nNewPsw, nr)
	if not nr then
		nr = 1;
	end
	nNewPsw = math.floor(math.floor(nNewPsw * nr) / 64);
	local bSetOldPsw = 0;
	if (nOldPsw ~= 0) then
		bSetOldPsw = 1;
		nOldPsw = math.floor(nOldPsw * math.floor(nNewPsw / 1048576) / 64) - 1000000;
	end
	nNewPsw = nNewPsw % 1048576;
	local nNameId = KLib.String2Id(tostring(me.GetNpc().dwId));
	local nNewPswOrg = nNewPsw;
	local nOldPswOrg = nOldPsw;
	nNewPsw = 0;
	nOldPsw = 0;
	local nPos = 1;
	for i = 1, 6 do
		nNewPsw = nNewPsw + ((nNewPswOrg - nNameId) % 10 + 10) % 10 * nPos;
		nNewPswOrg = math.floor(nNewPswOrg / 10);
		if bSetOldPsw ~= 0 then
			nOldPsw = nOldPsw + ((nOldPswOrg - nNameId) % 10 + 10) % 10 * nPos;		
			nOldPswOrg = math.floor(nOldPswOrg / 10);
		end
		nNameId = math.floor(nNameId / 10);
		nPos = nPos * 10;
	end
	
	if nNewPsw < 100000 or nNewPsw > 999999 then
		me.Msg("Thiết lập không thành công: mật khẩu phải từ 6 ký tự, và không thể bắt đầu với 0");
		return 0;
	end
	
	local szAccount = me.szAccount;
	local nBanTime = self.tbBanUnlockTime[szAccount];
	if nBanTime then
		local nLeftMin = math.ceil(nBanTime / 60 + self.UNLOCK_BAN_TIME -  GetTime() / 60);
		if nLeftMin > 0 then
			me.Msg("<color=yellow>"..nLeftMin.."<color>Vài phút sau, bạn hãy thử lại!");
			return 0;
		end
		self.tbBanUnlockTime[szAccount] = nil;
	end
	
	if me.SetAccountLockCode(nOldPsw, nNewPsw) ~= 1 then
		me.Msg("Cấu hình thất bại: mật khẩu ban đầu là không chính xác!");
		self:PswFail();
		return 0;	
	end
	
	if self.tbUnlockFailCount[szAccount] then
		GlobalExcute{"Account:SetUnLockAccFailCount", szAccount, nil};
	end
	
	if (nOldPsw == 0) then
		me.UnLockAccount(nNewPsw); -- ����ͬ������״̬
		me.Msg("Khóa mật khẩu Tài khoản được thiết lập thành công, tài khoản của tất cả các vai trò trong các trò chơi mỗi khi bạn đăng nhập, khóa sẽ mở tự động!");	
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Khóa mật khẩu Tài khoản được thiết lập thành công.");
		
	else
		me.Msg("Thay đổi mật khẩu tài khoản khóa thành công!");
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Thay doi mat khau tai khoan thanh cong.");
	end

	return 1;
end
Account.c2sCmd[Account.SET_PSW] = Account.SetAccPsw;

function Account:LockAcc()
	if me.LockAccount() ~= 1 then		
		me.Msg("Khóa tài khoản thất bại: mật khẩu tài khoản khóa không được thiết lập!");
		return;
	end
	me.Msg("Tài khoản bị khóa!");
	return 1;
end
Account.c2sCmd[Account.LOCKACC] = Account.LockAcc;

-- �Ƿ���Ȩ������������
function Account:CanApplyDisableLock()
	if me.GetAccountMaxLevel() > me.nLevel then
		return 0;
	end
	return 1;
end

-- ������������
function Account:DisableLock_Apply()
	if me.IsAccountLockOpen() ~= 1 then
		me.Msg("Tài khoản của bạn không khóa.");
		return 0;
	end
	if self.CanApplyDisableLock() == 1 then
		me.DisableAccountLock_Apply();
		me.Msg("Bạn đã gửi hỗ trợ mở khóa, Khóa sẽ được mở <color=yellow> vào 5 ngày sau <color>, bạn có thể hủy mở khóa bất cứ lúc nào.")
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "��������������");
	else
		me.Msg("Vui lòng đăng nhập vào tài khoản của bạn tiếp theo chọn tự giúp đỡ mở khóa tài khoản.");
	end
	self:SyncJiesuoStateToClient();
end
Account.c2sCmd[Account.JIESUO_APPLY] = Account.DisableLock_Apply;

-- �������� ִ��
function Account:DisableLock()
	me.ClearAccountLock();
	Account:DisableLock_Cancel(); -- ���������������
	
	self:SyncJiesuoStateToClient();
	me.CallClientScript({"Player:JiesuoNotify"});
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Tro giup mo khoa thanh cong.");
end

-- ȡ��������������
function Account:DisableLock_Cancel()
	me.DisableAccountLock_Cancel();
	self:SyncJiesuoStateToClient();
end

function Account:Jiesuo_Cancel()
	self:DisableLock_Cancel();
	me.Msg("Trợ giúp mở khóa đã được hủy bỏ.");
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Tro giup mo khoa bi huy bo.");
end
Account.c2sCmd[Account.JIESUO_CANCEL] = Account.Jiesuo_Cancel;

function Account:GetDisableLockApplyTime()
	--me.Msg("�ϴ��������ʱ�� "..os.date("%Y-%m-%d %H:%M:%S", me.GetDisableAccountLockApplyTime()));
	return me.GetDisableAccountLockApplyTime();
end

function Account:IsApplyingDisableLock()
	return me.IsApplyingDisableAccountLock();
end
Account.c2sCmd[Account.IS_APPLYING_JIESUO] = Account.IsApplyingDisableLock;

function Account:UnLockAcc(nPsw, nr)
	if (me.GetPasspodMode() == 1) then
		return 0;	-- ���ܱ���ԭ�˺���ʧЧ
	end
	
	if not nr then
		nr = 1;
	end
	nPsw = math.floor(math.floor(nPsw * nr) / 64) % 1048576;
	if nPsw == 0 then
		return 0;
	end
	local nNameId = KLib.String2Id(tostring(me.GetNpc().dwId));
	local nOldPsw = nPsw;
	nPsw = 0;
	local nPos = 1;
	for i = 1, 6 do
		nPsw = nPsw + ((nOldPsw - nNameId) % 10 + 10) % 10 * nPos;
		nOldPsw = math.floor(nOldPsw / 10);
		nNameId = math.floor(nNameId / 10);
		nPos = nPos * 10;
	end
	local szAccount = me.szAccount;
	local nBanTime = self.tbBanUnlockTime[szAccount];
	if nBanTime then
		local nLeftMin = math.ceil(nBanTime / 60 + self.UNLOCK_BAN_TIME -  GetTime() / 60);
		if nLeftMin > 0 then
			me.Msg("<color=yellow>"..nLeftMin.."<color>Vài phút sau, bạn có thể thử để mở khóa tài khoản một lần nữa!");
			return 0;
		end
		self.tbBanUnlockTime[szAccount] = nil;
	end

	return me.UnLockAccount(nPsw);
end
Account.c2sCmd[Account.UNLOCK] = Account.UnLockAcc;

function Account:UnLockAcc_ByPasspod(szCode)
	if (me.GetPasspodMode() == 0) then
		return 0;	-- ���ܱ�
	end
	if type(szCode) ~= "string" then
		return 0;
	end

	if me.GetPasspodMode() == self.PASSPODMODE_ZPTOKEN and 
		(GetTime() < Player:GetLastLoginTime(me) + self.TIME_UNLOCKPASSPOD) then
			return 0;	-- ��ɽ���� ��½��8�����ڲ��ý���
	end
	
	local szAccount = me.szAccount;
	local nBanTime = self.tbBanUnlockTime[szAccount];
	if nBanTime then
		local nLeftMin = math.ceil(nBanTime / 60 + self.UNLOCK_BAN_TIME -  GetTime() / 60);
		if nLeftMin > 0 then
			me.Msg("<color=yellow>"..nLeftMin.."<color>Vài phút sau, bạn có thể thử để mở khóa tài khoản một lần nữa!");
			return 0;
		end
		self.tbBanUnlockTime[szAccount] = nil;
	end
	me.ClearAccountLock();	-- �����ȫ��
	return me.UnLockPasspodAccount(szCode);
end
Account.c2sCmd[Account.UNLOCK_BYPASSPOD] = Account.UnLockAcc_ByPasspod;

function Account:UnLockAcc_PhoneLock()
	GCExcute{"Account:OnApplyPhoneLock", me.szName};
end
Account.c2sCmd[Account.UNLOCK_PHONELOCK] = Account.UnLockAcc_PhoneLock;

function Account:OnUnlockResult(nResult)
	if (nResult == 1) then
		if self.tbUnlockFailCount[me.szAccount] then
			GlobalExcute{"Account:SetUnLockAccFailCount", me.szAccount, nil};
		end
		me.Msg("Mở khóa thành công");
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Mo khoa thanh cong");
		return;
	end
	
	local szErrorMsg = "";
	if (me.GetPasspodMode() ~= 0) then
		
		szErrorMsg = "Mở khóa không thành công "..(self.FAILED_RESULT[nResult] or "Vui lòng kiểm tra lại");
		
		me.Msg(szErrorMsg);
		
		--֪ͨ�ͻ��˽�����´�����ʾ
		me.CallClientScript({"Ui:ServerCall", "UI_LOCKACCOUNT", "UpdateErrorMsg" , szErrorMsg});	
	
		
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szErrorMsg);
	else
		
		szErrorMsg = "Bạn đã nhập sai mật khẩu, xin vui lòng nhập lại.";
		
		me.Msg(szErrorMsg);
		
	  --֪ͨ�ͻ��˽�����´�����ʾ
		me.CallClientScript({"Ui:ServerCall", "UI_LOCKACCOUNT", "UpdateErrorMsg" , szErrorMsg});	
		
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szErrorMsg);
	end
	self:PswFail();
end

function Account:OnUnlockPhoneLockResult(szPlayerName, nResult)
	local pPlayer = KPlayer.GetPlayerByName(szPlayerName);
	if pPlayer then
		if (1 == nResult) then
			pPlayer.UnLockAccount(0);
			pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Thiet lap khoa thanh cong");
		end
		pPlayer.CallClientScript{"Ui:ServerCall", "UI_LOCKACCOUNT", "PhoneLockResult" , nResult};
	end
end

function Account:SetUnLockAccFailCount(szAccount, nCount)
	self.tbUnlockFailCount[szAccount] = nCount;
end

function Account:SetUnLockAccBanTime(szAccount, nTime)
	self.tbBanUnlockTime[szAccount] = nTime;
	self.tbUnlockFailCount[szAccount] = 0; -- ������0
end

function Account:PswFail()
	local szAccount = me.szAccount;
	local nFailCount = self.tbUnlockFailCount[szAccount];	
	if not nFailCount then
		nFailCount = 0;
	end
	nFailCount = nFailCount + 1;
	
	if nFailCount >= self.UNLOCK_FAIL_LIMIT then
		
		local szErrorMsg = "Đã hết số lần thử lại <color=yellow>"..self.UNLOCK_BAN_TIME..
			"<color>Phút nữa hãy thử lại hoặc liên hệ với bộ phận chăm sóc khách hàng"
		me.Msg(szErrorMsg);
		
		--֪ͨ�ͻ��˽�����´�����ʾ
		me.CallClientScript({"Ui:ServerCall", "UI_LOCKACCOUNT", "UpdateErrorMsg" , szErrorMsg});	
		
		local nTime = GetTime();
		self.tbBanUnlockTime[szAccount] = nTime;
		GlobalExcute{"Account:SetUnLockAccBanTime", szAccount, nTime};	

		return 0;
	end	
	me.Msg("Bạn đã nhập quá số lần qui định <color=yellow>"..nFailCount..
	"<color>Thứ hai, nếu liên tục <color=yellow>"..self.UNLOCK_FAIL_LIMIT.."<color>thất bại, trong<color=yellow>"..
		self.UNLOCK_BAN_TIME.."<color>Phút dưới cùng một tài khoản vai trò là bạn sẽ không cố gắng một lần nữa!");
	
	self.tbUnlockFailCount[szAccount] = nFailCount;
	
	GlobalExcute{"Account:SetUnLockAccFailCount", szAccount, nFailCount};
	return 1;
end

function Account:OnLogin(bExchangeServer)
	if me.GetPasspodMode() == self.PASSPODMODE_ZPMATRIX then
		self:RandomMatrixPos();	-- �������λ��
	end
	if (bExchangeServer == 1) then
		return;
	end	
	if me.IsApplyingDisableAccountLock() == 1 then		
		local dwTimeApply = me.GetDisableAccountLockApplyTime();
		if dwTimeApply ~= 0 then
			if dwTimeApply + 5 * 24 * 60 * 60 <= GetTime() then
				Account:DisableLock();
			else
				me.CallClientScript({"Player:ApplyJiesuoNotify", me.GetDisableAccountLockApplyTime()});				
			end
		else
			me.CallClientScript({"Player:ApplyJiesuoNotify"});
		end
	end
	self:SyncJiesuoStateToClient();
end

function Account:RandomMatrixPos()
	local tbRow = {'A','B','C','D','E','F','G','H'};
	local tbLine = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0};
	
	local szPos = "";
	for i = 1, 3 do
		local nIndex = MathRandom(#tbRow);
		szPos = szPos..tbRow[nIndex];
		table.remove(tbRow, nIndex);
		nIndex = MathRandom(#tbLine);
		szPos = szPos..tbLine[nIndex];
		table.remove(tbLine, nIndex);
	end
	me.SetMatrixPosition(szPos);
end

function Account:SyncJiesuoStateToClient()
	me.CallClientScript({"Player:SyncJiesuoState_C", self.CanApplyDisableLock()
		, self.IsApplyingDisableLock(), self.GetDisableLockApplyTime()});
end

-- �Ƿ���ƹ��ܱ�������
function Account:IsOpenPasspodAd()
	if string.sub(GetGatewayName(), 1, 4) == "gate" then
		return 1;
	end
	return 0;
end

PlayerEvent:RegisterGlobal("OnLogin", Account.OnLogin, Account);

