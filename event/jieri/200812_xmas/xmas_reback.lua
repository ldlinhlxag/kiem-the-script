--ʥ����ֵ����
--�����
--2008.12.22

SpecialEvent.Xmas2008 = SpecialEvent.Xmas2008 or {};

local tbEvent = SpecialEvent.Xmas2008;

tbEvent.tbRebackState = 
{
	20081223,
	20090101,
}

function tbEvent:CheckReback()
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	if nCurDate < self.tbRebackState[1] or nCurDate >= self.tbRebackState[2] then
		return 0;
	end
	return 1;		
end

function tbEvent:GetReback(nFlag)
	if self:CheckReback() == 0 then
		Dialog:Say("��Ѿ�������");
		return 0;
	end
	local nGetFlag, nPayCoin = self:GetRebackExtPoint();
	local nRebackCoin = math.floor(nPayCoin / 50) * 1000;
	if nGetFlag == 0 and nPayCoin >= 50 then
		nRebackCoin = 15000 + (math.floor(nPayCoin / 50) - 1) * 1000;
	end
	
	if not nFlag then
		local szMsg = string.format([[
			
			��Ŀǰδ��ȡ�����ĳ�ֵΪ��<color=yellow>%sԪ<color>
			����ȡ�İ�𷵻�Ϊ��<color=yellow>%s�󶨽��<color>
			
			�ʱ�䣺<color=yellow>2008��12��23��ά����
					  ����2009��1��1��0��<color>
			
			<color=red>ע�⣬��ֵδ��50Ԫ�Ļ�������ȡ��������ȡ�������ֵĳ�ֵ�������գ�δ��50Ԫ�Ĳ��ֻ��ۼƣ��������Ͳ�����ȡ�����ˣ��мǡ�<color>
			]], nPayCoin, nRebackCoin);
		local tbOpt = {
			{"��ȡʥ����ֵ��������", self.GetReback, self, 1},
			{"�˽�ʥ����ֵ����",self.RebackAbout, self},
			{"���������"},
		};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	if nRebackCoin <= 0 or nPayCoin < 50 then
		Dialog:Say("��Ŀǰʣ��δ��ȡ������<color=yellow>��ֵ����50Ԫ<color>�����ֵ�������ɡ�")
		return 0;
	end
	
	if nGetFlag == 0 then
		me.AddExtPoint(2, 100000000);
	end
	me.PayExtPoint(2, math.floor(nPayCoin / 50) * 50);
	me.AddBindCoin(nRebackCoin, Player.emKBINDCOIN_ADD_XMAS_REBACK);
	Dialog:Say(string.format("�ɹ���ȡ��<color=yellow>%s�󶨽��<color>��", nRebackCoin));
	Dbg:WriteLog("PlayerEvent.Xmas2008", "ʥ����ֵ����", "�󶨽��", nRebackCoin);
end

--���س�ֵ�������һ����ȡ��־��ʣ��δ��ȡ��ֵ��
function tbEvent:GetRebackExtPoint()
	local nPoint = me.GetExtPoint(2);
	local nGetFlag = math.floor(nPoint / 100000000);
	local nPayCoin = math.mod(nPoint , 100000000);
	return nGetFlag, nPayCoin;
end

function tbEvent:RebackAbout()
	Dialog:Say("��<color=yellow>2008��12��23��ά���󡪡�2009��1��1��0��<color>�Ļ�ڼ䣬��ҳ�ֵ<color=yellow>ÿ�ﵽ50Ԫ<color>���ڸ����ִ��ƹ�Ա�����<color=yellow>20%�İ�𷵻�<color>���ڵ�һ�γ�ֵ��50Ԫʱ���ܻ��<color=yellow>�൱��150Ԫ�İ�𷵻�<color>��\n\n<color=red>ע�⣬��ֵδ��50Ԫ�Ļ�������ȡ��������ȡ�������ֵĳ�ֵ�������գ�δ��50Ԫ�Ĳ��ֻ��ۼƣ��������Ͳ�����ȡ�����ˣ��мǡ�<color>")
end
