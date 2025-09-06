-- �ļ�������gbwlls_switch.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-12-16 11:15:59
-- ������  ������������أ������������һ�����ϵķ�����������3�������������ſ�����һ����������

--�������͸�ȫ�ַ��Լ���������
function GbWlls:RegOnConnectGbServer(nConnect)
	local szGateway = GetGatewayName();
	local nSession = Wlls:GetMacthSession();
	GC_AllExcute({"GbWlls:Gb_GetServerConnect", szGateway, nSession});
end

function GbWlls:Gb_GetServerConnect(szGateway, nSession)
	GbWlls.tbZoneServer = GbWlls.tbZoneServer or {};
	GbWlls.tbZoneServer[szGateway] = nSession;

	if GbWlls.IsOpen ~= 1 then
		return 0;
	end

	local nOpenFlag = self:GetGblWllsOpenState();
	if (nOpenFlag > 0) then
		return 0;
	end

	local nZoneServerCount = ServerEvent:GetZoneServerCount(szGateway)
	if nZoneServerCount <= 1 then
		return 0;
	end
	local nOpenSession = 0;
	for _, nSession in pairs(self.tbZoneServer) do
		if nSession > 3 then
			nOpenSession = nOpenSession + 1;
		end
	end
	if nOpenSession*2 >= nZoneServerCount then
		--���ÿ������������־ todo
		self:SetGblWllsOpenState(1);
	end
end

if not GLOBAL_AGENT and MODULE_GC_SERVER then
GCEvent:RegisterConnectGBGCServerFunc({"GbWlls:RegOnConnectGbServer"})
end
