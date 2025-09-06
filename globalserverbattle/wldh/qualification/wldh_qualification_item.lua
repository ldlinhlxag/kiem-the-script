-------------------------------------------------------
-- �ļ�������wldh_qualification_item.lua
-- �����ߡ���zhangjinpin@kingsoft
-- ����ʱ�䣺2009-09-08 11:52:25
-- �ļ�������
-------------------------------------------------------

Require("\\script\\globalserverbattle\\wldh\\qualification\\wldh_qualification_def.lua");

local tbItem = Item:GetClass("yingxiongtie");

function tbItem:OnUse()
	
	-- �ж��ܷ�ʹ��
	if self:CheckUse(me) ~= 1 then
		return 0;
	end
	
	local nCount = me.GetTask(Wldh.Qualification.TASK_GROUP_ID, Wldh.Qualification.TASK_YINXIONGTIE);
	local nCurCount = nCount + 1;
	
	-- ʹ�ú󣬸���Ӣ�������а�
	PlayerHonor:SetPlayerHonorByName(me.szName, PlayerHonor.HONOR_CLASS_PRETTYGIRL, 0, nCurCount);
	me.SetTask(Wldh.Qualification.TASK_GROUP_ID, Wldh.Qualification.TASK_YINXIONGTIE, nCurCount);
	
	me.Msg(string.format("Ӣ����ʹ�óɹ������Ѿ�����<color=yellow>%d<color>��Ӣ������", nCurCount));
	
	-- ������ʧ
	return 1;
end

function tbItem:CheckUse(pPlayer)
	
	if Wldh.Qualification:CheckServer() ~= 1 then
		Dialog:Say("�Բ��������ڵķ��������ܲμ����ִ�ᣬ�޷�ʹ��Ӣ������");
		return 0;
	end
	
	-- �ж��ʸ�
	if Wldh.Qualification:CheckMember(pPlayer) ~= 0 then
		Dialog:Say("�Բ������Ѿ���òμ����ִ����ʸ񣬲���Ҫ��ʹ��Ӣ�����ˡ�");
		return 0;
	end
	
	-- �ж�ʱ��
	local nNowDate = tonumber(GetLocalDate("%Y%m%d%H%M"));
	if nNowDate < Wldh.Qualification.MEMBER_STATE[1] then
		Dialog:Say("�Բ��𣬻�δ���ʱ�䣬����ʹ��Ӣ������");
		return 0;
	end
	
	-- ���⴦��
	if nNowDate > 200909272158 then
		Dialog:Say("�Բ����Ѿ��������һ��������ʱ�䣬�޷���ʹ��Ӣ�����ˡ�");
		return 0;
	end
	
	-- �Ƿ��������
	local nProssession = KGblTask.SCGetDbTaskInt(DBTASK_WLDH_PROSSESSION);
	if nProssession == 0 then
		Dialog:Say("�Բ�����δ�������ִ���ʸ�������������Ժ���ʹ��Ӣ������");
		return 0;
	end
	
	return 1;
end

