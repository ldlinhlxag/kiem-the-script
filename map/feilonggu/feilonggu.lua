-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(511); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;



-------------- ���뿪�����ȡ� ---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_exit511")

function tbTestTrap2:OnPlayer()	
	me.NewWorld(90,1902,3160)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;

-------------- ��ǰ��������512�� ---------------
local tbTestTrap3	= tbTest:GetTrapClass("to_feilongzhen")

function tbTestTrap3:OnPlayer()

	me.NewWorld(512,1610,3215)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1)	
	
end;
	
