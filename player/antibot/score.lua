-- �ļ�������score.lua
-- �����ߡ���houxuan
-- ����ʱ�䣺2008-12-22 08:54:39

Require("\\script\\player\\antibot\\antibot.lua");

local tbScore = Player.tbAntiBot.tbScore or {};
Player.tbAntiBot.tbScore = tbScore;

tbScore.tbItemList = {
		
	};

--ע��һ���µĴ����Ŀ
function tbScore:RegisterNewItem(nId, obj, szItemName, fnAddScore, fnGetScore, fnClear, fnLogMsg)
	if ((not obj) or (not szItemName) or (not fnAddScore) or (not fnGetScore) or (not fnClear) or (not fnLogMsg)) then
		return 0;
	end
	local tbOne = self.tbItemList[szItemName];
	if (tbOne) then
		Dbg:Output("Player", string.format("%s is already exist.", szItemName));
		return 0;
	end
	tbOne = {};
	tbOne.nId = nId;
	tbOne.obj = obj;
	tbOne.fnAddScore = fnAddScore;
	tbOne.fnGetScore = fnGetScore;
	tbOne.fnClear = fnClear;
	tbOne.fnLogMsg = fnLogMsg;
	self.tbItemList[szItemName] = tbOne;
	return 1;
end

--������еĴ�ֽ��
function tbScore:ClearAllScore(pPlayer)
	for key, tbOne in pairs(self.tbItemList) do
		local s = tbOne.fnClear(tbOne.obj, pPlayer, tbOne.nId);
	end
	pPlayer.SetTask(Player.tbAntiBot.TSKGID, Player.tbAntiBot.TSK_LAST_SCORE, 0);	--�������������
	return 0;
end

function tbScore:ScoreLog(pPlayer)
	local szMsg = "��Ҹ��������÷�";
	for key, tbOne in pairs(self.tbItemList) do
		local s = tbOne.fnLogMsg(tbOne.obj, pPlayer, tbOne.nId);
		szMsg = szMsg..s;
	end
	return szMsg; 
end

--ע�⣺��Ҫ�޸Ĵ����Ŀ��ע��˳��
---------------�����Ŀǰ����ű������ε��������ܸı��Ѿ�ע��Ĵ����Ŀ�����---------------------------
Require("\\script\\player\\antibot\\scoreitem1.lua");
Require("\\script\\player\\antibot\\scoreitem2.lua");

Player.tbAntiBot.tbScore:RegisterNewItem(1, Player.tbAntiBot.tbScoreItem1, "gamecode", Player.tbAntiBot.tbScoreItem1.AddScore, Player.tbAntiBot.tbScoreItem1.GetScore, Player.tbAntiBot.tbScoreItem1.Clear, Player.tbAntiBot.tbScoreItem1.GetLogMsg);
Player.tbAntiBot.tbScore:RegisterNewItem(2, Player.tbAntiBot.tbScoreItem3, "directadd", Player.tbAntiBot.tbScoreItem3.AddScore, Player.tbAntiBot.tbScoreItem3.GetScore, Player.tbAntiBot.tbScoreItem3.Clear, Player.tbAntiBot.tbScoreItem3.GetLogMsg);
Player.tbAntiBot.tbScore:RegisterNewItem(3, Player.tbAntiBot.tbScoreItem2, "roleaction", Player.tbAntiBot.tbScoreItem2.AddScore, Player.tbAntiBot.tbScoreItem2.GetScore, Player.tbAntiBot.tbScoreItem2.Clear, Player.tbAntiBot.tbScoreItem2.GetLogMsg1);
Player.tbAntiBot.tbScore:RegisterNewItem(4, Player.tbAntiBot.tbScoreItem2, "tasklink", Player.tbAntiBot.tbScoreItem2.AddScore, Player.tbAntiBot.tbScoreItem2.GetScore, Player.tbAntiBot.tbScoreItem2.Clear, Player.tbAntiBot.tbScoreItem2.GetLogMsg2);
Player.tbAntiBot.tbScore:RegisterNewItem(5, Player.tbAntiBot.tbScoreItem2, "shanghui", Player.tbAntiBot.tbScoreItem2.AddScore, Player.tbAntiBot.tbScoreItem2.GetScore, Player.tbAntiBot.tbScoreItem2.Clear, Player.tbAntiBot.tbScoreItem2.GetLogMsg3);
