-- ���

function Transfer:PlayerLogin(nPlayerId)
	self:DeleteItemAtTransfer(nPlayerId);
	
	--���ִ�����߸����Լ����ƺ�
	local nGate = Transfer:GetTransferGateway();
	if nGate and Wldh.Battle.tbLeagueName[nGate] then
		local szTitle = Wldh.Battle.tbLeagueName[nGate][1];
		local nEndTime = GetTime()+3600*24*30;
		me.AddSpeTitle(szTitle, nEndTime, "gold"); --���ӳƺ�
	end
	
	if Wldh:CheckIsOpen() == 1 and me.GetCamp() ~= 6 then
		me.AddItem(18,1,491,1);	--�������ִ�������ֲ�
		Wldh.tbChannelLeague:AddPlayer2League(nPlayerId);
	end
	
	--GM�Ÿ���GM��
	if me.GetCamp() == 6 then
		me.AddItem(18,1,400,1);
	end
end;


function Transfer:PlayerLogout(nPlayerId)
	
end;

--������Ե�������(����ʹ��)
function Transfer:GetTransferGateway()
	return me.GetTask(self.tbServerTaskId[1], self.tbServerTaskId[2]);
end

--�������Ե�������(����ʹ��)
function Transfer:SetTransferGateway()
	local nGateway = tonumber(string.sub(GetGatewayName(), 5, -1))
	return me.SetTask(self.tbServerTaskId[1], self.tbServerTaskId[2], nGateway);
end

--������Ե�����������
function Transfer:GetMyGateway(pPlayer)
	if not GLOBAL_AGENT then
		self:SetMyGateway(pPlayer);
	end
	return pPlayer.GetTaskStr(self.tbServerTaskGatewayName[1], self.tbServerTaskGatewayName[2]);
end

--����Լ����������ı��Id
function Transfer:GetMyTransferId(pPlayer)
	local szGateway = self:GetMyGateway(pPlayer);
	local tbInfo = ServerEvent:GetServerInforByGateway(szGateway);
	if not tbInfo then
		print("stack traceback", "Transfer:GetMyGatewa Error", "Not Find gatewaylistInfor", szGateway);
		return 0;
	end
	return tbInfo.nTransferId;
end

--�������Ե�����������
function Transfer:SetMyGateway(pPlayer)
	local szGateway = GetGatewayName();
	return pPlayer.SetTaskStr(self.tbServerTaskGatewayName[1], self.tbServerTaskGatewayName[2], szGateway);
end

--���͵�Ӣ�۵�(��ͨ��������ȫ�ַ�����ͨ��)
function Transfer:NewWorld2GlobalMap(pPlayer)
	if GLOBAL_AGENT then
		local nTransferId = Transfer:GetMyTransferId(pPlayer);
		local nMapId = self.tbGlobalMapId[nTransferId];
		if not self.tbGlobalMapId[nTransferId] then
			return 0;
		end
		pPlayer.NewWorld(nMapId, 1648, 3377);	
		return 0;
	end
	me.SetLogoutRV(0);
	-- �ж��Ƿ���ս��
	local nTransferId = Transfer:GetMyTransferId(pPlayer);
	local nMapId = self.tbGlobalMapId[nTransferId];
	if not self.tbGlobalMapId[nTransferId] then
		pPlayer.Msg("���������δ���ſ�����ܡ�");
		return 0;
	end
	-- ʵ�������ǿ������
	local nCanSure = Map:CheckGlobalPlayerCount(nMapId);
	if nCanSure < 0 then
		pPlayer.Msg("ǰ����·��ͨ��");
		return 0;
	end
	if nCanSure == 0 then
		pPlayer.Msg("Ӣ�۵��������������Ժ��ٳ��ԡ�");
		return 0;
	end
	local nMapIdEx , nPosX, nPosY = me.GetWorldPos();
	pPlayer.SetTask(self.tbServerTaskSaveMapId[1], self.tbServerTaskSaveMapId[2], nMapIdEx);
	pPlayer.SetTask(self.tbServerTaskSavePosX[1], self.tbServerTaskSavePosX[2], nPosX);
	pPlayer.SetTask(self.tbServerTaskSavePosY[1], self.tbServerTaskSavePosY[2], nPosY);
	pPlayer.GlobalTransfer(nMapId, 1648, 3377);	
end

--��ر���
function Transfer:NewWorld2MyServer(pPlayer)
	if GLOBAL_AGENT then
		local nMapIdEx	= pPlayer.GetTask(self.tbServerTaskSaveMapId[1], self.tbServerTaskSaveMapId[2]);
		local nPosX		= pPlayer.GetTask(self.tbServerTaskSavePosX[1], self.tbServerTaskSavePosX[2]);
		local nPosY		= pPlayer.GetTask(self.tbServerTaskSavePosY[1], self.tbServerTaskSavePosY[2]);
		pPlayer.GlobalTransfer(nMapIdEx, nPosX, nPosY);	
	end
end

-- ɾ��������Ʒ 
function Transfer:DeleteItemAtTransfer(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;
	
	local tbERoom = 
	{
		Item.ROOM_MAIL,						-- �ż�����
		Item.ROOM_RECYCLE,					-- �ع��ռ�
	};
	
	local tbAllRoom = {
			Item.BAG_ROOM,
			Item.REPOSITORY_ROOM,
			tbERoom,
		}
	for _, tbRoom in pairs(tbAllRoom) do
		for _, nRoom in pairs(tbRoom) do
			local tbIdx = pPlayer.FindAllItem(nRoom);
			for i = 1, #tbIdx do
				local pItem = KItem.GetItemObj(tbIdx[i]);
				 pPlayer.DelItem(pItem);
			end;
		end;
	end;
end;