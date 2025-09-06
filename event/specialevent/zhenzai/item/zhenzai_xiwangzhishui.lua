-- �ļ�������zhenzai_xiwangzhishui.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2010-04-15 17:58:38
-- ��  ��  ��ϣ��֮ˮ(��Ը�ı���Ʒ)

local tbItem 	= Item:GetClass("zhenzai_wish");
SpecialEvent.ZhenZai = SpecialEvent.ZhenZai or {};
local ZhenZai = SpecialEvent.ZhenZai or {};
tbItem.nTransferTime =  Env.GAME_FPS * 5;		--����ʱ��

function tbItem:OnUse()
	local nData = tonumber(GetLocalDate("%Y%m%d"));
	if nData < ZhenZai.VowTreeOpenTime or nData > ZhenZai.VowTreeCloseTime then	--��ڼ���
		Dialog:Say("���ڻ�����ʹ�ã����ǰ���ϣ��֮ˮ����Ϊ��������һ���Լ�������ɣ�", {"֪����"});
		return;
	end
	if me.nLevel < ZhenZai.nLevel  then
		Dialog:Say(string.format("���ĵȼ�����%s��������ʹ��������ߣ�", ZhenZai.nLevel),{"֪����"});
		return;
	end	
	Dialog:Say("�������ϣ��֮ˮ�����Ե��ٰ�����ƽ����Ϊ����������Ը��������Ϊ��������������ף������",
			{"��ѯĿǰƽ�����ϵ�Ը����", self.View, self},
			{"���͵�ƽ����", self.Transfer, self, 0},
			{"��������"}
			);
end

--�鿴��Ը���ϵ�Ը������
function tbItem:View()
	local nCount = KGblTask.SCGetDbTaskInt(DBTASD_EVENT_ZHENZAI_VOWNUM);
	Dialog:Say(string.format("��ǰƽ�����ϵ�Ը������Ϊ��<color=yellow>%s<color>", nCount),{"֪����"});
end

--����
function tbItem:Transfer(nFlag)
	--ֻ����(city��faction��village��fight)��ͼ����
	local nPlayerMapId, nPosX, nPosY = me.GetWorldPos();	
	local szMapType = GetMapType(nPlayerMapId);
	if not ZhenZai.tbTransferCondition[szMapType] then
		me.Msg("�˴�����ʹ�ø���Ʒ���ͣ�")
		return;
	end
	
	if nFlag == 1 then
		self:TransferEx();
		return;
	end
	
	local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,		
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
	}
		
	GeneralProcess:StartProcess("����", self.nTransferTime, {self.Transfer, self, 1}, nil, tbEvent);
end

--�����ɹ�newworld
function tbItem:TransferEx()
	me.NewWorld(unpack(ZhenZai.tbVowTreePosition));
end

function tbItem:InitGenInfo()
	-- �趨��Ч����
	local nSec = Lib:GetDate2Time(ZhenZai.nOutTime)
	it.SetTimeOut(0, nSec);
	return	{ };
end
