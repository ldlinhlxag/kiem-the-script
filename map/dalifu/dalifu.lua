-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(28); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �������˷��䡿---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_duanzhixing")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(165,1609,3666)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;


-------------- �����ʺ󷿼䡿---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_daohuanghou")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	   me.NewWorld(165,1724,3663)	-- ����,[��ͼId,����X,����Y]	
	   me.SetFightState(0)
	
end;


-------------- ����ѩ���䡿---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_luoxue")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()	
	me.NewWorld(165,1836,3665)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

-------------- ����ɣ�����䡿---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_qiaosangzi")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()	
	me.NewWorld(165,1946,3654)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;


-------------- �����������䡿---------------
local tbTestTrap5	= tbTest:GetTrapClass("to_xiaoguifei")

-- �������Trap�¼�
function tbTestTrap5:OnPlayer()	
	me.NewWorld(165,1950,3494)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;



-------------- ���ܵ�===�������19�š�---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_dalimidao")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	
local task_value = me.GetTask(1024,14)
	if (task_value == 1) then 
		me.NewWorld(216,1770,3734)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1)
		return;
	else
	   return;
	end		
end;

-------------- ������ʹ���---------------
local tbTestTrap7	= tbTest:GetTrapClass("to_huanggong")

-- �������Trap�¼�
function tbTestTrap7:OnPlayer()	
	me.NewWorld(819,1578,3243)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;
