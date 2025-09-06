
-- ====================== �ļ���Ϣ ======================

-- ���������ȡ����ļ������ű�
-- Edited by peres
-- 2007/03/15 PM 08:44

-- ֻ��������������
-- �����మ
-- ���ǵ�
-- �����ָ�Ħ������Ƥ���ϵ�����
-- ������������Ⱥ������ӹ�
-- ��������������ı���ͷ���
-- ����˯ʱ������ӳ�������
-- ���ǵã��峿���ѹ�����һ�̣������������
-- �������۾��������͸������һ��һ����������
-- ����������Ϊ�Ҹ�����ʹ

-- ======================================================

local tbReadFile = {};

tbReadFile.START_ROW = 2;	-- ���ӵڼ��п�ʼ����Ĭ���� 2��ǰ���ֱ���Ӣ�ĺ����ı�ͷ
tbReadFile.m_szKey = "";	-- �ļ��Ĺؼ���


function tbReadFile:init(szFile)
	if (KFile.TabFile_Load(szFile, szFile) == 0) then
		print("Load table file error: "..szFile);
		return 0;
	end;
	self.m_szKey = szFile;
	return 1;
end;

function tbReadFile:GetRow()
	return KFile.TabFile_GetRowCount(self.m_szKey) - self.START_ROW;
end;

function tbReadFile:GetCell(szCol, nRow)
	local szCell = KFile.TabFile_GetCell(self.m_szKey, nRow + self.START_ROW, szCol);
		if szCell==nil then
			print("Get a empty cell: Col:"..szCol.." Row:"..nRow.." File:"..self.m_szKey);
			return "";
		else
			return szCell;
		end;
end;

function tbReadFile:GetCellInt(szCol, nRow)
	local szCell = KFile.TabFile_GetCell(self.m_szKey, nRow + self.START_ROW, szCol);
		if szCell==nil or szCell=="" then
			print("Get a empty cell: Col:"..szCol.." Row:"..nRow.." File:"..self.m_szKey);
			return -1;
		else
			return tonumber(szCell);
		end;
end;

-- �������ָ�����ڵ������У�����ָ�����ݵ�����
-- ���������data:szData ָ��������
-- ���������string:szCol ָ�����б���
-- ����ֵ��  int:row    ������������
function tbReadFile:GetDateRow(szCol, szData)
	local strType = type(szData) -- ��ȡ��������

	for i=1, self:GetRow() do
		if strType=="number" then
			if self:GetCellInt(szCol, i) == szData then
				return i;
			end;
		else
			if self:GetCell(szCol, i) == szData then
				return i;
			end;
		end;
	end;
	print ("[Error��] tbReadFile:GetDateRow Get row nil!");
	return 0;
end;

function tbReadFile:CountRate(szCol)
	local nRow = self:GetRow();
	local nRandom = 0;
	local nAdd = 0;
	local i=0;

	for i=1, nRow do
		nAdd = nAdd + self:GetCellInt(szCol, i);
	end;

	nRandom = MathRandom(1, nAdd);

	nAdd = 0;

	for i=1, nRow do
		nAdd = nAdd + self:GetCellInt(szCol, i);
		if nAdd>=nRandom then
			return i;
		end;
	end;

	return 0;
end;

function tbReadFile:Release()
	KFile.TabFile_UnLoad(self.m_szKey);
end;

-- ���� Lib ��
Lib.readTabFile = tbReadFile;
