-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(108); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ��ȥ̫���Ǽ�---26�š�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_taihouluanjia")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(219,1578,3941)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(0);
	
end;


-------------- ��ȥ��������---20�š�---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_zhongyangmishi")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
 
	me.NewWorld(219,1867,3737)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
	
end;


-------------- ��ȥʬ��---29�š�---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_shiyuhua")

-- �������Trap�¼�
function tbTestTrap3:OnPlayer()	
	me.NewWorld(219,1861,3954)	-- ����,[��ͼId,����X,����Y]	
end;

