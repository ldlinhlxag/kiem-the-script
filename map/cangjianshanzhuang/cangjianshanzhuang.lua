-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(477); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("cangjian")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(477,1689,3030);
	TaskAct:Talk("δ���˵�������ɣ����˲��ý����Ժ��");
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;
