print("begin load vfactory.lua")

if (not VFactory.tbDefault ) then
	VFactory.tbDefault = {};
end	

VFactory.tbClass={}		-- ���tbClass[szClassName]=Class
VFactory.tbMapClass={}
VFactory.bInit = false;

--��ȡszClassNameָ����
function VFactory:LoadFile(szFileName)	
	if (self.bInit == true) then
		return
	end
	
	print("begin load vfactory.txt");
	
	local tbFileData = KLib.LoadTabFile(szFileName);
	for  nRow = 2, #tbFileData do
		local szBaseClass = tbFileData[nRow][1];
		local szDerivedClass = tbFileData[nRow][2];
	
		--��������
		local tbBaseClass = self.tbClass[szBaseClass];
		if (not tbBaseClass) then
			tbBaseClass = Lib:NewClass(self.tbDefault);
			self.tbClass[szBaseClass]	= tbBaseClass;
		end
		
		--����������
		local tbDerivedClass = self.tbClass[szDerivedClass];
		if (not tbDerivedClass) then
			tbDerivedClass = Lib:NewClass(tbBaseClass);
			self.tbClass[szDerivedClass] = tbDerivedClass;
		end
		
		--����ӳ���
		if (not self.tbMapClass[szBaseClass]) then
			self.tbMapClass[szBaseClass] = tbDerivedClass;
		end		
	end	
	
	self.bInit = true;
end	

function VFactory:GetClass(szClassName)
	self:LoadFile("\\setting\\scriptvalue\\vfactory.txt");
	local tbClass = self.tbClass[szClassName];
	if (not tbClass) then
		self.tbClass[szClassName] = {};
		tbClass = self.tbClass[szClassName];
	end
	return tbClass
end

--���ݻ������ͣ�������ǰ�汾�Ķ���
function VFactory:New(szClassType)
	self:LoadFile("\\setting\\scriptvalue\\vfactory.txt");
	local tbClass = self.tbMapClass[szClassType];
	if (not tbClass) then
		print("����\\setting\\scriptvalue\\vfactory.txt �ļ��м��뵱ǰ�汾��");
		return
	end
	return tbClass
end	
