-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(488); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����丮ۡ---1��---------------
local tbTestTrap	= tbTest:GetTrapClass("to_zhuxifu")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()	
	me.NewWorld(487,1554,3119)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;

-------------- ��������---1��---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_mishi")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	local task_value = me.GetTask(1022,140)
	if (task_value == 1) then 	
		me.NewWorld(489,1611,3216)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(0)
		return;
	end
end;
