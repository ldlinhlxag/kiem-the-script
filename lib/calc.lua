-- һЩ��ѧ�������ṩ��Npc��Skill��ģ���趨��ֵ��

local tbCalc	= {};


--����2���㣬�����κ���f(x)=k*x+b
-- y = (y2-y1)*(x-x1)/(x2-x1)+y1
function tbCalc:Line(x,x1,y1,x2,y2)
	if (x2==x1) then
		return y2;
	end;
	return (y2-y1)*(x-x1)/(x2-x1)+y1;
end;

--����2���㣬��2���κ���f(x)=a*x^2+c
-- y = (y2-y1)*(x^2-x1^2)/(x2^2-x1^2)+y1
function tbCalc:Conic(x,x1,y1,x2,y2)
	if ((x1<0) or (x2<0)) then
		return 0;
	end;
	if (x2==x1) then
		return y2;
	end;
	return (y2-y1)*(x*x-x1*x1)/(x2*x2-x1*x1)+y1;
end;

--����2���㣬��1/2���κ���f(x)=a*sqrt(x)+c
-- y = (y2-y1)*(sqrt(x)-sqrt(x1))/(sqrt(x2)-sqrt(x1)) + y1
function tbCalc:Extrac(x,x1,y1,x2,y2)
	if ((x1<0) or (x2<0)) then
		return 0;
	end;
	if (x2==x1) then
		return y2;
	end;
	return (y2-y1)*(x^0.5-x1^0.5)/(x2^0.5-x1^0.5) + y1;
end;


--���������:Link(x, tbPoint)
--����tbPoint�ṩ��һϵ�е㣬�����ڵ��������������
--������
--	x		����ֵ
--	tbPoint	�㼯�ϣ����磺{ {x1,y1,"Line"}, {x2,y2,"Conic"}, ..., {xn,yn} };
--���أ�y ֵ
function tbCalc:Link(x, tbPoint)
	if (not tbPoint) then
		return 0;
	end;
	if (type(tbPoint) == "number") then
		return tbPoint;
	end;
	local nSize = #tbPoint;
	assert(nSize >= 2);	-- �����Ҫ�̶�ֵ�����Բ���ֱ��д��ֵ����ʽ������Ҫֻдһ����
	local nPoint2	= nSize;
	local szFunc	= tbPoint[nSize][3];
	for i = 1, nSize do
		if (x < tbPoint[i][1]) then
			if (i == 1) then
				nPoint2	= 2;
			else
				nPoint2	= i;
			end;
			szFunc	= tbPoint[i][3];
			break;
		end;
	end;
	local tb1	= tbPoint[nPoint2-1];
	local tb2	= tbPoint[nPoint2];
	if (not szFunc) then
		szFunc	= "Line";
	end;
	local fnFunc	= self[szFunc];
	assert(fnFunc);	-- ���㷽�����϶��壬ע���Сд
	return math.floor(fnFunc(self, x, tb1[1], tb1[2], tb2[1], tb2[2]));
end;

Lib.Calc	= tbCalc;
