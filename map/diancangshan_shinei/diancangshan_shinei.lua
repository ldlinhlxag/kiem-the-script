-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(212); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪��Ժս����---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit7")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(98,1826,3260)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)  
end;

-------------- ���뿪��Ժ�Ի��� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit20")

function tbTestTrap2:OnPlayer()	
	me.NewWorld(98,1826,3260)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1)  	
end;

-------------- ���뿪ɽկ�� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_exit18")

function tbTestTrap3:OnPlayer()
		me.NewWorld(98,1826,3694)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1)  	
end;
		
-------------- ���뿪ɽկ�� ---------------
local tbTestTrap4	= tbTest:GetTrapClass("to_exit19")

function tbTestTrap4:OnPlayer()
		me.NewWorld(98,1826,3694)	-- ����,[��ͼId,����X,����Y]	
		me.SetFightState(1)  
end;
