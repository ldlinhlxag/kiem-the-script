
---- ����������

------------------------------------------------------------------------------------------
-- initialize

Gift._szTitle	= "";						-- ��������
Gift._szContent	= "";						-- ������Ϣ

-- �����µĸ���������
function Gift:New()
	return	Lib:NewClass(self);
end

------------------------------------------------------------------------------------------
-- common method

function Gift:SetTitle(szTitle)
	self._szTitle = szTitle;
end

function Gift:SetContent(szContent)
	self._szContent = szContent;
end

function Gift:GetCells()			-- �����������
	local tbCells = {};
	for j = 0, Item.ROOM_GIFT_HEIGHT - 1 do
		tbCells[i] = {};
		for i = 0, Item.ROOM_GIFT_WIDTH - 1 do
			tbCells[i][j] = me.GetGiftItem(i, j);
		end
	end
	return	tbCells;
end

function Gift:First()				-- ��������е�һ������
	return	self:Find(0, 0);
end

function Gift:Next()				-- ���������һ������
	local nX = self._nX + 1;
	local nY = self._nY;
	if (nX >= Item.ROOM_GIFT_WIDTH) then
		nX = 0;
		nY = nY + 1;
	end
	if (nY >= Item.ROOM_GIFT_HEIGHT) then
		return	nil;
	end
	return	self:Find(nX, nY);
end

function Gift:LastX()				-- ���һ���ҵ����ߵ�X����
	return	self._nX;
end

function Gift:LastY()				-- ���һ���ҵ����ߵ�Y����
	return	self._nY;
end

------------------------------------------------------------------------------------------
-- client callback interface

function Gift:OnSwitch(pPickItem, pDropItem, nX, nY)	-- ������������붫��
	return	1;
end

function Gift:OnUpdate()			-- ���½������֣��ڴ򿪽���ͷ����仯ʱ���ã�
	
end

------------------------------------------------------------------------------------------
-- server callback interface

function Gift:OnOK()				-- ȷ��

end

function Gift:OnCancel()			-- ȡ��

end

------------------------------------------------------------------------------------------
-- private method

function Gift:Find(nX, nY)			-- �������в���һ������

	local pItem = nil;

	for j = nY, Item.ROOM_GIFT_HEIGHT - 1 do
		if (j > nY) then
			nX = 0;
		end
		for i = nX, Item.ROOM_GIFT_WIDTH - 1 do
			pItem = me.GetGiftItem(i, j);
			if (pItem) then
				self._nX = i;
				self._nY = j;
				break;
			end
		end
		if (pItem) then
			break;
		end
	end

	if (not pItem) then
		return	nil;				-- ʲô��û�ҵ�
	end

	return pItem;

end
