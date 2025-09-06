-------------------------------------------------------
-- �ļ�������changelive.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-03-18 14:18:57
-- �ļ�����������ת�����ͻ��˽��ܹ���
-- ������ƣ�1. ���������ķ�Χ��2. ֻ��1��С�ſ����콱��3. �����ȼ�
-- ������ƣ�4. ��������5. ��ֵ�������޸ģ�6. ����ʱ��仯��7.���Ӹ�������
-- ������ƣ�8. �ڶ�������ת���� 2009-5-15
-------------------------------------------------------

-- ���彣��ת������������¼�
local tbChangeLive = {};
SpecialEvent.ChangeLive = tbChangeLive;

-- "\\setting\\player\task_def.txt" �����������һ��������
tbChangeLive.TASKGID = 2084;				-- ����ת��������
tbChangeLive.TIME_BEGIN = 200906052400;		-- ���ʼʱ��
tbChangeLive.TIME_END = 200906152400;		-- �����ʱ��

tbChangeLive.TASK_CHANGELIVE_AWARD = 1;		-- ��ȡ�������
tbChangeLive.TASK_CHANGELIVE_VALG = 2;		-- �ۼư󶨼�ֵ��
tbChangeLive.TASK_CHANGELIVE_VALS = 3;		-- �ۼƷǰ󶨼�ֵ��

tbChangeLive.TASK_CHANGELIVE_MONEY_S = 4;	-- �ǰ�����
tbChangeLive.TASK_CHANGELIVE_COIN_G = 5;	-- �󶨽��
tbChangeLive.TASK_CHANGELIVE_MONEY_G = 6;	-- ������

tbChangeLive.IS_AWARDED_EXT_POINT = 7;		-- ʹ��7����չ��(ǧλ)

tbChangeLive.REQUIRE_SPACE = 1;				-- ��Ҫ���ٱ����ռ�
tbChangeLive.DEF_ITEM = {18, 1, 312, 1};	-- Ǯ����item���

-- ����ת������ֵ�����ܱ�
tbChangeLive.INPUT_FILE_PATH = "\\setting\\event\\changelive\\jstran_accvalsum.txt";
-- ת���ɹ��Ľ����˺ű�
tbChangeLive.OUPUT_FILE_PATH = "\\..\\jstran_success.txt";

-- �ڶ���ת��������
tbChangeLive.INPUT_FILE_PATH_2 = "\\setting\\event\\changelive\\jstran_accvalsum_2.txt";
tbChangeLive.OUPUT_FILE_PATH_2 = "\\..\\jstran_success_2.txt";

-- ����ת��������ʾ
tbChangeLive.tbServerList =
{
	[1] = 1,	-- ��������
	[2] = 2,	-- �׻���ͨ
	[3] = 3,	-- ��ȸ����
	[4] = 4,	-- �������
	[5] = 5,	-- ��ޱ��ͨ
	[6] = 6,	-- ��������
	[7] = 7,	-- �������
}

-- �������ת����
tbChangeLive.tbReform = {};

-- �����
tbChangeLive.bOpen = 1;

function tbChangeLive:_SetState(bOpen)
	self.bOpen = bOpen;
end

function tbChangeLive:_GetState()
	return self.bOpen;
end

-- ������������
function tbChangeLive:Init()
	
	if self:_GetState() ~= 1 then
		return 0;
	end
	
	-- ��ȡ��ֵ�����ܱ�
	local tbMap	= {};
	--local tbInput = Lib:LoadTabFile(self.INPUT_FILE_PATH);
	local tbInput = Lib:LoadTabFile(self.INPUT_FILE_PATH_2);
	
	-- �������򷵻�
	if not tbInput then 
		return 0;
	end	
	
	-- �ж��Ƿ�û����
	if Lib:CountTB(tbInput) < 1 then
		return 0;
	end
	
	-- ��ʼ��������һ��ת����
	for _, tbRow in ipairs(tbInput) do 	 	
	 	tbMap[tbRow["jsAccDatabase"].."_"..string.upper(tbRow["jsAccount"])] = tbMap[tbRow["jsAccDatabase"].."_"..string.upper(tbRow["jsAccount"])] or {};
	 	tbMap[tbRow["jsAccDatabase"].."_"..string.upper(tbRow["jsAccount"])][tbRow["jxServerGroup"].."_"..tbRow["jxAccount"]] 
	 		= {tonumber(tbRow["nAccValG"]), tonumber(tbRow["nAccValS"])};
	end
	
	-- ����ת����
	self.tbReform = tbMap;
end

-- ����ؼ��
function tbChangeLive:CheckState()
	
	if self:_GetState() ~= 1 then
		return 0;
	end
	
	-- �ж��Ƿ�Ϊ�����ӿ�ר��
	local szServer = GetGatewayName();
	local nJsAccDB = tonumber(string.sub(szServer, 5, 6));
	
	if not self.tbServerList[nJsAccDB] then
		return 0;
	end
	
	-- ȡ��ǰ������ʱ��ת������
	local nNowDate = tonumber(GetLocalDate("%Y%m%d%H%M"));

	-- �ж�ʱ��
	if nNowDate < self.TIME_BEGIN or nNowDate > self.TIME_END then
		return 0;
	end
	
	-- �ж��Ƿ�û����
	if not self.tbReform then 
		return 0;
	end
	
	-- �ж��Ƿ�û����
	if Lib:CountTB(self.tbReform) < 1 then
		return 0;
	end

	-- �����
	return 1;
end

-- �����Ի���
function tbChangeLive:OnDialog()
		
	local bOk, szMsg = self:CheckGetAward();
	
	-- �޷���ȡ����
	if bOk ~= 1 then
		
		-- ��ʾ�Ի���
		Dialog:Say(szMsg, {"��֪����"});
		
		-- ֱ�ӷ���
		return;
	end
	
	-- ����ѡ�1. ��ȡ��Ʒ; 2. �һ�Ҫ����
	local tbOpt = {
		{"��ȡ��Ʒ", self.SelectAccount, self},
		{"�һ�Ҫ����"},
	}
	
	local szMsg = string.format("��ӭ�������������ͣ����������������͸��㣬�԰�����ȹ�ǰ�ڵ��ѹء�");
	Dialog:Say(szMsg, tbOpt);
end

function tbChangeLive:CheckAccount()
	
	-- ���ҵ��˺���
	local szAccount = string.upper(me.szAccount);
	
	-- �������ص�����
	local szServer = GetGatewayName();
	
	-- ��ʽΪ"gate0102"֮�࣬����������5-6λ
	local nJsAccDB = tonumber(string.sub(szServer, 5, 6));
	
	-- ����tbServerListת��Ϊ[0-1]��ʽ
	local nServerGroup = self.tbServerList[nJsAccDB];
	
	if not nServerGroup then
		return 0;
	end
	
	-- ������������
	local szIndex = nServerGroup.."_"..szAccount;

	-- ȡƥ���˺ű�
	local tbMap = self.tbReform[szIndex];
	
	-- �������˺��򷵻�0
	if not tbMap then
		return 0;
	end
	
	-- ���ڷ���1�ͱ�
	return 1, tbMap;
end

-- �ж��Ƿ����˺�ת�뽣��������Ӧ�����˺ű�
function tbChangeLive:CheckGetAward()
	
	if self:_GetState() ~= 1 then
		return 0, "�Բ��𣬽���ת������Ѿ��رա�";
	end

	local bOk = self:CheckAccount();
	
	-- �������˺�
	if bOk ~=1 then
		return 0, "�Բ��𣬲�û���κ��˺�����ת�����Ľ��������˺š�";
	end
	
	-- ȡ7����չ��ǧλ��ֵ
	local nPoint = me.GetExtPoint(self.IS_AWARDED_EXT_POINT);
	local nFoo = math.floor(nPoint / 1000);		-- ȡ��
	local nExtPoint = math.mod(nFoo, 10);		-- ȡ����
	
	-- �ж��Ƿ��б��
	if me.GetTask(self.TASKGID, self.TASK_CHANGELIVE_AWARD) ~= 0 then -- ��ɫ��ȡ��
		return 0, "���Ѿ���ȡ���ˣ���Ҫ��ƭ���ˡ�";
	
	 --���Լ���ý�ɫ	
	elseif nExtPoint ~= 0 then 	-- �˺���������ɫ��ȡ����
		return 0, "�Բ��������˺����Ѿ���������ɫ��ȡ���ˡ�";	
	
	-- �Ƿ���1��С��
	elseif me.nLevel > 1 then
		return 0, "�Բ������Ľ�ɫ�ȼ�̫�ߣ��޷���ȡ������";
	end
	
	-- ���˸ý�ɫ������ȡ����
	return 1;
end

function tbChangeLive:SelectAccount()
		
	-- �õ�ת���˺ű�
	local _, tbAccount = self:CheckAccount();
	
	if not tbAccount then 
		return 0;
	end
	
	local szMsg = "";
	local tbOpt = {};	
	
	-- �ж�ת���˺���Ŀ
	local nCount = Lib:CountTB(tbAccount);	
	
	-- ֻ��һ���˺�
	if nCount == 1 then
		szMsg = "����һ���˺�Ҫת������������ȷ�ϡ�";
			
	-- ����˺�
	elseif nCount > 1 then
		szMsg = string.format("���кü����˺Ŷ���Ҫת����������<color=red>������ֻ��ѡ��һ����������ѡ��<color>");
	end
		 	
	-- �Ի����˺��б�**���ﲻ����ipairs
	for szLine, tbRow in pairs(tbAccount) do 
	
		-- �ָ��ַ���
		local nAt = string.find(szLine, "_");
		local szJxAccDB = string.sub(szLine, 1, nAt - 1);
		local szJxAccount = string.sub(szLine, nAt + 1);
		local nServer = math.mod(tonumber(szJxAccDB), 10);
		local nRegion = math.floor(tonumber(szJxAccDB)/10);
		
		-- �����б�
		table.insert(tbOpt, {
			"������<color=yellow> "..nRegion.."��"..nServer.."�� <color>���˺�ת����",
			self.ConfirmAccount, self, tbRow[1], tbRow[2], szJxAccDB, szJxAccount,
			nRegion.."��"..nServer.."��"
			}
		);
	end
	
	-- ����һ��������
	table.insert(tbOpt, {"��������"});
	Dialog:Say(szMsg, tbOpt);
end

-- ȷ��ʹ�øý�ɫ��ȡ����
function tbChangeLive:ConfirmAccount(nAccValG, nAccValS, szJxAccDB, szJxAccount, szTxt)
	
	-- ����һ��ȷ�϶Ի���ͬʱ��ʾ�˺�����
	local szMsg	= string.format("��ȷ��Ҫ�ѽ���<color=yellow> "..szTxt.." <color>���˺�\r\n<color=yellow> "..szJxAccount.." <color>ת����ô��");
	local tbOpt = {
		{"��", self.GetAward, self, nAccValG, nAccValS, szJxAccDB, szJxAccount},
		{"��������"}
	};
	
	Dialog:Say(szMsg, tbOpt);
end

-- ���Ž���������ת���ɹ���
function tbChangeLive:GetAward(nAccValG, nAccValS, szJxAccDB, szJxAccount)
		
	-- ������ǰ���ж�һ�Σ�����Ƿ��ͻ��˽���
	local bOk = self:CheckGetAward();
	
	if bOk ~= 1 then
		return 0;
	end
	
	-- �ж������ռ��Ƿ��㹻
	if me.CountFreeBagCell() < tbChangeLive.REQUIRE_SPACE then
		Dialog:Say("�㱳�����ˣ��Ų��£���"..tostring(tbChangeLive.REQUIRE_SPACE).."��ռ������ɡ�", {"��֪����"});
		return 0
	end

	-- ���Ž������
	local pItem = me.AddItem(unpack(self.DEF_ITEM));
	
	-- ʧ���򷵻�
	if not pItem then
		return 0;
	end
	
	pItem.Bind(1); 	-- ��֮�����ü�ʱ��
	
	-- �󶨲Ƹ�����
	local nExtraValG = self:ExtraValue(tonumber(nAccValG));
	local nCurrValG = tonumber(nAccValG) + tonumber(nExtraValG);

	-- ��ֵ��������������ڽ�ɫ����
	me.SetTask(self.TASKGID, self.TASK_CHANGELIVE_VALG, nCurrValG);
	me.SetTask(self.TASKGID, self.TASK_CHANGELIVE_VALS, tonumber(nAccValS));
	
	-- ��ֵ��ת��
	local nMKP, nGTP, nMoneyG, nMoneyS, nCoinG = self:TransValue(nCurrValG, tonumber(nAccValS));
	
	-- ��¼���������
	me.SetTask(self.TASKGID, self.TASK_CHANGELIVE_MONEY_G, nMoneyG);
	me.SetTask(self.TASKGID, self.TASK_CHANGELIVE_MONEY_S, nMoneyS);
	me.SetTask(self.TASKGID, self.TASK_CHANGELIVE_COIN_G, nCoinG);
	
	-- ����ֱ������
	me.ChangeCurMakePoint(nMKP);
	me.ChangeCurGatherPoint(nGTP);
	
	-- �����ͬ�����Ӿ���Ҫ�Լ�д��ʾ
	me.Msg(string.format("�������<color=yellow>%s<color>�㾫��", nMKP));
	me.Msg(string.format("�������<color=yellow>%s<color>�����", nGTP));

	-- �ɹ���ʾ����
	local szMsg = string.format("��ɹ���ȡ������%s������գ�", pItem.szName);
	
	-- ������ɫ�ȼ�
	self:SetTransLevel();
		
	-- ������չ�㣬���˺�������ɫ������ȡ����
	-- fix a bug...2009-3-26
	me.AddExtPoint(self.IS_AWARDED_EXT_POINT, 1000);
	
	-- ��ɫ������
	me.SetTask(self.TASKGID, self.TASK_CHANGELIVE_AWARD, tonumber(GetLocalDate("%Y%m%d")));
	
	-- make log
	Dbg:WriteLog("SpecialEvent.ChangeLive", "����ת����", me.szAccount, me.szName, 
		"�󶨲Ƹ���"..tonumber(nAccValG), "���󶨲Ƹ���"..tonumber(nAccValS), "�����Ƹ���"..tonumber(nExtraValG));
	
	-- �ͷ�log
	local szLog = "ת�뽣���ɹ�����ð󶨲Ƹ���" .. nAccValG .. "�����󶨲Ƹ���" .. nAccValS .. "�������Ƹ���" .. nExtraValG;
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szLog);
	
	-- ����ת����
	local szOutput = szJxAccount.."\t"..szJxAccDB.."\t\r\n";
	--KIo.AppendFile(self.OUPUT_FILE_PATH, szOutput);
	--GCExcute({"KFile.AppendFile", self.OUPUT_FILE_PATH, szOutput});
	GCExcute({"KFile.AppendFile", self.OUPUT_FILE_PATH_2, szOutput});

	Dialog:Say(szMsg, tbOpt);
end

-- �󶨲Ƹ�����
function tbChangeLive:ExtraValue(nAccValG)
	
	local nBasicFactor = 0;		-- ����Ȩֵ
	local nRoleFactor = 0;		-- ��ɫȨֵ
	local nFixedFactor = 0;		-- �̶�����
	
	local nRoleValG = 0;		-- ��ɫ�Ƹ�
	local nExtraValG = 0;		-- �����Ƹ�
	
	-- �������ȼ�����150��
	if TimeFrame:GetState("OpenLevel150") == 1 then
		
		local nOpenTime = KGblTask.SCGetDbTaskInt(DBTASD_SERVER_STARTTIME);
		local nCurrTime = GetTime();
		
		if nCurrTime - nOpenTime >= 180 * 60 * 60 * 24 then
			nBasicFactor = 40;
			nRoleFactor = 0.5;
			nFixedFactor = 100000;
		else
			nBasicFactor = 30;
			nRoleFactor = 0.4;
			nFixedFactor = 50000;	
		end

	-- �������ȼ�����99��
	elseif TimeFrame:GetState("OpenLevel99") == 1 then
		nBasicFactor = 20;
		nRoleFactor = 0.3;
		nFixedFactor = 30000;
	
	-- �������ȼ�����89��
	elseif TimeFrame:GetState("OpenLevel89") == 1 then
		nBasicFactor = 10;
		nRoleFactor = 0.2;
		nFixedFactor = 20000;
	
	-- �������ȼ�����79��
	elseif TimeFrame:GetState("OpenLevel79") == 1 then
		nBasicFactor = 5;
		nRoleFactor = 0.1;
		nFixedFactor = 10000;
	
	-- �������ȼ�����69����ʲô������
	else
		return 0;
	end
	
	if nBasicFactor > 0 then
		
		-- 4��ʱ��*0.5Сʱ
		me.SetTask(1023, 7, me.GetTask(1023, 7) + nBasicFactor * 0.5 * 10);
		
		-- ������1��
		Task.tbPlayerPray:AddCountByLingPai(me, nBasicFactor);
		
		-- ��������10
		me.SetTask(2013, 4, me.GetTask(2013, 4) + nBasicFactor * 10);
		
		-- ����ʹ�ø���5
		me.SetTask(2024, 20, me.GetTask(2024, 20) + nBasicFactor * 5);
		me.SetTask(2024, 21, me.GetTask(2024, 21) + nBasicFactor * 5);
		
		-- ��������3
		me.AddKinReputeEntry(nBasicFactor * 3);
	end
	
	nRoleValG = nAccValG * nRoleFactor;
	
	if nRoleValG > 20000 then
		nRoleValG = 20000;
	end
	
	nExtraValG = nRoleValG + nFixedFactor;
	
	return nExtraValG;
end

-- ��ֵ��ת������Ӧ�ľ����𡢰���������
function tbChangeLive:TransValue(nAccValG, nAccValS)

	local nMKP, nGTP, nMoneyG, nMoneyS, nCoinG;
	
	-- �ǰ󶨼�ֵ
	if nAccValS > 32000 then		
		nMKP = 100000; -- 10����
		nGTP = 100000; -- 10�����
		nMoneyS = 2400000 + (nAccValS - 32000) * 150 
		
	elseif nAccValS > 0 then		
		nMKP = nAccValS * 3.125;
		nGTP = nAccValS * 3.125;
		nMoneyS = nAccValS * 75;
		
	else -- ����������������һ��..
		nMKP = 0;
		nGTP = 0;
		nMoneyS = 0;	
	end
	
	-- �󶨼�ֵ
	if nAccValG > 0 then
		nCoinG = nAccValG * 0.8;
		nMoneyG = nAccValG * 40;
	else
		nCoinG = 0;
		nMoneyG = 0;
	end
		
	-- STR to INT
	return 
		math.floor(tonumber(nMKP)), 
		math.floor(tonumber(nGTP)), 
		math.floor(tonumber(nMoneyG)), 
		math.floor(tonumber(nMoneyS)), 
		math.floor(tonumber(nCoinG));
end

-- ����ת����ɫ�ȼ���Ϊ���������ŵȼ�ǰһ����
function tbChangeLive:SetTransLevel()
	
	-- ���ж�һ��
	if me.nLevel > 1 then
		return;
	end
	
	-- �������ȼ�����150��
	if TimeFrame:GetState("OpenLevel150") == 1 then
		me.AddLevel(99-me.nLevel);
		return;
	end
	
	-- �������ȼ�����99��
	if TimeFrame:GetState("OpenLevel99") == 1 then
		me.AddLevel(89-me.nLevel);
		return;
	end
	
	-- �������ȼ�����89��
	if TimeFrame:GetState("OpenLevel89") == 1 then
		me.AddLevel(79-me.nLevel);
		return;
	end
	
	-- �������ȼ�����79��
	if TimeFrame:GetState("OpenLevel79") == 1 then
		me.AddLevel(69-me.nLevel);
		return;
	end
	
	-- 69�����޾���1��
end

-- �ű����س�ʼ��
tbChangeLive:Init();
