-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(819); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ش�����---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_dalifu")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	   me.NewWorld(28,1767,3302);	-- ����,[��ͼId,����X,����Y]	
	   me.SetFightState(0);
	
end;

-------------- ���ʹ���԰��---------------
local tbTestTrap2	= tbTest:GetTrapClass("to_houyuan")

-- �������Trap�¼�
function tbTestTrap2:OnPlayer()	
	   me.NewWorld(820,1611,3226);	-- ����,[��ͼId,����X,����Y]	
	   me.SetFightState(0);	
end;
