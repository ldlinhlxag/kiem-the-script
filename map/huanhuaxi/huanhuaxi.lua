-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(90); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ����������---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_danqingsheng")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(510,1605,3189)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- �������ȡ� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_mayigu")

function tbTestTrap2:OnPlayer()	
	me.NewWorld(511,1579,3224)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(0)	
end;

