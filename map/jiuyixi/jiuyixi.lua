-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(106); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ��ȥ��̲ʯ������--21�š�---------------
local tbTestTrap	= tbTest:GetTrapClass("to_hanzhongqiushi")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
		
local task_value = me.GetTask(1024,16)
	if (task_value == 2) then 
		return;	
	elseif (task_value == 1) then 
		me.NewWorld(540,1619,3220)	-- ����,[��ͼId,����X,����Y]	
        me.SetFightState(0)
		return;
	else
	   return;
	end		
end

-------------- ��ȥ��̲ʯ��Ǯ���Ϸ�--26�š� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_qianbingchengfang")

function tbTestTrap2:OnPlayer()	
	me.NewWorld(541,1610,3217)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ��ȥ��̲ʯ�����ܷ��ζ���--29�š� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_zhuguanfang")

function tbTestTrap3:OnPlayer()
	me.NewWorld(542,1605,3190)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;
