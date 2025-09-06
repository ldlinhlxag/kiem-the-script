-------------------------------------------------------
-- �ļ�������rabbit.lua
-- �ļ�������ץ��npc
-- �����ߡ���jiazhenwei@kingsoft.com
--����ʱ�� ��2009��8��25��
-------------------------------------------------------
if not SpecialEvent.CollectCard then
	SpecialEvent.CollectCard = {};
end
SpecialEvent.CollectCard.CallAiRabbit =  {};
local tbRabbit = SpecialEvent.CollectCard.CallAiRabbit;

tbRabbit.szChar ="���Ӻö����ز��˼�����~~~";
	
tbRabbit.NCHATSEC = 3; 		--timer�ӳ�ʱ��
tbRabbit.NRANGE = 1000; 		--npc�ܶ������Χ	
tbRabbit.NSEARCHAREA = 20 	--npc������ҵķ�Χ

--��������npc
--example		local nMapId,nX,nY = me.GetWorldPos(); 
--example         SpecialEvent.CollectCard:CallRabbit(nMapId, nX*32, nY*32, 598);
function tbRabbit:CallRabbit(nMapId, nX, nY, nAINpcId)		
	local pNpc = KNpc.Add(nAINpcId, 150, 0, SubWorldID2Idx(nMapId), nX, nY);	
	if (pNpc) then
		local nMovX, nMovY = self:RandomPos(nX, nY);
		pNpc.AI_AddMovePos(nMovX, nMovY);
		pNpc.SetNpcAI(9, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0);
		pNpc.GetTempTable("Npc").tbRabbitAbout				= {};
		pNpc.GetTempTable("Npc").tbRabbitAbout.bIsCatch 		= 0;   --�����Ƿ񱻲�׽
		pNpc.SetLiveTime(120 * Env.GAME_FPS);
		local nTimerId = Timer:Register(self.NCHATSEC * Env.GAME_FPS, self.Sendchat, self, pNpc.dwId, 1);	
        return pNpc.dwId;	
	end
	return 0;
end

--��·˵��
function tbRabbit:Sendchat(nNpcId)	
	local pNpc = KNpc.GetById(nNpcId);	
	local nMovX,nMovY = self:GetMovePos(nNpcId);
	if ( not pNpc) then	
		return 0;	
	end		
	if(2 == pNpc.GetTempTable("Npc").tbRabbitAbout.bIsCatch) then
		pNpc.Delete();
		return 0;
	end
	if (1 == pNpc.GetTempTable("Npc").tbRabbitAbout.bIsCatch) then
		 pNpc.GetTempTable("Npc").tbRabbitAbout.bIsCatch = 2;		
		 return;
	end
	
	pNpc.SendChat(self.szChar);
	pNpc.AI_ClearPath();	
	pNpc.AI_AddMovePos(nMovX, nMovY);
	pNpc.SetNpcAI(9, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0);		
	return ;
end

--���������Һ�����֮��ķ������һ�ξ����x��y
function tbRabbit:GetMovePos(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);	
	local tbRoundLis = KNpc.GetAroundPlayerList(nNpcId, self.NSEARCHAREA);
	
	local nMapId, nPlayerX, nPlayerY;			--��������
	local nNearPlayerX ,nNearPlayerY;			--�����������
	local nNpcX = 0;
	local nNpcY = 0;					--npc�����
	local nMinPos = 0; 						--npc��������(û��ʱΪ0)�ľ����ƽ��ֵ
	
	if (pNpc) then		 					--����npc�������ҵ������
		nMapId, nNpcX, nNpcY = pNpc.GetWorldPos();					
		for _ , nPlayer in pairs(tbRoundLis) do
			nMapId, nPlayerX, nPlayerY = nPlayer.GetWorldPos();				
			local nDistance = self:TowPosDistance(nPlayerX, nPlayerY, nNpcX, nNpcY);			
			if (nMinPos <= nDistance ) then
				nMinPos = nDistance;				
				nNearPlayerX = nPlayerX;
				nNearPlayerY = nPlayerY;
			end
		end				
	end
	if( 0 == nMinPos ) then			--����û����ҷ���npc����		
		return self:RandomPos(nNpcX, nNpcY);
	end		
	return  (nNpcX + nNpcX - nNearPlayerX)*32, (nNpcY + nNpcY - nNearPlayerY)*32;		--���������Һ�npc�������һ�ξ����x,y
end

--��鸽���Ƿ������
function tbRabbit:IsPlayer(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if (pNpc) then		
		local tbRoundLis = KNpc.GetAroundPlayerList(nNpcId, self.NSEARCHAREA);
		if(not tbRoundLis[1]) then
			return nil;
		end
	end
	return 1;
end

--����֮��ľ����ƽ��ֵ
function tbRabbit:TowPosDistance(nPosX1,nPosY1,nPosX2,nPosY2)
	return (nPosX1 - nPosX2) *  (nPosX1 - nPosX2) + (nPosY1 - nPosY2) *  (nPosY1 - nPosY2); 	
end

--nX��nY��NRANGE��Χ�ڵ������
function tbRabbit:RandomPos(nX,nY)		
	local tbRX =  {math.floor(MathRandom(-self.NRANGE, -math.floor(self.NRANGE*0.6))), math.floor(MathRandom(math.floor(self.NRANGE*0.6), self.NRANGE))};
	local tbRY =  {math.floor(MathRandom(-self.NRANGE, -math.floor(self.NRANGE*0.6))), math.floor(MathRandom(math.floor(self.NRANGE*0.6), self.NRANGE))};
	local nTrX =  tbRX[math.floor(MathRandom(1, 2))] or 0;
	local nTrY =  tbRY[math.floor(MathRandom(1, 2))] or 0;
	local nMovX = nX + nTrX;
	local nMovY = nY + nTrY;
	return nMovX,nMovY;		
end
