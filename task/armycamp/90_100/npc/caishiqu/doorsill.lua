-- 上交指定數目的材料可以到下一關
local tbNpc = Npc:GetClass("caishiqudoorsill");

tbNpc.tbNeedItemList = 
{
	{20,1,603,1,20},
}


function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if(tbInstancing.nCaiShiQuColItem == 1) then
		Task.tbArmyCampInstancingManager:ShowTip(me,"切石器已經被損壞");
		return;
	end
	
	Dialog:Say("在機器中放入二十枚取自採石工匠的“刀具”可將其損壞，屆時大工匠便會聞聲而出。",
		{
			{"投入道具", self.Destroy, self, tbInstancing},
			{"結束對話"}
		})	
	
end

function tbNpc:Destroy(tbInstancing)
	if (tbInstancing.nCaiShiQuColItem ~= 1) then
		Task:OnGift("從採石工匠處取得20枚刀具放入，可毀壞切石器。", self.tbNeedItemList, {self.PassCaiKuangQu, self, tbInstancing}, nil, {self.CheckRepeat, self, tbInstancing});
	end
end

function tbNpc:PassCaiKuangQu(tbInstancing)
	TaskAct:Talk("<npc=4002>:“你們這幫蠢材，又干了什麼好事？看我不好好教訓你們。”");
	tbInstancing.nCaiShiQuColItem = 1;
	KNpc.Add2(4002, tbInstancing.nNpcLevel, -1, tbInstancing.nMapId, 1696, 3880);
end


function tbNpc:CheckRepeat(tbInstancing)
	if (tbInstancing.nCaiShiQuColItem == 1) then
		return 0;
	end
	
	return 1;
end
