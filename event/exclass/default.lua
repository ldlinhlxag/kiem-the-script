-------------------------------------------------------------------
--File: 	default.lua
--Author: 	sunduoliang
--Date: 	2008-6-20
--Describe:	�����ϵͳ.��չ������
--InterFace1: self:GetParam(szParam);��û�ñ���szParam���͵����в���������table
--EventManager:GetTask(nTaskId);		--����������
--EventManager:SetTask(nTaskId, nValue);--�����������
--EventManager:GetNpcClass(varNpc);		--���npc��varNpcΪnpcId������npc���ͣ����ͣ���ͨ����Ϊclassname�����������ͣ�_JINGYING:��Ӣ��_SHOULING:���죬_ALLNPC:����npc��
--EventManager:GetNpcClass(varNpc):OnEventDeath(pNpc) --Ϊ�Զ���npc�������ú���

-------------------------------------------------------------------

local tbClass = EventManager:GetClass("default")

function tbClass:OnDialog()
	--�Ի�npc
end

function tbClass:OnUse()
	--ʹ����Ʒ
end

function tbClass:PickUp()
	--ʰȡ��Ʒ
end

function tbClass:IsPickable()
	--�Ƿ�����ʰȡ
end

function tbClass:InitGenInfo()
	--��Ʒ����
	return {};
end

function tbClass:ExeStartFun(tbParam)
	--ִ����ʱ�¼�
end

function tbClass:ExeEndFun(tbParam)
	--ִ����ʱ�¼�����
end

function tbClass:ExeNpcStartFun(tbParam)
	--�к�npcִ�У��ؼ��֣�MapPath��
end

function tbClass:ExeNpcEndFun(tbParam)
	--�к�npcִ�У��ؼ��֣�MapPath��
end
