-- �ļ�������tong_vote_npc.lua
-- �����ߡ���zounan
-- ����ʱ�䣺2010-04-01 15:37:34
-- ��  ��  ��
Require("\\script\\event\\specialevent\\tong_vote\\tong_vote_def.lua");
local tbTong = SpecialEvent.Tong_Vote;
tbTong.tbDialogNpc =  tbTong.tbDialogNpc or {};
local tbNpc = tbTong.tbDialogNpc or {};
tbNpc.LEVEL_LIMIT = 60;

function tbNpc:OnDialog()	
	
	if tbTong:IsOpen() ~= 1 then
		Dialog:Say("��ã����ڻ�ڡ�");
		return 0;			
	end
	if me.nLevel < tbTong.LEVEL_LIMIT then
		Dialog:Say("���ĵȼ�����������60���Ժ������ɡ�");
		return 0;
	end
	
	local szMsg = "���ͶƱ";
	local tbOpt = {
			{"�����������ͶƱ��", self.VoteTickets, self},
			{"��ѯ���Ʊ��", self.QueryIntPutName, self},
	--		{"��ȡ��Ů��ѡ����", self.GetAward, self},
	--		{"�˽���ϸ��Ϣ", self.GetDetailInfo, self},
			{"��㿴�����뿪��"},
		};
	Dialog:Say(szMsg, tbOpt);
end


function tbNpc:VoteTickets()
	Dialog:AskString("����������", 16, tbTong.VoteTickets, tbTong);	
end


function tbNpc:QueryIntPutName()
	Dialog:AskString("����������", 16, self.QueryByName, self);	
end

function tbNpc:QueryByName(szName)	
	local tbBuf = tbTong:GetGblBuf();
	if not tbBuf[szName] then
		Dialog:Say("û�иð����Ϣ");
		return 0;
	end
	
	local nTickets = tbBuf[szName].nTickets or 0;
	local szTickets = string.format("Ŀǰ<color=yellow>%s<color>��Ʊ��Ϊ��<color=white>%s<color>",szName, nTickets);
	Dialog:Say(szTickets);
	return;
end
