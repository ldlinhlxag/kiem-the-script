
-- ���ߣ�����������������

-- ��������ö�٣�ע�Ᵽ��������һ����
local REQ_STR		= 1;				-- ��������
local REQ_DEX		= 2;				-- ������
local REQ_VIT		= 3;				-- �⹦����
local REQ_ENG		= 4;				-- �ڹ�����
local REQ_LEVEL		= 5;				-- �ȼ�����
local REQ_FACTION	= 6;				-- ��������
local REQ_SERIES	= 7;				-- ��������
local REQ_SEX		= 8;				-- �Ա�����

Item.REQ_DESC_TABLE =
{
	[REQ_STR]		= function(nValue)
		return	"��������"..tostring(nValue).."��";
	end,
	[REQ_DEX]		= function(nValue)
		return	"������"..tostring(nValue).."��";
	end,
	[REQ_VIT]		= function(nValue)
		return	"�⹦����"..tostring(nValue).."��";
	end,
	[REQ_ENG]		= function(nValue)
		return	"�ڹ�����"..tostring(nValue).."��";
	end,
	[REQ_LEVEL]		= function(nValue)
		return	"�ȼ�����"..tostring(nValue).."��";
	end,
	[REQ_FACTION]	= function(nValue)
		local szFaction = Player.FACTION_NAME[nValue];
		if (not szFaction) then
			szFaction = "";
		end
		return "��������"..szFaction;
	end,
	[REQ_SERIES]	= function(nValue)
		local szSeries = Env.SERIES_NAME[nValue];
		if (not szSeries) then
			szSeries = "";
		end
		return "������������"..szSeries;
	end,
	[REQ_SEX]		= function(nValue)
		local szSex = Env.SEX_NAME[nValue];
		if (not szSex) then
			szSex = "";
		end
		return "�Ա�����"..szSex;
	end,
};

function Item:GetRequireDesc(nReqAttrib, nValue)
	local fProc = self.REQ_DESC_TABLE[nReqAttrib];
	if (not fProc) then
		return	"";
	end
	return	fProc(nValue);
end
