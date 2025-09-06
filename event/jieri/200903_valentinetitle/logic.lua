local tbValentineTitle = {};
SpecialEvent.ValentineTitle2009 = tbValentineTitle;

tbValentineTitle.tbLovers = {
	{"04","ɲ��ħ��ʦ"},
	{"04","���ٵ�ǧ�꡿"},
	{"04","��ǹ������"},
	{"04","ůů��С��"},
	{"04","��ѩ����"},
	{"04","Ư�ݷƶ�"},
	{"06","��Ű���"},
	{"06","���С��"},
	{"02","���c�c��"},
	{"02","С���߶߹�"},
	{"05","�m�����f"},
	{"05","�m����"},
	{"03","����һ����ү"},
	{"03","������z��"},
	{"04","ح��å��حؼɨ��"},
	{"04","������ħŮ��"},
};

function tbValentineTitle:CanGetTitle(pPlayer)
	if tonumber(GetLocalDate("%Y%m%d")) >= 20090323 then
		return 0;
	end
	
	local szGatewayName = string.sub(GetGatewayName(),5,6);
	for _, tb in ipairs(self.tbLovers) do
		if tb[1] == szGatewayName and tb[2] == pPlayer.szName then
			return 1;
		end
	end
	return 0;
end

function tbValentineTitle:GetTitle(pPlayer)
	local tbTitle = {[0] = {6,3,1,0},[1] = {6,3,2,0}};
	
	if pPlayer.FindTitle(unpack(tbTitle[pPlayer.nSex])) == 0 then
		pPlayer.AddTitle(unpack(tbTitle[pPlayer.nSex]));
		SpecialEvent:WriteLog(Dbg.LOG_INFO, "tbValentineTitle:GetTitle", pPlayer.szName);
	else
		Dialog:Say("���Ѿ�����ˡ�");
	end
end

-- ?pl DoScript("\\script\\event\\jieri\\200903_valentinetitle\\logic.lua")