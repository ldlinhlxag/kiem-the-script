-------------------------------------------------------------------
--File: 	eventmanager.lua
--Author: sunduoliang
--Date: 	2008-4-15
--Describe:	�����ϵͳ.
--
-------------------------------------------------------------------

function EventManager:scheduletask()
	--ÿ���賿4�����һ��ά��.
	self.EventManager:MaintainGC();
end
