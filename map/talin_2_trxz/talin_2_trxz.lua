-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(444); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("jgl2talin")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(66,1630,3574);	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);	

end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;