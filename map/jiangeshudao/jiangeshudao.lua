-- Map �����ӼӲ���
-- ��ӭɾ����


-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(104); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;


-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ��ȥ·��С��---20�š�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_xinshi")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(539,1605,3189)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;

-------------- ��ȥ��µķ���---��ݡ� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_wude")

function tbTestTrap2:OnPlayer()	
	me.NewWorld(535,1604,3188)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	
end;

-------------- ��ȥ���ر�Ժ---���ص��ˡ� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_tangshi")

function tbTestTrap3:OnPlayer()
	me.NewWorld(536,1527,3126)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1);
end;
		
-------------- ��ȥ��Ժ�����---̽��1-�Ի�-2�� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_tangque")

-- �������Trap�¼�
function tbTestTrap4:OnPlayer()

local task_value = me.GetTask(1024,18)
	
	if (task_value == 1) then 
		me.NewWorld(537,1527,3126)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	else
	    me.NewWorld(538,1527,3126)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(0);
		return;
	end		
end
	

