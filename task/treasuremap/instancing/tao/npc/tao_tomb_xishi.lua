
-- ====================== 文件信息 ======================

-- 陶朱公疑塚無名女子（西施）腳本
-- Edited by peres
-- 2008/03/09 PM 16:14

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================


local tbNpc = Npc:GetClass("tao_tomb_xishi");

function tbNpc:OnDialog()
	local szTalk	= [[<color=yellow><playername><color>: Cô nương, sao lại ở đây 1 mình vậy?<end>
						<color=red><npc=2705><color>: Tức ngực quá…<end>
						<color=yellow><playername><color>: Cô nương không sao chứ? Nơi này rất nguy hiểm, mau cùng ta rời khỏi!<end>
						<color=red><npc=2705><color>: Đau lòng quá…<end>
						<color=yellow><playername><color>: Ta…<end>
						<color=yellow><playername><color>: Sao lại có cảm giác đáng sợ thế này, ta hãy mau đi khỏi đây thôi.<end>
]];
						
	TaskAct:Talk(szTalk, Npc:GetClass("tao_tomb_xishi").TalkEnd, Npc:GetClass("tao_tomb_xishi"));	
	return;
end


function tbNpc:TalkEnd()
	return;
end;
