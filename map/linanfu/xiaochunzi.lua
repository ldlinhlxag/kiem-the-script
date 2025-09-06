
local tbNpc = Npc:GetClass("xiaochunzi");

local tbTaskValue	= {
	[1]	= {"皇上寝宫", 518,1582,3211,0},
	[2]	= {"太皇太后寝宫", 519, 1582,3211,0},
	[3]	= {"太皇太后寝宫", 520, 1582,3211,0},
	[4]	= {"太皇太后寝宫", 521, 1582,3211,0},
	[5]	= {"皇宫大殿", 523,1580,3258,1},
}

function tbNpc:OnDialog()
		Dialog:Say("Nếu bạn không cẩn thận trong công việc trong nhà, không thể tiếp tục làm nhiệm vụ, có thể đến với tôi. Tôi sẽ gửi lại nhiệm vụ bản đồ. Bây giờ bạn đến giúp đỡ hoặc làm nhiệm vụ? Làm nhiệm vụ vào tên nhiệm vụ, giúp đỡ là trên điểm tìm kiếm đối thoại giúp đỡ.",{
				   {"我来求助", tbNpc.Talk, tbNpc},
				   {"Kết thúc đối thoại"},
			});
end;

function tbNpc:Talk()
		Dialog:Say("看来你真是遇到麻烦了，准备好的话我就送你过去。",{
				   {"准备好了", tbNpc.GoNow, tbNpc},
				   {"Kết thúc đối thoại"},
			});
end;

function tbNpc:GoNow()
	local nTask	= me.GetTask(1024, 39);
	
	if nTask == 0 then
		Dialog:Say("你并不在任务中，一切都很顺利！");
		return;
	end;
	
	if tbTaskValue[nTask] then
		Dialog:Say("前往"..tbTaskValue[nTask][1].."，你确定要去吗？",{
				   {"是的，快点吧", self.Send, self, me, tbTaskValue[nTask][2], tbTaskValue[nTask][3], tbTaskValue[nTask][4], tbTaskValue[nTask][5]},
				   {"Kết thúc đối thoại"}
			});
		return;
	end;
end;


function tbNpc:Send(pPlayer, nMapId, nMapX, nMapY, nFightState)
	pPlayer.NewWorld(nMapId, nMapX, nMapY);
	pPlayer.SetFightState(nFightState);
end;


