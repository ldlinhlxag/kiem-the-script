-- �ļ�������relation_logic.lua
-- �����ߡ���furuilei
-- ����ʱ�䣺2009-07-30 16:15:32
-- ����������gameserver��gamecenter���õ��˼ʹ�ϵ�߼�

if (MODULE_GAMECLIENT) then
	return;
end

-- ���ָ������ҹ�ϵ�����Ƿ��ں��ʵķ�Χ��
function Relation:CheckRelationType(nType)
	if (nType < Player.emKPLAYERRELATION_TYPE_TMPFRIEND or
		nType > Player.emKPLAYERRELATION_TYPE_BUDDY) then
			return 0;
	end
	return 1;
end

