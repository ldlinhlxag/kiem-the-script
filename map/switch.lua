-------------------------------------------------------------------------
-- Author		:	LuoBaohang
-- CreateTime	:	2005-09-02
-- Desc			:  	��ͼ�л������ű�ͷ�ļ�--��������
-------------------------------------------------------------------------

local tbSwitchs	= Map.tbSwitchs; --���غ������壬ÿ�������涨����ֻ��һ�����ز���(����Ϊ1���˳�Ϊ0)

--״̬����(ǿ��ת��Ϊ����ģʽ,��ֹ�ı�ģʽ,��ֹ��ɱ,��ֹ�ı���Ӫ,��ֹ�д�)
function tbSwitchs:PKMODEL_OFF(bIn)
	if (bIn == 1) then
		me.nPkModel = Player.emKPK_STATE_PRACTISE;
		me.nForbidChangePK	= 1;
		me.ForbidEnmity(1);
		me.ForbidExercise(1);
		me.DisableChangeCurCamp(1);
	else
		me.nForbidChangePK	= 0;
		me.DisableChangeCurCamp(0);
		me.ForbidEnmity(0);
		me.ForbidExercise(0);
	end;
end;

--������Ӳ���
function tbSwitchs:TEAM_ON(bIn)
	if (bIn == 1) then
		if me.IsDisabledTeam() == 1 then
			me.TeamDisable(0);
		end
	end
end

--���鿪��(�뿪����,��ֹ���)
function tbSwitchs:TEAM_OFF(bIn)
	if (bIn == 1) then
		me.LeaveTeam();
		me.TeamDisable(1);
		--me.Msg("��ӹرգ�")
	else
		me.TeamDisable(0);
		--me.Msg("��ӿ�����")
	end;
end;

-- ������
function tbSwitchs:PRAY_OFF(bIn)
	if (bIn == 1) then
		Task.tbPlayerPray:DisablePray(me);
	else
		Task.tbPlayerPray:EnablePray(me);
	end;
end

--���߱���λ��(1������,0���汣��)
function tbSwitchs:LOGINREVOUT_OFF(bIn)
	if (bIn == 1) then
		me.SetLogoutRV(1);
	else
		me.SetLogoutRV(0);
	end;
end;

--�����ͷ�(1�޳ͷ�,0����ͷ�)
function tbSwitchs:PUNISH_OFF(bIn)
	if (bIn == 1) then
		me.SetNoDeathPunish(1);
	else
		me.SetNoDeathPunish(0);
	end;
end;

--ս���ر�״̬(1�����ս��״̬)
function tbSwitchs:FIGHTSTATE_OFF(bIn)
	if (bIn == 1) then
		me.SetFightState(0)
	end;
end;

--ս������(1����ս��״̬)
function tbSwitchs:FIGHTSTATE_ON(bIn)
	if (bIn == 1) then
		me.SetFightState(1)
	end;
end;

--��ԭԭʼ��Ӫ(1,��Ӫ����,0��ԭԭʼ��Ӫ)
function tbSwitchs:RESTORECURCAMP(bIn)
	if (bIn == 1) then
	else
		me.SetCurCamp(GetCamp())
	end;
end;

--��̯�չ�(1,��ֹ��̯���չ�,0��ԭ��̯�չ�)
function tbSwitchs:STALL_OFF(bIn)
	if(bIn == 1) then
		me.DisabledStall(1);
		me.DisableOffer(1);
	else
		me.DisabledStall(0);
		me.DisableOffer(0);
	end;
end;

--���ù���(1.���������,���ù���,����,��ֹ����й�ʱ��) --ע��:�����Լ�ά��,����ʹ�ñ��ӿڽ���.,��ʱʹ��,�Ժ�����
function tbSwitchs:CHAT_OFF(bIn)
	if bIn == 1 then
		me.SetForbidChat(1);
	else
		me.SetForbidChat(0);
	end
end

--����ͼ״̬(�ɰ汾,���ÿ�ɾ��)
function tbSwitchs:TONG_MAP(bIn)
	self:PUNISH_OFF(bIn)
	self:RESTORECURCAMP(bIn)
	self:STALL_OFF(bIn)
	if (bIn == 1) then
		me.SetTmpDeathPos(SubWorldIdx2ID(SubWorld),aRevPos.x * 32,aRevPos.y * 32)
	else
		me.SetRevivePos(me.GetRevivePos())
	end;
	--��ͼ�����ӳ�
	if (bIn == 1 and GetMapType(SubWorld) == 1)then
		local nTongID = GetMapParam(SubWorld, 0)
		if (nTongID ~= 0)then
			local _,b = me.GetTongName()
			if (b ~= nTongID and TONG_GetTongMapBan(nTongID) == 1)then
				local pos = GetMapEnterPos(SubWorldIdx2MapCopy(SubWorld))
				me.SetFightState(0)
				SetPos(pos.x, pos.y)
			end;
		end;
	end;
end;
