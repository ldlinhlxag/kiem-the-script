-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(535); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)

end;

		
-------------- ���뿪��·���----28ȥ���⡿ ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit535")

function tbTestTrap1:OnPlayer()
		me.NewWorld(104,1793,3526)	-- ����,[��ͼId,����X,����Y]
		me.SetFightState(1);	
end;
